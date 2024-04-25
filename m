Return-Path: <linux-kernel+bounces-158353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B351F8B1EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70A71C210F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF9086259;
	Thu, 25 Apr 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOFdXuh7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236786151
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039484; cv=none; b=skKYh/yv/NS4DdIpngopIqjXlfVrLeMN0wQXLYflUISoxPQEvemid0Z0xpcrMxKKiu4vEX6Tih+++ZaPg1JYTB0fAt9+ZyVdJQMtc+WXx6cIbayslUtXcHHfVsRF7Q6QeWS1GTjxKsqQBl1rhtAb0OOb8rUKFbcG0HLZpNx6npE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039484; c=relaxed/simple;
	bh=90aqyJDcuxgtbmJMDSeupvwwq0O3XKohFO2iryDavZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRzoc9iJpiZI5KSMarKPwmMyDmhFp2o/PFG9fYt4Efsqo0spOgQZY86aoUi9+okzUN78gvpqyk20Zr6U5rxTBwr/LhYfNO5t4gfCLmyA40cTvTj7WcD2Rl9/xq7divB9IuJmYGaNrtHPeSdM3WTZ8ywTKV8KNaqFfniVzWXl3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOFdXuh7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3mBgtuiCKBzoVzYLU6P6zbBW8ejOibsGMiGGBrCvDE4=;
	b=eOFdXuh72QPwPGrvrzXKKE7zwstA/6erXPbPJBNnEEzU2HV019/bEoYIDm3IOz5T6rVLqh
	BI4ycGjsJ8VUcannHeoYtj2DvmtDJhHDYfH1fqHnanfmXeuR8CPr5eaZX4n/Z5KgVIovTB
	yfn0Y+PVnMGtmll9Xmd1ihtXNzaYGmg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-HgsWvPyOP8GWooUFbEFinA-1; Thu, 25 Apr 2024 06:04:39 -0400
X-MC-Unique: HgsWvPyOP8GWooUFbEFinA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a48ed89c7eso1054630a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039479; x=1714644279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mBgtuiCKBzoVzYLU6P6zbBW8ejOibsGMiGGBrCvDE4=;
        b=gCW4YZM1C7JG1l58FE7mjCU2jsKo/A+1YrBEGxfibyFYw6TXq/hMtV69TvKXqgvKMI
         D+KKJlQW+idYai4+hIH2vFrw6zzRjcWSgF6iq8iLpJfL7BprmPm8gJJQxxB0Be0ki40G
         GKPvw9KSRGzKO7mLa3tUPt7KeAWV7RdQgp3gcPvmrbIApUE6suSw4oir5qvB9KkvPRUi
         cwUeFJYQyBmnYHBpjf+enAHwoDkdDWHukqOcxbqmrKCo5a9Om4tndTXE7oLOTNFfM93o
         d7/gctj65cPxRdc7tHqvETKgzXooF3BWdOAu+Q/n7SEzw8+hqO33wpEXZyLTi57cQB2F
         PSbw==
X-Forwarded-Encrypted: i=1; AJvYcCUfe48LllHmUjipyVg2gmL+tT2eQuGC3YTM6SW49rQiPQx9KeIx+aanT8HzUl1thtaIf4jx+4X/9bmGw5qHE6PVO96ATZVPGizL5eNm
X-Gm-Message-State: AOJu0YyRfqVq+6XpCfoM3ABsqu5K8eWYX7mzrEqF9LVEbKfFGRGbwOeU
	NBlMe5ZpHi785Qi2NAf1jV3TpiA3Ws0fS/oB1Zgr11Z4As8YpYhtnaSxfi9ksNtC1lP6072ZVEd
	aMilOoqBsqYTPAit/eiISMkeP99y5NnHVE7ObMpj+kst3MQYAYooCX17nm/Ejnw==
X-Received: by 2002:a17:90b:364d:b0:2af:5c36:b2f2 with SMTP id nh13-20020a17090b364d00b002af5c36b2f2mr3556648pjb.4.1714039478142;
        Thu, 25 Apr 2024 03:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVDx426qsql+BWbtnG8FmXe2oLr4J6joMt/VULjm8R8veF+8DYtvh44vWQwrBuqmwFeSiPzQ==
X-Received: by 2002:a17:90b:364d:b0:2af:5c36:b2f2 with SMTP id nh13-20020a17090b364d00b002af5c36b2f2mr3556612pjb.4.1714039477308;
        Thu, 25 Apr 2024 03:04:37 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id sv14-20020a17090b538e00b002ab3bffb765sm12619473pjb.32.2024.04.25.03.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:36 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 0/7] Support kdump with LUKS encryption by reusing LUKS volume keys
Date: Thu, 25 Apr 2024 18:04:24 +0800
Message-ID: <20240425100434.198925-1-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LUKS is the standard for Linux disk encryption. Many users choose LUKS
and in some use cases like Confidential VM it's mandated. With kdump
enabled, when the 1st kernel crashes, the system could boot into the
kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
specified target. Currently, when dumping vmcore to a LUKS
encrypted device, there are two problems,

 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes; For cloud confidential VMs, depending on the policy the
   kdump kernel may not be able to unseal the keys with TPM and the
   console virtual keyboard is untrusted.

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump. Take Fedora example, by default, only 256M is reserved for
   systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
   to be reserved for kdump. Note if the memory reserved for kdump can't
   be used by 1st kernel i.e. an user sees ~1300M memory missing in the
   1st kernel.

