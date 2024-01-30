Return-Path: <linux-kernel+bounces-44619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0290D842526
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854A01F25703
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B56F074;
	Tue, 30 Jan 2024 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tA7EWbFU"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5F6D1BA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618408; cv=none; b=cYXMsj6g85GDbZY/UYuSkyKi1zRtVOTNeQ1RiBgamBfXYKMjXum93ntUVaMGzs7eVW1FA87kYeyzoalZbcDTia7vY//9/swlGf0weIdOhCu3fVQw9MWWU/tIbL142NiY57fEFVipqD495nPB9gtcnRBZDzggqXfXk3PaJqV2Bgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618408; c=relaxed/simple;
	bh=amT5XvS5cIMcEYdHzb5WGCBIhqN0P7Hqeenb8AqG0zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Op5yWQu6WvpgvUpfmOcR7D/EGpSU9hzbeWhCjNfTfZnFv6PvfRnDXNi8+1Pk1WWqK2S2Q9FSi/gYLj6NvhxEswJVtD/odRCYL0Xl1DDXBTPLgsl4MTh9+PSmKZe/wgNXLn/YInbI/CMPeyrOy0NhFdo0gTqTnNxbbsJWYx8b4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tA7EWbFU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51030ce36fbso4008121e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706618403; x=1707223203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaTT8dB3EwkGsk/s/Xq1pLso3HjDpVKzVVMDBdDT7Fc=;
        b=tA7EWbFUqqE2O+mCBjAt22hVvtgmbiaa6WKhNVtv3j7Zz34O6sl/TGu+Lvh0NK0FV9
         YnmnVqinVSKwkH3A6XRmCpUytXb/3xeZarLVpPXe3BzWV5UoUUFb87iSXWitQoPx9QUz
         /1DWXCbEJd3DGhrOCsJpViJYEiRyG7R0RN82Q6B/t3FvveSdvALtxTZ+In05Qthc11pr
         2W6nAqxgpFCC6tWNi9PE+ktm8UXgfNNS0YfSA+AKV6Jj+7hTmY9fi//ZkDchX0nc8KDi
         ZByKWMYTE7Avk4WC6vHAVOvC6hRxFxCLKY8wUKmqi3kn4/TCa17A/+Jte7Wfel7zONmf
         3Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618403; x=1707223203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaTT8dB3EwkGsk/s/Xq1pLso3HjDpVKzVVMDBdDT7Fc=;
        b=HyipHBFcO818WpqyyuD9kBUN6w+4LFv7v/sb7KJVCwDy2YZkCK/oK+VjtJnU+IfZpk
         5JSe9ruARbPOZXaZlabSgwIApvu1uNVNpM5vKxaxr17xb2Wpk2x4bEprfbLaHrtSH1PA
         +6YdhNvCvP0AkTSUyEJDhjTus5vsWVkkcLPV7HCGIWDthOcagLe5UbGu/XLImVj1bq9J
         CGAKVxzMheYXwbvq7lvK9rQMg1SF10bALMJ4tkddoEJ0h2m+nuzIgYHeGE8H76DscfAh
         h0Cqdpl8x58IxJOv8vbRWYNnqpxK2KmTRlVx7IlJ5VHLgzXteMX/3zDad8p5mFxITPpD
         QsBw==
X-Gm-Message-State: AOJu0YxMQoPBJjuaDqbqmNwcyLfCIKmhtWNIrcnrOJgvfI/iirIZ05uP
	+vpMGTosDPvNvhs5RKRoWjmPpVuMVn7iQw/Ak1YuZA+ycm508rsNfCUBC1T0lY8=
X-Google-Smtp-Source: AGHT+IFnPKvzbNCMhe6s/L8G6kZw6DMvBRjhbburl1wgaBRZACQ7tPo5D9p5JxU9BQNYUd52+R0E9A==
X-Received: by 2002:a05:6512:3046:b0:510:28a9:9b2a with SMTP id b6-20020a056512304600b0051028a99b2amr6215200lfb.66.1706618403620;
        Tue, 30 Jan 2024 04:40:03 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id p10-20020a19f00a000000b005111b28f7c2sm200661lfc.36.2024.01.30.04.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:40:03 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Kevin Hilman <khilman@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ben Horgan <Ben.Horgan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
	linux-media@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v3 5/5] media: venus: Convert to dev_pm_domain_attach|detach_list() for vcodec
