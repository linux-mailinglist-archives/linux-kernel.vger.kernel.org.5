Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3257874E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbjHXQJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242402AbjHXQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:09:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D80119A9;
        Thu, 24 Aug 2023 09:09:18 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id A13582127C67;
        Thu, 24 Aug 2023 09:09:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A13582127C67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692893357;
        bh=SwodwWqZOmu7Po/FHd/TR7wIuk8vbUpBuX1785tzl4c=;
        h=From:To:Cc:Subject:Date:From;
        b=JFdLoKizaOS2q/zabgqy37/wlQ1PFIV6VwWs53i/ttwICYyaBQlMqCXNEtVf3et+O
         IA2ssvo5aLaLYMeMC0t2P8A2vcNLZ8M+h4hfAdvXbVa5f9mr6gBfrXO7Fcqc22Yv0o
         BVmKUnSkD2bWT8M0CKmRXhhiVuHp8zsT333qotlA=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: [PATCH v3 0/1] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date:   Thu, 24 Aug 2023 18:08:58 +0200
Message-Id: <20230824160859.66113-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


In the kernel source code, it exists different functions which share the same
name but which have, of course, different addresses as they can be defined in
different modules:
# Kernel was compiled with CONFIG_NTFS_FS and CONFIG_NTFS3_FS as built-in.
root@vm-amd64:~# grep ntfs_file_write_iter /proc/kallsyms
ffffffff814ce3c0 t __pfx_ntfs_file_write_iter
ffffffff814ce3d0 t ntfs_file_write_iter
ffffffff814fc8a0 t __pfx_ntfs_file_write_iter
ffffffff814fc8b0 t ntfs_file_write_iter
This can be source of troubles when you create a PMU kprobe for such a function,
as it will only install one for the first address (e.g. 0xffffffff814ce3d0 in
the above).
This could lead to some troubles were BPF based tools does not report any event
because the second function is not called:
root@vm-amd64:/mnt# mount | grep /mnt
/foo.img on /mnt type ntfs3 (rw,relatime,uid=0,gid=0,iocharset=utf8)
# ig is a tool which installs a PMU kprobe on ntfs_file_write_iter().
root@vm-amd64:/mnt# ig trace fsslower -m 0 -f ntfs3 --host &> /tmp/foo &
[1] 207
root@vm-amd64:/mnt# dd if=./foo of=./bar count=3
3+0 records in
3+0 records out
1536 bytes (1.5 kB, 1.5 KiB) copied, 0.00543323 s, 283 kB/s
root@vm-amd64:/mnt# fg
ig trace fsslower -m 0 -f ntfs3 --host &> /tmp/foo
^Croot@vm-amd64:/mnt# more /tmp/foo
RUNTIME.CONTAINERNAME          RUNTIME.CONTAIN… PID              COMM
  T      BYTES     OFFSET        LAT FILE
                                                214              dd
  R        512          0        766 foo
                                                214              dd
  R        512        512          9 foo
                                                214              dd
As you can see in the above, only read events are reported and no write because
the kprobe is installed for the old ntfs_file_write_iter() and not the ntfs3
one.
The same behavior occurs with sysfs kprobe:
root@vm-amd64:/# echo 'p:probe/ntfs_file_write_iter ntfs_file_write_iter' > /sys/kernel/tracing/kprobe_events
root@vm-amd64:/# cat /sys/kernel/tracing/kprobe_events
p:probe/ntfs_file_write_iter ntfs_file_write_iter
root@vm-amd64:/# mount | grep /mnt
/foo.img on /mnt type ntfs3 (rw,relatime,uid=0,gid=0,iocharset=utf8)
root@vm-amd64:/# perf record -e probe:ntfs_file_write_iter &
[1] 210
root@vm-amd64:/# cd /mnt/
root@vm-amd64:/mnt# dd if=./foo of=./bar count=3
3+0 records in
3+0 records out
1536 bytes (1.5 kB, 1.5 KiB) copied, 0.00234793 s, 654 kB/s
root@vm-amd64:/mnt# cd -
/
root@vm-amd64:/# fg
perf record -e probe:ntfs_file_write_iter
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.056 MB perf.data ]

root@vm-amd64:/# perf report
Error:
The perf.data data has no samples!
# To display the perf.data header info, please use --header/--header-only optio>
#

In this contribution, I modified the functions creating sysfs and PMU kprobes to
test if the function name given as argument matches several symbols.
In this case, these functions return EADDRNOTAVAIL to indicate the user to use
addr and offs to remove this ambiguity.
So, when the above BPF tool is run, the following error message is printed:
root@vm-amd64:~# ig trace fsslower -m 0 -f ntfs3 --host &> /tmp/foo &
[1] 228
root@vm-amd64:~# more /tmp/foo
RUNTIME.CONTAINERNAME          RUNTIME.CONTAIN… PID              COMM
  T      BYTES     OFFSET        LAT FILE
Error: running gadget: running gadget: installing tracer: attaching kprobe: crea
ting perf_kprobe PMU (arch-specific fallback for "ntfs_file_write_iter"): token
ntfs_file_write_iter: opening perf event: cannot assign requested address
And the same with sysfs kprobe:
root@vm-amd64:/# echo 'p:probe/ntfs_file_write_iter ntfs_file_write_iter' > /sys/kernel/tracing/kprobe_events
-bash: echo: write error: Cannot assign requested address
Note that, this does not influence perf as it installs kprobes as offset on
_text:
root@vm-amd64:/# perf probe --add ntfs_file_write_iter
Added new events:
  probe:ntfs_file_write_iter (on ntfs_file_write_iter)
  probe:ntfs_file_write_iter (on ntfs_file_write_iter)
...
root@vm-amd64:/# cat /sys/kernel/tracing/kprobe_events
p:probe/ntfs_file_write_iter _text+5039088
p:probe/ntfs_file_write_iter _text+5228752

Note that, this contribution is the conclusion of a previous RFC which intended
to install a PMU kprobe for all matching symbols [1, 2].

If you see any way to improve this contribution, particularly if you have an
idea to add tests or documentation for this behavior, please share your
feedback.

Changes since:
 v1:
  * Use EADDRNOTAVAIL instead of adding a new error code.
  * Correct also this behavior for sysfs kprobe.
 v2:
  * Count the number of symbols corresponding to function name and return
  EADDRNOTAVAIL if higher than 1.
  * Return ENOENT if above count is 0, as it would be returned later by while
  registering the kprobe.

Francis Laniel (1):
  tracing/kprobes: Return EADDRNOTAVAIL when func matches several
    symbols

 kernel/trace/trace_kprobe.c | 61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)


Best regards and thank you in advance.
---
[1]: https://lore.kernel.org/lkml/20230816163517.112518-1-flaniel@linux.microsoft.com/
[2]: https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kernel.org/
--
2.34.1

