Return-Path: <linux-kernel+bounces-131280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C01A8985A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06237287549
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B482D7A;
	Thu,  4 Apr 2024 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDTYor3G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87A59157;
	Thu,  4 Apr 2024 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228603; cv=none; b=ToI6yNP5lZpEIh5xL6BwrhOKoD+2MxV/AjM/nvJuWiNqqbG0Fut8r9M9ZeglaXZSz2llVRJrVWtcZ/rBtcNF+V8EpNB+t7p3Scu+m/No177aVdQaqkKfUEbrXHJOHjGl5YC40kN3pN/yOQSGELcsgkeIPDRiWLE0bb8YblhuDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228603; c=relaxed/simple;
	bh=Q14ggXy+y0e4OfUSS6sgHf6RZqlI/EP8PYD1AXlxvVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOuCjVJ2ZwihhIrWa7OHKccsNQeGGMaXO3XM1jYpaWN5bfE4GtEOlYayaQOq5SdXKtYMajN2BQVYwEqvra2PcD2c66ZXo09VhvteZiTQfyVsuQuy604wiUDozzrroHLhzUJQg8bHAfohRfMzDO4w4knG3bzzs+TZQt4vOIbv+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDTYor3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60563C43399;
	Thu,  4 Apr 2024 11:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712228603;
	bh=Q14ggXy+y0e4OfUSS6sgHf6RZqlI/EP8PYD1AXlxvVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mDTYor3GUqTiqx1mWDSXkEV1Vnm/cCTGnTl1eKZLn9l72ZgLAzRW16KGZ893QZmTJ
	 HjHO8kjaJGFOGhC3oEJJq2/b0EkcS3b5UYeX0VJNn2GrLx8HfcnUhtMnNLkZJrpUd2
	 AVuWLxDc80BMc4FEf6eSiWhhugSKsktgkAx7DZ8fgGXez1BC8W7gbDQIHk2qDLPNhi
	 0HJ1LJCtDWGJJJ+0LQNfepO0MP4gXqM+5r44jJGWFea4furiWM8VIcH0RiSHZeoOXl
	 Xj2RUHZGAmPFb2FxejqTvEJWWHaWHt5S5AVI3AUlYmyFtv8XC6UJ8tk+lFDUo556nH
	 feq2HzpO7cx1g==
Message-ID: <15064d90-e89d-4522-90a8-52aad643d7c8@kernel.org>
Date: Thu, 4 Apr 2024 13:03:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: fix null ptr deref in dev_map_enqueue
To: Edward Adam Davis <eadavis@qq.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzbot+af9492708df9797198d6@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <f45ad3e1-4433-422e-be28-17deaba4ade1@kernel.org>
 <tencent_A4FA0DA89270DDAC5D8519424F9B0DB42507@qq.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <tencent_A4FA0DA89270DDAC5D8519424F9B0DB42507@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/04/2024 05.03, Edward Adam Davis wrote:
> On Mon, 1 Apr 2024 13:00:12 +0200, Jesper Dangaard Brouer wrote:
>>> [Fix]
>>> On the execution path of bpf_prog_test_run(), due to ri->map being NULL,
>>> ri->tgtvalue was not set correctly.
>>>
>>> Reported-and-tested-by:syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
>>> Signed-off-by: Edward Adam Davis<eadavis@qq.com>
>>> ---
>>>    kernel/bpf/devmap.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>>> index 4e2cdbb5629f..ef20de14154a 100644
>>> --- a/kernel/bpf/devmap.c
>>> +++ b/kernel/bpf/devmap.c
>>> @@ -86,6 +86,7 @@ struct bpf_dtab {
>>>    static DEFINE_PER_CPU(struct list_head, dev_flush_list);
>>>    static DEFINE_SPINLOCK(dev_map_lock);
>>>    static LIST_HEAD(dev_map_list);
>>> +static bool is_valid_dst(struct bpf_dtab_netdev *obj, struct xdp_frame *xdpf);
>>>
>>>    static struct hlist_head *dev_map_create_hash(unsigned int entries,
>>>    					      int numa_node)
>>> @@ -536,7 +537,10 @@ int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
>>>    int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
>>>    		    struct net_device *dev_rx)
>>>    {
>>> -	struct net_device *dev = dst->dev;
>>> +	struct net_device *dev;
>>> +	if (!is_valid_dst(dst, xdpf))
>> This is overkill, because __xdp_enqueue() already contains most of the
>> checks in is_valid_dst().
>>
>> Why not:
>>
>>    if (!dst)
>> 	return -EINVAL;
> This can work, but I think is_valid_dst() is better, as its internal inspection
> of dst is more thorough.


No, is_valid_dst() is not better, because it will repeat almost same
checks (as I said) as __xdp_enqueue() already contains these checks.
This is fast-path code, we don't want to repeat checks.

--Jesper
(copy-pasted function below to easier compare)

static inline int __xdp_enqueue(struct net_device *dev, struct xdp_frame 
*xdpf,
				struct net_device *dev_rx,
				struct bpf_prog *xdp_prog)
{
	int err;

	if (!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT))
		return -EOPNOTSUPP;

	if (unlikely(!(dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT_SG) &&
		     xdp_frame_has_frags(xdpf)))
		return -EOPNOTSUPP;

	err = xdp_ok_fwd_dev(dev, xdp_get_frame_len(xdpf));
	if (unlikely(err))
		return err;

	bq_enqueue(dev, xdpf, dev_rx, xdp_prog);
	return 0;
}


static bool is_valid_dst(struct bpf_dtab_netdev *obj, struct xdp_frame 
*xdpf)
{
	if (!obj)
		return false;

	if (!(obj->dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT))
		return false;

	if (unlikely(!(obj->dev->xdp_features & NETDEV_XDP_ACT_NDO_XMIT_SG) &&
		     xdp_frame_has_frags(xdpf)))
		return false;

	if (xdp_ok_fwd_dev(obj->dev, xdp_get_frame_len(xdpf)))
		return false;

	return true;
}



