Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF027B7ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbjJDMKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbjJDMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:10:46 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2329C9;
        Wed,  4 Oct 2023 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Message-Id:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Subject:Date:From:References:In-Reply-To:Reply-To:
        Content-ID:Content-Description;
        bh=SmL8ximB3jmibA5ut1EhfI+VT8YUU8o3eptjGal/v/8=; b=dTCUotHndBZzy055HBmkMgW8Jm
        7PPB9RGNMRO1nXirwbGtECWdOLx0WIetYONPfmMbo90+gSbBQbkAU4U6OInftVy0P+86DMd0UNNly
        9/wcR5OJXGw2JxBqr22k6IxmiWW7ACc8jiGb0eVPH8hFl3FLWMhVluGG10gb9sU02j3F/uV28vaF2
        btk3tBNOTKtBBwW6CLfkzY/9D0laZA6oiHTTwi6W11K3CgC2O4OzHQeIEd+iY/ZT60QPgk49RXlbT
        8frjXUjoEn+a//YGSnkRJUT2jQFAN5aXk9CX4iVzfNVQl+JGjPfM99acVm1zd78AcncjIRuwBH/DJ
        2B9FUzcg==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qo0i5-0070GG-12;
        Wed, 04 Oct 2023 14:10:37 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Wed, 04 Oct 2023 14:10:34 +0200
Subject: [PATCH v2] clk: qcom: smd: Disable unused clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-clk-qcom-smd-rpm-unused-v2-1-9a5281f324dc@kernkonzept.com>
X-B4-Tracking: v=1; b=H4sIADlWHWUC/zWNQQ6CMBAAv0L27JLdilI8+Q/jAekCjVBwC8aE8
 HcbE49zmJkNoqiXCJdsA5W3j34KCcwhg6avQyfoXWIwZI5MVGAzPPHVTCPG0aHOI65hjeLwUVa
 OiI2xzJDsWaX1n1/5dk/canKWXqX+94gsl1xQRTZne6rKMzLGReb0vXai/TS4PMgC+/4FA3ZKe
 KcAAAA=
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
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

At the moment, clk-smd-rpm forces all clocks on at probe time (for
"handoff"). However, it does not make the clk core aware of that.

This means that the clocks stay enabled forever if they are not used
by anything. We can easily disable them again after bootup has been
completed, by making the clk core aware of the state. This is
implemented by returning the current state of the clock in
is_prepared().

Checking the SPMI clock registers reveals that this allows the RPM to
disable unused BB/RF clocks. This reduces the power consumption quite
significantly and is also needed to allow entering low-power states.

As of commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out
interconnect bus clocks") the interconnect-related clocks are no longer
managed/exposed by clk-smd-rpm. Also the BI_TCXO_AO clock is now
critical (and never disabled).

There is still a slight chance that this change will break boot on some
devices. However, this will be most likely caused by actual mistakes in
the device tree (where required clocks were not actually specified).

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
Changes in v2:
- Rebase on latest qcom/for-next, update commit message with other recent
  related changes
- Link to v1: https://lore.kernel.org/linux-arm-msm/20200817140908.185976-1-stephan@gerhold.net/
---
Keeping all unused clocks on makes it very easy to forget to enable
actually required clocks. [1] is one example of that, where the crypto
engine worked fine without any clocks. IMHO we should try to get this
change in sooner than later to avoid introducing more new mistakes.

[1]: https://lore.kernel.org/linux-arm-msm/ZGdLCdSof027mk5u@gerhold.net/
---
 drivers/clk/qcom/clk-smd-rpm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 0191fc0dd7da..eba650ad7291 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -335,6 +335,13 @@ static void clk_smd_rpm_unprepare(struct clk_hw *hw)
 	mutex_unlock(&rpm_smd_clk_lock);
 }
 
+static int clk_smd_rpm_is_prepared(struct clk_hw *hw)
+{
+	struct clk_smd_rpm *r = to_clk_smd_rpm(hw);
+
+	return r->enabled;
+}
+
 static int clk_smd_rpm_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
@@ -431,6 +438,7 @@ static int clk_smd_rpm_enable_scaling(void)
 static const struct clk_ops clk_smd_rpm_ops = {
 	.prepare	= clk_smd_rpm_prepare,
 	.unprepare	= clk_smd_rpm_unprepare,
+	.is_prepared	= clk_smd_rpm_is_prepared,
 	.set_rate	= clk_smd_rpm_set_rate,
 	.round_rate	= clk_smd_rpm_round_rate,
 	.recalc_rate	= clk_smd_rpm_recalc_rate,
@@ -439,6 +447,7 @@ static const struct clk_ops clk_smd_rpm_ops = {
 static const struct clk_ops clk_smd_rpm_branch_ops = {
 	.prepare	= clk_smd_rpm_prepare,
 	.unprepare	= clk_smd_rpm_unprepare,
+	.is_prepared	= clk_smd_rpm_is_prepared,
 	.recalc_rate	= clk_smd_rpm_recalc_rate,
 };
 
@@ -1279,6 +1288,9 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 		ret = clk_smd_rpm_handoff(rpm_smd_clks[i]);
 		if (ret)
 			goto err;
+
+		/* During handoff we force all clocks on */
+		rpm_smd_clks[i]->enabled = true;
 	}
 
 	for (i = 0; i < desc->num_icc_clks; i++) {

---
base-commit: 870b5222204243ee6dbeada9ad1b90cda9ecb4da
change-id: 20231004-clk-qcom-smd-rpm-unused-b79d00122811

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

