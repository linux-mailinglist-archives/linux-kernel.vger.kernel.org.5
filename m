Return-Path: <linux-kernel+bounces-159903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECC8B35FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBF31F22722
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1C145B06;
	Fri, 26 Apr 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kd/aJxvM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF6145327
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128604; cv=none; b=DsYgvFW4HjdcA80AL3IMEQDVcfva+9RlivJC2EB+IaHfG841IHNSAVfwTmqW89GdwMx+O3CtTBrXLt8hgndV5M0NYBkNef2MjZvM5ICc1O2Tbka7SAayCqPy3e1KLbHTjUvplLmOU02yUxWacCdxtcJPS+188zWggvkRhzJzXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128604; c=relaxed/simple;
	bh=3TP2uHC4mQRfabmD1+dpyNDOj8vwZ4B4oSRmGaqT+Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spwFR8i4y6e40WQzjCOoueGmd2c8XARU9y5Gdiceg0X7qaqaPEY9TYnBlV8bJDJtmvYXPXYkH3MAa0NvAkGmbCi9lfDY0qseyGchAUOHQudV/Zxp8BFgjo9KPagLGpId1ufYig74xubWpNBtU9NI4XPu2GhibNVGN/DhsJj+ptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kd/aJxvM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714128601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AySb1TlhVPPrqTACK8fU1SzEo7gL7MLhlk77wlxrmQo=;
	b=Kd/aJxvMZhKIrBHzN7ysNiBpIeDku4M2bbzsMuMVW68G6vA2I8ux3r/lTmzR7Z8tP5Kvos
	ck8ZQE08+cUuPgyzK0+kc26g7D5xDJ75iOzt5zjNKXEiARzAL9pM7TH76pr1EuopU3lRl8
	e5W9ITaWgjegAnLusJFT0AO3wrKIuVA=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-jOSv7jo1Pl6NtXb8PjjIuQ-1; Fri, 26 Apr 2024 06:49:55 -0400
X-MC-Unique: jOSv7jo1Pl6NtXb8PjjIuQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c613c1c51eso1887601b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128594; x=1714733394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AySb1TlhVPPrqTACK8fU1SzEo7gL7MLhlk77wlxrmQo=;
        b=KO7qA80BE+aBJzhsUkUI+nNlD59mFznmQLy0W2+8OsJ8vQGIVbKVZLUxVF3/rXTBxT
         4r+C9szklWp8gVxCFI7BQiWhv2sYj1awHo8Xj3QxQGer0UZCmgicCzViSE8dqxwrOcMh
         TeBLNTOQbt3R+6sSHX57qWAA1lM9OZQuChEc/XOLP+7JrK2i2KR9L4CDFN0eTZY/CQN9
         0axNfPRST3ABCgey3TDeTwihibZ07c0kRkitaRxioPTLslpWcwwKveq2Ake6l8RdtGwv
         wTBEx0PppFXa595PLVO8Ma01d+ul3wxZJO+C+suk/SceDbD/B1m9RERUa+NhJIsGJNr2
         FzYw==
X-Forwarded-Encrypted: i=1; AJvYcCW75arjxKt+EcSqS8YTqTLUVEjRqXwq9z//BN+lqOLwvk3Ip08zS7PBBvLZSqoM6rBu7PdbF4KfEQxDEx9UuVjIp0StffR3A4yA45uW
X-Gm-Message-State: AOJu0YxbfF5XLJBCFiW5SRVWEmDWxPqsxy6VXGW055MQOiUERDeOEdnU
	8isl6ca8JBO9VU5zARTHpp5p4uADSZ07zVt4IU2ieZSpZj4BzwoNQMIHqjieKxt5Ff9qo+a5LKN
	+u324+K/YMDmJmCsCBWGLJOD7/kjBIASnOghbMJtjeLxwBOb1jzOFgBGrXftYdg==
X-Received: by 2002:a05:6808:bc8:b0:3c6:f7b1:b228 with SMTP id o8-20020a0568080bc800b003c6f7b1b228mr2723694oik.31.1714128594301;
        Fri, 26 Apr 2024 03:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZsGfT69zsmTCVgTcj+/En2dvpkEVqYiuQXZdoAX6RGBoDOOIyO2jwTtLnAHh1VuafDtHvkA==
X-Received: by 2002:a05:6808:bc8:b0:3c6:f7b1:b228 with SMTP id o8-20020a0568080bc800b003c6f7b1b228mr2723673oik.31.1714128593932;
        Fri, 26 Apr 2024 03:49:53 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id vv26-20020a05620a563a00b007907b57aa1fsm3888019qkn.12.2024.04.26.03.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:49:53 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2 0/6] KVM: arm64: emulation for CTR_EL0
Date: Fri, 26 Apr 2024 12:49:44 +0200
Message-ID: <20240426104950.7382-1-sebott@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hej folks,

I'm looking into supporting migration between 2 Ampere Altra (Max)
machines (using Neoverse-N1). They are almost identical regarding
their feature id register state except for CTR_EL0.DIC which is set
on one machine but not the other.

CTR_EL0 is currently marked as invariant and migrating a VM between
those 2 machines using qemu fails.

Changes RFC [0] -> V1 [1]:
 * store the emulated value per VM and not per VCPU
 * allow to change more values than just the DIC bit
 * only trap guest access to that reg when needed
 * make sure to not present the guest with an inconsistent register set
Changes V1 -> V2:
 * implemented Marc's suggestion for keeping registers consistent while
   not breaking userspace ABI / expectations (I hope correctly this time)
 * keep the shadowed value valid at all time
 * unify the code to setup traps

Note:
* in order to switch off CTR_EL0.IDC userspace first has to set up
  CLIDR_EL1 accordingly
* reading CCSIDR before and after changing the cache size in CTR_EL0
  could result in different values (but only if CCSIDR was not changed
  from the generated value)
* I'll prepare a testcase for the next revision

Thanks,
Sebastian

[0]: https://lore.kernel.org/all/20240318111636.10613-1-sebott@redhat.com/T/
[1]: https://lore.kernel.org/lkml/20240405120108.11844-1-sebott@redhat.com/T/

Sebastian Ott (6):
  KVM: arm64: change return value in arm64_check_features()
  KVM: arm64: unify trap setup code
  KVM: arm64: maintain per VM value for CTR_EL0
  KVM: arm64: add emulation for CTR_EL0 register
  KVM: arm64: show writable masks for feature registers
  KVM: arm64: rename functions for invariant sys regs

 arch/arm64/include/asm/kvm_emulate.h |  37 -----
 arch/arm64/include/asm/kvm_host.h    |   4 +-
 arch/arm64/kvm/arm.c                 |   3 +-
 arch/arm64/kvm/sys_regs.c            | 225 ++++++++++++++++++++-------
 4 files changed, 173 insertions(+), 96 deletions(-)

-- 
2.42.0


