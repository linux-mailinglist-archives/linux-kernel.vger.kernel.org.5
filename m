Return-Path: <linux-kernel+bounces-14296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC847821B06
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA5A28331D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4F0EADC;
	Tue,  2 Jan 2024 11:33:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25332F510;
	Tue,  2 Jan 2024 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VzqYx19_1704195199;
Received: from 30.221.130.246(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VzqYx19_1704195199)
          by smtp.aliyun-inc.com;
          Tue, 02 Jan 2024 19:33:20 +0800
Message-ID: <b2ee4680-72e9-56a1-e0dd-9cbbe64a7dac@linux.alibaba.com>
Date: Tue, 2 Jan 2024 19:33:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [0/2] net/smc: Adjustments for two function implementations
To: Markus Elfring <Markus.Elfring@web.de>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
 <93033352-4b9c-bf52-1920-6ccf07926a21@linux.alibaba.com>
 <46fe66f7-dc3b-4863-96e8-7a855316e8bd@web.de>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <46fe66f7-dc3b-4863-96e8-7a855316e8bd@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/1/2 16:51, Markus Elfring wrote:
> …
>>> A few update suggestions were taken into account
>>> from static source code analysis.
> …
>>>     Return directly after a failed kzalloc() in smc_fill_gid_list()
>>>     Improve exception handling in smc_llc_cli_add_link_invite()
>>>
>>>    net/smc/af_smc.c  |  2 +-
>>>    net/smc/smc_llc.c | 15 +++++++--------
>>>    2 files changed, 8 insertions(+), 9 deletions(-)
> …
>> I see you want to fix the kfree(NULL) issues in these two patches.
> 
> I propose to avoid redundant function calls at various source code places.
> 
> 
>> But I am wondering if this is necessary, since kfree() can handle NULL correctly.
> 
> Would you prefer only required data processing in affected function implementations?
> 

Thank you Markus. I understood that you want to avoid redundant function calls.

But it is not very attractive to me since the calls occur on low-frequency paths
or unlikely condition, resulting in limited performance loss and the current
kfree() usage is fine and common. So what is the benfit?

I noticed that some other discussions are on-going. It seems like you are trying
to change other similiar places. Let's collect more opinions.

https://lore.kernel.org/netdev/828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de/
https://lore.kernel.org/netdev/90679f69-951c-47b3-b86f-75fd9fde3da3@web.de/
https://lore.kernel.org/netdev/dc0a1c9d-ceca-473d-9ad5-89b59e6af2e7@web.de/
https://lore.kernel.org/netdev/cde82080-c715-473c-97ac-6ef66bba6d64@web.de/

Thanks.

> Regards,
> Markus

