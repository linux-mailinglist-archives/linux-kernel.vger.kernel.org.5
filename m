Return-Path: <linux-kernel+bounces-100761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEBB879CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DF81F22177
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A3A142910;
	Tue, 12 Mar 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Cw8/tuwE"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D11386AA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275213; cv=none; b=fnSWfh9hXT3HeGZNBwUjo/g0CHp6p2Fy/Qcph3UfEetBXPcC1nOavpa3/wEpnH39l5kVsIKE8iqAzu8rkF0Qh+tBBqoI3tRsu/87PQyhBuRAwMFaTj0ACY5bkpZJX3qAnDqTLSRwQY2yNw0HFjLRz4djWQVwj1c40LHOz3OAn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275213; c=relaxed/simple;
	bh=6QqCqncS8fTFBYJS77lc/hwVrLjNV1a8m1Jo+xCPFRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAwMYuSZSxYR0PHgwXwFk2ZfIItUX/b3SSsnHlaFmzz/zK86cb0K02oTxODLknkYCJYJYbeElB0sc7ZFT7BCXpcBaxNZBFJRCBKp5ya/35pXINvh5OpywQFD4iueM/YiDQWpLQBjoch1tpUBGdjqqBXcS+7NBe3J8KmBiQAmIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Cw8/tuwE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vB/FuN5JdbTJIQDfsr256losXLHU4seda82ExkFZ/Bc=; b=Cw8/tuwEQaWKJA8VMqnvHjabrs
	VdnsLEs4hM7BCCkv1GHT7sEjEnyJWjAssG0WgahqpMd2du/xFRidWBu8yNaiLTk6OlIhZMq6FNFoq
	HdNs2CCG4y3kyn3nEJSMc8/8Se/II0NrrCkkAp0ejGBJsX8UAagUfVeeIdu19Iip+hoAN3J3qTKiu
	Z0mx0ST5O4K21+N60hI1LzezAQ5BaJLs0IswlxqrrcqDkQIB6iFEbtOj8Pa87zsz0EWrtXGj5DVQX
	toixFVPj4HvdjVao7dAWUzhO5fcVEj2b4GVgbUHslfnPC/KbtF8ap1ILRrt8DOW2+l/iMIp8XMRBH
	72whPzgg==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rk8hj-009VrP-Gy; Tue, 12 Mar 2024 21:26:32 +0100
Date: Tue, 12 Mar 2024 17:26:17 -0300
From: Melissa Wen <mwen@igalia.com>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Arthur Grillo <arthurgrillo@riseup.net>, 
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, Melissa Wen <melissa.srw@gmail.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi, 
	Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH 0/7] Additions to "Reimplement line-per-line pixel
 conversion for plane reading" series
Message-ID: <x6vrj6l7mpn5hwrx4ceafdaagqbbcsj5n753wrx2bapzl5w27e@ye4e2kgi3fcm>
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
 <4b01ba61-9184-4a17-9fe6-59eb88a21214@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b01ba61-9184-4a17-9fe6-59eb88a21214@igalia.com>

On 03/08, Maíra Canal wrote:
> Hi Arthur,
> 
> Would it be possible for you to coordinate with Louis and create a
> single series with all the modification?
> 
> I don't see a reason to submit fixes to a series that it is still
> on review.

I agree. Moreover, the fix for drm_fixp2int_round() should go in a
single patch detached from these multiple work branches, since it
is addressing an issue already upstream.

Thanks,

Melissa

> 
> Best Regards,
> - Maíra
> 
> On 3/6/24 17:03, Arthur Grillo wrote:
> > These are some patches that add some fixes/features to the series by
> > Louis Chauvet[1], it was based on top of the patches from v4.
> > 
> > Patches #2 and #3 should be amended to "[PATCH v4 11/14] drm/vkms: Add
> > YUV support". To make patch #3 work, we need patch #1. So, please, add
> > it before the patch that #2 and #3 amend to.
> > 
> > Patches #4 to #6 should be amended to "[PATCH v4 14/14] drm/vkms: Create
> > KUnit tests for YUV conversions". While doing the additions, I found
> > some compilation issues, so I fixed them (patch #4). That's when I
> > thought that it would be good to add some documentation on how to run
> > them (patch #7), this patch should be added to the series as new patch.
> > 
> > [1]: https://lore.kernel.org/r/20240304-yuv-v4-0-76beac8e9793@bootlin.com
> > 
> > To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > To: Melissa Wen <melissa.srw@gmail.com>
> > To: Maíra Canal <mairacanal@riseup.net>
> > To: Haneen Mohammed <hamohammed.sa@gmail.com>
> > To: Daniel Vetter <daniel@ffwll.ch>
> > To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > To: Maxime Ripard <mripard@kernel.org>
> > To: Thomas Zimmermann <tzimmermann@suse.de>
> > To: David Airlie <airlied@gmail.com>
> > To: arthurgrillo@riseup.net
> > To: Jonathan Corbet <corbet@lwn.net>
> > To: pekka.paalanen@haloniitty.fi
> > To: Louis Chauvet <louis.chauvet@bootlin.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: jeremie.dautheribes@bootlin.com
> > Cc: miquel.raynal@bootlin.com
> > Cc: thomas.petazzoni@bootlin.com
> > Cc: seanpaul@google.com
> > Cc: marcheu@google.com
> > Cc: nicolejadeyee@google.com
> > 
> > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > ---
> > Arthur Grillo (7):
> >        drm: Fix drm_fixp2int_round() making it add 0.5
> >        drm/vkms: Add comments
> >        drm/vkmm: Use drm_fixed api
> >        drm/vkms: Fix compilation issues
> >        drm/vkms: Add comments to format tests
> >        drm/vkms: Change the gray RGB representation
> >        drm/vkms: Add how to run the Kunit tests
> > 
> >   Documentation/gpu/vkms.rst                    |  11 +++
> >   drivers/gpu/drm/vkms/tests/vkms_format_test.c |  81 +++++++++++++++++++--
> >   drivers/gpu/drm/vkms/vkms_drv.h               |   4 +
> >   drivers/gpu/drm/vkms/vkms_formats.c           | 101 +++++++++++++++++++-------
> >   include/drm/drm_fixed.h                       |   2 +-
> >   5 files changed, 165 insertions(+), 34 deletions(-)
> > ---
> > base-commit: 9658aba38ae9f3f3068506c9c8e93e85b500fcb4
> > change-id: 20240306-louis-vkms-conv-61362ff12ab8
> > 
> > Best regards,

