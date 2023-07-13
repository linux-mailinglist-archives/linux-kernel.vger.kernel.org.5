Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB23751A55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjGMHut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjGMHur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:50:47 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321F3B7;
        Thu, 13 Jul 2023 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689234647; x=1720770647;
  h=references:from:to:cc:date:message-id:in-reply-to:
   mime-version:subject;
  bh=vot4qMoMLFWBXgyy/o6LSt72N9CRa0tUFzm54MB4zW4=;
  b=r5Jp7N/KjHTHce7RFrFa92deyMkUoKZzn0i9ORmah2Qc0CV8SqjBtCn3
   syoihsikxJ9p3T74ABRIIboX20gEvd1RmnSVHROwATdb4/avteDElGZFa
   vE8UcMhLdrlAeW+nw1imGvfHt1xonulXW8HPAtLwOS0x3VQZneH8B1o4R
   k=;
X-IronPort-AV: E=Sophos;i="6.01,202,1684800000"; 
   d="scan'208";a="339471606"
Subject: Re: [PATCH net] net: ena: fix shift-out-of-bounds in exponential backoff
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 07:50:43 +0000
Received: from EX19D010EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com (Postfix) with ESMTPS id A414C609A2;
        Thu, 13 Jul 2023 07:50:41 +0000 (UTC)
Received: from EX19D028EUB003.ant.amazon.com (10.252.61.31) by
 EX19D010EUA002.ant.amazon.com (10.252.50.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 07:50:38 +0000
Received: from u95c7fd9b18a35b.ant.amazon.com.amazon.com (10.1.212.11) by
 EX19D028EUB003.ant.amazon.com (10.252.61.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 07:50:34 +0000
References: <20230711013621.GE1926@templeofstupid.com>
 <pj41zllefmpbw7.fsf@u95c7fd9b18a35b.ant.amazon.com>
 <20230711225210.GA2088@templeofstupid.com>
User-agent: mu4e 1.10.3; emacs 28.2
From:   Shay Agroskin <shayagr@amazon.com>
To:     Krister Johansen <kjlx@templeofstupid.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Arthur Kiyanovski" <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        "Noam Dagan" <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date:   Thu, 13 Jul 2023 10:46:55 +0300
Message-ID: <pj41zlilao9rqt.fsf@u95c7fd9b18a35b.ant.amazon.com>
In-Reply-To: <20230711225210.GA2088@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Originating-IP: [10.1.212.11]
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D028EUB003.ant.amazon.com (10.252.61.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krister Johansen <kjlx@templeofstupid.com> writes:

>
> On Tue, Jul 11, 2023 at 08:47:32PM +0300, Shay Agroskin wrote:
>>
>> Krister Johansen <kjlx@templeofstupid.com> writes:
>>
>> > diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c
>> > b/drivers/net/ethernet/amazon/ena/ena_com.c
>> > index 451c3a1b6255..633b321d7fdd 100644
>> > --- a/drivers/net/ethernet/amazon/ena/ena_com.c
>> > +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
>> > @@ -35,6 +35,8 @@
>> >  #define ENA_REGS_ADMIN_INTR_MASK 1
>> > +#define ENA_MAX_BACKOFF_DELAY_EXP 16U
>> > +
>> >  #define ENA_MIN_ADMIN_POLL_US 100
>> >  #define ENA_MAX_ADMIN_POLL_US 5000
>> > @@ -536,6 +538,7 @@ static int 
>> > ena_com_comp_status_to_errno(struct
>> > ena_com_admin_queue *admin_queue,
>> >    static void ena_delay_exponential_backoff_us(u32 exp, u32 
>> >    delay_us)
>> >  {
>> > +   exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);
>> >     delay_us = max_t(u32, ENA_MIN_ADMIN_POLL_US, delay_us);
>> >     delay_us = min_t(u32, delay_us * (1U << exp), 
>> >     ENA_MAX_ADMIN_POLL_US);
>> >     usleep_range(delay_us, 2 * delay_us);
>>
>> Hi, thanks for submitting this patch (:
>
> Absolutely; thanks for the review!
>
>> Going over the logic here, the driver sleeps for `delay_us` 
>> micro-seconds in
>> each iteration that this function gets called.
>>
>> For an exp = 14 it'd sleep (I added units notation)
>> delay_us * (2 ^ exp) us = 100 * (2 ^ 14) us = (10 * (2 ^ 14)) / 
>> (1000000) s
>> = 1.6 s
>>
>> For an exp = 15 it'd sleep
>> (10 * (2 ^ 15)) / (1000000) = 3.2s
>>
>> To even get close to an overflow value, say exp=29 the driver 
>> would sleep in
>> a single iteration
>> 53687 s = 14.9 hours.
>>
>> The driver should stop trying to get a response from the device 
>> after a
>> timeout period received from the device which is 3 seconds by 
>> default.
>>
>> The point being, it seems very unlikely to hit this 
>> overflow. Did you
>> experience it or was the issue discovered by a static analyzer 
>> ?
>
> No, no use of fuzzing or static analysis.  This was hit on a 
> production
> instance that was having ENA trouble.
>
> I'm apparently reading the code differently.  I thought this 
> line:
>
>> >     delay_us = min_t(u32, delay_us * (1U << exp), 
>> >     ENA_MAX_ADMIN_POLL_US);
>
> Was going to cap that delay_us at (delay_us * (1U << exp)) or
> 5000us, whichever is smaller.  By that measure, if delay_us is 
> 100 and
> ENA_MAX_ADMIN_POLL_US is 5000, this should start getting capped 
> after
> exp = 6, correct?  By my estimate, that puts it at between 160ms 
> and
> 320ms of sleeping before one could hit this problem.
>
> I went and pulled the logs out of the archive and have the 
> following
> timeline.  This is seconds from boot as reported by dmesg:
>
>    11244.226583 - ena warns TX not completed on time, 10112000 
>    usecs since
>     last napi execution, missing tx timeout val of 5000 msec
>
>    11245.190453 - netdev watchdog fires
>
>    11245.190781 - ena records Transmit timeout
>    11245.250739 - ena records Trigger reset on
>
>    11246.812620 - UBSAN message to console
>
>    11248.590441 - ena reports Reset inidication didn't turn off
>    11250.633545 - ena reports failure to reset device
>    12013.529338 - last logline before new boot
>
> While the difference between the panic and the trigger reset is 
> more
> than 320ms, it is definitely on the order of seconds instead of 
> hours.
>

Yup you're right. I was so entangled in my exponent calculations 
that I completely missed the min_t expression there.

That's quite an awkward design to be honest, I hope to submit a 
re-write for it in one of the releases.

Thanks again for the work you've put into it
