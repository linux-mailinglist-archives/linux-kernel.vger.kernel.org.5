Return-Path: <linux-kernel+bounces-42218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A49183FE10
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C573B22940
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412E4C63F;
	Mon, 29 Jan 2024 06:15:30 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F64C3D4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508929; cv=none; b=kBJvtwEAMMvJ5qZMXVdlGRsUC8nam/zdc5a4zYoFNcVtzVfwZc9WK2Yj0kLAR3ZJqCml4AC0XuqZcwtHL2nmA2WNplxeqz6up6vnObUI8JbHAkWG6VLp7cOOr6PykSloUhX0K69mCNx73kwb8MwA2yvIdZeaN0+SOyKWD0VDGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508929; c=relaxed/simple;
	bh=k0mAZNrg4BsgnhFM7qwsAaKaHvudR4Cu4AygmjqhslY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rb3KxKfMsWqYdpjjiT/iyYb9YkSD8PcLyRrlYvAIykqeE0pcM8U0S58fiUZVZg7f81+bINgQzJ7c7fWQkzvnXayvsoc0hC8U9YrxJbZg2UKps4wAtUp3YhQHTEkBNyXgXn1psAAYrFlIsabo5EhQcmgGEBDh12cHA9//yTTFG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from [192.168.255.10] (unknown [61.151.228.150])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 666237E010A;
	Mon, 29 Jan 2024 14:15:02 +0800 (CST)
Message-ID: <0e99b72c-c3d9-424e-8efe-af750da69ebf@ustc.edu>
Date: Mon, 29 Jan 2024 14:15:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mempolicy: check home_node is in the nodes of policy
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240126132240.24518-1-luochunsheng@ustc.edu>
 <20240128002942.b0dbede1fcc4b80d2a398d15@linux-foundation.org>
From: ustc <luochunsheng@ustc.edu>
In-Reply-To: <20240128002942.b0dbede1fcc4b80d2a398d15@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEtPVh5DGh8aGkpOQhpPH1UTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpOSlVJSUNVSk5LWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8d53db60b703a2kunm666237e010a
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pwg6Ojo4KjMPCAEJSyEzPRMN
	QwwKCQFVSlVKTEtNTktDQktITklLVTMWGhIXVRcOFBgTDhUIEx4VHDsOCA8YVR4fDkVZV1kSC1lB
	WU1KVUpOSlVJSUNVSk5LWVdZCAFZQUpDTEs3Bg++

For example,  In a system with NUMA nodes 0,1,2,3, i mbind process to 
node 0-2 and set home_node to node 3, it will not be allocated from node 
3, then from node closer to node 3. But i think home_node should be set 
directly from node 0-2, which makes more sense. So i think it needs to 
return failure to prompt user.


On 2024/1/28 16:29, Andrew Morton wrote:
> On Fri, 26 Jan 2024 08:22:40 -0500 Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>
>> set_mempolicy_home_node should be used after setting the memory
>> policy. If the home_node isn't in the nodes of policy, we should
>> return failure to avoid misunderstanding.
> Thanks.  Under what circumstances does userspace trigger this issue?
>

