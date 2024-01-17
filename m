Return-Path: <linux-kernel+bounces-28732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C168383025E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022BB286827
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDE414004;
	Wed, 17 Jan 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg+H5DNS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3D67C6E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484001; cv=none; b=nmxZIuELZuUpItXoBwkKi3/MggtTQ1Bp+Tf9GmD2WNmD8A50ERHypg6IqNohiBdqFb3CI8g1jscl0FY5X9/tywJ9R6u8r5z9VH6wwSOZ7sI0SVaIEa/nkNHR6JGXa+zLFD5dpcG3m5MekKfUO2RV+9s+LpHUdxKWR23pL1HB1wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484001; c=relaxed/simple;
	bh=Hu9dm8ZObL7wR5kdtp/P19OQIMCvQ8txBzsqQBsIopY=;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer; b=XBlF2t3vndowpzrpcLewkbOLTwo2AKD2QVLyzPyn86WApe3Jc5i6UMdZYWTitooeEqycehm2rzA7LvQD26M0BwjFOBhGxjvPsds4aSJ1I7EbydN/SU5A0bkXw7/WYw6mIVH6mPDVyQFxjvn749f4/ZDZhf7nZeqPN9bifrdQc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg+H5DNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4BDC433F1;
	Wed, 17 Jan 2024 09:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705484001;
	bh=Hu9dm8ZObL7wR5kdtp/P19OQIMCvQ8txBzsqQBsIopY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gg+H5DNSzdAZQKBcTCUIA6P/2wipiMN9afanINGAniHkDeMudoVJDKdRPhttBhHP9
	 yqTsk1kWipb6ywNKGuAOwZSPK+BJ8Nsmam7MqtcvwPTWZSBGU7bVEAo4Qx6mqtAp7t
	 Aa803a5hv0T9vOPgqriH8RImVxBT7BARI7z0IAQxAj3kgzunQ9GW0CNpe/QaaciN3y
	 JZ69mds+WtaM2TuOpGEW6+0kfyaxpaeIaf5MgywxZTP3/KWiUDRKkb2d9i8yDGFTue
	 mEnWjYOcR+amjJenMfnZJ2L8Jfn54F6C7g44x/GB7zyQ6XXJiS4x37MzPS4MR7OCUt
	 qIfzq3dICOVmw==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
In-Reply-To: <20240116174602.1019512-1-michal.winiarski@intel.com>
References: <20240116174602.1019512-1-michal.winiarski@intel.com>
Subject: Re: (subset) [PATCH] drm/tests: mm: Call drm_mm_print in
 drm_test_mm_debug
Message-Id: <170548399858.73195.15806480553530773396.b4-ty@kernel.org>
Date: Wed, 17 Jan 2024 10:33:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Tue, 16 Jan 2024 18:46:02 +0100, Michał Winiarski wrote:
> The original intent behind the test was to sanity check whether calling
> the debug iterator (drm_mm_print) doesn't cause any problems.
> Unfortunately - this call got accidentally removed during KUnit
> transition. Restore it.
> 
> 

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime


