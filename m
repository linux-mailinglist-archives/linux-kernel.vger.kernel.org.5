Return-Path: <linux-kernel+bounces-47474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BA4844E69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D01B1F29C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17583BB53;
	Thu,  1 Feb 2024 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTnaoViN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC341A27C;
	Thu,  1 Feb 2024 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749674; cv=none; b=Cpi2uoHiHI62yLGAqLIwuUnaoy40fl26DbGzsvCbAPtDSgEgLQSTJ5qIjlwspMLz6kau1v5J8hG2zBwE1AoXvtZ3qN+zlZAfM8d2hpm2K734YMScw8DnXkiLg6gePKb2SE6WhtoudXQ0hIPkPMLjA8FD5ogyajr9hB+JNFST8WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749674; c=relaxed/simple;
	bh=4WsWv00onasp48d72sbpBjqQmJ37YOowYHi4hbk2FQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lw2/+/imtUYNYsK40hv8IZUsm/ruRAKxDyY+gKE+o45ZROcCiCrxtSlEhVCaEpyUBiGjRlwSTh8aLgbjze0AsDiyzeHpKSDhooalLUNecLBJ3tf5gq2k7xdgcrngl1P1oRoawqs6EFiJLpmtlEIaPsp36lNyCzL2gNwWP/YMc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTnaoViN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749673; x=1738285673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4WsWv00onasp48d72sbpBjqQmJ37YOowYHi4hbk2FQg=;
  b=LTnaoViNbPtUE6o6pHTOyj5Oe3N52/I/rvVudQkO0hkyJB1Pe6L+2VUd
   ktExJfxO9kxxAOoEMn2lrDAQP6OJPXIp14ZSkMlu8zWlfqNJmFZXlvdH6
   Iain2QAJqJkzd74TeaSBdNZfBND5yjNTVHhJhtje/3ITDfTVKpPkWWxwc
   ByfKa7TTCAYhXq1tqgdOV109cX/tPQEKNKbYcSAz2XuKqNveuZOauioNk
   OHYvcmCMyHRi99eiV9dszi12lr/ugxZFTKMH8Qu9Jw2iVxlMHYvjmZgYE
   Xh6KJtHHeTn/Hrd2JLN7CRS0Po+W9sp6wlqdqhAlGrBmXHDJnhvzkP+32
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10533017"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10533017"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4265165"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:50 -0800
Received: from debox1-desk4.lan (unknown [10.212.205.115])
	by linux.intel.com (Postfix) with ESMTP id B3099580201;
	Wed, 31 Jan 2024 17:07:49 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: netdev@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 8/8] tools: intel_sdsi: Add current meter support
Date: Wed, 31 Jan 2024 17:07:47 -0800
Message-Id: <20240201010747.471141-9-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201010747.471141-1-david.e.box@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to read the 'meter_current' file. The display is the same as
the 'meter_certificate', but will show the current snapshot of the
counters.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 48 +++++++++++++++++---------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index a8fb6d17405f..c9b3e457885d 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -182,6 +182,7 @@ struct sdsi_dev {
 enum command {
 	CMD_SOCKET_INFO,
 	CMD_METER_CERT,
+	CMD_METER_CURRENT_CERT,
 	CMD_STATE_CERT,
 	CMD_PROV_AKC,
 	CMD_PROV_CAP,
@@ -329,7 +330,7 @@ static void get_feature(uint32_t encoding, char *feature)
 	feature[0] = name[3];
 }
 
-static int sdsi_meter_cert_show(struct sdsi_dev *s)
+static int sdsi_meter_cert_show(struct sdsi_dev *s, bool show_current)
 {
 	char buf[METER_CERT_MAX_SIZE] = {0};
 	struct bundle_encoding_counter *bec;
@@ -360,7 +361,11 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 		return ret;
 	}
 
-	cert_ptr = fopen("meter_certificate", "r");
+	if (!show_current)
+		cert_ptr = fopen("meter_certificate", "r");
+	else
+		cert_ptr = fopen("meter_current", "r");
+
 	if (!cert_ptr) {
 		perror("Could not open 'meter_certificate' file");
 		return -1;
@@ -368,7 +373,8 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 
 	size = fread(buf, 1, sizeof(buf), cert_ptr);
 	if (!size) {
-		fprintf(stderr, "Could not read 'meter_certificate' file\n");
+		fprintf(stderr, "Could not read '%s' file\n",
+			show_current ? "meter_current" : "meter_certificate");
 		fclose(cert_ptr);
 		return -1;
 	}
@@ -734,7 +740,7 @@ static void sdsi_free_dev(struct sdsi_dev *s)
 
 static void usage(char *prog)
 {
-	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-m] [-a FILE] [-c FILE]]\n", prog);
+	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-m | -C] [-a FILE] [-c FILE]\n", prog);
 }
 
 static void show_help(void)
