Return-Path: <linux-kernel+bounces-93260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528A1872D37
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8601C25E38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A5E11198;
	Wed,  6 Mar 2024 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSvKHA3B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD53D52E;
	Wed,  6 Mar 2024 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694269; cv=none; b=Uhj76//huJoWmmSeR05909kuubpqJaguskJYrUP24hS4X4ovO3qmkzJ+shz1CUkjn98AFhSMSzKxRSZQJmUhd9B46Jev407BbAQ652qORDMDEEYaaOnWlKJKu4dNkh9fh+vmu9yJKV/9bWxpz9QhBuQTv85uXG0ElutD1g/Da/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694269; c=relaxed/simple;
	bh=M81xZ8Yygk+8jrRbZ8XTA0NRgMTVSAnbU7y/Y1YDlHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6d01fODoxGx3pvRazmswdlQyxUT4LFAru4HTxwsqyDixeXQwWuFJ5zC3yhtuHi/t7KkYMQ0rIGR9AZxrR34gLZjabHhZLjP2GRe8SabM4H6cir7shwYgtDYQEJKv/DyEup0j2bF/uQf3BVNqKrgGFc8AnsvrRUUNrmkSOQhxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSvKHA3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A584C433F1;
	Wed,  6 Mar 2024 03:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709694268;
	bh=M81xZ8Yygk+8jrRbZ8XTA0NRgMTVSAnbU7y/Y1YDlHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HSvKHA3BBqEbXscEbQhIYWKBGdhNdJVlA8+2oogswRqnFNtxqAUvCILMaD5ATtdH7
	 F1QPh6C8NZugdFE6NXMlq+8n8jjMGNGDIk6lyYHW3zloU0WNbOPydIGGPcxRxxU4vl
	 fdCOqKHlTPcv+4UCstI5M+CvLpzqrQmBXlVCEd2Pxf61/z/d7DQ4tii+TEBztevuHZ
	 Vuk0uTWhD7bqUgs8EjBp2UpJUs/N15dzfSYQ/O2VT+eamzx7ulBoQBv53QlFGz+1qu
	 dDTMTqljd8pJcgBLePm0WYP1c4IBES7f5g1rTIbMExzRQgjd+XMk77CJ899Fh52P+d
	 g9Me8IS9cLZzA==
Date: Tue, 5 Mar 2024 19:04:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "David Ahern" <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, <leonro@nvidia.com>, <gal@nvidia.com>,
 "Anatoli N . Chechelnickiy" <Anatoli.Chechelnickiy@m.interpipe.biz>, Ian
 Kumlien <ian.kumlien@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Mina Almasry <almasrymina@google.com>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
Message-ID: <20240305190427.757b92b8@kernel.org>
In-Reply-To: <20240304094950.761233-1-dtatulea@nvidia.com>
References: <20240304094950.761233-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 11:48:52 +0200 Dragos Tatulea wrote:
> When the skb is reorganized during esp_output (!esp->inline), the pages
> coming from the original skb fragments are supposed to be released back
> to the system through put_page. But if the skb fragment pages are
> originating from a page_pool, calling put_page on them will trigger a
> page_pool leak which will eventually result in a crash.

So it just does: skb_shinfo(skb)->nr_frags = 1;
and assumes that's equivalent to owning a page ref on all the frags?

Fix looks more or less good, we would need a new wrapper to avoid
build issues without PAGE_POOL, but I wonder if we wouldn't be better
off changing the other side. Instead of "cutting off" the frags -
walking them and dealing with various page types. Because Mina and co.
will step onto this landmine as well.

