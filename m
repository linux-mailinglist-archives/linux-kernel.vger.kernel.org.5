Return-Path: <linux-kernel+bounces-46967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C0844717
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05C11F2580E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9F213399E;
	Wed, 31 Jan 2024 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zr0I78bw"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E4131750;
	Wed, 31 Jan 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725628; cv=none; b=UQb+xgSuWtx95kYcW58ag+3Hb/aSQnmPrfMKqweNQrwVQzXbxmhBNtXzJv9Uts862fDBJJrfbV9WMu2x2BI5qzs74t9ODt971Gd1u8v4JLsBAIS1Bso0QGC1bGOIRsms92AYUQEOo3cGWvVNm3y/b7TGmOykDotXbfILqgm81Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725628; c=relaxed/simple;
	bh=yG5pKXzI2U9TEh+X2crF1nYSTpS7SIx9dKJxseUsNn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7xviBmGCI3Vev/5JIXRJRdHNAS9iSz2/yCnqXbinbHrcFs64Z7hwvEZNZWp2QHjnDrEUNVRdM+iJDEXPlHs7tCuZ7DfPyQZZ4sQg6w/UlH+ng4pkyLFlqVc/AUpoJRA1tPPTSZbt0gBiKh0CU1Fo4zuukzaf+OzRPPqjqUew9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zr0I78bw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hg9/xopq1B8VMQX5winCbXo7MK2kcXX1CEYYe/IOgTw=; b=zr0I78bwzf/kHL9GgaOT8aPq0V
	AOfR+UzbbbpIqbLyGVcv+3rSQvj4d47+7QwE1iELR1HWRC3VaC13bQ9rg8cihasNKHAOry6OkWvWx
	2qyZLxoxrVtMEU+W85giReSnveU4jQ8EP6d0uOtdUmOFn5Q+jZeADlsriC+URF1kwUVA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVFIO-006bdb-Q5; Wed, 31 Jan 2024 19:26:48 +0100
Date: Wed, 31 Jan 2024 19:26:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/8] Improve GbEth performance on Renesas RZ/G2L
 and related SoCs
Message-ID: <953f6b82-c4b1-43f7-af68-e504d663f070@lunn.ch>
References: <20240131170523.30048-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131170523.30048-1-paul.barker.ct@bp.renesas.com>

> Changes are made specific to the GbEth IP, avoiding potential impact on
> the other Renesas R-Car based SoCs which also use the ravb driver. This
> follows the principle of only submitting patches that we can fully test.
 
Are you saying that Renesas does not have access to all Renesas RDKs?

I don't particularly like the way your first patch makes a copy of
shared functions. Is it not likely that R-Car would also benefit from
this?

	Andrew

