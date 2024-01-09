Return-Path: <linux-kernel+bounces-20873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E278286BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3C1C24005
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5F39859;
	Tue,  9 Jan 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="d8hEYxMp"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B638F94
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a29b850ec66so97177566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704805323; x=1705410123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgjWq+GNDqJ5m/X5ry3BHL3SU/PqMtpMN091r7LGUoA=;
        b=d8hEYxMpzBR+8QlOEeIGhic/bKWnS+H+eT9e+INslkMW7LjVe+eknOYIUXPBdi4pQZ
         UZNXmXJVgY50yApwicHHWLjCdeOtHYiALWrvB+iyaqJeNe+TaSOyCElQYD6+cYN3sxvI
         JpofjVfa8QpTVORQ+qWDUPTt5VX4pchmsiySQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704805323; x=1705410123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgjWq+GNDqJ5m/X5ry3BHL3SU/PqMtpMN091r7LGUoA=;
        b=bFTqeqon9GsefRgJf/LIiXCawBjlxRXOHZrzAfbe+8YAG99UvMJa8u/+NyIVPtQJW6
         x6Nsfqe1a8/4AYGt98xNgnQSfmcq89IsqvUpEOglxp6Sq+VC5sB+y5y/af9m/sMMjyaE
         rKUF2xBCVS6ppCJjwu7OTu5724jO+g1XyS2lKIEXuwytTQD4igi5QsVrDO/9TA+wIzvR
         3+3DlMc5GbAkg520JpVnSXcX/Lo59U/W/wHXEQdnFt+KoUcvc4gUgL2nntUke/Ld5mEJ
         iGyCwv3/uTOIc/OtWf0WBtFSMZQzhcY7vj9RRhPH61Bvor6gylUbxSlJsiQqD9+eMiD9
         h5/w==
X-Gm-Message-State: AOJu0Yzb+U7Ww37rcz6kvk6SEE50LRJAP3F80yyC9a6MjQEn4Hz4J/wl
	F/XkRdmT5BXBX8RcMERBvU3zpKMG/J8WOw==
X-Google-Smtp-Source: AGHT+IGjVfkl4K5438EgxZNYkdIb8UWsXUs419kNzc6Ewo2f7z4uJ8gnFTH0tvWgAwZexzBu/d17zw==
X-Received: by 2002:a17:906:fe47:b0:a28:34e5:b609 with SMTP id wz7-20020a170906fe4700b00a2834e5b609mr5343630ejb.6.1704805322530;
        Tue, 09 Jan 2024 05:02:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x12-20020a170906710c00b00a29430458efsm1031296ejj.65.2024.01.09.05.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 05:02:01 -0800 (PST)
Date: Tue, 9 Jan 2024 14:01:59 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Daniel Vetter <daniel@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	linaro-mm-sig@lists.linaro.org,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 3/4] usb: gadget: functionfs: Add DMABUF import
 interface
Message-ID: <ZZ1Dx1Jqbi61_Afb@phenom.ffwll.local>
Mail-Followup-To: Paul Cercueil <paul@crapouillou.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	linaro-mm-sig@lists.linaro.org,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-media@vger.kernel.org
References: <20240108120056.22165-1-paul@crapouillou.net>
 <20240108120056.22165-4-paul@crapouillou.net>
 <ZZvtEXL8DLPPdtPs@phenom.ffwll.local>
 <a44aca93adc60ce56a64c50797a029631900172e.camel@crapouillou.net>
 <ZZwU827NMHbx7bsO@phenom.ffwll.local>
 <2c0d4ef1b657c56ea2290fe16d757ce563a3e71b.camel@crapouillou.net>
 <ZZxKvR9gjH8D5qxj@phenom.ffwll.local>
 <31e56028b4d865c60b7c01b2a305b3dd8a21ff7a.camel@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31e56028b4d865c60b7c01b2a305b3dd8a21ff7a.camel@crapouillou.net>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Tue, Jan 09, 2024 at 12:06:58PM +0100, Paul Cercueil wrote:
