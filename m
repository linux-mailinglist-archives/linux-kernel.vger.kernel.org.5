Return-Path: <linux-kernel+bounces-80021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484E28629D6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 10:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790231C20ACF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C987FDF69;
	Sun, 25 Feb 2024 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b="OUmE95w+"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D75DDC7
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708851782; cv=none; b=Td2Y67ngCmfktEND6f25PoXstjTtRw0l58GCCSAvoUrdgg1+cv8GICH94Wl/KQnHQt762HtVMLarRdGB9/ZLHYiKQeQuiD6fL2Pk6oS8+YM3UZIvaFDj3CfeCCSnccakv/xHWjec9eW8NHlm09cnvRtyO7ufgnGZh662TiJwRF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708851782; c=relaxed/simple;
	bh=BhKO9PDBNegiMdZZdRH/v6D5eq38Xipa+7Mr0Cwvt8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jZFllyXQQRfbAsC3p7hE8xgQmj63+mBBGL8Y9Nwo0Kme1WxK+bR79JWr8DWvnFavnNNbXvNI1ixi53lfXHSlc6HAEbaTboo2U3cj0HYUXbzQ1TYFYxR2ak9/nS8slnXG4O6Rhzkf0jWsK+LvKx5ECvr/JfL5Ft8SuhEDsySrlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw; spf=pass smtp.mailfrom=csie.ntu.edu.tw; dkim=pass (2048-bit key) header.d=csie.ntu.edu.tw header.i=@csie.ntu.edu.tw header.b=OUmE95w+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csie.ntu.edu.tw
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b276979aso1704784a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 01:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie.ntu.edu.tw; s=google; t=1708851778; x=1709456578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4hwb3pMKOhklL904VE2Zqtqr31z33P4MP5BzucroJg=;
        b=OUmE95w+F4m4j2mS6vJ2avG+jZLjfAQ6W7ShUmADFUYSFXoVyB61HzJiERAb1FMdqi
         g2iCpFGJNJexN1NiAzZWxy9iNBB8SZYjCsTpECSIe7TdgLV9E12qXp8A6fBSf5s0Pjlj
         K5WWNMK1mwdTuaBxWfnQ1dkvyAhH4rU45fzx70nv+MxjqbYXCQ7V+ThIAqqj7fg8NicR
         pygjFUp8XPArM4Vx1/AywaegvKqkaC2lOXTbh0BjmnLSB3yaQ8Rb2RYAOensTkv2fdFc
         A8e51NVhOVKvQTt8wK63G/PXaqwvekEG/91an2tRxHthq+/8mFXUgSLi5kxQ8mcSQL6x
         yBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708851778; x=1709456578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4hwb3pMKOhklL904VE2Zqtqr31z33P4MP5BzucroJg=;
        b=kmIDGDW8Osysm26bh0BvoFxVYNl3vglxHH2akUU7TtKgbnk4+WeVbx2ujmjU9XAOtf
         3WEjHUQ/M6EqfTbyUoMUGjNWK+0GjO2wSqRPqhSzYCCbkpuyjIzyaE2xgfpskZADR3J8
         boruAFVWZx5VNdOBctvc/0ghYJeYdWJILKpmZwqpW8x/ub0XFZ+lAMq9e+uw5HbRFlau
         x31bpkN2mBzhPdh7ZMSVQLCM61z2Tj98HYTkGZRxLrLiGuFnXRZdlumvbluFLfnUCwga
         lG7V5yh/aXMLbhSlbvxfM09zs/bsDzhSIFg/kQ+1WVbBGn+zm07zT/WWI3CwIJNpfH7e
         JFWw==
X-Forwarded-Encrypted: i=1; AJvYcCWUnIfU25VdMbNCt1EfxhR1O4DUXv3C4QFMx9E7F1VZiSGgkk4Rnwc1V9auzr7RrX+HRM5OXBuTCAKBu2C2nPnkZVyJ9PQoBK/B3DUq
X-Gm-Message-State: AOJu0Ywaesy50vAmYd89KgWiCmgqfhfFa9lX9l5JTCgA0G8FSaB/vTei
	Xxu0n72+WNwgtBs6dxiQfNHjzg5M9655oLuFGVyVj1qGBpohgZEzaOk1y9U/d27bLtdU/C8pAo4
	kjpijNhpMMRh7CFwIpJ+se7KnLRD8h+Il3+V5zgNd7tq1rpwhzZtGdm/sLqmsuhRve7lhW50=
X-Google-Smtp-Source: AGHT+IGKAsn5LYGykt9Ucw4vyFygaP3Xutj4HGQWD9tAELbXQUR6KtKqhIGhHTiJVu0ALIpwr2a0Vw==
X-Received: by 2002:a17:90b:3609:b0:29a:c027:3983 with SMTP id ml9-20020a17090b360900b0029ac0273983mr6549pjb.36.1708851778031;
        Sun, 25 Feb 2024 01:02:58 -0800 (PST)
Received: from localhost.localdomain (2001-b011-3808-dc23-dcdd-edc7-9b03-9c72.dynamic-ip6.hinet.net. [2001:b011:3808:dc23:dcdd:edc7:9b03:9c72])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090ac09200b0029a3da37123sm2298071pjs.23.2024.02.25.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 01:02:57 -0800 (PST)
From: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sauravsc@amazon.com,
	Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
Subject: [PATCH 0/1] KVM: arm64: Affinity level 3 support
Date: Sun, 25 Feb 2024 17:02:36 +0800
Message-Id: <20240225090237.775573-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0

Hi everyone,

By supporting Aff3, we not only allow broader usage, but also get the
chance to fix the issue pointed out by Saurav [1]. The current code
returns 0s for GICR_TYPER[63:56], causing guests to fail when its VCPUs
tries to find a matching redistributor, when the VMM programs non-zero
values for VCPUs' MPIDR_EL1.Aff3.

For testing, both 64-bit (with ICH_VTR_EL2.A3V == 1) and 32-bit guests
are ran using QEMU, Aff3 usage is emulated by modifying reset_mpidr to
write non-zero test values to MPIDR_EL1.Aff3 when Aff3 is valid, and
populating the Aff3 field of kvm_sys_reg_set_user's user given value
if r->reg == MPIDR_EL1.
The 64-bit case is checked to have MPIDR_EL1.Aff3 populated and both
64-bit and 32-bit guests seem to work with interrupts being delivered
properly.

Note: I checked with Saurav to make sure he isn't planning on working on
this as well. Also thanks for the maintainers for giving directions for
improvements in [1].

[1]: https://lore.kernel.org/kvmarm/20240205184326.78814-1-sauravsc@amazon.com/

Wei-Lin Chang (1):
  KVM: arm64: Affinity level 3 support

 arch/arm64/kvm/sys_regs.c          | 24 +++++++++++++++++++++---
 arch/arm64/kvm/vgic/vgic-debug.c   |  2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 18 +++++++++++-------
 include/kvm/arm_vgic.h             |  7 ++++++-
 4 files changed, 39 insertions(+), 12 deletions(-)

-- 
2.34.1


