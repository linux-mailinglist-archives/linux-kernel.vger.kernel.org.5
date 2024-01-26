Return-Path: <linux-kernel+bounces-40522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA7283E1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A55AB2383B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A422325;
	Fri, 26 Jan 2024 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZELKKWi6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6240A21370
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294633; cv=none; b=Mk55cWlpuHK3YbcN3LboaSkIEtBWcKpsOuqiZZ5xGwu6Z74fWF0LPChdVfcY5sFmCjITbJRn9C+M4U+wKcE6qkbZctHkQi6/FkQvuEa9PLZ6zgfEA2/qCLOrXk7kQHOZtNY3NCeTgMu69oI7T6D35fB1kYo1pePLXJF733R9j+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294633; c=relaxed/simple;
	bh=GTDjsu6rhEo2jOBPARRAChZuzZfYp4I5irbMSymKoVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPhwOifSc5VDrb4VlPilqk4isVXd3cuvwLcziKEwv7s4YFnBWwUDFZ3ZFovNitJjx2r/LO7sN+RPhDcJY82X4SqnPOiOLVB2txVD9vCMaelqfDfPmWrF+khl50tdFzcCjD2lnEajcvCu5zTa7wO74VMTQ6JiySGlwMVO9tUQlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZELKKWi6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706294630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjr2qXp3L4j2942eOUz5zFFxnCl3RL5KDAtLwwiTpOk=;
	b=ZELKKWi6jjxTiIl/IXyv75/S/Kh4GXV9VvHW8/H2BYjmFpPh0Kx/lSxKP/Iv4z30iDaFME
	EcQBmjzAytmvY3oiEsp+r1ufiHM5YZlbOtB4S1+Lma44pLr9FUqr5JFD0RHCRt1cpwKEe8
	aPcH7TA5RLcyR9T1OOJqb/9h5bJJUaQ=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-reLP8AnaONmJL_jpE39CSQ-1; Fri, 26 Jan 2024 13:43:46 -0500
X-MC-Unique: reLP8AnaONmJL_jpE39CSQ-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-468141d0ad0so204182137.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706294626; x=1706899426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjr2qXp3L4j2942eOUz5zFFxnCl3RL5KDAtLwwiTpOk=;
        b=GUui+26WcK5liPqNWhG/Ikk7Cub0fTWj5FY2+/fLU1NcoJ/C5shS3zEuQe0mjFJRIM
         LBCb/VdwaxUkcUroFqQ0sd1GmiSRs3HzdFn0Qfypjte9/LheLxCVih0rzGHA6ukTsz3P
         AN5HUfJd3lqIM3C+ge/Uj526BLViNjnYKBbzyXFXtlwt0SZACTsDbEuCxOKufF4di7xH
         AK21q5a01/VjZuNIR41SmzbL6dsR71GKinBWhb6fbft4xGsxhzy11OK7bBswcaXj0mhP
         tjMnL49JTwQds44G8lic2B9V4tEMElzs3sIm4Sbj84EkuorRDc9rkndW1h/4R+CUJGcM
         TRwg==
X-Gm-Message-State: AOJu0YzarePxqea7Gz0uRe/gkIsrBSSgMg16Z+6E5jWFrY6H3z5pkV8t
	ULv7K/n067ZfQ0MpZ6LKCEXBoPzO78xrHjMNkxkT+opy/tXD4xz976NwjXNAVUN8bsygB5SsjzG
	fVP9wqV3x5hU4T3FQvDSUGLvXdZh0+vsrycrAY1S2Vl/wUfGvhyTEXheBKa/2Gx5e7930X5+KFN
	+08VcScVVD9Etm9vvJI/3LEZhhmO1xP4aoqZlv
X-Received: by 2002:a05:6102:2929:b0:46b:2484:706 with SMTP id cz41-20020a056102292900b0046b24840706mr291432vsb.1.1706294626200;
        Fri, 26 Jan 2024 10:43:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeiYnaGwaRTPw/BuT1W1AJZWARSelaRPkVdIBhgQa1W/zS8FnDAO3yU8hld1a5HB0rBdrk+7Re9sseBLVfHU8=
X-Received: by 2002:a05:6102:2929:b0:46b:2484:706 with SMTP id
 cz41-20020a056102292900b0046b24840706mr291419vsb.1.1706294625961; Fri, 26 Jan
 2024 10:43:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124130317.495519-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240124130317.495519-1-kirill.shutemov@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jan 2024 19:43:34 +0100
Message-ID: <CABgObfbQ72PQ5u06cOeowjzWqiQmWNn83xOWGE12R363dWOK_g@mail.gmail.com>
Subject: Re: [PATCH, RESEND] x86/sev: Fix SEV check in sev_map_percpu_data()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 2:09=E2=80=AFPM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> The function sev_map_percpu_data() checks if it is running on an SEV
> platform by checking the CC_ATTR_GUEST_MEM_ENCRYPT attribute. However,
> this attribute is also defined for TDX.
>
> To avoid false positives, add a cc_vendor check.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 4d96f9109109 ("x86/sev: Replace occurrences of sev_active() with c=
c_platform_has()")
> Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
> Acked-by: David Rientjes <rientjes@google.com>

Queued, with "x86/kvm in the subject".

Paolo

> ---

>  arch/x86/kernel/kvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index dfe9945b9bec..428ee74002e1 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -434,7 +434,8 @@ static void __init sev_map_percpu_data(void)
>  {
>         int cpu;
>
> -       if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +       if (cc_vendor !=3D CC_VENDOR_AMD ||
> +           !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>                 return;
>
>         for_each_possible_cpu(cpu) {
> --
> 2.43.0
>


