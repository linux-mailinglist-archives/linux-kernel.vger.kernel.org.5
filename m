Return-Path: <linux-kernel+bounces-118295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C66088B758
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3561C3655E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA35A110;
	Tue, 26 Mar 2024 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gMV4OzaU"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F943AC5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419590; cv=none; b=DE8kz7D37Lc6eJITT+/vrpgmFqOoBYH+huJpdnkAk861Hxc5IPa3GmatwjNmqpf5g4ZmwLiv0+L6659JaAaYuddLT5yihRy37g1akkgGErpwobk4KWMhp1Px9rW0Xls32i/0fvXl5PZZk30zSseLnG/OgMBZIvbdsn57GWFkaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419590; c=relaxed/simple;
	bh=DzA4iTSRfcMkSiWx40hDp/d0kxPk4iivjd05tRZ0Ytw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fyq6EkIdDPCfLGOA8/Iy9FnwY3CeuBgtAPj5XYBq+gW7Fveqfhxy/eipV5buwTZU6LmPlZSnN1naFv2fPSY/EfGy/it6Bgu95qQQhIYX4Y5EspwBpCcVoJAGjvm6cGITmMF7l2VdKrPtdYuAYVW0kpL6R48d98dfSpqyWbZNWZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gMV4OzaU; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso4968860276.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711419587; x=1712024387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwUWm3j1zJRZURenFwbWO1vD1+nvI5/zaM6L0hDa+ys=;
        b=gMV4OzaUqXj6cWO3esWsRB1q8K3Hdz6UBF+wi1xjKJIpS9UtlI2XVh4hp2HXrhCWt5
         b7e6GOEJ6kAvwLapWAKeTDjZu9qg7fQcKuC+U0K8ubAM85hqRrQAGhi6f3Ed6/6Hcsq9
         7urN32pU48lnVOIld8V5E4OCsgDXW10JSBzi/bUEKO9ant+kGzjnwe5a51AVaYyOFp5y
         edwdiTTzwAjCUwJV00D92hvRYC5X69XHARfFFwkynkfSc37s5ASLbJOOJD3kYYFFtjCf
         yboAhkuGxY5Om+XWEO/hc4fzPsOKvfHwU8KkNan+glbHOo12IS9JGqNeJcHhMgFFETgS
         wPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711419587; x=1712024387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwUWm3j1zJRZURenFwbWO1vD1+nvI5/zaM6L0hDa+ys=;
        b=gCNQDh6Rrik9eMEOyduNfxRpLYbXXIBw4iM+Y84lUtLK6od3913lpEsRClM+eI9Ys3
         MMZNGgJZydVa9Ug9qpUq5fTCN/wVtzXCkMSiC18VyKf9AW3YH5ZkCDPn8sn7ZtFe0oWb
         Q2WY2a34LoWzgW+WmZAfsjy/+cv+g3mOUGvW0siI5Z6U6dJ3SgH7qFvgP4n6rxWhTWKT
         c4re+y37BbgwtFN5+nuLQScQEaL98sH5sC9arAnKZ1kTOEGOtAUaZ1XGLHSVkcGebJEl
         FNbLZPjAjQGJsxbvBrsKTTStGdcCeBHabew8gPritwZMgq9Q3wm0tB/aSv6fCLdZD2uZ
         UQqw==
X-Forwarded-Encrypted: i=1; AJvYcCXEH1ryyL6s5vDWC5wcxW1jKn84qTli0gG4gH1K8ghztNOSyitcKX6meAJSPs/R8N79lmjaxj0SYx2L9QwmKQyB7Pl7moqMwQp2Vs+6
X-Gm-Message-State: AOJu0Yz7SK5LHrSUCl/Dut6LZu5mnG61NJRyJq7zCSu0mgFpF2ULJHsH
	5nJTmSdmxDVqsnr109ziPXh3UxpZ/QtmPr8/odq9Cw/mC9zUe4aaKrMxga3c4BqHXmx1rsqMIP+
	09pnzBEsf0Fx2K5RTkfkv7JI4uRCQe/QMEOiA
