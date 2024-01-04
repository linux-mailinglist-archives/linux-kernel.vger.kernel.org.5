Return-Path: <linux-kernel+bounces-16980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC438246C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629C31C24097
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307F82555B;
	Thu,  4 Jan 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV2uMaCL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC522557D;
	Thu,  4 Jan 2024 16:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D55C433C9;
	Thu,  4 Jan 2024 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704387537;
	bh=Qv1FVDMhJFpUV2ReAZyavAebhLNjyUrQ22LEd6iuk4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BV2uMaCL5PEzmjFiquegFIlzyHg8xODu616+S88grmlsxWurqRBreB1sHykacxixP
	 2toi0l9ux2iKE9RVTRX8jPV23I4hpNWtOA13NT5jImqyl1ZZqHLWCcctpMa5pH519q
	 S+GXacB/+K38Ks9nso6uPAyXrN6nR7KpoUwEbmNaPp3EfFjC1CZVTeudvRq+53iRtd
	 fBTpbBarodjoXTGtkg2Ovwhone2JWKLrIoaZdR8ZwKxZPD0rYxfDD6BQhMzsbPPJT9
	 rHhk1DdAQRwpWn+7t/omKpuaqqV6W7U3KPlXVtY48Ty9bpLLbaoAI8wlk6HKyd3xWt
	 WUfJxubzTkijg==
Date: Thu, 4 Jan 2024 08:58:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Christian Kujau
 <lists@nerdbynature.de>, Salam Noureddine <noureddine@arista.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Safonov
 <0x7f454c46@gmail.com>
Subject: Re: [PATCH] net/tcp: Only produce AO/MD5 logs if there are any keys
Message-ID: <20240104085855.4c5c5a1f@kernel.org>
In-Reply-To: <335a2669-6902-4f57-bf48-5650cbf55406@arista.com>
References: <20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com>
	<20240104075742.71e4399f@kernel.org>
	<335a2669-6902-4f57-bf48-5650cbf55406@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jan 2024 16:42:05 +0000 Dmitry Safonov wrote:
> >> Keep silent and avoid logging when there aren't any keys in the system.
> >>
> >> Side-note: I also defined static_branch_tcp_*() helpers to avoid more
> >> ifdeffery, going to remove more ifdeffery further with their help.  
> > 
> > Wouldn't we be better off converting the prints to trace points. 
> > The chances for hitting them due to malicious packets feels much
> > higher than dealing with a buggy implementation in the wild.  
> 
> Do you mean a proper stuff like in net/core/net-traces.c or just
> lowering the loglevel to net_dbg_ratelimited() [like Christian
> originally proposed], which in turns becomes runtime enabled/disabled?

I mean proper tracepoints.

> Both seem fine to me, albeit I was a bit reluctant to change it without
> a good reason as even pre- 2717b5adea9e TCP-MD5 messages were logged and
> some userspace may expect them. I guess we can try and see if anyone
> notices/complains over changes to these messages changes or not.

Hm. Perhaps we can do the conversion in net-next. Let me ping Eric :)

