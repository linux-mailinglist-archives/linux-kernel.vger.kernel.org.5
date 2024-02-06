Return-Path: <linux-kernel+bounces-54138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8559884AB61
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7E01C23753
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC2D4A15;
	Tue,  6 Feb 2024 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeAa6s+R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8634A06
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181672; cv=none; b=iShUNS70bVSRpQzM3y7i7g/mGIfutAuDz/qdUcxcFfn1FejEEutkAqR6b05A7Ddtqyiwja3t5/K8DAmAUK5x4+bjLQJovFXOg0hE8MIkjai/x01LCnLd3GKTmUOBenjtJ7KmqabSBFFWqji/Un2GGajE56VTA75FkM/KWN9mgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181672; c=relaxed/simple;
	bh=DP4FmgXcccO+rK4IKEraucp1wQntMzDreh9T6ETZ8oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBlPz23Qt4PmVbTaxQ/CdBQFnWmWGxi6Q9wljDDRrxlLAzK+ARvegPK9KADiizhYrOwQSip/VaprYJlrDJbe2mA0DLkQFXfdaX1vH2B9TjFuX1S+UyIBkeK+bYrWyT3bk6wwhdCtoeuwEPBvmrtXEh6reU0LeyDGVMplWk2idl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeAa6s+R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707181669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx0YFEsgX9UDCD0E+Npx4uOUY3x3FOt3qs6zB+rlWnE=;
	b=QeAa6s+R9TbrX50hVSrrPBfE9Mcfstrrl6CRMRbzRlKdDsaxi4Gtlu5/6+8DYPKNSHq+YA
	L/nBsfJQYndg0zyiTN0RUnb6dnvEyBcrZMGFxSMSpyegoms8cpNPOnVTiug8/8jlEEmIMd
	VCatpFLvQ+5MjbAYXumJK4JfBAwB810=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-Hp_jRAt_OQqpQogeRMuzng-1; Mon,
 05 Feb 2024 20:07:45 -0500
X-MC-Unique: Hp_jRAt_OQqpQogeRMuzng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 491113C11C62;
	Tue,  6 Feb 2024 01:07:45 +0000 (UTC)
Received: from [10.22.17.212] (unknown [10.22.17.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D17DBC0FDEF;
	Tue,  6 Feb 2024 01:07:44 +0000 (UTC)
Message-ID: <166aca9d-d4f2-4057-9fc4-e551114e97b8@redhat.com>
Date: Mon, 5 Feb 2024 20:07:44 -0500
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


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

OK, I saw your new commit 3bc1e711c26b ("workqueue: Don't implicitly 
make UNBOUND workqueues w/ @max_active==1 ordered") in the for-6.9 
branch. Will rebase my patch series on top of that and make the 
necessary modification.

Thanks,
Longman



