Return-Path: <linux-kernel+bounces-163980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1CE8B76CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C5CB2272A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6E171E49;
	Tue, 30 Apr 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSyykgKc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C3C171668
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483176; cv=none; b=OyQTr0rgbKsLpg12Xmiugm35XkdtNmZPqpuZioDLCCLTIG5D1/RNjtT1igu2OhPFACHRKLTRealWVgDqL+79g3DHgY+dNs7/lkPwTiR1H55v5Qc9N9bEpzWq0Bqg6rkq6z3BCqbpmW3JzY+cA7kaD//rfkeRFEYOnw9p2dEUKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483176; c=relaxed/simple;
	bh=flc38teKNx+GZo7NmJ5kYlP5ydouaYSS4d1wDV2Fd1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jsu29EymGgUhvw9PI7a9lfC0K97xm3xsE2O4xCdWv+TnQFVMc28aiUyroQD0AMo3WYnVkQI22asXOQZA8hFUTm5dus53t/j4KAGVfPC+fxn45HSiK/Ehr94bFQLcKn7pelb1gEnKn5tXsL/mGq9yX7feFJhu0t1Ex+uvuCmRvcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSyykgKc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714483174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=flc38teKNx+GZo7NmJ5kYlP5ydouaYSS4d1wDV2Fd1M=;
	b=QSyykgKc7Bgy8t5tvngWwlBbbdBY265iy2lXdQiCw7j1NXN41Rey6FcPwssyC/FUF9ZOms
	XS7yzv1nM181GqtVcW2maxSWoyUfuq/6SrH3a5PI183B3It8nUkp7lIiK4gm26/fKTNbGF
	sDuAiZa27czZbrTwtYrZ8KPVlQ+ubSY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-qzEtkfj2OjqvElhoCiGK6A-1; Tue, 30 Apr 2024 09:19:32 -0400
X-MC-Unique: qzEtkfj2OjqvElhoCiGK6A-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5728683a63cso244823a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714483171; x=1715087971;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flc38teKNx+GZo7NmJ5kYlP5ydouaYSS4d1wDV2Fd1M=;
        b=PxFVzkMd/GkcBUJBXL6JYyVfGQn4XwDrkfG2uoulTfJbTHnUdncHNSJCdtP8xG3+IB
         Lpho5+N3FioikMPBOEBZk/eh3Cw8whMIgZA//WywHUMvtBd1HerJRKdTSb3tlApDYWFA
         3ijOjjIlVt068E2jwIiDu3y1pQV0pp7V4oOoZ2ur1UrlGGiFLMM/VmOuf9rLpe01yQeq
         +mQCT9+EWjAeQmIjTfG6KYSs/wDZqFVPKjhN9Z2cNKHAWi/Ut0MXLlanGaHRCuzEfKp3
         niRhCBKzz8VvSzXbOXqA8sKpxLdiDdNeVSmG525GNW1XIBn75RviAJX8H4+BeKXkhz10
         AIkA==
X-Forwarded-Encrypted: i=1; AJvYcCWgWeyKxb2vDkPItGon1UgcU5mcSJxmLwtN/qHfyYi/WcUNeOIIyDbizWuU5a6Ik54Pz4R90G+n5cpsH+8TqZIPWosMfnJiVQogyPrG
X-Gm-Message-State: AOJu0YzCDj2bT7s5J8AI5T6KkzGbRC7Vu07NWaqWARRlA13X1ahMDZ9a
	qwAK2luRVC7C3i/w3vflzuewZi6ZtxyDOeqyE+PjuGYAKWshaucTMkV6jrWK0vCulBhb5quTBzd
	hvGDXkH7ap4NJ4SDiyKE384yO7rqw4awuLIaQQ0uYJV/66xb3NJJ2XhQsMw3/sQ==
X-Received: by 2002:a17:907:31c2:b0:a58:a102:14c9 with SMTP id xf2-20020a17090731c200b00a58a10214c9mr10029941ejb.1.1714483171184;
        Tue, 30 Apr 2024 06:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh4K4utBzJoK8EabmELqU4eU7xXvQ9Tvf1P7sU4CiIYaYLxbNlXgftXkCnmG96HMMAft3zHA==
X-Received: by 2002:a17:907:31c2:b0:a58:a102:14c9 with SMTP id xf2-20020a17090731c200b00a58a10214c9mr10029918ejb.1.1714483170818;
        Tue, 30 Apr 2024 06:19:30 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:6a10::f71])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906431500b00a521e5856f6sm15163433ejm.51.2024.04.30.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 06:19:30 -0700 (PDT)
Message-ID: <e273971a5219cc240c4e9dda1adbbdf7a5ee6812.camel@redhat.com>
Subject: Re: [PATCH v2] rxrpc: Fix using alignmask being zero for
 __page_frag_alloc_align()
From: Paolo Abeni <pabeni@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, 
 linux-afs@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>, Marc
 Dionne <marc.dionne@auristor.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Date: Tue, 30 Apr 2024 15:19:28 +0200
In-Reply-To: <20240428111640.27306-1-linyunsheng@huawei.com>
References: <20240428111640.27306-1-linyunsheng@huawei.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-28 at 19:16 +0800, Yunsheng Lin wrote:
> rxrpc_alloc_data_txbuf() may be called with data_align being
> zero in none_alloc_txbuf() and rxkad_alloc_txbuf(), data_align
> is supposed to be an order-based alignment value, but zero is
> not a valid order-based alignment value, and '~(data_align - 1)'
> doesn't result in a valid mask-based alignment value for
> __page_frag_alloc_align().
>=20
> Fix it by passing a valid order-based alignment value in
> none_alloc_txbuf() and rxkad_alloc_txbuf().
>=20
> Also use page_frag_alloc_align() expecting an order-based
> alignment value in rxrpc_alloc_data_txbuf() to avoid doing the
> alignment converting operation and to catch possible invalid
> alignment value in the future. Remove the 'if (data_align)'
> checking too, as it is always true for a valid order-based
> alignment value.
>=20
> Fixes: 6b2536462fd4 ("rxrpc: Fix use of changed alignment param to page_f=
rag_alloc_align()")
> Fixes: 49489bb03a50 ("rxrpc: Do zerocopy using MSG_SPLICE_PAGES and page =
frags")
> CC: David Howells <dhowells@redhat.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Acked-by: David Howells <dhowells@redhat.com>

Double checking before doing dumb mistakes...

@David: I assume from your ack you are fine with this patch being
merged via the net tree, am I correct?

Thanks,

Paolo


