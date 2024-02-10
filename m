Return-Path: <linux-kernel+bounces-60622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4485077F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 01:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48F81F29245
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F856518A;
	Sat, 10 Feb 2024 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FCsdXnMQ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA96026D
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609099; cv=none; b=HFp49EWV+m7nahdcvj510Uj0rkPNyWVLTG2/Ak4zL/mlXCrA9zgyFkKN0COM4h68ddt7FdC7YLE5TlCyCeALHHiAmPkKreUhsSY9LkPMAUfw3lIJkaSN2964pnpOCrqwdpWK5zbEtE/JF4y0c+00bj8cZ5hki8x2CGh5wmW4G24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609099; c=relaxed/simple;
	bh=ReWhSS+1izQtXkqlEOSz/2/Fm5ZmohM2FkH09HrD/N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN9+XPPlG3P6kbOJAui5h/1YoqEWamjpFuZLQ5Wiycx3wKPcuKQ940z6fhur9BlVMqadU6rmpw5C5cRhKzs1DODKe0OCuL4qNTSMZYlXVgatrXiz4RWGSvcEYMRNc3FGRxMKF71/VAVO2rc8rxQde8MQyD5zASS+km1cv7r1KZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FCsdXnMQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d073b54359so29834751fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609095; x=1708213895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDLyZQY0Gp7KhBNnuaHo8uCD80YF3Aj4cErAT5jFTkw=;
        b=FCsdXnMQkruigWqTwwnI34yhDSMLm5sEVjgn4psqoBaud/SBiOf1+HHROL3So/+yfv
         Adk95tCY32ibLVp3H75Y381UyrusWexpgmP6X+1kWK1uHwuCUxthZdwIVctjSSzLGS6Z
         5tZtF/Y9D5x8p8hNxnMIHDi6BA2f+kQXwGD5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609095; x=1708213895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDLyZQY0Gp7KhBNnuaHo8uCD80YF3Aj4cErAT5jFTkw=;
        b=pcjiT33LVS/xdKiuRYXmL1Vz7hvibXzzgxCgGPxM4hpa2IirY7A2MEPPWjx8A5tyzi
         Zrug8I1ns+1vQR0tL2Fl+zLIgz/FKz7fu/NpHtyu1u+5AIkHQpE53HhpdCy067567eRE
         Yu2cMl6GwF3febP+wmeOm1Mu1MJ3zeoMLUCxDWonzxnOepxcLLm8L4OaUowiEljxRyPO
         zFQXufpt1ci4svBL2OFF/OPnqAFwdLklflaEAoNanijlyGVo5Zl8ZNXSq9HUGRmMBD73
         E3htGEVMGFdQP98FLWmdg4Hj7tH5TaK+e+1UhlgFM5YFQapd9zE35ZeGW3NuKjrfrxRW
         l1lA==
X-Gm-Message-State: AOJu0YzAmIL0SL60KPhRLRiTKRN85A4dH/lWzeh7DY9BM6LbWBQ0s05l
	/6ghW0DsgYB8F7yU58/+8XAydwOR4ZxDLhvRnG6/e4RQsIHz3TLatWrLJkFK
X-Google-Smtp-Source: AGHT+IFetT6LA2as4CdJTi2zyucAEZ9+MaO/PFI5HGIj+AVSpSBk8RQAQfFz+stqPzyFLlL/c80Vpg==
X-Received: by 2002:ac2:5ecf:0:b0:511:8659:73e4 with SMTP id d15-20020ac25ecf000000b00511865973e4mr939007lfq.8.1707609094898;
        Sat, 10 Feb 2024 15:51:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV05e2q10UG4B8HgNTYcMFSVqYO5DH9XhpkBr4BqrsDpnBr7GQNu0Z0vGObHET6IWiqhmLt2Fa8kBQV9sp/UIvPS1u8v0tfV2sU/8B1iViCfYhk4kH46gHTO5OLWeDmz3zM+d4i837LDVWSRH4ZcmhZtQsq2a3Nc1H5cEYXOPvSnZFGFbSJgBKuuzF6RJhYhbATNCRFIIXkwYT7xxAjNbEiKMOoOvsuaRgYHAzGwBXDRZobNnmmXAVda3PmKAn2W09HX7e3Zksajh2ijTi+V1HfuJ1qO0bygY5ra9WstZp/sYTryTnI5n+SJVaETRH6OSjjtl+lAQfMuC2puATsFSAw7NXTEB5MyN6IS2GlLfJ5wXVhJC0/hL3siJA+PzMdWfWfKb/8jJ9d6Bh6+J43m7T3JeBEENrpomfC+JHHl2xy1+87elkeOuA6plBmg0ykyWyzzz/uUFaMuVpfEU8fail/1udjhYg9YraaVqQpkQF8le3CpfEGKWCMelVFeT9Sy28QMQBPbv5SAz3JN4xSYZQExZWQtndhb0pBbl9UWhgdNNaYqbN6HOI0SqCwuSp5+iPSl3DQ1zR8OEV+ygjX6KKqXP8CTgYpKnxRL28fBpzBfe/WTg==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:34 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>,
	Yaniv Tzoreff <yanivt@google.com>,
	Benson Leung <bleung@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simon Ser <contact@emersion.fr>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@semihalf.com
