Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7B27A31C8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbjIPSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjIPSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 14:00:05 -0400
Received: from smtp40.i.mail.ru (smtp40.i.mail.ru [95.163.41.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CFECE6;
        Sat, 16 Sep 2023 11:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=+lCM8qubLARYTvfEHuxj/geOniNoi7kjimOOnYNhXZY=; t=1694887200; x=1694977200; 
        b=QEv4qL0UOf0sj1fTf8kdhsBqCRz2G6jPUlUdWpVAENLMkiNp+nhUY3P0byHaNw7fh4IaZmzFZpW
        w+ESrFEKD66b2eIzF+A/GiK3YXqTRyaoi4KOL6tDFNhHBi1jeis5M3K8p06SgOYNuQcysyaC2wgO5
        Attudf34y5/amjLE6Js=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qhZaI-006d7F-1h; Sat, 16 Sep 2023 20:59:58 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 2/2] pmdomain: qcom: rpmhpd: Add support for SM7150 rpmh clocks
Date:   Sat, 16 Sep 2023 20:59:52 +0300
Message-ID: <20230916175952.178611-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230916175952.178611-1-danila@jiaxyga.com>
References: <20230916175952.178611-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp40.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9FD052C19707CBA108F1E255DB0CE4ADF810AD9F6ADB4530800894C459B0CD1B9C6127204C78C72662695CD013C20067C31D7BEF43F7B604A37AD88C62730AFDD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE74286BEFC80AC600CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC20F58FBAB79054EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBAA605E978BE5FA9121FCD0C5B8183BF1ECC7F00164DA146DAFE8445B8C89999728AA50765F7900637CAEE156C82D3D7D9389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8B861051D4BA689FCF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C1DAA61796BF5227BBA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B615519F706774CB6A3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4931B544F03EFBC4D57C8D5298E42E60C1FC4224003CC83647689D4C264860C145E
X-B7AD71C0: 6FEFE4C63DFE2D85718F43753FD9AD21390936EE2A242988633761F9DFDC81E9C79EB1DA2EBAF7A81C6805ECDC0957F8
X-C1DE0DAB: 0D63561A33F958A5C77FAC5310941106147C0D302D6FBB8366D32F0EC6D2A0F4F87CCE6106E1FC07E67D4AC08A07B9B0CE135D2742255B359C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0AD75DCE07D45A7499577DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF922733AE475BDCF693BFE7357B281D8A4006E8518DDC067B17B326EC56491F8EF93E7F6CC6F26229B3573C328C294A3D4469FED4482D0DF876B5B102148F81E921BEC6C0C71ED4F84C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwfkaTmrWlaxwu9hpjvK0Qg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498126E16CB1D4F8C9A0C58471F59312CD37D586A72D9E53DC1D643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the RPMH clocks present in SM7150 SoC.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index a87e336d5e33..ec2582f7225c 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -337,6 +337,23 @@ static const struct rpmhpd_desc sm6350_desc = {
 	.num_pds = ARRAY_SIZE(sm6350_rpmhpds),
 };
 
+/* SM7150 RPMH powerdomains */
+static struct rpmhpd *sm7150_rpmhpds[] = {
+	[RPMHPD_CX] = &cx_w_mx_parent,
+	[RPMHPD_CX_AO] = &cx_ao_w_mx_parent,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MSS] = &mss,
+};
+
+static const struct rpmhpd_desc sm7150_desc = {
+	.rpmhpds = sm7150_rpmhpds,
+	.num_pds = ARRAY_SIZE(sm7150_rpmhpds),
+};
+
 /* SM8150 RPMH powerdomains */
 static struct rpmhpd *sm8150_rpmhpds[] = {
 	[SM8150_CX] = &cx_w_mx_parent,
@@ -562,6 +579,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sdx65-rpmhpd", .data = &sdx65_desc},
 	{ .compatible = "qcom,sdx75-rpmhpd", .data = &sdx75_desc},
 	{ .compatible = "qcom,sm6350-rpmhpd", .data = &sm6350_desc },
+	{ .compatible = "qcom,sm7150-rpmhpd", .data = &sm7150_desc },
 	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
 	{ .compatible = "qcom,sm8250-rpmhpd", .data = &sm8250_desc },
 	{ .compatible = "qcom,sm8350-rpmhpd", .data = &sm8350_desc },
-- 
2.41.0