> Hi Daniel / Sima,
> 
> Le lundi 08 janvier 2024 à 20:19 +0100, Daniel Vetter a écrit :
> > On Mon, Jan 08, 2024 at 05:27:33PM +0100, Paul Cercueil wrote:
> > > Le lundi 08 janvier 2024 à 16:29 +0100, Daniel Vetter a écrit :
> > > > On Mon, Jan 08, 2024 at 03:21:21PM +0100, Paul Cercueil wrote:
> > > > > Hi Daniel (Sima?),
> > > > > 
> > > > > Le lundi 08 janvier 2024 à 13:39 +0100, Daniel Vetter a écrit :
> > > > > > On Mon, Jan 08, 2024 at 01:00:55PM +0100, Paul Cercueil
> > > > > > wrote:
> > > > > > > +static void ffs_dmabuf_signal_done(struct ffs_dma_fence
> > > > > > > *dma_fence, int ret)
> > > > > > > +{
> > > > > > > +	struct ffs_dmabuf_priv *priv = dma_fence->priv;
> > > > > > > +	struct dma_fence *fence = &dma_fence->base;
> > > > > > > +
> > > > > > > +	dma_fence_get(fence);
> > > > > > > +	fence->error = ret;
> > > > > > > +	dma_fence_signal(fence);
> > > > > > > +
> > > > > > > +	dma_buf_unmap_attachment(priv->attach, dma_fence-
> > > > > > > >sgt,
> > > > > > > dma_fence->dir);
> > > > > > > +	dma_fence_put(fence);
> > > > > > > +	ffs_dmabuf_put(priv->attach);
> > > > > > 
> > > > > > So this can in theory take the dma_resv lock, and if the usb
> > > > > > completion
> > > > > > isn't an unlimited worker this could hold up completion of
> > > > > > future
> > > > > > dma_fence, resulting in a deadlock.
> > > > > > 
> > > > > > Needs to be checked how usb works, and if stalling
> > > > > > indefinitely
> > > > > > in
> > > > > > the
> > > > > > io_complete callback can hold up the usb stack you need to:
> > > > > > 
> > > > > > - drop a dma_fence_begin/end_signalling annotations in here
> > > > > > - pull out the unref stuff into a separate preallocated
> > > > > > worker
> > > > > > (or at
> > > > > >   least the final unrefs for ffs_dma_buf).
> > > > > 
> > > > > Only ffs_dmabuf_put() can attempt to take the dma_resv and
> > > > > would
> > > > > have
> > > > > to be in a worker, right? Everything else would be inside the
> > > > > dma_fence_begin/end_signalling() annotations?
> > > > 
> > > > Yup. Also I noticed that unlike the iio patches you don't have
> > > > the
> > > > dma_buf_unmap here in the completion path (or I'm blind?), which
> > > > helps a
> > > > lot with avoiding trouble.
> > > 
> > > They both call dma_buf_unmap_attachment() in the "signal done"
> > > callback, the only difference I see is that it is called after the
> > > dma_fence_put() in the iio patches, while it's called before
> > > dma_fence_put() here.
> > 
> > I was indeed blind ...
> > 
> > So the trouble is this wont work because:
> > - dma_buf_unmap_attachment() requires dma_resv_lock. This is a
> > somewhat
> >   recent-ish change from 47e982d5195d ("dma-buf: Move
> >   dma_buf_map_attachment() to dynamic locking specification"), so
> > maybe
> >   old kernel or you don't have full lockdep enabled to get the right
> >   splat.
> > 
> > - dma_fence critical section forbids dma_resv_lock
> > 
> > Which means you need to move this out, but then there's the potential
> > cache management issue. Which current gpu drivers just kinda ignore
> > because it doesn't matter for current use-case, they all cache the
> > mapping
> > for about as long as the attachment exists. You might want to do the
> > same,
> > unless that somehow breaks a use-case you have, I have no idea about
> > that.
> > If something breaks with unmap_attachment moved out of the fence
> > handling
> > then I guess it's high time to add separate cache-management only to
> > dma_buf (and that's probably going to be quite some wiring up, not
> > sure
> > even how easy that would be to do nor what exactly the interface
> > should
> > look like).
> 
> Ok. Then I'll just cache the mapping for now, I think.

Yeah I think that's simplest. I did ponder a bit and I don't think it'd be
too much pain to add the cache-management functions for device
attachments/mappings. But it would be quite some typing ...
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

