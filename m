Return-Path: <linux-kernel+bounces-64204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB4D853BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8FC1C266A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F7960BB4;
	Tue, 13 Feb 2024 20:02:48 +0000 (UTC)
Received: from tux.runtux.com (tux.runtux.com [176.9.82.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203055FF00;
	Tue, 13 Feb 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.82.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854567; cv=none; b=OKHP1/X84qhimIermBhRIlT/YEXc7Mo//JIP994IRfutvmHdoIDA1fysghw69XmkulwuviAYC3pq7JV+IOMn9NmO3Y+wFUmvg8fU5yu30tAtL+94Zc9zw4Pyt/GLHGxEg2oMWQfM4GUuPwmoZqJwpC3v2VcDHiOiEO9QtEcCf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854567; c=relaxed/simple;
	bh=Qb1lpnp4lI0xqDhguc3q4Hz1/+0FvDlmffl/hZUBcdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INlkl/to1F4ygBsKpYkeHpZ61Csip7sI1fWI6awc0Bfq0rWAdIA7e5OEUd5FDR/sEmX7icRKv3mi5IC9uIjmaDXf4XUAIS6gdOvcR41hm30b9Qg2iiY/IgXu/Y2Y6/FXsBoUpey0z7MYUpL5Q0xDAKaygeXx5uyPZadbozDm9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com; spf=pass smtp.mailfrom=runtux.com; arc=none smtp.client-ip=176.9.82.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtux.com
Received: from localhost (localhost [127.0.0.1])
	by tux.runtux.com (Postfix) with ESMTP id 81DEF6EF5B;
	Tue, 13 Feb 2024 21:02:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
	by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id HyON-kXHh0LD; Tue, 13 Feb 2024 21:02:39 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
	(Authenticated sender: postmaster@runtux.com)
	by tux.runtux.com (Postfix) with ESMTPSA id 2CAD66EEF6;
	Tue, 13 Feb 2024 21:02:39 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
	id C6C64469; Tue, 13 Feb 2024 21:02:38 +0100 (CET)
Date: Tue, 13 Feb 2024 21:02:38 +0100
From: Ralf Schlatterbeck <rsc@runtux.com>
To: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] spi-mxs: Fix chipselect glitch
Message-ID: <20240213200238.v5q364fwvn62vseb@runtux.com>
References: <20240202115330.wxkbfmvd76sy3a6a@runtux.com>
 <170784989820.681459.6695714509639866106.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170784989820.681459.6695714509639866106.b4-ty@kernel.org>
X-ray: beware
User-Agent: NeoMutt/20180716

On Tue, Feb 13, 2024 at 06:44:58PM +0000, Mark Brown wrote:
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!

Thanks!
Sorry for my impatience.

Ralf
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com

