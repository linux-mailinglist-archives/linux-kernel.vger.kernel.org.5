Return-Path: <linux-kernel+bounces-17214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B88F8249EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E118D1C229A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B5E2C860;
	Thu,  4 Jan 2024 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dszp85vl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F02C197
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704402003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O+nTqWfxAs5egWeWSamTaC98/2rprnp2o0jYIMLBSrc=;
	b=Dszp85vlXcX64hxfTE911WX4eXOLA2QTLBGspnTVbSzUgqabrz+8b5t5eilUswvKkV/8V+
	KqM1oScAqjkkdMNNRfrFZw/NRHO/zU0U+m6yphPoo2/4FrAzBl0eziaLkiUzztR81PyUdg
	ldF8FTbPvOvRZEHFfRMGPv4IgkqpLIs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-uHN8fklkP_-yWiSAiu-pGQ-1; Thu,
 04 Jan 2024 16:00:00 -0500
X-MC-Unique: uHN8fklkP_-yWiSAiu-pGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A90729AA3BB;
	Thu,  4 Jan 2024 21:00:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E70A1121306;
	Thu,  4 Jan 2024 20:59:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: ajones@ventanamicro.com,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	x86@kernel.org,
	kbingham@kernel.org
Subject: [PATCH 0/4] Replace CONFIG_HAVE_KVM with more appropriate symbols.
Date: Thu,  4 Jan 2024 15:59:55 -0500
Message-Id: <20240104205959.4128825-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

CONFIG_HAVE_KVM is currently used with three meanings:

- some architectures use it to enabled the KVM config proper, depending
  on CPU capabilities (MIPS)

- some architectures use it to enable host-side code that is not part of
  the KVM module (x86)

- to enable common Kconfigs required by all architectures that support
  KVM, currently CONFIG_EVENTFD

These three meanings can be replaced respectively by an architecture-
specific Kconfig, by IS_ENABLED(CONFIG_KVM), or by a new Kconfig symbol
that is in turn selected by the architecture-specific "config KVM".
This is what each of the first three patches does.  After this,
CONFIG_HAVE_KVM is unused and can be removed.

This fixes architectures (PPC and RISC-V) that do not have CONFIG_HAVE_KVM=y
and therefore fail to select CONFIG_EVENTFD.  Patch 1 can be quickly
applied to 6.8 to fix this build failure, while the rest can be delayed
to the early -rc period or 6.9 if desired.

Paolo


Paolo Bonzini (4):
  KVM: introduce CONFIG_KVM_COMMON
  MIPS: introduce Kconfig for MIPS VZ
  x86, vfio, gdb: replace CONFIG_HAVE_KVM with IS_ENABLED(CONFIG_KVM)
  treewide: remove CONFIG_HAVE_KVM

 arch/arm64/Kconfig                       |  1 -
 arch/arm64/kvm/Kconfig                   |  2 +-
 arch/loongarch/Kconfig                   |  1 -
 arch/loongarch/kvm/Kconfig               |  2 +-
 arch/mips/Kconfig                        | 18 +++++++++---------
 arch/mips/kvm/Kconfig                    |  3 ++-
 arch/powerpc/kvm/Kconfig                 |  1 +
 arch/riscv/kvm/Kconfig                   |  1 +
 arch/s390/Kconfig                        |  1 -
 arch/s390/kvm/Kconfig                    |  2 +-
 arch/x86/Kconfig                         |  1 -
 arch/x86/include/asm/hardirq.h           |  2 +-
 arch/x86/include/asm/idtentry.h          |  2 +-
 arch/x86/include/asm/irq.h               |  2 +-
 arch/x86/include/asm/irq_vectors.h       |  2 +-
 arch/x86/kernel/idt.c                    |  2 +-
 arch/x86/kernel/irq.c                    |  4 ++--
 arch/x86/kvm/Kconfig                     |  3 +--
 drivers/vfio/vfio.h                      |  2 +-
 drivers/vfio/vfio_main.c                 |  4 ++--
 scripts/gdb/linux/constants.py.in        |  6 +++++-
 scripts/gdb/linux/interrupts.py          |  2 +-
 tools/arch/x86/include/asm/irq_vectors.h |  2 +-
 virt/kvm/Kconfig                         |  2 +-
 24 files changed, 35 insertions(+), 33 deletions(-)

-- 
2.39.1


