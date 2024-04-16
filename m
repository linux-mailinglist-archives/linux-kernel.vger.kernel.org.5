Return-Path: <linux-kernel+bounces-147325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B58A728B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9761C2157C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725B2133435;
	Tue, 16 Apr 2024 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yg4y+BaZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619AB1332A7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289302; cv=none; b=e6pVAG7sr+7IVv4J+eZi9WEWjm4HHIzcqDuqezVWIfXs+FuyDyMJbx97xANx2t/sAyD5CjXzyDjP/vkT91vfZ0YqvWHDZbX+M2GWu66DsJHTCKHX5oEVvC6LA9HRtP5Glfwf/tpuK2qmlzqsMlfWJm5frcJBS6WZkWaH/fNh6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289302; c=relaxed/simple;
	bh=Vw0CuoQdG1Izc0eYCH/qYFN7N+2d8J9VLlSakCDBFi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qsk459LR0ya+/MGT1f2CHHHa8yDkX6Vy/uZghIyxq7W83xEHk5TzpvjHbrfsyRs7nGve7vsu5avKDgAEAtbL2J2iShfhU4J2Z4EB29V4IR9bHsmeTqSYejNf5z8wHJ0AFXb0Cv6dVWN4t/hgVz+p2iH3Z84jShQoExpN3bWdag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yg4y+BaZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713289300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kEHTIuVZ7IxKlDHHHL8YBjswFPsEcqdIbeYKHCzhGso=;
	b=Yg4y+BaZK28kWUOlybkb8UYbyTkCsa/TlMg9cz7vuTSYiYLwhPxC9i2gaVLfT9uTBTSXPs
	uQVZ/bpwxU1CkOGtib57ix7vhIWBYheJFY8MoctfsFdoEx2QFYlZoKNq1AKaqdcd5oNmcC
	uvxRpRybqphJXt0br7JXPqsD3t21128=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-LLnZDNbYP1CcJhuodhnRsQ-1; Tue, 16 Apr 2024 13:41:38 -0400
X-MC-Unique: LLnZDNbYP1CcJhuodhnRsQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41828dd7c29so10506505e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289297; x=1713894097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEHTIuVZ7IxKlDHHHL8YBjswFPsEcqdIbeYKHCzhGso=;
        b=ftOaGjzboDYxgbOQevV7HzKkY7HwNa/fw/irr8Yya7+cFZBgYhPbp6+K6DPENtG8HA
         VlsYQXm9kEaiVM1NkcWGcMrrwUBrKevzSwpkEUuwlhJvuYVfk3X7qft0kisKQG+f8hDs
         JFakRBFJt1rSBCI3FphG/Sks3+yAlnrwUr/Pr40/vj5nqKuZNmtmYCbKAAj1HXFIKdFs
         YXgs25FeIXeQUCejCdwv8PSB1D+ZwQ+9dQWADmJm/rKXFyzADvUjdKBd5tlsLxVkNVSr
         5hBhNXhF4UeUp46cYdmY6P8IScQEyOlqsQm8Xu6qsv2MVHWhhv95q5dhwm2BtMcFp25h
         ndAg==
X-Gm-Message-State: AOJu0YzKEOC/WUTWMRJi7nYQC+SClAjhysaIzNJEcD6RLyV+RNfX4f+I
	3Rdp3nGmx3Ig4sOtliQrGlRyXANB7gm/oXoevY3GTmShc0D3sPTXRWUAejtHCR3n2FWWmgST6zU
	SL0V3M7GXXP4sdBlT6qPMXr5rA4DIhNujuCd1UTh708mtqPdBfl3jDlTU9B9Z170GBsJ3pVlbvb
	jHaa0mAfa44bc3Ia0VPg5izOVLYXoDwuvJecWM
X-Received: by 2002:adf:e350:0:b0:341:c9d1:eae5 with SMTP id n16-20020adfe350000000b00341c9d1eae5mr8036997wrj.27.1713289297630;
        Tue, 16 Apr 2024 10:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyH8MDxjCQbeF4u8/ZnigxwSksZER5MaFWOeKNXzVAniAX9fCqV7NYMCr8Msf/kPf1h3wAmnL54k980D0yUQo=
X-Received: by 2002:adf:e350:0:b0:341:c9d1:eae5 with SMTP id
 n16-20020adfe350000000b00341c9d1eae5mr8036988wrj.27.1713289297303; Tue, 16
 Apr 2024 10:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412173532.3481264-1-pbonzini@redhat.com> <20240412173532.3481264-5-pbonzini@redhat.com>
 <Zh0mocWeGCGWmBvA@chao-email>
In-Reply-To: <Zh0mocWeGCGWmBvA@chao-email>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Apr 2024 19:41:25 +0200
Message-ID: <CABgObfaV416+wRoRLJzEU6q5D4CJcLh=Ja-K_OBrf6LBnU=KiA@mail.gmail.com>
Subject: Re: [PATCH 04/10] KVM: x86/mmu: Add Suppress VE bit to EPT shadow_mmio_mask/shadow_present_mask
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:08=E2=80=AFPM Chao Gao <chao.gao@intel.com> wrote=
:
>
> >+++ b/arch/x86/include/asm/vmx.h
> >@@ -514,6 +514,7 @@ enum vmcs_field {
> > #define VMX_EPT_IPAT_BIT                      (1ull << 6)
> > #define VMX_EPT_ACCESS_BIT                    (1ull << 8)
> > #define VMX_EPT_DIRTY_BIT                     (1ull << 9)
> >+#define VMX_EPT_SUPPRESS_VE_BIT                       (1ull << 63)
> > #define VMX_EPT_RWX_MASK                        (VMX_EPT_READABLE_MASK =
|       \
> >                                                VMX_EPT_WRITABLE_MASK | =
      \
> >                                                VMX_EPT_EXECUTABLE_MASK)
> >diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> >index 6c7ab3aa6aa7..d97c4725c0b7 100644
> >--- a/arch/x86/kvm/mmu/spte.c
> >+++ b/arch/x86/kvm/mmu/spte.c
> >@@ -413,7 +413,9 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits, bool ha=
s_exec_only)
> >       shadow_dirty_mask       =3D has_ad_bits ? VMX_EPT_DIRTY_BIT : 0ul=
l;
> >       shadow_nx_mask          =3D 0ull;
> >       shadow_x_mask           =3D VMX_EPT_EXECUTABLE_MASK;
> >-      shadow_present_mask     =3D has_exec_only ? 0ull : VMX_EPT_READAB=
LE_MASK;
> >+      /* VMX_EPT_SUPPRESS_VE_BIT is needed for W or X violation. */
> >+      shadow_present_mask     =3D
> >+              (has_exec_only ? 0ull : VMX_EPT_READABLE_MASK) | VMX_EPT_=
SUPPRESS_VE_BIT;
>
> This change makes !shadow_present_mask checks in FNAME(sync_spte) and
> make_spte() pointless as shadow_present_mask will never be zero.

It makes them wrong, not pointless. :)

The checks verify that there are "some" bits that are different
between non-present and present PTEs. They need to remove
SHADOW_NONPRESENT_MASK from shadow_present_mask.

Paolo


