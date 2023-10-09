Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE697BD8C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346144AbjJIKgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345937AbjJIKgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:36:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC8CAB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:36:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3296b49c546so2468783f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696847793; x=1697452593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLqmJToKVvGx3RPF93C/D7OTDNmDiwUSULcdREcteNg=;
        b=V4ndD/FvTN8lDLyDZ+iL1ssnIQXGKkAxLC7Gh+qcxuxRwg/FhAD/TVT73fKADskQrU
         1cveajp1LH72QU65QuUopll3bPyK9bDBOJzUAmTmoa3nZluUL7vesFFIU+SQQR/KkuPr
         8m08QwvP9FKNhgHIVeNVG2Tt0F7BqhbJHr0F7duxV63YusafmwMjcKyO6ZK3axtUsZqo
         w6XTcqnQ+3blMZxf4mH+kQlo60LS+gNWeoaOCXY2kmIQFg75gPCpMyc+NfeFtkhM8ijY
         l4L5NejI8U/JD8NdUPBtpAmSVxw4F46tlb5HhFn7m+0/Rs8dWJz1T9wSMBZ6qSoOEcyH
         csog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696847793; x=1697452593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLqmJToKVvGx3RPF93C/D7OTDNmDiwUSULcdREcteNg=;
        b=ZGO7PZ2oGLs5ubx6SVJG+mq9gt9rYJ29u9RmN/K4mq624XpUT6MKl8oiy2lBtfCj6W
         EQdyRrpx3x4H/6TiI19oB4i0ZtxLbxpI+PtlcKrh6vzwctg0DeMMEquEjZvTvQdmyK2k
         6YYo/0HAkF4U4gAoX/k2iI13Vvv9u2y8HS/4CRiD7Xg6zvEjHT1XoMNoC2A5yrWCr/Rz
         t1wehAtRGcfYb+Ghft4WwayuvDa5FcWw4S1IfGMQnP98z545QxtQw4QRHmMeZhie38KZ
         wXJItXurLVjCsnoJRI4vjk13TNNMmKfswezZJCyI5bmsQap81BsGF24UGp4CEPeQc6NU
         wQow==
X-Gm-Message-State: AOJu0Yzwge8SNJRRMUOvH67RFqfl6RFotMlo0IeoY4EImMaP0kOFjgNF
        /a+pQUM/cSrEZ40pEc0amZsyNw==
X-Google-Smtp-Source: AGHT+IE1c9bbdHMwBLMomM9sWbKgUcq5hfVG4KlvDcosRRJkN4Ti2TteiXopQtpHeenYl1QcJ2PxJw==
X-Received: by 2002:a5d:614b:0:b0:31c:8c93:61e3 with SMTP id y11-20020a5d614b000000b0031c8c9361e3mr12270603wrt.60.1696847793608;
        Mon, 09 Oct 2023 03:36:33 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:53f1:24bc:5e47:821d])
        by smtp.gmail.com with ESMTPSA id f16-20020adfdb50000000b0031ff89af0e4sm9226722wrj.99.2023.10.09.03.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:36:33 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 6/6] cpufreq/cppc: set the frequency used for capacity computation
Date:   Mon,  9 Oct 2023 12:36:21 +0200
Message-Id: <20231009103621.374412-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009103621.374412-1-vincent.guittot@linaro.org>
References: <20231009103621.374412-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppc cpufreq driver can register an artificial energy model. In such case,
it also have to register the frequency that is used to define the CPU
capacity

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index fe08ca419b3d..24c6ba349f01 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -636,6 +636,21 @@ static int populate_efficiency_class(void)
 	return 0;
 }
 
+
+static void cppc_cpufreq_set_capacity_ref_freq(struct cpufreq_policy *policy)
+{
+	struct cppc_perf_caps *perf_caps;
+	struct cppc_cpudata *cpu_data;
+	unsigned int ref_freq;
+
+	cpu_data = policy->driver_data;
+	perf_caps = &cpu_data->perf_caps;
+
+	ref_freq = cppc_cpufreq_perf_to_khz(cpu_data, perf_caps->highest_perf);
+
+	per_cpu(capacity_ref_freq, policy->cpu) = ref_freq;
+}
+
 static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data;
@@ -643,6 +658,9 @@ static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
 		EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
 
 	cpu_data = policy->driver_data;
+
+	cppc_cpufreq_set_capacity_ref_freq(policy);
+
 	em_dev_register_perf_domain(get_cpu_device(policy->cpu),
 			get_perf_level_count(policy), &em_cb,
 			cpu_data->shared_cpu_map, 0);
-- 
2.34.1

