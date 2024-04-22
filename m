Return-Path: <linux-kernel+bounces-153394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D098ACD90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAD028581B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C661509A9;
	Mon, 22 Apr 2024 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1lbRl8C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1914EC7D;
	Mon, 22 Apr 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790320; cv=none; b=utzQyDhNSWDgY2x6cPVRq3Pf23Q6+YopuTOYUUKawmMDDXuachaeHInOW6fh0kenxf7xk2YiPwoIS6yh/p+TYvlI1Ejwu0p1hAfPwW7FALvXDn97um3dSElVPNMmO9xBMclwdESb2L318a0/MwBuu3nZMXAE4rAkN9sqJ4w+RbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790320; c=relaxed/simple;
	bh=+ZojygioNdxYcfykHxwc6qvTmYz1IYCwb3Dbi5nl09w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xbuq6uFHiyvliSNsFcBlxXppt8SSGUloAr+rEPChQIbN7PdQC7MWyTsAiFObZcIBw/2SjGU4QxU72pSHT30pEMvEsPZYDkI1mrCYUa6vachFFfoxLKfJBheVJFlsu3JeHA4nNEW2CsIgwMOsroeciyl9n/d2Jb/4uYXEvmlwHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1lbRl8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D69C113CC;
	Mon, 22 Apr 2024 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713790320;
	bh=+ZojygioNdxYcfykHxwc6qvTmYz1IYCwb3Dbi5nl09w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1lbRl8C6V3FYH7wjNOfEzIlHI2HjpdLdVNz++RD8+BMhEkzZuv6nApDxJ4oZho33
	 Ke9bYGBYAxT8EXozJWoV55NmcHYJZouzI7Y46CXThlcNnQv3eBwWfgsl3t8d61719X
	 5y4LFNk/D4EzsJ6zTRM0MJAwGSx1Mdic1T3Pspks0fPVn4aO84dhFyFwRWPyLxaWQ5
	 jG3LDLF2+CqvT+OZF2XUFF5CgDFZE76SS3wILnjjcHZe9o1E2zpK6R7CZzU56liCRm
	 zWZPfDNQPG4w3qNdXDiTurbgommQCGuMYQIZcar3st9QPsFWkXkPYAI0R2peaIu78z
	 KPKiTgrNWofNA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ryt9G-000000004vc-3K9E;
	Mon, 22 Apr 2024 14:51:55 +0200
Date: Mon, 22 Apr 2024 14:51:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Zhengping Jiang <jiangzp@google.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
Message-ID: <ZiZdag8fw8H1haCb@hovoldconsulting.com>
References: <20240319154611.2492-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319154611.2492-1-johan+linaro@kernel.org>

Hi Luiz,

On Tue, Mar 19, 2024 at 04:46:09PM +0100, Johan Hovold wrote:
> Qualcomm Bluetooth controllers can be registered either from a serdev
> driver or from the Bluetooth line discipline. In the latter case, the
> HCI UART serdev pointer is NULL, something which the driver needs to
> handle without crashing.
> 
> This series fixes one such issue at setup() time which incidentally
> masked a similar crash at suspend. Fix this in two separate patches so
> that the latter issue is address in pre-6.2 stable kernels.

> Johan Hovold (2):
>   Bluetooth: qca: fix NULL-deref on non-serdev suspend
>   Bluetooth: qca: fix NULL-deref on non-serdev setup

Could you pick these up for 6.9 or 6.10?

The patches are marked for stable backport and only privileged users can
set the N_HCI line discipline these days (even if I'm not sure about
pre-5.14 kernels...) so it may be fine to wait for 6.10 if you prefer.

Johan

