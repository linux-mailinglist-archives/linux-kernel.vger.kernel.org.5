Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D37CB96B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjJQDtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjJQDtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:49:12 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67BE83;
        Mon, 16 Oct 2023 20:49:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VuLP0Gd_1697514545;
Received: from 30.221.128.209(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VuLP0Gd_1697514545)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 11:49:06 +0800
Message-ID: <49847786-9914-b615-56d6-f39fbc6e03c2@linux.alibaba.com>
Date:   Tue, 17 Oct 2023 11:49:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
From:   Wen Gu <guwen@linux.alibaba.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     wintera@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <dcc46fedda57e7e3ade14685ddb262309544ad7e.camel@linux.ibm.com>
 <d04f304b-fe41-09b5-b2a5-5ce0e8254e41@linux.alibaba.com>
In-Reply-To: <d04f304b-fe41-09b5-b2a5-5ce0e8254e41@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/8 15:19, Wen Gu wrote:
> 
> 
> On 2023/10/5 16:21, Niklas Schnelle wrote:
> 
>>
>> Hi Wen Gu,
>>
>> I've been trying out your series with iperf3, qperf, and uperf on
>> s390x. I'm using network namespaces with a ConnectX VF from the same
>> card in each namespace for the initial TCP/IP connection i.e. initially
>> it goes out to a real NIC even if that can switch internally. All of
>> these look great for streaming workloads both in terms of performance
>> and stability. With a Connect-Request-Response workload and uperf
>> however I've run into issues. The test configuration I use is as
>> follows:
>>
>> Client Command:
>>
>> # host=$ip_server ip netns exec client smc_run uperf -m tcp_crr.xml
>>
>> Server Command:
>>
>> # ip netns exec server smc_run uperf -s &> /dev/null
>>
>> Uperf tcp_crr.xml:
>>
>> <?xml version="1.0"?>
>> <profile name="TCP_CRR">
>>          <group nthreads="12">
>>                  <transaction duration="120">
>>                          <flowop type="connect" options="remotehost=$host protocol=tcp" />
>>                          <flowop type="write" options="size=200"/>
>>                          <flowop type="read" options="size=1000"/>
>>                          <flowop type="disconnect" />
>>                  </transaction>
>>          </group>
>> </profile>
>>
>> The workload first runs fine but then after about 4 GB of data
>> transferred fails with "Connection refused" and "Connection reset by
>> peer" errors. The failure is not permanent however and re-running
>> the streaming workloads run fine again (with both uperf server and
>> client restarted). So I suspect something gets stuck in either the
>> client or server sockets. The same workload runs fine with TCP/IP of
>> course.
>>
>> Thanks,
>> Niklas
>>
>>
> 
> Hi Niklas,
> 
> Thank you very much for the test. With the test example you provided, I've
> reproduced the issue in my VM. And moreover, sometimes the test complains
> with 'Error saying goodbye with <ip>'
> 
> I'll figure out what's going on here.
> 
> Thanks!
> Wen Gu

I think that there is a common issue for SMC-R and SMC-D. I also reproduce
'connection reset by peer' and 'Error saying goodbye with <ip>' when using
SMC-R under the same test condition. They occur at the end of the test.

When the uperf test time ends, some signals are sent. At this point there
are usually some SMC connections doing CLC handshake. I catch some -EINTR(-4)
in client and -ECONNRESET(-104) in server returned from smc_clc_wait_msg,
(correspondingly handshake error counts also increase) and TCP RST packets
sent to terminate the CLC TCP connection(clcsock).

I am not sure if this should be considered as a bydesign or a bug of SMC.
 From an application perspective, the conn reset behavior only happens when
using SMC.

@Wenjia, could you please take a look at this?

Thanks,
Wen Gu
