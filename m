Return-Path: <linux-kernel+bounces-60061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A0284FF5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794D228442D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC3E219E4;
	Fri,  9 Feb 2024 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHY/ue5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B391A70A;
	Fri,  9 Feb 2024 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516156; cv=none; b=lwDwCkywNU1K84SjzsXqfChdCTjOnAx741jVaa0QYQgp89zzGvyEFU/ymxugj/Huy67eLt5psWW8wVEJhumBmTpM2RfPFxe2gVv75yBt9nLNFdb8Y+Csfq5Psu++4hDg+6ktJNP4Kfu76fghB7Z7ZiBDwWgBzOX/EZ49r+0e1qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516156; c=relaxed/simple;
	bh=vtEET3uyoCJTR2xzZC0XhdsJ1n+MqemqXmujTlSCaoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMmYznvUNBUEeVl1tiEWKEO4oyPADmnAvH86QA5PTQokEWSXaeDvzLMKaJfTbUPToIjLjlAqxsKRAdYMW+rq6qUjOfeabreQG+1JU4d7QR7rDJi1JJAk/M9O1D7LIvo/8oh677np9F7ktGG/Ii6qFuFmdpzcMlAZMmnMNTUyhuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHY/ue5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D8EC433C7;
	Fri,  9 Feb 2024 22:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707516155;
	bh=vtEET3uyoCJTR2xzZC0XhdsJ1n+MqemqXmujTlSCaoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jHY/ue5IKYv+3rg7wvYqE1vBLPgfeLKvHvEmchnLNSXJP1N/JfnztQWQ9RiUN1ywT
	 AIbagXHUZefIGsy4+d5tBpCG4dXz0FfdijjFIt5nh0y8UC+jLAkwx7JJld9tii5KDn
	 /jqmr+yV/lOUvD9qEy3I52mjzrALKfT2kkYjc/4MjgUJE6i68LK0nSVG4YjDmwSpYC
	 5TnPblCYvgZfpGSp4RhwhmF/rC6QD9JAdc/ZiegjYDQ6Nq9S3yIynRrAq2dTn56hZC
	 opBxpvvDarDpyXVtDe9UfEIZTLXgiwCnO6e9GfOWuwTED4X0UZeQfXdFwOp+azJ6JC
	 sBeg0CPjOWoPw==
Date: Fri, 9 Feb 2024 14:02:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 4/6] bitmap: Introduce bitmap_off()
Message-ID: <20240209140234.10e150b1@kernel.org>
In-Reply-To: <20240206140717.107930-5-herve.codina@bootlin.com>
References: <20240206140717.107930-1-herve.codina@bootlin.com>
	<20240206140717.107930-5-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Feb 2024 15:07:14 +0100 Herve Codina wrote:
> The bitmap_onto() function translates one bitmap relative to another but
> no function are present to perform the reverse translation.
> 
> Introduce bitmap_off() to fill this hole.

Argh, Yury is not even CCed on this? I was about to ping him but then 
I realized his email is completely missing :o

Please repost this and CC the appropriate maintainers...
-- 
pw-bot: cr

