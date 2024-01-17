Return-Path: <linux-kernel+bounces-29365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7E4830D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817381F238AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F90D249ED;
	Wed, 17 Jan 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fe71WRyB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5456249E0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705519961; cv=none; b=GkUTssn9SlYwFRYSj1IEmnhw0KjgR3pr0Ick6xdfvE2uCMpGk1Ri0WpV0ColVWgD/ALfD/5DZ6/p12aqTVq8v57A52CTRKsuJ8Ok6V0F028saXAbBT02RSiXgmmYuRPsFVV5Nm0QWOPw3Fnvwi2MWsy+AG8W9ea9wzQUxBtInqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705519961; c=relaxed/simple;
	bh=QvqQHYPeITGXtLTPrNEHN+dZrrNa20vk0SDYMEEzQq4=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By; b=IRff2r3ATOJ/5WkaXxi3XhFD2oJlnwxUUCrNpVm3t9C/DPh7DId/Of5/9mK9U0D/ldFETmEK3wocPkgpPCPCq/FMFUJR4vBP7jDVaopHuULnOIGLn4W4wXDRxTAAocBiuBP/xTCj7yjSU5Hjaviw928sZaC4JtHmciLB6tzY914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fe71WRyB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705519958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfUgfGTy5yRHGk/lV0Z6rRdd4H0q3HaJTSR3wYzs52E=;
	b=fe71WRyBxTlp+DXlJthRFj9nUaPQrS8lygIZgqViCnLD3ThMZhFFvb7PWrsJI1Ygoowc5D
	T6ZS8I8udS3HudbU164lqGaRAeN682GIupkBgAKEaU8bNtmUqIZuZSTuJ5WXkldV9M9BjL
	wCNVZyRGDE4j66f9Xz4lXFpj+zopSU0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-Gayb9gvBNdCBCNZGvG7HOQ-1; Wed,
 17 Jan 2024 14:32:35 -0500
X-MC-Unique: Gayb9gvBNdCBCNZGvG7HOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EF1A2806400;
	Wed, 17 Jan 2024 19:32:35 +0000 (UTC)
Received: from [10.22.16.147] (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AE540FEEE;
	Wed, 17 Jan 2024 19:32:34 +0000 (UTC)
Message-ID: <72e4a971-96e5-44b7-b348-bbdb68e54b40@redhat.com>
Date: Wed, 17 Jan 2024 14:32:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] kernel/workqueue: Distinguish between general
 unbound and WQ_SYSFS cpumask changes
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Aaron Tomlin
 <atomlin@atomlin.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240116161929.232885-1-juri.lelli@redhat.com>
 <20240116161929.232885-4-juri.lelli@redhat.com>
 <ZabRlEklmuqwFPj-@slm.duckdns.org> <ZafQwMw8ZKztunMU@localhost.localdomain>
 <ZagKbRlBxZHsKiw5@mtj.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZagKbRlBxZHsKiw5@mtj.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


On 1/17/24 12:12, Tejun Heo wrote:
> Hello,
>
> On Wed, Jan 17, 2024 at 02:06:08PM +0100, Juri Lelli wrote:
>>> This looks rather hacky. Can you elaborate how the current code misbehaves
>>> with an example?
>> I was trying to address the fact that ordered unbound workqueues didn't
>> seem to reflect unbound_cpumask changes, e.g.
>>
>> wq_unbound_cpumask=00000003
>>
>> edac-poller              ordered,E  0xffffffff 000000ff      kworker/R-edac-            351 0xffffffff 000000ff
>>
>> vs.
>>
>> edac-poller              ordered,E  00000003                 kworker/R-edac-            349 00000003
>>
>> with the patch applied. But honestly, I'm now also not convinced what
>> I'm proposing is correct, so I'll need to think more about it.
>>
>> Can you please confirm though that ordered unbound workqueues are not
>> "special" for some reason and we would like them to follow
>> unbound_cpumask changes as normal ubound workqueues?
> They aren't special and should follow the normal unbound workqueue cpumask.

My impression is that changing the workqueue cpumask of ordered unbound 
workqueue may break the ordering guarantee momentarily. I was planning 
to look into this further to see if that is true when I have time. If it 
is not a concern, we should certainly apply the global unbound cpumask 
change to those workqueues as well.

Cheers,
Longman


