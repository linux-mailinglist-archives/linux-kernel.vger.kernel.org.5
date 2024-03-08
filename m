Return-Path: <linux-kernel+bounces-96978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B650F876408
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81031C2161E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52D57862;
	Fri,  8 Mar 2024 12:10:04 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66E5731B;
	Fri,  8 Mar 2024 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899803; cv=none; b=N6RA5OpYGOYQhKs9iYihG6vR7r09ZfIjQi3rxCAksVpkAenYxRuxUJKWxcEVyPzztbzOG5Y1MwdVLnxor+ODNfpmxgEdTVQDnSIniySfwORlKb8678s4X9tNM/ANod46QbqzvDr+4hKkM+RtryW45TzMZcjtv5y/bOzN0gL56zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899803; c=relaxed/simple;
	bh=9T09C1YQCN5oBbpYEijWlMzI0K+d0IQxA9WFgqToIXA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YYqI+pu7W5M10Vit5a4B6XTYTUj3ImjcYaZOVzoz2+55L1Dk4g279NqczDYWC6zLEzIGHlAiN6vwjyoWMyOR1iCSCSrSi50tTwQ/a94OBAo3ItA2R51cRpMVfc+hEXsdDSfwkBGvVRv+scPgDrCy7/riUzhlQg9fo0mn1DUjFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DC9D692009C; Fri,  8 Mar 2024 13:09:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D63B192009B;
	Fri,  8 Mar 2024 12:09:57 +0000 (GMT)
Date: Fri, 8 Mar 2024 12:09:57 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andreas Larsson <andreas@gaisler.com>
cc: sam@ravnborg.org, sparclinux@vger.kernel.org, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
    Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
    Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2 7/7] sparc32: Fix section mismatch in leon_pci_grpci
In-Reply-To: <8398f430-14be-4447-9c17-9f6ac0af024a@gaisler.com>
Message-ID: <alpine.DEB.2.21.2403081209100.45777@angie.orcam.me.uk>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org> <20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org> <b62d0ae6-c2cb-4f2c-b792-2dba52a44e35@gaisler.com> <c5654b69-209e-4406-ac70-9a4547adfc36@gaisler.com>
 <alpine.DEB.2.21.2403072015010.29359@angie.orcam.me.uk> <8398f430-14be-4447-9c17-9f6ac0af024a@gaisler.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 8 Mar 2024, Andreas Larsson wrote:

> Based on the outcome of the testing and discussions that followed I will
> not pick up the "sparc32: Do not select ZONE_DMA" patch from
> 
> https://lore.kernel.org/sparclinux/20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org/
> 
> which was the one that got your name misspelled, unless I missed some
> other occurrence.

 Ah, OK then, thank you for double-checking.

  Maciej

