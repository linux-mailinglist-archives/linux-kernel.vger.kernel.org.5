Return-Path: <linux-kernel+bounces-60583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62E850758
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631C61F23DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE575FF06;
	Sat, 10 Feb 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PrvczPHc"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A54273FE
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609033; cv=none; b=L5I+Ttuip+0L2V6HS4jbayvzYTJHwQBpJ67KVvPnX3pC0pPM6Ue8efYhZ+3+ZiatxBHqahyRf7RUuslYPR+GtZQlywVx+EGcJjDq/ndYh5dccwlIUV3Fdrfj7uIn2zcKn+dl0+YQgwoOQJsadj9/CBA94ID/vcac471GIhgNUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609033; c=relaxed/simple;
	bh=82RfOQuEL0ULs4XSv13KhKeJk1+RHtvCtp8ruNdyAQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CbBjkMDDK/RynELLqYqig5Xbq9Xs6S50+oKZDrK2Sf1U//opPQIAh1hO2B0OBZyhuTrnQb54H3wBqdwWnz6JYTIscONpYGF0fgFFoHaMdrGZNOxS0iCPzi3HF1f7YBshrc6U5pGFTtE84vkMiGJ3cwzkhasM/zQ45H2gBoeDjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PrvczPHc; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so28194691fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609029; x=1708213829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5jyVVrh90QePF6hlIE8n7YfeTi17sNKDqtJeo5NYPV8=;
        b=PrvczPHcuaWgGLTAHIT+2p9hneDn3GkU2BhyHeuYIIWer/Gy1qk0Vf8iv5xr1DozUz
         zRPLCRsTyP6WXQbUtltX9V6Rz4wctgGyMPFaZwD4GiWIYK4vcXsQh5suMSkQ9gOihweW
         CoPey3ZcEMzGs9Mf3utNZe+RDG0o6XOME9lXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609029; x=1708213829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jyVVrh90QePF6hlIE8n7YfeTi17sNKDqtJeo5NYPV8=;
        b=xRQ+NDaAN4aWaPRn4dyR7KffgrQxRY5/jxWwxS1IrPQptQBNmaegKMKd8xpXTg8Ff8
         ON97GjxhVQ7y44F3V/+HXwXZ5/nWYevzCxgPAOQr3DSC+zyU8/v9jJc9FI0Rd9ATAk4/
         1F2e080lkB88uwk7ObWIEhXk5pVPxrxV5ugQtfrK1IbblCpM7SkZ3JQdSLhP1+123feO
         qeKRoFlxxQKZzV5WdDpYpmCdGjWu36wrY83vlJ5SBClKpP2XWLrOJjSZs+qOcmr3VVPH
         80ruCNkvbZE0737/lE0XxvbYu35+rmCj4iTHoAfX4Uufb9OsbSSkkhb73gHij9tRxbqr
         Fa3g==
X-Forwarded-Encrypted: i=1; AJvYcCUXA4AHoKVU06zJ9g9lmAMZk3fMHgWYzZv+xeningKquYlbfqKIhQHdD7qjrh0UohqAe7H0jn0u8FOPtvrtZgBhBmql0nK1/oSyOzuD
X-Gm-Message-State: AOJu0YxMh39gy0maDV7yUxQqIO9PEgBytUXQkYPTWZ+BGAEcPF6A1kz4
	dGUvj1xvLgnheputTu4AQOgCQggO0SjlCJ/00J9FCT1+3zCcrVbe9rFMI4r4
