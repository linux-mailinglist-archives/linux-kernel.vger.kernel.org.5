Return-Path: <linux-kernel+bounces-77894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58998860BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FDD1C22101
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243A17C64;
	Fri, 23 Feb 2024 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ho2KFuMY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB6179BF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675671; cv=none; b=h1ThC5Al13oi67Hq421FxKqojZH0Vcs4gKHrUGGu4pIIJ0leTXKmV8x+Xgv2W+6TReZNySgrkaqrdzAB5htoD6PTA8uDYq68yGO4Q1P/ggA4jQsjeJ4UnJ49EP2ZIwPdyRv9Z1N+prkFowFHJ2wK77Hi8v24nOGzUPcJf5kE9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675671; c=relaxed/simple;
	bh=DNHZee+XcgGpqhbeML1UkHBmgn9qbg3ptmfP88KNB6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/alSGS6u6FALsyca7f2kXqwCTH1Bm7IE9PtwDeiQZ8p0sap3pqKug1rSgiIxM9ftKbhJLUFCKwq3Dp2fhnkroD4n6LvFyR7lkONnnCZT7LQ3RcjHM46NVYY9jYCwSrDg5fAMRhW342aCire8VgjmfEDvkPQfhKeDgURbyn2EmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ho2KFuMY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708675668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYGnVDuOUOzN376Dec8nS0W4C0cCcX6YgBNBZdpZb+A=;
	b=Ho2KFuMYmvwjd4e6w/f7Xm6GPN+N/IHxS+/aE1knDPI4lYOIsjerW0bGnIvk97zHLysxvo
	Wp3Y99wovWj/EAUSA/5SwH34zsjEF5jyWZjs7xmybq1WIe/5+urSnVUTLMIsGoaeAJrLDe
	xN2w9W0EFCd12ApiuikPSWd7NPOy+Dg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-8kyaYTX5NDS2Z5Jb8Fl4Kw-1; Fri, 23 Feb 2024 03:07:46 -0500
X-MC-Unique: 8kyaYTX5NDS2Z5Jb8Fl4Kw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-512b41a2966so528543e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708675664; x=1709280464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYGnVDuOUOzN376Dec8nS0W4C0cCcX6YgBNBZdpZb+A=;
        b=whHCVTuGkJBUuv+IBIm2rD+UOu07IlC8tWen6lAjtDn+ymOMlqdXoMo8Py+jz973h/
         +0sXroBFdIlq/rvl5JpnmJ5MtyTLBjWwg/1Tv6G1ZisXaSzm2SJu8zGF8nh7fgTB6ij0
         S7Hn0htjYtgGe12rW4l1vE2TXRvStSJHwHO7Na5IUTVTwIi/U+PNr2i9/4SF11eRVqnl
         g5DkNPC3Uz0YNK+zHvYjlGJbFC7w6b1UoJtedCBVgfTuLgeLstHv62mPVsy1AuTt01xq
         1pJS/eit98X+qop8qIkrw7nTi1T9Q/mgawYN+jNj06KEF8TUTNzTpw2p/JdY5MDEX1jv
         XZ4g==
X-Gm-Message-State: AOJu0YwyyQ3pKacw5sOeDXpXUgoGaRgpudeH6U34uXBlH4G7insoFp5A
	DtcbKuaXttl34djxkJHRv3aonuZBECYiurLtVr3a6osuhZtfqbowfIiutdrs/Dp3lGgWv0w9kAb
	KFhl9j+5/2lbgbjyXB2LKCaHKZoHIZYMcWjlsh755meHYlATgugEG2LiBWy/SWuHJbqywjwF7
X-Received: by 2002:a05:6512:388f:b0:512:b858:2ac2 with SMTP id n15-20020a056512388f00b00512b8582ac2mr745621lft.55.1708675664597;
        Fri, 23 Feb 2024 00:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu9CCEwmfSaqKwPGD1L/tzZQvMDbb2NOZKx10PuT4J316mtOybBCCtbpJw8jJNXS8wF+KX/g==
X-Received: by 2002:a05:6512:388f:b0:512:b858:2ac2 with SMTP id n15-20020a056512388f00b00512b8582ac2mr745609lft.55.1708675664242;
        Fri, 23 Feb 2024 00:07:44 -0800 (PST)
Received: from redhat.com ([109.253.221.205])
        by smtp.gmail.com with ESMTPSA id y2-20020a05600c20c200b004126a6ee498sm1361817wmm.12.2024.02.23.00.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:07:43 -0800 (PST)
Date: Fri, 23 Feb 2024 03:07:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH -next] VDUSE: fix another doc underline warning
Message-ID: <20240223030721-mutt-send-email-mst@kernel.org>
References: <20240223062341.26914-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223062341.26914-1-rdunlap@infradead.org>

On Thu, Feb 22, 2024 at 10:23:41PM -0800, Randy Dunlap wrote:
> Extend the underline for a heading to prevent a documentation
> build warning. Also spell "reconnection" correctly.
> 
> Documentation/userspace-api/vduse.rst:236: WARNING: Title underline too short.
> HOW VDUSE devices reconnectoin works
> ----------------
> 
> Fixes: 2b3fd606c662 ("Documentation: Add reconnect process for VDUSE")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Cindy Lu <lulu@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: virtualization@lists.linux.dev
> Cc: Jonathan Corbet <corbet@lwn.net>

Thanks, I fixed this in my tree already.

> ---
>  Documentation/userspace-api/vduse.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -232,8 +232,8 @@ able to start the dataplane processing a
>  
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
>  
> -HOW VDUSE devices reconnectoin works
> -----------------
> +HOW VDUSE devices reconnection works
> +------------------------------------
>  0. Userspace APP checks if the device /dev/vduse/vduse_name exists.
>     If it does not exist, need to create the instance.goto step 1
>     If it does exist, it means this is a reconnect and goto step 3.


