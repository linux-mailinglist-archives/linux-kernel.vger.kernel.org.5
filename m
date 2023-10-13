Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903757C7B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjJMBTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMBTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:19:19 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C4283;
        Thu, 12 Oct 2023 18:19:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vu0C2vA_1697159952;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Vu0C2vA_1697159952)
          by smtp.aliyun-inc.com;
          Fri, 13 Oct 2023 09:19:13 +0800
Date:   Fri, 13 Oct 2023 09:19:12 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: return the right falback reason when prefix
 checks fail
Message-ID: <20231013011912.GS92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231012123729.29307-1-dust.li@linux.alibaba.com>
 <5b54a227-2e18-46d5-9b15-aea9709cf2a5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b54a227-2e18-46d5-9b15-aea9709cf2a5@linux.ibm.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 03:05:20PM +0200, Alexandra Winter wrote:
>
>
>On 12.10.23 14:37, Dust Li wrote:
>> In the smc_listen_work(), if smc_listen_prfx_check() failed,
>> the real reason: SMC_CLC_DECL_DIFFPREFIX was dropped, and
>> SMC_CLC_DECL_NOSMCDEV was returned.
>> 
>> Althrough this is also kind of SMC_CLC_DECL_NOSMCDEV, but return
>> the real reason is much friendly for debugging.
>> 
>> Fixes: e49300a6bf62 ("net/smc: add listen processing for SMC-Rv2")
>> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
>
>As you point out the current code is not really wrong. So I am not sure,
>whether this should be a fix for net, or rather a debug improvement for
>net-next.

To be honest, I was a bit conflicted which branch should this go for.
But after checking the code before e49300a6bf62 ("net/smc: add listen
processing for SMC-Rv2"), I discovered the previous behavior was to return
SMC_CLC_DECL_DIFFPREFIX. Therefor, I have decided it should be
considered a fix.

I should have memtioned this in the commit message.

Best regards,
Dust


>
>> ---
>>  net/smc/af_smc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index bacdd971615e..21d4476b937b 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -2361,7 +2361,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
>>  		smc_find_ism_store_rc(rc, ini);
>>  		return (!rc) ? 0 : ini->rc;
>>  	}
>> -	return SMC_CLC_DECL_NOSMCDEV;
>> +	return prfx_rc;
>>  }
>>  
>>  /* listen worker: finish RDMA setup */
>
>For the code change:
>Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
