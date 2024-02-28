Return-Path: <linux-kernel+bounces-84822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED4886AC06
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7281C2148C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C004D59F;
	Wed, 28 Feb 2024 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LG8R525/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C1E482FE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115526; cv=none; b=cN8CiAzwzTANMex0NyNoS9ThzcPm3bnSO7PVzHvWsUHciWMHwik+pZlmcaYOWD4RPvByR+ywBlM/9gJAxtTCyw6teQR5JopbuPNAsXfWhiiTmiMeQ5nLgtrzoAur+6kQvcLok9KmhHRCW6HRnUF4HCIwS//xp7YsZ9M0YuZMYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115526; c=relaxed/simple;
	bh=5nMH6rhMv/5mgGZqAP+nH6ZKn9Su5tHGv21eiWmAMG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n0VCtGYzNqivukBb9p5+0r77ITd7ETvL36BOkX5RY1TAVG8++zTOINKGUy/xNeyiYvvLMQ9vyZ7fkDh2QjUtOUyRkhU6pTJTeY2J1sIzmSpYzYUtekVdqQmNENVJHRJgWse8Qu4iPqH3Yaw1YK6v4Gj7coxiBkRUujOkyBB/Xps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LG8R525/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709115523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iFcTu4vWXsmQv14zHnSYq8RhqP6dIPyBbIRKHjBzM90=;
	b=LG8R525/o3Vy+pT5xQqtVKQ/C8SE8/ytbYoUJOhjk6ZlzCz+SFrCSwkagyBRXWhBNgt9go
	k1iuN6EFhgG11F0UFVt4dawq53hnSEKGiMtALu9V3A9lMnihruuLF2bEIvCdoW71KObmKI
	imESXjQ06Mv42A7mhsqk6TQ33deChmA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-FP8xKnhlP221lR6BnYgJXQ-1; Wed,
 28 Feb 2024 05:18:39 -0500
X-MC-Unique: FP8xKnhlP221lR6BnYgJXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5ED8B3C11A06;
	Wed, 28 Feb 2024 10:18:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 268818177;
	Wed, 28 Feb 2024 10:18:38 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Li RongQing <lirongqing@baidu.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] KVM: x86: Fix KVM_FEATURE_PV_UNHALT update logic
Date: Wed, 28 Feb 2024 11:18:34 +0100
Message-ID: <20240228101837.93642-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Guest hangs in specific configurations (KVM_X86_DISABLE_EXITS_HLT) are 
reported and the issue was bisected to commit ee3a5f9e3d9b ("KVM: x86: Do
runtime CPUID update before updating vcpu->arch.cpuid_entries") which, of
course, carries "No functional change intended" blurb. Turns out, moving
__kvm_update_cpuid_runtime() earlier in kvm_set_cpuid() to tweak the 
incoming CPUID data before checking it wasn't innocent as 
KVM_FEATURE_PV_UNHALT reset logic relies on cached KVM CPUID base which
gets updated later.

I was not able to reproduce the issue with QEMU myself so I wrote a
selftest to show the problem.

Vitaly Kuznetsov (3):
  KVM: x86: Introduce __kvm_get_hypervisor_cpuid() helper
  KVM: x86: Use actual kvm_cpuid.base for clearing KVM_FEATURE_PV_UNHALT
  KVM: selftests: Check that KVM_FEATURE_PV_UNHALT is cleared with
    KVM_X86_DISABLE_EXITS_HLT

 arch/x86/kvm/cpuid.c                          | 42 ++++++++++++-------
 .../selftests/kvm/x86_64/kvm_pv_test.c        | 42 +++++++++++++++++++
 2 files changed, 68 insertions(+), 16 deletions(-)


base-commit: 0cbca1bf44a0b8666c91ce3438f235c6fe70fbf1
-- 
2.43.0


