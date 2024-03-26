Return-Path: <linux-kernel+bounces-118789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC1288BF56
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83731F293A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F076CDAD;
	Tue, 26 Mar 2024 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XrWLZ/p0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0EC4C3DE;
	Tue, 26 Mar 2024 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448802; cv=none; b=aLi28GBpLVMwUgM1klA9Yru0Y9SfeR6lVZ2iHppqRlCHiSKldObQ6XA3EgCk3WDcSb5lujVc9Qv+fe8hWWMlPyCXxESxald6AUsNq8IR6c4T3tdZrh8EGkISm2iyo9u+SwSyx7z1GyzBaRsp5hp4CsmLsANdA25xqUhM+Jn9uoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448802; c=relaxed/simple;
	bh=Ufkhyldei9lgWlSrdN5/bzS4q1PlmwydeMttBxm5jDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0ML7Z8c3r6fj0a03LYo4oENfFkOkz2nVWImAp83KXg14leS7LcE5lrfTC2gsnu91yj6cNKfxx17WKuffKMuUsKRdl3SaangmLQe5IFxR9+SNUMpUrDYeIdueCHOfnhbSv3ljIvNMbImHPlQdwoVFzI/1CtJ0RX7FRN6aL8HH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XrWLZ/p0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711448798;
	bh=Ufkhyldei9lgWlSrdN5/bzS4q1PlmwydeMttBxm5jDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XrWLZ/p0SL1vC9suePIteW3t0c+F0fS6QxscxFZySrI0BCE2wkRtVZb00LoK8NTKV
	 x/IjwdcCvLuphTjU17aQD/x5srAduK2fSfXXZl9rGSGcqU/X5vBGCOLwOGVZss/bMc
	 6r6zHqjb2CHlP5RSoKSOGll+vKlEd9v2LJfvGAYTyR8Rsuwwo5JOvOeBtutIqXD6DF
	 O4sYKmF40T78E0KwAE+GkbBK6oI0ADXsaVMFCbWtf8aNX6oCS5LfeWj/k4Ru1mUc4D
	 qqr/xN7C1LjNnIGX8psTRnL9pI/dKim4K5tgu0LypI81mVkaEgT4l/7s1rEmSC2mMf
	 VOoA1bjlLu+Dw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 271D437813D7;
	Tue, 26 Mar 2024 10:26:38 +0000 (UTC)
Date: Tue, 26 Mar 2024 11:26:35 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, Steven Price
 <steven.price@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/panthor: Fix spelling mistake "readyness" ->
 "readiness"
Message-ID: <20240326112635.110302e1@collabora.com>
In-Reply-To: <ZgKgDZrUakS_pwBS@e110455-lin.cambridge.arm.com>
References: <20240326100219.43989-1-colin.i.king@gmail.com>
	<ZgKgDZrUakS_pwBS@e110455-lin.cambridge.arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 10:14:37 +0000
Liviu Dudau <liviu.dudau@arm.com> wrote:

> On Tue, Mar 26, 2024 at 10:02:19AM +0000, Colin Ian King wrote:
> > There is a spelling mistake in a drm_err message. Fix it.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>  
> 
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Boris, can you also pick this one up when you're pushing your kernel doc fix?

Sure, I will.

