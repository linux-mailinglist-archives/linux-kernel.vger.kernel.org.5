Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCF47AC172
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjIWLua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIWLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:50:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576561B0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:50:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99357737980so443813466b.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695469819; x=1696074619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkMg6Ss1ODOcr8VdxRq6yPqfjTyE6Onn/Fwc4BWB7DM=;
        b=rLkzUVP9FvDi4+xOnZH7Iga1U2MJSV+W/0G+rtds2o8MTzHpFrZ009AS4vb/8PN6td
         f9vExEq4tuN4HGGf7XfxTn1GwdiQhiq2QZ11Dyu6shWaC5nbvKNbgotBaGEmajaiBSW0
         +gc72amGkuTSZxoRt/Kv4yH99qDceXRaltQ6HceQpxu+z9o1RXa07q0i7ymRcV4of6hf
         H1TXEbkI7YxfcN4wk+VvVt/uvBnohsgKBGXfTxIEqbLg7QVI7WZB7aFFxF+SE5/vHkHi
         qzgCk6EctIw9+jHV9x2iX5Zz4NXmrGfEj5Dt4AzZEqMqLS83NEF+JKgCl0eQKlExPsl0
         R5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695469819; x=1696074619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkMg6Ss1ODOcr8VdxRq6yPqfjTyE6Onn/Fwc4BWB7DM=;
        b=IEOa8wLaZ6ZJ9MC0jm8wO4fakzHUSGb/Idq0g4+QqzYBfQOgBAGzM+wnmOtk150gDL
         TsPOVi0XI4pY+9LVQ+46LxJDatVflshC+/C4PTpa1xN+3EritDC2eW/by/tsdt1u0LlM
         w7bGBenqBeKrAUpYCgWDzl+cmwRMCWweS71vPQsvIaG89yFfJ66Mp1P4zRyeHXRZBlvN
         G7S09jjLdtUJ+s8FnhgBmWNhzW6TmRxJNVwJfTZ8WuP8/1IT03CGxy46EGbKDkB0SVFW
         QR/P9wNNVUD1pCrsIwoTQrF2N/DcsoygZrYK2VxyPO36/uNQ4A78ZhfPUhKURrtyFBzJ
         JFHA==
X-Gm-Message-State: AOJu0YzJPC9/v8bzzX0eEGdgSfhKVPxzpxcKdK/Z+ferXVZKy0fGXEms
        xfij8Ce8AWMjDrWS20122ireJw==
X-Google-Smtp-Source: AGHT+IFA63qVcvn23d2cB7ArqMpEOgP3SaNn+1EhFxPur0BUfXBa/lAhkkc40O5YTXiHAPiXx/8TGQ==
X-Received: by 2002:a17:906:310d:b0:9a2:24f9:fabe with SMTP id 13-20020a170906310d00b009a224f9fabemr2003596ejx.66.1695469818880;
        Sat, 23 Sep 2023 04:50:18 -0700 (PDT)
Received: from hackbox.lan ([86.120.16.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709062a4f00b009ad8084e08asm3853310eje.0.2023.09.23.04.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 04:50:18 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Subject: [RESEND v3 2/5] PM: domains: Add the domain HW-managed mode to the summary
Date:   Sat, 23 Sep 2023 14:50:05 +0300
Message-Id: <20230923115008.1698384-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923115008.1698384-1-abel.vesa@linaro.org>
References: <20230923115008.1698384-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that genpd supports dynamically switching the control for an
attached device between hardware- and software-mode,  let's add this
information to the genpd summary in debugfs.

Suggested-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index dfb4f1de540d..93350e67b0e8 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -3171,6 +3171,15 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
 	seq_printf(s, "%-25s  ", p);
 }
 
+static void mode_status_str(struct seq_file *s, struct device *dev)
+{
+	struct generic_pm_domain_data *gpd_data;
+
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+
+	seq_printf(s, "%20s", gpd_data->hw_mode ? "HW" : "SW");
+}
+
 static void perf_status_str(struct seq_file *s, struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
@@ -3229,6 +3238,7 @@ static int genpd_summary_one(struct seq_file *s,
 		seq_printf(s, "\n    %-50s  ", kobj_path);
 		rtpm_status_str(s, pm_data->dev);
 		perf_status_str(s, pm_data->dev);
+		mode_status_str(s, pm_data->dev);
 		kfree(kobj_path);
 	}
 
@@ -3245,8 +3255,9 @@ static int summary_show(struct seq_file *s, void *data)
 	int ret = 0;
 
 	seq_puts(s, "domain                          status          children                           performance\n");
-	seq_puts(s, "    /device                                             runtime status\n");
-	seq_puts(s, "----------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "    /device                                             runtime status                           managed by\n");
+	seq_puts(s, "------------------------------------------------------------------------------------------------------------\n");
+
 
 	ret = mutex_lock_interruptible(&gpd_list_lock);
 	if (ret)
-- 
2.34.1

