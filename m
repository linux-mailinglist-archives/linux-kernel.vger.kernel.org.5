Return-Path: <linux-kernel+bounces-79328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F828620D2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775151C23E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B33814DFE3;
	Fri, 23 Feb 2024 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bFNTDbX4"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C1F14DFD6
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732385; cv=none; b=qWB8pG5ema4+pXpWsVZqqg8IKrFycaeJ8Fx+jXPSQ6MWjjekURZMkTMW5km96vB0sE8YqSkyTBDeP+e2u2LAemsRauu2icZAL9knF6EHkYpr+86I4Bgv7y+ma1IgFhYi0c82o1fUA/GO+r/RfCDwi0zcmsEzTT8yS/Sj0TAXcbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732385; c=relaxed/simple;
	bh=zg8HqNF7aNa77zuqfRyQfW/fe99lLofctq+gMMs9G44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eimou3HMPMCdO9x2a3Gpw4TaGlStGR0eTb7KJmvibDlX17jRvB4T2NnY0zhDpa0mvkt5X2ve/821ViZd9H+0RJdDJXQPCg310oPud4CD3nvDvPcEpSypAj3TiDiq5b+epz7LOyizY7qmd95f2Ktk5AcMkK6JdrJU2GkfaIxhe+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bFNTDbX4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b519e438so1293509a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708732377; x=1709337177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CtZ/gyZzvkeNiWt3oVfT5QTmQaJyVqDv2YJqGRGnkp8=;
        b=bFNTDbX4t/+wJ17uhYeOwK48ligwrudqgUXrs6T66/iR9ztdLkoTEaH5f6krmWc6bN
         HSbqmhjOXmNszglAVWbWLLy91gWIdSDFUzj/6QdyXgzQD0bVKyFBbzCIEk5tcP/Nxr5I
         YIlgaI+ggYj152lj+s8Mf4J3my0SIHzMG+SL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732377; x=1709337177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtZ/gyZzvkeNiWt3oVfT5QTmQaJyVqDv2YJqGRGnkp8=;
        b=VzGQ9ymoOseL/bz8g4tLLzsDGq2hpxEI4aVRf2f96WCqaJQh2UuUtREiomvZSR9/k3
         Bub9t1KMRjGGIiB7eh9IYPN4yqYUTGDbmUOZMvVxzt88ifP8MXPV12ZMVgnVbUEMxVDD
         sgINUv4x7HbGizEzf1vja/haIdpsf5z+Xl0kGnotcuo7qjlQ8VNZEJM4DUfkMz+o+wEJ
         vgi8iR7kWbunaxT+FnBqogHLHemUabBQL9qU2Dli2Mu1jEGTp0dYEX5l0wNMIqcbK5fI
         87kLrXcYv/pFfxoYMgvc9wLs7Ed/Hg3YRQqDATpJn+/bdZl7BkfFkKDfm4kkeNxXvcKj
         iEtw==
X-Forwarded-Encrypted: i=1; AJvYcCXcNFvvryAMSPygP6jS8DQkcOrvOnw24FxsiOyAuYztXwRUjcIIoWEU3djUu8QfabxfRqMAoZL/37YlL2Hvoz+dUmkZYSj3DeslZq9p
X-Gm-Message-State: AOJu0Yx1Fk6cd/+6f/YrXI/YFp8IvMbbwdreVAklVJo8P8GGQi2wm3Ep
	eMkqmahXBqPhx4QaueIntaPzBBcC4mWx6ca4yDGDa4n7fmIdGbxwcPX+y3g6CEsL2J/QJEUALEk
	=
X-Google-Smtp-Source: AGHT+IF2ovpdMncpOoipr11gK3mj2YeoUlDG6r4zkubeInfRKqAiH6Gx3gjs5b2QMNtbTaGPmvGiTg==
X-Received: by 2002:a05:6a20:a49d:b0:19e:a527:96be with SMTP id y29-20020a056a20a49d00b0019ea52796bemr966445pzk.43.1708732377079;
        Fri, 23 Feb 2024 15:52:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l64-20020a632543000000b005d3bae243bbsm57028pgl.4.2024.02.23.15.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 15:52:56 -0800 (PST)
Date: Fri, 23 Feb 2024 15:52:56 -0800
From: Kees Cook <keescook@chromium.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Peter Rosin <peda@axentia.se>, gustavoars@kernel.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH -next] mux: convert mux_chip->mux to flexible array
Message-ID: <202402231552.26E774D@keescook>
References: <20230223014221.1710307-1-jacob.e.keller@intel.com>
 <e8782296-49bc-33a2-47b3-45c204551806@intel.com>
 <202402182100.1D5BBE45@keescook>
 <787dcf27-c434-42e0-9c80-35e341aa16c4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787dcf27-c434-42e0-9c80-35e341aa16c4@intel.com>

On Tue, Feb 20, 2024 at 01:27:45PM -0800, Jacob Keller wrote:
> 
> 
> On 2/18/2024 9:04 PM, Kees Cook wrote:
> > On Mon, Feb 27, 2023 at 12:28:43PM -0800, Jesse Brandeburg wrote:
> >> On 2/22/2023 5:42 PM, Jacob Keller wrote:
> >>> The mux_chip structure size is over allocated to additionally include both
> >>> the array of mux controllers as well as a device specific private area.
> >>> The controllers array is then pointed to by assigning mux_chip->mux to the
> >>> first block of extra memory, while the private area is extracted via
> >>> mux_chip_priv() and points to the area just after the controllers.
> >>>
> >>> The size of the mux_chip allocation uses direct multiplication and addition
> >>> rather than the <linux/overflow.h> helpers. In addition, the mux_chip->mux
> >>> struct member wastes space by having to store the pointer as part of the
> >>> structures.
> >>>
> >>> Convert struct mux_chip to use a flexible array member for the mux
> >>> controller array. Use struct_size() and size_add() to compute the size of
> >>> the structure while protecting against overflow.
> >>>
> >>> After converting the mux pointer, notice that two 4-byte holes remain in
> >>> the structure layout due to the alignment requirements for the dev
> >>> sub-structure and the ops pointer.
> >>>
> >>> These can be easily fixed through re-ordering the id field to the 4-byte
> >>> hole just after the controllers member.
> >>
> >> Looks good to me (just a driver dev, not a mux dev!). Also added
> >> linux-i2c mailing list and a couple others for more review.
> >>
> >> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> >>
> >> related thread (cocci script) at [1]
> >>
> >> [1]
> >> https://lore.kernel.org/all/20230227202428.3657443-1-jacob.e.keller@intel.com/
> > 
> > *thread necromancy*
> > 
> > Can we land this? It's the last struct_size() instance that the above
> > Coccinelle script flags.
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 
> I'm happy to send a v2 if we need.

Since it's been a while, yeah, can you send a v2?

Thanks!

-Kees

-- 
Kees Cook

