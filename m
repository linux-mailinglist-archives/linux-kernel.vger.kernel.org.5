Return-Path: <linux-kernel+bounces-76750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D91B85FBEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8171C22C06
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DD0149013;
	Thu, 22 Feb 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PlwPp4qs"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDB149005;
	Thu, 22 Feb 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614668; cv=none; b=mkupuWPuek6P2Avw7SO5R6kSthRd0gtMTqOmIKEHWp2Fy10vX+sza+3vDeu2V4d9jwP8MRQByGDRMGLWPuAYTcGD300tkb733qPgojRDoeEm/8c+953Mw7tv/6Jz0/6ygT2eWsM37acToJLhSfvaCCOwQVzOFG6eW/B2INAy0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614668; c=relaxed/simple;
	bh=N4DqxkrUO+39GL6l6n4cDeOPvtBE1QaBpCHDr4rRhKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWpXAAibRz2krhzyaE6XDhr1/lerxY8LGmAe7QoyuK9q2BSy2yrluh8JSkLBG3tSR26Wm3vLywu1NHyua3DkcrlFwQWG3tpHfHeI43lmLUX6x88rKyguu96D85RYA0jes5Hlv7bmgndueGe/el3Xe5Cntz3jLTI3UZTpPGWPcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PlwPp4qs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wMH/YxCjPZ+y9HsN5oGyh1S5l+4RS/ggKj3jV/RYk0o=; b=PlwPp4qsKfFwbW6SZDrR5NPnMQ
	bR7XdWqPB+3yentT0+DlCP3iWQUbcAbX468on34w/o/3vMxOcbjXYYQWet4npgIE2qKzq8kE44oHM
	JT5IhGFCO0YIF5P7A3+uL6bdTE3C3jSwdtnPLreSxTDspO8QL54S9WVu7na1/VEbCscc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rdAj7-008S6N-L3; Thu, 22 Feb 2024 16:11:09 +0100
Date: Thu, 22 Feb 2024 16:11:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 3/9] net: qlogic: qede: Use linkmode helpers
 for EEE
Message-ID: <68088998-4486-4930-90a4-96a32f08c490@lunn.ch>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-3-71f13b7c3e60@lunn.ch>
 <20240220124405.GB40273@kernel.org>
 <a52361ef-66ab-41bd-b245-ccd26fcbd957@lunn.ch>
 <20240221102851.GA352018@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221102851.GA352018@kernel.org>

On Wed, Feb 21, 2024 at 10:28:51AM +0000, Simon Horman wrote:
> On Tue, Feb 20, 2024 at 03:45:28PM +0100, Andrew Lunn wrote:
> > > > +	unsupp = linkmode_andnot(tmp, edata->advertised, supported);
> > > 
> > > nit: Given the types involved, I might have written this as:
> > > 
> > > 	unsupp = !!linkmode_andnot(tmp, edata->advertised, supported);
> > 
> > linkmode_andnot() calls bitmap_andnot():
> > 
> > static inline bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
> > 			const unsigned long *src2, unsigned int nbits)
> > 
> > It already returns a bool, so there is no need to force an int to bool
> > conversion using !!.
> 
> Good point, sorry for missing that.

> I assume there is a reason that the return type of
> linkmode_andnot is not bool.

Either i got it wrong when i added the wrapper, or bitmap_andnot() has
changed since then?

It probably can be changed to a bool.

	Andrew

