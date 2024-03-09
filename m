Return-Path: <linux-kernel+bounces-97769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 688AB876F2F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459581C20CBE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB691EA73;
	Sat,  9 Mar 2024 04:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kQaZep7D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B3C10A34;
	Sat,  9 Mar 2024 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709959373; cv=none; b=kp5iJy+E5FyRlZ774gnOKNJRrEAqZSLGmJhFKQY/QedM5qn47LZVl/aE2ik+VjLlEuiyQdlOgJtvxkEVNg+VO0I72D9TlAgQSUJs4mqUrXfbvj8fC01NvXVnDg5YoHJKG6O3w4HQp9paXJOgAVB6YuQiVX36abxR9Cped1PJkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709959373; c=relaxed/simple;
	bh=MhaUZkR+zHT+hBRKhEA6jXqVicUXERiCJ4v3T85N63k=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Of2/JO5ZSLkVf2Fe8ZJEir+1JxnHor+nElJRSB5mnFPiFg6NL3GEo9/gaYLIEbjxF8TLDXvEg8V9WhtixwLZ1+M+PdH87axcXoor8dS99oE/zb1vGbc+udJn9nYFVTvTBPfWYT3e9xXFyfgUCSM4bPReL/WqPo35JklJO4Myvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kQaZep7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07A0C433C7;
	Sat,  9 Mar 2024 04:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709959373;
	bh=MhaUZkR+zHT+hBRKhEA6jXqVicUXERiCJ4v3T85N63k=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=kQaZep7DufDlD4TcCEwxPHIQAMTa96bO79yptDpP3N5v3iWWZkxor+tfKJuIWEekj
	 MqtI70ZJA8OPobCIyL9ihOxfANdsavmfcDv2heioEqCnMReivT2VVU8Yhex+QxGJj4
	 yXXitd/67pxge9M4JKqsp62/DnEX2x86iUVcIdRQ=
Date: Fri, 8 Mar 2024 20:42:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>, herbert@gondor.apana.org.au,
 chriscli@google.com, chrisl@kernel.org, ddstreet@ieee.org,
 linux-kernel@vger.kernel.org, sjenning@redhat.com,
 vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>,
 davem@davemloft.net, hannes@cmpxchg.org, linux-crypto@vger.kernel.org,
 linux-mm@kvack.org, zhouchengming@bytedance.com, nphamcs@gmail.com,
 yosryahmed@google.com
Subject: Re: [PATCH v6 0/2] zswap: remove the memcpy if acomp is not
 sleepable
Message-Id: <20240308204251.43d7e518ba95fb4ce22f8d4d@linux-foundation.org>
In-Reply-To: <20240308203641.7fbe7e939b3483bd83b9769d@linux-foundation.org>
References: <20240222081135.173040-1-21cnbao@gmail.com>
	<CAGsJ_4wMGNDcgc3pqSUicYoH7Z_miczkT=uwZU+yhDF0fd57Rg@mail.gmail.com>
	<20240308192334.845b27504a663ec8af4f2aad@linux-foundation.org>
	<CAGsJ_4xSwNZmHN5GvipS-1kELX2NBwHxoGE=aG4sekm1LcYVPw@mail.gmail.com>
	<20240308203641.7fbe7e939b3483bd83b9769d@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 20:36:41 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> > Okay, I understand. Since this patch improves zswap's performance, I wanted
> > it to be integrated sooner to contribute. However, I'm perfectly willing to
> > respect your concerns and adhere to the community's best practices.
> > 
> 
> OK.  I very much doubt if anyone is running those drivers on mm.git, so
> adding it now isn't likely to hurt.
> 
> So I'll merge it now and shall aim to get it upstream very late in the
> next merge window.

Nope.  mm.git won't build without acomp_is_async().

We can merge the zswap patch via the crypto tree.  Acked-by: me.

Or please just resend the zswap change after 6.9-rc1 is released.



