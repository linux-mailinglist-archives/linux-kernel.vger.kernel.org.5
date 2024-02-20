Return-Path: <linux-kernel+bounces-73221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8942485BF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9481C20EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0B74E19;
	Tue, 20 Feb 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCEVxzWA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559274E0A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441895; cv=none; b=WnPgrQg2yN91l+DXi0T8bMNyabPicaT1DTOHCkkoo1UJ3g09xwsLZT+BuSIv92CAtri/0qA/xancDXTISGuIZsdSpeh/+jrR/pzuIcNiBAcFX/VKETvMdWoObBR5Ao48m399RGhZGZ44WxfxkveYqoo9DAlMJzAIjeEe9jB7kgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441895; c=relaxed/simple;
	bh=4j0AEdcx9mCGsF7IUdM5SYFWq0DI9pYHWcnCN7aVjB0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IOFOfxG0z6FkFFAf1AeONMwvBzRXCsRUSqX74bthpwt12Vc4Nbyg76LwedOzOkVA5DfaLZZbPOcMCklBi/Jks3XLjxTbkbEKtsgYDnfCxsE+dLgF8BiYvaMCGUizTk8lemZgLCN3rZ2ld4AipyY3uaZSSw1Y1DOsyTva31jt3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pCEVxzWA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607e613a1baso88410177b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708441892; x=1709046692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HntEjy9yxWmWWTXkuNNpSjp1N7kZ7Hb0rp6LmAC2dFs=;
        b=pCEVxzWAcOWVkHY2a9dp0aLV3gI1VNYor+JPYmFG6UFGRX8Jn+eKei7oMp1KWmvm/K
         q81E4Y/0ya0flhvR8I+lHR7Zr3MROgrFim4QGvIKZX+/7L331ZyteLXb2kP3II/jXv8O
         5lru8KsWBjjT9BZD3pCq7qdnEb8LJr8bIR5qaaEGwTir5JbETSDyuyf3+i5DI1Br36ab
         XNi+KM7Q+NJHHEmkHWoyMxZJn/C95PgR8oVwSCCCAeGh7PbtlqH4758/8xP+c+U9u+/1
         ShMzSQMmlyui2oUeGZqTEf+3FQUvwWCMW7LzZGW92GlDWMN6nhHRiEuhDmF/qK5kBkmH
         W6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441892; x=1709046692;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HntEjy9yxWmWWTXkuNNpSjp1N7kZ7Hb0rp6LmAC2dFs=;
        b=Yh63F/W1SZupjyJ/xN8Kyu9dbTiQUZEcvxWZ2qFWmUv4lPWgUVdsbcxunI2YfRqeKy
         CIpdNtahg8FYp3zAm5/HK6W9YdosUU47v8XEEmHGAXan+1iq0SlmhrawIME9LmXZTDDn
         e2zNmWfKo3hxWeMfL2kvzlh3UYrfKB3S/OCL61U7vL3jaOW8TJt33Yg2yXGKyl7wOlP4
         l6750I6duAdqiSeJp0Qyog/aIX3GlXRJpkQo+XaDzS1YN5yXATgMqfRu6FXNoa8EvLaT
         6qtTUTa0kh5KbiFFn/bLrOleDpPA+FSTDWbErIt8sqD4YmpDEj6Df3aWetKdaGbO+tT/
         xD1A==
X-Forwarded-Encrypted: i=1; AJvYcCUPohsmhmAacaxr2cmZdDim0U96OxjYn3IZvbdobPR4rQGm8ToUpAPEqRssDWCcXoP8F+WXlJsj/I4wKBFv3QSN+JLRqVxO6rYpdCD5
X-Gm-Message-State: AOJu0YzbgTp0Q98u5wfw87Q52nTnWmZ2yA6MEclU/whDudI1hUnGBIax
	l4pcXEifTw/iJJk7KQZrogb93xlJ2i7m9o1X9mRxcCTas3Jsd56c4dyaG5tikFmVsMJi0fN7e4A
	1nhCgjmh08MsWMNBK6CjD0uOLng==
X-Google-Smtp-Source: AGHT+IHawj15gJxsvtR7YjJHEveUJ4WwPausjIgV44eHILmnRZ0cyOqUs/m7BsqWzl/SQPAk6PdNzK5cvmg0Wu4bYlg=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a0d:d7d1:0:b0:608:22f1:c8e4 with SMTP
 id z200-20020a0dd7d1000000b0060822f1c8e4mr1953137ywd.6.1708441892365; Tue, 20
 Feb 2024 07:11:32 -0800 (PST)
Date: Tue, 20 Feb 2024 15:10:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220151035.327199-1-sebastianene@google.com>
Subject: [PATCH v6 0/6] arm64: ptdump: View the second stage page-tables
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com, 
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev, 
	rananta@google.com, ricarkol@google.com, ryan.roberts@arm.com, 
	shahuang@redhat.com, suzuki.poulose@arm.com, will@kernel.org, 
	yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, vdonnefort@google.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

This is the first part of the series which enables dumping of the guest
stage-2 pagetables. The support for dumping the host stage-2 pagetables
which is pKVM specific will be part of a follow-up series as per the
feedback received in v4. 

When CONFIG_PTDUMP_STAGE2_DEBUGFS is enabled, ptdump registers 
'/sys/debug/kvm/<guest_id>/stage2_page_tables' entry with debugfs
upon guest creation. This allows userspace tools (eg. cat) to dump the
stage-2 pagetables by reading the registered file.

Reading the debugfs file shows stage-2 memory ranges in following format:
<IPA range> <size> <descriptor type> <access permissions> <mem_attributes>