X-Google-Smtp-Source: AGHT+IGhkBY1+RruyeUV2vsZeEjEI7pkKpc1bs5gQ0cb0FtpNehUJ59MsQfe/E15NLD/n98mDPGT4A==
X-Received: by 2002:ac2:4d91:0:b0:511:82f8:d30d with SMTP id g17-20020ac24d91000000b0051182f8d30dmr1855653lfe.32.1707609028546;
        Sat, 10 Feb 2024 15:50:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSHradiuXSf+f9EYFnFeIUEbn3uz2AB/xYdznyDtrbWCL+ZYBuMH3p2bN9VkkcIidPsNb+SfGkwvqvAVJOwpicEKAuIS7Whl4t+kxT3k1FQ7KVC17PvoA1gzSVwUMSQCnz569rcRUwNl1F7Q/0t9OXzDv6B1LLVqOYTUToHGIc6wxGHk9ycbwhPjdxdOffLkoG62JARaou/nV9RHLYlYSKLz8C+dpNl0LvzKa1bt6xMuua4qcCESs5d44HBn1Uqa+gNCB8A4nasU3MzpUELnBZPa2IpxPBED9QPuF1GMF22Vjt3c3wmRxTGIbJaj5+CJfV8sQ96pUTb6WksEJIBbO1ggODDmBo6C3UzNtLfqISZFfRPkq01lTeQ8UNqBm9B43fqptV7grkfmX2YhpOkJAViAM4iCQOFPrNmyHDc7Q9FIfWQqiYgk9lr9yUgwH0gfIVSk0obtMlPC+WhEjvsIaJVMWwC1usP1ZaGVS19SFdXzrKozVF5cCB/XaqEpESbwhTBKhmZ3hNiM70FbACkP7zam6/l74XdA7DqJpL2vjflpOCxcxbQkcG+hPQpTlQFANkDowlLvbf1IXUMgc9Zt25VCP5QmHljV02yTEX8vGL9q0ZSA==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:28 -0800 (PST)
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
Subject: [PATCH v4 00/39] dyndbg: add support for writing debug logs to trace
Date: Sun, 11 Feb 2024 00:49:30 +0100
Message-ID: <20240210235009.2405808-1-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for writing debug logs to trace events and trace instances.
The rationale behing this feature is to be able to redirect debug logs
(per each callsite individually) to trace to aid in debugging. Dynamic
debug has now ability to send pr_debugs to sysfs *and/or* tracefs. Since
tracefs has 2 user groups, dyndbg can write to either:

