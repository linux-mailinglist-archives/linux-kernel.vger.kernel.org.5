Return-Path: <linux-kernel+bounces-102321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571CB87B091
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB36A1F22A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41889143C62;
	Wed, 13 Mar 2024 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pt4Xvk6Z"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D944D58AB8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352503; cv=none; b=edsVSE5Vap8odPOhL0MwOwUJIVNJ/YxMLzwVBrTn9WgcTKCS5/G4PB+LOO0zyOm/bF2rPINB2gBgCFeaR4savtakm+OAz5B9vNHfikg5ezLQtd77ZriCMisURaxh1Qx4Dmh4sRCcZKJVhDaMFHbTl08zJsCiT2fo6cfnxCGCWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352503; c=relaxed/simple;
	bh=cwRbPymiLOyZlyDmK8zPSK9UFQ0A0ibmMVEQvH7Wa+Y=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=dsi9rpSlLIgOVIynTwLdCZKLV+wwWCGc7mZXLdcYI8EtMAhnTlzX9/M7V+gNjC+omb/umNBd2oeRerTkTCgRdwWpnbYtvHNo+78Q5HlJAzG4EOnODwl+qrbJDuRTHPvlthlAZfhAwcn1D+wZSIjaj3MEZ9ZV/y0j0R8laJNg+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--eranian.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pt4Xvk6Z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--eranian.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a4ee41269so2671277b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710352501; x=1710957301; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TF6nSMnYxDunkikTDjHzvblyRSJb/thPi17ukSIIAXQ=;
        b=Pt4Xvk6ZBM44LlEworphKc8xs/rWNmbe4F9EDGmK0ikskq8YK7fVRHBeGZ6a4201SG
         Jgwar0ivx4YgPfeAQIU5OpdFndGFaqASAOz78ysXRxcvRK0rhrgm56xS4bhQOZBdLhxZ
         pax2GWJRDwd5K3nxBRjh2OVVSyeSIMxC+gPnPkgdxlAOexZ3fFhWC10nE0lmqpjYK4Hj
         GfQmmbKO911O0JFmistQhNv0A8paBchp+LGvsn6RG1qVokiJFCFBV0MfYuBrb6gFI+Z3
         uaxl9EcgNL6sItBAQGgfoz96rFS7BXcY/xognU8vZs1eY/NawTy3iSAvkLadeUQq/KVX
         kt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710352501; x=1710957301;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TF6nSMnYxDunkikTDjHzvblyRSJb/thPi17ukSIIAXQ=;
        b=cseUboH575k8hjCLiOFXTLy/Y6wccxxiTdAvbZFVXwMDptCbM0tPmVJWqun9FBd57M
         uqKiGwEygphI0Ftb9SuDhXIDwQCVBpfMC8WWPIlfQaD0xMl1YxkX62JT/tYBncz7nLcf
         TtuOmebLy+Em4IiPX9ZU0JU3gdyl7CkNYMxfk4Ew2gqBGrRcsgBMJai5nOEidyFY4s3s
         Z5s+G/sAlZP1O/k2+9rRS3H3ftyIRtMIccgDAylhzWj91sO0gIOENBA8mV0IcqA3rXNV
         xL4cH4L3Hjm6vi80GZ0yKecIjuOQxpAn9BkCFyxIRxCGsfUnxfMrmC9jFiD8LA5enzYU
         t7lg==
X-Gm-Message-State: AOJu0Yxu0ovE6e2MMqLSiebRd/fZ+2OvzTdOiiQV16DOlx1EwQDjPRZ0
	FIsaxkTq6JyWrkTTl5oGA7RBbZ58UrQIR8eeWRUmRnA8q2k+Dsj9Zcg3Wpw1qHQJMSjAzVnA1Kd
	xSwV7RFtZ0U5V3CabEIRjQhzCjM6BHnnZN55bDgF1bCFsXu5QsDTb09u5f3rkjYAHe1LFFIe0eQ
	MAsvI3qqIbcvEBg3E8ZCCxFhKUGmvGcR+SY18W5Bb5ktECvA==