Below is the output of a guest stage-2 pagetable mappings running under
Qemu:

---[ IPA bits 33 start lvl 2 ]---
0x0000000000000000-0x0000000080000000           2G PGD
0x0000000080000000-0x0000000080c00000          12M PGD      R W AF        BLK
0x0000000080c00000-0x0000000080e00000           2M PGD   XN R W AF        BLK
0x0000000080e00000-0x0000000081000000           2M PGD      R W AF        BLK
0x0000000081000000-0x0000000081400000           4M PGD   XN R W AF        BLK
0x0000000081400000-0x000000008fe00000         234M PGD
0x000000008fe00000-0x0000000090000000           2M PGD   XN R W AF        BLK
0x0000000090000000-0x00000000fa000000        1696M PGD
0x00000000fa000000-0x00000000fe000000          64M PGD   XN R W AF        BLK
0x00000000fe000000-0x0000000100000000          32M PGD
0x0000000100000000-0x0000000101c00000          28M PGD   XN R W AF        BLK
0x0000000101c00000-0x0000000102000000           4M PGD
0x0000000102000000-0x0000000102200000           2M PGD   XN R W AF        BLK
0x0000000102200000-0x000000017b000000        1934M PGD
0x000000017b000000-0x0000000180000000          80M PGD   XN R W AF        BLK

Link to v5:
https://lore.kernel.org/all/20240207144832.1017815-2-sebastianene@google.com/

Link to v4:
https://lore.kernel.org/all/20231218135859.2513568-2-sebastianene@google.com/

Link to v3:
https://lore.kernel.org/all/20231115171639.2852644-2-sebastianene@google.com/

Changelog:
 v5 -> current:
 * don't return an error if the kvm_arch_create_vm_debugfs fails to
   initialize (ref.
https://lore.kernel.org/all/20240216155941.2029458-1-oliver.upton@linux.dev/)  
 * fix use-after-free suggested by getting a reference to the
   KVM struct while manipulating the debugfs files
   and put the reference on the file close.
 * do all the allocations at once for the ptdump parser state tracking
   and simplify the initialization.
 * move the ptdump parser state initialization as part of the file_open
 * create separate files for printing the guest stage-2 pagetable
   configuration such as: the start level of the pagetable walk and the
   number of bits used for the IPA space representation.
 * fixed the wrong header format for the newly added file
 * include missing patch which hasn't been posted on the v5:
   "KVM-arm64-Move-pagetable-definitions-to-common-heade.patch" 


 v4 -> v5:
 * refactorization: split the series into two parts as per the feedback
   received from Oliver. Introduce the base support which allows dumping
   of the guest stage-2 pagetables.
 
 * removed the *ops* struct wrapper built on top of the file_ops and
   simplify the ptdump interface access.
 
 * keep the page table walker away from the ptdump specific code

  v3 -> current_version:
  * refactorization: moved all the **KVM** specific components under
    kvm/ as suggested by Oliver. Introduced a new file
    arm64/kvm/ptdump.c which handled the second stage translation.
    re-used only the display portion from mm/ptdump.c

  * pagetable snapshot creation now uses memory donated from the host.
    The memory is no longer shared with the host as this can pose a security
    risk if the host has access to manipulate the pagetable copy while
    the hypervisor iterates it.

  * fixed a memory leak: while memory was used from the memcache for
    building the snapshot pagetable, it was no longer giving back the
    pages to the host for freeing. A separate array was introduced to
    keep track of the pages allocated from the memcache.


  v2 -> v3:
  * register the stage-2 debugfs entry for the host under
    /sys/debug/kvm/host_stage2_page_tables and in
    /sys/debug/kvm/<guest_id>/stage2_page_tables for guests.

  * don't use a static array for parsing the attributes description,
    generate it dynamically based on the number of pagetable levels

  * remove the lock that was guarding the seq_file private inode data,
    and keep the data private to the open file session.

  * minor fixes & renaming of CONFIG_NVHE_EL2_PTDUMP_DEBUGFS to
    CONFIG_PTDUMP_STAGE2_DEBUGFS


  v1 -> v2:
  * use the stage-2 pagetable walker for dumping descriptors instead of
    the one provided by ptdump.

  * support for guests pagetables dumping under VHE/nVHE non-protected

Thanks,

Sebastian Ene (6):
  KVM: arm64: Move pagetable definitions to common header
  arm64: ptdump: Expose the attribute parsing functionality
  arm64: ptdump: Use the mask from the state structure
  KVM: arm64: Register ptdump with debugfs on guest creation
  KVM: arm64: Initialize the ptdump parser with stage-2 attributes
  KVM: arm64: Expose guest stage-2 pagetable config to debugfs

 arch/arm64/include/asm/kvm_pgtable.h |  42 +++++
 arch/arm64/include/asm/ptdump.h      |  42 ++++-
 arch/arm64/kvm/Kconfig               |  13 ++
 arch/arm64/kvm/Makefile              |   1 +
 arch/arm64/kvm/debug.c               |   8 +
 arch/arm64/kvm/hyp/pgtable.c         |  42 -----
 arch/arm64/kvm/kvm_ptdump.h          |  20 ++
 arch/arm64/kvm/ptdump.c              | 270 +++++++++++++++++++++++++++
 arch/arm64/mm/ptdump.c               |  49 +----
 9 files changed, 405 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm64/kvm/kvm_ptdump.h
 create mode 100644 arch/arm64/kvm/ptdump.c

-- 
2.44.0.rc0.258.g7320e95886-goog


