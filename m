Return-Path: <linux-kernel+bounces-132941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3976899C42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1311C235CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F9C16C6B5;
	Fri,  5 Apr 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D72Ay4HA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB40C16C69E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318480; cv=none; b=gVQ0TE5xlrfDK69/WB4/JDiv09bGr9gADCjzW2lcONH00jXYnDtYKEKIMQzzvzHdeD1aA11EOPLKoXZeJD336MtgNjf/yHZq1fwlhU+k2Kpwhwq14+5jqU0DwW8E4WRoxNVxjPQCkBs/KI/cAwg6BNZk4pGGlqgpJD0vI06PfoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318480; c=relaxed/simple;
	bh=dAWJ3+cXxiuZbHkwBo+d8CXVXZTUmlRT6gNYyEXFD3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCe3RHP+sACJEDIDY1F/PsTsM56a/t51giTq2AsFrNkp/06G+fEnGgw/RaQs3sYMrfyy4fzxffctMx56jaW2DDZotI/8baKh8ESmroMK0SHxvO0ZobrUXiaNzkbUATeRIT2leheMTDKgPu6R9axsD23JJ13+k4OWG367kLUiWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D72Ay4HA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712318477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fOyfVcrOV/57WM6ff0FNPDEGtLigdW9U20TrqvIPj9w=;
	b=D72Ay4HA90Lg+JHT/oErgNyjIXGR7mEVrgsaGMsy11rNkHUahdADV/7mb7zRi73CbFLNCj
	KbMPbhkZ1D39SJbCYm8PQm1IKny7wqa7X/4bNChHQKRrEtHEovg/W4mGOi2en/iGSih5vR
	UJ9zVDzNeS9CuZYv4r5e1l8zQLnMAAY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-zVx69gFbOH2uFLAXfKidkg-1; Fri, 05 Apr 2024 08:01:16 -0400
X-MC-Unique: zVx69gFbOH2uFLAXfKidkg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-430b327e703so18947931cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712318476; x=1712923276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOyfVcrOV/57WM6ff0FNPDEGtLigdW9U20TrqvIPj9w=;
        b=tEUt1MxvaYxdaUEC8gVJuUeRZ/WbJwXCbubDYOC+rWCTVnubcY/9fnP0wGtW3be27s
         61JAqU4oVmF0EvHtOb6vmlRJ1wJacmO1+JyQbbxj9gjc7JnN4DkTbdkgRA8RtRY31KI7
         G4EH5m8ylu/ZuWFK9MNnOQejJRSykOib4rCw7uP/q3jZ6AQmaakf8TYhgO/H4vdDqKiq
         pC5L3G1CJnzBI/efJF3KSbwdbtmtoxbRHcylchiL5BBsJdexBifxHqN9t01BoyyFZFud
         0m0mu37Yjelele3ZLaA0gF/hXhsUh/YRoAiMOYhqds06lJmgEdKuHw19fAhcBDBHrBer
         /yEg==
X-Forwarded-Encrypted: i=1; AJvYcCWVzcEqC3RFpbKAmWxOgH1bBEJGBpkepcB47M3673LCc0atG0Q72GRC2GvqzplXTlXiA5khVJgQ2Z1xPg6zqtFOXWwfSuZHaTvlNyds
X-Gm-Message-State: AOJu0YxRtzOJOpVqlNf+HqIuT2mWYAWqSMqQRzxlO7iPsbjH3eoRYRp2
	s48iQTMJRoOkY+hqqTSU4xcB27R+I5mAbOyHMcZd2W4YSj0IWbCRBopN9V0PHpMS0dSSrn2GOgD
	GSiuhIfv9B1pGRqhaiZDnb/SepEQIN6+gwhRo/ACb54ulWjJkBEbdnUcnoXndyg==
X-Received: by 2002:ac8:5f06:0:b0:432:cfa6:5d20 with SMTP id x6-20020ac85f06000000b00432cfa65d20mr1214363qta.12.1712318476287;
        Fri, 05 Apr 2024 05:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbkyu7lrarVuj8TBoNoTnVyIyQO0Zw8ghmwwqUIjLkAEOkX/uFF9qF4MU9eU2zyyX3VCAVhQ==
X-Received: by 2002:ac8:5f06:0:b0:432:cfa6:5d20 with SMTP id x6-20020ac85f06000000b00432cfa65d20mr1214188qta.12.1712318473883;
        Fri, 05 Apr 2024 05:01:13 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4c24001316a1e598258370.dip0.t-ipconnect.de. [2003:c9:3f4c:2400:1316:a1e5:9825:8370])
        by smtp.gmail.com with ESMTPSA id fb17-20020a05622a481100b00434383f2518sm679808qtb.87.2024.04.05.05.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:01:13 -0700 (PDT)
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
Subject: [PATCH 0/4] KVM: arm64: emulation for CTR_EL0
Date: Fri,  5 Apr 2024 14:01:04 +0200
Message-ID: <20240405120108.11844-1-sebott@redhat.com>
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

I've send this out as an RFC before [0]. What I've changed here
based on feedback I've got from Marc was:
 * store the emulated value per VM and not per VCPU
 * allow to change more values than just the DIC bit
 * only trap guest access to that reg when needed
 * make sure to not present the guest with an inconsistent register set

Patch 2 adds a ctr_el0 member to struct kvm_arch - would it be preferred
to add it into kvm->arch.id_regs[] (this would mean to increase that
array 4x)?

Patch 3 resets CLIDR_EL1 after a write to CTR_EL0 potentially changing
the value for CLIDR_EL1 - would that be ok for userspace?

Thanks,
Sebastian

[0]: https://lore.kernel.org/all/20240318111636.10613-1-sebott@redhat.com/T/


Sebastian Ott (4):
  KVM: arm64: change return value in arm64_check_features()
  KVM: arm64: maintain per VM value for CTR_EL0
  KVM: arm64: add emulation for CTR_EL0 register
  KVM: arm64: show writable masks for feature registers

 arch/arm64/include/asm/kvm_host.h |   1 +
 arch/arm64/kvm/sys_regs.c         | 131 ++++++++++++++++++++----------
 2 files changed, 89 insertions(+), 43 deletions(-)

-- 
2.42.0


