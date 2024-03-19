Return-Path: <linux-kernel+bounces-107889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D958B88030F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142751C226D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E317618AE4;
	Tue, 19 Mar 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0+JBnNM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E791FBF0;
	Tue, 19 Mar 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868250; cv=none; b=elb8adzisoqXY60locy52P+nPI/r+BKubVHu1EfBCRMZD9iqSNfDInIi+jIxaZKAlcn64MWhuT1UYkgciVupTuPmLzxy61RqkPgVq/u8ypgXGpYt48tk6qtMwx/DFf0CJRX5f+14FnBFjxjd5b+HY18dJtH6cSGKekLBzWtc12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868250; c=relaxed/simple;
	bh=chLaU/1e7fuTEiGMQDP7fwuUnBlDqgypzyaFA4B5D/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYf7MS6AGZsFHqBQ7MOu6tO3nPY+PRBc3Tj/LnOnOUinlOzasq8EJpl7KoFZ8Yyn6owIum1QqM29jHtgU1riq1oKeYdiz/oNPqA68xn5irHRmdswbSIlx+gkBp9KRZUNlJQ9r0HCAIJTqTJW6Jr+JLyZAa1MzQhMhbwZfXGBhg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0+JBnNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE7AC433C7;
	Tue, 19 Mar 2024 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710868249;
	bh=chLaU/1e7fuTEiGMQDP7fwuUnBlDqgypzyaFA4B5D/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0+JBnNMxAhJUtYep+rLCG3N2uUAuNHcnVZgVDffhTTd+iN+UKC8dIMKaaKqlQG3+
	 A+jXW1KsbnYkcxKExsQcgjhDzmN+FtMhlWpsdYDx7Db0eSmv2fbKcRqgI4YwIfy+Cn
	 KkxK2XTNMqCKjC+eOvahe7rQAPxIwNIynDAjzAd4lSbdv+6etCfQJRn32mY+qmr/9h
	 E3gY/+mIlS1X5v8yeB0hJOUjRQses4i/eGVchqbNNeG357DrTD3YPoDHWz9/dQzjTg
	 oZmALqkVwr9hPcK3VboINeB3spT07mnCtyc87TEk32SjUf1pObrrHkVvu2DaaIiSB7
	 GY4ZrICEkUy0Q==
Date: Tue, 19 Mar 2024 10:10:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark <mark@yotsuba.nl>
Cc: netdev@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Breno Leitao <leitao@debian.org>, Ingo
 Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netpoll: support sending over raw IP interfaces
Message-ID: <20240319101048.5b7c6949@kernel.org>
In-Reply-To: <93E237FA-9F0B-48E4-8A89-B9C2619B90A5@yotsuba.nl>
References: <20240313124613.51399-1-mark@yotsuba.nl>
	<20240314113455.152cebc9@kernel.org>
	<93E237FA-9F0B-48E4-8A89-B9C2619B90A5@yotsuba.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 12:47:46 +0100 Mark wrote:
> > Would be great if this could come with a simple selftest under
> > tools/testing/selftests/net. Preferably using some simple tunnel
> > device, rather than wg to limit tooling dependencies ;)  
> 
> Yes, that makes a lot of sense. I wrote a selftest that tests netconsole
> using IPIP and GRE tunnels, and they too seem to work correctly and pass (and
> more importantly, fail without the patch ;-). Would you prefer me to submit
> a v2 with that test now, or when net-next reopens in a week?

Feel free to post as [RFC net-next v2] now. I can't guarantee people
will find the time to review, but it shouldn't hurt to have it on 
the list :)

