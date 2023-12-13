Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61E18109AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 06:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjLMF56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 00:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjLMF55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 00:57:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C656DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 21:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702447081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RUoeFpzGOqKTN9flZH6s2xBw5Pk9zJr+cPefMlD1aKs=;
        b=Pys9pTyedstXNDELxN7U13Gf0KRInxaZjiSBbfKSYzXDRXv7239ulYdn3XFb1lHmtHfOQD
        gW+ie3D/KfECfstQsQAPFIIxume2keAk+foPwlYI4tPTMmeFD50rK2IW3zK5kec71eja5I
        4v/G/NP/fR9jt7QCb18xEh9oe6n+a2k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-WAbzVqSrMWOIel7uGGUcPw-1; Wed, 13 Dec 2023 00:57:56 -0500
X-MC-Unique: WAbzVqSrMWOIel7uGGUcPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39171185A783;
        Wed, 13 Dec 2023 05:57:56 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24DE41C060AF;
        Wed, 13 Dec 2023 05:57:50 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
        joe@perches.com, nathan@kernel.org, conor@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 0/7] kexec_file: print out debugging message if required
Date:   Wed, 13 Dec 2023 13:57:40 +0800
Message-ID: <20231213055747.61826-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, specifying '-d' on kexec command will print a lot of debugging
informationabout kexec/kdump loading with kexec_load interface.

However, kexec_file_load prints nothing even though '-d' is specified.
It's very inconvenient to debug or analyze the kexec/kdump loading when
something wrong happened with kexec/kdump itself or develper want to
check the kexec/kdump loading.

In this patchset, a kexec_file flag is KEXEC_FILE_DEBUG added and checked
in code. If it's passed in, debugging message of kexec_file code will be
printed out and can be seen from console and dmesg. Otherwise, the
debugging message is printed like beofre when pr_debug() is taken.

Note:
****
=====
1) The code in kexec-tools utility also need be changed to support
passing KEXEC_FILE_DEBUG to kernel when 'kexec -s -d' is specified.
The patch link is here:
=========
[PATCH] kexec_file: add kexec_file flag to support debug printing
http://lists.infradead.org/pipermail/kexec/2023-November/028505.html

2) s390 also has kexec_file code, while I am not sure what debugging
information is necessary. So leave it to s390 developer.

Test:
****
====
Testing was done in v1 on x86_64 and arm64. For v4, tested on x86_64
again. And on x86_64, the printed messages look like below:
--------------------------------------------------------------
kexec measurement buffer for the loaded kernel at 0x207fffe000.
Loaded purgatory at 0x207fff9000
Loaded boot_param, command line and misc at 0x207fff3000 bufsz=0x1180 memsz=0x1180
Loaded 64bit kernel at 0x207c000000 bufsz=0xc88200 memsz=0x3c4a000
Loaded initrd at 0x2079e79000 bufsz=0x2186280 memsz=0x2186280
Final command line is: root=/dev/mapper/fedora_intel--knightslanding--lb--02-root ro
rd.lvm.lv=fedora_intel-knightslanding-lb-02/root console=ttyS0,115200N81 crashkernel=256M
E820 memmap:
0000000000000000-000000000009a3ff (1)
000000000009a400-000000000009ffff (2)
00000000000e0000-00000000000fffff (2)
0000000000100000-000000006ff83fff (1)
000000006ff84000-000000007ac50fff (2)
......
000000207fff6150-000000207fff615f (128)
000000207fff6160-000000207fff714f (1)
000000207fff7150-000000207fff715f (128)
000000207fff7160-000000207fff814f (1)
000000207fff8150-000000207fff815f (128)
000000207fff8160-000000207fffffff (1)
nr_segments = 5
segment[0]: buf=0x000000004e5ece74 bufsz=0x211 mem=0x207fffe000 memsz=0x1000
segment[1]: buf=0x000000009e871498 bufsz=0x4000 mem=0x207fff9000 memsz=0x5000
segment[2]: buf=0x00000000d879f1fe bufsz=0x1180 mem=0x207fff3000 memsz=0x2000
segment[3]: buf=0x000000001101cd86 bufsz=0xc88200 mem=0x207c000000 memsz=0x3c4a000
segment[4]: buf=0x00000000c6e38ac7 bufsz=0x2186280 mem=0x2079e79000 memsz=0x2187000
kexec_file_load: type:0, start:0x207fff91a0 head:0x109e004002 flags:0x8
---------------------------------------------------------------------------

History:
=========
v3->v4:
- Add the explanation about why kexec_dprintk() need be introduced to
  replace pr_debug() in log of ARCH patch, suggested by Conor.
- Mentioned why pr_notice() need be replaced with kexec_dprintk() in
  function elf_kexec_load() of risc-v, Suggested by Conor.
- Change breaking one message line into two back to one line, pointed
  out by Joe.
v2->v3:
- Adjust all the indentation of continuation line to the open parenthesis
  for all kexec_dprintk() call sites. Thank Joe to point this out.
- Fix the LKP report that macro kexec_dprintk() is invalid when
  CONFIG_KEXEC=Y, CONFIG_KEXEC_FILE=n, CONFIG_CRASH_DUMP=y.

v1->v2:
- Take the new format of kexec_dprintk() suggested by Joe which can
  reduce kernel text size.
- Fix building error of patch 2 in kernel/crash_core.c reported by LKP.
- Fix building warning on arm64 in patch 4 reported by LKP.

Baoquan He (7):
  kexec_file: add kexec_file flag to control debug printing
  kexec_file: print out debugging message if required
  kexec_file, x86: print out debugging message if required
  kexec_file, arm64: print out debugging message if required
  kexec_file, ricv: print out debugging message if required
  kexec_file, power: print out debugging message if required
  kexec_file, parisc: print out debugging message if required

 arch/arm64/kernel/kexec_image.c        |  6 +++---
 arch/arm64/kernel/machine_kexec.c      | 26 ++++++--------------------
 arch/arm64/kernel/machine_kexec_file.c | 12 ++++++------
 arch/parisc/kernel/kexec_file.c        |  8 ++++----
 arch/powerpc/kexec/elf_64.c            |  8 ++++----
 arch/powerpc/kexec/file_load_64.c      | 18 +++++++++---------
 arch/riscv/kernel/elf_kexec.c          | 11 ++++++-----
 arch/riscv/kernel/machine_kexec.c      | 26 --------------------------
 arch/x86/kernel/crash.c                |  4 ++--
 arch/x86/kernel/kexec-bzimage64.c      | 23 ++++++++++++++---------
 include/linux/kexec.h                  |  9 ++++++++-
 include/uapi/linux/kexec.h             |  1 +
 kernel/crash_core.c                    |  8 +++++---
 kernel/kexec_core.c                    |  2 ++
 kernel/kexec_file.c                    | 14 +++++++++++---
 security/integrity/ima/ima_kexec.c     |  4 ++--
 16 files changed, 83 insertions(+), 97 deletions(-)

-- 
2.41.0

