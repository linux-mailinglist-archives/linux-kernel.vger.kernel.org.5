Return-Path: <linux-kernel+bounces-134541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477DB89B2CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D31282262
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6643A1B5;
	Sun,  7 Apr 2024 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="CeTS4FKg"
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043B37149;
	Sun,  7 Apr 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712506219; cv=none; b=kvDedg7a6zKedRPzCsbuaFMaBOvVyQZUR8oILkKlSOvN9JGklHkRhi52X0uOAh07EN7WUI9p4q8/KXxbZm/0GRMtFEaHC85CZllS5xtFSkG4Qot+PHUkNvEszx1mjPARsCMgMiqR2hT3OUvhjb8zymQnrEqbKgwpTHi5sO+zIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712506219; c=relaxed/simple;
	bh=jRHmiYZioEwTqHzvjz9ABYHfiTrjg7+dvZ5R454o5LU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PHKQjb5rZlNc7O0UZRQu41pyHpBXO3oXq5ON2QbsVTszfZ8I9kKapq7ow9NTwRuL/TnKLCcIWru2YmBL1mxifZMo/s9WL/XnCOG+pIvbSNzyTnrl4zp0DICpK37ZRlgf058rlFdDzSqDbD+WZcQBpWgsCozNOWsGQFrO4Z3LZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=CeTS4FKg; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1712506205; bh=jRHmiYZioEwTqHzvjz9ABYHfiTrjg7+dvZ5R454o5LU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CeTS4FKglAx+piMHVKigJkdCDiiM1bokhQAM9Q5pZWIb4AZP+M8uh0y3zUBI2swey
	 1Y5rmf+F3PYKcb9ngrPTadUwe4m0mcsAZwO5BFsGhxXgr1473SlczVyX3X5UnHfDJJ
	 FXDPz2t98/zRjgjTMPNDtQZAdA1PX7RidonG7j1GvTXUETxWSBWweovpu7gzxd6I63
	 1nGtkjqQoyWImhDp3OTfoVGhybpPro2b0nSgpM+GzeWtMzEOau/1QrpHHIyj5ftP6b
	 rQk3oes8bDqLriOLkddTTpQ8gr+NIVy38njV5/ZB06gQKu/hg44FZR6kQtVDAHwUA0
	 hqdD0pk/c5FWA==
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jserv@ccns.ncku.edu.tw, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kuan-Wei Chiu
 <visitorckw@gmail.com>
Subject: Re: [PATCH net-next] net: sched: cake: Optimize number of calls to
 cake_heapify()
In-Reply-To: <20240406235532.613696-1-visitorckw@gmail.com>
References: <20240406235532.613696-1-visitorckw@gmail.com>
Date: Sun, 07 Apr 2024 18:10:04 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87frvxgnmr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kuan-Wei Chiu <visitorckw@gmail.com> writes:

> Improve the max-heap construction process by reducing unnecessary
> heapify operations. Specifically, adjust the starting condition from
> n / 2 to n / 2 - 1 in the loop that iterates over all non-leaf
> elements.

Please add an explanation for why this change is correct, and why it is
beneficial. "Improve" and "unnecessary" is way too implicit.

pw-bot: cr

