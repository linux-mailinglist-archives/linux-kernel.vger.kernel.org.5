Return-Path: <linux-kernel+bounces-118298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D36CA88B76A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4730AB20B21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4C8287F;
	Tue, 26 Mar 2024 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udTdxOGA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B654E1A8;
	Tue, 26 Mar 2024 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420137; cv=none; b=MMakkP2L5rxoXtyh2YNjdC2RCavSl0n9+vEW0mRx1hXBaYEG6TO6JcDLGI5b1Z0/f745FPYphLBUDfP66ag4+MYNKrHHnotGlG+7BH8Ggd+sZkmHOKDFh4szrLQYXVKubNPuMRsJtp+AXBNsEOqiPjTlKCdAAAMxv44bgiIg8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420137; c=relaxed/simple;
	bh=Ktz9UbpIvvzi2R8AiNv+RRMOy4vq7/ZgvePg/K1Kn8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1d0S0ScxnUdDCjpUlzx+FwF+CdAm2koJxmI7/p1c86tpV+mY2kba6SucD8Oj8cfcri+ba4l8gfrEdpYtDISOuin2nJ6ucoZWlP3pLFNCLjRePu6Dj4/Suv6nOwbBHBRhHvMA0JiufUCnJLVDyT306feyUKso90T0SXzPu2x61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udTdxOGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60579C433C7;
	Tue, 26 Mar 2024 02:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711420137;
	bh=Ktz9UbpIvvzi2R8AiNv+RRMOy4vq7/ZgvePg/K1Kn8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=udTdxOGAJBrg51gfL1uwJ93+ngK3GMR3Fm0SHsW8NFMKc9VeZ8WX9rURwWXQQ1s0e
	 X3QpkfyFYRd5auxgAHs/WDPfEgWkK7wSdwbRSK6qHf0/CGPL8KpZO9/fEKWPQ2XdIY
	 jnlKG4Dht0MQ7vuTO/6bx6UbifyWIgKxFgzP8LfsnjvuliAD1b+X6o3pf/hbIgdu7n
	 y+/cszBAu+5pTmwVTHjeiB8jAJDHwN24rlH/UglH/enj2pq0nZaEqnDaDJPPBOzfQq
	 mZV1xvO24t1nWKFsmZujrP5oEVBubPo6ks4hFNQzy5B7k/2WcFzNu7DrmpBWk+Gcdc
	 DMB3pyfzrPbRw==
Date: Mon, 25 Mar 2024 19:28:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Balazs Scheidler <bazsi77@gmail.com>
Cc: kerneljasonxing@gmail.com, kuniyu@amazon.com, netdev@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Balazs Scheidler
 <balazs.scheidler@axoflow.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: udp: add IP/port data to the
 tracepoint udp/udp_fail_queue_rcv_skb
Message-ID: <20240325192855.1fb3c331@kernel.org>
In-Reply-To: <34a9c221a6d644f18c826a1beddba58af6b7a64c.1711361723.git.balazs.scheidler@axoflow.com>
References: <cover.1711361723.git.balazs.scheidler@axoflow.com>
	<34a9c221a6d644f18c826a1beddba58af6b7a64c.1711361723.git.balazs.scheidler@axoflow.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 11:29:18 +0100 Balazs Scheidler wrote:
> +                memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
> +                memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));

Indent with tabs please, checkpatch says:

ERROR: code indent should use tabs where possible
#59: FILE: include/trace/events/udp.h:38:
+                memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));$

WARNING: please, no spaces at the start of a line
#59: FILE: include/trace/events/udp.h:38:
+                memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));$

ERROR: code indent should use tabs where possible
#60: FILE: include/trace/events/udp.h:39:
+                memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));$

WARNING: please, no spaces at the start of a line
#60: FILE: include/trace/events/udp.h:39:
+                memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));$
-- 
pw-bot: cr

