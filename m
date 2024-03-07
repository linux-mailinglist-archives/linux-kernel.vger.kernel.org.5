Return-Path: <linux-kernel+bounces-95977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C13875590
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0281C23690
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9993413172E;
	Thu,  7 Mar 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhIj2XV0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5E5130AE3;
	Thu,  7 Mar 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833921; cv=none; b=r01DkB5r5W7NrWLP2Y7rIz3/Up35XUn7dzGWaErkvcQ0+lncrZJ5/8J4EQ0RRtMeU10iTeAJb+4a7kbvo/jFsHNW6+WcVdsNWreg9A3U0TbaPqyB0iysDemoM8hpWmMwxLSahQlFQCbboz5QPSZvLkTYl6XKoqdjGCqq/ouvuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833921; c=relaxed/simple;
	bh=wqt+7zpY7T9qhz7k/3D0BX/QAFNFEUsMdIfj4F+JpbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quL4VTiNPFR9fnSHzTzIdd4Wgt6eqRE51xzWx8TeigbNQy15NE//Zyd2RrX1+zJOBi/eQnaQ0BRPAW25pKyrUvh0coMpI1QqWjLbAoBNSz25ZeROd7Ds1aF/vr2YjlK9ZFMQeEcTFw6b5+Boby0kZS7k57XmdFLBvn8tTInle08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhIj2XV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D78C433C7;
	Thu,  7 Mar 2024 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709833920;
	bh=wqt+7zpY7T9qhz7k/3D0BX/QAFNFEUsMdIfj4F+JpbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MhIj2XV0DtBlgP4b0Z4BsGgjGt+5IYCF6CQujrtejn3i8VAini9fm6mm4gg25rclo
	 jkZWlcpzLWubk5DnqjEDKDg/GfLoN0JHC7d9//N+13W+/mk80BjMfJDaO3l29pon5r
	 zT1PkEIJhiBI21DzBwY3yIdy+wMdSnc+mKPuz1dtnnnTWm12H6iUYvDqjmZkQ2h9H/
	 UX6R/3Myh6RmnpTuXBXRyvEuSFI55z3DPh4JS1LP+D/mv6U+Hc6+GQHMI7nMko0S8Q
	 n2azgp6YoZgDm14QS34OVPeXFpqFhSYIgXwVNCT6SnOVpjfu+X/f4O4up+fDELa/qm
	 I20seVADRiRoQ==
Date: Thu, 7 Mar 2024 09:51:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: <almasrymina@google.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <leonro@nvidia.com>, <gal@nvidia.com>, "Anatoli N . Chechelnickiy"
 <Anatoli.Chechelnickiy@m.interpipe.biz>, Ian Kumlien
 <ian.kumlien@gmail.com>, <stable@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: esp: fix bad handling of pages from page_pool
Message-ID: <20240307095158.099d25ed@kernel.org>
In-Reply-To: <20240307101548.815189-1-dtatulea@nvidia.com>
References: <20240307101548.815189-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

LGTM, thanks! Minor nit picks for the tags, otherise:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

On Thu, 7 Mar 2024 12:15:47 +0200 Dragos Tatulea wrote:
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

General guidance is to order tag chronologically, so:

Cc: stable@vger.kernel.org
Fixes: (speaking of which, you need to add it, presumably point it at
        the commit where skb->pp_recycle was added)
Reported-by:
Link / Closes:
your sign-off
Review tags

> Reported-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.interpipe.biz>
> Tested-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnickiy@m.interpipe.biz>

You can combine it as Reported-and-tested-by:
up to you

> Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
> Closes: https: //lore.kernel.org/netdev/CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com

A space sneaked into the link.

> Cc: stable@vger.kernel.org
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Change-Id: I3d2744e1abb33a694a8f49e07f913724a0f8871a

Change-Id's gotta go.
-- 
pw-bot: cr

