Return-Path: <linux-kernel+bounces-168337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93FC8BB6EF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD1D1F25666
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA2E5B5D3;
	Fri,  3 May 2024 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dL58ZFmd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43AF59161
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774427; cv=none; b=ELz+RUfM76Jzxc+zEXugTQxnMmm7pLOb5GP/enGLeog1tLLtsHmomjDjt18MzUZY4nE5bgODQ5jX07JwFYPOoE11vrUdq8uQM/JJmKEygwVjaCbrBoUAhiCCy0C4tgu/LZvlVxEeiYyLqhQuc4DUX6OMhEhH5T7rWolJkiQT1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774427; c=relaxed/simple;
	bh=HbGa2OPDrW1btTMtK6Lox9/dGpxHQnDUa2fRGEVQEH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knQ4+H72jDenMoEUduCRmmZhz7qvP1nUvdH4csUUBc8hY6KaECYfrhSiO/0dp9ZZ2gocUwnHi+CRIc1sYO3nHbUMzTvLd9BN80yAg6f2EWs+GtO7SP4xYwxmO8mQDjJrrhiZcsW1r1Q+gtSMIs2QDJfGw57r9amnf0Vqtk6vwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dL58ZFmd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714774424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXJGg6Yv+cev4+++4ag1dpaYqLQ1DRjklZr5exWF9PQ=;
	b=dL58ZFmdQf1+tFk8zK3GQOZh7742LrDbVes2ukBzz2NGpXvZfOSUfN6oYsisPOpf16ycD/
	9Q4yPme/UpBmpFKRFWhsDLcBp4aKw43XV4KoCrNxm+82d7Z8nAiN+rryGYTvj0qv2vXYKb
	TN1iadw3TaVCIhr8jsGt7cue4jhLnZs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-ZoJOM9MwNsKw103QBC28Mw-1; Fri,
 03 May 2024 18:13:39 -0400
X-MC-Unique: ZoJOM9MwNsKw103QBC28Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23E9B29AB3F5;
	Fri,  3 May 2024 22:13:39 +0000 (UTC)
Received: from [10.22.34.156] (unknown [10.22.34.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 67F5540C140B;
	Fri,  3 May 2024 22:13:38 +0000 (UTC)
Message-ID: <8373c730-2e08-4abb-8d21-fd9a76116d2c@redhat.com>
Date: Fri, 3 May 2024 18:13:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
To: David Laight <David.Laight@ACULAB.COM>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'peterz@infradead.org'" <peterz@infradead.org>
Cc: "'mingo@redhat.com'" <mingo@redhat.com>,
 "'will@kernel.org'" <will@kernel.org>,
 "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 "'virtualization@lists.linux-foundation.org'"
 <virtualization@lists.linux-foundation.org>,
 'Zeng Heng' <zengheng4@huawei.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
 <9d4024ba-6422-4775-b934-bfa80a72a858@redhat.com>
 <16557e30-8353-4cd1-995b-23ec763d2b07@redhat.com>
 <a2c35933c3de481faec0b201ab1a0c16@AcuMS.aculab.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <a2c35933c3de481faec0b201ab1a0c16@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


On 5/3/24 17:10, David Laight wrote:
> From: Waiman Long
>> Sent: 03 May 2024 17:00
> ...
>> David,
>>
>> Could you respin the series based on the latest upstream code?
> I've just reapplied the patches to 'master' and they all apply
> cleanly and diffing the new patches to the old ones gives no differences.
> So I think they should still apply.
>
> Were you seeing a specific problem?
>
> I don't remember any suggested changed either.
> (Apart from a very local variable I used to keep a patch isolated.)

No, I just want to make sure that your patches will still apply. Anyway, 
it will be easier for the maintainer to merge your remaining patches if 
you can send out a new version even if they are almost the same as the 
old ones.

Thanks,
Longman


