Return-Path: <linux-kernel+bounces-62909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9688527BF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCED285A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAFBA923;
	Tue, 13 Feb 2024 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0Jmgzuf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB68F45
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794925; cv=none; b=B0swbbw42NTmKywM4G3CMKz1y4HQmz+qZFYrQjOuRcOA2TfCs+/78wrChTX/hpp6V62MLXjeybriOm9xiiTU4Tm/figUY91BRB3JUgGqkzoCD3nOCXQffepSCBw76GT8nDViaWstX81fGjoG0KO3c7aFBuFcyhu29LViAls0/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794925; c=relaxed/simple;
	bh=w89UxfyV9E96tI1Kth/qtwIA4elDphzZr87V/PV2G7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqHbhM5dZDVJvUOMzqE+PdtV380Kkbh2eUK6zBvLlavRjpQhDOrp8gnRbtB83N8SusmiRDdpl8MF1M17TKw5T9r0QboTZUn2H8kBEWCsz8v4x18PpiHSq/e/qa3ptZhtQBsj1sapDHOzwSm9cn8jnohSK22lpsnUpP+gjv6yGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0Jmgzuf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707794923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tc2HR3uaoQ354WpZiDJS4lzYU+PnPEat7AqBvHrYLOk=;
	b=X0JmgzufjHS48vJBV8k/iSOVGTPzx0+q46nDbAWasUAGCD39mZ2xuiK6+wFF2cVB7R2y4Y
	kNeXgUoi/tFW/S23pD3zJ3MRuo56I0w1gGfq5PhIDJYe7kfQ6THwEy73/gjTJIn9KOHI6L
	tFEu6dBYJ7KUIjxqVTnjwIqOTW7VJK8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-lKlC188kP6uCWDuqEMXdcg-1; Mon,
 12 Feb 2024 22:28:39 -0500
X-MC-Unique: lKlC188kP6uCWDuqEMXdcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEE3229AC010;
	Tue, 13 Feb 2024 03:28:38 +0000 (UTC)
Received: from [10.22.33.62] (unknown [10.22.33.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 58AB71121312;
	Tue, 13 Feb 2024 03:28:37 +0000 (UTC)
Message-ID: <a8313e5d-c4f2-4f4c-a05e-b87b2d694901@redhat.com>
Date: Mon, 12 Feb 2024 22:28:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] locking/mutex: Clean up mutex.h
Content-Language: en-US
To: George Stark <gnstark@salutedevices.com>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: gregkh@linuxfoundation.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@salutedevices.com" <kernel@salutedevices.com>
References: <20231216013656.1382213-1-longman@redhat.com>
 <8be5bc9d-9505-41c6-b2ca-654bfe1d809f@salutedevices.com>
 <22c625f9-1750-4ade-b9c7-27b608c7f653@salutedevices.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <22c625f9-1750-4ade-b9c7-27b608c7f653@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


On 2/11/24 18:28, George Stark wrote:
> Hello
>
> Excuse me, this is my 4th letter here since December 2023 and there's 
> no response unfortunately.
>
>
> Just to recall that we had the discussion in December 2023 about 
> implementing devm_mutex_init. We came to conclusion that the only 
> effective way to do it in include/linux/mutex.h but mutex.h requires
> some cleanups to simplify the devm_mutex_init patch.
> mutex.h owners proposed such a cleanup patch themselves and there's no 
> progress since that. How can we move forward on those patches?
>
> Cleanup patch:
> https://lore.kernel.org/lkml/20231216013656.1382213-1-longman@redhat.com/
>
> Original problem that requires devm_mutex_init and discussion:
> https://lore.kernel.org/lkml/ZcZeRmVjEPhVPW9-@smile.fi.intel.com/T/#m0f514f8f96e18db9568f84b2df37aaf648874a4a 
>

Sorry for my late reply. My cleanup patch was sent at the later half of 
Dec 2023. It is probably not a good time as maintainers are either busy 
or taking time off. I have resent the patch again with other cleanup 
patches. Hopefully those patches can be merged soon.

Cheers,
Longman