Besides users (at least for Fedora) usually expect kdump to work out of
the box i.e. no manual password input is needed. And it doesn't make
sense to derivate the keys again in kdump kernel which seems to be
redundant work.

This patch set addresses the above issues by make the LUKS volume keys
persistent for kdump kernel with the help of cryptsetup's new APIs
(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
this kdump copy of LUKS volume keys,

 1. After the 1st kernel loads the initramfs during boot, systemd
    use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
    volume keys and then save the volume keys to specified keyring
    (using the --link-vk-to-keyring API) and the key will expire within
    specified time.

 2. A user space tool (kdump initramfs builder) writes a key description to
    /sys/kernel/crash_dm_crypt_keys to inform the 1st kernel to record the
    key while building the kdump initramfs

 3. The kexec_file_load syscall read the volume keys by recored key
    descriptions and then save them key to kdump reserved memory and wipe the
    copy.

 4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
    initramfs asks the kdump kernel to create a user key using the key stored in
    kdump reserved memory by writing to to /sys/kernel/crash_dm_crypt_keys. Then
    the LUKS encrypted devide is unlocked with libcryptsetup's
    --volume-key-keyring API.

 5. The system gets rebooted to the 1st kernel after dumping vmcore to
    the LUKS encrypted device is finished

After libcryptsetup saving the LUKS volume keys to specified keyring,
whoever takes this should be responsible for the safety of these copies
of keys. The keys will be saved in the memory area exclusively reserved
for kdump where even the 1st kernel has no direct access. And further
more, two additional protections are added,
 - save the copy randomly in kdump reserved memory as suggested by Jan
 - clear the _PAGE_PRESENT flag of the page that stores the copy as
   suggested by Pingfan

This patch set only supports x86. There will be patches to support other
architectures once this patch set gets merged.

v3
 - Support CPU/memory hot-plugging [Baoquan]
 - Don't save the keys temporarily to simplify the implementation [Baoquan] 
 - Support multiple LUKS encrypted volumes
 - Read logon key instead of user key to improve security [Ondrej]
 - A kernel config option CRASH_DM_CRYPT for this feature (disabled by default)
 - Fix warnings found by kernel test robot
 - Rebase the code onto 6.9.0-rc5+

v2
 - work together with libscryptsetup's --link-vk-to-keyring/--volume-key-keyring APIs [Milan and Ondrej]
 - add the case where console virtual keyboard is untrusted for confidential VM
 - use dm_crypt_key instead of LUKS volume key [Milan and Eric]
 - fix some code format issues
 - don't move "struct kexec_segment" declaration
 - Rebase the code onto latest Linus tree (6.7.0)

v1
 - "Put the luks key handling related to crash_dump out into a separate
   file kernel/crash_dump_luks.c" [Baoquan]
 - Put the generic luks handling code before the x86 specific code to
   make it easier for other arches to follow suit [Baoquan]
 - Use phys_to_virt instead of "pfn -> page -> vaddr" [Dave Hansen]
 - Drop the RFC prefix [Dave Young]
 - Rebase the code onto latest Linus tree (6.4.0-rc4)

RFC v2
 - libcryptsetup interacts with the kernel via sysfs instead of "hacking"
   dm-crypt
   - to save a kdump copy of the LUKS volume key in 1st kernel
   - to add a logon key using the copy for libcryptsetup in kdump kernel [Milan]
   - to avoid the incorrect usage of LUKS master key in dm-crypt [Milan]
 - save the kdump copy of LUKS volume key randomly [Jan]
 - mark the kdump copy inaccessible [Pingfan]
 - Miscellaneous
   - explain when operations related to the LUKS volume key happen [Jan]
   - s/master key/volume key/g
   - use crash_ instead of kexec_ as function prefix
   - fix commit subject prefixes e.g. "x86, kdump" to x86/crash

Coiby Xu (7):
  kexec_file: allow to place kexec_buf randomly
  crash_dump: make dm crypt keys persist for the kdump kernel
  crash_dump: store dm keys in kdump reserved memory
  crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
  crash_dump: retrieve dm crypt keys in kdump kernel
  x86/crash: pass dm crypt keys to kdump kernel
  x86/crash: make the page that stores the dm crypt keys inaccessible

 arch/x86/kernel/crash.c            |  15 +-
 arch/x86/kernel/kexec-bzimage64.c  |   7 +
 arch/x86/kernel/machine_kexec_64.c |  21 ++
 include/linux/crash_core.h         |   9 +-
 include/linux/crash_dump.h         |   2 +
 include/linux/kexec.h              |   6 +
 kernel/Kconfig.kexec               |   8 +
 kernel/Makefile                    |   1 +
 kernel/crash_dump_dm_crypt.c       | 319 +++++++++++++++++++++++++++++
 kernel/kexec_file.c                |  15 ++
 kernel/ksysfs.c                    |  22 ++
 11 files changed, 423 insertions(+), 2 deletions(-)
 create mode 100644 kernel/crash_dump_dm_crypt.c

-- 
2.44.0