X-Google-Smtp-Source: AGHT+IHWoTDaFrz39cq3SgBRPBnsFN2RcJxYtTh8fpxz5aBnMNl+4i7QiRhfchmCfv6bEuPFbggLy/iD0MsC0nuzuM4=
X-Received: by 2002:a05:6902:4d2:b0:dc2:1f53:3a4f with SMTP id
 v18-20020a05690204d200b00dc21f533a4fmr7114306ybs.5.1711419587211; Mon, 25 Mar
 2024 19:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325123603.1bdd6588@canb.auug.org.au>
In-Reply-To: <20240325123603.1bdd6588@canb.auug.org.au>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 25 Mar 2024 19:19:33 -0700
Message-ID: <CAJuCfpH4Ee00hM9+B7=mi5Dwjrhov8vUK-KwPuoO3wsD7iJSAQ@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 6:36=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> After merging the mm tree, today's linux-next build (htmldocs) produced
> these warnings:
>
> include/linux/slab.h:545: warning: expecting prototype for kmem_cache_all=
oc(). Prototype was for kmem_cache_alloc_noprof() instead
> include/linux/slab.h:652: warning: expecting prototype for kmalloc(). Pro=
totype was for kmalloc_noprof() instead
> include/linux/slab.h:692: warning: expecting prototype for kmalloc_array(=
). Prototype was for kmalloc_array_noprof() instead
> include/linux/slab.h:714: warning: expecting prototype for krealloc_array=
(). Prototype was for krealloc_array_noprof() instead
> include/linux/slab.h:730: warning: Function parameter or struct member '_=
n' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Function parameter or struct member '_=
size' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Function parameter or struct member '_=
flags' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'n' descript=
ion in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'size' descr=
iption in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'flags' desc=
ription in 'kcalloc'
> include/linux/slab.h:774: warning: expecting prototype for kzalloc(). Pro=
totype was for kzalloc_noprof() instead
> mm/slab_common.c:1217: warning: expecting prototype for krealloc(). Proto=
type was for krealloc_noprof() instead
> mm/util.c:751: warning: expecting prototype for __vcalloc(). Prototype wa=
s for __vcalloc_noprof() instead
> mm/vmalloc.c:3897: warning: expecting prototype for vmalloc(). Prototype =
was for vmalloc_noprof() instead
> mm/vmalloc.c:3916: warning: expecting prototype for vmalloc_huge(). Proto=
type was for vmalloc_huge_noprof() instead
> mm/vmalloc.c:3953: warning: expecting prototype for vmalloc_user(). Proto=
type was for vmalloc_user_noprof() instead
> mm/mempool.c:245: warning: expecting prototype for mempool_init(). Protot=
ype was for mempool_init_noprof() instead
> mm/mempool.c:271: warning: Function parameter or struct member 'gfp_mask'=
 not described in 'mempool_create_node_noprof'
> mm/mempool.c:271: warning: Function parameter or struct member 'node_id' =
not described in 'mempool_create_node_noprof'
> mm/mempool.c:271: warning: expecting prototype for mempool_create_node().=
 Prototype was for mempool_create_node_noprof() instead
>
> Introduced by commits
>
>   c64e38ed88d1 ("mm/slab: enable slab allocation tagging for kmalloc and =
friends")
>   ea7b8933f21b ("mempool: hook up to memory allocation profiling")
>   576477564ede ("mm: vmalloc: enable memory allocation profiling")
>
> from the mm-unstable branch of the mm tree.

Thanks for the report, Stephen!
Let us check with Randy Dunlap how we should handle these. I assume we
still want documentation to document kmalloc(), not kmalloc_noprof().
Maybe there is a way to mute these warnings.

>
> --
> Cheers,
> Stephen Rothwell

