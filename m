Return-Path: <linux-kernel+bounces-40475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212083E11A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59951C21A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CC820B3B;
	Fri, 26 Jan 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGc/ziW9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884020B12
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292760; cv=none; b=RjZ431PIVJTrRINs4YaVTnvVct04+i8/ZtVwt4+tN5woQAUlmBIs1FogDOZ2kHhobTBCEDV64LOcmkAs5Cd8cMDmbIY8saISEQZWJKQ7mMjulHQq5FbDiJ1w9eYkQsFJl4C3loOITenn2O/37LKB7ozhK0KZb0EG0sN3IHJ50aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292760; c=relaxed/simple;
	bh=6yCOi67LSlnU+pmKW/Ep4Ha9/RlzYxbaLQYCGWndYNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCxdp7jKNCeVyQQTmx3rIluo4+2haFdmPfdRlp25O1zkZk5hGrUJZZlYB8bNjsAejbAyK50XOXxQ6krB8Qqb1WI3BvfBy0ZkeW8W10/IM/dxpyVxF2/4+E3o8LFyhpoHh/eUAtGMVZEjvkojpyCO73E5ABkpWrN55UxVWqTtiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGc/ziW9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706292758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcV+9Bo1H23A9wxX2UhBXjVrN11bidIv7zn0dsKCWms=;
	b=CGc/ziW99IYRgNoSWJpPT1TG6eTKsuE2X11C9QutBNhciUXZIIvZRqSYRNeyeYFafVaw+J
	qiEzVlJROQr5qV1lwK5WxBBhdkEvxLR8VokJm4vwDBLyuk4vi7SfdoPPDhQ6XC802LTQxM
	K60hfmhOGyo0VSjgVTnVn56EE2jCFLw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-RJa8FW8bNEu9MYcHY56OkQ-1; Fri, 26 Jan 2024 13:12:36 -0500
X-MC-Unique: RJa8FW8bNEu9MYcHY56OkQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-598f047f034so675074eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706292756; x=1706897556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcV+9Bo1H23A9wxX2UhBXjVrN11bidIv7zn0dsKCWms=;
        b=VMHSglzqI/2ZQhWwedrJdgzyB8vP+Qt0yk2WUaV9bEm5D9xLveLSI9YnC9xYiniMOK
         M5RcfxPZ7TW//+4k9cYO8JNI8Z3TR7bh53yC+SG/KbbVV4joZSUtCB1vB/PKYyrT6N7B
         ASCa6OsX19rgiyXUH8pb9vxBBQLdgfbEzjtuC4RwnbF5mTmmPM82oX3AI22lzXn3kpw0
         5rd69vd5InCdK5KyMYMPY8gZS3e1j4iEJlBvod5j1u+Key3k8hWJ5i/qmgOdNHB1jK8W
         1rLk452b+S1AoG4oSxacLq5dFIWmq6Rp4Eckh8XGGbtzs+ts/pGYVUe5DTPhSR2EgTEY
         8TyQ==
X-Gm-Message-State: AOJu0YwXvZlb2rtnFOoz3UKhLrKeNqJYwCZrGJqPLSUd5Da2iFWgqCgi
	OklD7xuj6BWgtioSfTR3FOADQ9A6vnYqHa+ZBNXS8MBdxEdoTTYXso2h2fXmcpUVaMTgMhJrCcV
	PZnffnFcmOy5+0M7pNZyBumNWBsw9AXGvqIvfmNqCF06OmxRdGJJm4GEOwksuPM1VZHXaJ3zNcU
	xC9uMwrG1b7vGRRikbEwfj3W/AZNaBbDTKk1Ga
X-Received: by 2002:a4a:bb13:0:b0:59a:f1e:9b3b with SMTP id f19-20020a4abb13000000b0059a0f1e9b3bmr31624oop.16.1706292755830;
        Fri, 26 Jan 2024 10:12:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWdCtjgO3580n6V/ysz5cdqBhP2YbS7PowzyjTwjU/nOPK/g3zR7PIHStrWznjt939pfIl/ZSUhr6xwGM74cg=
X-Received: by 2002:a4a:bb13:0:b0:59a:f1e:9b3b with SMTP id
 f19-20020a4abb13000000b0059a0f1e9b3bmr31613oop.16.1706292755620; Fri, 26 Jan
 2024 10:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbGkZlFmi1war6vq@google.com> <20240125050823.4893-1-moehanabichan@gmail.com>
In-Reply-To: <20240125050823.4893-1-moehanabichan@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jan 2024 19:12:24 +0100
Message-ID: <CABgObfbjzmv3WiVUMpxLHHYYf+EyvGxRvaMR0_-PkiKGOmSsxg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Check irqchip mode before create PIT
To: Tengfei Yu <moehanabichan@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 6:09=E2=80=AFAM Tengfei Yu <moehanabichan@gmail.com=
> wrote:
>
> As the kvm api(https://docs.kernel.org/virt/kvm/api.html) reads,
> KVM_CREATE_PIT2 call is only valid after enabling in-kernel irqchip
> support via KVM_CREATE_IRQCHIP.
>
> Without this check, I can create PIT first and enable irqchip-split
> then, which may cause the PIT invalid because of lacking of in-kernel
> PIC to inject the interrupt.
>
> Signed-off-by: Tengfei Yu <moehanabichan@gmail.com>

Queued, thanks.

Paolo

> ---
> v1 -> v2: Change errno from -EEXIST to -ENOENT.
> v1 link: https://lore.kernel.org/lkml/ZbGkZlFmi1war6vq@google.com/
>
>  arch/x86/kvm/x86.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 27e23714e960..c1e3aecd627f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7016,6 +7016,9 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned i=
nt ioctl, unsigned long arg)
>                 r =3D -EEXIST;
>                 if (kvm->arch.vpit)
>                         goto create_pit_unlock;
> +               r =3D -ENOENT;
> +               if (!pic_in_kernel(kvm))
> +                       goto create_pit_unlock;
>                 r =3D -ENOMEM;
>                 kvm->arch.vpit =3D kvm_create_pit(kvm, u.pit_config.flags=
);
>                 if (kvm->arch.vpit)
> --
> 2.39.3
>


