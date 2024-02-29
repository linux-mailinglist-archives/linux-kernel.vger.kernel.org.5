Return-Path: <linux-kernel+bounces-86924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBE786CCE3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82F5289312
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A1914A4D0;
	Thu, 29 Feb 2024 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GATfAOGH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C511474A9;
	Thu, 29 Feb 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220388; cv=none; b=sTRQSfeC0M1l2ebvHdBOUkSQ5pn56B/kk2TMoMVg7NMsaoA14SsQbaS8bRWqNkj5CMJWA0KOwKO3tVLrFxFP4gDw/vcBITEzzP9EDQ72/pKDFuoITlP/YQmBdi5WH5Qv6AVbMTN/KD9T9ZRVMogChkk85y5RVqboYC10EmIc2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220388; c=relaxed/simple;
	bh=AI8kOUhbOYdns3KMMDjVTMnWtl0XB8l9IYFlvRgSpkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLOgVfFvHxe/AmMilwGujzEYbTORNTJQJc35rjgNv0uPWLuLj5wCzQdV8BpOnBFXhgwE6IYCRui4G4eQ06ej49MUDjzMjaPmDn/HEYzgS0+QER+y9iZIwDZJ0aasz/WXdLN1GSsFIrxEeWK9q1JM7IxYB7ZZtoXWCptbZBU+H4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GATfAOGH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JDYqbpl/+BoYOgWj42ekyUhd06iuQi2g92l5iNt/wbI=; b=GATfAOGHCRpbgfl5msH8olx3yF
	suXKEsjN8NvDG2Zyhy6wlb34vDh3q1/V6oOLi+mKOQ+SfHbVgoRcoNBm08jsdje9Ex0KZVdvgkJ7Z
	PiV9HQy4cB6iyIwf8Kcj8Nwi99GLobDZk0Trr0rH1NlVWRbQZ00S1nnivboh9Oi0ls/E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfiJ3-0093Hj-GN; Thu, 29 Feb 2024 16:26:45 +0100
Date: Thu, 29 Feb 2024 16:26:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hariprasad Kelam <hkelam@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, sbhatta@marvell.com, gakula@marvell.com,
	sgoutham@marvell.com
Subject: Re: [net-next PatchV3] octeontx2-pf: Add support to read eeprom
 information
Message-ID: <5aabaac2-155f-4d0e-8ab2-b864df9636fd@lunn.ch>
References: <20240227084722.27110-1-hkelam@marvell.com>
 <28d5c5b8-bd8f-458a-a62e-bb233add4a2b@lunn.ch>
 <b1d6d86e0d31910abeb4c0d9c43b98947835d316.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1d6d86e0d31910abeb4c0d9c43b98947835d316.camel@redhat.com>

> @Andrew: it looks like the firmware interface is going to be limited
> for the time being, are ok with that?

Yes, i'm O.K. with it, just disappointed.

Maybe the next version of the firmware will allow more?

      Andrew

