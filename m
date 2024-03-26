Return-Path: <linux-kernel+bounces-118998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB18B88C26D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0161C396A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7696BFCC;
	Tue, 26 Mar 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mUn7qT1B"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470D514A8E;
	Tue, 26 Mar 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456930; cv=none; b=gr2TO8onbTUB+bZznV3z1jqxtOKCzPjh5VRyXf6RVOmyUrNEVqomVUyOFWu9PzNhykw6Z8zNEiEbZ2hKJb5gwtE6XDH4I4kqB5CTZHAlbshYVwVr3jROXUW+8vr8P/iVvH3EE392VUf92cgwM4BM4kH7Jwta7zaA2N88D3c2rhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456930; c=relaxed/simple;
	bh=og88FDM4ZTpK5DW4E3vnOVZd7Iyo7jDawmiEgO5c8yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4E29Abw4EH25OU630UuCUcUtDofMM/o0FPYImk5I7b0mVHBNeDBBVBgiLPzpRZeArc180YB26KTicsly7sThfKVxMWbjszPcTZ5ltm9haqc4R9zrOjAYIJNIvcVA4pSaADYEnuPW/JkvTQRQIdPSudRAbL+BTfI3a4pnxns9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mUn7qT1B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4cVPvciGVgrafa0cVb07sczYDu529Sl1ym9/IQMvG1s=; b=mUn7qT1Be/OtUQ9CGlX+ec5vSd
	GKgWsRKfjVYNCVyOEFR9SD4oSptMtJCZKthCggSHAkdgIIsOPrebFZZ5gL077JepNiG18n+GsjYZf
	G1ZdyyeTjGPINMeJG2cshxG32iIeyeJ4F28Q6Nk0BBqHxN2VcNvTUc32PKf3U8RHNNb4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rp67R-00BHAM-Bx; Tue, 26 Mar 2024 13:41:33 +0100
Date: Tue, 26 Mar 2024 13:41:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] net: hsr: Use full string description when
 opening HSR network device
Message-ID: <4a35a186-3c81-42df-847e-a80403cff1f7@lunn.ch>
References: <20240326085649.3259424-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326085649.3259424-1-lukma@denx.de>

On Tue, Mar 26, 2024 at 09:56:49AM +0100, Lukasz Majewski wrote:
> Up till now only single character ('A' or 'B') was used to provide
> information of HSR slave network device status.
> 
> As it is also possible and valid, that Interlink network device may
> be supported as well, the description must be more verbose. As a result
> the full string description is now used.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

