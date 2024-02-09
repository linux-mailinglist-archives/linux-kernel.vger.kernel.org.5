Return-Path: <linux-kernel+bounces-59661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D1384FA04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639FD1C29B3A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEB184A36;
	Fri,  9 Feb 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6JdfqrM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3084A2E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497202; cv=none; b=a+3k4ExWQhDJkmbK6FkFs1Ljtm81ovqmeciudRIfrdhELgoTVNVLTnpR/ZBGhBs/3Xch0rTkxuIHKa0gSvMCXtMwIeAF40w6DJdgavKf9d2GkqFggLdUgWQM3kMiknExWVFUxpWbHR7aCXSjRg0ojwc2JJ7L4vGghF7ylZg6kwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497202; c=relaxed/simple;
	bh=VEm6RVPdD1p5mJ6bXFN7fX2f9SsH2oo3/ieQH2PCFN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MB65K3JcDOcjT0Zy+on1g4m2CB/Wv3y7O/UFXX3K16Y5ct745bD9sUlYcFKGUwsPZ0QH1Th91FhMu4qd6v7bDFifxCRLb6p72LFuRc0saXrPUgWFV9T63KxqjFS5pZr0hRb+ObN+Y64OP2cdLtQih3wdsDnvq+LUSw8o5bLuqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6JdfqrM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707497199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RKTWo9+VRgzlcBEDe2NCNrxzS16RFHF2DMS3KxpjAQ=;
	b=U6JdfqrM6VStVMEN3G3WFfmBUL3KmqdxvWEam+/Oety/yJOkLoEw6R/vJUcpjNAl13KGc1
	GVfEI8pK3c9k5+TJlcMih4ScRWoIQdpdWG8MN+53C73xEo77w2RWjhGPnvJ5owX22qTzu8
	LLQ+f5fNbaM7mycPaa8IrLrEkX4x+uw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-9sWaT8x3PzSwPdNe5-ekHA-1; Fri, 09 Feb 2024 11:46:36 -0500
X-MC-Unique: 9sWaT8x3PzSwPdNe5-ekHA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B7AB10AFB9B;
	Fri,  9 Feb 2024 16:46:36 +0000 (UTC)
Received: from [10.22.17.112] (unknown [10.22.17.112])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 02E13492BC8;
	Fri,  9 Feb 2024 16:46:35 +0000 (UTC)
Message-ID: <a1704f1a-f05b-4798-a3a4-a1d35d7282fd@redhat.com>
Date: Fri, 9 Feb 2024 11:46:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] workqueue: Fix kernel-doc comment of unplug_oldest_pwq()
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
References: <20240209145850.1157304-1-longman@redhat.com>
 <ZcZSlBRELjUIVJ_B@slm.duckdns.org> <87zfw9d271.fsf@meer.lwn.net>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <87zfw9d271.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 2/9/24 11:36, Jonathan Corbet wrote:
> Tejun Heo <tj@kernel.org> writes:
>
>> (cc'ing Jonathan and quoting whole body)
>>
>> I'm not necessarily against the patch but at least from in-code
>> documentation POV the diagram being in the function comment seems better.
>> Jonathan, do you happen to know a better way to address this?
> So I went to reproduce this problem, but it seems that it's hidden away
> in some branch and not in linux-next.  So I'll have to guess without
> testing my solution, but...
>
>> On Fri, Feb 09, 2024 at 09:58:50AM -0500, Waiman Long wrote:
>>> It turns out that it is not a good idea to put an ASCII diagram in the
>>> kernel-doc comment of unplug_oldest_pwq() as the tool puts out warnings
>>> about its format and will likely render it illegible anyway. Break the
>>> ASCII diagram out into its own comment block inside the function to
>>> avoid this problem.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   kernel/workqueue.c | 32 ++++++++++++++++++--------------
>>>   1 file changed, 18 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>>> index cd2c6edc5c66..f622f535bc00 100644
>>> --- a/kernel/workqueue.c
>>> +++ b/kernel/workqueue.c
>>> @@ -1790,25 +1790,29 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq, bool fill)
>>>    * unplug_oldest_pwq - restart an oldest plugged pool_workqueue
>>>    * @wq: workqueue_struct to be restarted
>>>    *
>>> - * pwq's are linked into wq->pwqs with the oldest first. For ordered
>>> - * workqueues, only the oldest pwq is unplugged, the others are plugged to
>>> - * suspend execution until the oldest one is drained. When this happens, the
>>> - * next oldest one (first plugged pwq in iteration) will be unplugged to
>>> - * restart work item execution to ensure proper work item ordering.
>>> - *
>>> - *    dfl_pwq --------------+     [P] - plugged
>>> - *                          |
>>> - *                          v
>>> - *    pwqs -> A -> B [P] -> C [P] (newest)
>>> - *            |    |        |
>>> - *            1    3        5
>>> - *            |    |        |
>>> - *            2    4        6
>>> + * This function should only be called for ordered workqueues where only the
> The problem here is that you have a literal block without marking it as
> such.  If you were to format it as:
>
>> * next oldest one (first plugged pwq in iteration) will be unplugged to
>> * restart work item execution to ensure proper work item ordering::
>> *
>> *    dfl_pwq --------------+     [P] - plugged
>> *                          |
>> *                          v
>> *    pwqs -> A -> B [P] -> C [P] (newest)
>> *            |    |        |
>> *            1    3        5
>> *            |    |        |
>> *            2    4        6
>> *
>> * This function should only be called for ordered workqueues where only the
> ...it should work.  The changes are the "::" after "ordering" and the
> blank line at the end of the block.
>
Thanks for the tip. I will update my patch to use the proper formatting 
hint.

Cheers,
Longman


