Return-Path: <linux-kernel+bounces-99515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B4087897A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424202821F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5948C54BFD;
	Mon, 11 Mar 2024 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="napyVu9g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AFC5675F;
	Mon, 11 Mar 2024 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189012; cv=none; b=SrgceWFa26ySqAQeU8yxVF1cR2FazdElYIav7qTN542qGb5EAH1WHjx22URC7GvzZ5ZXjobZF5BAbSLyqkBkDkmW6ugrulhuJGWbmBu70nWd7AnOy0X+0E8CTSv42fcj5XbhforNWFjaMz06PmevPQQ2ah66d2LHF6iO5tSmzqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189012; c=relaxed/simple;
	bh=0tS+vxfg8HDQU1ELwiYHWm6/ey7BA5p+nRLEIii4sbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udWTKXfpNnms+672ASMyjefexOVYH1fThVVcPluqwzUU6wNH8uPN57BNxpnklewmeUFk0Xo3t4ZNUlnp5jM7e1fRtFVSroEHHPfRTFTwn9fX7+naBQ7kbHwjIDRmVTznajGeGGAqXSBViuKn2EPKu10pBUdG5g0++Lc2P4PVdYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=napyVu9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339ACC433F1;
	Mon, 11 Mar 2024 20:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189012;
	bh=0tS+vxfg8HDQU1ELwiYHWm6/ey7BA5p+nRLEIii4sbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=napyVu9gbFaWdcdGETPbBSu48gI6089fqm14WR3nQWP8Jzk+3rSjWJebxJlN9MD+V
	 n97OpRePO3CRoPyBnfJyZngPwA3gC7GuVXlsOYgVWIGCfz9OBLhxlEXuuntWdVomlQ
	 8ocqNYCcJ9UrdO7Fn6eZfWm+AL+duqbl5OKwm1iu8gB9BU+BOFb9RHw2Z4p0UzYl2U
	 GK8dVAs7SNpoF5+E2IlDR+f068V+3MjDfOjcBreEXg5ro8SxwBaHfzHz2ucba/AQzy
	 SzYnw+rLl9GIJSx+efUX9GcY3BiPmO+dFatWhZ7Vnt+TSo8qdlBCA0H4vsbUUNCLz1
	 2RUjDosx9ggMA==
Date: Mon, 11 Mar 2024 13:30:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com
Subject: Re: [PATCH] net: veth: do not manipulate GRO when using XDP
Message-ID: <20240311133011.2f9236da@kernel.org>
In-Reply-To: <20240311124015.38106-1-ignat@cloudflare.com>
References: <20240311124015.38106-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 12:40:15 +0000 Ignat Korchagin wrote:
> Commit d3256efd8e8b ("veth: allow enabling NAPI even without XDP") tried to fix
> the fact that GRO was not possible without XDP, because veth did not use NAPI
> without XDP. However, it also introduced the behaviour that GRO is always
> enabled, when XDP is enabled.
> 
> While it might be desired for most cases, it is confusing for the user at best
> as the GRO flag sudddenly changes, when an XDP program is attached. It also

s/ddd/dd/ spellcheck the whole message, pls

> introduces some complexities in state management as was partially addressed in
> commit fe9f801355f0 ("net: veth: clear GRO when clearing XDP even when down").
> 
> But the biggest problem is that it is not possible to disable GRO at all, when
> an XDP program is attached, which might be needed for some use cases.
> 
> Fix this by not touching the GRO flag on XDP enable/disable as the code already
> supports switching to NAPI if either GRO or XDP is requested.

Sound legit, AFAIU. But please also adjust
tools/testing/selftests/net/veth.sh because it's failing now.

