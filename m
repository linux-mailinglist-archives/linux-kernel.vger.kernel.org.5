Return-Path: <linux-kernel+bounces-84252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B886A42F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C231F28AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3789556472;
	Wed, 28 Feb 2024 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdFXYp99"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC382031D;
	Wed, 28 Feb 2024 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078423; cv=none; b=D7amLrUUuS8C6LBFxlDJ2HzzaPBOfRKfdcd3+1/WtJUbuTqNs82Z0mKfS5EOGTD+mC8p+rkavqnbzBfn4j1x5Z3x0zIgd6lAgLNaiVl/Kl9L9ny6Ptkg2INFX6U5DDXp7jpseXAc/K8LHhKHVl7GgzVVmbx9d3BKpg9pq8qshO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078423; c=relaxed/simple;
	bh=aFIWj3cqC8NcatziWVc8C2kC8LNbb5w+GhtCarWn8pk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=guE05f78uYSo9i4EP9+oVhjXlXmfT3W1JfUYcOLk6GxjxkG4I4f0IQsQlmC1qG5Jo4eHsDR3/14AZqJ87Hvq2qGkoWGQd3Kyg2gcVmyzBqtD2YrZ8k54B+nzv2y2Xd1G0eSmVz5/vKdG9zt4X68FfHIlQpNcF5Q0m/lQy5awsnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdFXYp99; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078422; x=1740614422;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=aFIWj3cqC8NcatziWVc8C2kC8LNbb5w+GhtCarWn8pk=;
  b=EdFXYp99ZCEeGzP+QmB10vA2OndVbZlgATf4TSaS5eqcCV6AUNKC5Ca6
   XNoUeZIFV/Yy5bRuaiXl38/bBRdjxedB8i6yPY07EAer4Bc30vGIAaOr+
   HpnHpKWGN2YhCABCCP5VS+faBoKvdyT7gAD981ASFkHxKlpcflpqr5bJN
   Li90cN75HqkIsufvmiT5il86FYtG//1DyxleT+Tdh/smnYgcb9oODagtb
   /krMsAa95lrN/Yh3HkvxtvcaDaA9O95pB5BoLuchURv+pSZLF9Ww2pdmt
   TgKYogJvnDvriU881AMhl7m/ZHIXT0PR5/pDihBumUUBXv9OmCGaeWxIB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14604946"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14604946"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7176945"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:19 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id 10FC0580D7F;
	Tue, 27 Feb 2024 16:00:18 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 9/9] tools: intel_sdsi: Add current meter support
Date: Tue, 27 Feb 2024 16:00:16 -0800
Message-Id: <20240228000016.1685518-10-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228000016.1685518-1-david.e.box@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
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

V2 - Set the name of the file to be opened once.

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 49 ++++++++++++++++----------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index a8fb6d17405f..325e1e41af1d 100644
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
@@ -329,13 +330,14 @@ static void get_feature(uint32_t encoding, char *feature)
 	feature[0] = name[3];
 }
 
-static int sdsi_meter_cert_show(struct sdsi_dev *s)
+static int sdsi_meter_cert_show(struct sdsi_dev *s, bool show_current)
 {
 	char buf[METER_CERT_MAX_SIZE] = {0};
 	struct bundle_encoding_counter *bec;
 	struct meter_certificate *mc;
 	uint32_t count = 0;
 	FILE *cert_ptr;
+	char *cert_fname;
 	int ret, size;
 	char name[4];
 
@@ -345,7 +347,6 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 
 	if (!s->regs.en_features.sdsi) {
 		fprintf(stderr, "SDSi feature is present but not enabled.\n");
-		fprintf(stderr, " Unable to read meter certificate\n");
 		return -1;
 	}
 
@@ -360,15 +361,17 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 		return ret;
 	}
 
-	cert_ptr = fopen("meter_certificate", "r");
+	cert_fname = show_current ? "meter_current" : "meter_certificate";
+	cert_ptr = fopen(cert_fname, "r");
+
 	if (!cert_ptr) {
-		perror("Could not open 'meter_certificate' file");
+		fprintf(stderr, "Could not open '%s' file: %s", cert_fname, strerror(errno));
 		return -1;
 	}
 
 	size = fread(buf, 1, sizeof(buf), cert_ptr);
 	if (!size) {
-		fprintf(stderr, "Could not read 'meter_certificate' file\n");
+		fprintf(stderr, "Could not read '%s' file\n", cert_fname);
 		fclose(cert_ptr);
 		return -1;
 	}
@@ -734,7 +737,7 @@ static void sdsi_free_dev(struct sdsi_dev *s)
 
 static void usage(char *prog)
 {
-	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-m] [-a FILE] [-c FILE]]\n", prog);
+	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-m | -C] [-a FILE] [-c FILE]\n", prog);
 }
 
 static void show_help(void)
@@ -743,8 +746,9 @@ static void show_help(void)
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
@@ -760,21 +764,22 @@ int main(int argc, char *argv[])
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
@@ -790,6 +795,9 @@ int main(int argc, char *argv[])
 		case 'm':
 			command = CMD_METER_CERT;
 			break;
+		case 'C':
+			command = CMD_METER_CURRENT_CERT;
+			break;
 		case 's':
 			command = CMD_STATE_CERT;
 			break;
@@ -828,7 +836,10 @@ int main(int argc, char *argv[])
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


