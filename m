Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DBF7C934F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjJNHpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNHpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:45:32 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E353C2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:45:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79fca042ec0so111234039f.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697269529; x=1697874329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUGayCjdfCKVMoAdEORZ5NxIXkJ/ofSNrTgGs/xtftE=;
        b=e5w6CmFjkySmPdLyRuMcoXlHko8ip3BpnpVLoHnVMBEQXVpNKnKhEPnFZfe6az2Ige
         cHqfsMNiWabdspaL2GdeBaZAWp2C2oZppT+k3kyS83waVxyXVgzbaxwMUUIDHNpnGbhk
         APLLUi1MA9sOCsdUjdgWl1Y7iaSGQBCOpynWO0Xv6zbp7GsJkKLmkWONh+qwIKw4+i8G
         LXHniKLVsNnaQCyT6+zitQ3obM2EaJGnYKmLy+ZOeNePTIAiWEof9z7qa478DzrkTxXy
         sG/eogQGdFzXbAm+6Pf3kFC8oDXui8y6W6kmR1N980doMzcdMjTkyHuN7iK0xa1mKsm2
         dUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269529; x=1697874329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUGayCjdfCKVMoAdEORZ5NxIXkJ/ofSNrTgGs/xtftE=;
        b=Zu3NQhc1aODEoZD05RXB2gnD6B85HjhXVxlY6LBQJ83Am3NaL3M86dUUs909TZemuV
         XDNmgEq5AP2uMurxyEauio4oEy971ExDkAs9gJPsfZ+UKtGbVlFiTsgbeMx845yEeaCa
         eDHhnAH9fFapmoHfbvlw1hhje8T/NRKDLqgYZNoljfmfGtl3QWTkdhIls9Kg+aiyhgja
         8ljF4PKxHrJz9B5GRwSl0nMFYG5T5GUvCoeW7nc91j3rwN29Xlp9AVLhMWqRSmDkLlot
         L6DBaj+n90JUlXpsViKUsw41DS7guYso7++uV6hVmxfm4gpsclf8MICGNjWpG1ZjPZ7+
         Q1pw==
X-Gm-Message-State: AOJu0YymtUkJPH1bz2eXTTlGtQKhTsOwP5Oeq7AoUXoAB+x5+7+HIreO
        5gZv1de1awnZpXTixM+dnXthig==
X-Google-Smtp-Source: AGHT+IFu4IpYYh0fEp9h0zOOlOY34CAXroKMc6faHAM0eY/L+xaLENO/R/YjFnAwiYbWYfOexjgEcQ==
X-Received: by 2002:a92:c269:0:b0:357:5234:802d with SMTP id h9-20020a92c269000000b003575234802dmr10535089ild.10.1697269529372;
        Sat, 14 Oct 2023 00:45:29 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.106])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902be0800b001c3e732b8dbsm4965124pls.168.2023.10.14.00.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:45:28 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for timestamp trace
Date:   Sat, 14 Oct 2023 15:45:12 +0800
Message-Id: <20231014074513.1668000-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231014074513.1668000-1-leo.yan@linaro.org>
References: <20231014074513.1668000-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An AUX trace can contain timestamp, but in some situations, the hardware
trace module (e.g. Arm CoreSight) cannot decide the traced timestamp is
the same source with CPU's time, thus the decoder can not use the
timestamp trace for samples.

This patch introduces 'T' itrace option. If users know the platforms
they are working on have the same time counter with CPUs, users can
use this new option to tell a decoder for using timestamp trace as
kernel time.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/itrace.txt | 1 +
 tools/perf/util/auxtrace.c          | 3 +++
 tools/perf/util/auxtrace.h          | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index a97f95825b14..19cc179be9a7 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -25,6 +25,7 @@
 		q	quicker (less detailed) decoding
 		A	approximate IPC
 		Z	prefer to ignore timestamps (so-called "timeless" decoding)
+		T	use the timestamp trace as kernel time
 
 	The default is all events i.e. the same as --itrace=iybxwpe,
 	except for perf script where it is --itrace=ce
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a0368202a746..f528c4364d23 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1638,6 +1638,9 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 		case 'Z':
 			synth_opts->timeless_decoding = true;
 			break;
+		case 'T':
+			synth_opts->use_timestamp = true;
+			break;
 		case ' ':
 		case ',':
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 29eb82dff574..55702215a82d 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -99,6 +99,7 @@ enum itrace_period_type {
  * @remote_access: whether to synthesize remote access events
  * @mem: whether to synthesize memory events
  * @timeless_decoding: prefer "timeless" decoding i.e. ignore timestamps
+ * @use_timestamp: use the timestamp trace as kernel time
  * @vm_time_correlation: perform VM Time Correlation
  * @vm_tm_corr_dry_run: VM Time Correlation dry-run
  * @vm_tm_corr_args:  VM Time Correlation implementation-specific arguments
@@ -146,6 +147,7 @@ struct itrace_synth_opts {
 	bool			remote_access;
 	bool			mem;
 	bool			timeless_decoding;
+	bool			use_timestamp;
 	bool			vm_time_correlation;
 	bool			vm_tm_corr_dry_run;
 	char			*vm_tm_corr_args;
@@ -678,6 +680,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				q:			quicker (less detailed) decoding\n" \
 "				A:			approximate IPC\n" \
 "				Z:			prefer to ignore timestamps (so-called \"timeless\" decoding)\n" \
+"				T:			use the timestamp trace as kernel time\n" \
 "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
 "				concatenate multiple options. Default is iybxwpe or cewp\n"
 
-- 
2.34.1

