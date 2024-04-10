Return-Path: <linux-kernel+bounces-139047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E989FDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF201C21BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F017BB00;
	Wed, 10 Apr 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+xkYvV4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676417A918
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769005; cv=none; b=iysmNkX5x4zrwLFbJ7rpHda/xtpzDww666CDd7ho83mdrRdVNb0amxmxU1Ozf0N7TmDvddS0lhm/BGcfpSKBLjrFjJJIZr7eL5+mJ55u9QW9X1gQxHiklNpKbtlzZQdkhUxdnmjasjrhaOJmMwHXs94kr8hZQme/H3g15torFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769005; c=relaxed/simple;
	bh=VtpjC07++KGGgzAE60ATz4dYFOQkqcE78s6E1W/Gh+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tf3+9OtB7H6bsCT1YQgmSOGl/U7ck4bKUFmj46L5U3itxYQqD9sILsFPlVpWq+vO2R4GxJfW2k9O9RAvLK+6qsXpC+PDnPlBxRCXwhTap3FD4YXs3G7gClH8+1NB8VS6NXyJ2hT4JSJ3m7nLFgVu/kHINY8Cn3/he1GWKPb+1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+xkYvV4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712769002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0l1ynD0EW3Jmpq+Ulyaiq0nHLkeBnyCPceM9vs7ots=;
	b=a+xkYvV4inKFPfhDBqU28Em/3EVC3F2scfVFJQ1FBVA/KNC/ykqN3574yZvIYJioFtLUCU
	AMhDOZWK5BO/FxdANxR0186fMhqY+LAKgd+ymciNG5zJfiQozBtOcPV2M3ABWmWqU74y5P
	csz+9WnhyNLYRG3GuBDEi9Ungn/ZThs=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-mUbrnu4PPfG377ge4dMEuw-1; Wed, 10 Apr 2024 13:10:01 -0400
X-MC-Unique: mUbrnu4PPfG377ge4dMEuw-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5aa3afc55c6so1144296eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712769000; x=1713373800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0l1ynD0EW3Jmpq+Ulyaiq0nHLkeBnyCPceM9vs7ots=;
        b=a8uzSfeHHzCrQnLA08Zyz38OSX/mtSJqJ250HRl0+maTMo3t1emEeL5M59p+UU6QTb
         9KVaJEk67gGGeFvuRSqr0hWj4gFxeH13UerujPAUfvOM1Y+W70LCRyZ52ZvjbKssQC8X
         zCk+iHobEWpLSxm7kN5xjhyyw5Ww2cUlBAbgbXPnpSipX80bM+5t/9CNVZf9uDHubK1W
         v7ysFnhOjHEiIyj4FoataO7Q/V3ntU6x+QNHc08nUsaEw9fykeOMm11pqLwydjUzMyy4
         xMil94dtEr7BlscifBpcmUhhxE2stasOP+GphsFW4Va7a8xcQ2L8EEVZQK9bFVPGNFQB
         PyKw==
X-Forwarded-Encrypted: i=1; AJvYcCXD8GQEMzXAmLEsy60m+eE7CnabHF7JPw7jVgxdTT2ZFHPcuXYGyZ0iW3jXbZWaX5tA47UwBA3aV9rEzrjDqhiK5YJpcrJtAkMiQ2PQ
X-Gm-Message-State: AOJu0YzogFnk+asm7Mz/LXwvVDCbxfy8881KaZPZUfbko/tBB1Vjm7x0
	mfPjy2jKXVHUltXBvnQ4qIjxffzrWKI1+Kdg+Gj2yiAFxucEJ9/3PYH/+NZr/LyNx/iosISibe/
	RgKmWJMy3LW1y/kHHGWO1Kkr95Vw+L5kp9iNxmSfd4n0h+VNvdSMbjHm+wLQI+w==
X-Received: by 2002:a05:6870:f216:b0:22e:8800:b8bc with SMTP id t22-20020a056870f21600b0022e8800b8bcmr3433182oao.5.1712769000028;
        Wed, 10 Apr 2024 10:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE/+7WQSnj/hTRuIBN88EVodJlSwEmPwY3FJlo7FEcAzIDxoZmRwfUFXXtj6Npb6mUKMjDdQ==
X-Received: by 2002:a05:6870:f216:b0:22e:8800:b8bc with SMTP id t22-20020a056870f21600b0022e8800b8bcmr3433135oao.5.1712768999323;
        Wed, 10 Apr 2024 10:09:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id du47-20020a05620a47ef00b0078bc4cad726sm5455316qkb.72.2024.04.10.10.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 10:09:58 -0700 (PDT)
Date: Wed, 10 Apr 2024 13:09:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, david@redhat.com,
	zhengqi.arch@bytedance.com, kaleshsingh@google.com,
	ngeoffray@google.com
Subject: Re: [PATCH] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
Message-ID: <ZhbH5TepRnNZu82l@x1n>
References: <20240404171726.2302435-1-lokeshgidra@google.com>
 <Zg7hrt5HudXLBUn_@casper.infradead.org>
 <Zg8OYYV7DDo7S2Yf@x1n>
 <CAJuCfpGHe2=noJomL0XonT4dVGvZmVujRMEbgpYgVg_d5wo-+g@mail.gmail.com>
 <Zg8V5OycPYYk7-Qp@x1n>
 <CAJuCfpGj5xk-NxSwW6Mt8NGZcV9N__8zVPMGXDPAYKMcN9=Oig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpGj5xk-NxSwW6Mt8NGZcV9N__8zVPMGXDPAYKMcN9=Oig@mail.gmail.com>

On Thu, Apr 04, 2024 at 02:07:45PM -0700, Suren Baghdasaryan wrote:
> Yes, I was typing my reply :)
> This might have happened simply because lock_vma_under_rcu() was
> originally developed to handle only anonymous page faults and then got
> expanded to cover file-backed cases as well. Your suggestion seems
> fine to me but I would feel much more comfortable after Matthew (who
> added file-backed support) reviewed it.

Thanks.

Just in case this will fall through the cracks (while I still think we
should do it..), I sent a formal patch just now with some more information
in the commit log.  Any further review comments welcomed there.

-- 
Peter Xu


