Return-Path: <linux-kernel+bounces-159908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31D8B360B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17792284B55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104881474CB;
	Fri, 26 Apr 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hn4SG3To"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD96146D52
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128611; cv=none; b=ERbyeYIFdxtb/mYTWfNa1W0o4vc7GXao+B+8LZgnqWxx5NpZe4rnHX5RWN/sEso9ThwamJ3ivcgO85+lIGu0Ft57Q711IcjXazRvw/Htv4M81b34dSxA8UvAl0QqUfYJ/jzjRujA3pLgZ26gakb4+uxoNZ4YX/bIHJ4RBUZLgPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128611; c=relaxed/simple;
	bh=Tf9y+3NWAEc98GgU9RtLG+14qsoC+MYFycxluP99giU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hkd6LsPmEyUOY9QaNHnT3rDEb9WZej+04s73cPWRTSsfC1c7wmjhRZryQaPTBjrwYrus0BCKzjqVuc8/7X1sme206u5S4x6ldagBCXZsWyC9ZzmyrtTY/4C6hOlUnPGH8Nuu4jmNLhThRQcZHmwLFPkB7PlHI7nasmgQ0qfLOUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hn4SG3To; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714128608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNqZh+z2EiZYSEoBRZTk0oPEfA8kIktvdRXuHyV2qbw=;
	b=hn4SG3TolmVDVQOLaUb0jlmlAltR+YScK7GO3KMjPfWsuSOgyMaxbz/NGXWDZtdcH5EtVV
	g3wkr6M6DYXf0LO9ACc9M+ATqNm5bFfOecXlDnHRattnFZ4RlbL/v7JBadVxT+sKZa1mcj
	6u5a9eFXa1svJuPzxvvfGMJsYidvP7A=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-BDCwz__lNUaAvZl0gJqFPg-1; Fri, 26 Apr 2024 06:50:07 -0400
X-MC-Unique: BDCwz__lNUaAvZl0gJqFPg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c5f316d1ffso2437688b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128607; x=1714733407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNqZh+z2EiZYSEoBRZTk0oPEfA8kIktvdRXuHyV2qbw=;
        b=Af2WkfrKoPtktsaZ8WrYG9004YeIaLFCBI385zabXscw1Vg3hIZBb5L6cZ5UcCE8mv
         a9eeFnoCLXBUzKTBWHuZXAxckgcoQGZp9jWALOMQYl0/7WbcXxu48C6sNEl1jeF/hY16
         Kq8yh8I5ijPKFkyAulWX6ZBWjAhoCl/VYReV7ixqulNZjp+RzITQjLuDAJ15R7MwtWIn
         pzFFtYtZgvrL7YeEb1Hx6k1CsSOoIQJ6NlaGl7c2iRrvLb415O60rPD+B61JoDi+AlpV
         or7lz8oHL2YSL0szcP5DXgMzNDRGpOAevT9wtaOcftywSxP27Pc4gTu99JAdUSjR9sV6
         SU/w==
X-Forwarded-Encrypted: i=1; AJvYcCUn3MK5Q68xgeal7pxEorwGVvJ5ypk5ZyJramAjRrMYYmu1tWkGtb3RHJodQksfS+DhfB8XP3JiqKnsMEkxvCbSHe58xyaVYjASXsbF
X-Gm-Message-State: AOJu0YzGGDJcySVS4+3iFfWK3ScDGSzxHX2M9dJIj/qTkQbO+352q4gq
	ZVQkYEi8CC9ni60Mry2eIKWowIaxe+9IQTnuLp5Yy5b2Ut8/2HPUw51D+b1WxFTgTK1OLqPUozT
	NRagQ2Y+i9DWqxQ/fywvwBXleVxiQJvTOWtmL4CWOB2EPlXtUC9okNW8S0J+nlw==
X-Received: by 2002:a05:6808:30a4:b0:3c7:4d4e:efa with SMTP id bl36-20020a05680830a400b003c74d4e0efamr3051375oib.0.1714128607086;
        Fri, 26 Apr 2024 03:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKgU12rJ0S8FySH9QjK+dyy5z+zqe2fLh87SXhBDOo4CIWHlr7Ul+j8/28IMaiu8xhUzD1bg==
X-Received: by 2002:a05:6808:30a4:b0:3c7:4d4e:efa with SMTP id bl36-20020a05680830a400b003c74d4e0efamr3051354oib.0.1714128606675;
        Fri, 26 Apr 2024 03:50:06 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id vv26-20020a05620a563a00b007907b57aa1fsm3888019qkn.12.2024.04.26.03.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:50:06 -0700 (PDT)
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
Subject: [PATCH v2 6/6] KVM: arm64: rename functions for invariant sys regs
Date: Fri, 26 Apr 2024 12:49:50 +0200
Message-ID: <20240426104950.7382-7-sebott@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426104950.7382-1-sebott@redhat.com>
References: <20240426104950.7382-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invariant system id registers are populated with host values
at initialization time using their .reset function cb.

These are currently called get_* which is usually used by
the functions implementing the .get_user callback.

Change their function names to reset_* to reflect what they
are used for.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 7d5d55e5c16a..88f6cdf9b8d6 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3753,8 +3753,8 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
  */
 
 #define FUNCTION_INVARIANT(reg)						\
-	static u64 get_##reg(struct kvm_vcpu *v,			\
-			      const struct sys_reg_desc *r)		\
+	static u64 reset_##reg(struct kvm_vcpu *v,			\
+			       const struct sys_reg_desc *r)		\
 	{								\
 		((struct sys_reg_desc *)r)->val = read_sysreg(reg);	\
 		return ((struct sys_reg_desc *)r)->val;			\
@@ -3766,9 +3766,9 @@ FUNCTION_INVARIANT(aidr_el1)
 
 /* ->val is filled in by kvm_sys_reg_table_init() */
 static struct sys_reg_desc invariant_sys_regs[] __ro_after_init = {
-	{ SYS_DESC(SYS_MIDR_EL1), NULL, get_midr_el1 },
-	{ SYS_DESC(SYS_REVIDR_EL1), NULL, get_revidr_el1 },
-	{ SYS_DESC(SYS_AIDR_EL1), NULL, get_aidr_el1 },
+	{ SYS_DESC(SYS_MIDR_EL1), NULL, reset_midr_el1 },
+	{ SYS_DESC(SYS_REVIDR_EL1), NULL, reset_revidr_el1 },
+	{ SYS_DESC(SYS_AIDR_EL1), NULL, reset_aidr_el1 },
 };
 
 static int get_invariant_sys_reg(u64 id, u64 __user *uaddr)
-- 
2.42.0


