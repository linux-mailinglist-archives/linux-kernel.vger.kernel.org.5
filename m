Return-Path: <linux-kernel+bounces-132944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBE4899C46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC6D1F2290A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556FC16D321;
	Fri,  5 Apr 2024 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iY4oCGn9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274BB16C859
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318490; cv=none; b=t5aggCMBkpYZwwzyFqXD9hmrEnB/TJhXYZyRB+aDqHqNm670Gew9BS3j1+iO8MQTo/ZmkqMwPo4DslbyyfWNpUNMnUQmYA/xQ5Dnqf2eLPDYeZJPzDzZ3IbpapjbhFXKlN7oPPNDdHjn9urMcofap8EsiPdqaY82ca9j4eqaOVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318490; c=relaxed/simple;
	bh=4UJ5Fg3bfU8lfARbEPZ8K38xQekfzxdrdG5SQuwKNMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vx66MJr5TQqBahZm2KeMvff0FGqD3pEFWaUJCFii5ngeUQPio6m2VGq6Qz9gHeCJkf+OR6Zq73GUCc/ZjeMFXgpxomqDzs7gOqtAofFlMWR0hwDldrIV0AOiPSFelDpsCYA+EIeNW2EfPeXiRAVmx+0RdinjyQwAo7o9u86pRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iY4oCGn9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712318488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rn4BMv+SOP2Xe0y3A99nPyLC4GfuU+9ShaoCAlDA424=;
	b=iY4oCGn9iN5w93qROm+Vs/KKt+uWq3xQF/9mIUmr5YwmLxSsnnWQvU0SyeiG6myqdMFuBQ
	SIulIKyge5X/NWxFSKrXZ37Q60gNOQYOdK/onczzMSq+UCA0/j1J5pfRxUV49ww7/bI2+L
	Tv81/m+M+3V5AtgrtQ0UuC3kbqiA9d4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-8GhajZp8PhiTcLdHUxvujw-1; Fri, 05 Apr 2024 08:01:27 -0400
X-MC-Unique: 8GhajZp8PhiTcLdHUxvujw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4311b01a1ecso21591371cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712318486; x=1712923286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn4BMv+SOP2Xe0y3A99nPyLC4GfuU+9ShaoCAlDA424=;
        b=vO4W3/Gv2pM6S3Djd0NSYysz30ke/JN3tR9IitFB3uzOVp659JnHCOUhONHPPYqTb5
         iAZZGFH2jU0Pj7zRLnv4nsx4ommbIu9Qwglh58J8c7jSGDw3vDQ7/J137U8nb5NiWzia
         /JGSDteyQVbKyUrUXvvdTkXDxREt4BnhPa0a/XxiH997VbaR5lLE8rXZ34WKlGZi54Ia
         ItVyUEE3MQkfL58DjnuIDzltiYar0eHe2lMw+FKM6A8OzmYTkI3EnFH+gU7reiy76aar
         XHfriR33sHsYBrVPKXW5w8rqSQqCh0MdpFbbXwGA2CnDxDhPdvCUfR6rx4lnjqGQ+xZU
         znWw==
X-Forwarded-Encrypted: i=1; AJvYcCUkinh95pibZw/tgZvap29FBZzj7cwRrDqxMAwlx8ndIpu8PXcQN82NV6BN3Yo5nShGlQBYN4uHIMtLOnmX2cnb2f3LZn8qrhy3FXrH
X-Gm-Message-State: AOJu0YzIQqaBbesjxfmggbgb2Rf3lcCrlzM3zDGcwN2lcJkpb2ckO9P3
	ok15dG5LFNvIyQloVtsaDZeVIQXOFj2xDm0wJKT1rqraIzwjFcnFVIojDkCNYU99N53pmD21dvB
	nqANi96VJoATr8kKvafkVWaBKI5Nz3LFVDCSrL82vyj2ek+bEc82vHIigkZFRKw==
X-Received: by 2002:ac8:7d0a:0:b0:431:5fad:ddbd with SMTP id g10-20020ac87d0a000000b004315fadddbdmr1508847qtb.29.1712318486527;
        Fri, 05 Apr 2024 05:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJoGGlIt1CxA4rAZezuA7q+tZShCN/ywwM2H1k89TmnzVpNOpAzo4NVsKSoiRJE7N6sIm0dg==
X-Received: by 2002:ac8:7d0a:0:b0:431:5fad:ddbd with SMTP id g10-20020ac87d0a000000b004315fadddbdmr1508823qtb.29.1712318486257;
        Fri, 05 Apr 2024 05:01:26 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4c24001316a1e598258370.dip0.t-ipconnect.de. [2003:c9:3f4c:2400:1316:a1e5:9825:8370])
        by smtp.gmail.com with ESMTPSA id fb17-20020a05622a481100b00434383f2518sm679808qtb.87.2024.04.05.05.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:01:25 -0700 (PDT)
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
Subject: [PATCH 4/4] KVM: arm64: show writable masks for feature registers
Date: Fri,  5 Apr 2024 14:01:08 +0200
Message-ID: <20240405120108.11844-5-sebott@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405120108.11844-1-sebott@redhat.com>
References: <20240405120108.11844-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using ~0UL provide the actual writable mask for
non-id feature registers in the output of the
KVM_ARM_GET_REG_WRITABLE_MASKS ioctl.

Explicitely set the mask for CLIDR_EL1 to make sure we present
the same value to userspace than before.

This changes the mask for the CTR_EL0 register in the output
of the KVM_ARM_GET_REG_WRITABLE_MASKS ioctl.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b0ba292259f9..947aa9c0784f 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2505,7 +2505,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
 	{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
-	  .set_user = set_clidr },
+	  .set_user = set_clidr, .val = ~0UL },
 	{ SYS_DESC(SYS_CCSIDR2_EL1), undef_access },
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
@@ -4059,20 +4059,11 @@ int kvm_vm_ioctl_get_reg_writable_masks(struct kvm *kvm, struct reg_mask_range *
 		if (!is_feature_id_reg(encoding) || !reg->set_user)
 			continue;
 
-		/*
-		 * For ID registers, we return the writable mask. Other feature
-		 * registers return a full 64bit mask. That's not necessary
-		 * compliant with a given revision of the architecture, but the
-		 * RES0/RES1 definitions allow us to do that.
-		 */
-		if (is_id_reg(encoding)) {
-			if (!reg->val ||
-			    (is_aa32_id_reg(encoding) && !kvm_supports_32bit_el0()))
-				continue;
-			val = reg->val;
-		} else {
-			val = ~0UL;
+		if (!reg->val ||
+		    (is_aa32_id_reg(encoding) && !kvm_supports_32bit_el0())) {
+			continue;
 		}
+		val = reg->val;
 
 		if (put_user(val, (masks + KVM_ARM_FEATURE_ID_RANGE_INDEX(encoding))))
 			return -EFAULT;
-- 
2.42.0


