Return-Path: <linux-kernel+bounces-53707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C116484A647
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D21028A825
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDB217ED42;
	Mon,  5 Feb 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KKiJoKcN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4FF17569D;
	Mon,  5 Feb 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159851; cv=none; b=MZrhOhOZyz23Tg60yyqIzYAPesOxf9uQ6dE91c6X0SBW/hvjzFdq335x2389vrjcZV/+lIsN0bVx/TQyMMl95QxxxaDLeMdELtFl5cMyzQ4w4AQXa8n6qmmdUxbSYOK88pUmELDVZ91WhqVjnPNX3yMBpg6y5X3L6BzGK9BVW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159851; c=relaxed/simple;
	bh=2X0beJ3dmfA+cwC1iXbunu8iUPuukUKOrL3cq5ZA8ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDHz+BPclkHcSyJpjsFy6G5RBm7FwImjkGRn1To0+UwSEjJHVY5f21O4LO6jNxSWQKVeBA54mEinpqLTnIflvStR+sMYFYLPCmoo5bIHVH0zh3sKsC/5lJ72mmC6Keqc2YcGIQw0ia+rFvSMIG65aTFi0NT4AQh5qUNXaqf7rtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KKiJoKcN reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7149EC43399;
	Mon,  5 Feb 2024 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159850;
	bh=2X0beJ3dmfA+cwC1iXbunu8iUPuukUKOrL3cq5ZA8ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKiJoKcNSZNzeFU8frS2NzdZ6dX9p2Jr1fVNFKDL0ClEXMa2Da3IMQgGFdChq8Dcq
	 rvvufbbCNYDt+EMGO3X6QHqXsL1eXQ2dAcNiB46GSqXrCEw1aLoRlgcXYupPVgSATl
	 o9DN1RUgsP5fFhaqOo/Gbx5S5oQ7Fos+tZO5O2YE=
Date: Mon, 5 Feb 2024 04:51:19 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_parport: make pata_parport_bus_type const
Message-ID: <2024020516-decipher-unvaried-202a@gregkh>
References: <20240204-bus_cleanup-ata-v1-1-2bdc1fadf356@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-ata-v1-1-2bdc1fadf356@marliere.net>

On Sun, Feb 04, 2024 at 12:23:29PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the pata_parport_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

