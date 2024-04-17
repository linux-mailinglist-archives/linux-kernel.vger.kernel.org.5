Return-Path: <linux-kernel+bounces-148777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB418A8742
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031E41C21363
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA1146D60;
	Wed, 17 Apr 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue5F6FPH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8233E493;
	Wed, 17 Apr 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367072; cv=none; b=WKsbZ2SmNf+aDCEEyQc1Bcwk3pm0cy2D+xdQU79bvUiCgsy1mqWk3fDyEZiecGAX/vPuGpJ8AJ9rCOx2yQVV+EJvFcF+gBYDkM8WkzwWH0TNYUZD3erUDFX6mRH7GIHUGvrjKB1ySUcw4ub799dXHs7OGtZvnhzXtpeOWQ6Mpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367072; c=relaxed/simple;
	bh=7yUA2jvJOr59LgOV0dNeP1KEF/46tQCssXhwNevw0jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSU1FutspLaPqKBDMYhlbqtKiCh0Sd28RuGNm06azjXDfFZ58VoqatvHVitUBZcfjON2Yt5EEkgWoAXkLjkgKKFnhic+8xBQ3uMeAiBXu24a6slgfxzI+GisK/hD61y9F6kZ7ifbVWVnvsXaILEEk4Jo45Ylq91poLB1twKhQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue5F6FPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8725CC072AA;
	Wed, 17 Apr 2024 15:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713367072;
	bh=7yUA2jvJOr59LgOV0dNeP1KEF/46tQCssXhwNevw0jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ue5F6FPHnOL678DL2/9QaVKJxkFHLib2iST9fdO1L1DqVuQLwpSnn0egwI8VXOzhh
	 LFsGHcMiju8mmTJOYIS8Y9+CCV6vK7CMDOAFASU9B3+nci/5W1LyK+X7yPLqzm3pJ/
	 eDDGZfj2e4s8xLceRvdIcC91uGBPgSkNP8SuU9QmxwHKEV+e2YNjiQKQyytEesYgY7
	 RQVwnwqv7V4wVJlhGyLzi04W+9NRyccDMGiwcruWywBs2oXbXCWSFGjKjIRQuD9vCl
	 NfylHouYCztjVEuEI2Ie5JRFpluNauRX0op/bF8/b8bw/7enGM/Rm8OW7GO2U8kChS
	 gSwovAp1+cV5w==
Date: Wed, 17 Apr 2024 16:17:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	devicetree@vger.kernel.org, linux-media@vger.kernel.org,
	Tomi Valkeinen <tomi.valkainen@ideasonboard.com>
Subject: Re: [PATCH v4 0/7] Managing live video input format for ZynqMP DPSUB
Message-ID: <20240417-stifling-saline-c401b7ba73e2@spud>
References: <20240416-dp-live-fmt-v4-0-c7f379b7168e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qNv7Ubbsw1/3mR4p"
Content-Disposition: inline
In-Reply-To: <20240416-dp-live-fmt-v4-0-c7f379b7168e@amd.com>


--qNv7Ubbsw1/3mR4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2024 at 01:31:35PM -0700, Anatoliy Klymenko wrote:
> Implement live video input format setting for ZynqMP DPSUB.

> To: Conor Dooley <conor+dt@kernel.org>

If there's nothing dt related here anymore, you can drop me :)

--qNv7Ubbsw1/3mR4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/oGQAKCRB4tDGHoIJi
0schAP98nHZnfFSME0zR7T2jkF0LbZDaU+MuGab26eGkYG765AEAt9tVsTAZnaX6
UmEjaoo4QyCmxz3wnRuiLAPA1WaPbwo=
=ni7T
-----END PGP SIGNATURE-----

--qNv7Ubbsw1/3mR4p--

