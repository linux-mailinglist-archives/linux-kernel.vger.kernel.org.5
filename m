Return-Path: <linux-kernel+bounces-39245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9451B83CD67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDCA297446
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960DD137C3E;
	Thu, 25 Jan 2024 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bArLd719"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E5613540C;
	Thu, 25 Jan 2024 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214401; cv=none; b=ll1sDJ92fbZgRoIDziNp5UB56IIolAXqMF9asdLiEttjmAdcxOf4RiUpjZx4XStkve4EI4evY/DgPdM+gtDTApeivajcgO2+jjCAIAfGpqxNoucDC8Gi7Z5NQNJwgCIlulv8nAg3bb0GEEKNIyV8pcFlhdnT0lzY4PKF1A0P7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214401; c=relaxed/simple;
	bh=6Ci/ePnkDO+HzTkfbOrA1/SdnXyBeEgeJWRwOv8Bw0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLar/OhQIdi11f+GFD4p1ewq2PLU2MgByxyRHRvUd9zczYFmLVL9HOlpN3GWQ9vowM5P0H0LirvkbtmLV69ADe1vReapZ09/ASJkjXHbL35N+ebU/35U3zKawQuXJK/jH9Zf3V8FVQikWuoq6kt1/9vUxsZ0RB4vH1tYSz811aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bArLd719; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cLj43Nh+nvdCTCdSIUxmh1BP+fwMrqS2+QveJHTLMOo=; b=bArLd719RSnaG1cB0oo1Ht8CZS
	f5xPT15CoitJrMDQUkeSnjUxRsTsJ9b9LpBceS1o8WVbHKFbSCYhCkLeIEMkA6vpZTsTA34ECbIhD
	sg1c58SoqHxHAgUxC6j7IShsBjuBSV1Ix88jZl9pOL2+dPHSPRkuA5lRmigDIgI0/Prs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT6Ii-0067TW-La; Thu, 25 Jan 2024 21:26:16 +0100
Date: Thu, 25 Jan 2024 21:26:16 +0100
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
Message-ID: <9eecccb0-a875-4dbc-b88c-5b2aad838305@lunn.ch>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-2-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122084530.32451-2-danieller@nvidia.com>

On Mon, Jan 22, 2024 at 10:45:22AM +0200, Danielle Ratson wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Ethtool can already retrieve information from a transceiver module
> EEPROM by invoking the ethtool_ops::get_module_eeprom_by_page operation.
> Add a corresponding operation that allows ethtool to write to a
> transceiver module EEPROM.
> 
> The purpose of this operation is not to enable arbitrary read / write
> access, but to allow the kernel to write to specific addresses as part
> of transceiver module firmware flashing. In the future, more
> functionality can be implemented on top of these read / write
> operations.

My memory is dim, but i thought we decided that since the algorithm to
program these modules is defined in the standard, all we need to do is
pass the firmware blob, and have an in kernel implementation of the
algorithm. There is no need to have an arbitrary write blob to module,
which might, or might not be abused in the future.

Also, is the module functional while its firmware is being upgraded?
Do we need to enforce the link is down?

   Andrew

