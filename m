Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16B87B820B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242890AbjJDORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbjJDORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:17:31 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5421BBD;
        Wed,  4 Oct 2023 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=uGFUKnshKK/Dlrx7eSaJi3UN15UGXc4Ye0y6BgFwE70=; b=mcndqaF/9YtRUFqpPsJk35hOjM
        ssdRCGiQRptp2Mz9hSJoC9ceNzNnFVX7rU3X2vCznKlRa20t5axk4+9w1KYS2AJnf5G+kV5Sp8w2m
        nsnBkhJLiNVv2U1cyj8wzbOpWopwDszXGdCxzxGRihGf80lMpvoXi7jlVEX3EPBqlQcIYbaiFWRDj
        qw3b8W3M/r7XSOkeQO6X6bWQgEp0r8pZW19fsVnHK6qOXiUpyF6g5A5WYbCFfZarXAIY61mBT88gS
        33Fj7IaVRnTJRmJx6wPWoG263EUDVqgVKI/furH2T2IjWSehykKB2ykrNXMI2M1VBhmIfOkD77Jq8
        JVKqIm2g==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qo2gl-0071hO-1J;
        Wed, 04 Oct 2023 16:17:23 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Wed, 04 Oct 2023 16:17:18 +0200
Subject: [PATCH RFC 2/2] regulator: qcom_smd: Disable unused regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-reg-smd-unused-v1-2-5d682493d555@kernkonzept.com>
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

The RPM firmware on Qualcomm platforms does not provide a way to check
if a regulator is on during boot using the SMD interface. If the
regulators are already on during boot and Linux does not make use of
them they will currently stay enabled forever. The regulator core does
not know these regulators are on and cannot clean them up together with
the other unused regulators.

Fix this by setting the initial enable state to -EINVAL similar to
qcom-rpmh-regulator.c. The regulator core will then also explicitly
disable all unused regulators with unknown status.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
NOTE: This has a slight potential of breaking boards that rely on having
unused regulators permanently enabled (without regulator-always-on).
However, this is always a mistake in the device tree so it's probably
better to risk some breakage now, add the missing regulators and avoid
this problem for all future boards.
---
 drivers/regulator/qcom_smd-regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index f53ada076252..0bbfba2e17ff 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -53,14 +53,14 @@ static int rpm_reg_write_active(struct qcom_rpm_reg *vreg)
 		reqlen++;
 	}
 
-	if (vreg->uv_updated && vreg->is_enabled) {
+	if (vreg->uv_updated && vreg->is_enabled > 0) {
 		req[reqlen].key = cpu_to_le32(RPM_KEY_UV);
 		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
 		req[reqlen].value = cpu_to_le32(vreg->uV);
 		reqlen++;
 	}
 
-	if (vreg->load_updated && vreg->is_enabled) {
+	if (vreg->load_updated && vreg->is_enabled > 0) {
 		req[reqlen].key = cpu_to_le32(RPM_KEY_MA);
 		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
 		req[reqlen].value = cpu_to_le32(vreg->load / 1000);
@@ -1377,6 +1377,7 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
 	vreg->rpm	= rpm;
 	vreg->type	= rpm_data->type;
 	vreg->id	= rpm_data->id;
+	vreg->is_enabled = -EINVAL;
 
 	memcpy(&vreg->desc, rpm_data->desc, sizeof(vreg->desc));
 	vreg->desc.name = rpm_data->name;

-- 
2.39.2

