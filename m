Return-Path: <linux-kernel+bounces-6514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5610F8199D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88FFC1C221B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206DE18E07;
	Wed, 20 Dec 2023 07:48:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4631863B;
	Wed, 20 Dec 2023 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=27325e8b39=fe@dev.tdt.de>)
	id 1rFr2f-001Wsk-7a; Wed, 20 Dec 2023 08:30:57 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1rFr2e-00842a-BG; Wed, 20 Dec 2023 08:30:56 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id E820C24004B;
	Wed, 20 Dec 2023 08:30:55 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 68382240049;
	Wed, 20 Dec 2023 08:30:55 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id BBD262230F;
	Wed, 20 Dec 2023 08:30:54 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Dec 2023 08:30:54 +0100
From: Florian Eckert <fe@dev.tdt.de>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eckert.Florian@googlemail.com, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/thermal/tmon: Fix compilation warning for wrong
 format
In-Reply-To: <6dbed9d3-abfe-476c-a771-10a5e70bb87c@linaro.org>
References: <20231204141335.2798194-1-fe@dev.tdt.de>
 <6dbed9d3-abfe-476c-a771-10a5e70bb87c@linaro.org>
Message-ID: <6a9f55419ee05ba44ef40430e7a16ac4@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1703057456-71B3339C-00D76D5A/0/0
X-purgate-type: clean
X-purgate: clean



On 2023-12-19 19:12, Daniel Lezcano wrote:
> On 04/12/2023 15:13, Florian Eckert wrote:
>> The following warnings are shown during compilation:
>> 
>> tui.c: In function 'show_cooling_device':
>>   tui.c:216:40: warning: format '%d' expects argument of type 'int', 
>> but
>> argument 7 has type 'long unsigned int' [-Wformat=]
>>     216 |                         "%02d %12.12s%6d %6d",
>>         |                                      ~~^
>>         |                                        |
>>         |                                        int
>>         |                                      %6ld
>>   ......
>>     219 |                         ptdata.cdi[j].cur_state,
>>         |                         ~~~~~~~~~~~~~~~~~~~~~~~
>>         |                                      |
>>         |                                      long unsigned int
>>   tui.c:216:44: warning: format '%d' expects argument of type 'int', 
>> but
>> argument 8 has type 'long unsigned int' [-Wformat=]
>>     216 |                         "%02d %12.12s%6d %6d",
>>         |                                          ~~^
>>         |                                            |
>>         |                                            int
>>         |                                          %6ld
>>   ......
>>     220 |                         ptdata.cdi[j].max_state);
>>         |                         ~~~~~~~~~~~~~~~~~~~~~~~
>>         |                                      |
>>         |                                      long unsigned int
>> 
>> To fix this, the correct string format must be used for printing.
>> 
>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
> 
> Applied, thanks

Thanks :+1:

