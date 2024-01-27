Return-Path: <linux-kernel+bounces-40959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C185783E8F5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C656286DFE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DB6947A;
	Sat, 27 Jan 2024 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuycoVZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2328F6D;
	Sat, 27 Jan 2024 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318841; cv=none; b=D8RxWZRGCMBVfGGS/yqe8loS7kNA9Nvi+rlektblWbGvmPBN7pFMmFjn2lsMydCZd+spQsokTUAFSnxgFCOmXu9nMOqpBy2jPk+JYSDmjDt1NxDwe4y7uy7L4nYFdk9eKTGR8fK5gPZ0d3GeP287yeOPa4lKbLh19pEoX5BWEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318841; c=relaxed/simple;
	bh=6j7ldOY0z2Dy6Mx0aFNXfvDzOKct/0FiBiEEaBDJVVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=et4Jx9wNYomxRsta0VMoFnI2wSFBsajwOsOHAEU9I7E3BFu9IRHj8RGL99gkYQ4jgFcOFuIxhyLbDyMnm5N++FDEDWHP9a8k9EkPzt/U+s2rnrHj2OViwUyvg1iBATD3idAaQ3DbRfDV+3gcFrkkcmghcLTfN2Qi0FITiNbHK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuycoVZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051B9C43394;
	Sat, 27 Jan 2024 01:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706318841;
	bh=6j7ldOY0z2Dy6Mx0aFNXfvDzOKct/0FiBiEEaBDJVVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XuycoVZQcAX+YMGCP8hH7xKBfZBFekMjy7Ay7QX+EsypdCq34cDtBPI3appGlPLlo
	 snCbRcoAMXU/LTNr9kDDVD5xHL85bTJCiT0MwH+AoaUSadmvdouJb70SsEEo2KZV1K
	 2lzcXPrA/y/5ff7fR0QfknF1+6LDbgdpXWT0nTkZkzvTuouSHT4zbFHk4ugg1FCXvP
	 oybobEhT8W1JRmGibeU98ywdmZSmKzzQIllM5sG9hoQGVRGI7vYiOGCtD2Cw4HbAw/
	 W/kLeGhw87bwSZrXxHABjw6D+Bc0jsgybkQupL0Q1fTOrO5L9J4UO7fuT1ZMwItWvn
	 S4+q3vmwwF7WQ==
Date: Fri, 26 Jan 2024 17:27:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Roopa Prabhu
 <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] bridge: mcast: fix disabled snooping after long
 uptime
Message-ID: <20240126172720.716689b6@kernel.org>
In-Reply-To: <20240126143607.5649-1-linus.luessing@c0d3.blue>
References: <20240126143607.5649-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jan 2024 15:36:07 +0100 Linus L=C3=BCssing wrote:
> +static inline void br_multicast_query_delay_expired(struct timer_list *t)
> +{
> +}

nit: let's drop the inline, if it's to suppress a compiler warning
under some configurations - it's better to put an explicit #ifdef
around it.
--=20
pw-bot: cr

