Return-Path: <linux-kernel+bounces-58481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D562084E707
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B0DB2565B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B2A84FCF;
	Thu,  8 Feb 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoaTxKRj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011182D8C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414365; cv=none; b=oRR4Q7oBz5yJyjP4A51j5Lhjuib70OybIDNJ4jD835TWSAQtRro+k8s9pAY1E8UWYV+cU0t6qI3AXVuNaUwfZQTgT+LN3n/ySB7kW/HCGtShmBPrtUeLsxa+j130zZvQcRTux3ZCubXW/Eb//5FjP3FDJBb3mpJRZk4x4dfrpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414365; c=relaxed/simple;
	bh=f+PuXbNhXMTQKCE8D1ReIzehabsulG0iotcVaoV0u04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rq5lX66kqhR4I6hfC+5oqAWeZJ63CeEZ0VQzFlgYXLrBNEzpJKQ9Riw5qxbNtKaGJzUSxbm5aDsZooWSYdHFRQNaY/7f4tZLbfXStGzweGGmBviB53oS7F3MwEQsoG8zqX/piYCKiH8LK+DayK1jEzdOFHiFJ8Ccq477AIyWU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoaTxKRj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707414362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8X4EhnjHNg6ZybPIUTxfj0f8bu4Fo5AJsqmmWpX13E=;
	b=hoaTxKRj0hwUzwSf7HfCFwO/LvcA8IkkdawWFpjk9mdfE7o2M0caeMxvcmyhLOyecE0kq9
	5f/oSVpVAZ673+g+SMW+MVBB7S6ufqAIIEvobmjSwKRuRxfVHbUWXZYyM4EqUEOE56GeAT
	Xv+cfOLjBM08ttCZ0uwrbiAs/gWDhI8=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-FLVz5ynHOc-PCYrYvAPkRQ-1; Thu, 08 Feb 2024 12:45:58 -0500
X-MC-Unique: FLVz5ynHOc-PCYrYvAPkRQ-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-46d2776dbc1so18629137.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 09:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414357; x=1708019157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8X4EhnjHNg6ZybPIUTxfj0f8bu4Fo5AJsqmmWpX13E=;
        b=nr5iNe9s22nOh3KGJ/qgYTnbTasw3PmfW0ZSY5DH7Z0dXbiMJ5+b47cWNmZ9/l+YYB
         ydWY3GYqKuVZvjtXdkBNnGiHelOCRLx38QWtKExm3cJgxCs0XCsdlBnOresKRU3uJBVG
         cUz0vH3UzSYCSyKvXRwDIpVxLLxjwcZ8lAHaPIsP6PccHeoutVdvN8cFy0Qcn5GdwkOz
         uBy2zSVRleD0rMoLaFFz7RrK6RSvJCoZVaX8NJ8V6K2ZJANvvLCg4mChMTlvvQC++j8L
         sVmP0hvBour1z3CevrTTE05Y5n9znLuMkN062Vvqi42SQZOcv2aNMxuK0j6d4l3GkQdE
         mwtA==
X-Gm-Message-State: AOJu0YzzphjL9jkx8/wWEYjN6oZAIGnczp74mJW+6HfmHZqq//ecYm7J
	ke98g+YazRhpWCrs66zA5taf87XCJw7DTJKHToc8D2JrrT4SfaBG3io/blTa6OrdunNnI2agPBj
	75LkFHnMs9ojQWllqYwOfZOt8IGruawjLeNa3WWNNtSvEY6Ko/jotv6Z8+cAoueyTrRYhSdHUqp
	SI3LrGtsobavrib+rQBqUYMvpeoOBVTIOEJ4US
X-Received: by 2002:a05:6102:754:b0:46d:2083:14d1 with SMTP id v20-20020a056102075400b0046d208314d1mr23911vsg.10.1707414357389;
        Thu, 08 Feb 2024 09:45:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFjZYAC+poB2A8bKFCXFb8kn7FgCzxPV6IsYhUCAgELoYofUjEzpN8/jetwu7l5YiegAIAgtJ1gKO1+GPVsjw=
X-Received: by 2002:a05:6102:754:b0:46d:2083:14d1 with SMTP id
 v20-20020a056102075400b0046d208314d1mr23887vsg.10.1707414357128; Thu, 08 Feb
 2024 09:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123001555.4168188-1-michal.wilczynski@intel.com>
 <20240125005710.GA8443@yjiang5-mobl.amr.corp.intel.com> <CABgObfYaUHXyRmsmg8UjRomnpQ0Jnaog9-L2gMjsjkqChjDYUQ@mail.gmail.com>
 <42d31df4-2dbf-44db-a511-a2d65324fded@intel.com>
In-Reply-To: <42d31df4-2dbf-44db-a511-a2d65324fded@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Feb 2024 18:45:44 +0100
Message-ID: <CABgObfYa5eKj_8qyRfimqG7DXpbxe-eSM6pCwR6Hq97eZEtX6A@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: nSVM/nVMX: Fix handling triple fault on RSM instruction
To: "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc: Yunhong Jiang <yunhong.jiang@linux.intel.com>, seanjc@google.com, mlevitsk@redhat.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, dedekind1@gmail.com, 
	yuan.yao@intel.com, Zheyu Ma <zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 2:18=E2=80=AFPM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
> Hi, I've tested the patch and it seems to work, both on Intel and AMD.
> There was a problem with applying this chunk though:
>
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kv=
m-x86-ops.h
> index ac8b7614e79d..3d18fa7db353 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -119,7 +119,8 @@ KVM_X86_OP(setup_mce)
>  #ifdef CONFIG_KVM_SMM
>  KVM_X86_OP(smi_allowed)
>  KVM_X86_OP()                 // <- This shouldn't be there I guess ?
> -KVM_X86_OP(leave_smm)
> +KVM_X86_OP(leave_smm_prepare)
> +KVM_X86_OP(leave_smm_commit)
>  KVM_X86_OP(enable_smi_window)
>  #endif
>  KVM_X86_OP_OPTIONAL(dev_get_attr)
>
> Anyway I was a bit averse to this approach as I noticed in the git log
> that callbacks like e.g post_leave_smm() used to exist, but they were lat=
er
> removed, so I though the maintainers don't like introducing extra
> callbacks.

If they are needed, it's fine. In my opinion a new callback is easier
to handle and understand than new state.

> > 2) otherwise, if the problem is that we have not gone through the
> > vmenter yet, then KVM needs to do that and _then_ inject the triple
> > fault. The fix is to merge the .triple_fault and .check_nested_events
> > callbacks, with something like the second attached patch - which
> > probably has so many problems that I haven't even tried to compile it.
>
> Well, in this case if we know that RSM will fail it doesn't seem to me
> like it make sense to run vmenter just do kill the VM anyway, this would
> be more confusing.

Note that the triple fault must not kill the VM, it's just causing a
nested vmexit from L2 to L1. KVM's algorithm to inject a
vmexit-causing event is always to first ensure that the VMCS02 (VMCB02
for AMD) is consistent, and only then trigger the vmexit. So if patch
2 or something like it works, that would be even better.

> I've made the fix this way based on our discussion with Sean in v1, and
> tried to mark the RSM instruction with a flag, as a one that needs
> actual HW VMenter to complete succesfully, and based on that information
> manipulate nested_run_pending.

I understand, apologies for not noticing v1. Let's wait for Sean's opinion.

Paolo


