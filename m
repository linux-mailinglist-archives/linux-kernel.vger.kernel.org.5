Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65887B22A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjI1Qma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjI1Qm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:42:28 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A1A1AD;
        Thu, 28 Sep 2023 09:42:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vt26VCS_1695919339;
Received: from 30.39.212.64(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vt26VCS_1695919339)
          by smtp.aliyun-inc.com;
          Fri, 29 Sep 2023 00:42:21 +0800
Message-ID: <1a6ef713-e5fd-3af7-fd57-966d6ddda9a4@linux.alibaba.com>
Date:   Fri, 29 Sep 2023 00:42:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
To:     Alexandra Winter <wintera@linux.ibm.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <2e4bb42a-1a6c-476e-c982-c4d6cfdac63b@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <2e4bb42a-1a6c-476e-c982-c4d6cfdac63b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/27 23:16, Alexandra Winter wrote:
> 
> 
> On 24.09.23 17:16, Wen Gu wrote:
>> Wen Gu (18):
>>    net/smc: decouple ism_dev from SMC-D device dump
>>    net/smc: decouple ism_dev from SMC-D DMB registration
>>    net/smc: extract v2 check helper from SMC-D device registration
>>    net/smc: support SMCv2.x supplemental features negotiation
>>    net/smc: reserve CHID range for SMC-D virtual device
>>    net/smc: extend GID to 128bits only for virtual ISM device
>>    net/smc: disable SEID on non-s390 architecture
>>    net/smc: enable virtual ISM device feature bit
>>    net/smc: introduce SMC-D loopback device
>>    net/smc: implement ID-related operations of loopback
>>    net/smc: implement some unsupported operations of loopback
>>    net/smc: implement DMB-related operations of loopback
>>    net/smc: register loopback device as SMC-Dv2 device
>>    net/smc: add operation for getting DMB attribute
>>    net/smc: add operations for DMB attach and detach
>>    net/smc: avoid data copy from sndbuf to peer RMB in SMC-D
>>    net/smc: modify cursor update logic when sndbuf mapped to RMB
>>    net/smc: add interface implementation of loopback device
>>
>>   drivers/s390/net/ism_drv.c    |  20 +-
>>   include/net/smc.h             |  32 ++-
>>   include/uapi/linux/smc.h      |   3 +
>>   include/uapi/linux/smc_diag.h |   2 +
>>   net/smc/Kconfig               |  13 ++
>>   net/smc/Makefile              |   2 +-
>>   net/smc/af_smc.c              |  88 ++++++--
>>   net/smc/smc.h                 |   7 +
>>   net/smc/smc_cdc.c             |  56 ++++-
>>   net/smc/smc_cdc.h             |   1 +
>>   net/smc/smc_clc.c             |  64 ++++--
>>   net/smc/smc_clc.h             |  10 +-
>>   net/smc/smc_core.c            | 111 +++++++++-
>>   net/smc/smc_core.h            |   9 +-
>>   net/smc/smc_diag.c            |  11 +-
>>   net/smc/smc_ism.c             | 100 ++++++---
>>   net/smc/smc_ism.h             |  24 ++-
>>   net/smc/smc_loopback.c        | 489 ++++++++++++++++++++++++++++++++++++++++++
>>   net/smc/smc_loopback.h        |  54 +++++
>>   net/smc/smc_pnet.c            |   4 +-
>>   20 files changed, 996 insertions(+), 104 deletions(-)
>>   create mode 100644 net/smc/smc_loopback.c
>>   create mode 100644 net/smc/smc_loopback.h
> 
> 
> Hello Wen Gu,
> 
> I applied and built your patches and noticed some things that you may want to consider in the next version:
> 
> Series should be split up [2]
> 
> Several lines exceed 80 columns [1][3]
> 
> 'git clang-format HEAD~18' finds several formatting issues.
> 	Maybe not all of them need to be fixed.
> 
> codespell *.patch
> 0006-net-smc-extend-GID-to-128bits-only-for-virtual-ISM-d.patch:7: protocal ==> protocol
> 
> With your patches applied I get some new warnings [4]:
> Seems there are some ntoh conversions missing
> 
>    CHECK   net/smc/af_smc.c
> net/smc/af_smc.c:723:32: warning: cast to restricted __be64
> net/smc/af_smc.c:1427:52: warning: cast to restricted __be64
>    CHECK   net/smc/smc_pnet.c
>    CHECK   net/smc/smc_ib.c
>    CHECK   net/smc/smc_clc.c
> net/smc/smc_clc.c:954:72: warning: incorrect type in argument 1 (different base types)
> net/smc/smc_clc.c:954:72:    expected unsigned short [usertype] chid
> net/smc/smc_clc.c:954:72:    got restricted __be16 [usertype] chid
> net/smc/smc_clc.c:1050:29: warning: incorrect type in assignment (different base types)
> net/smc/smc_clc.c:1050:29:    expected unsigned long long [usertype] gid
> net/smc/smc_clc.c:1050:29:    got restricted __be64 [usertype]
> net/smc/smc_clc.c:1051:31: warning: incorrect type in assignment (different base types)
> net/smc/smc_clc.c:1051:31:    expected unsigned long long [usertype] token
> net/smc/smc_clc.c:1051:31:    got restricted __be64 [usertype]
> 
> 
> [1] linux/Documentation/process/coding-style.rst
> [2] https://www.kernel.org/doc/html/v6.3/process/maintainer-netdev.html?highlight=network
> [3] scripts/checkpatch.pl --strict --max-line-length=80 --git HEAD-18
> [4] make C=2 CF=-D__CHECK_ENDIAN__ M=net/smc -Wunused-function -Wimplicit-fallthrough -Wincompatible-function-pointer-types-strict
> 
> 

Hi Sandy,

Thank you very much for your detailed comments. They are really helpful.
I will check and fix them in my next version.

> 
> When I installed the patches, I noticed that
>> smcd info
> showed an SEID, even though I had no ISM device --> good
> 

Yes, virtual ISM device will return the right SEID (same as that returned
by ISM device) on s390 arch.

> 
>> smcd device
> FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
> 0000 0                   0000   Yes       2
> 
> This needs some improvements.., but I'm not sure what is the best way to display virtual smcd interfaces in the smc-tools.
> 

Right. My idea is to add the display of the device's name and GID
along with the PCI information (all zero) to indicate it's virtual
smcd device.

> 
> I was able to do SMC transfers via the smcd-loopback feature :-D
> 

Glad to hear this. I will improve the issues you mentioned in the next
version and next version will be split up.

Thank you very much.
Wen Gu
