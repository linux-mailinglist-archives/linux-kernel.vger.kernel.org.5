Return-Path: <linux-kernel+bounces-154385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F23B8ADB78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B69D284D12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46613AD8;
	Tue, 23 Apr 2024 01:21:27 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C2BB710949;
	Tue, 23 Apr 2024 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835286; cv=none; b=D4TNkmIXOKSfoN5OYWll78fN02EgJ4dtlPBkUp2k7QXmSlDoDR/rzzKTEkMoRjpaGuppsUpDvGbepq9+b991O7sBaTLRX9uWiZkIwltDLTwIwW6TsuQR2S5Cz2cUHBEq9N5FaZ8zYFEnGaf/faTHvjp6KQtlfWdM6MEevc+1SMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835286; c=relaxed/simple;
	bh=VTGFvad64cVAJMNUZ8WORJx7AJhyjOaOK5Po0AOfSHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=VWKAzWYQwBifHktcMKooq1WUAB6y7FLbXjBINhRvVCzHHXmFrTHXy+bQ4ZeLMCQrb75F83blIspszuISgkGz3lOe/pCKWcuczxHp75nGbiJK3pA36vGXzI2wHv8IN9mNx47dM1Z/1ikmuXCQvJNWBV3f5bMNnVR8k6oFA6VNvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id E0A936083C8B3;
	Tue, 23 Apr 2024 09:21:11 +0800 (CST)
Message-ID: <3621bf61-732a-c2bc-c135-fbba299f8f57@nfschina.com>
Date: Tue, 23 Apr 2024 09:21:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH wireless v2] wifi: ath10k: Fix an error code problem in
 ath10k_dbg_sta_write_peer_debug_trigger()
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: quic_jjohnson@quicinc.com, jjohnson@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 c_mkenna@qti.qualcomm.com, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <878r15j3bt.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/22 14:53, Kalle Valo wrote:
> Su Hui <suhui@nfschina.com> writes:
>
>> Clang Static Checker (scan-build) Warning:
>> drivers/net/wireless/ath/ath10k/debugfs_sta.c:line 429, column 3
>> Value stored to 'ret' is never read.
>>
>> Return 'ret' rather than 'count' when 'ret' stores an error code.
>> By the way, remove some useless code.
>>
>> Fixes: ee8b08a1be82 ("ath10k: add debugfs support to get per peer tids log via tracing")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>> v2:
>>   - remove the initializer change.
>>
>>   drivers/net/wireless/ath/ath10k/debugfs_sta.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
>> index 394bf3c32abf..c1198e9027ae 100644
>> --- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
>> +++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
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
> Minimal changes with one logical change per patch, please. I'll remove
> this part in the pending branch.
>
Sorry for this, thanks for your help!

Su Hui


