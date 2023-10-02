Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28937B5D0C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjJBWTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJBWTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:19:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDDAD8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:19:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so439299276.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696285159; x=1696889959; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2wUAnWIW9zJ3ana8E0TCfI1tH00XkwJZJ8WQ0fILTKw=;
        b=D7xS4a7cH+/QlWEkA9n0Ma3QsEgRYbIL6v5Gmnw+hdYm43759vG75oLNfuaSggtTUT
         TX9Tl+SqGpLzNvjLycveD0mmvv76BBJI7YVAxr0XSTgF4zUZnT2jCgI/R6+HH8IDOHC+
         8YUKzDWog1EL1/BVWuvauAyi1jXpnjsFWjKObvXiDgxF/gKLuZaHVHyTw/ov31ptEtkK
         Vrg+9vYG0fHFjBhN0uPp3l8KQDVscWEWmt3ylpxozqpeb+vMuGAZ1Zqfm2GMnLMnkgs1
         oC5074M3kAO6hy4Pnj+/pK3YFgwY66+F2Wf5U34mWBWWYLAaFfad16Y94vNw+Z7K/dS1
         Gp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696285159; x=1696889959;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wUAnWIW9zJ3ana8E0TCfI1tH00XkwJZJ8WQ0fILTKw=;
        b=Rt0qlOnO0nkTjOYV+WhvEPdOMavp67Dz7I/lJcODFw3YPqs28jFg+GNET/MWyESuKL
         Lqs1N5DGDnnOwWUPRMMjLIS8yJzjkJha0tUnAEIaaCyfvee2j4lve0uJQ+F1Vs22RHBZ
         duORjqgNwUIQpki/yAfFAQ61bF2mbxY39fX7IL4b6MN0jQLxEH4vsyilnfiDO7tB4jNA
         RIEzbe4z1siqnVQcrIk687pxPkVQEoGGBLq6UJjIm/CjzEY7kH9K3bG8jI7rUeZT9s6C
         vvMzYNJ51T/lNMBv8G/ZZXU0PPwVTD4yUbkKgmSDUhxSbISMfsmQzIB2FZOsVpQHnGGM
         3jNg==
X-Gm-Message-State: AOJu0YxC7Ih4UzVi2fZBy9PnSTm9jpEvGHQPdRW9j/XTKy+Rp03YU/Q1
        uUq6K0c13KnaUMT1dOuVyA9JcEnevC/M
X-Google-Smtp-Source: AGHT+IE7kbxKDvfHnds4/doK3Cau9kRtjJ3LDIBLfnaDBoWUcsfv2KpGW/h4t+5F9T8WD5mnxQgtfaxZtLwA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a907:e439:3a86:b259])
 (user=irogers job=sendgmr) by 2002:a25:7606:0:b0:d84:2619:56df with SMTP id
 r6-20020a257606000000b00d84261956dfmr215174ybc.13.1696285158714; Mon, 02 Oct
 2023 15:19:18 -0700 (PDT)
Date:   Mon,  2 Oct 2023 15:19:09 -0700
Message-Id: <20231002221909.2958708-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Subject: [PATCH v1] perf intel-pt: pkt-decoder: Fix alignment issues
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The byte aligned buffer is cast to large types and dereferenced
causing misaligned pointer warnings from undefined behavior sanitizer.
Fix the alignment issues with memcpy which may require the
introduction of temporaries.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../intel-pt-decoder/intel-pt-pkt-decoder.c   | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index af9710622a1f..28659874d84e 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -83,7 +83,7 @@ static int intel_pt_get_long_tnt(const unsigned char *buf, size_t len,
 	if (len < 8)
 		return INTEL_PT_NEED_MORE_BYTES;
 
-	payload = le64_to_cpu(*(uint64_t *)buf);
+	memcpy_le64(&payload, buf, sizeof(payload));
 
 	for (count = 47; count; count--) {
 		if (payload & BIT63)
@@ -220,6 +220,8 @@ static int intel_pt_get_3byte(const unsigned char *buf, size_t len,
 static int intel_pt_get_ptwrite(const unsigned char *buf, size_t len,
 				struct intel_pt_pkt *packet)
 {
+	uint32_t tmp;
+
 	packet->count = (buf[1] >> 5) & 0x3;
 	packet->type = buf[1] & BIT(7) ? INTEL_PT_PTWRITE_IP :
 					 INTEL_PT_PTWRITE;
@@ -228,12 +230,13 @@ static int intel_pt_get_ptwrite(const unsigned char *buf, size_t len,
 	case 0:
 		if (len < 6)
 			return INTEL_PT_NEED_MORE_BYTES;
-		packet->payload = le32_to_cpu(*(uint32_t *)(buf + 2));
+		memcpy(&tmp, buf + 2, sizeof(tmp));
+		packet->payload = le32_to_cpu(tmp);
 		return 6;
 	case 1:
 		if (len < 10)
 			return INTEL_PT_NEED_MORE_BYTES;
-		packet->payload = le64_to_cpu(*(uint64_t *)(buf + 2));
+		memcpy_le64(&packet->payload, buf + 2, sizeof(packet->payload));
 		return 10;
 	default:
 		return INTEL_PT_BAD_PACKET;
@@ -258,7 +261,7 @@ static int intel_pt_get_mwait(const unsigned char *buf, size_t len,
 	if (len < 10)
 		return INTEL_PT_NEED_MORE_BYTES;
 	packet->type = INTEL_PT_MWAIT;
-	packet->payload = le64_to_cpu(*(uint64_t *)(buf + 2));
+	memcpy_le64(&packet->payload, buf + 2, sizeof(packet->payload));
 	return 10;
 }
 
@@ -454,6 +457,8 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type type, unsigned int byte,
 			   struct intel_pt_pkt *packet)
 {
 	int ip_len;
+	uint16_t tmp16;
+	uint32_t tmp32;
 
 	packet->count = byte >> 5;
 
@@ -465,13 +470,15 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type type, unsigned int byte,
 		if (len < 3)
 			return INTEL_PT_NEED_MORE_BYTES;
 		ip_len = 2;
-		packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
+		memcpy(&tmp16, buf + 1, sizeof(tmp16));
+		packet->payload = le16_to_cpu(tmp16);
 		break;
 	case 2:
 		if (len < 5)
 			return INTEL_PT_NEED_MORE_BYTES;
 		ip_len = 4;
-		packet->payload = le32_to_cpu(*(uint32_t *)(buf + 1));
+		memcpy(&tmp32, buf + 1, sizeof(tmp32));
+		packet->payload = le32_to_cpu(tmp32);
 		break;
 	case 3:
 	case 4:
@@ -484,7 +491,7 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type type, unsigned int byte,
 		if (len < 9)
 			return INTEL_PT_NEED_MORE_BYTES;
 		ip_len = 8;
-		packet->payload = le64_to_cpu(*(uint64_t *)(buf + 1));
+		memcpy_le64(&packet->payload, buf + 1, sizeof(packet->payload));
 		break;
 	default:
 		return INTEL_PT_BAD_PACKET;
-- 
2.42.0.582.g8ccd20d70d-goog

