Return-Path: <linux-kernel+bounces-48431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203AD845C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7682FB2E5FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFDC626BE;
	Thu,  1 Feb 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mhud7vc+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809B626A6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802389; cv=none; b=JPMMjZXJRJOuKtkH6zu+Qq0ykio7M8GsXJ/WvgEPJG2jMQLuujBeHd0dfBNNs3M16a7Q0CsDDMIGJpIU1Ni0CacXUKpSczATT0JF3C3SGlrDT4waUphQ4kryasLxmSgovY6aHv8ElsDDFI2jLIKwXrzhvSM93yeErLIEym8lavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802389; c=relaxed/simple;
	bh=FNJHQ8pJXT36VqFlM1SA6DkMrPT0+YUA6Rj5q50WrWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTUct7eksGCoeGIel+sQxfSlzeZAUKGYJJ4UrJBAtnqM+6Vu8Z18e+6kKcVOBn1uVNTM1Me8bG6MOnn/osnasULg56KHK1K4iEZalijShXXWVFI29Dx6gBRA/OeyljRMLxThEqG2auZMBlpR5bE+Qqw34bf/ACQkxf6RJKI9hJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mhud7vc+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706802387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEOm7jSo2AEqVXKKLj//3vg9u/H5Q/zbUzqoRszUSKY=;
	b=Mhud7vc+YG82ZxvsWmavbMU2b7W4T6MTUha9FPYi6xr1HFOLvo6IrnkRvI0p5ALngkuZqp
	RL6r2rURIko2o3oQEEUPZbpwEqDSpiv1xgnQZgYMuUQSUmt2Hg/a18fxtr7OtisHrdEPUm
	2KyOlOxkuV9VUUppu78KiCs/rzMKmdI=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-kEaD2O7qMROkvSYFi7E4nw-1; Thu, 01 Feb 2024 10:46:25 -0500
X-MC-Unique: kEaD2O7qMROkvSYFi7E4nw-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-46b33bc35fbso425631137.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802385; x=1707407185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEOm7jSo2AEqVXKKLj//3vg9u/H5Q/zbUzqoRszUSKY=;
        b=LGejGamZWle/n+tCyAmTJwBUqy8CRSfxWHd/r1m/89zPmn3k+QQPVYz8S/rZqw3ypJ
         gRV8wzR3bQ2Nlg5WCFKbNJ+ARRIY+7P3euH24u//QCDgpkEzkuGGulmaiHi7XxaIObHN
         WRy21mwCXbCxTyPqGjFLKJnpYyr6HQK3cQSAMYIkDfdjbi/0uAGdFDjy3Oo026miXs6o
         GW8dERo+4tvRW2Wr58kQ+rnYvV8O9eIHzBKp90fGicPm6Z82nB+frt7IfD7b4zC8Txjz
         vSik4Jsw1C/j97aSSmSiWQ7NGeHfGVH6oOlv0ug3+C3NmreFQGoxxs83Qn0AyblRqMNX
         7qnA==
X-Gm-Message-State: AOJu0Yx1HbUdTpuKk3kdpQZ3T+Q+7apcZJv3gvJxeAs5ODIxLi8attO/
	wEpGwEgMIEWojvAcd8VsBflRJjHwfaWA4eZnDD0uOxb6KEUd51K0HKPGmrIpErJ/p880N/KX3aw
	4lPiCjZixMRO7SzYcOG6/HLvt2ZBZWFE0OmuAKcgNE0dkiclRqi/OTpe+fw5XEv9Iez7hyY0LM0
	CRdYUosmn6xejXJLmYdLskHalT2tZRR4kdMY+Z
X-Received: by 2002:a05:6102:18c5:b0:46c:fc71:584c with SMTP id jj5-20020a05610218c500b0046cfc71584cmr62838vsb.22.1706802385194;
        Thu, 01 Feb 2024 07:46:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX2rN1Zzn1bhCilbvAuGtiDDUAvnFKPvLtzVG6cM37SpLqg+N2G2IXDzPX4jRggQvgEuxXLfhBq12/eBBNo+M=
X-Received: by 2002:a05:6102:18c5:b0:46c:fc71:584c with SMTP id
 jj5-20020a05610218c500b0046cfc71584cmr62823vsb.22.1706802384969; Thu, 01 Feb
 2024 07:46:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220151358.2147066-1-nikunj@amd.com> <20231220151358.2147066-11-nikunj@amd.com>
In-Reply-To: <20231220151358.2147066-11-nikunj@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 Feb 2024 16:46:12 +0100
Message-ID: <CABgObfYwtMQY-E+ENs3z8Ew-Yc7tiXC7PmdvFjPcUeXqOMY8PQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/16] x86/sev: Add Secure TSC support for SNP guests
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com, x86@kernel.org, 
	kvm@vger.kernel.org, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, dionnaglaze@google.com, pgonda@google.com, 
	seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 4:16=E2=80=AFPM Nikunj A Dadhania <nikunj@amd.com> =
wrote:

> +       /* Setting Secure TSC parameters */
> +       if (cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC)) {
> +               vmsa->tsc_scale =3D snp_tsc_scale;
> +               vmsa->tsc_offset =3D snp_tsc_offset;
> +       }

This needs to use guest_cpu_has, otherwise updating the hypervisor or
processor will change the initial VMSA and any measurement derived
from there.

In fact, the same issue exists for DEBUG_SWAP and I will shortly post
a series to allow enabling/disabling DEBUG_SWAP per-VM, so that
updating the kernel does not break existing measurements.

Paolo


