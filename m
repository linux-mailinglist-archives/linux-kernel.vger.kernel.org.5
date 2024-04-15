Return-Path: <linux-kernel+bounces-145268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1478A51AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0F91C227EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0A07D086;
	Mon, 15 Apr 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZFeOpk6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7878C6F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187898; cv=none; b=rH7n9xcGXjlC2xvNPbNrECYekpWc9gVwMfBwcdpORK3I8a2EpGEMTo6rYf5HKCDlqoF+FTRsBDaBelryfuNeHwSS3CvbN59ce2925NelIo0e6axgUbzuCMpQu7hpoP08CE9Vte8LOksQ80T+/GNz8NFVu2E04wtA6qUR+P5T4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187898; c=relaxed/simple;
	bh=RTcp4ChnIgmlmEcfEQU6EJGn9gnNOY6imrmIY/RWxas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS/AH7fLb69kQ72C2TrKYAjC4idNKKgYcCCsdVDxF0i8hCLwLCEf2JY5b6InP0FR7SVDtHCvEChuNGtyZa0pDjff+guGiZKmQJmK/3HeW3YmSt3u4U23nTxn18k+OU/9gzVwhXar+eTBxTuKLYLKre/PTV1zEcpq7yaNVwZb08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZFeOpk6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713187892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Odozy2BLDSJ3flfmqEEsFw+Lc+xUdGcL/TjOYgEXfpE=;
	b=hZFeOpk6NfU7lRxtbb4s6Du74vGjTaUXByloqj2JwtznCVYpIQhL8dC5ubh7iwuyAeN99r
	IquDs2h8/++sMgshQltbypkbrdt2UwWemud7WvM0xPDvEqzvRceQcFe1PBAZMjK8q6zQC/
	4TUulwT2axebIx3fMe+hE50B71mHUnU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-o1aYcjk_MuGQ9AEmV87FQw-1; Mon, 15 Apr 2024 09:31:30 -0400
X-MC-Unique: o1aYcjk_MuGQ9AEmV87FQw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ea10c8093eso394011a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187887; x=1713792687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odozy2BLDSJ3flfmqEEsFw+Lc+xUdGcL/TjOYgEXfpE=;
        b=JpXgmqjxTh+42IjgxAHOumCZoclPu1BgRk4i0EZtEJ0i20G6daMkuGQyvac6MQXnsg
         wyvskBqR8j5ytodjpC52CsTyPrQjiI4hiZdLCCYhi4NE8w9omZV7o2Aoyq+ltmepBaZ6
         ghLRbrL1xHZCwUMD8aug7ymL4JTp18hQfeuW0g82zupEHzGc0h7qxV34DeeJXbpcGQh5
         u0uOoz4LsMjw0dojHFPzDisziKIj3/iFfU/JCYPrHHYpnSzD0vUE4GNENpmFnrGwmduU
         PursEvUub1jCJ7sjnKD7imzp6NSnScOfIUXOkLE9ByBdOs1FLgxBj0kz+Plsw9f4Lya6
         YI6A==
X-Forwarded-Encrypted: i=1; AJvYcCWNmiLQRxc0fOJz5rFBF+MQyiUibWYHuyHCF6DAmhWEgS+k3KBKkQfZZfeahqu707bduZR4gOkZmkw464pmgDTF7tHJC86XszX7YPch
X-Gm-Message-State: AOJu0Yw4Oa751zd5TcA0oVilx2qdXbcDQL0EXlnd8RaIW/XTZRse3DhD
	WacDfnobzOwwi4WxWM22wTrEqzz1E7vD049/scq9Kkqfdq7v77otqTPKLwIx/6IGnvNmWHdmMCA
	5Hfthd2ZYux2aIaR0BDHwUNdbJFsXWXA81F8BXO1CcYOhMkbusPUv2JMZ8Jadng==
X-Received: by 2002:a05:6830:108e:b0:6eb:7e33:3fbb with SMTP id y14-20020a056830108e00b006eb7e333fbbmr3038922oto.0.1713187886774;
        Mon, 15 Apr 2024 06:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsrdRJqSAOaya5H1or0iH1a+btPgQDm4zN+Ikilpc1533OpLXJHjXMg4zifVdXgL/6oVr8IA==
X-Received: by 2002:a05:6830:108e:b0:6eb:7e33:3fbb with SMTP id y14-20020a056830108e00b006eb7e333fbbmr3038894oto.0.1713187886392;
        Mon, 15 Apr 2024 06:31:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id v23-20020a05620a0a9700b0078ebb13a03csm6315948qkg.67.2024.04.15.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:31:26 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:31:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
	lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] userfaultfd: remove WRITE_ONCE when setting
 folio->index during UFFDIO_MOVE
Message-ID: <Zh0sLJfu19ij2rAV@x1n>
References: <20240415020821.1152951-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240415020821.1152951-1-surenb@google.com>

On Sun, Apr 14, 2024 at 07:08:21PM -0700, Suren Baghdasaryan wrote:
> When folio is moved with UFFDIO_MOVE it gets locked before the rmap and
> index are modified. Due to the folio lock being already held, WRITE_ONCE()
> is not needed when setting the folio index. Remove it.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Lokesh Gidra <lokeshgidra@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


