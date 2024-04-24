Return-Path: <linux-kernel+bounces-156052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 487E58AFD39
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF66B24152
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545C4A23;
	Wed, 24 Apr 2024 00:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOqzAWEf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DDE3D68;
	Wed, 24 Apr 2024 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713917552; cv=none; b=NunQ9t4fJmlgiiecpHwrNY+XblmqBihFXVWnGavooPzwjlAKXRjezZlvxC2y7k3yMAAENGCxtoR8yPm6uFlISzXThF/TIDrGuVAzl5SqYBzy9dTJeqcQSV9hUYRplxf6I9j8KkOVL4fl4xttAc/ujNKIZhfhr1KyprS0zkPdHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713917552; c=relaxed/simple;
	bh=eBnFOgZH6lzpyVEaHACstUFnWetL3HCIbdh7soHcVqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKecOAnGfEF+lsCsLdUeVMS5lp1If8313w/kb7xvecS2l3SnYzZdoXunCn8rEWCozUk7wFkG1Nu8+3pVSOvyNjWW7bKFlUf+EjZhusxpEEMB4ozv/ln5BpH8/ZfJskbB0soQT8bhuQuxxyRpJtttFfMuypVwnJ/FxqyjKFmgiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOqzAWEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21B3C116B1;
	Wed, 24 Apr 2024 00:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713917552;
	bh=eBnFOgZH6lzpyVEaHACstUFnWetL3HCIbdh7soHcVqs=;
	h=From:To:Cc:Subject:Date:From;
	b=WOqzAWEfp2w8qvvi0u0BsDNcAStGeA1LOJq4Cx7g8u2v+wHrpBwih3+Wq77yBCkBi
	 8RW9BS32oho2U7dA0FpH9iu7KWSTLtO54adc4ZPVtul0i43+yiyI/MelUy/m8CYpHn
	 9pWQ/1TTM5fy4/HFEqizhHQBBZ4qQTe94Zw0eEoZvE5znjJ2HTkvP4hb67sbfjTBf1
	 DYubQ8Q0a0m6tDot54QcvkM4of4cFDWRpCvWDhafQF9LbklJ8+WQhJqL1FPOKxNJHZ
	 k9Idm6fZVxTJ20Hrz3Ycuw98HlzfctESOH1NOszaN4Qzkj93BOSVDKBDD7i7UQ7rHW
	 VdVvC/wO+OpkQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf test: Add a new test for perf annotate
Date: Tue, 23 Apr 2024 17:12:31 -0700
Message-ID: <20240424001231.849972-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a basic perf annotate test

  $ ./perf test annotate -vv
   76: perf annotate basic tests:
  --- start ---
  test child forked, pid 846989
   fbcd0-fbd55 l noploop
  perf does have symbol 'noploop'
  Basic perf annotate test
           : 0     0xfbcd0 <noploop>:
      0.00 :   fbcd0:       pushq   %rbp
      0.00 :   fbcd1:       movq    %rsp, %rbp
      0.00 :   fbcd4:       pushq   %r12
      0.00 :   fbcd6:       pushq   %rbx
      0.00 :   fbcd7:       movl    $1, %ebx
      0.00 :   fbcdc:       subq    $0x10, %rsp
      0.00 :   fbce0:       movq    %fs:0x28, %rax
      0.00 :   fbce9:       movq    %rax, -0x18(%rbp)
      0.00 :   fbced:       xorl    %eax, %eax
      0.00 :   fbcef:       testl   %edi, %edi
      0.00 :   fbcf1:       jle     0xfbd04
      0.00 :   fbcf3:       movq    (%rsi), %rdi
      0.00 :   fbcf6:       movl    $0xa, %edx
      0.00 :   fbcfb:       xorl    %esi, %esi
      0.00 :   fbcfd:       callq   0x41920
      0.00 :   fbd02:       movl    %eax, %ebx
      0.00 :   fbd04:       leaq    -0x7b(%rip), %r12	# fbc90 <sighandler>
      0.00 :   fbd0b:       movl    $2, %edi
      0.00 :   fbd10:       movq    %r12, %rsi
      0.00 :   fbd13:       callq   0x40a00
      0.00 :   fbd18:       movl    $0xe, %edi
      0.00 :   fbd1d:       movq    %r12, %rsi
      0.00 :   fbd20:       callq   0x40a00
      0.00 :   fbd25:       movl    %ebx, %edi
      0.00 :   fbd27:       callq   0x407c0
      0.10 :   fbd2c:       movl    0x89785e(%rip), %eax	# 993590 <done>
      0.00 :   fbd32:       testl   %eax, %eax
     99.90 :   fbd34:       je      0xfbd2c
      0.00 :   fbd36:       movq    -0x18(%rbp), %rax
      0.00 :   fbd3a:       subq    %fs:0x28, %rax
      0.00 :   fbd43:       jne     0xfbd50
      0.00 :   fbd45:       addq    $0x10, %rsp
      0.00 :   fbd49:       xorl    %eax, %eax
      0.00 :   fbd4b:       popq    %rbx
      0.00 :   fbd4c:       popq    %r12
      0.00 :   fbd4e:       popq    %rbp
      0.00 :   fbd4f:       retq
      0.00 :   fbd50:       callq   0x407e0
      0.00 :   fbcd0:       pushq   %rbp
      0.00 :   fbcd1:       movq    %rsp, %rbp
      0.00 :   fbcd4:       pushq   %r12
      0.00 :   fbcd0:  push   %rbp
      0.00 :   fbcd1:  mov    %rsp,%rbp
      0.00 :   fbcd4:  push   %r12
  Basic annotate test [Success]
  ---- end(0) ----
   76: perf annotate basic tests                                       : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/annotate.sh | 83 ++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100755 tools/perf/tests/shell/annotate.sh

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
new file mode 100755
index 000000000000..7820d13eebae
--- /dev/null
+++ b/tools/perf/tests/shell/annotate.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+# perf annotate basic tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+shelldir=$(dirname "$0")
+
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
+testsym="noploop"
+
+skip_test_missing_symbol ${testsym}
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+testprog="perf test -w noploop"
+# disassembly format: "percent : offset: instruction (operands ...)"
+disasm_regex="[0-9]*\.[0-9]* *: *\w*: *\w*"
+
+cleanup() {
+  rm -rf "${perfdata}"
+  rm -rf "${perfdata}".old
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_basic() {
+  echo "Basic perf annotate test"
+  if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
+  then
+    echo "Basic annotate [Failed record]"
+    err=1
+    return
+  fi
+
+  # check if it has the target symbol
+  if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${testsym}"
+  then
+    echo "Basic annotate [Failed missing symbol]"
+    err=1
+    return
+  fi
+
+  # check if it has the disassembly lines
+  if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${disasm_regex}"
+  then
+    echo "Basic annotate [Failed missing disasm output]"
+    err=1
+    return
+  fi
+
+  # check again with a target symbol name
+  if ! perf annotate -i "${perfdata}" "${testsym}" 2> /dev/null | \
+	  grep -m 3 "${disasm_regex}"
+  then
+    echo "Basic annotate [Failed missing disasm output]"
+    err=1
+    return
+  fi
+
+  # check one more with external objdump tool (forced by --objdump option)
+  if ! perf annotate -i "${perfdata}" --objdump=objdump 2> /dev/null | \
+	  grep -m 3 "${disasm_regex}"
+  then
+    echo "Basic annotate [Failed missing disasm output from objdump]"
+    err=1
+    return
+  fi
+  echo "Basic annotate test [Success]"
+}
+
+test_basic
+
+cleanup
+exit $err
-- 
2.44.0.769.g3c40516874-goog


