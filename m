Return-Path: <linux-kernel+bounces-59938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E08F84FD96
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DE7287F72
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C16F63C7;
	Fri,  9 Feb 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0FgUj9Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993065677
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510654; cv=none; b=fSJGhx/ah5CjcrJSMXfNr3X7NCvE/8IHzk+V/RruEXUZcEG9uaQ7df2+DxAbxlN+OsU3YC9h3XwKMxK0xiTvyDSXvqr0d4rz8zXuWb0Kx9sn9PkmHZAUHmhcqe69aJcNSoS3S96PndJFd8Eq55nT720lrCjOYqWOft3yRGU4iHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510654; c=relaxed/simple;
	bh=KrHznBuwaabRsN5qbonlIYaEpCp/iU506qqInVuAJ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvPS6UCKhhO2K8kWZr6sS1m/7Z0gSpmHkBnEHqrwtWE5xMVHD/dLa2vmMY2nVtuK7aCkAb/E1G54Z9oxqVJw63sZDhUmU4VbmYrUYje5zFqiO8qSg5gU6mSncrMucoOjAKTNdBXdc2ommKGiClTIGmNNY3aUc4FV2+p4GWaFLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0FgUj9Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707510651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8J/XbEGW4rTV6z/EaKBWgEwgI/IDyi1WgmOXHA89nc=;
	b=N0FgUj9Q5AK+1OWY6KMcWcLFXB/nZbDYog2dGqDrcpbgUfbx5ZfyGNR2JUg7JV2lwnMGeH
	kggPAdrbt4tgIPXLnqdhjVv03cLUuNRX0xpwiggwpKfTcv5dnQ69MHW5FtlDO0Hl7jRxg3
	pJ4atz0DpzLjVyiY4rri7g79PERYhJY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-Oy5Rdq8vN0qXPmdGpYsydA-1; Fri, 09 Feb 2024 15:30:49 -0500
X-MC-Unique: Oy5Rdq8vN0qXPmdGpYsydA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4107802453dso4619195e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 12:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510648; x=1708115448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8J/XbEGW4rTV6z/EaKBWgEwgI/IDyi1WgmOXHA89nc=;
        b=RsjYCNzoMQyqi9pSVZJqVPVD8YCsNVfFVRGiUSYQ72aQg2rdmyQOe7IwUiV9tCDIy6
         XCfn4vyv+8rml9j3fHa38SD83X9GckkW7obIK+TUqlcN85fkC2AnXn3+p0ncBrDdjM4U
         Ss/ZbLIUOBuKNh2dHGFcwWAPcLmMxgMB58xM8I4XcOvXJf4UfyvQwmM0RlHZh5eLrTW9
         FVrzVxlRbc0z024nJ56E5PpJhh8/ICwMpX7RCjnUbYp1LcLGQ4h7vOKz04n0W+8+zjVU
         kMKfYCCK9EpWVodTxSsazA3ujdOAS8GiG9TGF7TdE1KIu/rHsSDeFugrsGR6eHA78YpA
         ohgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmPnzIjH0fNVEqGV4Ldy0XcLglfwuj5z3n5m3UHziCHvLN7IMAaOmSQ7MwYxBF6YhSkYa9ikFs1QzML+v6ZHAartRiRKs3VzSF8Tkl
X-Gm-Message-State: AOJu0YynPJrBCz9DGcLRDHR5Hs0EqG5PGq2pik4o2gifXH9tsCYfAPJk
	xDVZrINGz1jQGHNxgPKQ3MAAmcS4jLZCx/BWYfICM0ODGyK1RqSYyqRZfYkoxPJa8JGMrAdXiL4
	wjQMp6j7KSkLNa8aSyYskNBY263eJR9Ey7bFikAbYwxq1QONr/yifuU+46vcCGw==
X-Received: by 2002:a05:600c:5248:b0:40e:f2d6:9dc with SMTP id fc8-20020a05600c524800b0040ef2d609dcmr299009wmb.33.1707510648622;
        Fri, 09 Feb 2024 12:30:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn7tTpFP36Rfj//rT72qd9+jvGx2yenpz6/LSui/V8HYLJ/ywcOwSHhBf9szBB3acqUagp1Q==
