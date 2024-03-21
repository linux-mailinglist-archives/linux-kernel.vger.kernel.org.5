Return-Path: <linux-kernel+bounces-109508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A0881A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4D8282DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756E010E6;
	Thu, 21 Mar 2024 00:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1M21YGue"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001063C;
	Thu, 21 Mar 2024 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979838; cv=none; b=OpKWK1cgqhN38iWQJeqbKylp1aRRPm74EQwLeizPJ46lxIsCFIUKKS/hmgObIijsT071dOMLgKU5R/dM5iF1bv+O2k75+s6Fx0ryyPpLAqfbSkrbADar9DWbDPNQETVf8Qd3tWljBjrHziGni10y6srsSL36RPMpVrDA+g4me/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979838; c=relaxed/simple;
	bh=XF+QbRwExUSVDbOeZC0JJnQAl1pkZTUOdsQR3pkmSpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7eHCiZ+siglkHINTQxYNr5r6+NMpk+nPI8PZKnH/s1VXKXzeF8QksIy90uTaCm4e4rHhtZF+rcUyGMOUKrpnUBNhxDdBCaDzLUdWfBdEhqotn552rLKzh1EhXX/5IftaEq7Koowd69EVwNI53MRRKUsyiwaAKUmpbVd08IqjNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1M21YGue; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qYTfryt6uzT4gEzIjPEXIhCxudEshHluSopJ4l+iWUY=; b=1M21YGueS2/3kQUt04LM3AquuH
	xFt8tOZY9vJd4QGqlsHqHTpZ4i0eeGvpb46l+8dzE/idVmoAFThGhkyoGyXyoG4pcRsFiFP9hCm0e
	7fm5nbXbnJfZZ1dSecPrO8t+G3HxDYMqNuEtkzBtfJ7YmWBSeslnCy4B/8IQ2vForgp8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rn60k-00ApEo-DT; Thu, 21 Mar 2024 01:10:22 +0100
Date: Thu, 21 Mar 2024 01:10:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: taras.chornyi@plvision.eu, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kory.maincent@bootlin.com,
	thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
	przemyslaw.kitszel@intel.com, dkirjanov@suse.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] net: marvell: prestera: enlarge fw restart time
Message-ID: <259379aa-e9b9-4524-a092-5338314791d4@lunn.ch>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <20240320172008.2989693-3-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320172008.2989693-3-enachman@marvell.com>

On Wed, Mar 20, 2024 at 07:20:05PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Increase firmware restart timeout, as current timeout value of 5 seconds
> was too small, in actual life it can take up to 30 seconds for firmware
> to shutdown and for the firmware loader to shift to the ready to receive
> firmware code state.

So this means the probe can be waiting 30 seconds?

This seems like a really good reason not to reset the hardware during
-EPROBE_DEFER.

	Andrew

