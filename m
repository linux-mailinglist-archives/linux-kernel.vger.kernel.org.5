Return-Path: <linux-kernel+bounces-72208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350C185B0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B803F283D50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8185D41AAB;
	Tue, 20 Feb 2024 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9zlYGtk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAF3E47F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395640; cv=none; b=pQ6+vHMpa3K5iOyyiVPspHQ0ZXDByGRds+NqxGfjrZ1+1DYBtQdJCbMTci0UDip1frLntqvfBZvbDw74QMM4JOcRtAwyGz0UppPIpx5tB//1gXlLZT1c2XblIa6Y4DLakFWOz8CJpybZ7IRm5SMw+OgX9VnPTm01yUnS1qrqC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395640; c=relaxed/simple;
	bh=XdmGftUgvdRWRE2HE9nGJXerV+xvznarJWKf1cokm1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1g88ozAD081wwd6KPe5GOAb+uhntPg0WXT5LrY2isfvDhL8NwxCgA0rZ7msK7IdCjJfw6hvtk42eLXUqxwtKRttp3JYNvQcEgUOBnsnjL8kyAxq2NyMJ9L9jtOQwR74jWlC5nJ1CcWikgHYtWwEVlc0potjdVVAu9fJ4O12NJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9zlYGtk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708395638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLeXaVVMj3CAyWPynSowMBob8/77CE28trQ00f9Cmc0=;
	b=H9zlYGtkGOYTLgtH4mo65wF7Ns/3TjmKgucdWmuFObnJwRrNoJIPCbHn/LLzQQ8RFOeCO4
	UZc+oArsEFcPt0bnaP1piCk4eYOk3sg7QKZ+NAbwtJTSqGdVQBTEgdg9NE5PSGX7bED1SZ
	E0pxsT35I9oOIoW/tl4FfYTEda+15iI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-paPtkcdCNX6qWmuYvLFQTg-1; Mon, 19 Feb 2024 21:20:32 -0500
X-MC-Unique: paPtkcdCNX6qWmuYvLFQTg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C52D185A780;
	Tue, 20 Feb 2024 02:20:32 +0000 (UTC)
Received: from [10.22.18.9] (unknown [10.22.18.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BC179C185C0;
	Tue, 20 Feb 2024 02:20:31 +0000 (UTC)
Message-ID: <388686b2-5305-43d1-8edf-19ba66d52727@redhat.com>
Date: Mon, 19 Feb 2024 21:20:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Jin Wang <jin1.wang@intel.com>
References: <20240129134505.961208-1-feng.tang@intel.com>
 <87msrwadvu.ffs@tglx> <ZdNnjdNTjtvpbGH0@feng-clx.sh.intel.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZdNnjdNTjtvpbGH0@feng-clx.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


On 2/19/24 09:37, Feng Tang wrote:
> Hi Thomas,
>
> On Mon, Feb 19, 2024 at 12:32:05PM +0100, Thomas Gleixner wrote:
>> On Mon, Jan 29 2024 at 21:45, Feng Tang wrote:
>>> +static inline long clocksource_max_watchdog_read_retries(void)
>>> +{
>>> +	long max_retries = max_cswd_read_retries;
>>> +
>>> +	if (max_cswd_read_retries <= 0) {
>>> +		/* santity check for user input value */
>>> +		if (max_cswd_read_retries != -1)
>>> +			pr_warn_once("max_cswd_read_retries was set with an invalid number: %ld\n",
>>> +				max_cswd_read_retries);
>>> +
>>> +		max_retries = ilog2(num_online_cpus()) + 1;
>> I'm getting tired of these knobs and the horrors behind them. Why not
>> simply doing the obvious:
>>
>>         retries = ilog2(num_online_cpus()) + 1;
>>
>> and remove the knob alltogether?
> Thanks for the suggestion! Yes, this makes sense to me. IIUC, the
> 'max_cswd_read_retries' was introduced mainly to cover different
> platforms' requirement, which could now be covered by the new
> self-adaptive number.
>
> If there is no concern from other developers, I will send a new
> version in this direction.

I see no problem simplifying it.

Cheers,
Longman


