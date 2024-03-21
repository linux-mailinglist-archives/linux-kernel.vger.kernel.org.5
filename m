Return-Path: <linux-kernel+bounces-109515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C0881A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A093928330C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95617CD;
	Thu, 21 Mar 2024 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ORuUhkI7"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C8370;
	Thu, 21 Mar 2024 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710980308; cv=none; b=EWOyLTMjIQe8wiqDqGzz+UmXJ32/cr2syYJt/QYoxcOgS2TPtrPw9ndABGYW3NRIYjC70VktAdYQoiJVuS+ULQMlXdDXA6kxh1/pxllxhGRSz6Wta+S/c3Jxt6S1pmgrYzXaC5hFwHP9sDAijqY7NXs3lqqelDeATNQqLeRRa14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710980308; c=relaxed/simple;
	bh=588rIHi/4MMrQySk9slMJxannA2P6Q0kkf1zN1E0sHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaVtg19DvRI2Pnq9zlZgHS00kGwehP4Enr46cJdyshRgSY3LLyLSIsbb4CX2SGhe5MBNzKgejedZaHhNVjrcLq0k/PSn18quWLV4KYbfzTSROJSzD+kS2xswRG+pfsF2a4NvLsGIF/eVK1hzOQxw2UgB41e4PGVvL0G6BIm3SY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ORuUhkI7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ns8szlSlhabcBnuGpfChkLK2b2WxxeaoC7Rx3R82ZsA=; b=ORuUhkI7UAcvQNGHRuSKD8Wt4c
	ySLO3I05B/5tFN7DXGb254Y2/bDlAxHzx/Gvdn1wJzqD8rj/Bcb8/c5mq/eURHe4wX3obsD1ejU6x
	P8YIsqm7M4A4xiURBODh2PxCKoHLTodDw7TH0lp1ENQbQjE9g92E71yguoVgaQYkyryg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rn68O-00ApK2-1W; Thu, 21 Mar 2024 01:18:16 +0100
Date: Thu, 21 Mar 2024 01:18:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: taras.chornyi@plvision.eu, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kory.maincent@bootlin.com,
	thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
	przemyslaw.kitszel@intel.com, dkirjanov@suse.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Fix prestera driver fail to probe twice
Message-ID: <4104387a-d7b5-4029-b822-060ef478c6e3@lunn.ch>
References: <20240320172008.2989693-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320172008.2989693-1-enachman@marvell.com>

On Wed, Mar 20, 2024 at 07:20:03PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Fix issues resulting from insmod, rmmod and insmod of the
> prestera driver:
> 
> 1. Call of firmware switch HW reset was missing, and is required
>    in order to make the firmware loader shift to the correct state
>    needed for loading the next firmware.
> 2. Time-out for waiting for firmware loader to be ready was too small.
> 3. memory referencing after freeing
> 4. MAC addresses wrapping
> 5. Missing SFP unbind (phylink release) of a port during the port release.

I don't see any problems with 3-5. Maybe post them independent of the
first 2 and they can be merged.

Are you really saying it is impossible to determine if the hardware is
in the boot loader waiting for firmware, or is running the firmware?

   Andrew

