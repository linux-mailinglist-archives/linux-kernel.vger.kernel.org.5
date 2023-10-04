Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6277B820A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242885AbjJDORe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242879AbjJDORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:17:31 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B0EAD;
        Wed,  4 Oct 2023 07:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=SkbWpdDlNPiVngrUfwn9Q3KUJG64A7lq4G4XSXJ8ny8=; b=Ey6XFdVJPni7Vjj/dP2fzSll4K
        LnYLm7C3dDqJe9KaqyAl0gmltjHRWRt18tHoDEuCyhW8zSkW3g6rjcFUJBG98iSH9zAw2OXxtbTMh
        DV8QVszoYimRfe47hlguY7xk5ieDNBuXUz6dXRV2iB0+rCoIRDRtH0me/Qt0YSw5MtmBYMsbB0u+f
        s0yxshk2WgBQqCx7LCt0uV4TvX2ZYAjqc5DG5wL5nrelx3oX4n+3n01MINF5TwShj1gv9sEYsOTSk
        JSSDt36nQMsytbqhUnOHWg7t2B3wgvTLFoPsl5fR7KW7Y8T02llzbWCYxoG4ywuacKUQ2YMv++oSS
        J+Z5Cjqw==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qo2gk-0071hO-1E;
        Wed, 04 Oct 2023 16:17:22 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Wed, 04 Oct 2023 16:17:17 +0200
Subject: [PATCH RFC 1/2] regulator: core: Disable unused regulators with
 unknown status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-reg-smd-unused-v1-1-5d682493d555@kernkonzept.com>
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
In-Reply-To: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some regulator drivers do not provide a way to check if the regulator is
currently enabled or not. That does not necessarily mean that the
regulator is always-on. For example, the regulators managed by the RPM
firmware on Qualcomm platforms can be either on or off during boot but
the initial state is not known. To sync the state the regulator should
get either explicitly enabled or explicitly disabled.

Enabling all regulators unconditionally is not safe, because we might
not know which voltages are safe. The devices supplied by those
regulators might also require a special power-up sequence where the
regulators are turned on in a certain order or with specific delay.

Disabling all unused regulators is safer. If the regulator is already
off it will just stay that way. If the regulator is on, disabling it
explicitly allows the firmware to turn it off for reduced power
consumption.

The regulator core already has functionality for disabling unused
regulators. However, at the moment it assumes that all regulators where
the .is_enabled() callback fails are actually off. There is no way to
return a special value for the "unknown" state to explicitly ask for
disabling those regulators.

Some drivers (e.g. qcom-rpmh-regulator.c) return -EINVAL for the case
where the initial status is unknown. Use that return code to assume the
initial status is unknown and try to explicitly disable the regulator
in that case.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Instead of -EINVAL we could also use a different return code to indicate
the initial status is unknown. Or maybe there is some other option that
would be easier? This is working for me but I'm sending it as RFC to get
more feedback. :)
---
 drivers/regulator/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3137e40fcd3e..182e3727651a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -6207,8 +6207,13 @@ static int regulator_late_cleanup(struct device *dev, void *data)
 	if (rdev->use_count)
 		goto unlock;
 
-	/* If reading the status failed, assume that it's off. */
-	if (_regulator_is_enabled(rdev) <= 0)
+	/*
+	 * If reading the status failed, assume that it's off.
+	 * If the current status is unknown (-EINVAL), assume that the
+	 * regulator might be on and try to explicitly disable it.
+	 */
+	ret = _regulator_is_enabled(rdev);
+	if (ret <= 0 && ret != -EINVAL)
 		goto unlock;
 
 	if (have_full_constraints()) {

-- 
2.39.2

