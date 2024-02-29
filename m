Return-Path: <linux-kernel+bounces-87543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE886D5B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715D2B23F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2851504F8;
	Thu, 29 Feb 2024 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJx0nr8b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E48154BE3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240185; cv=none; b=hekeOcjqmTdOKVVSqIJSsNmXCbMl1umXaguU354WxjI9DBnhIuIVka/RDNr/VIlbQ17e0BmRpI58FMGsnG4ZPGSy+KpTmgSrtmXsNDQZZdluMdBmtJaJbHcHVqDhm0ZnR+iETiuXwZkDFV0diXqGQVK/qp49XQow5huiyJo3nvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240185; c=relaxed/simple;
	bh=fV1kqpZQ/sSCXlptOjdZ28ZJ5cm/XhJs99VfeV8ikn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMlNjOynoozlivV37D6Vfvh2p+YkuLAbfFWJYJucF63KyOotIE0FlLvUrHC0xQ4Yk+0V9Yv83LA6zwHCBmU8krX9ysHUd9pE7qOsGQ6oMhLmI4myv5edQQ8jNbnoGol5n8caMsXNXeKq1Pz02lx1WhDXOdBEFq0KSdwr+/EGPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJx0nr8b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709240179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiaPwrwhaqL9Ej4GtEw9LKGF9DdPVcepWFooDH+BsfA=;
	b=ZJx0nr8bUNfBOS1tqzq/XWJUrGy5Spnui3AWH2n+j/5WVKi0+TRPqqsLn04zAuN/CIxcd1
	D87dlziKWpGrBhEQxyFD3gQzPtUrpz8d1wuaSeHavDjxxNNlwYojvzg8WJJxYdmXF+Jmd3
	/7uaJk/KXkmEriU3K9pxbKwc6w+S5Ns=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-lk-veFmqN4aitpyYJbdGhQ-1; Thu, 29 Feb 2024 15:56:17 -0500
X-MC-Unique: lk-veFmqN4aitpyYJbdGhQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412b2321084so5287375e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240176; x=1709844976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiaPwrwhaqL9Ej4GtEw9LKGF9DdPVcepWFooDH+BsfA=;
        b=HukYMU+QoMklrhYSqP3yiBV/njlFIi9a+TfD9UP5YbWu+wBf4SjuRMqtAAKNWyoiXT
         temJU+HZ3zD9ASkxTOt2rsYf1ndN1tggSXX/2gLuR2TBm87uqHzVtOncXAvCKDGqNpiB
         z18uqWzjbQTdsGxIak0IxwxU3fjxJxC289hCAmKaMHy/zjED1yb6YlIPIi4pv2REmDf/
         JhArydmCDKV3crx/JqXnchOhodKo/Z3gvPx+3EHUmL7gf3uTkzEN77xiGuYc/ibV8WwF
         55FfQm9jSPt6AGeRY6B+uGUa1985k9hkNQTyUwwm8Z8xy5kX6+U1UHfL+NEG9H5ibuo4
         v9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWHrBoD1w24zsW2i8eGW1PILmGtXl/quUhabo8Y7sNM2XA+nsEo7bz84i7roFMSwAlA4//z3KsKvHqFJK2AIT+7xo6OQNrA56fzQN0Z
X-Gm-Message-State: AOJu0YzsHlKGMPpaqysJkOQ23EAwtV9gPs4ikPyJC3hDskJMsp2zSjgY
	KDEw/yXbePdOZvrg1zulVUXbKshID23XaLx/6SVz9xWWfZBzfuwd71DdsIuRMeWoV4bpGbUGjJc
	KigA2PQHs4UdNw7I67JSbM7qRlNg9CLc70uRdQIm6nAQvBX5Vedr9JUv5UrrUGzkUgGA6Ptk5uH
	qO+La+RhzB1fLaeZCZtxRe1gAAR2X1BbvJHz++
X-Received: by 2002:a05:600c:a386:b0:412:b6c4:ac21 with SMTP id hn6-20020a05600ca38600b00412b6c4ac21mr129744wmb.41.1709240176743;
        Thu, 29 Feb 2024 12:56:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/pLwxu7qVY+FEzPu28C2COXQu70si1JtMVmyrPRMvUbqeq+QPhQ4uW/IqUc+Dif1jUGUYHijFe39hpc6rWc8=
X-Received: by 2002:a05:600c:a386:b0:412:b6c4:ac21 with SMTP id
 hn6-20020a05600ca38600b00412b6c4ac21mr129737wmb.41.1709240176364; Thu, 29 Feb
 2024 12:56:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-3-seanjc@google.com>
 <CABgObfbtPJ6AAX9GnjNscPRTbNAOtamdxX677kx_r=zd4scw6w@mail.gmail.com> <ZeDPgx1O_AuR2Iz3@google.com>
In-Reply-To: <ZeDPgx1O_AuR2Iz3@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Feb 2024 21:56:04 +0100
Message-ID: <CABgObfaXQR7WaUwjvBz-1yJN3fyysj1BMyY0S9L3DbizWjgrSQ@mail.gmail.com>
Subject: Re: [PATCH 02/16] KVM: x86: Remove separate "bit" defines for page
 fault error code masks
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:40=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> Long story short, I think we should get to the below (I'll post a separat=
e series,
> assuming I'm not missing something).
>
>         unsigned long rflags =3D static_call(kvm_x86_get_rflags)(vcpu);
>         unsigned int pfec =3D access & (PFERR_PRESENT_MASK |
>                                       PFERR_WRITE_MASK |
>                                       PFERR_USER_MASK |
>                                       PFERR_FETCH_MASK);
>
>         /*
>          * For explicit supervisor accesses, SMAP is disabled if EFLAGS.A=
C =3D 1.
>          * For implicit supervisor accesses, SMAP cannot be overridden.
>          *
>          * SMAP works on supervisor accesses only, and not_smap can
>          * be set or not set when user access with neither has any bearin=
g
>          * on the result.
>          *
>          * We put the SMAP checking bit in place of the PFERR_RSVD_MASK b=
it;
>          * this bit will always be zero in pfec, but it will be one in in=
dex
>          * if SMAP checks are being disabled.
>          */
>         u64 implicit_access =3D access & PFERR_IMPLICIT_ACCESS;
>         bool not_smap =3D ((rflags & X86_EFLAGS_AC) | implicit_access) =
=3D=3D X86_EFLAGS_AC;
>         int index =3D (pfec | (not_smap ? PFERR_RSVD_MASK : 0)) >> 1;
>         u32 errcode =3D PFERR_PRESENT_MASK;
>         bool fault;

Sounds good.  The whole series is

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

apart from the small nits that were pointed out here and there.

Paolo