Date: Tue, 30 Jan 2024 13:39:51 +0100
Message-Id: <20240130123951.236243-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130123951.236243-1-ulf.hansson@linaro.org>
References: <20240130123951.236243-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's avoid some of the boilerplate code to manage the vcodec PM domains,
by converting into using dev_pm_domain_attach|detach_list().

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: <linux-media@vger.kernel.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

Changes in v2:
	- Added reviewed-by and tested-by tags.

---
 drivers/media/platform/qcom/venus/core.c      | 12 +++--
 drivers/media/platform/qcom/venus/core.h      |  7 ++-
 .../media/platform/qcom/venus/pm_helpers.c    | 48 +++++++------------
 3 files changed, 26 insertions(+), 41 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index a712dd4f02a5..ce206b709754 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/v4l2-mem2mem.h>
@@ -114,7 +115,8 @@ static void venus_sys_error_handler(struct work_struct *work)
 	pm_runtime_put_sync(core->dev);
 
 	for (i = 0; i < max_attempts; i++) {
-		if (!core->pmdomains[0] || !pm_runtime_active(core->pmdomains[0]))
+		if (!core->pmdomains ||
+		    !pm_runtime_active(core->pmdomains->pd_devs[0]))
 			break;
 		usleep_range(1000, 1500);
 	}
@@ -705,7 +707,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
 	.vcodec1_clks = { "vcodec1_core", "vcodec1_bus" },
 	.vcodec_clks_num = 2,
