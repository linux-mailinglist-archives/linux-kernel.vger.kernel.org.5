Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917CC802A0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjLDCBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjLDCBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:01:12 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12E7FE;
        Sun,  3 Dec 2023 18:01:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vxh9rK-_1701655273;
Received: from 30.221.130.147(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vxh9rK-_1701655273)
          by smtp.aliyun-inc.com;
          Mon, 04 Dec 2023 10:01:15 +0800
Message-ID: <e6dc8b40-367c-ad29-1fc0-344f8d65d1db@linux.alibaba.com>
Date:   Mon, 4 Dec 2023 10:01:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v3 0/7] net/smc: implement SMCv2.1 virtual ISM
 device support
To:     Alexandra Winter <wintera@linux.ibm.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
 <c1a7b672-4a43-4494-acd1-500026566f69@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <c1a7b672-4a43-4494-acd1-500026566f69@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/2 00:32, Alexandra Winter wrote:
> 
> 
> On 30.11.23 12:28, Wen Gu wrote:
>> The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
>> SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
>> OS or hypervisor software, comparable to IBM ISM which is based on platform
>> firmware or hardware.
>>
>> With the introduction of virtual ISM, SMCv2.1 makes some updates:
>>
>> - Introduce feature bitmask to indicate supplemental features.
>> - Reserve a range of CHIDs for virtual ISM.
>> - Support extended GIDs (128 bits) in CLC handshake.
>>
>> So this patch set aims to implement these updates in Linux kernel. And it
>> acts as the first part of SMC-D virtual ISM extension & loopback-ism [1].
>>
>> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
>>
>> v3->v2:
>> - Rename smc_clc_fill_fce as smc_clc_fill_fce_v2x;
>> - Remove ISM_IDENT_MASK from drivers/s390/net/ism.h;
>> - Add explicitly assigning 'false' to ism_v2_capable in ism_dev_init();
>> - Remove smc_ism_set_v2_capable() helper for now, and introduce it in
>>    later loopback-ism implementation;
>>
>> v2->v1:
>> - Fix sparse complaint;
>> - Rebase to the latest net-next;
>>
>> Wen Gu (7):
>>    net/smc: Rename some variable 'fce' to 'fce_v2x' for clarity
>>    net/smc: support SMCv2.x supplemental features negotiation
>>    net/smc: introduce virtual ISM device support feature
>>    net/smc: define a reserved CHID range for virtual ISM devices
>>    net/smc: compatible with 128-bits extend GID of virtual ISM device
>>    net/smc: disable SEID on non-s390 archs where virtual ISM may be used
>>    net/smc: manage system EID in SMC stack instead of ISM driver
>>
> 
> Wen Gu,
> as you can see in [1] your patches 5/7 and 1/7 still have formatting issues.
> In this case they need to pass
> 
> scripts/checkpatch.pl --strict --max-line-length=80
> 
> (see linux/Documentation/process/coding-style.rst)
> 
> [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=&submitter=&state=&q=net%2Fsmc&archive=&delegate=

Thanks. They will be fixed and I will check the patches with tests provided by
https://github.com/kuba-moo/nipa/tree/master/tests/patch
