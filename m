Return-Path: <linux-kernel+bounces-135383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A3689BFCB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D256284EAA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0167E572;
	Mon,  8 Apr 2024 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="wNVB4yAr"
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B487172F;
	Mon,  8 Apr 2024 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581238; cv=none; b=fOUO8BzCb2bR5hBQNsAhuHc/vdVIsqCejozfJuBQk144g2DU8dpS5ksw31YLv3QW0/Mjz+TrrLiumppESbd8Zef44SsxOZfiUyLxw/tUuODF2o5qf2v1qLTjpRqiiU/ddG/cYuh/QOmnIkJPFhN0vEOll5chq+3xmgbPi7Hdxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581238; c=relaxed/simple;
	bh=FkXLzyxqjZzUX3ydZJqpehjHFFdMSDLx+4h5DWHTIiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RQcOdFqJH2qcxACnm662f4KxwE+ZttMtBUUrTFTHSr+OIFiptpWG/YoVHvjJ2/RshG/RyFRAb8sLzq0AoAl0nKFBLnEYKoG7yCS+a9YWwtd8A9346uN2KarfZwgz52H0Xfg55mHA0wbv655JWgybAXdonvp5hf7YDItKUcaFvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=wNVB4yAr; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1712581229; bh=FkXLzyxqjZzUX3ydZJqpehjHFFdMSDLx+4h5DWHTIiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=wNVB4yArKpa2PUdlKiLdUKq+m0PD/rqSv51mIeW6FY3daUZxgK8MjoX3api0EigvJ
	 d5z8okWEZnkeGojomYZA7aj65SsZa2dOSApaNxn8tFnlvRvlc/7hgZwq5qAZFZp7pL
	 1iaq0RtpGeDFMHpwyKAhdlW4p+XbPu3Kc3DuG0drdQvu4h3ol/L5ja8gwcd0Hitm1K
	 T2NtVewABkVOGdCDoZbjpCZVKXITP4DD8t2PTpdUAby5d4tjjTeE6dNCaRZQfI7Ick
	 FgMlzoZJSH9a24rzBvXxDStS9jsl0JRPl77FgvewUknuJ5doB+aFCH1YU8LucGi4yv
	 LXUTQZ5bAez+A==
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jserv@ccns.ncku.edu.tw, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sched: cake: Optimize number of calls to
 cake_heapify()
In-Reply-To: <ZhPRfYt0BLh9UELN@visitorckw-System-Product-Name>
References: <20240406235532.613696-1-visitorckw@gmail.com>
 <87frvxgnmr.fsf@toke.dk> <ZhPRfYt0BLh9UELN@visitorckw-System-Product-Name>
Date: Mon, 08 Apr 2024 15:00:29 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87cyr0ggb6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kuan-Wei Chiu <visitorckw@gmail.com> writes:

> On Sun, Apr 07, 2024 at 06:10:04PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Kuan-Wei Chiu <visitorckw@gmail.com> writes:
>>=20
>> > Improve the max-heap construction process by reducing unnecessary
>> > heapify operations. Specifically, adjust the starting condition from
>> > n / 2 to n / 2 - 1 in the loop that iterates over all non-leaf
>> > elements.
>>=20
>> Please add an explanation for why this change is correct, and why it is
>> beneficial. "Improve" and "unnecessary" is way too implicit.
>>=20
>> pw-bot: cr
>
> For correctness:
> To build a heap, we need to perform heapify operations on all non-leaf
> nodes, so we need to find the index of the first non-leaf node. In a
> heap, the index of node i, the left child's index is 2 * i + 1, and the
> right child's index is 2 * i + 2. The left and right children of node
> CAKE_MAX_TINS * CAKE_QUEUES / 2 are at indexes CAKE_MAX_TINS *
> CAKE_QUEUES + 1 and CAKE_MAX_TINS * CAKE_QUEUES + 2, respectively. Both
> children's indexes are beyond the range of the heap, indicating that
> CAKE_MAX_TINS * CAKE_QUEUES / 2 is a leaf node. The left child of node
> CAKE_MAX_TINS * CAKE_QUEUES / 2 - 1 is at index CAKE_MAX_TINS *
> CAKE_QUEUES - 1, and the right child is at index CAKE_MAX_TINS *
> CAKE_QUEUES. Therefore, we know the left child exists, but the right
> child does not. Since it's not a leaf node, the loop should start from
> it.
>
> For benefit:
> We can reduce 2 function calls (one for cake_heapify() and another for
> cake_heap_get_backlog()) and decrease 5 branch condition evaluations
> (one for iterating through all non-leaf nodes, one inside the while
> loop of cake_heapify(), and three more inside the while loop with if
> conditions). The only added operation is an extra subtraction.
>
> If you're satisfied with the explanation above, I can attempt to
> rewrite the commit message and send the v2 patch.

Yes, sounds reasonable. Did you measure any real-world performance
benefit, or is this purely a theoretical optimisation? Either way,
please indicate this in the updated patch description.

-Toke