Subject: [PATCH v4 39/39] docs/dyndbg: explain debug-to-tracefs (=T:label.flags)
Date: Sun, 11 Feb 2024 00:50:09 +0100
Message-ID: <20240210235009.2405808-40-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

Dyndbg can now send pr_debugs to sysfs *and/or* tracefs.
Since tracefs has 2 user groups, dyndbg can write to either:

0. users of existing trace-events, in the global: tracing/trace
1. users of trace_array_printk(),
   writing to private trace buffers: in tracing/instances/*

It is presumed that being able to mix existing pr_debugs into your
trace, to add "framing/context/decorations", will prove useful for
both kinds of users.  If nothing else, it lets users apply trace-cmd
upon klog+trace-event activity.

63 private instances are supported, "0" is the global trace.

These capabilities are exposed via new grammar into >control:

1. T-flag enables pr_debugs to tracefs
   p-flag to syslog is independent.
   by default, +T writes to global buf: /sys/kernel/tracing/trace
   +T:0 is the explicit :<label> form.

2. open <label>, close <label>
   new command connects to tracing/instances/<label>, or creates it.
   the global buf is named "0", its the default destination
   "0" is always open, open 0 always succeeds.
   63  opened tracing/instances/<label>/'s are supported.
   open foo (ok) updates default-dest

3. +:<label>
   all pr_debugs are pre-labelled "0" by default
   once opened, a label can be set for any callsites, like the flags

4. new "label" keyword:
   this lets user select/enable previously labelled pr_debugs.

The change details:

Identify new "label" keyword at the top, where others are summarized.

Describe "label" keyword in the match-spec section, in terms of how it
selects previously labelled callsites.

Rework flags-spec description, tweaking: change-ops, primary/enable
flags, the prefix flags.  Drop extra words where possible.

Add "Basic flag examples:" - a large set of flag-setting examples,
with comments on their effect.  ISTM this is clearer than a rules
description.  This also introduces examples of the new +:<label> flag,
and explains the "0" default.

Add several new sections:
 "Debug output to Syslog and/or Tracefs"
 "open foo & close foo"
 "Labeled Trace Examples"
 "Miscellaneous Notes" with relocated notes.

NOTE: I liberally added [#tags] to try to link concepts (and/or
details) across examples and explanations.  I don't know how they
actually render in sphinx, they read reasonably well as is.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 351 +++++++++++++++---
 1 file changed, 305 insertions(+), 46 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 2d7ee4e558c8..c89ddcfb3f23 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -16,8 +16,8 @@ Dynamic debug provides:
  * a Catalog of all *prdbgs* in your kernel.
    ``cat /proc/dynamic_debug/control`` to see them.
 
- * a Simple query/command language to alter *prdbgs* by selecting on
-   any combination of 0 or 1 of:
+ * a Simple query/command language to alter groups (or singles) of
+   *prdbgs* by selecting on any combination of 0 or 1 of:
 
    - source filename
    - function name
@@ -25,6 +25,7 @@ Dynamic debug provides:
    - module name
    - format string
    - class name (as known/declared by each module)
+   - label name (trace-label, as determined by user)
 
 Viewing Dynamic Debug Behaviour
 ===============================
@@ -81,14 +82,15 @@ by spaces, tabs, or commas.  So these are all equivalent::
   :#> ddcmd file,svcsock.c,line,1603,+p
 
 Command submissions are bounded by a write() system call.  Multiple
-commands can be written together, separated by ``%``, ``;`` or ``\n``::
+commands can be sent together in a CMD_BLK, each separated by ``%``,
+``;`` or ``\n``::
 
   :#> ddcmd func foo +p % func bar +p
-  :#> ddcmd func foo +p \; func bar +p
-  :#> ddcmd <<"EOC"
+  :#> ddcmd "func foo +p ; func bar +p"
+  :#> ddcmd <<CMD_BLK
   func pnpacpi_get_resources +p
   func pnp_assign_mem +p
-  EOC
+  CMD_BLK
   :#> cat query-batch-file > /proc/dynamic_debug/control
 
 You can also use wildcards in each query term. The match rule supports
@@ -97,8 +99,8 @@ character). For example, you can match all usb drivers::
 
   :#> ddcmd file "drivers/usb/*" +p	# "" to suppress shell expansion
 
-Syntactically, a command is pairs of keyword values, followed by a
-flags change or setting::
+Syntactically, a query/command is 0 or more pairs of keyword values,
+followed by a flags change or setting::
 
   command ::= match-spec* flags-spec
 
@@ -106,6 +108,14 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
+non-query commands support connection to tracefs:
+
+  command ::= open <name>
+  command ::= close <name>
+
+Match specification
+===================
+
 A match specification is a keyword, which selects the attribute of
 the callsite to be compared, and a value to compare against.  Possible
 keywords are:::
@@ -115,6 +125,7 @@ keywords are:::
 		 'module' string |
 		 'format' string |
 		 'class' string |
+		 'label' string |
 		 'line' line-range
 
   line-range ::= lineno |
@@ -131,15 +142,15 @@ keywords are:::
 
 The meanings of each keyword are:
 
-func
-    The given string is compared against the function name
-    of each callsite.  Example::
+func <func_name>
+    The func_name is compared against the function name of each
+    callsite.  Example::
 
 	func svc_tcp_accept
 	func *recv*		# in rfcomm, bluetooth, ping, tcp
 
-file
-    The given string is compared against either the src-root relative
+file <file_name>
+    The file_name is compared against either the src-root relative
     pathname, or the basename of the source file of each callsite.
     Examples::
 
@@ -149,11 +160,10 @@ file
 	file inode.c:start_*	# parse :tail as a func (above)
 	file inode.c:1-100	# parse :tail as a line-range (above)
 
-module
-    The given string is compared against the module name
-    of each callsite.  The module name is the string as
-    seen in ``lsmod``, i.e. without the directory or the ``.ko``
-    suffix and with ``-`` changed to ``_``.
+module <mod_name>
+    The mod_name is compared to each callsites mod_name, as seen in
+    ``lsmod``, i.e. without the directory or the ``.ko`` suffix and
+    with ``-`` changed to ``_``.
 
     Examples::
 
@@ -161,7 +171,7 @@ module
 	module nfsd
 	module drm*	# both drm, drm_kms_helper
 
-format
+format <fmtstr>
     The given string is searched for in the dynamic debug format
     string.  Note that the string does not need to match the
     entire format, only some part.  Whitespace and other
@@ -177,17 +187,17 @@ format
 	format "nfsd: SETATTR"  // a neater way to match a format with whitespace
 	format 'nfsd: SETATTR'  // yet another way to match a format with whitespace
 
-class
-    The given class_name is validated against each module, which may
-    have declared a list of known class_names.  If the class_name is
-    found for a module, callsite & class matching and adjustment
-    proceeds.  Examples::
+class <cl_name>
+    The cl_name is validated against each module, which may have
+    declared a list of class_names it knows.  If the cl_name is known
+    by a module, site matching and site flags adjustment proceeds.
+    Examples::
 
 	class DRM_UT_KMS	# a DRM.debug category
 	class JUNK		# silent non-match
-	// class TLD_*		# NOTICE: no wildcard in class names
+	# class TLD_*		# NOTICE: no wildcard in class names
 
-line
+line <ln_spec>
     The given line number or range of line numbers is compared
     against the line number of each ``pr_debug()`` callsite.  A single
     line number matches the callsite line number exactly.  A
@@ -201,33 +211,271 @@ line
 	line -1605          // the 1605 lines from line 1 to line 1605
 	line 1600-          // all lines from line 1600 to the end of the file
 
-The flags specification comprises a change operation followed
-by one or more flag characters.  The change operation is one
-of the characters::
+label <lbl_name>
+    This matches the lbl_name against each callsite's current label
+    (the default is "0").  This allows a user to select and enable a
+    previously labelled set of callsites, after assembling a group label
+    to express the "relatedness" they perceive.
 
-  -    remove the given flags
-  +    add the given flags
-  =    set the flags to the given flags
+Flags Specification
+===================
 
-The flags are::
+The flags-spec is a change operation followed by one or more flag
+characters.  The change operation is one of the characters::
 
-  p    callsite prints to syslog
-  T    callsite issues a dyndbg:* trace-event
-  _    enables no flags
+  -    disable these flags
+  +    enable these flags
+  =    set these flags
 
-  Decorator flags add to the message-prefix, in order:
-  t    Include thread ID, or <intr>
-  m    Include module name
-  f    Include the function name
-  s    Include the source file name
-  l    Include line number
+The primary flags are::
 
-For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
-the ``p`` flag has meaning, other flags are ignored.
+  p    print to syslog
+  T    write to tracefs
+  _    no-flags (allows positive assertion of no-flags)
+  :    trace-label pseudo-flag (see below)
+
+The prefix flags append callsite info to each site's dynamic-prefix,
+in the order shown below, (with '':'' between each).  That is then
+prepended to the pr_debug message, for both sylog and tracefs.
+
+  t    thread ID, or <intr>
+  m    module name
+  f    the function name
+  s    the source file name
+  l    line number
+
+Basic flag examples:
+
+  # because match-spec can be empty, these are legal commands.
+  =p    # output to syslog (on all sites)
+  =T    # output to trace (on all sites)
+  =_    # clear all flags (set them all off)
+  +_    # add no flags [#nochgquery]_
+  -_    # drop no flags [#nochgquery]_
+  +mf   # set "module:function: " prefix
+  +sl   # set "file:line: " prefix
+
+[#nochgquery] these queries alter no flags, they are processed
+normally.
+
+Labelling pr_debug callsites
+============================
+
+Callsites can also be labelled, using the ``:<lbl_name>`` trace-label
+pseudo-flag, and the following <lbl_name>.  This labels the callsite
+with that name, allowing its later selection and enablement using the
+"label" keyword.  From boot, the [#default_dest] and all callsite
+labels are set to "0".
+
+Labelling Examples:
+
+  =T:0     # enable tracing to "0"/global explicitly
+  =T:0.    # same, dot terminates lbl_name (optional here)
+  =T:0.mf  # same, but add "module:func:" prefix to msgs (dot required)
+  =T       # enable tracing to site.label (0 by default)
+
+  =T:foo    # set labels to foo [#ifopened]_, send them to tracing/instances/foo
+  =T:foo.mf # same, with "module:function:" prefix
+
+  =_:foo    # clear all flags, set all labels to foo [#ifopened]_
+  =:foo     # set labels, touch no flags, since no flags are given
+  =:0       # reset all labels to global trace-buf
+  =:0.      # same (with optional dot)
+
+Labelling is primarily for mapping into tracing, but is syntactically
+separate, and is allowed independently, so the label keyword can be
+used to enable to syslog, or to both.
+
+  =p:foo    # enable to syslog, p ignores foo
+  =pT:foo   # trace to instances/foo, and to syslog
+
+Debug output to Syslog and/or Tracefs
+=====================================
+
+Dynamic Debug can independently direct pr_debugs to both syslog and
+tracefs, using the +p, +T flags respectively.  This allows users to
+migrate away from syslog in bites, if and as they see a reason.
+
+Dyndbg supports 64-way steering of pr_debugs into tracefs, by labelling
+the callsites as described above.  You can steer trace traffic for any
+number of reasons:
+
+ - create a flight-recorder buffer.
+ - isolate hi-rate traffic.
+ - simplify buffer management and overwrite guarantees.
+ - assemble "related" sets of prdbgs by labelling them.
+ - select & enable them later, with "label" keyword.
+ - just label some traffic as trash/uninteresting (>/dev/null?)
+ - 63 private buffers are supported + global
+
+The ``:0.`` default label steers output to the global trace-event buf:
+
+   ddcmd open 0   # opened by default, also sets [#default_dest]_
+   ddcmd =:0	  # steer pr_debugs to /sys/kernel/tracing/trace
+   ddcmd =T	  # enable pr_debugs to their respective destinations
+
+   # also need to enable the events into tracefs
+   echo 1 > /sys/kernel/tracing/trace_on
+   echo 1 > /sys/kernel/tracing/events/dyndbg/enable
+
+Or the ``:<name>.`` labels steer +T enabled callsites into
+/sys/kernel/tracing/instances/<name> [#ifopened]_
+
+   ddcmd open foo	# open or append to /sys/kernel/tracing/instances/foo
+   ddcmd =:foo		# set labels explicitly
+   ddcmd =T		# enable tracing to site.label
+
+   # needed if appending (above)
+   echo 1 > /sys/kernel/tracing/instances/foo/trace_on
+   echo 1 > /sys/kernel/tracing/instances/foo/events/dyndbg/enable
+
+open foo & close foo
+====================
+
+The ``open foo`` & ``close foo`` commands allow dyndbg to manage the
+63 private trace-instances it can use simultaneously, so it can error
+with -ENOSPC when asked for one-too-many.  Otherwise, [#default_dest]
+is upated accordingly.
+
+[#ifopened] It is an error -EINVAL to set a label (=:foo) that hasn't
+been previously opened.
+
+[#already_opened] If /sys/kernel/tracing/instances/foo has already
+been created separately, then dyndbg just uses it, mixing any =T:foo
+labelled pr_debugs into instances/foo/trace.  Otherwise dyndbg will
+open the trace-instance, and enable it for you.
+
+Dyndbg treats ``:0.`` as the name of the global trace-event buffer; it
+is automatically opened, but needs to be enabled in tracefs too.
+
+If ``open bar`` fails (if bar was misspelled), the [#last_good_open]
+is not what the user expects, so the open-cmd also terminates the
+play-thru-query-errors strategy normally used over a CMD_BLK of
+query-cmds.
+
+``open 0`` always succeeds.
+
+``close foo`` insures that no pr_debugs are set to :foo, then unmaps
+the label from its reserved trace-id, preserving the trace buffer for
+trace-cmd etc.  Otherwise the command returns -EBUSY.
 
-Note the regexp ``^[-+=][fslmpt_]+$`` matches a flags specification.
-To clear all flags at once, use ``=_`` or ``-fslmpt``.
+Labeled Trace Examples
+======================
 
+Example 1:
+
+Use 2 private trace instances to trivially segregate interesting debug.
+
+  ddcmd open usbcore_buf	# create or share tracing/instances/usbcore_buf
+  ddcmd module usbcore =T	# enable module usbcore to just opened instance
+
+  ddcmd open tbt		# create or share tracing/instances/tbt
+  ddcmd module thunderbolt =T	# enable module thunderbolt to just opened instance
+
+Example 2:
+
+RFC: This is plausible but aggressive conjecture, needs DRM-folk
+review for potential utility.
+
+  echo <<DRM_CMD_BLK > /proc/dynamic_debug/control
+
+    # open 0		# automatically opened anyway
+    open 0		# but also resets [#default_dest]_ to 0
+
+      # send some traffic to global trace, to mix with other events
+
+      class DRM_UT_KMS +T:0	# set label explicitly
+      class DRM_UT_ATOMIC +T	# enable to site.label
+
+    # label 2 classes together (presuming its useful)
+    open drm_bulk	# open instances/drm_bulk/, set [#default_dest]_
+
+      class DRM_UT_CORE +T		# implicit :drm_bulk
+      class DRM_UT_DRIVER +T:drm_bulk	# explicit (but unnecessary)
+
+    # capture DRM screen/layout changes
+    open drm_screens
+      class DRM_UT_LEASE +T	# all implied [#default_dest]_
+      class DRM_UT_DP    +T
+      class DRM_UT_DRMRES +T
+      class DRM_UT_STATE  +T
+
+    # mark traffic to ignore
+    open trash			# will remain empty
+      class junk -T		# cuz we disable the label
+
+    open drm_vblank		# isolate hi-rate traffic
+      class DRM_UT_VBL +T	# use drm_vblank (implicitly)
+
+    # afterthought - add to drm_bulk
+    class DRM_UT_DRIVER +T:drm_bulk	# explicit name needed here
+
+    open 0	# reset [#default_dest]_ for next user
+
+   DRM_CMD_BLK
+
+This example uses +T (not =T) to enable pr_debugs to tracefs.  Doing
+so preserves all other flags, so you can independently use +p for
+syslog, and customize the shared prefix-flags per your personal whim
+(or need), knowing they're not changed later spuriously.
+
+NB: Dyndbg's support for DRM.debug uses ``+p`` & ``-p`` to toggle each
+DRM_UT_* class by name, without altering any prefix customization you
+might favor and apply.
+
+This example also does explicit ``+T:<name>`` labelling more than
+strictly needed, because it also mostly follows a repeating "open then
+label" pattern, and could rely upon [#last_good_open] being set.  The
+afterthought provides a counter-example.
+
+Trash is handled by labelling and disabling certain traffic, so it is
+never collected.  This will waste a trace instance, but it will stay
+empty.
+
+The extra ``open 0`` commands at the start & end of the DRM_CMD_BLK
+explicitly reset the [#last_good_open], since ``open 0`` never fails.
+This defensive practice prevents surprises when the next user expects
+the "0" default (reasonably!) which enables to the global trace-buf.
+
+Example 3: labelling 1st, deferred enable.
+
+If the DRM_CMD_BLK above had replaced ``+T`` with ``-T``, then the
+selected sites would get their labels set, but the trace-enable flag
+is unset, and they are all trace-disabled.
+
+This style lets a user aggregate an arbitrary set of "related"
+pr_debugs.  Then those labels can be later selected and enabled
+together:
+
+  ddcmd label drm_screens +T	# enable tracing on the user's label
+  ddcmd label drm_bulk +p	# works for syslog too
+
+RFC:
+
+Its practical to not require the open-1st if the trace instance
+already exists, but auto-open of misspelled names would be an
+anti-feature.
+
+Also, without ``open foo`` required, theres no [#last_good_open], and
+[#default_dest] must be set by explicit labelling at least once before
+using [#default_dest] in following query-cmds.
+
+Example 4:
+
+This example opens interesting instances/labels 1st (perhaps at boot),
+then labels several modules, and enables their pr_debugs to the
+labelled trace-instances.
+
+  echo <<ALT_BLK_STYLE > /proc/dynamic_debug/control
+    open x;             # set [#default_dest]_ to x
+    open y;             # set [#default_dest]_ to y
+    open z              # set [#default_dest]_ to z
+    module X  +T:z
+    module X1 +T	# :z, use [#default_dest]_ implicitly
+    module Y  +T:y
+    module Z  +T:z
+    module Z1 +T	# :z, use [#default_dest]_ implicitly
+  ALT_BLK_STYLE
 
 Debug messages during Boot Process
 ==================================
@@ -343,6 +591,8 @@ Examples
     dyndbg="file init/* +p #cmt ; func parse_one +p"
     // enable pr_debugs in 2 functions in a module loaded later
     pc87360.dyndbg="func pc87360_init_device +p; func pc87360_find +p"
+    // open private tracing/instances/foo,bar
+    dyndbg=open,foo%open,bar
 
 Kernel Configuration
 ====================
@@ -375,6 +625,15 @@ Otherwise, they are off by default; ``ccflags += -DDEBUG`` or
 If ``CONFIG_DYNAMIC_DEBUG`` is not set, ``print_hex_dump_debug()`` is
 just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
 
+Miscellaneous Notes
+===================
+
 For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
 its ``prefix_str`` argument, if it is constant string; or ``hexdump``
 in case ``prefix_str`` is built dynamically.
+
+For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
+the ``p`` and ``T`` flags have meaning, other flags are ignored.
+
+pr_fmt displays after the dynamic-prefix.
+
-- 
2.43.0.687.g38aa6559b0-goog


