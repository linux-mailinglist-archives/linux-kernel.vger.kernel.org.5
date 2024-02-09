Return-Path: <linux-kernel+bounces-59617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD07984F9BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1445B1C21427
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB47BAE4;
	Fri,  9 Feb 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Zmyp79Sr"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13037B3CF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496613; cv=none; b=YeH7InBgn0jQpA6N5QszI/reSbZBesF8WLGTTM/asDtOyU8+mptv1nB59B1+WcxcJthOk4vVWSqGxLtKv6HlcYrvPV/UxKoT7gS5ZfnnZdQqMbKZuggNe8uiiYhDTGm0aLVd5qP+OdvyOQU5g5rshY64mRm1omNAK26v6RA43ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496613; c=relaxed/simple;
	bh=d7okUqp/3uZnwXF7MeKDkSh0JzNedP4z+LN7JvpdaHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OXTljWkpiJIkzNHk6LEQWGH3Y9pp/E/kx3Q+h4L+GVkWnrZuK3uTY7YMjD5XvLgEbCbM1IqoatMjn0rL9a4eYt9H6koApp0xkT9kk1imqRcuiAPuCxTysyDSUWFWYvCKW2+Sm1yn5aExsUIQY1pd6zShIWuEzrn+f4hEKunGBwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Zmyp79Sr; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C639C41A2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707496611; bh=NRT0BzbVaBiW/CbrG+I1Jwm5NSvx3kcZk+mnaMCJbrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Zmyp79SrYdrLr0mM1ufjNYkLxvlR9/31+UkcdlW2eVhwXvE4ByFO64Z2M64uauywM
	 ZR93kdhg0fYtarXwaD7JiSC3It+dnFohyWeIzWsaiv66zKIy8yufgLHvseLL2C13Nf
	 Qxp+EGiCdxHTt6GkYgJWRNoEplOezdab2ozv4ZFThMqymVUt966sw0fLkidRhW2b+n
	 H/Oe03GypYDPcAYVMHvC8YcpHgmVAlS5PVsXRVP/vGTgNSKlpTguPRGJ6HxlfRe87P
	 p9S+WPDIgTpcuePy8GINUb+kXWR/uXrGaZ92zCx9LsSwHFjuqnonVdVAHup3SacFFG
	 BlzcyR701hAog==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C639C41A2A;
	Fri,  9 Feb 2024 16:36:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix kernel-doc comment of unplug_oldest_pwq()
In-Reply-To: <ZcZSlBRELjUIVJ_B@slm.duckdns.org>
References: <20240209145850.1157304-1-longman@redhat.com>
 <ZcZSlBRELjUIVJ_B@slm.duckdns.org>
Date: Fri, 09 Feb 2024 09:36:50 -0700
Message-ID: <87zfw9d271.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tejun Heo <tj@kernel.org> writes:

> (cc'ing Jonathan and quoting whole body)
>
> I'm not necessarily against the patch but at least from in-code
> documentation POV the diagram being in the function comment seems better.
> Jonathan, do you happen to know a better way to address this?

So I went to reproduce this problem, but it seems that it's hidden away
in some branch and not in linux-next.  So I'll have to guess without
testing my solution, but...

> On Fri, Feb 09, 2024 at 09:58:50AM -0500, Waiman Long wrote:
>> It turns out that it is not a good idea to put an ASCII diagram in the
>> kernel-doc comment of unplug_oldest_pwq() as the tool puts out warnings
>> about its format and will likely render it illegible anyway. Break the
>> ASCII diagram out into its own comment block inside the function to
>> avoid this problem.
>> 
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/workqueue.c | 32 ++++++++++++++++++--------------
>>  1 file changed, 18 insertions(+), 14 deletions(-)
>> 
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index cd2c6edc5c66..f622f535bc00 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -1790,25 +1790,29 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq, bool fill)
>>   * unplug_oldest_pwq - restart an oldest plugged pool_workqueue
>>   * @wq: workqueue_struct to be restarted
>>   *
>> - * pwq's are linked into wq->pwqs with the oldest first. For ordered
>> - * workqueues, only the oldest pwq is unplugged, the others are plugged to
>> - * suspend execution until the oldest one is drained. When this happens, the
>> - * next oldest one (first plugged pwq in iteration) will be unplugged to
>> - * restart work item execution to ensure proper work item ordering.
>> - *
>> - *    dfl_pwq --------------+     [P] - plugged
>> - *                          |
>> - *                          v
>> - *    pwqs -> A -> B [P] -> C [P] (newest)
>> - *            |    |        |
>> - *            1    3        5
>> - *            |    |        |
>> - *            2    4        6
>> + * This function should only be called for ordered workqueues where only the

The problem here is that you have a literal block without marking it as
such.  If you were to format it as:

> * next oldest one (first plugged pwq in iteration) will be unplugged to
> * restart work item execution to ensure proper work item ordering::
> *
> *    dfl_pwq --------------+     [P] - plugged
> *                          |
> *                          v
> *    pwqs -> A -> B [P] -> C [P] (newest)
> *            |    |        |
> *            1    3        5
> *            |    |        |
> *            2    4        6
> *
> * This function should only be called for ordered workqueues where only the

..it should work.  The changes are the "::" after "ordering" and the
blank line at the end of the block.

Thanks,

jon

