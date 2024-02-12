Return-Path: <linux-kernel+bounces-61892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2918F8517E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DD1282029
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F553C48C;
	Mon, 12 Feb 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4yiV2VP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED43C478
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751610; cv=none; b=V+t35R5kYX24rzMy0GcbMKYN+kFq6HM18racbw12t9i73o+NhN9Bv+tGfofEbTNW3klqGuDATugafWcW3qAV3ZY+Fm69kJ/zCyAROz8uH8oD65kHn8tB+R6x7yyVl672s/GqAVfanFLAJcik+y+SnOzYPoaPYRWOQjZr9Lhgh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751610; c=relaxed/simple;
	bh=ylaC1wxOtmdVELv0CHaAgYwG4Tklp3Nu9mzaIJ8MpfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8k3/8pW3jfTq2pOOarZj99b3bnv2jcaKyjH4feGsA6wWNBAP/GAokxrKmfPOpMBwMUQNjHCrFw0kUz09BaqGgcdwIqSOSrWHxLYMYh3yXAGSdKGKM5rMM0Lfe6ENjoBooFriaVvEnlqkqap/ur3yM7BEVzUgk7HCqAuSRMaGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4yiV2VP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707751608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylaC1wxOtmdVELv0CHaAgYwG4Tklp3Nu9mzaIJ8MpfQ=;
	b=O4yiV2VPgGCJ9vZI2gJiZ+UDlOGtvImxFfdr6fvoDnIV09EVuqN84y9UMTrO6WA/OVcguv
	wEaAoi3wISQrgMNjj6xz9USXYu+wisRU1UAMjGJ7a0c1NRnIU7I9ASdWSs4AOFRAIISDfW
	tn1rJYHqCH8vCbPnbUhXbFg6DJZpggU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455--AT9ag3PPyGuW6Mt9zfYVg-1; Mon, 12 Feb 2024 10:26:46 -0500
X-MC-Unique: -AT9ag3PPyGuW6Mt9zfYVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1E9A108BE69;
	Mon, 12 Feb 2024 15:26:42 +0000 (UTC)
Received: from [10.22.33.62] (unknown [10.22.33.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8F192112B5;
	Mon, 12 Feb 2024 15:26:42 +0000 (UTC)
Message-ID: <8f8d5a2d-dde3-42e5-9988-fab042666f40@redhat.com>
Date: Mon, 12 Feb 2024 10:26:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Port hierarchical_{memory,swap}_limit cgroup1->cgroup2
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 "Jan Kratochvil (Azul)" <jkratochvil@azul.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <ZcmaPqZ9HzoN0GFM@host1.jankratochvil.net>
 <ked455hccs23ghrqug3ieqck6qmmlip5htgszjvz7n3cvhvaeo@7kkg6faezy2a>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ked455hccs23ghrqug3ieqck6qmmlip5htgszjvz7n3cvhvaeo@7kkg6faezy2a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


On 2/12/24 10:00, Michal Koutný wrote:
> Hello.
>
> Something like this would come quite handy.
>
> On Mon, Feb 12, 2024 at 12:10:38PM +0800, "Jan Kratochvil (Azul)" <jkratochvil@azul.com> wrote:
>> which are useful for userland to easily and performance-wise find out the
>> effective cgroup limits being applied.
> And the only way to figure out inside cgroupns.
>
>> But for cgroup2 it has been missing so far, this is just a copy-paste of the
>> cgroup1 code while changing s/memsw/swap/ as that is what cgroup1 vs. cgroup2
>> tracks. I have added it to the end of "memory.stat" to prevent possible
>> compatibility problems with existing code parsing that file.
> I was thinking of memory.max.effective (and others).
>
> - no need to (possibly flush) stats when reading memory.stat
> - can be generalized also for pids controller (and other "limiting" controllers)
> - analogous to precedent of cpuset.cpus.effective
>
> Whereas, using v1 approach in v2:
> - memory.stat mixes true stats and limits,
> - memmory.stat is hierarchical by default, no need for the prefix.
>
> What do you think of the separate .effective file(s)?

This is certainly a good alternative.

Cheers,
Longman



