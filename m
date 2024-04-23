Return-Path: <linux-kernel+bounces-154674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4268ADF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530F8B25E42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC11C50297;
	Tue, 23 Apr 2024 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUQ0DlkY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D02B9CA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860521; cv=none; b=k/vAIaAaUPkKjI+3zJ9Xveb67TFA4TdR3nVpbYpHK1Rh8aoMSiPaJQ5K9Lu5eHlw9NZldITUflu1myH6HE1JEDHpNjdL9zJS5MxToJ3ZYifrzz6TYdrnq8Icdrq0qFL50DhyU737ePR7CPDHDa4XRlWlY3Ac/bz0ILx/2nPJD0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860521; c=relaxed/simple;
	bh=7SvZxhV4kSK3GCKRr+qq1bEh3I+PguFZxghwXcojRt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZ9cQEb2tbc7GUfCFv4qgElqvhQ4l/oIMIuWuvdqvWY7bJkNQQn+Dc7yJi20xcJV0rkVYdBkFjAZbxI7l01KUUwon4OngiBTiWEYtu5d7ZLTac8djnFmDnhcAyeYSQHHHCAzNThP4abwCi7NN3oYtsTenHjoCKR4GSPl0mAyfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUQ0DlkY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713860519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RXblZzRaQ2FOuUJgk4xde8wObaGAG9T7t401LxxiPb8=;
	b=GUQ0DlkYoF9qnAcbfTCM3ugQamPLP3uoiMdwjFIFd1wkji3SeoWHpYpP2Ugk9yDSBBYhXk
	P1ngPitd7JXulMCzg+bevLCXgfwvFB65FR17KMl6BpVlwXAFVYwSaLzsXW8YFEBOQTB0MF
	CYaA/MbIk9WjoHkKCLxhvIv1hJ3IQak=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-cx-C9G-rNXGTMzOdQMuQBg-1; Tue, 23 Apr 2024 04:21:57 -0400
X-MC-Unique: cx-C9G-rNXGTMzOdQMuQBg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41552c04845so28181805e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713860516; x=1714465316;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXblZzRaQ2FOuUJgk4xde8wObaGAG9T7t401LxxiPb8=;
        b=cqLxlxfOqrc6/fq8qYVnn4Q0ZNy54F7dxl54RtPTAWdiZStYCLO25VBeU2Kv0ZIaxP
         VFhqw6w6djSQGk8grNu2QURawSZ5RLZReB4QUFXI9Hsfv7/yUqLflBCzGOSlYiLvuJd5
         s/O3gk6c8aB2qfS/pl+DQ+H5WxpneffRSsr3L6XFqCPk96tdSoS3pKESNJLtcN4L08XC
         /HorvFYH1LyNAu2HObqbuB5g/BRLX3X7+ByP3egk/59Cj9oLiADDkYPVZQyi5qq2wgIT
         1VyWUwxK/jiykQEcfC350shtPeuYROsAREWIPBBl1kQHplnyZPp638bMXdcM6fAK2Pyk
         xpfw==
X-Forwarded-Encrypted: i=1; AJvYcCUDPoHxQoN3conOg12wBb8lrTj+NoLCn6ldcluT050jhdyeQapcJtxqAj6wcRp6QJNMK4conEEGSyBrW3WP2yMieZO3wfEScRId2Ytz
X-Gm-Message-State: AOJu0YzL1Im3f4yDZxgx/eFdQfG8dfWum80YdFVyzFj0V9IhXCJDOwFq
	6RKMeLCFOh92z5pPBjC9SjTPBYTKrTgDFKr2LWD297kDOnzbHqVNQQdiCT9QgJ2xP6LmWjPRsP7
	UGVg1k4wftCK/s2XrEbVW2Zhwz0/mpPK8xuplcATUP7rxJylC8E8BUfCqJMm41A==
X-Received: by 2002:a05:600c:3b94:b0:416:9f45:e639 with SMTP id n20-20020a05600c3b9400b004169f45e639mr8733145wms.20.1713860516713;
        Tue, 23 Apr 2024 01:21:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFnYfCf7LRlRuISVNbuTS8ojuS11gtFoMoX3VQA/pNfU4E872Cg2+TUtq3TB9F7mcSOpnQRw==
X-Received: by 2002:a05:600c:3b94:b0:416:9f45:e639 with SMTP id n20-20020a05600c3b9400b004169f45e639mr8733122wms.20.1713860516260;
        Tue, 23 Apr 2024 01:21:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fd00:fb07:92f8:8f0c:6a08? (p200300cbc706fd00fb0792f88f0c6a08.dip0.t-ipconnect.de. [2003:cb:c706:fd00:fb07:92f8:8f0c:6a08])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600c354d00b00419fba938d8sm10667233wmq.27.2024.04.23.01.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 01:21:55 -0700 (PDT)
Message-ID: <e07add5b-e772-4a8c-b71f-79f1fe74580a@redhat.com>
Date: Tue, 23 Apr 2024 10:21:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the vhost tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Suren Baghdasaryan <surenb@google.com>
References: <20240423145947.142171f6@canb.auug.org.au>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240423145947.142171f6@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.04.24 06:59, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the vhost tree got a conflict in:
> 
>    drivers/virtio/virtio_mem.c
> 
> between commit:
> 
>    c22e503ced5b ("fix missing vmalloc.h includes")
> 
> from the mm-unstable branch of the mm tree and commit:
> 
>    4ba509048975 ("virtio-mem: support suspend+resume")
> 
> from the vhost tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Easy header conflict. @MST, @Andrew, do we simply want to take that 
virtio-mem patch via the MM tree to get rid of the conflict completely?

-- 
Cheers,

David / dhildenb


