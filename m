Return-Path: <linux-kernel+bounces-62903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9038527B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B75B1C234A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB58F65;
	Tue, 13 Feb 2024 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxH3tWNw"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944711C87
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794245; cv=none; b=KWUgY/ebXIGYOjQyCskQ4EICKSDqGQBBCj5DKu3a15ODQdw2vn+WEJIbBtYZQjC7lVdFVXJqJ2HFTFooH+BzerfyWllBRJcAXg8/6ZoN3POHH3t4w7+fVX7vFY52tau3EnYFzScAcZGjf6MxqY7/edclPQk3+9aNsoRw3Gr5ifM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794245; c=relaxed/simple;
	bh=yaFwwuILjODPQCHNexeJRgI7TYDh6uFcXGGTgisJfRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JIPcKiNb+R4J77vcyJFDHBP4RwVZI+MXNygIhkMF/EKof0ilhf3MlT7CMTDhim68kwUONo+S9Zuy9/N3LrsrpdFYpT+6bydDNr3VfsbPPomiSLaMFigjmE53aX5N9mhUFyadJzGy5DPN/aGoKRdFOeD3WVglEpm9E/OrBuJBB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxH3tWNw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6da57e2d2b9so4562476b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707794244; x=1708399044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVm2qt6PZQcz0utE4Akn0WypHrSjA1Wf8uiop5Zn5yU=;
        b=kxH3tWNwpZe9XJwwsw8Y169BnKonISo6JEkCD5IhnfjzzUJOLfRUS79XyAQuOZXrHy
         aHJDE2QaD5+Pzu/KUIKzVRLZc3tx7aXX23Ls9WR1mELeM8hArQFH62Ks4hRqPj3oWrMj
         AO+FsE9EpQudYmtHetcDdk7LeKvbn0u55TzbmBSbXvtuk+AUWV+70rqwyBXRGGkQKyjw
         39WySEaJVjzBecl827NXLE6+SRDM5uGqaRgds9aZo0DDW3ykvLugzlyUcvvDl33T64wq
         cmuu7MdzoQuJysHmIY87TXN/yFJeLFxvoTgSc7J0gL7Nmof18Wg1sLUemk2blQH9XScl
         eBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707794244; x=1708399044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVm2qt6PZQcz0utE4Akn0WypHrSjA1Wf8uiop5Zn5yU=;
        b=ebuUsmI47GzzNSx++2ZRNnh6uQOofWMQjNmtlXsZ5o8PPc7bcUg/t4RwCDbY/gqaNT
         OHNM9eVCHTtYm1dyzKqzSGiA+xoRXNeexs9uM5GTHlCanmuzhn6+cGSAecddVUTMquPt
         baPZyN7fU84Xsd4JqGLyds9gb0o3nPfgv32VGinQM4TiZRAfgwrRXinoXEz3rHVdDslf
         3kudGOOFm/yEFIO3IlqQwpvI5xZMEqI0tdOm0te18sOZ30riN6BM2VkHyKkJoMOrckjq
         0C2KfOjC6jh/mnT9IWTtiZjsOeocp4yVquV7N2XI70ueAixv58W7BykQR/VKbRutKPEG
         Ymzw==
X-Forwarded-Encrypted: i=1; AJvYcCVJLO1e2BXt8/yhkI2Gw0R0wzDpQKSOSWf1NSrhA7uVcnSrXuuUq57PdlEiiA+LVIXRvd+xf859H4WFsIt8VcEM5KRd65Hkekh82Nl4
X-Gm-Message-State: AOJu0YyvG9dvZTxzVoxwQDZhDXBHaCeaoiGjBtU0ZhLgMF6hQ+Ds7Udu
	Bncd79JrdJ6tJswU6ADHcjofMwy3BKN9xiKgc5i66dAXS68C1G7kxI/+AezcDKbjuwWA8TsvwWK
	5KA==
X-Google-Smtp-Source: AGHT+IGkpD6RdniIDh260A6OxDHEWqMXuQHS+eBuq/fo4zQ0+WcsNYS5eDYc+e0o5cV18GY88+G49qabbao=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1898:b0:6e0:fdf6:971c with SMTP id
 x24-20020a056a00189800b006e0fdf6971cmr3911pfh.1.1707794243564; Mon, 12 Feb
 2024 19:17:23 -0800 (PST)
Date: Mon, 12 Feb 2024 19:17:21 -0800
In-Reply-To: <20240103084424.20014-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240103084327.19955-1-yan.y.zhao@intel.com> <20240103084424.20014-1-yan.y.zhao@intel.com>
Message-ID: <ZcrfQS883NfOso4r@google.com>
Subject: Re: [RFC PATCH v2 1/3] KVM: allow mapping of compound tail pages for
 IO or PFNMAP mapping
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, 
	stevensd@chromium.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jan 03, 2024, Yan Zhao wrote:
> Allow mapping of tail pages of compound pages for IO or PFNMAP mapping
> by trying and getting ref count of its head page.
> 
> For IO or PFNMAP mapping, sometimes it's backed by compound pages.
> KVM will just return error on mapping of tail pages of the compound pages,
> as ref count of the tail pages are always 0.
> 
> So, rather than check and add ref count of a tail page, check and add ref
> count of its folio (head page) to allow mapping of the compound tail pages.

Can you add a blurb to call out that this is effectively what gup() does in
try_get_folio()?  That knowledge give me a _lot_ more confidence that this is
correct (I didn't think too deeply about what this patch was doing when I looked
at v1).

> This will not break the origial intention to disallow mapping of tail pages
> of non-compound higher order allocations as the folio of a non-compound
> tail page is the same as the page itself.
> 
> On the other side, put_page() has already converted page to folio before
> putting page ref.
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  virt/kvm/kvm_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index acd67fb40183..f53b58446ac7 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2892,7 +2892,7 @@ static int kvm_try_get_pfn(kvm_pfn_t pfn)
>  	if (!page)
>  		return 1;
>  
> -	return get_page_unless_zero(page);
> +	return folio_try_get(page_folio(page));

This seems like it needs retry logic, a la try_get_folio(), to guard against a
race with the folio being split.  From page_folio():
  
 If the caller* does not hold a reference, this call may race with a folio split,
 so it should re-check the folio still contains this page after gaining a
 reference on the folio.

I assume that splitting one of these folios is extremely unlikely, but I don't
see any harm in being paranoid (unless this really truly cannot race).

