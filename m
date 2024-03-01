Return-Path: <linux-kernel+bounces-88374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8502286E0AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F091C212FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A196D1A7;
	Fri,  1 Mar 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTOQlnpw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E16D1B9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293815; cv=none; b=u3ym4xklfVycDtIOSxDU8aceROfYNnecikxE5FCHSaUSCwsdHNoxNwzSK+tznYRrSwvBAJAlRgrc0cObJ/1n147fiTEKhIYvhw/lGFRq88HOY/JEY6pzAjRlLerh/DxEY3uJ7zEXZ7Vv6gUEWZay8EWt5oRMzVlLfoLUbnXsP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293815; c=relaxed/simple;
	bh=v8Q6Jl37N2zGR/HpoxxGmiaWTFVZujCX5ASqmiZFrbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ3lwP9gsyL+uHK4VW32KobZJp+0KZ5ErozjndW/8BElM58klW8tdYUcNc4p13oH9CFr8qvcRXYydB0V5hcAb5KFzfVAxHFryYWNFaRXz+hgHQOsf1tASSM3nDjAe7/+1+6s4hddV0/cNhw1B9afHtx5KrRxZ/N06OU77usGK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTOQlnpw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709293812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfXTaDiZwo/oZl8lj7bR+2VUdXCLhRKEwJk47+amUD4=;
	b=UTOQlnpwGej5R/GRVj30k1LJhUw4zbbMmB/uL5YL3TsASdGL/PnzGnP1W+vWSIzOmNGkqs
	rDF5UlukU7apPcaUvtRiphXHmqnSmUI2+q50hpJpzqia1c1IwWLlqIJD3RykjmtQG2FF9T
	heZnv3Cd4z7oNbIes2+28UdELqjlOqo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-YGujJ0KJNnGkBm0XpuaVAg-1; Fri, 01 Mar 2024 06:50:11 -0500
X-MC-Unique: YGujJ0KJNnGkBm0XpuaVAg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a44508b6b22so110947266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709293810; x=1709898610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfXTaDiZwo/oZl8lj7bR+2VUdXCLhRKEwJk47+amUD4=;
        b=la46OvIW0/0FBGIvsnhta350bCZED83cCB2yELuRy8dLZr/RO34PJBl2ncaUBBTXtK
         lmI7cTM40j76LEWpk1o0Hh7W1UkZvLRY47ydHaFSCcDGDYL3SSyGBjY4vtP+PowOoMae
         o6lpknPHDp30yFnjkIC62hOoYufVUxjE6SUTE4v4+rIDYExll6nYD+/K2e0Sj4bDSB1w
         WSx3uyJzbXoLjtGn9BB8DigansEat7qB/Rx4YcmpCWN4SW82fe+12xWgyZDUYeGcvghd
         lvB/T7qrokIbzSW8thCmzAVjFuxooL+pEZQr7b1PBUgBl9Cfe/3wcINRoxBkN+tqi5i+
         kcsg==
X-Forwarded-Encrypted: i=1; AJvYcCV0qrCwuidyHEqZp3l9xt5jVVjnT/obKfOKWKK/vo80ynif8fYYd6T/fg47MwENu//MTQIt5BFB20g3j7YZ5IhpFusXLILCr78qCKuC
X-Gm-Message-State: AOJu0YxD506wV7aNjRmTmmC1AmPlubGBDVl/iMX+/3wZXu7IzI3UpXbB
	TDI6hol1Brz72g3i8fCrPUvKdTuti2F/wxWjFMWglSc4OutP24z+65aVLJikjmxc59m878aEeJy
	LCA7+0nYvGATKRLk2YA69s2B1SWr3nuOj/KcwkvsIa/lOEdDDHwH3absUgyAlO+HgTk8PtQ==
X-Received: by 2002:a17:906:6889:b0:a43:f825:ef52 with SMTP id n9-20020a170906688900b00a43f825ef52mr1165086ejr.28.1709293809864;
        Fri, 01 Mar 2024 03:50:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgSzULUZjY1B+qQ1X+GwdMQFa+cNtdHXqiMvqiMYETfuq7yL9oj929clF85P2IkH9peSUsVw==
X-Received: by 2002:a17:906:6889:b0:a43:f825:ef52 with SMTP id n9-20020a170906688900b00a43f825ef52mr1165062ejr.28.1709293809432;
        Fri, 01 Mar 2024 03:50:09 -0800 (PST)
Received: from redhat.com ([2.52.158.48])
        by smtp.gmail.com with ESMTPSA id cb17-20020a170906a45100b00a43f1feac16sm1627108ejb.88.2024.03.01.03.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:50:08 -0800 (PST)
Date: Fri, 1 Mar 2024 06:50:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	Zelin Deng <zelin.deng@linux.alibaba.com>
Subject: Re: [RFC] dma-mapping: introduce dma_can_skip_unmap()
Message-ID: <20240301064632-mutt-send-email-mst@kernel.org>
References: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
 <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>

On Fri, Mar 01, 2024 at 11:38:25AM +0000, Robin Murphy wrote:
> Not only is this idea not viable, the entire premise seems flawed - the
> reasons for virtio needing to use the DMA API at all are highly likely to be
> the same reasons for it needing to use the DMA API *properly* anyway.

The idea has nothing to do with virtio per se - we are likely not the
only driver that wastes a lot of memory (hot in cache, too) keeping DMA
addresses around for the sole purpose of calling DMA unmap.  On a bunch
of systems unmap is always a nop and we could save some memory if there
was a way to find out. What is proposed is an API extension allowing
that for anyone - not just virtio.

-- 
MST


