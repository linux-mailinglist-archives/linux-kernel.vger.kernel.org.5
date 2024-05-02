Return-Path: <linux-kernel+bounces-166419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A448B9A63
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE34E2865AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC9179B87;
	Thu,  2 May 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="w7z6BQ6D"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9A75802;
	Thu,  2 May 2024 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651217; cv=none; b=MvmCoKeXFRK8mPQUv9LTC+UczDPrAj8PLtIsW89nsb2Tb3yO7VkpKVI/UTf9xj3Gcq19QJFSAjaySUNbVvVNPHt2r+lZetoLjOqg1wKWbWs1KlbHoPXSVBBhOKj1ZwpZ5aZ6Poq0mYft4+a4ZqJArI9NRlQnSUlyl6jdDh0ZpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651217; c=relaxed/simple;
	bh=Tn9X1pB0kSnxSpRiX5UvTT+OcNnAjl4ra21UEYpQFBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXQ4rEu1CxIFS5PKgNaDM3HTiHQ9GZ17YxPrj87S/Yc3lbZtsD/82t1hjwgl94yZecN37+LprOVN3K1VoO7BjnaOC4obw6rDtQXqgvaY1qOfg0DuXaOxFBJlhFr0DUm90b18fo9kEgBDWnubUH3wtBquNkvVUB/vwjJXs/tXDUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=w7z6BQ6D; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714651214;
	bh=Tn9X1pB0kSnxSpRiX5UvTT+OcNnAjl4ra21UEYpQFBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=w7z6BQ6D9JT6SOIHFBP+7pSW2NXFePpVrghIzJ5rmMdTxpIuV+bBe9d5qZZXSGIkp
	 2ekjhCeQBdItsVg9DeENZR9+IN0NNez/qIhgE4+rSf8rQLW57XtrIRP5uvpb7o25/X
	 RlGnurlZNcoW1dxBTDbfDhv7owoKTXIv+dGPFf0r2gXPR5t/AxRhLZDtY+1LfVg9vw
	 lFTc4sKdbQKovKKbBglEcitnkmn1KOmHbgaHupGM2VC4PJnvVGd9L1l+GSQf7eb0dw
	 Z98+gKWXX7KoLvX9rxvokb+fjUWLomSOf18J9k9AXF5wNKxb8OMSHQpnSARPIXjZre
	 I8BE23098+Ykg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4E11C378143B;
	Thu,  2 May 2024 12:00:13 +0000 (UTC)
Date: Thu, 2 May 2024 14:00:12 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>, Qiang
 Yu <yuq825@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob
 Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian Koenig=
 <christian.koenig@amd.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Zack Rusin <zack.rusin@broadcom.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3 0/2] drm: Fix dma_resv deadlock at drm object pin
 time
Message-ID: <20240502140012.68e88831@collabora.com>
In-Reply-To: <20240502135941.136ad639@collabora.com>
References: <20240501065650.2809530-1-adrian.larumbe@collabora.com>
	<84a5f7b6-d20a-4c69-83a8-d8394fea2b68@suse.de>
	<20240502135941.136ad639@collabora.com>
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

On Thu, 2 May 2024 13:59:41 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> Hi Thomas,
> 
> On Thu, 2 May 2024 13:51:16 +0200
> Thomas Zimmermann <tzimmermann@suse.de> wrote:
> 
> > Hi,
> > 
> > ignoring my r-b on patch 1, I'd like to rethink the current patches in 
> > general.
> > 
> > I think drm_gem_shmem_pin() should become the locked version of _pin(), 
> > so that drm_gem_shmem_object_pin() can call it directly. The existing 
> > _pin_unlocked() would not be needed any longer. Same for the _unpin() 
> > functions. This change would also fix the consistency with the semantics 
> > of the shmem _vmap() functions, which never take reservation locks.
> > 
> > There are only two external callers of drm_gem_shmem_pin(): the test 
> > case and panthor. These assume that drm_gem_shmem_pin() acquires the 
> > reservation lock. The test case should likely call drm_gem_pin() 
> > instead. That would acquire the reservation lock and the test would 
> > validate that shmem's pin helper integrates well into the overall GEM 
> > framework. The way panthor uses drm_gem_shmem_pin() looks wrong to me. 
> > For now, it could receive a wrapper that takes the lock and that's it.  
> 
> I do agree that the current inconsistencies in the naming is
> troublesome (sometimes _unlocked, sometimes _locked, with the version
> without any suffix meaning either _locked or _unlocked depending on
> what the suffixed version does), and that's the very reason I asked
> Dmitry to address that in his shrinker series [1]. So, ideally I'd
> prefer if patches from Dmitry's series were applied instead of
> trying to fix that here (IIRC, we had an ack from Maxime).

With the link this time :-).

[1]https://lore.kernel.org/lkml/20240105184624.508603-1-dmitry.osipenko@collabora.com/T/

> 
> Regards,
> 
> Boris


