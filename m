Return-Path: <linux-kernel+bounces-25915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AF882D81C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EE31C218DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7CF27701;
	Mon, 15 Jan 2024 11:09:11 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9851E867
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40FB91nb026996;
	Mon, 15 Jan 2024 20:09:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Mon, 15 Jan 2024 20:09:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40FB90l7026993
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Jan 2024 20:09:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <199a52ed-59d0-4651-b361-3b3d0692a2bf@I-love.SAKURA.ne.jp>
Date: Mon, 15 Jan 2024 20:08:58 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc/nci: fix task hung in nfc_targets_found
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Edward Adam Davis <eadavis@qq.com>,
        syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
References: <000000000000a041b0060eb045ec@google.com>
 <tencent_E44436084AA874977705670A3CDD37BE9609@qq.com>
 <10fa514a-7fa0-449f-a7fd-cd3bfb0180d7@linaro.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <10fa514a-7fa0-449f-a7fd-cd3bfb0180d7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/15 18:36, Krzysztof Kozlowski wrote:
>> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
>> index 6c9592d05120..9a277228a875 100644
>> --- a/net/nfc/nci/core.c
>> +++ b/net/nfc/nci/core.c
>> @@ -145,6 +145,8 @@ inline int nci_request(struct nci_dev *ndev,
>>  {
>>  	int rc;
>>  
>> +	if (test_bit(NCI_UNREG, &ndev->flags))
>> +		return -ENODEV;
> 
> nci_close_device() clears the NCI_UP, which is tested here, just after
> acquiring mutex. And there is explicit comment about it just below your
> code. Why it is not relevant?

Because the deadlock happens at mutex_lock(&ndev->req_lock), which is
before test_bit(NCI_UP, &ndev->flags) is called. Please see
https://lkml.kernel.org/r/d314e471-0251-461e-988d-70add0c6ebf6@I-love.SAKURA.ne.jp .

> 
> Your code looks really unnecessary, at least with that code flow from
> commit msg. Especially considering you do it outside of mutex, so how
> does it solve anything?
> 
> Best regards,
> Krzysztof
> 