0. users of trace-events (prdbg and devdbg), in the global: tracing/trace
1. users of trace_array_printk(), writing to private trace
   buffers: in tracing/instances/*

It is presumed that being able to mix existing pr_debugs into your trace,
to add "framing/context/decorations", will prove useful for both kinds
of users.  If nothing else, it lets users apply trace-cmd upon klog and
trace-event activity.

Dynamic Debug can independently direct pr_debugs to both syslog and
tracefs, using the +p, +T flags respectively.  This allows users to
migrate away from syslog in bites, if and as they see a reason.

Dyndbg supports 64-way steering of pr_debugs into tracefs, by labelling
the callsites. You can steer trace traffic for any number of reasons:
- create a flight-recorder buffer.
- isolate hi-rate traffic.
- simplify buffer management and overwrite guarantees.
- assemble "related" sets of prdbgs by labelling them.
- select & enable them later, with "label" keyword.
- just label some traffic as trash/uninteresting (>/dev/null?)
- 63 private buffers are supported + global

Callsites can be labelled, using the ``:<lbl_name>`` trace-label
pseudo-flag, and the following <lbl_name>.  This labels the callsite
with that name, allowing its later selection and enablement using the
"label" keyword.  From boot, the [#default_dest] and all callsite
labels are set to "0".

Labelling Examples:

=T:0     # enable tracing to "0"/global explicitly
=T:0.    # same, dot terminates lbl_name (optional here)
=T:0.mf  # same, but add "module:func:" prefix to msgs (dot required)
=T       # enable tracing to site.label (0 by default)

=T:foo    # set labels to foo [#ifopened]_, send them to tracing/instances/foo
=T:foo.mf # same, with "module:function:" prefix

=_:foo    # clear all flags, set all labels to foo [#ifopened]_
=:foo     # set labels, touch no flags, since no flags are given
=:0       # reset all labels to global trace-buf
=:0.      # same (with optional dot)

Labelling is primarily for mapping into tracing, but is syntactically
separate, and is allowed independently, so the label keyword can be
used to enable to syslog, or to both.

=p:foo    # enable to syslog, p ignores foo
=pT:foo   # trace to instances/foo, and to syslog

The ``:0.`` default label steers output to the global trace-event buf:

ddcmd open 0   # opened by default, also sets [#default_dest]_
ddcmd =:0      # steer pr_debugs to /sys/kernel/tracing/trace
ddcmd =T       # enable pr_debugs to their respective destinations

# also need to enable the events into tracefs
echo 1 > /sys/kernel/tracing/trace_on
echo 1 > /sys/kernel/tracing/events/dyndbg/enable

Or the ``:<name>.`` labels steer +T enabled callsites into
/sys/kernel/tracing/instances/<name> [#ifopened]_

ddcmd open foo       # open or append to /sys/kernel/tracing/instances/foo
ddcmd =:foo          # set labels explicitly
ddcmd =T             # enable tracing to site.label

# needed if appending (above)
echo 1 > /sys/kernel/tracing/instances/foo/trace_on
echo 1 > /sys/kernel/tracing/instances/foo/events/dyndbg/enable

The ``open foo`` & ``close foo`` commands allow dyndbg to manage the
63 private trace-instances it can use simultaneously, so it can error
with -ENOSPC when asked for one-too-many.  Otherwise, [#default_dest]
is upated accordingly.

[#ifopened] It is an error -EINVAL to set a label (=:foo) that hasn't
been previously opened.

[#already_opened] If /sys/kernel/tracing/instances/foo has already
been created separately, then dyndbg just uses it, mixing any =T:foo
labelled pr_debugs into instances/foo/trace.  Otherwise dyndbg will
open the trace-instance, and enable it for you.

Dyndbg treats ``:0.`` as the name of the global trace-event buffer; it
is automatically opened, but needs to be enabled in tracefs too.

``close foo`` insures that no pr_debugs are set to :foo, then unmaps
the label from its reserved trace-id, preserving the trace buffer for
trace-cmd etc.  Otherwise the command returns -EBUSY.

Usage examples

Open "usb" trace instance in <debugfs>/tracing/instances/ by issuing
the command:

localhost ~ # echo "open usb" >
			    <debugfs>/dynamic_debug/control

The open "usb" also sets default destination to the "usb" instance.

To enable writing usbcore module debug logs to the "usb" trace instance
opened above a user can issue the command:

localhost ~ # echo "module usbcore =T:usb" >
			    <debugfs>/dynamic_debug/control

When trace destination is followed by another flag the next flag has to
be preeceded with ".", for example

localhost ~ # echo "module usbcore =T:usb.l" >
			    <debugfs>/dynamic_debug/control

To simplify processing trace destination can be omitted and in such
a case the default destination will be used, for example the command

localhost ~ # echo "module usbcore =Tl" >
			    <debugfs>/dynamic_debug/control

will use default trace destination "usb".

To label all thubderbolt module callsites with the "usb" trace instance
name a user can issue the command

localhost ~ # echo "module thunderbolt =:usb" >
			    <debugfs>/dynamic_debug/control

To enable all "usb" labelled callsites a user can issue the command:

localhost ~ # echo "label usb =T" >
			    <debugfs>/dynamic_debug/control

When "usb" instance is not used anymore by any of the callsites
a user can close it by issuing the command:

localhost ~ # echo "close usb" >
			    <debugfs>/dynamic_debug/control

and then to delete it at a later convenient time after inspecting
the captured debug logs with:

localhost ~ # rmdir <debugfs>/tracing/instances/usb

To enable writing usbcore module debug logs to trace dyndbg:prdbg and
dyndbg:devdbg events user can issue the command:

localhost ~ # echo "module usbcore =T:0" >
			    <debugfs>/dynamic_debug/control

Then dyndbg trace events can be for example captured with the command:

localhost ~ # trace-cmd start -e dyndbg

or

localhost ~ # trace-cmd start -e prdbg,devdbg

The captured debug logs can displayed with the command:

localhost ~ # trace-cmd show

All currently opened trace instances can be shown with the command:

localhost ~ # trace-cmd stat


For full description of the feature and more examples please see
the updated documentation in Documentation/admin-guide/dynamic-debug-howto.rst


Changes:
V4 -> V3
- fix typos in the cover letter decrased -> decreased, make -> makes,
- allow "T:foo." with the trailing dot,
- update the cover-letter to include trace-cmd stat which can be used to show currently opened trace instances,
- change commit subject "dyndbg: add processing of T(race) flag argument" to "dyndbg: handle +T:buf_name.flags grammar",
- squash commit "dyndbg: add skip_spaces_and_coma()" with commit "dyndbg: treat comma as a token separator"
and update function name skip_spaces_and_coma -> skip_spaces_and_comma,
- add dyndbg_selftest.sh script which includes test cases for the verification of dynamic debug functionality (especially addtion of trace support),
- refactor test_private_trace_2, test_private_trace_3 and test_private_trace_4 tests,
- add cleanup function to tests suite which prepares environment for tests execution,
- update handling of trace destination so that it can be provided in the form of "T:t_name" or ":t_name", the former
sets trace destination and enables output to it, the latter sets only trace destination for future use,
- update "add support for default trace destination" to set default trace destination on last sucessfull open command,
- update default trace destination on reopen of already trace instance or on "open 0",
- preserve callsites' trace destinations which differs from '0' for later use with 'label' keyword,
- add static prefix to skip_spaces_and_comma(),
- modify the continue-looping behavior of ddebug_exec_queries to stop processing next queries in a multi command string
when trace open or close command fails,
- add test which verifies default trace destination feature,
- add test which verifies different combinations of flags and trace destination,
- rename cycle_tests_problem() to cycle_not_best_practices(),
- commit "dyndbg: treat comma as a token separator", clarify that it adds new format and still continues to support existing one,
- update check_match_ct() function to enclose pattern to match with spaces, this is required because some matching was too relaxed,
apart from it if -r is passed as $3 then pattern to match is used as is without enclosing it with spaces,
- modify the behavior of the command "ddcmd =:foo" in the commit "dyndbg: update "ddcmd =:foo" behavior" to set (only) the foo label and preserve the flags,
update test_flags test,
- do not display trace destination in /proc/dynamic_debug/control if it is set to default "0" (commit "dyndbg: don't show "0" as it is default"),

V3 -> V2
- squash "dyndbg: export _print_hex_dump" with "dyndbg: add support for hex_dump output to trace",
- squash "dyndbg: tweak pr_info format s/trace dest/trace_dest/"  with "dyndbg: add processing of T(race) flag argument",
- squash "dyndbg: change +T:name_terminator to dot" with "dyndbg: add processing of T(race) flag argument",
- fix setting default trace destination,
- decrease use count when callsite is being disabled as a part of module removal,
- fix parsing of T flag argument,
- update __get_str_strip_nl macro per Steve's comment,
- drop commit "dyndbg: move lock,unlock into ddebug_change, drop goto" and add comment explaining why ddebug_parse_flags
and ddebug_change have to be run in critical section,
- add "depends on TRACING" for "DYNAMIC_DEBUG",
- update DYNAMIC_DEBUG_BRANCH macro which is used when CONFIG_JUMP_LABEL is not set,
- change structure name ddebug_trace_inst to dd_private_tracebuf,
- change structure name ddebug_trace to dd_tracebuf_tbl_info,
- rename is_ddebug_cmd to is_dd_trace_cmd,
- rename validate_tr_name to dd_good_trace_name,
- rename handle_tr_opend_cmd to handle_trace_opend_cmd and handle_tr_close_cmd to handle_trace_close_cmd,
- refactor ddebug_parse_cmd,
- add pr_err when trace_array_get_by_name or trace_array_init_printk fails in trace_array_init_printk,
- add static prefix to show_T_args,
- rename TRACE_DST_MAX to TRACE_DST_LAST and change its value to 64, reserve index 0 for trace events in dd_tracebuf_tbl_info (index 0 will be wasted),
- add "#: " prefix to "Default trace destination" and "Opened trace instances" and print all opened trace instances on the same line,

V2->V1
Major rework after receiving feedback in
https://lore.kernel.org/all/20231103131011.1316396-1-lb@semihalf.com/

This includes among other things:
- addittion of open/close commands,
- use names instead of numbers for trace destinations,
- change prdbg and devdbg trace events to strip newline
on the slow path (read side),
- change prdbg and devdbg trace events to stores actual values
instead of pointers because if a pointer becomes invalid then
the TP_printk call will cause a crash,
- add support for default trace destination.

V1
Major rework after receiving feedback in
https://lore.kernel.org/all/20230915154856.1896062-1-lb@semihalf.com/

Jim Cromie (22):
  dyndbg: add _DPRINTK_FLAGS_ENABLED
  dyndbg: add _DPRINTK_FLAGS_TRACE
  dyndbg: add write events to tracefs code
  dyndbg: add 2 trace-events: prdbg, devdbg
  tracefs: add __get_str_strip_nl
  dyndbg: use __get_str_strip_nl in prdbg and devdbg
  dyndbg: repack _ddebug structure
  dyndbg: add label keyword handling
  dyndbg: fix old BUG_ON in >control parser
  dyndbg: treat comma as a token separator
  dyndbg: split multi-query strings with %
  dyndbg: reduce verbose/debug clutter
  dyndbg: display the bad flag-val in parse-flags err msg
  dyndbg: report err in ddebug_parse_flags when read_args fails
  dyndbg: warn if no flags are given
  dyndbg-test: add tools/testing/selftests/dynamic_debug/*
  dyndbg-test: fixup search-trace-name help
  dyndbg-test: test_private_trace_mixed_class - parameterize modname
  dyndbg-test: add test for label keyword
  docs/dyndbg: update examples \012 to \n
  docs/dyndbg: explain new delimiters: comma, percent
  docs/dyndbg: explain debug-to-tracefs (=T:label.flags)

Łukasz Bartosik (17):
  dyndbg: move flags field to a new structure
  dyndbg: add trace destination field to _ddebug
  dyndbg: add open and close commands for trace
  dyndbg: don't close trace instance when in use
  dyndbg: handle [+T]:buf_name.flags grammar
  dyndbg: add support for default trace destination
  dyndbg: update default trace destination on reopen
  dyndbg: update selection of trace destination
  dyndbg: write debug logs to trace instance
  dyndbg: add support for hex_dump output to trace
  dyndbg: don't process queries when trace cmd fails
  dyndbg: update "ddcmd =:foo" behavior
  dyndbg: don't show default trace destination "0"
  dyndbg-test: refactor test_private_trace_* tests
  dyndbg-test: setup environment for tests execution
  dyndbg-test: add test which verifies flags and dst
  dyndbg-test: add test which verifies default dst

 .../admin-guide/dynamic-debug-howto.rst       | 370 ++++++-
 MAINTAINERS                                   |   2 +
 include/linux/dynamic_debug.h                 |  57 +-
 include/trace/events/dyndbg.h                 |  54 +
 include/trace/stages/stage3_trace_output.h    |  13 +
 lib/Kconfig.debug                             |   2 +
 lib/dynamic_debug.c                           | 829 +++++++++++++--
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   1 +
 .../dynamic_debug/dyndbg_selftest.sh          | 959 ++++++++++++++++++
 10 files changed, 2142 insertions(+), 154 deletions(-)
 create mode 100644 include/trace/events/dyndbg.h
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

-- 
2.43.0.687.g38aa6559b0-goog