X-Received: by 2002:a05:600c:5248:b0:40e:f2d6:9dc with SMTP id fc8-20020a05600c524800b0040ef2d609dcmr298995wmb.33.1707510648315;
        Fri, 09 Feb 2024 12:30:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcq9h0v46XkBbkpGmGw7p+gvFjC5M5dM9Vxo8+153Wr+2lSmDerGeFt0bQGagJ3AqQ62L9bMcfNAhyGp2EErv/jeUfhwoqxnFqHWXQmWyIufisWQ5NN+QWQZlhqNzGtg3ymkuvzMX62LPzGS7cu5QPu8iSUMsQ7o6o8mDsv/1PeyApbtC7c0tr4rM19hySOPuvNxflS+MbsX7T4dcy51FG4nTDSJDOHg2oTilImEUjF9D97lu6EPkSvViSU5ywMA6djQ5iy8zI6i8Z1CgH9ADUR4hIYgyTZ5dnpM5e3m41u/AzGTlyFFLd1f8XUHyiMrA2TbDmPUp5WspO/0kN3M4DJfVZl1bznOif8MLeUNZ6JMJUffSu4bpqe4e3RjzORPF4lNXqSILT96MQe6qWSLLYaiRE9viR3LceZoFPgmqQ4SLwrk5+FfsTiZKXV4pGD77JBdQi4X+LMuG+3Y6kX6rHBO1SJC2XaPIdkIlpeCi4v+S7sSmgEXReM8iiCvemxFkRuc3WnHLe1Fa0/cXLvqaT9xfK6QfieDTCNEXIlIWWWNaoUpH0eAyFuxH2qyqMoSV10vmbY//bU6qpp6m8rb//wF90dZGrVCRNumEXcMHCB/ll6EBPUktzLtXGDl4=
Received: from toolbox ([2001:9e8:898e:7200:1f00:29c:19b0:2997])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b003392206c808sm109606wrv.105.2024.02.09.12.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 12:30:47 -0800 (PST)
Date: Fri, 9 Feb 2024 21:30:46 +0100
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Emma Anholt <emma@anholt.net>, Jonathan Corbet <corbet@lwn.net>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Hans Verkuil <hverkuil@xs4all.nl>,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB
 property
Message-ID: <20240209203046.GA996172@toolbox>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
 <niqn7eql5neyfp5ficdfisdpmlwrprovqn5g7lgcfwoe74ds23@7fr4yv2miqe7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <niqn7eql5neyfp5ficdfisdpmlwrprovqn5g7lgcfwoe74ds23@7fr4yv2miqe7>

On Fri, Feb 02, 2024 at 04:49:04PM +0100, Maxime Ripard wrote:
> Hi Sebastian,
> 
> On Mon, Jan 15, 2024 at 03:33:08PM +0100, Sebastian Wick wrote:
> > >  /**
> > >   * DOC: HDMI connector properties
> > >   *
> > > + * Broadcast RGB
> > > + *      Indicates the RGB Quantization Range (Full vs Limited) used.
> > > + *      Infoframes will be generated according to that value.
> > > + *
> > > + *      The value of this property can be one of the following:
> > > + *
> > > + *      Automatic:
> > > + *              RGB Range is selected automatically based on the mode
> > > + *              according to the HDMI specifications.
> > > + *
> > > + *      Full:
> > > + *              Full RGB Range is forced.
> > > + *
> > > + *      Limited 16:235:
> > > + *              Limited RGB Range is forced. Unlike the name suggests,
> > > + *              this works for any number of bits-per-component.
> > > + *
> > > + *      Drivers can set up this property by calling
> > > + *      drm_connector_attach_broadcast_rgb_property().
> > > + *
> > 
> > This is a good time to document this in more detail. There might be two
> > different things being affected:
> > 
> > 1. The signalling (InfoFrame/SDP/...)
> > 2. The color pipeline processing
> > 
> > All values of Broadcast RGB always affect the color pipeline processing
> > such that a full-range input to the CRTC is converted to either full- or
> > limited-range, depending on what the monitor is supposed to accept.
> > 
> > When automatic is selected, does that mean that there is no signalling,
> > or that the signalling matches what the monitor is supposed to accept
> > according to the spec? Also, is this really HDMI specific?
> > 
> > When full or limited is selected and the monitor doesn't support the
> > signalling, what happens?
> 
> Leaving the YCbCr vs RGB discussion aside, would this be better ?

Yes, it is. Thanks.

We do have to resolve the YCbCr vs RGB issue though.

>  * Broadcast RGB (HDMI specific)
>  *      Indicates the Quantization Range (Full vs Limited) used. The color
>  *      processing pipeline will be adjusted to match the value of the

Ah, another thing no note here is that the CRTC as configured by user
space must always produce full range pixels.

>  *      property, and the Infoframes will be generated and sent accordingly.
>  *
>  *      The value of this property can be one of the following:
>  *
>  *      Automatic:
>  *              The quantization range is selected automatically based on the
>  *              mode according to the HDMI specifications (HDMI 1.4b - Section
>  *              6.6 - Video Quantization Ranges).
>  *
>  *      Full:
>  *              Full quantization range is forced.
>  *
>  *      Limited 16:235:
>  *              Limited quantization range is forced. Unlike the name suggests,
>  *              this works for any number of bits-per-component.
>  *
>  *      Property values other than Automatic can result in colors being off (if
>  *      limited is selected but the display expects full), or a black screen
>  *      (if full is selected but the display expects limited).
>  *
>  *      Drivers can set up this property by calling
>  *      drm_connector_attach_broadcast_rgb_property().
> 
> Thanks!
> Maxime