X-Google-Smtp-Source: AGHT+IHR438+/k/mtigktr29SR2OtJHKqSj3VsCXUx4RMCkxdP5JpMDHXhyL0jlbkDgq2zlvBMoxEjGZQ2DS
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2a3:200:a07a:f32f:fd84:7146])
 (user=eranian job=sendgmr) by 2002:a05:690c:3392:b0:60a:e67:2ed0 with SMTP id
 fl18-20020a05690c339200b0060a0e672ed0mr876765ywb.9.1710352500739; Wed, 13 Mar
 2024 10:55:00 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:54:53 -0700
Message-Id: <20240313175453.433166-1-eranian@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH] perf/amd/ibs: provide weights for all IBS op samples
From: Stephane Eranian <eranian@google.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, namhyung@kernel.org, irogers@google.com, 
	sandipan.das@amd.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

IBS Op provides instructions latencies for each uop sampled. The current
code was only providing the weights only for loads. This is useful
information for performance analysis. This patch modifies the logic to
provide the weights for all uops.

$ perf record -a -W -c 100003 -e ibs_op/cnt_ctl=1/GH ....

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/ibs.c | 46 +++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e91970b01d62..d2f4d3b19cf9 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -957,6 +957,28 @@ static __u64 perf_ibs_get_op_data2(struct perf_ibs_data *ibs_data,
 	return val;
 }
 
+static void perf_ibs_parse_uop_latencies(__u64 sample_type,
+					 struct perf_ibs_data *ibs_data,
+					 struct perf_sample_data *data)
+{
+	union ibs_op_data op_data;
+
+	/* latencies not requested by user */
+	if (!(sample_type & PERF_SAMPLE_WEIGHT_TYPE))
+		return;
+
+	op_data.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA)];
+
+	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		data->weight.var1_dw = 0;
+		data->weight.var2_w = op_data.tag_to_ret_ctr;
+		data->weight.var3_w = op_data.comp_to_ret_ctr;
+	} else {
+		data->weight.full = op_data.tag_to_ret_ctr;
+	}
+	data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+}
+
 static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 				      struct perf_ibs_data *ibs_data,
 				      struct perf_sample_data *data)
@@ -980,17 +1002,15 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 		data->sample_flags |= PERF_SAMPLE_DATA_SRC;
 	}
 
-	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE && op_data3.dc_miss &&
-	    data->data_src.mem_op == PERF_MEM_OP_LOAD) {
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
 		op_data.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA)];
-
-		if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
-			data->weight.var1_dw = op_data3.dc_miss_lat;
-			data->weight.var2_w = op_data.tag_to_ret_ctr;
-		} else if (sample_type & PERF_SAMPLE_WEIGHT) {
-			data->weight.full = op_data3.dc_miss_lat;
+		if (op_data3.dc_miss && data->data_src.mem_op == PERF_MEM_OP_LOAD) {
+			if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
+				data->weight.var1_dw = op_data3.dc_miss_lat;
+			} else if (sample_type & PERF_SAMPLE_WEIGHT) {
+				data->weight.full = op_data3.dc_miss_lat;
+			}
 		}
-		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 	}
 
 	if (sample_type & PERF_SAMPLE_ADDR && op_data3.dc_lin_addr_valid) {
@@ -1121,8 +1141,12 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		perf_sample_save_raw_data(&data, &raw);
 	}
 
-	if (perf_ibs == &perf_ibs_op)
-		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
+	if (perf_ibs == &perf_ibs_op) {
+		__u32 type = event->attr.sample_type;
+
+		perf_ibs_parse_uop_latencies(type, &ibs_data, &data);
+		perf_ibs_parse_ld_st_data(type, &ibs_data, &data);
+	}
 
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
-- 
2.44.0.278.ge034bb2e1d-goog


