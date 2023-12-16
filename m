Return-Path: <linux-kernel+bounces-1927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0648155F9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F701F254C6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A9C110E;
	Sat, 16 Dec 2023 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9WJRJFn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23C10F1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702690258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVlrB+oQEuOU8B0i3W32kFhArbOa2dYtoStKRM7GlpY=;
	b=W9WJRJFnuUiWd+DO7n661VgqGVaZ0ynLPydF4uwu3fjtFgeUiNluigUn8AQV+ravQuj1Zm
	l+WVq0+Tt/6q+6vUj22Mzz6lnD5GouimIMLuvbaKaqWndMK29BPvJXRQBncHpaQlbyWbBg
	eX7+Cq82kxVJNiPLDNq4RPNMFRS9iN8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-swiyUIjUOvCYb61XDJkKDw-1; Fri,
 15 Dec 2023 20:30:54 -0500
X-MC-Unique: swiyUIjUOvCYb61XDJkKDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66A9329AB3E0;
	Sat, 16 Dec 2023 01:30:53 +0000 (UTC)
Received: from [10.22.9.217] (unknown [10.22.9.217])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F2B942166B31;
	Sat, 16 Dec 2023 01:30:51 +0000 (UTC)
Message-ID: <550a22b0-dfc9-427f-bbf0-3c6854e9867d@redhat.com>
Date: Fri, 15 Dec 2023 20:30:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4-bis] locking: introduce devm_mutex_init
Content-Language: en-US
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au,
 npiggin@gmail.com, hdegoede@redhat.com, mazziesaccount@gmail.com,
 peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 boqun.feng@gmail.com, nikitos.tr@gmail.com,
 George Stark <gnstark@salutedevices.com>, kernel@salutedevices.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20231214173614.2820929-3-gnstark@salutedevices.com>
 <c16599b23afa853a44d13b906af5683027959a26.1702621174.git.christophe.leroy@csgroup.eu>
 <CAHp75VfBcmTBXXtU6o1x0Ea24wG-_Qb46opkS0EXKQ1Ynh0Mcw@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAHp75VfBcmTBXXtU6o1x0Ea24wG-_Qb46opkS0EXKQ1Ynh0Mcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 12/15/23 10:58, Andy Shevchenko wrote:
> On Fri, Dec 15, 2023 at 8:23 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>> From: George Stark <gnstark@salutedevices.com>
>>
>> Using of devm API leads to a certain order of releasing resources.
>> So all dependent resources which are not devm-wrapped should be deleted
>> with respect to devm-release order. Mutex is one of such objects that
>> often is bound to other resources and has no own devm wrapping.
>> Since mutex_destroy() actually does nothing in non-debug builds
>> frequently calling mutex_destroy() is just ignored which is safe for now
>> but wrong formally and can lead to a problem if mutex_destroy() will be
>> extended so introduce devm_mutex_init()
> Missing period.
>
> ...
>
>>   } while (0)
>>   #endif /* CONFIG_PREEMPT_RT */
> ^^^ (1)
>
>> +struct device;
>> +
>> +/*
>> + * devm_mutex_init() registers a function that calls mutex_destroy()
>> + * when the ressource is released.
>> + *
>> + * When mutex_destroy() is a not, there is no need to register that
>> + * function.
>> + */
>> +#ifdef CONFIG_DEBUG_MUTEXES
> Shouldn't this be
>
> #if defined(CONFIG_DEBUG_MUTEXES) && !defined(CONFIG_PREEMPT_RT)
>
> (see (1) as well)?

CONFIG_DEBUG_MUTEXES and CONFIG_PREEMPT_RT are mutually exclusive. At 
most one of them can be set.

Cheers,
Longman


