Return-Path: <linux-kernel+bounces-39262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8A483CDBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C65EB24F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01D1386C2;
	Thu, 25 Jan 2024 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Iu30FEXn"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA4C131E40;
	Thu, 25 Jan 2024 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215551; cv=none; b=JtWhgIkzla+Tji7tBawXM4hWMljOn460Lc3VZj4Pp7j1vP8WDKQfj8LWqCJ7qJARHDDBuOzTZY7v2HuCWA5Xo3Q0eZS8WCNVjuVoAgFhLfCb33k2XbrEoo+akeElm2E/CNZCZgpU0J4fKjZSgnf/Yc9FH0deYjAtLy8eTvL6wCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215551; c=relaxed/simple;
	bh=MEYtjeW29vfCnD9UeqkFj+lrriB0AqvztxsmzdZxKf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJdE1XIOWBEipotMBWzvhuiQ9m/Zlb2mQKETNBKeTGS855uOeMphe/TrrHch9xGi6UsJXZEFy/gPpr5u02GzlYhSJkV6OS2fKo12Yy4lkgKR1qtCkQFt8Amjt6GoEHSsDaUA3aWXDZyle/ueReHTiDSKiPKIrraZ4JHwjawzPxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Iu30FEXn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NjvNmpvcyNjsNydEo+Z2ltkIxVtWxwctxxsjrOVm3aI=; b=Iu30FEXnJMWAZuuxH3st9SEc0J
	05YCNF82thUjrVtBzvkzYVU1IuZKCChHWOB5Qeok3uOZCv7PQ5CQ/s/n5t5j0G74VYzQol8ZZKyGb
	RUnIMCWFbfjBYch9zGLzaiK+aMJ72YN8j4Z0rfFOr2zW7xcAA33YPLIxKSDMUFqmOWao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT6bQ-0067eB-86; Thu, 25 Jan 2024 21:45:36 +0100
Date: Thu, 25 Jan 2024 21:45:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, sdf@google.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
	richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [RFC PATCH net-next 1/9] ethtool: Add ethtool operation to write
 to a transceiver module EEPROM
Message-ID: <20ab7355-fc72-4dba-b3ea-db2244909bab@lunn.ch>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-2-danieller@nvidia.com>
 <9eecccb0-a875-4dbc-b88c-5b2aad838305@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eecccb0-a875-4dbc-b88c-5b2aad838305@lunn.ch>

On Thu, Jan 25, 2024 at 09:26:16PM +0100, Andrew Lunn wrote:
> On Mon, Jan 22, 2024 at 10:45:22AM +0200, Danielle Ratson wrote:
> > From: Ido Schimmel <idosch@nvidia.com>
> > 
> > Ethtool can already retrieve information from a transceiver module
> > EEPROM by invoking the ethtool_ops::get_module_eeprom_by_page operation.
> > Add a corresponding operation that allows ethtool to write to a
> > transceiver module EEPROM.
> > 
> > The purpose of this operation is not to enable arbitrary read / write
> > access, but to allow the kernel to write to specific addresses as part
> > of transceiver module firmware flashing. In the future, more
> > functionality can be implemented on top of these read / write
> > operations.
> 
> My memory is dim, but i thought we decided that since the algorithm to
> program these modules is defined in the standard, all we need to do is
> pass the firmware blob, and have an in kernel implementation of the
> algorithm. There is no need to have an arbitrary write blob to module,
> which might, or might not be abused in the future.

O.K, back after reading more of the patches.

If i'm understanding the code correctly, this is never exposed to
userspace? Its purely an in kernel API? It would be good to make that
clear in the commit message, and document that in the ethtool ops
structure.

Thanks
      Andrew

