Return-Path: <linux-kernel+bounces-138564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE1789F3C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CF21C26800
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AB215E213;
	Wed, 10 Apr 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBKzqXDu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839013D2BC;
	Wed, 10 Apr 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754690; cv=none; b=EdJH4BmsUM7J9Qi2S+WhJ0UPLrZMQ8zidgBS2GZK+GSfbl9Wx39KmVWf3vWfRJ1yu1aMke8P9nDhAXelgQXEs8MLrFM8PUUS1U3Y4Wm1nmtnfC9VL74c1VZxjOOR1DEb+iz9ZkGOsN/7PEEmMShe+8LEp567xRig72DWNrBNrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754690; c=relaxed/simple;
	bh=Md4uSOFTpo6URfFRK5OxgLSLUbspD99XvlPf7qjsLWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmvPM/lkNL02lAaHZtPd57GDVEmXdSy3/x8PevzkMMwJFVbBItz3RqeLl0PMDXpD11IKBGiSRD5LVugQ7RLl0fDNuIsntVE70vPpLdlPPhCM1JKQgzSw/v6tEyj4CeBzcwflZpw7HSyVM5RTkvW1xjsnGvC+cNS7qqmVxh3tV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBKzqXDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D68C433C7;
	Wed, 10 Apr 2024 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712754690;
	bh=Md4uSOFTpo6URfFRK5OxgLSLUbspD99XvlPf7qjsLWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YBKzqXDuq/ayEedOvudSsWlKvu0+kXM7qR7yvhCIhUXrETVQX1RTkmzW/LQRKwg5V
	 IcyIfTPJ4O1dYlZG7W2MGHnlRT0CctC45p/gpsTGuxqVRWQ6jBC8v46H92DjscWcPA
	 S1Me+FWz8DlfPv2OPh9ZTLaMXmQ+eq35vUfx1/ggcz1UGOg7m1kSr+CtmHtp9QSdDl
	 u2WqaVU9xY/JXsAKfkMsmBSu0kPzHwFI62a6qDChyEFoyUFAv3lpH1Cd76RkOzbPeT
	 FbxmobA19dnXSkZ7Dl8Xkwzov8h7bDOoUd78+gpwa3z+1OiicGMTfh9OTloV3bBxHS
	 bAU0luAqv+CKg==
Date: Wed, 10 Apr 2024 06:11:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Begunkov
 <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 kernel@pengutronix.de
Subject: Re: [PATCH] tls: defer close to kernel task
Message-ID: <20240410061128.3b337185@kernel.org>
In-Reply-To: <20240410-ktls-defer-close-v1-1-b59e6626b8e4@pengutronix.de>
References: <20240410-ktls-defer-close-v1-1-b59e6626b8e4@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 08:33:07 +0200 Sascha Hauer wrote:
> proto->close is normally called from a userspace task which can be
> interrupted by signals. When asynchronous encryption is used then KTLS
> sends out the final data at close time. When a signal comes in during
> close then it can happen tcp_sendmsg_locked() is interrupted by that
> signal while waiting for memory in sk_stream_wait_memory() which then
> returns with -ERSTARTSYS. It is not possible to recover from this situation
> and the final transmit data is lost.
> 
> With this patch we defer the close operation to a kernel task which
> doesn't get signals.
> 
> The described situation happens when KTLS is used in conjunction with
> io_uring, as io_uring uses task_work_add() to add work to the current
> userspace task.
> 
> The problem is discussed in [1] and [2] and the solution implemented in
> this patch is suggested by Pavel Begunkov here [3]

Appears to crash reliably.
Please run the tls selftests with KASAN enabled.
-- 
pw-bot: cr

