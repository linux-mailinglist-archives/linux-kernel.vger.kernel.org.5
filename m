Return-Path: <linux-kernel+bounces-107254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE20E87FA03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57282823D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EA254BE2;
	Tue, 19 Mar 2024 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8/UGenF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD58364
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837335; cv=none; b=Ark8Cwv3oajDnTHsfUanC0VIaSBoBjAFsz2T20l+rgLRACxPGfWDZTqO523A4iP90jcclSgLhX6QoNfHylPVrKcU7LeLN1qNThDtQlxmbQaPUmFMpE84aveEmZE3Rsd55jz/3NymQQbCRyX5qSi46iuIO1Ge+qxc5mR4SAquOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837335; c=relaxed/simple;
	bh=Uhw7X37ePZrOYI/rJry/tZ9rI468Mam9nGel7TLxUcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKj1ZPCbVJYvqL8edxkJc8mOny3hlp95rrRpdrGVdeNZvcqwl/py0LMvljRp2Qy3QqdhckTnRwnHf3yqrjNOXGgQN8ybMcngV+bbPO/nedW4zmsTUZFBAhAsJ4fu7SdUp9sYP/b/6J5cwpy1vOdR3GuzBBdGKg1o2Lkbr8eR2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8/UGenF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710837332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bidhNprDIaXErWo++B8NK9gU1Mr0P973Tkk526SOsxc=;
	b=h8/UGenF7DKlb3cEw/hagnsGNv/KKOdfutUhaayyM+5y2zthTPc013go6V4CdVgsbH7ULn
	UrL/39iQKMtEpuvBUCBv54lSYD/2W7ka2EbjKiutJURrtTcBxdbytB4I/kN5GHsJ9F9GZC
	LKhnhorCy86QXtDdCBRLRcWn7u5eT6I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-ViRNNpPeNSGjZuJMFlAqBg-1; Tue, 19 Mar 2024 04:35:31 -0400
X-MC-Unique: ViRNNpPeNSGjZuJMFlAqBg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3fb52f121eso235121666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710837330; x=1711442130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bidhNprDIaXErWo++B8NK9gU1Mr0P973Tkk526SOsxc=;
        b=mtXzcqMOF42NaKTqHWT5o4J9ySH3o/lDS/S/dw0LaAQTYfm12Zq/TeHDDSGMdRg3Pd
         N5+1YIjLVsSAHpsIKylyOAbg86+jfWUrsYZ/mRODEJfWov/hc1NRzMzAciD1y3hbA3kH
         U5QnkwrBKJDrMy0bj4dt0eNA1fI1ddN402oT7nryUMmsj3+lKVusvViUZAobgJYJEdn1
         H5BqtdMTEHiLk3du+xZUBDBhneoZzEt4Nw2PxcZiQerm18A3r1UyVF6SszpWohfJgkZM
         zufdzGZt2gX/6lvPjSnhpmI1hCJFKHXar5fTHzvor9I3VniTyoBlt0+Gai4EeaVL1tIC
         15mg==
X-Forwarded-Encrypted: i=1; AJvYcCU1+uPVi7ZLs63pGAHCOffnPY94fHyjbt6wctyS3+yvDGb2bX/yfMr855iEoL2e7nUvpIj5xixNtvFBEZzKa0ctzRl7tP+HB7IUekvn
X-Gm-Message-State: AOJu0YwmFwcUAfYS4f9ArSKzOzq9xA5jgm7ZfSxiGfSiOvKiTaGaOR0Q
	2aomoOxtprRQkAVAvuk0AtM/El89Q/LiXLQRsbk8M0oB4b2ln3dsQm4+nZubNqceEGp57mZUNmf
	lj6vBe3fnjDaUbAI4XenoPQ1Fvsw40IYU97hwx6AjVb3zTal9NUfVY1/Jf+7IztY1XXg+ew==
X-Received: by 2002:a17:906:364a:b0:a46:617e:d3a7 with SMTP id r10-20020a170906364a00b00a46617ed3a7mr9211984ejb.60.1710837330130;
        Tue, 19 Mar 2024 01:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2M46P0WU30p/kI4KM147xUw+jHFCsikBReD0bxprbCUbp1whXFumyfQAXLRkNAFtveWMugw==
X-Received: by 2002:a05:6512:68c:b0:513:db96:2be9 with SMTP id t12-20020a056512068c00b00513db962be9mr10460157lfe.64.1710836978279;
        Tue, 19 Mar 2024 01:29:38 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id g14-20020a5d540e000000b0033e95bf4796sm11737388wrv.27.2024.03.19.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:29:37 -0700 (PDT)
Date: Tue, 19 Mar 2024 04:29:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Luis Machado <luis.machado@arm.com>, Jason Wang <jasowang@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	nd <nd@arm.com>
Subject: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6 sched/fair: Add
 lag based placement)
Message-ID: <20240319042829-mutt-send-email-mst@kernel.org>
References: <07974.124020102385100135@us-mta-501.us.mimecast.lan>
 <20240201030341-mutt-send-email-mst@kernel.org>
 <89460.124020106474400877@us-mta-475.us.mimecast.lan>
 <20240311130446-mutt-send-email-mst@kernel.org>
 <cf813f92-9806-4449-b099-1bb2bd492b3c@arm.com>
 <73123.124031407552500165@us-mta-156.us.mimecast.lan>
 <20240314110649-mutt-send-email-mst@kernel.org>
 <84704.124031504335801509@us-mta-515.us.mimecast.lan>
 <20240315062839-mutt-send-email-mst@kernel.org>
 <b3fd680c675208370fc4560bb3b4d5b8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fd680c675208370fc4560bb3b4d5b8@linux.ibm.com>

On Tue, Mar 19, 2024 at 09:21:06AM +0100, Tobias Huschle wrote:
> On 2024-03-15 11:31, Michael S. Tsirkin wrote:
> > On Fri, Mar 15, 2024 at 09:33:49AM +0100, Tobias Huschle wrote:
> > > On Thu, Mar 14, 2024 at 11:09:25AM -0400, Michael S. Tsirkin wrote:
> > > >
> > 
> > Could you remind me pls, what is the kworker doing specifically that
> > vhost is relying on?
> 
> The kworker is handling the actual data moving in memory if I'm not
> mistaking.

I think that is the vhost process itself. Maybe you mean the
guest thread versus the vhost thread then?


