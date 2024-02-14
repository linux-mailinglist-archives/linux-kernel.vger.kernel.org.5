Return-Path: <linux-kernel+bounces-64695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F8854193
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FD51F2A4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7448C09;
	Wed, 14 Feb 2024 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JixVEReS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6420EB;
	Wed, 14 Feb 2024 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707878669; cv=none; b=U5A4hwtgw++AbxaVIQ4WspX1kwmip/HDnNGDotoj+gi4zlgWYvD0zijyKWi+o9rVApOS/W1VDNiamU16vkr0JHmZFgBEfs+uPNL6c0I0wp2p3WH3R5JgoHXNA/RpIP4au3rFJKRD0pZGHEoCJtYT0Ce0e/sbmb96TTPvyD9GD3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707878669; c=relaxed/simple;
	bh=F9SLSrJ9tazlMoBwo9qdHzu3gmcgsg3epPk8XMRqOfk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJy3P1IMXqetM9MNFumnGQQYRfSZZpR3JN3q2AQjQ3wKKR6pDw6v7vZ3viW4b36Ut1HuMlYQ6WxjDlRQJTs//4/amf7kc+x5+AC4RwCBF8u4Yb0R5bZPyTWH/prsBxE1oUEciOZmW+Ev/76NHjHscoC5U2Rh9KtE7z514siqypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JixVEReS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724CEC433F1;
	Wed, 14 Feb 2024 02:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707878668;
	bh=F9SLSrJ9tazlMoBwo9qdHzu3gmcgsg3epPk8XMRqOfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JixVEReSHI1W74Z4j/HBPFYhemampMieVUQhZMp+aFV5N2hbaL0bhkXMFxdmGNhEI
	 22uBV6A5N227sux9F8n5Qq5t9yLveOhM5M5HReKmnujOiUxRZOsz8jNnQL4VgTIbxZ
	 2d0qtfXfYvEBuKY3YreWySkIidJuUUqevCNAlAIJFWJqMNh2HQdWR1x2ypASVfnlMU
	 EEyNwPJp2xhG/GDaPl9WBTigYV0AXeMPC/mKvW+DlJQdCQd5dcWzxcb+j4SU/ypcWF
	 4QY9If8DlOWvZHV3fn/YwXdqYu3Gx+cpTN/FseEg5Rr6thW+OSUWybmycX35N1hJEZ
	 kltLXfp+wqzmA==
Date: Tue, 13 Feb 2024 18:44:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Ernberg <john.ernberg@actia.se>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: fec: Always call fec_restart() in resume
 path
Message-ID: <20240213184427.5af2d7eb@kernel.org>
In-Reply-To: <20240212105010.2258421-1-john.ernberg@actia.se>
References: <20240212105010.2258421-1-john.ernberg@actia.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 10:50:30 +0000 John Ernberg wrote:
> Tested on 6.1 kernel and forward ported. I discovered this when we
> upgraded from 5.10 to 6.1, but the resume path in the FEC driver has had
> this imbalance since at least 2009.
> 
> This is also why I target the -next tree, I can't identify a proper commit
> to blame with a Fixes. Let me know if this should be the net tree anyway.

I thought you bisected it to one or two specific changes?
I'd put those down as Fixes tags and target net.

