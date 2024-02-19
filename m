Return-Path: <linux-kernel+bounces-71842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A662385AB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459A71F23F19
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15C48791;
	Mon, 19 Feb 2024 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cEJ6+gQ+"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A94A3B;
	Mon, 19 Feb 2024 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368956; cv=none; b=ccSooodnUTBkQka5SziYnQxC9NkvLkZIDtYZrQHEp++usyuTkxDsr517h/iXXezb+9EG71zer55q9EbEYL0if4vZT7Tlmxq2gLEfDmsgtILbtTyi5drk6Ty1e4aOgIsTZgni7ibD5P8d42autRBl7n68t17KCIX9R5eGfRwMCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368956; c=relaxed/simple;
	bh=N5ZH9wqFWur86cVuVxvi/Pi+hCjhc8MpHYwaMvTmuzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlfB+uwn2fJCrdX09dk238oNK+cSX7XSzu8XqW/XIuFlz/W9cUUfWqMKPvYdHKQSGKIjV16b0XTEPltlVgw4iZSIPBunc6SzP5Dnm1O1Gb9VxNOclZu8zpNPeG2HsYOey7qho+Wk+ILhCgFpn9bj3OXcTcJqwqlmMFvULHcME5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cEJ6+gQ+; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708368954; x=1739904954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AYF3fJ3lQYdHvX4FbenRMpfXYf4i7AfH5JvlmkprmDk=;
  b=cEJ6+gQ+FZptKUuB/jkouOlvMXJCPXgvQmai2DLmdvPuS3B1IiGyosVx
   H8CP7gKfLy/dHx60AMT2LU8Uqcz1mbBRXnIWHKjh2Jm/x2CGdLie+MFTq
   avuIYqbVot+soUFCi6XVb/myZNdPD4XwwzqK1AiSyAf9pcKOblyVXuafo
   4=;
X-IronPort-AV: E=Sophos;i="6.06,170,1705363200"; 
   d="scan'208";a="185811561"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 18:55:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:4119]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.9:2525] with esmtp (Farcaster)
 id 9b887880-2511-4018-a341-9f255bfa8211; Mon, 19 Feb 2024 18:55:49 +0000 (UTC)
X-Farcaster-Flow-ID: 9b887880-2511-4018-a341-9f255bfa8211
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 18:55:48 +0000
Received: from 88665a182662.ant.amazon.com (10.94.72.56) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 18:55:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <vschneid@redhat.com>
CC: <bigeasy@linutronix.de>, <davem@davemloft.net>, <dccp@vger.kernel.org>,
	<dsahern@kernel.org>, <edumazet@google.com>, <juri.lelli@redhat.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>, <mleitner@redhat.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <tglozar@redhat.com>,
	<tglx@linutronix.de>, <kuniyu@amazon.com>
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
Date: Mon, 19 Feb 2024 10:55:37 -0800
Message-ID: <20240219185537.13666-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240219095729.2339914-2-vschneid@redhat.com>
References: <20240219095729.2339914-2-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Valentin Schneider <vschneid@redhat.com>
Date: Mon, 19 Feb 2024 10:57:29 +0100
> The TCP timewait timer is proving to be problematic for setups where scheduler
> CPU isolation is achieved at runtime via cpusets (as opposed to statically via
> isolcpus=domains).
> 
> What happens there is a CPU goes through tcp_time_wait(), arming the time_wait
> timer, then gets isolated. TCP_TIMEWAIT_LEN later, the timer fires, causing
> interference for the now-isolated CPU. This is conceptually similar to the issue
> described in
>   e02b93124855 ("workqueue: Unbind kworkers before sending them to exit()")
> 
> Keep softirqs disabled, but make the timer un-pinned and arm it *after* the
> hashdance.
> 
> This introduces the following (non-fatal) race:
> 
>   CPU0                        CPU1
>     allocates a tw
>     insert it in hash table
> 				finds the TW and removes it
> 				(timer cancel does nothing)
>     arms a TW timer, lasting
> 
> This partially reverts
>   ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")
> and
>   ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashdance")
> 
> This also reinstores a comment from
>   ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashdance")
> as inet_twsk_hashdance() had a "Step 1" and "Step 3" comment, but the "Step
> 2" had gone missing.
> 
> Link: https://lore.kernel.org/all/ZPhpfMjSiHVjQkTk@localhost.localdomain/
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  net/dccp/minisocks.c          | 16 +++++++---------
>  net/ipv4/inet_timewait_sock.c | 20 +++++++++++++++-----
>  net/ipv4/tcp_minisocks.c      | 16 +++++++---------
>  3 files changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/net/dccp/minisocks.c b/net/dccp/minisocks.c
> index 64d805b27adde..2f0fad4255e36 100644
> --- a/net/dccp/minisocks.c
> +++ b/net/dccp/minisocks.c
> @@ -53,16 +53,14 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
>  		if (state == DCCP_TIME_WAIT)
>  			timeo = DCCP_TIMEWAIT_LEN;
>  
> -		/* tw_timer is pinned, so we need to make sure BH are disabled
> -		 * in following section, otherwise timer handler could run before
> -		 * we complete the initialization.
> -		 */
> -		local_bh_disable();
> -		inet_twsk_schedule(tw, timeo);
> -		/* Linkage updates.
> -		 * Note that access to tw after this point is illegal.
> -		 */
> +	       local_bh_disable();

This line seems not correctly indented, same for TCP change.



> +
> +		// Linkage updates
>  		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
> +		inet_twsk_schedule(tw, timeo);
> +		// Access to tw after this point is illegal.

Also please use /**/ style for these comments, same for TCP too.


> +		inet_twsk_put(tw);
> +
>  		local_bh_enable();
>  	} else {
>  		/* Sorry, if we're out of memory, just CLOSE this

