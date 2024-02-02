Return-Path: <linux-kernel+bounces-50459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAF7847933
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CAC1C24010
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A8715E5A2;
	Fri,  2 Feb 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+eLWkV9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE9F80606
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900621; cv=none; b=qulavum6C6Be/PtyznjmtKxx7IuffiDeQIVE3pxcveNwpHMWKV1fhCpN3h2D9nUu3znIkCxmFluUH0Ye3f1BK8lNIHgWWGKdpGaNDfMPX5rRMTIQXkUC1MJytdJr+YOh2KhvP45qHwP3rZ1JhnyjClH3GCXTdfSz0MdKQQwsvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900621; c=relaxed/simple;
	bh=THucXeFWcPzmw3jP+HY8jU1LiVqzxkWuYIlkaZfJ2aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdYCIRo5QAo/XDs+DbxuEHWQB29LCH7NHrTzEFGK52E0i5XC++FHjS7jjFT9j8RhNGETwfA5fQ7pjXEL7t0ZD0093Wq96Dv/S6iHaTgrMdDybGSdkq7GMzr59ZPOKF2Yw0bgd5Tk8CYk+JbgSHYrJDXb2Ha9dsWDcv1YRi/8KaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+eLWkV9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706900618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yDvvsTWw5M0ROiUn+I4EVM05VQE2w9cB0Y2ALAs0Xc=;
	b=Y+eLWkV96ylKNGohic2d5FXmoH3TejPiUMWPA019slBnzVhCqBqdgOv11ggtd50gpoAG4y
	K/lpH5tEYbgDUV65tTZLmyPHyIVabOcAxhy9rrxmkKdSYAKIs44R9Kp+Dz/YAu32w9yYWM
	szr+Icqjcn4AvUh7NFdwCUsYMbCTCqI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-jgR1ydyLMGuDveUw2H50Rg-1; Fri, 02 Feb 2024 14:03:37 -0500
X-MC-Unique: jgR1ydyLMGuDveUw2H50Rg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADDCE185A780;
	Fri,  2 Feb 2024 19:03:36 +0000 (UTC)
Received: from [10.22.17.111] (unknown [10.22.17.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BAC41C060AF;
	Fri,  2 Feb 2024 19:03:36 +0000 (UTC)
Message-ID: <d7adf125-52d2-47b1-9abb-c2c085eb5382@redhat.com>
Date: Fri, 2 Feb 2024 14:03:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] workqueue: Enable unbound cpumask update on
 ordered workqueues
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
 Cestmir Kalina <ckalina@redhat.com>, Alex Gladkov <agladkov@redhat.com>
References: <20240130183336.511948-1-longman@redhat.com>
 <ZbpElS5sQV_o9NG1@localhost.localdomain>
 <89927d84-279a-492e-83d3-6d3e20b722f7@redhat.com>
 <Zbtv4v2KCKshnCL2@localhost.localdomain>
 <ff2c0ce1-4d40-4661-8d74-c1d81ff505ec@redhat.com>
 <Zb0CU2OrTCv457Wo@localhost.localdomain> <Zb0hXLDlXmfmn_Yw@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zb0hXLDlXmfmn_Yw@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 2/2/24 12:07, Tejun Heo wrote:
> Hello,
>
> On Fri, Feb 02, 2024 at 03:55:15PM +0100, Juri Lelli wrote:
>> Indeed. I believe this is what my 3/4 [1] was trying to cure, though. I
>> still think that with current code the new_attr->cpumask gets first
>> correctly initialized considering unbound_cpumask
>>
>> apply_wqattrs_prepare ->
>>    copy_workqueue_attrs(new_attrs, attrs);
>>    wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
>>
>> but then overwritten further below using cpu_possible_mask
>>
>> apply_wqattrs_prepare ->
>>    copy_workqueue_attrs(new_attrs, attrs);
>>    cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);
>>
>> operation that I honestly seem to still fail to grasp why we need to do.
>> :)
> So, imagine the following scenario on a system with four CPUs:
>
> 1. Initially both wq_unbound_cpumask and wq A's cpumask are 0xf.
>
> 2. wq_unbound_cpumask is set to 0x3. A's effective is 0x3.
>
> 3. A's cpumask is set to 0xe, A's effective is 0x3.
>
> 4. wq_unbound_cpumask is restore to 0xf. A's effective should become 0xe.
>
> The reason why we're saving what user requested rather than effective is to
> be able to do #4 so that the effective is always what's currently allowed
> from what the user specified for the workqueue.
>
> Now, if you want the current effective cpumask, that always coincides with
> the workqueue's dfl_pwq's __pod_cpumask and if you look at the current
> wq/for-6.9 branch, that's accessible through unbound_effective_cpumask()
> helper.

Thank for the explanation, we will use the new 
unbound_effective_cpumask() helper. It does look like there is a major 
restructuring of the workqueue code in 6.9. I will adapt my patch series 
to be based on the for-6.9 branch.

Cheers,
Longman


