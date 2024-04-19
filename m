Return-Path: <linux-kernel+bounces-151391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126828AADFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBCD1C20AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3DB84A5A;
	Fri, 19 Apr 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Akw+r+IT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4C22064
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528106; cv=none; b=PmHzAYMsri/qdDDWWIl5JJwXVqZkEJPLm/tp98eaXNEs04uHDlqGn3nJNJVrxCs0iK97253t//Xq2V8CjGNjK0KTzW895hBas+g2hPUW0RSvDtW/aKIUPZyVMtmpK9GJV2Yx8HJ4qfkf8H1AEdqAZ0qyX8HNEM1B9f6vpfvhqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528106; c=relaxed/simple;
	bh=acN4eXWZt8iLvqysCB2S2Dc6auK2r1UT70yxAxadgbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBiVTUVek1ugXqfCM9i71Fy6SrDzsYsYuFAkD5FnK7kHW2HtWPzNu/4xUNCvs1/rJTnGj603AorftnDuF2ibJvNOXM5rbpm2zyw6TXZ1miAsOjVNAz88NwvDCcsp1Cbtjq2T8D7ywA4j/oPqVCNTb56W136SG1F8ckQYEgLko9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Akw+r+IT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713528104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vahs511qBysOkO0uiEmPvdJfNTUFHsURAvS7DcBv8xY=;
	b=Akw+r+ITtB6jgATaNf+mskwcKMUt3m4QXf/7JL+1hd09iQ5PHq5rQXrX7dnOXhSuRl3mFj
	/aIHEa/JxbuZfgCKM4urVzCW5K1QcHziyzYv1fpSx/jxey70qhHOQj8AlWanPXL3sgf7M1
	VNlofBOtP56Y9kWFuTP0tWPDr72JY70=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-2KcJdromNqGegCUOmBND6A-1; Fri, 19 Apr 2024 08:01:42 -0400
X-MC-Unique: 2KcJdromNqGegCUOmBND6A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41828dd7c29so10044555e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713528101; x=1714132901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vahs511qBysOkO0uiEmPvdJfNTUFHsURAvS7DcBv8xY=;
        b=sitV7sYWWq093OsBS96BJzZ6Sdq+cYldHbo7oiC6FTRz16zJZW+OP+4VcDhdL+XFVh
         NO+xa2tVqcwC6lVW9bzpgV/eiej2PE/3olKgIBuugQUvzRq0KXmwGw8m+wsBNvJiurl1
         oqs3aBUmkzqE1O1XoqWr1yaOlR0PTxQ87Hol2GJvm8V79PDASuyJsROb7ypIAxyNHdZ1
         kxaDyol1+uqynAXV21VUgrgmK0kILIFFf6dKoOR7fa4oc06um+UXkkY6+k8HmwVfcdl1
         cWdWBuxQgdtZejR2CSk3h+W0lzHOdssAP+BODkoXsJdHuv5oMz2bIJEKx8RLZ9B58vMl
         fccA==
X-Forwarded-Encrypted: i=1; AJvYcCVxkAZIjeGwPGBK4SYwWf3CAT/VRL42Ple14Cb4M/mKstzMGu52SvZDE8z7DPeJUG1w0kFYjsgHvVRVUkFYTSGEBvm8N9d9+d+/Sal6
X-Gm-Message-State: AOJu0YzqDzSiWCJS5HSgu+1SRv2fZRN12FF118BCv1ZVk1SjsyQpgoXp
	RBC95fFwGlBGfJWa7mT5jwifIvu8ISjfTy+EMW8gHZ2FMzVRV9Rr0TrrOgRnP9JvtHzNASiSQkc
	8YxctN7E+Wgb3BZEZnsFNXxLr5Sz3Bk879ceGiunJRt1txRv4+nm9E9VVTdHC6SuBcvGqLR5D6R
	M7D/NbHdLFVGs6Wf2E4Jsk+9+ycIHoCh+dopUE
X-Received: by 2002:a05:600c:45cd:b0:418:9ba3:ee76 with SMTP id s13-20020a05600c45cd00b004189ba3ee76mr1378065wmo.4.1713528101564;
        Fri, 19 Apr 2024 05:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaFUZhMFYFAs3ZhsYYcBoV+2/MzoyjDzM+1t4+goj9WAVZ/2QAmnhBwnZ/PquJCML4YzG+HJVNxiJvWhvW6sY=
X-Received: by 2002:a05:600c:45cd:b0:418:9ba3:ee76 with SMTP id
 s13-20020a05600c45cd00b004189ba3ee76mr1378024wmo.4.1713528101121; Fri, 19 Apr
 2024 05:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418194133.1452059-1-michael.roth@amd.com> <20240418194133.1452059-17-michael.roth@amd.com>
In-Reply-To: <20240418194133.1452059-17-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 Apr 2024 14:01:29 +0200
Message-ID: <CABgObfYzM4tsoYtVdACtbY4ZXs4j2hrsVEafD9=EnqnXjoJ+2Q@mail.gmail.com>
Subject: Re: [PATCH v13 16/26] KVM: SEV: Support SEV-SNP AP Creation NAE event
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de, 
	thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, seanjc@google.com, 
	vkuznets@redhat.com, jmattson@google.com, luto@kernel.org, 
	dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com, 
	peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, 
	Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:45=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
>          * the VMSA will be NULL if this vCPU is the destination for intr=
ahost
>          * migration, and will be copied later.
>          */
> -       if (svm->sev_es.vmsa)
> +       if (!svm->sev_es.snp_has_guest_vmsa)
>                 svm->vmcb->control.vmsa_pa =3D __pa(svm->sev_es.vmsa);
>
>         /* Can't intercept CR register access, HV can't modify CR registe=
rs */

This needs to be svm->sev_es.vmsa && ... (see existing comment above the "i=
f").

Paolo