-	.vcodec_pmdomains = { "venus", "vcodec0", "vcodec1" },
+	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 2,
@@ -754,7 +756,7 @@ static const struct venus_resources sc7180_res = {
 	.clks_num = 3,
 	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
 	.vcodec_clks_num = 2,
-	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
@@ -811,7 +813,7 @@ static const struct venus_resources sm8250_res = {
 	.resets_num = 2,
 	.vcodec0_clks = { "vcodec0_core" },
 	.vcodec_clks_num = 1,
-	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "mx", NULL },
 	.vcodec_num = 1,
@@ -870,7 +872,7 @@ static const struct venus_resources sc7280_res = {
 	.clks_num = 3,
 	.vcodec0_clks = {"vcodec_core", "vcodec_bus"},
 	.vcodec_clks_num = 2,
-	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 4a633261ece4..7ef341bf21cc 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -25,7 +25,6 @@
 
 #define VIDC_CLKS_NUM_MAX		4
 #define VIDC_VCODEC_CLKS_NUM_MAX	2
-#define VIDC_PMDOMAINS_NUM_MAX		3
 #define VIDC_RESETS_NUM_MAX		2
 
 extern int venus_fw_debug;
@@ -72,7 +71,7 @@ struct venus_resources {
 	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	const char * const vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	unsigned int vcodec_clks_num;
-	const char * const vcodec_pmdomains[VIDC_PMDOMAINS_NUM_MAX];
+	const char **vcodec_pmdomains;
 	unsigned int vcodec_pmdomains_num;
 	const char **opp_pmdomain;
 	unsigned int vcodec_num;
@@ -134,7 +133,7 @@ struct venus_format {
  * @video_path: an interconnect handle to video to/from memory path
  * @cpucfg_path: an interconnect handle to cpu configuration path
  * @has_opp_table: does OPP table exist
- * @pmdomains:	an array of pmdomains struct device pointers
+ * @pmdomains:	a pointer to a list of pmdomains
  * @opp_dl_venus: an device-link for device OPP
  * @opp_pmdomain: an OPP power-domain
  * @resets: an array of reset signals
@@ -187,7 +186,7 @@ struct venus_core {
 	struct icc_path *video_path;
 	struct icc_path *cpucfg_path;
 	bool has_opp_table;
-	struct device *pmdomains[VIDC_PMDOMAINS_NUM_MAX];
+	struct dev_pm_domain_list *pmdomains;
 	struct device_link *opp_dl_venus;
 	struct device *opp_pmdomain;
 	struct reset_control *resets[VIDC_RESETS_NUM_MAX];
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index a1b127caa90a..502822059498 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -455,7 +455,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		ret = pm_runtime_put_sync(core->pmdomains[1]);
+		ret = pm_runtime_put_sync(core->pmdomains->pd_devs[1]);
 		if (ret < 0)
 			return ret;
 	}
@@ -471,7 +471,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		ret = pm_runtime_put_sync(core->pmdomains[2]);
+		ret = pm_runtime_put_sync(core->pmdomains->pd_devs[2]);
 		if (ret < 0)
 			return ret;
 	}
@@ -484,7 +484,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 	int ret;
 
 	if (coreid_mask & VIDC_CORE_ID_1) {
-		ret = pm_runtime_get_sync(core->pmdomains[1]);
+		ret = pm_runtime_get_sync(core->pmdomains->pd_devs[1]);
 		if (ret < 0)
 			return ret;
 
@@ -502,7 +502,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 	}
 
 	if (coreid_mask & VIDC_CORE_ID_2) {
-		ret = pm_runtime_get_sync(core->pmdomains[2]);
+		ret = pm_runtime_get_sync(core->pmdomains->pd_devs[2]);
 		if (ret < 0)
 			return ret;
 
@@ -860,19 +860,18 @@ static int vcodec_domains_get(struct venus_core *core)
 	struct device **opp_virt_dev;
 	struct device *dev = core->dev;
 	const struct venus_resources *res = core->res;
-	struct device *pd;
-	unsigned int i;
+	struct dev_pm_domain_attach_data vcodec_data = {
+		.pd_names = res->vcodec_pmdomains,
+		.num_pd_names = res->vcodec_pmdomains_num,
+		.pd_flags = PD_FLAG_NO_DEV_LINK,
+	};
 
 	if (!res->vcodec_pmdomains_num)
 		goto skip_pmdomains;
 
-	for (i = 0; i < res->vcodec_pmdomains_num; i++) {
-		pd = dev_pm_domain_attach_by_name(dev,
-						  res->vcodec_pmdomains[i]);
-		if (IS_ERR_OR_NULL(pd))
-			return pd ? PTR_ERR(pd) : -ENODATA;
-		core->pmdomains[i] = pd;
-	}
+	ret = dev_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
+	if (ret < 0)
+		return ret;
 
 skip_pmdomains:
 	if (!core->res->opp_pmdomain)
@@ -896,30 +895,14 @@ static int vcodec_domains_get(struct venus_core *core)
 	return 0;
 
 opp_attach_err:
-	for (i = 0; i < res->vcodec_pmdomains_num; i++) {
-		if (IS_ERR_OR_NULL(core->pmdomains[i]))
-			continue;
-		dev_pm_domain_detach(core->pmdomains[i], true);
-	}
-
+	dev_pm_domain_detach_list(core->pmdomains);
 	return ret;
 }
 
 static void vcodec_domains_put(struct venus_core *core)
 {
-	const struct venus_resources *res = core->res;
-	unsigned int i;
+	dev_pm_domain_detach_list(core->pmdomains);
 
-	if (!res->vcodec_pmdomains_num)
-		goto skip_pmdomains;
-
-	for (i = 0; i < res->vcodec_pmdomains_num; i++) {
-		if (IS_ERR_OR_NULL(core->pmdomains[i]))
-			continue;
-		dev_pm_domain_detach(core->pmdomains[i], true);
-	}
-
-skip_pmdomains:
 	if (!core->has_opp_table)
 		return;
 
@@ -1035,7 +1018,8 @@ static void core_put_v4(struct venus_core *core)
 static int core_power_v4(struct venus_core *core, int on)
 {
 	struct device *dev = core->dev;
-	struct device *pmctrl = core->pmdomains[0];
+	struct device *pmctrl = core->pmdomains ?
+			core->pmdomains->pd_devs[0] : NULL;
 	int ret = 0;
 
 	if (on == POWER_ON) {
-- 
2.34.1


