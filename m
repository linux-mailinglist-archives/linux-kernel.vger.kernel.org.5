Return-Path: <linux-kernel+bounces-142135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C028A27F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C273C1C23263
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8374D584;
	Fri, 12 Apr 2024 07:25:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3814AEE3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906750; cv=none; b=MTktdNqYbfAkVAydn1FQt4f2CxOz+3hZSP4tpPYNthQEXHUgL2EF+sbBFShB1TNBAnze/JJjZM7sydY4iUa3gQi96tcPfHBUbFh0vGHLGzN1JJw/I6deDsdqYodXZXSukgqMYMDu2aVy/33PhfnFRhe7rrHGO0iaJaTbBXI7J9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906750; c=relaxed/simple;
	bh=Xg19eC67v3NTayc5Hy9RUTH6DfrUtRo1sUps2JiuTm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKjlsUxlGkFjw/HofLuSiXrqiLoBK9kqvAe2oO/Ihp7oSIaDB3R1VZqOMxVLKCbn6Bf++2RElCkdA7EsQfIvawEo+P5r3OgPyTe3TFz8ceVW44qaReuG+a4VolXQXtLnGg1msKMZxzg9rwwIvMTrzzQAR+vn9YLCkzFLcALu9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rvBI3-0000dd-3D; Fri, 12 Apr 2024 09:25:39 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rvBI1-00BpnW-DU; Fri, 12 Apr 2024 09:25:37 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1rvBI1-009Hey-14;
	Fri, 12 Apr 2024 09:25:37 +0200
Date: Fri, 12 Apr 2024 09:25:37 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, kernel@pengutronix.de
Subject: Re: [PATCH] tls: defer close to kernel task
Message-ID: <Zhjh8f2_9EGv7I9W@pengutronix.de>
References: <20240410-ktls-defer-close-v1-1-b59e6626b8e4@pengutronix.de>
 <20240410061128.3b337185@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410061128.3b337185@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2024 at 06:11:28AM -0700, Jakub Kicinski wrote:
> On Wed, 10 Apr 2024 08:33:07 +0200 Sascha Hauer wrote:
> > proto->close is normally called from a userspace task which can be
> > interrupted by signals. When asynchronous encryption is used then KTLS
> > sends out the final data at close time. When a signal comes in during
> > close then it can happen tcp_sendmsg_locked() is interrupted by that
> > signal while waiting for memory in sk_stream_wait_memory() which then
> > returns with -ERSTARTSYS. It is not possible to recover from this situation
> > and the final transmit data is lost.
> > 
> > With this patch we defer the close operation to a kernel task which
> > doesn't get signals.
> > 
> > The described situation happens when KTLS is used in conjunction with
> > io_uring, as io_uring uses task_work_add() to add work to the current
> > userspace task.
> > 
> > The problem is discussed in [1] and [2] and the solution implemented in
> > this patch is suggested by Pavel Begunkov here [3]
> 
> Appears to crash reliably.
> Please run the tls selftests with KASAN enabled.

Oops, will run the tests and fix the fallout before resending.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

