Return-Path: <linux-kernel+bounces-58990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03C84EF78
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682652887A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1325953A9;
	Fri,  9 Feb 2024 03:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Md4fTCu/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75785221
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 03:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707450353; cv=none; b=M8FaZiBBwrfhpsvX7eZqMTxHicpsb6wdb4X12BRIb6sf+u1kjzqUQuYOrq+v6NNKjSwOzM4lQRUuq/ileF4O4KetnxhCdVYDUdSLUnQstj3Qv0An9Poyp+NKv2ujcQ/gFU/jTwl0KUrYLkOvY1Podw2RZWkg82TOZKLnBnRLHvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707450353; c=relaxed/simple;
	bh=KYXq3vsFg9agxeweIpZT8Hkb1gjVOc3XU0BDt7CEye4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUWNgfMQ9kA+6/LQnGV4WVjaB0zV3uS7N6U6YtQP6zPn3FrWMSuFHlCMtqywOmo4pQZUtxmojuZgBKQDYfzIe5xlSx6qclxl6VVtGZXfPvOSee7v38bysCIwid8XL+Q8Lnc3YO7XzxBlJA2xwvKpt1h4SDqcaFrQJag/CeJLN6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Md4fTCu/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707450350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=en4CRu6uro7HIccHAz5xaJYPbyqAmpdG3f5ewbgFR/4=;
	b=Md4fTCu/mG9B+DOm7UQarC8OZS/5aaL9miDIJouvdr05ejwqVDzIzYhsQQvuomVBPl1KYs
	t1mCRaEgacfeDkU1juPUIZLAlKX9RsMTnTUw+w2ORl2S7KOCJdpj8MuSm0pCDmJyaJcGlJ
	t/ezigbRFb1BteRsmmEg5+MUvXE0Pcc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-zfXdj_9sNpWk3gvZOpAftQ-1; Thu, 08 Feb 2024 22:45:46 -0500
X-MC-Unique: zfXdj_9sNpWk3gvZOpAftQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FD7785A58C;
	Fri,  9 Feb 2024 03:45:46 +0000 (UTC)
Received: from [10.22.8.4] (unknown [10.22.8.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DACF32166B32;
	Fri,  9 Feb 2024 03:45:45 +0000 (UTC)
Message-ID: <45d11189-3ca2-422f-89dc-d33f6ee33f7d@redhat.com>
Date: Thu, 8 Feb 2024 22:45:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the workqueues tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240209142432.05acc1b2@canb.auug.org.au>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240209142432.05acc1b2@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 2/8/24 22:24, Stephen Rothwell wrote:
> Hi all,
>
> After merging the workqueues tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Documentation/core-api/workqueue:778: kernel/workqueue.c:1801: WARNING: Line block ends without a blank line.
> Documentation/core-api/workqueue:778: kernel/workqueue.c:1804: WARNING: Line block ends without a blank line.
>
> Introduced by commit
>
>    4c065dbce1e8 ("workqueue: Enable unbound cpumask update on ordered workqueues")

That warning is likely by the following function comment:

/**
  * unplug_oldest_pwq - restart an oldest plugged pool_workqueue
  * @wq: workqueue_struct to be restarted
  *
  * pwq's are linked into wq->pwqs with the oldest first. For ordered
  * workqueues, only the oldest pwq is unplugged, the others are plugged to
  * suspend execution until the oldest one is drained. When this 
happens, the
  * next oldest one (first plugged pwq in iteration) will be unplugged to
  * restart work item execution to ensure proper work item ordering.
  *
  *    dfl_pwq --------------+     [P] - plugged
  *                          |
  *                          v
  *    pwqs -> A -> B [P] -> C [P] (newest)
  *            |    |        |
  *            1    3        5
  *            |    |        |
  *            2    4        6
  */

One possible solution is to take out one '*' of the leading "/**" so 
that it is not regarded as an inline documentation block. Any other 
suggestion is welcome.

Cheers,
Longman


