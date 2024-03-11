Return-Path: <linux-kernel+bounces-98958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896EF87819A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9161C2157F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A3B3FE52;
	Mon, 11 Mar 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WjVhg7Rx"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E6C3FE20;
	Mon, 11 Mar 2024 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167231; cv=none; b=lqS6uSD5CAzB0p6HREwJJPpmDVxXmIyyvmnzY5ZJBArXpUXNFSYNlTHidp0nXkBp4+iSqCE4oKBRDZY8grzXNlKb9r5gRNiyVTU/VCzOMKRAnLu1WcejHCjPcp3590NLpCX1nnaLuKT1ssAZdbzNfNVyIJVguGRWxnMBF3zdBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167231; c=relaxed/simple;
	bh=1aJ4w3r/zuASTGzt0lTlVBVdTLgTFG77gu8clfftNhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmVXmC1GizcPSEjBfnhY/NnYuDSWZpsZLwm5bEy6xjWhn86+k8mTLq3fKVCe3XXCYB8QfXddTYLnw7Nm6x1PCEAn08fR8U4lutcC6GiofN+xdrkeTuPoKO/oBthCHM+HwykX9D4o/BJBQrTZTbe9nox3HR6dxpPNEErA+rZPTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WjVhg7Rx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oZTbxkjQedlArZ4e1pEnB9bCeXJ2IXvLPwUoSVRKmrU=; b=WjVhg7RxE78mYJA9EoCPJHHhGK
	VMninMbKOuUUU0FUXCz9/F97u7+gipe1cZOlnhQLoslr7Qt6Ao8esrO9PVyGv6QQ+Nh0KUMCsKbsq
	BrrNFHexTPpbmu/OTEE2KqJvS1lfONbB7ryS47D0OfHU6Ju+6LaU5LgYKdE3kfPdeUrA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rjgck-009yQL-RJ; Mon, 11 Mar 2024 15:27:30 +0100
Date: Mon, 11 Mar 2024 15:27:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: taras.chornyi@plvision.eu, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kory.maincent@bootlin.com,
	thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: marvell: prestera: fix driver reload
Message-ID: <4bd45f5f-d341-471e-8ceb-4fbc98d3ac33@lunn.ch>
References: <20240311135112.2642491-1-enachman@marvell.com>
 <20240311135112.2642491-2-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311135112.2642491-2-enachman@marvell.com>

On Mon, Mar 11, 2024 at 03:51:10PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Driver rmmod after insmod would fail because of
> the following issues:
> 
> 1. API call to reset the switch HW and restart the
>    firmware CPU firmware code loading was missing in
>    driver removal code handler.
> 2. Timeout waiting for the firmware CPU firmware
>    loader code to start was too small.
> 
> Fix by adding API call to reset the switch HW and
> restart the firmware CPU firmware code loading when
> handling the driver removal procedure,
> increase the timeout waiting for this restart operation
> from 5 to 30 seconds.

The commit messages suggests this does two things. So it should be two
patches.

Please could you explain why the firmware needs resetting during
shutdown. That is odd, so should be explained. The commit message is
about Why?, not What?

      Andrew

