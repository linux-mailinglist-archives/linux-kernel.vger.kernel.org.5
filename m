Return-Path: <linux-kernel+bounces-76799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E4685FCCC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE4AB26846
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E2E153BC3;
	Thu, 22 Feb 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crVvQVJW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA501534F7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616497; cv=none; b=NhNwdvi9jEbCzAInrCYxpYYAsu3dA3DNmFAHA/g/zOz55/6fcDI9RAJ5Fvsls0OUl8c0QZgtUvmQyqTnk+LLwktPLCG+ulIqf5l33q0IhdSCcFr55ogpTXO7gQQNDYHAFuFgrAnUEBJxC0hy02L2hle/Zo6QZqSITNNzFQ640ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616497; c=relaxed/simple;
	bh=t2Y541NBTF20XK3dcuTaD4MfPwHo6wDUA3Kzlm90WZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp5ItQ0FHD1fGGIj4kPN3dry4TDKt82ckDkiRG7qeTvxbUx4qBvfVqhlO9rm9bLd9kXZa+vLRK92kchkvMPlMyDpDXFqulS4/w1kaNML9qcTH2RJnESPgSwQP6SLGnAZ20Q0tfvjBeUWKAbHpcWWZuhvxrL9Aij0KSu4GX/Nz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crVvQVJW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708616494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ohgWeecE5sLvAbR1ati6o7mII8imwpShQzkYvL5vVU=;
	b=crVvQVJWUGcpe1JgVC0EWZHnRHjpTR4dbXeRghxifHmbyY1NQMSvtepavK/FjBTNjVjHU2
	4bwWwqLKc2LaxBmx8nmFHOAwb9pYDBou1KBabRJ7pwT4CjLY/hAXwKt1rPgQw8Gmal/iET
	bAt3MmemMomzzdDFalOigVBLjNtTXDk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-LyQuHO84Oiu55SD-XBk7DQ-1; Thu, 22 Feb 2024 10:41:32 -0500
X-MC-Unique: LyQuHO84Oiu55SD-XBk7DQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-410422e8cd1so34003655e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616491; x=1709221291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ohgWeecE5sLvAbR1ati6o7mII8imwpShQzkYvL5vVU=;
        b=R0bHTJDlYXxC2WYI1cYw13vCd6RxsOnwXXnvgh3jTcbDLlZz2dAo/fEZLL7ZMo4BNW
         iG762+pl7IA2pUrUW6epZJtZLBqP70YSaSxyJwuyTUfsjmFEq/GdfcKAe4SI8nPPN5yq
         RZlAtVLyi4cWQcfiGH5rTj+dRR0pX97RguiTmXTNetRaP8ZfUvTtPfdv1/rQ3dQxqhGg
         5LlEz5nzFq6l//yiSKn+S2Fgaw3pE/Ngx+wnQ6TojoD8JexfiLETzLK0Jy3IT+rYmbni
         4O6ALcrfmxn0MVG1odelmFnPznZwp0uk6ZAEzOM+0CultYt/16kfywOl8PhTi5fs0Ti2
         V8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW4XarXqeYQ/Q9Wp6AsHspH1zLgv7UHuqTnAUYQpy2BkbA4ldZi1lc+QSqmHOEnbiXrF0yczBx9ENooUwAnAzk/XdFRz9hatIncLSTP
X-Gm-Message-State: AOJu0YykXCqOupIME6zTkS9ISBQQrhcGGgbM8rigTxbXcDV9iEGz0khw
	cqVoQd9uWHDbgeTB9tVZOxry3ClHTvLyBfgV9zXNb0T40knsqonZK92f9cfCS91/m5RNDhvEbOb
	CYrWbTZenKoM5tvvIHFGAuKBbxKN7dH+d9c2XQxoOBZhBTkyb6ZsrSTI6sX5aog==
X-Received: by 2002:a05:600c:4f82:b0:411:e6fd:4ad with SMTP id n2-20020a05600c4f8200b00411e6fd04admr17000829wmq.5.1708616491547;
        Thu, 22 Feb 2024 07:41:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtqkR0KaYBzcVyqpjgYX963S7RxaFGa+tK0UVfi315EcYLlqk4dk7ACCc6QXbmqO7Qpvbbag==
X-Received: by 2002:a05:600c:4f82:b0:411:e6fd:4ad with SMTP id n2-20020a05600c4f8200b00411e6fd04admr17000815wmq.5.1708616491215;
        Thu, 22 Feb 2024 07:41:31 -0800 (PST)
Received: from redhat.com ([2a06:c701:73fa:1600:1669:f0ad:816d:4f7])
        by smtp.gmail.com with ESMTPSA id y17-20020a05600c365100b004126101915esm6463325wmq.4.2024.02.22.07.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:41:30 -0800 (PST)
Date: Thu, 22 Feb 2024 10:41:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lei Yang <leiyang@redhat.com>
Cc: syzbot <syzbot+6f3c38e8a6a0297caa5a@syzkaller.appspotmail.com>,
	jasowang@redhat.com, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, sfr@canb.auug.org.au,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [syzbot] [virtualization?] linux-next boot error: WARNING:
 refcount bug in __free_pages_ok
Message-ID: <20240222103932-mutt-send-email-mst@kernel.org>
References: <000000000000d305050611b50d09@google.com>
 <20240219022853-mutt-send-email-mst@kernel.org>
 <CAPpAL=y+-YrDUsKYVBig4dc-7+Cg1Lk_VWXPOKeL=s2Fitf3mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpAL=y+-YrDUsKYVBig4dc-7+Cg1Lk_VWXPOKeL=s2Fitf3mA@mail.gmail.com>

On Thu, Feb 22, 2024 at 11:06:55AM +0800, Lei Yang wrote:
> Hi All
> 
> I hit a similar issue when doing a regression testing from my side.
> For the error messages please help review the attachment.
> 
> The latest commit:
> commit c02197fc9076e7d991c8f6adc11759c5ba52ddc6 (HEAD -> master,
> origin/master, origin/HEAD)
> Merge: f2667e0c3240 0846dd77c834
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Feb 17 16:59:31 2024 -0800
> 
>     Merge tag 'powerpc-6.8-3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> 
>     Pull powerpc fixes from Michael Ellerman:
>      "This is a bit of a big batch for rc4, but just due to holiday hangover
>       and because I didn't send any fixes last week due to a late revert
>       request. I think next week should be back to normal.
> 
> Regards
> Lei

It all looks like a generic bug dealing with some refcounting
in the allocator.  So, a chance of a bisect there?

-- 
MST


