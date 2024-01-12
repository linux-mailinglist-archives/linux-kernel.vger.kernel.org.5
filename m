Return-Path: <linux-kernel+bounces-24272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D411982BA1A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FBE1F25F32
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1551A1B281;
	Fri, 12 Jan 2024 03:44:57 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8D1B27B;
	Fri, 12 Jan 2024 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TB6pf01FpzNkyp;
	Fri, 12 Jan 2024 11:44:09 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 93C29140555;
	Fri, 12 Jan 2024 11:44:34 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 11:44:33 +0800
From: Yang Jihong <yangjihong1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yangjihong1@huawei.com>
Subject: [PATCH] perf build: Check whether pkg-config is installed when libtraceevent is linked
Date: Fri, 12 Jan 2024 03:40:19 +0000
Message-ID: <20240112034019.3558584-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)

If pkg-config is not installed when libtraceevent is linked, the build fails.

The error information is as follows:

  $ make
  <SNIP>
  In file included from /home/yjh/projects_linux/perf-tool-next/linux/tools/perf/util/evsel.c:43:
  /home/yjh/projects_linux/perf-tool-next/linux/tools/perf/util/trace-event.h:149:62: error: operator '&&' has no right operand
    149 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
        |                                                              ^~
  error: command '/usr/bin/gcc' failed with exit code 1
  cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory
  make[2]: *** [Makefile.perf:668: python/perf.cpython-310-x86_64-linux-gnu.so] Error 1
  make[2]: *** Waiting for unfinished jobs....

Because pkg-config is not installed, fail to get libtraceevent version in
Makefile.config file. As a result, LIBTRACEEVENT_VERSION is empty.
However, the preceding error information is not user-friendly.

Identify errors in advance by checking that pkg-config is installed at
compile time.

The build results of various scenarios are as follows:

1. build successful when libtraceevent is not linked and pkg-config is not installed

  $ pkg-config --version
  -bash: /usr/bin/pkg-config: No such file or directory
  $ make clean >/dev/null
  $ make NO_LIBTRACEEVENT=1 >/dev/null
  Makefile.config:1133: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
    PERF_VERSION = 6.7.rc6.gd988c9f511af
  $ echo $?
  0

2. dummy pkg-config is missing when libtraceevent is linked

  $ pkg-config --version
  -bash: /usr/bin/pkg-config: No such file or directory
  $ make clean >/dev/null
  $ make >/dev/null
  Makefile.config:221: *** Error: pkg-config needed by libtraceevent is missing on this system, please install it.  Stop.
  make[1]: *** [Makefile.perf:251: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2
  $ echo $?
  2

3. build successful when libtraceevent is linked and pkg-config is installed

  $ pkg-config --version
  0.29.2
  $ make clean >/dev/null
  $ make >/dev/null
  Makefile.config:1133: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
    PERF_VERSION = 6.7.rc6.gd988c9f511af
  $ echo $?
  0

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/Makefile.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index aa55850fbc21..70c33c935a98 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -216,6 +216,12 @@ ifeq ($(call get-executable,$(BISON)),)
   dummy := $(error Error: $(BISON) is missing on this system, please install it)
 endif
 
+ifneq ($(NO_LIBTRACEEVENT),1)
+  ifeq ($(call get-executable,$(PKG_CONFIG)),)
+  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
+  endif
+endif
+
 ifneq ($(OUTPUT),)
   ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
     BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
-- 
2.34.1


