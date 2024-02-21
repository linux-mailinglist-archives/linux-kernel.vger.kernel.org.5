Return-Path: <linux-kernel+bounces-74883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B89785DEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA3B1C23C79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF927A715;
	Wed, 21 Feb 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="FmhYO+ZN"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892969317
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525358; cv=none; b=VyLrgdT5BdWh9gvIvz2QY9FTu+dWXFU1zRwihYwDYxXu/KEvIOK1Md7umIjBJFbBz8ldtf/dEW6h/ppD6CRw5hC8dxiWb8iERNEsKBi/zCsuvarRlVBRJO2pqEsLLDoAnmZxzcnfBmwq1rCtt1JidOgfxV+LdiyHQbdrBtl2aSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525358; c=relaxed/simple;
	bh=LF3mPKz82wFKYBnS3pkUFExa+8tzUpNv+iiGbb7Kggc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7Sfwe+mSpYswe+rW5NZH7isFRq2QjCHxf7VLPBmzzyVBxKWHRyVubKLQf6aJvOJz438xs/e4NmxWdsLII19ObZnV3sNYjDfCoyvWxKw0u+ZPvn1/Wc/ziySn/ByrbKluKbS5tbeA9BWMjUISjvcNDj8gqahh4XqFfFKq6wVFMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=FmhYO+ZN; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708525351; bh=LF3mPKz82wFKYBnS3pkUFExa+8tzUpNv+iiGbb7Kggc=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=FmhYO+ZNYNU0FoScZxKn01rd9HtaMosC2AF9CFkg2IIDbNUYYYGRJBlLI/ow9fhuN
	 S7NpSsbC2rZGeJcs2D1NrTfoiWxgMXo7Bk3eqLWovOtIHd/rcRtGcL8axGhaxSRoB4
	 yrUAFDB3bdUZb7RnkypcZNqX5O+tiL9d3yyixMLo=
Date: Wed, 21 Feb 2024 15:22:30 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/sun4i: Fix layer zpos change/atomic modesetting
Message-ID: <6n6fnjl3dw4dnmoygh3u72ebbubotpqyg67cwkuataw2vw6lwm@bhxrtjewjso6>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240216190430.1374132-1-megi@xff.cz>
 <20240216190430.1374132-4-megi@xff.cz>
 <inuhwnlexpt6dpre4uailtvytjhms4uqeerzehbntczurhcxol@fc4nvkdwffdd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <inuhwnlexpt6dpre4uailtvytjhms4uqeerzehbntczurhcxol@fc4nvkdwffdd>

Hi Maxime,

On Wed, Feb 21, 2024 at 02:45:20PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Feb 16, 2024 at 08:04:26PM +0100, Ondřej Jirman wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > Identical configurations of planes can lead to different (and wrong)
> > layer -> pipe routing at HW level, depending on the order of atomic
> > plane changes.
> > 
> > For example:
> > 
> > - Layer 1 is configured to zpos 0 and thus uses pipe 0. No other layer
> >   is enabled. This is a typical situation at boot.
> > 
> > - When a compositor takes over and layer 3 is enabled,
> >   sun8i_ui_layer_enable() will get called with old_zpos=0 zpos=1, which
> >   will lead to incorrect disabling of pipe 0 and enabling of pipe 1.
> > 
> > What happens is that sun8i_ui_layer_enable() function may disable
> > blender pipes even if it is no longer assigned to its layer.
> > 
> > To correct this, move the routing setup out of individual plane's
> > atomic_update into crtc's atomic_update, where it can be calculated
> > and updated all at once.
> > 
> > Remove the atomic_disable callback because it is no longer needed.
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> 
> I don't have enough knowledge about the mixers code to comment on your
> patch, so I'll let Jernej review it. However, this feels to me like the
> pipe assignment is typically the sort of things that should be dealt
> with device-wide, and in atomic_check.

Yes, this is what this patch does. It moves blender setup from individual
planes' attomic commits to a single place in crtc atomic commit.

kind regards,
	o.

> If I'm talking non-sense, it would be great to mention at least why that
> can't be an option in the commit log.
> 
> Maxime



