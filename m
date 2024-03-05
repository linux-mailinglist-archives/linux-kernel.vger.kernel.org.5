Return-Path: <linux-kernel+bounces-92448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAE0872048
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6321C22982
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B50785C7D;
	Tue,  5 Mar 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OQDU6ggv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BDF8592E;
	Tue,  5 Mar 2024 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645666; cv=none; b=hCaOxwyuT2MqQQuOFp+l1baMskOr3cXS5nJSsWkvhyZuM80RiLB0Xv36zVW0dMJLckHI8r/BSjC+Y9fp5RH+qan69FlYD6s5RuKKFw/dh+Uh9UNLI3w0MC3RxNKWr1nDgIuNHk9h2EAqDjcPTYsdqGVVgQ+79xkcmldffkwY64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645666; c=relaxed/simple;
	bh=g4/QOF7J2Wwmq5RED3wJPXCTwXZH4+mZplLeZQexveM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5uW3XMlWQLH+agYkHyHvsIMwyZyRaGCG31LTOiu9SB0lkEGrnSBCsZsrBaYyS/nkGUlx1mlEuK99A51szZyDVatmJeC1hzXDmuaTSDT/LLxyLt034goy/qOGLfMCD1p4YAzrSNzgkKWhK5MiO5PP22a/QAkPzMSDiEv8nizbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OQDU6ggv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED44C433C7;
	Tue,  5 Mar 2024 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709645666;
	bh=g4/QOF7J2Wwmq5RED3wJPXCTwXZH4+mZplLeZQexveM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQDU6ggv54aYtD+1IDFT3k/iv4TejmdReAkqFsd71PddBRutvzVhsCX2zY6h6LWzy
	 bn0crC1yL+7OcLzk3aopjSjrkAZ46owcDTJgOJVpF1d2jCXNsQ1m/XS4t2m6nhL9td
	 L8mD7q2UXsAf02KQLlN5ebDD0p0btdc5WgKFlPVY=
Date: Tue, 5 Mar 2024 13:34:21 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Helen Koike <helen.koike@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/9] usb: misc: onboard_hub: use device supply names
Message-ID: <2024030557-mutable-subtype-f340@gregkh>
References: <20240305-onboard_xvf3500-v7-0-ad3fb50e593b@wolfvision.net>
 <20240305-onboard_xvf3500-v7-2-ad3fb50e593b@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-onboard_xvf3500-v7-2-ad3fb50e593b@wolfvision.net>

On Tue, Mar 05, 2024 at 06:55:02AM +0100, Javier Carrasco wrote:
> The current implementation uses generic names for the power supplies,
> which conflicts with proper name definitions in the device bindings.
> 
> Add a per-device property to include real supply names and keep generic
> names for existing devices to keep backward compatibility.
> 
> Acked-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/usb/misc/onboard_usb_hub.c | 49 ++++++++++++++++++++------------------
>  drivers/usb/misc/onboard_usb_hub.h | 12 ++++++++++
>  2 files changed, 38 insertions(+), 23 deletions(-)

Due to other patches to this file, this commit does not apply to my
tree.  Can you rebase and resend after -rc1 is out?

thanks,

greg k-h

