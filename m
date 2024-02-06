Return-Path: <linux-kernel+bounces-54149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5B84AB86
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDC91C23B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9319A139D;
	Tue,  6 Feb 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlftpUEt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BF1113
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182653; cv=none; b=aiBBJqZrJ1nDA3OCpjrmItmyB2WR1b9GWHkkPFXWU2L8RO8eYiNeXIRDn2KL+nAfZzyzVy3kk30RZ8/FAlWHg0hHtDVNwKJ5II9u05nlYPas9ev3pPMpXvufF9j0fAXjl9UUPMe71u7vjOit0qEID7qKN6eHm/ZPwto4J8LMhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182653; c=relaxed/simple;
	bh=VXzOZc4vStdTE6t2Oi4yAIKYdKGrqAEWrs21RG9yHiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efDPa4g4EaEmOW2VUbipWG9X3tVnDj+Ll0pr1BAwWIuzywYL3jnmRAGicMaLzmiFIjialshSwK9ILhejRKik2pFySG5vM5BOxkkDlWBCIeRtTluod2rG12Jjjpn1k54jU3nQKwJ6uFl0JV6uOhExQUtZ/vVSijxcaqfLWWAbHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlftpUEt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707182650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OobGLijtb3dnc1pP7/J4GgG3dmB8XmvivQA2oHRpQrc=;
	b=hlftpUEtEQ420T8ugvC1stuF3X5EJwMns0nIXAM+3hXT12eH5qANPa+awIPU5nNnCm7Uuo
	GQoZ+HRwKhxGdkS/RmDhLINpSnulcQckfK6gjSiLwcODRDVZlRIyo15lf4KEtfAGU0KVNx
	mgs29V6HdtfHTVb636upDmGzd9pvOiM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-VjKfTTdyNK-gY-nlkk_w_A-1; Mon,
 05 Feb 2024 20:24:07 -0500
X-MC-Unique: VjKfTTdyNK-gY-nlkk_w_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33FB83C29A63;
	Tue,  6 Feb 2024 01:24:07 +0000 (UTC)
Received: from [10.22.17.212] (unknown [10.22.17.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C40382026D66;
	Tue,  6 Feb 2024 01:24:06 +0000 (UTC)
Message-ID: <35ec9009-52eb-40aa-bf7a-db7a451d3652@redhat.com>
Date: Mon, 5 Feb 2024 20:24:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-wq v3 0/4] workqueue: Enable unbound cpumask update on
 ordered workqueues
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Cestmir Kalina <ckalina@redhat.com>,
 Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
 Costa Shulyupin <cshulyup@redhat.com>
References: <20240205194602.871505-1-longman@redhat.com>
 <ZcE8pUuHfa7gVZs6@slm.duckdns.org> <ZcF3qmion7H6qyYY@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZcF3qmion7H6qyYY@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


On 2/5/24 19:04, Tejun Heo wrote:
> On Mon, Feb 05, 2024 at 09:53:09AM -1000, Tejun Heo wrote:
>> On Mon, Feb 05, 2024 at 02:45:58PM -0500, Waiman Long wrote:
>>>   v3:
>>>    - [v2] https://lore.kernel.org/lkml/20240203154334.791910-1-longman@redhat.com/
>>>    - Drop patch 1 as it has been merged into the for-6.9 branch.
>>>    - Use rcu_access_pointer() to access wq->dfl_pwq.
>>>    - Use RCU protection instead of acquiring wq->mutex in
>>>      apply_wqattrs_cleanup().
>> Looks like we raced each other. I'll wait for v4.
> BTW, please don't bother to handle __WQ_ORDERED being cleared. We are very
> close to removing the implicit ORDERED promotion, so we should be able to
> apply the patch to remove the distinction between explicitly and implicitly
> ordered workqueues.

BTW, the workqueue.c file in your latest for-6.9 branch still has a 
reference to __WQ_ORDERED_EXPLICIT in workqueue_apply_unbound_cpumask(). 
Will that break compilation?

Regards,
Longman


