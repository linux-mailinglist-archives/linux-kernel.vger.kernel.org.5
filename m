Return-Path: <linux-kernel+bounces-152699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2676B8AC311
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB18F1F21044
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B6101D5;
	Mon, 22 Apr 2024 03:33:31 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3E4984C97;
	Mon, 22 Apr 2024 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713756810; cv=none; b=oj9ZsHgOZzJqnP9CobZnMP2vaaGehDpX/CdR49kuAKQmBsriEGT36DEF7Ay8QKFnSpwXi9MzCWAVd1GP66nIL+epHx8vnfBnZLaoIH7X0RsGwxqNArKPxW3tmfAwBLAjJFa7AqN+BY+HphHkx6ndkUbsGymqjH9yUc/+BUsUUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713756810; c=relaxed/simple;
	bh=zI6AXceJfEK/L8fmn63vHcXTweS/N0utaLuM9iw/3cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=g7cdl5usLabn9l1TlgG0xlL+r79iQvT6WMEb386A5uucdp1Z28leWV9bYgd/iPgEGkvLMvfP9SndsNGMNnGGetsnysfh6c2eAo4XQs3z+nCnTXwUqpMWZAUmvGZlK7UMWWwLYqH3jXXYRjkcwJUkVYDGdaqVdsWokZlSNNWDa8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 0B5136068094E;
	Mon, 22 Apr 2024 11:32:43 +0800 (CST)
Message-ID: <6d311a40-05b9-3958-673d-e4c4d154ce4f@nfschina.com>
Date: Mon, 22 Apr 2024 11:32:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH wireless] wifi: ath10k: Fix an error code problem in
 ath10k_dbg_sta_write_peer_debug_trigger()
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, kvalo@kernel.org,
 jjohnson@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com
Cc: c_mkenna@qti.qualcomm.com, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <a4c2cb8c-dd80-457f-82b5-2eb58a9b55b5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/19 23:09, Jeff Johnson wrote:
> On 4/17/2024 1:17 AM, Su Hui wrote:
>>   	u8 peer_debug_trigger;
>> -	int ret;
>> +	int ret = 0;
> this is unnecessary since this will be written in all paths that lead to the
> return that reads it
Yes, this is my fault. I will remove this in v2 patch.
>>   
>>   	if (kstrtou8_from_user(user_buf, count, 0, &peer_debug_trigger))
>>   		return -EINVAL;
>> @@ -432,14 +432,12 @@ ath10k_dbg_sta_write_peer_debug_trigger(struct file *file,
>>   
>>   	ret = ath10k_wmi_peer_set_param(ar, arsta->arvif->vdev_id, sta->addr,
>>   					ar->wmi.peer_param->debug, peer_debug_trigger);
>> -	if (ret) {
>> +	if (ret)
>>   		ath10k_warn(ar, "failed to set param to trigger peer tid logs for station ret: %d\n",
>>   			    ret);
>> -		goto out;
>> -	}
>>   out:
>>   	mutex_unlock(&ar->conf_mutex);
>> -	return count;
>> +	return ret ?: count;
>>   }
>>   
>>   static const struct file_operations fops_peer_debug_trigger = {
> I'd suggest as an alternate solution that this function is a good candidate
> for the the cleanup.h functionality. By scoping the mutex_lock() you can
> simply return at each error location, and remove the explicit mutex_unlock().

like guard(mutex)(&ar->conf_mutex)?

Maybe I can send a separate patch for this,  because there are more than 
one candidates

for the cleanup.h functionality.

> But I'd accept this with the initializer change removed as well since I don't
> think ath10k has any cleanup.h usages yet.

I will send v2 patch soon , thanks for your reply!

Su Hui



