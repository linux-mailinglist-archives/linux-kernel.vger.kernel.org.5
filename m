Return-Path: <linux-kernel+bounces-40466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E924283E0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05D7282FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F3208B0;
	Fri, 26 Jan 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXih+yPE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E1E208BA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292083; cv=none; b=FuemvBVK7tX9C9jR8p57+Tr2HfxPsgy6i8VBZaYNfuh1bNMWUHJ6PkhJ1oKf3o+JhcvDiwOtTfnlDb+UMZB9C5Hzew860gMsWp5rabfLvLwzxxtKgi2nC1AVlVtrHrwqRxZyuQ4BpR0xOGPKuAv36c1GTjL0d/L5aV18orvtSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292083; c=relaxed/simple;
	bh=ILNAcCRYxFV2hBwDPjxHOp/jkyTMR71/MVIQgy9Ru1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFhvWei4qSGu9qw0Z9QZPaXTcaRhAGjAXdCeO6STKf/4NwtezmWQLs8rCpR/S9bWw+LIBbZ9LPJcFaG2Z/nyNa1c69GRCO3aFFe3kMLXV22Bj0I5GXQbD2HVm10LWx/DdchQLz0hKay05ofsDihBg8649+Kcq2slQeiE4YJVHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXih+yPE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706292081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1idEZmiqZ0PAWapQhsolthHnuhF6TvOu+W3q8ZLhUs=;
	b=IXih+yPExA88Q8XQBhWU5uO8z6+Yb+ppVtuz39YfvPz29KZWA47/JMbMowV/LYTxl+Aof9
	RXi34dlESDlCfxRn+hxkTHQ//5HW8bnWMLwMpUqnK9LgM4zQk1ff4TYtv9GvOZLpx08dY4
	BcIGxWepZ4NxbDG1aNo+ib5YBJD/I8U=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-b9P8I73oM7COiVsz9sYaig-1; Fri, 26 Jan 2024 13:01:19 -0500
X-MC-Unique: b9P8I73oM7COiVsz9sYaig-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-59a0b1bb6b1so611673eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706292078; x=1706896878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1idEZmiqZ0PAWapQhsolthHnuhF6TvOu+W3q8ZLhUs=;
        b=SmwojdsNaWugJFpb2NL9waSodYlOAHE7KzL/wiYbTIugE8axm85wfc0cUmfHnBvDbm
         /GOksdNwp/Klft/q4tbswT7gC3O3hXpofS1QV938kvzSOlDbExqgkfZiz+8zZi74f2lE
         YGQjQfD5toDIhOr72qJiFghZy6wATS2UzFCvbWM7l8gw3TN26a7S/2uZkmZ/T2h41eSK
         WMkFr/Fw9WMBiuhGFcIwdtrNZu8cLNTEuIj32EnT+/DKLmav0nCJvx5ZRV6ejNrT96Pj
         F/LfA8u4JhrMolG1H3SR5VvDyQhBO/nTrJ/z4pJvKJ1PKOJqqzEabbRBvR9ruzYVgSye
         KJYA==
X-Gm-Message-State: AOJu0YzWJhk9zGG9KkfCqI+5fCgCRT4VsWcK+MY7YxAUCIve4xKe3nCt
	OMXMDUaaLlIQ3xRExqiWdrWEuNu+GLC+QEjxBra+QEnmvWTZA3C/e9FgOZcX+zf6Mm9cghueuHm
	LZpweWl7QQK6JZcuZMwkI0hGXdWpud5ag/L4WuhN+JnCsnwZ4Tj4QtCVjQFyO4av+iVA5H37GMS
	G0xFzmo5bfQVh10jEo2m70oxIjOItcO3ALtcKK
X-Received: by 2002:a05:6359:321a:b0:175:b57e:7be1 with SMTP id rj26-20020a056359321a00b00175b57e7be1mr63141rwb.52.1706292078524;
        Fri, 26 Jan 2024 10:01:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/FiWt3RhBG2eZaUchUIE9MWYT+Vtp8D1XAoXVuiI7s21J/GldQs2rrbA47me4Q5yktW3RDvlHGE5BtjxRS6Q=
X-Received: by 2002:a05:6359:321a:b0:175:b57e:7be1 with SMTP id
 rj26-20020a056359321a00b00175b57e7be1mr63124rwb.52.1706292078152; Fri, 26 Jan
 2024 10:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115090735.2404866-1-chenhuacai@loongson.cn>
In-Reply-To: <20231115090735.2404866-1-chenhuacai@loongson.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jan 2024 19:01:06 +0100
Message-ID: <CABgObfYbv_rHto8eEWLB3srmCPj6Le7wDfG5XtYpUH17HBTcCw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Fix build due to API changes
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 10:14=E2=80=AFAM Huacai Chen <chenhuacai@loongson.c=
n> wrote:
>
> Commit 8569992d64b8f750e34b7858eac ("KVM: Use gfn instead of hva for
> mmu_notifier_retry") replaces mmu_invalidate_retry_hva() usage with
> mmu_invalidate_retry_gfn() for X86, LoongArch also need similar changes
> to fix build.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Applied, thanks.

Paolo

> ---
>  arch/loongarch/kvm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index 80480df5f550..9463ebecd39b 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
> @@ -627,7 +627,7 @@ static bool fault_supports_huge_mapping(struct kvm_me=
mory_slot *memslot,
>   *
>   * There are several ways to safely use this helper:
>   *
> - * - Check mmu_invalidate_retry_hva() after grabbing the mapping level, =
before
> + * - Check mmu_invalidate_retry_gfn() after grabbing the mapping level, =
before
>   *   consuming it.  In this case, mmu_lock doesn't need to be held durin=
g the
>   *   lookup, but it does need to be held while checking the MMU notifier=
.
>   *
> @@ -807,7 +807,7 @@ static int kvm_map_page(struct kvm_vcpu *vcpu, unsign=
ed long gpa, bool write)
>
>         /* Check if an invalidation has taken place since we got pfn */
>         spin_lock(&kvm->mmu_lock);
> -       if (mmu_invalidate_retry_hva(kvm, mmu_seq, hva)) {
> +       if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
>                 /*
>                  * This can happen when mappings are changed asynchronous=
ly, but
>                  * also synchronously if a COW is triggered by
> --
> 2.39.3
>


