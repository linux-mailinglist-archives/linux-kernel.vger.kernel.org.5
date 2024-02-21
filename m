Return-Path: <linux-kernel+bounces-74650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68185D741
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412E21C224EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF58495E5;
	Wed, 21 Feb 2024 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VV9x1OiZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8AC4879B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515559; cv=none; b=Fu6WeBQfyLMsk8A4N2sWoS2jVZwe6ru8a5N/fX//lUZCusYRvQxoUo1pKBl4TMR3XwCWZJalOYmOD0QxRPrH6MNy1FJ9xh0l0lpGZyU/0rezmtNWVSPSH8g+plTYMU5ymb5OpaQK9peurMe4l6O/u0RR8RIWDDDfUT4fxMkuCrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515559; c=relaxed/simple;
	bh=WN29FhHIbaFhzOpidBbq2yPCWUFc+rFagYVzvFv0258=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m6rYR9+UKBQV7rkJDEdqFWs/opRJ47t4dbJR8m7M3tRvZyfP3psbxvAtaDzdnab59ckeSQFHVwj5XO20m7acxd0hSeu8LHWvqlrt5B8Z3J5HMlkYyVagYMB9/NdOpsn8z2yDrkojJKCvJm3UU+4yggQqfduXLtjQK1pLpqk/nJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VV9x1OiZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708515556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a2Dtr1oYPq5h+UmaIBvjfi/Gm7gWRD+25qD/vc/SHLA=;
	b=VV9x1OiZxs7/T8CkCVs6ZvkKwQ0Wa4S4dF4bl7EabTmB6U41UHr0IQywt2xpL/YZZk5aHa
	BK2Xs3uo+1fjdMdZT7SWWsziGcs7sflBJXFUEuPmKaov303E3ic2A/aVrgr4CqaS0H5/1M
	UWfR5oYSDKAAaYlDOfkZJzLX8U4yWUE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-xhTwOjeCPh6_F_GL_nOHXg-1; Wed,
 21 Feb 2024 06:39:14 -0500
X-MC-Unique: xhTwOjeCPh6_F_GL_nOHXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C38628EA6EB;
	Wed, 21 Feb 2024 11:39:14 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E7694031FBF;
	Wed, 21 Feb 2024 11:39:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 6.8-rc6
Date: Wed, 21 Feb 2024 06:39:13 -0500
Message-Id: <20240221113913.215306-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Linus,

The following changes since commit 9895ceeb5cd61092f147f8d611e2df575879dd6f:

  Merge tag 'kvmarm-fixes-6.8-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2024-02-16 12:02:38 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to c48617fbbe831d4c80fe84056033f17b70a31136:

  Merge tag 'kvmarm-fixes-6.8-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2024-02-21 05:18:56 -0500)

----------------------------------------------------------------
ARM: Two fixes for the ITS emulation.  Unmapped interrupts were
used instead of ignored, causing NULL pointer dereferences.

----------------------------------------------------------------
Oliver Upton (2):
      KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()
      KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler

Paolo Bonzini (1):
      Merge tag 'kvmarm-fixes-6.8-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD

 arch/arm64/kvm/vgic/vgic-its.c | 5 +++++
 1 file changed, 5 insertions(+)


