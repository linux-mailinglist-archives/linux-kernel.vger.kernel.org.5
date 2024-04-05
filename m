Return-Path: <linux-kernel+bounces-132727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8796899957
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6807CB216E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70CA15FCFA;
	Fri,  5 Apr 2024 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEiy9Vug"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347ECEEB2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308897; cv=none; b=evBADD8r3KdqvbsmjQT4YxhcepaIgNbInO6If60u9J5cQx5yC0mFJL2EyaPtrD9EEbgeUc//sdO5Ev7grA6LLNafbEehimYtAIQAMsXLOdsbDeDXX7kOilszGBhOSTJlOe1pGXplk2PdfO7oAKGfjp0ymIExUNspOWBdDEcXnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308897; c=relaxed/simple;
	bh=kXYJax6SMc5fEX2Qq3xhhaKTyorpIOKA/K5ZRGBzgoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHUtu9zKBlI99q8qHLhI0YKMWYzsrhrgsks2W30kTC2vLqRBcQIiAeAkiTCUpXBlX1jpXsebjF/HCmVc+gdqxpV7dmiWd8KvBw6H1Y7I9DrzPHblcGAWIridjUMOL6OioaSjhC2eqCLzYFodsIsnfgproOX850yINVGcAFVbQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEiy9Vug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC865C433B2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712308896;
	bh=kXYJax6SMc5fEX2Qq3xhhaKTyorpIOKA/K5ZRGBzgoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AEiy9VuguSsSP9FTOQZVjzlN9g+yYG5W2C6YmlATBWCiEQ1LOHjrhvb+8aTbUP2rT
	 sCP4EAeVf38No9iaKZfWYFUlJ7VXeEpZjsAXO/LrBFbpID9itooKSJ7rfMkHKBXJCn
	 OLp2dzop5QvtBgbJxfmhkIwk70cJn5mvB8UvSMMXBaNzQROFkXc0nlIwAwTEtmNGtT
	 O2+R0aUZseK6o6+uDAev04QkNvq3keFMdU+uREVDnS3eoR0oTUUl23sT0vpa+hy4od
	 K+lwjcwv2ItR3TZTqsdpmP0jXdtP2N1qWCo04cJ+l+tKsAESfwrEQlU8w2aQC17yLn
	 +sOjnUFj1824Q==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e2ac1c16aso1103858a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:21:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEoM7jfBG7k6ZGxW6++pU9eYJTVDmkRvbR0MnQtem4CLqqg8llgFDgNyqbZ6kIUUfCpDkfLspnNSd0+M8dbPqvIQ4kj/54chkt6dG2
X-Gm-Message-State: AOJu0YzOikXHjA9cZ/TMwWTp6mqMzyFK+DyQeKMBORBGTXZs0I3a4S/M
	XCcjIO3kR5JF+3pKt5gmiPWwOjYePOiLZF4OQSFUW5bD+QlMlbrsHPbSN8ygDu0sEzcLYORxVHE
	a+8MchRqiAF2/872WS3psXfMXyaA=
X-Google-Smtp-Source: AGHT+IHsvYvyZPc/Yacto/gLkYNUVzXawnN29Wxuvy2uRdc25PRnaix45JPTuO4eKx1jWxTqOetLynPZ9Yk3hTqjdsw=
X-Received: by 2002:a17:906:454f:b0:a46:d5b9:c2ae with SMTP id
 s15-20020a170906454f00b00a46d5b9c2aemr586797ejq.32.1712308895263; Fri, 05 Apr
 2024 02:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404133642.971583-1-chenhuacai@loongson.cn>
 <20240404133642.971583-2-chenhuacai@loongson.cn> <20240404112518.51204544a4e73c2639ce53b1@linux-foundation.org>
In-Reply-To: <20240404112518.51204544a4e73c2639ce53b1@linux-foundation.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 5 Apr 2024 17:21:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6pFfFuLE9ARPCXS-5d1==H7hiEfySPnQdQbf-kiXx_XA@mail.gmail.com>
Message-ID: <CAAhV-H6pFfFuLE9ARPCXS-5d1==H7hiEfySPnQdQbf-kiXx_XA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Move lowmem_page_address() a little later
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, linux-mm@kvack.org, 
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:25=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
org> wrote:
>
> On Thu,  4 Apr 2024 21:36:34 +0800 Huacai Chen <chenhuacai@loongson.cn> w=
rote:
>
> > LoongArch will override page_to_virt() which use page_address() in the
> > KFENCE case (by defining WANT_PAGE_VIRTUAL/HASHED_PAGE_VIRTUAL). So mov=
e
> > lowmem_page_address() a little later to avoid such build errors:
> >
> > error: implicit declaration of function 'page_address'.
> >
>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>
> Please ensure that it spends adequate time in linux-next for the
> compilation testing.
OK, thanks.

Huacai

