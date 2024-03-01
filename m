Return-Path: <linux-kernel+bounces-88254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D318086DF40
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607B7282807
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA46D3FB30;
	Fri,  1 Mar 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuDHT623"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4C16FF46;
	Fri,  1 Mar 2024 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289060; cv=none; b=lviUw83Ep+wliJF2Ee+q3fZDI6tMrDhGwHdWm1xxxYoMrK3i4zaSBDgxttAypA9fccO84Nb3LxYVcNrU2p0pn5ZotE66WMg6SCw5qfvvRXgUBt6EUmKN+ekVDqLUCMQPtqBwpCpKfbFVtc9Xsp0h80h/F9wIv3vqeje5TVfJ/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289060; c=relaxed/simple;
	bh=dgKpI41QjGCHxUXx9zUpZ2jMevchmNMDZ5zbAW9T4z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7+4pO+poXUjPt4o1dmk0S/p8jlDg9OiRvVrg1KFqrJyC96wIUViVGbz4babipmRnqWqtXZPELO+QulmDIVFvRKUFLNOuUplMXAhM1AGb4Eud21zBS7tzT5KVU5LTuZghFWtzlGkdtu0PSUvwwOQeg6YfWvcyJrKy4foT/NIYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuDHT623; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC35C433F1;
	Fri,  1 Mar 2024 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709289059;
	bh=dgKpI41QjGCHxUXx9zUpZ2jMevchmNMDZ5zbAW9T4z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BuDHT623qzr/FGGXvtVM2chDjaossdPprsG1lRUK24tCYniAyYxhgC9m90qCS3Rru
	 JIjXBMl6X99Id1h2tLMiwQqLk0Urq6YAWJWdYoZlLmcypM68yq2Gq1JlqJsfv2oxxx
	 iCShHyIZvtG2HmHVD5kNQ1B4fFl5EU+KzBLVrOv1R3xoDoU7lmEEpq6VK+FHrG3NNe
	 JEF5MeLLx92PDkZ37IVduLvnfZ0YQ08kB1Lvu5t5w0H72gkiveJ8KfcHRvW7OBAyW7
	 YM76A0g/1nQVocwGbQf6FvqwVFaLiTsQmIxMhtqX0zKKtFsRjh61pTPKOvsYkiPEAN
	 1kNeUGJJuARTw==
Date: Fri, 1 Mar 2024 11:30:56 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v7 21/36] drm/connector: hdmi: Add Broadcast RGB property
Message-ID: <20240301-light-impressive-grasshopper-adabeb@houat>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-21-8f4af575fce2@kernel.org>
 <20240229194726.GB166694@toolbox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229194726.GB166694@toolbox>

On Thu, Feb 29, 2024 at 08:47:26PM +0100, Sebastian Wick wrote:
> > @@ -1708,6 +1731,39 @@ EXPORT_SYMBOL(drm_connector_attach_dp_subconnect=
or_property);
> >  /**
> >   * DOC: HDMI connector properties
> >   *
> > + * Broadcast RGB (HDMI specific)
> > + *      Indicates the Quantization Range (Full vs Limited) used. The c=
olor
> > + *      processing pipeline will be adjusted to match the value of the
> > + *      property, and the Infoframes will be generated and sent accord=
ingly.
> > + *
> > + *      This property is only relevant if the HDMI output format is RG=
B. If
> > + *      it's one of the YCbCr variant, it will be ignored and the outp=
ut will
> > + *      use a limited quantization range.
>=20
> Uh, maybe just say that the quantization range is selected automatically
> in case a YCbCr output format is in use. I'm not sure every YCbCr
> variant requires limited and even if it does, new formats could change
> this.

I documented what i915 is doing:
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/i915/display=
/intel_hdmi.c#L2143

Maxime

