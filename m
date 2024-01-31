Return-Path: <linux-kernel+bounces-47012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46FB8447EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A6B1C21FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7AA3AC24;
	Wed, 31 Jan 2024 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QK4rhbG/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3633610A;
	Wed, 31 Jan 2024 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729075; cv=none; b=t2bD7clOuO2ZAy09jpgUOJdn7XyMuSaob/7ogoRwOHAJNvx4Gv0RXpJcVbTUGBnoAz8pZGdRkGOHmHtPEyMpZKHnAMs6W8D27O6NQ+Y8ZKq2HC0aYfJLK24+mdHlwUKkLqi5FFUEkuP9J8COhD4QReooVvuOXnbuFMXvzqASg20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729075; c=relaxed/simple;
	bh=T8MDEuGVKv/mgfa9CO6cBEqeOvKSrL1fjA0wmbjS61A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a4mT32vJR0b91kVIfB1t0nLSiEx8PSRsozsa/S6CPe0TcRDQbuKiB0M/PooaCKskTTgEQnHEnMsbSNCE+GudkFJwTWFJDJULcYO0zSIrrEwziYQ0BUlth7BmS5rugZPQ+J7GF94Qgjle6157OEr1hmNQlBQecItt0HMx8Y2jR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QK4rhbG/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706729074; x=1738265074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T8MDEuGVKv/mgfa9CO6cBEqeOvKSrL1fjA0wmbjS61A=;
  b=QK4rhbG/vLXfdUU0iUVa1lthr4DQgqJh2KvRplk0d6hTXSbBM5ARm+a8
   +qftyjtI4Q3oIkwWw9R13B8890BIweCgsESRrwVsiL4YQ6gIeZl/tVgOC
   5UhQU+Qh2e+nBvQE+sA/CUn8v5gVdUi2rHqxnUbPtCmNlJ5p5AXqC0hCY
   B32FHQUzrQalC5H+ZSueJNyzJFbQJrK6Vz+DXqz68So6iimGJC7hQm9m1
   Q0O5sw+maEkn/WGwg0Nc/mLy58MHWZc8cyqLR8cspWuC092UDBtPBEyiS
   PbuR+wv+DSv62UZKD383V9PpKvyUfJ80ssS2+zeLOmFVrr2/qPNPNTcMY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3562151"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="3562151"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 11:24:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4269805"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.217.93])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 11:24:30 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf test: Enable Symbols test to work with a current module dso
Date: Wed, 31 Jan 2024 21:24:16 +0200
Message-Id: <20240131192416.16387-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

The test needs a struct machine and creates one for the current host,
but a side-effect is that struct machine has set up kernel maps
including module maps.

If the 'Symbols' test --dso option specifies a current kernel module,
it will already be present as a kernel dso, and a map with kmaps needs
to be used otherwise there will be a segfault - see below.

For that case, find the existing map and use that. In that case also,
the dso is split by section into multiple dsos, so test those dsos
also. That in turn, shows up that those dsos have not had overlapping
symbols removed, so the test fails.

Example:

  Before:

    $ perf test -F -v Symbols --dso /lib/modules/$(uname -r)/kernel/arch/x86/kvm/kvm-intel.ko
     70: Symbols                                                         :
    --- start ---
    Testing /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko
    Segmentation fault (core dumped)

  After:

    $ perf test -F -v Symbols --dso /lib/modules/$(uname -r)/kernel/arch/x86/kvm/kvm-intel.ko
     70: Symbols                                                         :
    --- start ---
    Testing /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko
    Overlapping symbols:
     41d30-41fbb l vmx_init
     41d30-41fbb g init_module
    ---- end ----
    Symbols: FAILED!

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/symbols.c | 68 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 16e1c5502b09..2fed6d67f50f 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -41,6 +41,30 @@ static void exit_test_info(struct test_info *ti)
 	machine__delete(ti->machine);
 }
 
+struct dso_map {
+	struct dso *dso;
+	struct map *map;
+};
+
+static int find_map_cb(struct map *map, void *d)
+{
+	struct dso_map *data = d;
+
+	if (map__dso(map) != data->dso)
+		return 0;
+	data->map = map;
+	return 1;
+}
+
+static struct map *find_module_map(struct machine *machine, struct dso *dso)
+{
+	struct dso_map data = { .dso = dso };
+
+	machine__for_each_kernel_map(machine, find_map_cb, &data);
+
+	return data.map;
+}
+
 static void get_test_dso_filename(char *filename, size_t max_sz)
 {
 	if (dso_to_test)
@@ -51,6 +75,26 @@ static void get_test_dso_filename(char *filename, size_t max_sz)
 
 static int create_map(struct test_info *ti, char *filename, struct map **map_p)
 {
+	struct dso *dso = machine__findnew_dso(ti->machine, filename);
+
+	/*
+	 * If 'filename' matches a current kernel module, must use a kernel
+	 * map. Find the one that already exists.
+	 */
+	if (dso && dso->kernel) {
+		*map_p = find_module_map(ti->machine, dso);
+		dso__put(dso);
+		if (!*map_p) {
+			pr_debug("Failed to find map for curent kernel module %s",
+				 filename);
+			return TEST_FAIL;
+		}
+		map__get(*map_p);
+		return TEST_OK;
+	}
+
+	dso__put(dso);
+
 	/* Create a dummy map at 0x100000 */
 	*map_p = map__new(ti->machine, 0x100000, 0xffffffff, 0, NULL,
 			  PROT_EXEC, 0, NULL, filename, ti->thread);
@@ -97,6 +141,26 @@ static int test_dso(struct dso *dso)
 	return ret;
 }
 
+static int subdivided_dso_cb(struct dso *dso, struct machine *machine __maybe_unused, void *d)
+{
+	struct dso *text_dso = d;
+
+	if (dso != text_dso && strstarts(dso->short_name, text_dso->short_name))
+		if (test_dso(dso) != TEST_OK)
+			return -1;
+
+	return 0;
+}
+
+static int process_subdivided_dso(struct machine *machine, struct dso *dso)
+{
+	int ret;
+
+	ret = machine__for_each_dso(machine, subdivided_dso_cb, dso);
+
+	return ret < 0 ? TEST_FAIL : TEST_OK;
+}
+
 static int test_file(struct test_info *ti, char *filename)
 {
 	struct map *map = NULL;
@@ -124,6 +188,10 @@ static int test_file(struct test_info *ti, char *filename)
 	}
 
 	ret = test_dso(dso);
+
+	/* Module dso is split into many dsos by section */
+	if (ret == TEST_OK && dso->kernel)
+		ret = process_subdivided_dso(ti->machine, dso);
 out_put:
 	map__put(map);
 
-- 
2.34.1


