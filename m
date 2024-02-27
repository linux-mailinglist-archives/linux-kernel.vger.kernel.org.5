Return-Path: <linux-kernel+bounces-83110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4E5868E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3968E1C2333B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5713A24C;
	Tue, 27 Feb 2024 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AO/xkNcV"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B0130ADF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032446; cv=none; b=IMRq4XbOeo3cGgo8onYxNv153hit5hbEHMj/9bg1GIaIBPfiA8HOm1gki15syZq0ft2zjzVsTlvDcUVpsWAjkAFceSbLp8wQ9FLF6QeeFEEcYkodsJ+Jt+0rt4A+j5H9IPvCfQazGdw9gu9pmauTrL7DIq0TF35G85irulINgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032446; c=relaxed/simple;
	bh=xb3Ql6xT74CAOQFb23o6aeaQuso1t6kO3YOXaRZgSMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3E+t7+Wb97DyDfjfcIyX3hbEaUYQTa2wEnGJUt3LlO9XEwjiZF7MDBDbR7NtN4IIY9WdO69hnXRDre1/LG/rqCYyMhvaSuIo4SIUtA5cvgDZrg/LyKJSG/D2BBmdflIZoPqE0La1nIY9jvFoBIwl8fYeF5dAAX/vURpUR4H5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AO/xkNcV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 348FE40E019E;
	Tue, 27 Feb 2024 11:14:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AgoBXzs2zQv7; Tue, 27 Feb 2024 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709032438; bh=99TMyWukII079j6mPAdkD+OQGFzvrXC2zWsz+T4V/+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AO/xkNcVx0vGn6QhDuF7PuTPIbOCxbZb84R59KxJGH7Pk5SptW8/bspueiZAxPcmj
	 DTqzs+9+cKNzJFbOcZDfLoF9xyzkUN4PfWEMm/MsJsZsNFJcMwByPbB0DMYOhLdT7J
	 CAnJBAdf8Ktrb3C+fzQ9WeL2+5kovQw+4RoIQkTb2Wdxa3hogrhk6cciEntvQp9Uin
	 CUvv2nHpLbx9yzPfEwA1KAVlmqc+KWFlUq2C5JaUhI8hhomeE9CYZeHm523z0kSJMH
	 L4GRXz59JYyOwYy1G9QEIwG1dvwzPrkyb59TxdjSt8f+yfXCunU4uQiOT1EAGjDfeG
	 I8mdGBFrW/cdaHfj/5y7VQKKFhda/quH+sKWtaF8rqcmJpd6ApGrx4ZJ+JC9d7YEdh
	 uFbo3akQ270OH5Fy72yYUCTPq7mPudr78L//5qy726ueJoRjCDnBb/GA8hZJSwBvNu
	 cs6l0jLOS4Yi4mHwpBT073RdCawk+5tSxkfnCkpBFLuf+3XBF48UAd/JrG5E8XmEpE
	 T6VAi65XYPZqOKUlbsg8OvBDLf2Z1LMMxqkgHECwwpvMgf9Ul3mUKkW+MRjzb1CkS3
	 7wuBO9u+MM/uZgt5zGs0YPdnK39cTe/8Qs6Ww8nAwIj7hjRmwv9EAX/Dt1vv/H7n17
	 tZMmRjLBu79QfGtZvRVzNJes=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B2E7740E016B;
	Tue, 27 Feb 2024 11:13:49 +0000 (UTC)
Date: Tue, 27 Feb 2024 12:13:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, ville.syrjala@linux.intel.com,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: BUG: sleeping function called from invalid context at
 drivers/gpu/drm/i915/gem/i915_gem_pages.c:526
Message-ID: <20240227111344.GCZd3D6CibmN8KLWgl@fat_crate.local>
References: <20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local>
 <87jzmqjir5.fsf@intel.com>
 <20240227105356.GBZd2_RL9hjC_LupZB@fat_crate.local>
 <87h6hujhrz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6hujhrz.fsf@intel.com>

On Tue, Feb 27, 2024 at 12:58:08PM +0200, Jani Nikula wrote:
> Let's see what Ville says, but in the end bisection might be the
> quickest way to find the regression. Though I understand it can be
> tedious for you personally.

Ha, I can do it in parallel with the gazillion other things. :-)

It'll take a lot longer, though.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

