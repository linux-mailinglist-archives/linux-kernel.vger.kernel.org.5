Return-Path: <linux-kernel+bounces-53696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C8F84A63C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAB9290AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729017CE82;
	Mon,  5 Feb 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WYStd+iK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6E8174764;
	Mon,  5 Feb 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159849; cv=none; b=H3/dXtdc8o7Iqg6jgkm38ATIrvOYe9K7gLVmbXxft70enRDQFI3zqFsMCWlP1YbGI9Gsg+yZ+/0TGBxgGOAU0C4LUBLVbufeZoOEA2Hp36yr8T81DbUUjlrPjHW1v6niQVBzTo3MVyPNfulgzt9PONY2VnVKfov33bcDf5G/1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159849; c=relaxed/simple;
	bh=2X0beJ3dmfA+cwC1iXbunu8iUPuukUKOrL3cq5ZA8ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV3JHSbeH6oDeHg41h83l7A2+agLIvn4Kcg7FgxDN06KF0FyKJUkrVGnC9jOY1sdfCf3O65eFzff6Qbcepq8tPerEIFcv2YFrKCACTPu7fUvgq0kYUtVPr6aQQsy9GX23LUScVhU/uJ7Pb13Ny/0VXcCn9mypKGwHFFB5vJz5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WYStd+iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A186C32785;
	Mon,  5 Feb 2024 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159849;
	bh=2X0beJ3dmfA+cwC1iXbunu8iUPuukUKOrL3cq5ZA8ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYStd+iKd+2So2kDrSMMyTih3ROQAIUWkWpwxk17wXdTS6kx+hJSilmhUYJC3lCbe
	 chWZGGaRCrJC4ZY+msoO5eFEOhYRYRkKGqoC7FoNcMkxUtb7wW4tEYIEL5QItuJ7l1
	 wJ7NakcylCA9AdxLgYiPcIxBYlMhFSZ+DMShIWno=
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