@@ -743,8 +749,9 @@ static void show_help(void)
 	printf("  %-18s\t%s\n", "-l, --list",           "list available On Demand devices");
 	printf("  %-18s\t%s\n", "-d, --devno DEVNO",    "On Demand device number");
 	printf("  %-18s\t%s\n", "-i, --info",           "show socket information");
-	printf("  %-18s\t%s\n", "-s, --state",          "show state certificate");
-	printf("  %-18s\t%s\n", "-m, --meter",          "show meter certificate");
+	printf("  %-18s\t%s\n", "-s, --state",          "show state certificate data");
+	printf("  %-18s\t%s\n", "-m, --meter",          "show meter certificate data");
+	printf("  %-18s\t%s\n", "-C, --meter_current",  "show live unattested meter data");
 	printf("  %-18s\t%s\n", "-a, --akc FILE",       "provision socket with AKC FILE");
 	printf("  %-18s\t%s\n", "-c, --cap FILE>",      "provision socket with CAP FILE");
 }
@@ -760,21 +767,22 @@ int main(int argc, char *argv[])
 	int option_index = 0;
 
 	static struct option long_options[] = {
-		{"akc",		required_argument,	0, 'a'},
-		{"cap",		required_argument,	0, 'c'},
-		{"devno",	required_argument,	0, 'd'},
-		{"help",	no_argument,		0, 'h'},
-		{"info",	no_argument,		0, 'i'},
-		{"list",	no_argument,		0, 'l'},
-		{"meter",	no_argument,		0, 'm'},
-		{"state",	no_argument,		0, 's'},
-		{0,		0,			0, 0 }
+		{"akc",			required_argument,	0, 'a'},
+		{"cap",			required_argument,	0, 'c'},
+		{"devno",		required_argument,	0, 'd'},
+		{"help",		no_argument,		0, 'h'},
+		{"info",		no_argument,		0, 'i'},
+		{"list",		no_argument,		0, 'l'},
+		{"meter",		no_argument,		0, 'm'},
+		{"meter_current",	no_argument,		0, 'C'},
+		{"state",		no_argument,		0, 's'},
+		{0,			0,			0, 0 }
 	};
 
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+a:c:d:hilms", long_options,
+	while ((opt = getopt_long_only(argc, argv, "+a:c:d:hilmCs", long_options,
 			&option_index)) != -1) {
 		switch (opt) {
 		case 'd':
@@ -790,6 +798,9 @@ int main(int argc, char *argv[])
 		case 'm':
 			command = CMD_METER_CERT;
 			break;
+		case 'C':
+			command = CMD_METER_CURRENT_CERT;
+			break;
 		case 's':
 			command = CMD_STATE_CERT;
 			break;
@@ -828,7 +839,10 @@ int main(int argc, char *argv[])
 			ret = sdsi_read_reg(s);
 			break;
 		case CMD_METER_CERT:
-			ret = sdsi_meter_cert_show(s);
+			ret = sdsi_meter_cert_show(s, false);
+			break;
+		case CMD_METER_CURRENT_CERT:
+			ret = sdsi_meter_cert_show(s, true);
 			break;
 		case CMD_STATE_CERT:
 			ret = sdsi_state_cert_show(s);
-- 
2.34.1


