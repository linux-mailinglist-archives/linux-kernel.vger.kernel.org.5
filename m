Return-Path: <linux-kernel+bounces-52381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66E84975A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C49290B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69614A90;
	Mon,  5 Feb 2024 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ABPuaPKx"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4C13AC8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127666; cv=none; b=uTfbOtoyCsXzOxlpsXOrI4LbrQpvHR4NPXGgYhx55GK1AWWK0YgGQGv0Q86yhjO+P616FtPGNu1LFtsY8c4/S1YGTvOAc7i0lVj/BWs8EU1ZXB92Vr3OCXB95IlFOPDkZu7y5hA465P7xLzdg3A9c+eSpYAkiV7+GwN6QNHesXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127666; c=relaxed/simple;
	bh=tD4QR9Po7scG1koROP0sIkHIipingYtfL96RhUuPG9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlJecSSCi5JzQ8NMRzJAMIBc32Un55S/05XvqWgaX69GfyXcZ9yB5WTZhnki0tJab3y3ta2exoJQ6rs/YHg1O4RKWSgZmu9Es5j2jm04zMEiT/unf0OX9OBx801VKrPXegGYT0Z6Grf7Z/Hj+hW5sP0yByoMVjTmEuEhYsp7+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ABPuaPKx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29041136f73so2825442a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707127664; x=1707732464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTu8hCiFGaRTFcyBAl4MNKVcs6pCHrxvfIEHSfh1ONU=;
        b=ABPuaPKxsw1dnSJX0FCjAw5KI2ROCfEOavcWnRdwI5FrBB5pyi8LEmZZA64ckIqhC5
         CuFbmUjmUFZEvf1KXCjkENzHbuGlJq8GWuWUIcRhSADo20mQVxmO5jrfN4F//kPxcTkX
         8qhR65WlPty06BgETn9keeHmXRKNRbb62FOUW5a0TDbRmMdV/Vy6DJlzKjTP025U2Z51
         SvPD1pZ1aN2lLbGRCy9wwKUlD70FlgtumL+Zds/qrDV0uucOUgtkSLfVDNpi3dgTL8MA
         oFeftkzhmcYIRlDkzKKykMfq3ppiZ8odUB4LBW2BsK04uG1lq+yrjgp2Qj+XyjLvOtIT
         D/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127664; x=1707732464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTu8hCiFGaRTFcyBAl4MNKVcs6pCHrxvfIEHSfh1ONU=;
        b=HMxcELZZGBtygVuEfzKUvxsdro9g4/Zpna41aUNl6I4t6j/nNXo4N6YMIvXNa43Ufa
         4TsrImnDCcieFLyJ1N6pgjc3xDHUDy2CgI8MSzWgicC3ZWUCliQCgA6lsnkITFOP/84b
         jK1JSZ/7q/Dt1E68FMQ1G2ygV1mwPTx41P/+6Ex9JIELA+zI81TWVJJdLPPoXX/zAwMt
         lxYiUUUOXswRPgiSIt4ezG+qrqKikjBrBDTz4Ym+AHWBvJvF10KlFHzxinxZ3swVrfiR
         wv0voFxe7TG3D+m+/V/4h+5RTpts2pgwPfSjNae1gVB+Mnl0pzRgBOIUvA8ocJURZvSD
         RiNA==
X-Gm-Message-State: AOJu0Yw0mOHzNXOGY5SLsaXp2v6pKMc1Rra220hyIs9Fc+50Q1MGSynm
	y5R88xpuI95ynX8F+LKeZiFiQj18SgmO+2FKSO9vh+VxMdc5VoVJ1dk3RNy/CuU=
X-Google-Smtp-Source: AGHT+IHpt62Ya3GlCVxPD/oOFtFpdKJCCajYVL3/N0YP3NrsbMwh1cOF44ldpqR0MMBr3e5mIs1ZVA==
X-Received: by 2002:a17:90b:11c9:b0:294:b47d:9f4f with SMTP id gv9-20020a17090b11c900b00294b47d9f4fmr7778514pjb.34.1707127664021;
        Mon, 05 Feb 2024 02:07:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWZ/Dm1OhcAI1YE902vGjWl423HhsqCsMLA5c03+mK8Yxgw3nHp8DXirojt/zcNRSIuWIoN15lBrdRpiJZwnym9uWN8NS+96dLafLX9ZI/86PMOaifPT/Zr3fxMg/kQ8PKsop5d1vcmXaT3W+WAXm6rm3k2vryjYctDWQ==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902c74b00b001d91b608a9csm5911371plq.279.2024.02.05.02.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:07:43 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rWvt7-002L0B-05;
	Mon, 05 Feb 2024 21:07:41 +1100
Date: Mon, 5 Feb 2024 21:07:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: chandan.babu@oracle.com, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Simplify the allocation of slab caches in
 xfs_rmap_intent_init_cache
Message-ID: <ZcCzbZDvBkCDyUIR@dread.disaster.area>
References: <20240205081227.434198-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205081227.434198-1-chentao@kylinos.cn>

On Mon, Feb 05, 2024 at 04:12:27PM +0800, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.

What makes you think KMEM_CACHE is new? It was added to the kernel
in 2007 The vast majority of the kernel is still using
kmem_cache_create(), not the weird, shouty macro that doesn't
actually tell us what it is doing with said kmem_cache......

Up until now I've chosen not switch XFS to use it because many of
the slab caches we use in XFS are not just "default" slab caches.
IOWs, we still have to use kmem_cache_create() for a lot of the
caches we create, so we may as well use kmem_cache_create() for all of them
rather than have to go look up what KMEM_CACHE() translates to every
time we are looking at how slab caches are created.

Also, if you are going to change simple API stuff like this in XFS,
please do all the conversions in a single patch. It takes much less
time and resources to review and merge a single patch compared to a
couple of dozen independent one line patches...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

