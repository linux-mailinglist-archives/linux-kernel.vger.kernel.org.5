Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC1777E685
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbjHPQf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344751AbjHPQfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:35:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 419ED199B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:35:40 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id F22DD211F60F;
        Wed, 16 Aug 2023 09:35:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F22DD211F60F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692203739;
        bh=hDfklMh8aJUtPeiHwukPAsHMKsB2N0lXxyDkBf0zYIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kVCPywVMpkZYPlzwqset20n3P8q0NwKWkGtMq9RpyS8MWfqNTn3yO6WDBgHYfR7Hj
         q58e6XTr+qfS3ubjTjpvdsP/JLUsrhimdLvNu6/R0i0WPcKb/3+Jiki5erUYKJAXkD
         RMLaAlc5SAzjJvsYQV57OuEFtB3B3OnPi+Nnnb60=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Francis Laniel <flaniel@linux.microsoft.com>
Subject: [RFC PATCH v1 0/1] tracing/kprobe: Add multi-probe support for 'perf_kprobe' PMU
Date:   Wed, 16 Aug 2023 18:35:16 +0200
Message-Id: <20230816163517.112518-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
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
different modules.
This is, for example, the case with ntfs_file_write_iter() which exists both in
the "old" NTFS module and in the "new" NTFS3 module.
When you create a perf_kprobe PMU for such a function, it will only be created
for the first one (i.e. the one with the lowest address):
root@vm-amd64:~# grep ntfs_file_write_iter /proc/kallsyms
ffffffff814c5c20 t __pfx_ntfs_file_write_iter
ffffffff814c5c30 t ntfs_file_write_iter
ffffffff814f41f0 t __pfx_ntfs_file_write_iter
ffffffff814f4200 t ntfs_file_write_iter
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
As you can see, only read events are reported and not the open and write ones.

So, with this contribution, I added multi-probe support for perf_kprobe PMU.
The idea is to create a trace_kprobe for each address which correspond to the
given symbol.
All these different trace_kprobe will be linked together by sharing the same
trace_probe.
As a consequence, all these trace_kprobes are registered and the above problem
is solved:
root@vm-amd64:/mnt# ig trace fsslower -m 0 -f ntfs3 --host &> /tmp/foo &
[1] 210
root@vm-amd64:/mnt# dd if=./foo of=./bar count=3
3+0 records in
3+0 records out
1536 bytes (1.5 kB, 1.5 KiB) copied, 0.00624642 s, 246 kB/s
root@vm-amd64:/mnt# fg
ig trace fsslower -m 0 -f ntfs3 --host &> /tmp/foo
^C
root@vm-amd64:/mnt# more /tmp/foo
RUNTIME.CONTAINERNAME          RUNTIME.CONTAIN… PID              COMM
  T      BYTES     OFFSET        LAT FILE
                                                217              dd
  O          0          0          8 foo
                                                217              dd
  O          0          0          6 bar
                                                217              dd
  R        512          0       1064 foo
                                                217              dd
  W        512          0        267 bar
                                                217              dd
  R        512        512          8 foo
                                                217              dd
  W        512        512        238 bar
                                                217              dd
  R        512       1024          6 foo
                                                217              dd
  W        512       1024          8 bar
Note that, we also get the open events as ntfs_file is also defined twice.

I marked this contribution as RFC as I first would like to get your opinion on
it.
Moreover, as I am not a kprobe expert, this is possible that I made mistake (I
am not really sure if all the trace_kprobes linked with append_trace_kprobe()
are freed together).
So, if you see any way to improve this contribution, feel free to share.

Francis Laniel (1):
  tracing/kprobe: Add multi-probe support for 'perf_kprobe' PMU

 kernel/trace/trace_kprobe.c | 86 +++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)


Best regards and thank you in advance.
--
2.34.1

