Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9787E6193
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjKIApw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKIApu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:45:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645F492;
        Wed,  8 Nov 2023 16:45:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5CCC433C9;
        Thu,  9 Nov 2023 00:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699490748;
        bh=YRu4R22LiL/XRUCDX6bXCOEEuo4U/vGZY7DHbSLNVwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLSjAiIMn2NBulFrRC52cwjm9YTPQLTE5AU/tlNolhqABeG0kKSss8R4fpWqjGE8U
         Rn1xGX2bmuGIrkAs8XzOPZYAa8I91721ErFqWtfL1pgoCRp3VAu6pfTCjI3yzxAuIA
         XlFVLE0/D0xJ8RbKVh9ech2e8MpnGlQfDnyRMNjVfJVsT1nviFshv1NHjgzalfmQGq
         mK7vkrRBEYs9aQWWQnI8+52pSAvHYp6GLtCdoQk/myAbrGlvKDnxKQlqJgqLomPZtd
         vFZELx41GJIYn6Vlhsn7GUylIPrN3wAl4VMzSMYjRisM3HWZr0B4AbQRhmlcv0c8zs
         bNv88w6VSGAWA==
Date:   Wed, 8 Nov 2023 16:45:45 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] perf: user space sframe unwinding
Message-ID: <20231109004545.panz6kojksxfcjhi@treble>
References: <cover.1699487758.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699487758.git.jpoimboe@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 04:41:05PM -0800, Josh Poimboeuf wrote:
> Some distros have started compiling frame pointers into all their
> packages to enable the kernel to do system-wide profiling of user space.
> Unfortunately that creates a runtime performance penalty across the
> entire system.  Using DWARF (or .eh_frame) instead isn't feasible
> because of complexity and slowness.
> 
> For in-kernel unwinding we solved this problem with the creation of the
> ORC unwinder for x86_64.  Similarly, for user space the GNU assembler
> has created the SFrame ("Simple Frame") format starting with binutils
> 2.40.
> 
> These patches add support for unwinding user space from the kernel using
> SFrame with perf.  It should be easy to add user unwinding support for
> other components like ftrace.
> 
> I tested it on Gentoo by recompiling everything with -Wa,-gsframe and
> using a custom glibc patch (which I'll send in a reply to this email).

Here's my glibc patch:

diff --git a/elf/dl-load.c b/elf/dl-load.c
index 2923b1141d..333d7c39fd 100644
--- a/elf/dl-load.c
+++ b/elf/dl-load.c
@@ -29,6 +29,7 @@
 #include <bits/wordsize.h>
 #include <sys/mman.h>
 #include <sys/param.h>
+#include <sys/prctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <gnu/lib-names.h>
@@ -88,6 +89,10 @@ struct filebuf
 
 #define STRING(x) __STRING (x)
 
+#ifndef PT_GNU_SFRAME
+#define PT_GNU_SFRAME 0x6474e554
+#endif
+
 
 int __stack_prot attribute_hidden attribute_relro
 #if _STACK_GROWS_DOWN && defined PROT_GROWSDOWN
@@ -1213,6 +1218,10 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
 	  l->l_relro_addr = ph->p_vaddr;
 	  l->l_relro_size = ph->p_memsz;
 	  break;
+
+	case PT_GNU_SFRAME:
+	  l->l_sframe_addr = ph->p_vaddr;
+	  break;
 	}
 
     if (__glibc_unlikely (nloadcmds == 0))
@@ -1263,6 +1272,8 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
 	l->l_map_start = l->l_map_end = 0;
 	goto lose;
       }
+
+
   }
 
   if (l->l_ld != 0)
@@ -1376,6 +1387,13 @@ cannot enable executable stack as shared object requires");
 	break;
       }
 
+#define PR_ADD_SFRAME 71
+  if (l->l_sframe_addr != 0)
+  {
+    l->l_sframe_addr += l->l_addr;
+    __prctl(PR_ADD_SFRAME, l->l_sframe_addr, NULL, NULL, NULL);
+  }
+
   /* We are done mapping in the file.  We no longer need the descriptor.  */
   if (__glibc_unlikely (__close_nocancel (fd) != 0))
     {
diff --git a/include/link.h b/include/link.h
index c6af095d87..36ac75680f 100644
--- a/include/link.h
+++ b/include/link.h
@@ -348,6 +348,8 @@ struct link_map
     ElfW(Addr) l_relro_addr;
     size_t l_relro_size;
 
+    ElfW(Addr) l_sframe_addr;
+
     unsigned long long int l_serial;
   };
 
