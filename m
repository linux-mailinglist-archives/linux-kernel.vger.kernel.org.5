Return-Path: <linux-kernel+bounces-56741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FF684CE6C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237921C20E18
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B28005A;
	Wed,  7 Feb 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmzJMu7c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E417FBD9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321148; cv=none; b=FMWrsjBgM2qVBdjg3fKCI5zkjRAqbggv8NMXtEJbB6uxKV0F5f2fNhDvVEIvTBDxXKKe4uBtzQEu76Hkj+jrhXTKAUjVFF+fuuZtnwDugrJqA73hyK3QmhLYBAfpb9SlZ1H9hT3fnejZHM9ftvVeH+mweuFUfECtqsGnSw3R/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321148; c=relaxed/simple;
	bh=cHYNDEi3WlHG4angWaXSJlNb7gbznKoIJltmiX4Cfa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iX+fqKPiNHre/P2HWQukkoTu8yHG5PTd2JgpbcHiZQTQD4wwdalfElTIRGjs1jmXaXKOpMYvLUjJlU/Feess9PzT/eahOf9b+3DyFbCOMogQ4kn7k3J7k3K1kIQEn/1b3F1g43zef42I0yeOnMFRAMcYyGTKVbLzTIqi7UMGfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmzJMu7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF34C433F1;
	Wed,  7 Feb 2024 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707321148;
	bh=cHYNDEi3WlHG4angWaXSJlNb7gbznKoIJltmiX4Cfa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmzJMu7cKmZvdytEdbGNsrv/J2EM5eMY7C8ep99MQMYPXPSfn5RXk6Pl+W5hxQjgj
	 5cLwXKOmxQ/tmKF1MbH05iRh3y/HS4iLUc5HifLrxW9uA3yXZNRc6eNEPyJgqVc0Gv
	 9yzu21BUaTqV+u7tAOPY/QHvCFi6V+H4WOkZl2Tk7KNGGAuokp6i37yNSprn5+qaR5
	 ZQ7BWDjoMTCfchTu6lEgIg+r7D5wm+Jw9AhbuJk1UszZ0E8mXr/LNG0YrnarhABAiH
	 kzb6YDDJUpErLBcGRtQRMLk4K/6nvS9ickaC2GYnuW/6jWuefkwskvwVmUoOOSkWcL
	 3WEGQiJt7qE0g==
Date: Wed, 7 Feb 2024 15:52:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	manikandan.m@microchip.com, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux@armlinux.org.uk,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, geert+renesas@glider.be, arnd@arndb.de,
	palmer@rivosinc.com, akpm@linux-foundation.org, gerg@linux-m68k.org,
	rdunlap@infradead.org, vbabka@suse.cz,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: display: bridge: add sam9x75-lvds
 compatible
Message-ID: <20240207-raving-chatty-7961fb5c5d43@spud>
References: <20240207102802.200220-1-dharma.b@microchip.com>
 <20240207102802.200220-2-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tvxf/pUyWbuFS5ma"
Content-Disposition: inline
In-Reply-To: <20240207102802.200220-2-dharma.b@microchip.com>


--tvxf/pUyWbuFS5ma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

$subject: dt-bindings: display: bridge: add sam9x75-lvds compatible

If there's a respin for some reason, please update the subject to match
what the commit is actually doing (adding a whole binding).

Cheers,
Conor.

--tvxf/pUyWbuFS5ma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcOnMwAKCRB4tDGHoIJi
0ue9AQC+O1AcM535fj1ORbNpOe2LbZVdJ/keOqbM5p7WIHcV8gD/aJgptEm38mUu
e4pTQU4ClUkiAFbmRHcNmXKC7rhfiww=
=057J
-----END PGP SIGNATURE-----

--tvxf/pUyWbuFS5ma--

