Return-Path: <linux-kernel+bounces-58625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774C484E8F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3F82839AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4CE381D2;
	Thu,  8 Feb 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjKhU40J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF05374C3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420837; cv=none; b=FtTHxm45xnN3vxslCo6cb0QZdXQrA3l2mHYEEiV3WtnFSHWLQRnRe/WDQWN/M9/o2pYEtBkCaIbpX8aSSsWzCmJwbKllMGfwiM0cNJ3CbHybq0dsSGIDhIjirhKwTMej2K82lLsuVMyj57Y9WUEbL4lRzDqai+wXbQcMw/f39w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420837; c=relaxed/simple;
	bh=NqMEuaRPqrpIwVbPtLtad8belPEZHetFsrcHU0a/9bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHEPYA6GI8VmEBwiLmAiiUn4ewogq0wX/+wpk1MFr8CMMKX222u0kyEbssJfSo6vK9FgLJdQ+0FTN+yRlMI/9Zi2XA8STcUywE7D2rb9MRF0O4akH1SyWfw35SjnzfxWPi2qzcZjYuZ6o4OP7az5a9UqSSD+x4c1nAO5piECV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjKhU40J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707420834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3FC5ULp5dMmlADJ+vyVgtloEuiTVNBG5B3TkU5Z6UM=;
	b=EjKhU40JPiWDwv3LZQ66pkQaikY2PYfLvCoAOlvYFhWf0q4VBJsVX9AwrWjz2x8pd/v0O0
	FVldQREjtERiWPN4jzUlF/5p+Fwdawha4xWIGpWEdlWgraHvgPaWqxwVy4tuXYr/slo6JZ
	hoJDfvaCeWR1Y0dMsXIRvTlV3IUTFCc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-OvhzvZPUND-rvhiidWXQ3Q-1; Thu,
 08 Feb 2024 14:33:51 -0500
X-MC-Unique: OvhzvZPUND-rvhiidWXQ3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DF303C0BE4D;
	Thu,  8 Feb 2024 19:33:51 +0000 (UTC)
Received: from [10.22.8.4] (unknown [10.22.8.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A84A72028CD2;
	Thu,  8 Feb 2024 19:33:50 +0000 (UTC)
Message-ID: <d9319087-1e97-4a55-aaed-dbce8fe3b0f7@redhat.com>
Date: Thu, 8 Feb 2024 14:33:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wq/for-6.9 v5 0/4] workqueue: Enable unbound cpumask
 update on ordered workqueues
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Cestmir Kalina <ckalina@redhat.com>,
 Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
 Costa Shulyupin <cshulyup@redhat.com>
References: <20240208161014.1084943-1-longman@redhat.com>
 <ZcUq3VnputFml3LK@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZcUq3VnputFml3LK@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


On 2/8/24 14:26, Tejun Heo wrote:
> On Thu, Feb 08, 2024 at 11:10:10AM -0500, Waiman Long wrote:
>>   v5:
>>    - [v4] https://lore.kernel.org/lkml/20240207011911.975608-1-longman@redhat.com/
>>    - Streamline patch 2 by simplifying unplug_oldest_pwq() and calling it
>>      only in pwq_release_workfn().
>>
>>   v4:
>>    - [v3] https://lore.kernel.org/lkml/20240205194602.871505-1-longman@redhat.com/
>>    - Rebase on the latest for-6.9 branch again & discard the use of
>>      __WQ_ORDERED_EXPLICIT and resetting of __WQ_ORDERED.
>>    - Add a new patch 1 to change the ordering of pwq's in wq->pwqs from
>>      oldest to newest.
>>    - Change the terminalogy from freeze/thaw to plug/unplug.
>>    - Allow more than 2 pwq's in wq->pwqs of ordered workqueue but only the
>>      oldest one is unplugged. This eliminates the need to wait for
>>      the draining of extra pwq in workqueue_apply_unbound_cpumask().
>>
>>   v3:
>>    - [v2] https://lore.kernel.org/lkml/20240203154334.791910-1-longman@redhat.com/
>>    - Drop patch 1 as it has been merged into the for-6.9 branch.
>>    - Use rcu_access_pointer() to access wq->dfl_pwq.
>>    - Use RCU protection instead of acquiring wq->mutex in
>>      apply_wqattrs_cleanup().
> Applied the series w/ (w/ the updated second patch) to wq/for-6.9.
>
> Thanks for working on this. It's really great that this got solved finally.

Me too. Thanks for all the good suggestions that you had given me as I 
don't have a full understanding of all the different pieces of the 
workqueue code.

Cheers,
Longman


