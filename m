Return-Path: <linux-kernel+bounces-109514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426FE881A69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE99283637
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC65817CD;
	Thu, 21 Mar 2024 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oLml6oym"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462965F;
	Thu, 21 Mar 2024 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710980071; cv=none; b=jjH9WpQXpK5UiiIm6n3ZTR/FJwfBhFU5IqDHdfwsp3prLxJ7OyKFhJSHUSUpDK02l+BeTKu7p7RUw3q05zML8B52f+3YYaUnsDMT5OvXxaULhanGWYRke6KC+MinyaO4DjElWXbK2fV6W2ZPI2dcBGPaP39502aduRU8cy5ZMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710980071; c=relaxed/simple;
	bh=YGING0romE1l6bMQ4cDz8A1udigCDIqFS/DzUgtKzCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL0RYTI9C4vfHrehKrAqTJBAMISxAFx1lIfeNTWwcVXMhLMk6KneVO1eFKFFL28+cBlS2ruAM0KyF8FqxoO5oPLl4WTSXTA+O6TK6rWjePv9kd2f+4wic3WB7WEQ9OnS02YO55gE8IHmKcQIenPMuFcss+eZnfieEaR7nfqNylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oLml6oym; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pyBatt9aFx0RwpN/n9HRNzymBlaZ5SXZq7hL1v52m7g=; b=oLml6oymGR3RU+hxWYtEnwxxN5
	tVx/kjfJaaKlCDj2azhAFhnOyFmxtPTOH9RXlljg1nITmPao5FMBqvUDLuLGOpux08W+9VNxZmCNy
	AGiVMJy2/eU0Zo9P5kVPmhG3uNcWr73rxyOLDZTwauQ9MoX13+8yKiv9dHdsKirHg9sE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rn64Z-00ApI3-5z; Thu, 21 Mar 2024 01:14:19 +0100
Date: Thu, 21 Mar 2024 01:14:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: taras.chornyi@plvision.eu, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kory.maincent@bootlin.com,
	thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
	przemyslaw.kitszel@intel.com, dkirjanov@suse.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] net: marvell: prestera: fix memory use after free
Message-ID: <d0158f0e-62c5-4eb4-8944-0d1cb0492687@lunn.ch>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <20240320172008.2989693-4-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320172008.2989693-4-enachman@marvell.com>

On Wed, Mar 20, 2024 at 07:20:06PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Prestera driver routing module cleanup process would release memory,
> then reference it again and eventually free it again the second time.
> 
> Remove the redundant first memory free call.
> All such double free calls were detected using KASAN.
> 
> Fixes: 4394fbcb78cf ("net: marvell: prestera: handle fib notifications")
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

