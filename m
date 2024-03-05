Return-Path: <linux-kernel+bounces-92235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA8F871D31
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41F21F22285
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08B554903;
	Tue,  5 Mar 2024 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHz02/Vl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DD10A1B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637398; cv=none; b=Lt5ITCST05jeSVlvkocgneXZyE5tdiy1pvhz6PXGpS26RFMaVBL/VoWksfermr8lFk6/hhQDvDLGrm1wu/KWOWeIdj1Fl+8O+ztdEZDmtXZsXmbtLIBHLnLfp3aSARkpi5WIwY/A3ZuQcniuCocmAubIDbw7I/nmqhu8JoZDFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637398; c=relaxed/simple;
	bh=82TnKfQxhHPjvfZNCare+xueMxM6O7riM34Cl4yT29A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cMnmQ8X1FjUfBA1/2CrUriEhUUWIO4fiCVuyvC2kYWbYyxOj69gTGk6HHOpAIALyycz8H8TXF/85T2O6YFIUTR9F2tdOUti9xTwN3ezW4kvmWbWJdBxyOBjrFgLcV8qF2H6rEbbakMhza9yWwfmxqeI0N0m0NJFwlym8Nws6Q8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHz02/Vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC864C433C7;
	Tue,  5 Mar 2024 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709637398;
	bh=82TnKfQxhHPjvfZNCare+xueMxM6O7riM34Cl4yT29A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VHz02/Vlmmgs+VZkkiPHpYARitSl3d8bv0NqhnAP4k3UbVa0k/waPiQuyS1dZd2ng
	 hpv1GPyNlmmHgdrzdmOxwd2fk9ZXbFqJouaDVbIWSs94VT/F4T5B86dti3BA8YplSL
	 rkVxi+8AkN3+xz4Yas5aPdAPxFy63OHOOmfPNeTCBnFTAAyWlsBwTaBHZZnCR7Gajo
	 kEjVzskUdO7xG6YJ7/ZW+WPTfVNhbcXpbG7Ovelb0F0supgt8uBzIdYG6ni9qskoBS
	 J54JUiVrt0u8vIAlXaceVT6sJa4udfa1g98dZ0/xhzlACv+C+qqAJ4D5U1NhZN4uHZ
	 c0Vu4yZtwBvHw==
From: Maxime Ripard <mripard@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Enric Balletbo <eballetb@redhat.com>, 
 Andrew Halaney <ahalaney@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240228-tidss-dev-err-probe-v1-1-5482252326d3@redhat.com>
References: <20240228-tidss-dev-err-probe-v1-1-5482252326d3@redhat.com>
Subject: Re: [PATCH] drm/tidss: Use dev_err_probe() over dev_dbg() when
 failing to probe the port
Message-Id: <170963739518.522738.2603963239528747970.b4-ty@kernel.org>
Date: Tue, 05 Mar 2024 12:16:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Wed, 28 Feb 2024 14:12:06 -0600, Andrew Halaney wrote:
> This gets logged out to /sys/kernel/debug/devices_deferred in the
> -EPROBE_DEFER case and as an error otherwise. The message here provides
> useful information to the user when troubleshooting why their display is
> not working in either case, so let's make it output appropriately.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime


