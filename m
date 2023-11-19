Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7DE7F06E9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjKSOff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjKSOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:35:29 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943C0128;
        Sun, 19 Nov 2023 06:35:25 -0800 (PST)
X-UUID: 2098c2fc7b834aada21791e7475b1b85-20231119
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ec71fa2b-9dec-46e1-a8de-a4f5c23d635d,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:ec71fa2b-9dec-46e1-a8de-a4f5c23d635d,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:9b363a60-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:231118012929Q096TJVV,BulkQuantity:3,Recheck:0,SF:64|66|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2098c2fc7b834aada21791e7475b1b85-20231119
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 516458896; Sun, 19 Nov 2023 22:35:20 +0800
Message-ID: <26295fac-2617-4219-a2d5-5f009223e655@kylinos.cn>
Date:   Sun, 19 Nov 2023 22:35:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231117154831.2518110-1-chentao@kylinos.cn>
 <CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,
Thank you very much for the suggestion, I have modified and resent the 
patch as suggested.

On 2023/11/18 01:29, Eric Dumazet wrote:
> On Fri, Nov 17, 2023 at 6:06 PM Kunwu Chan <chentao@kylinos.cn> wrote:
>>
>> net/ipv6/route.c:2332:39: warning: incorrect type in assignment (different base types)
>> net/ipv6/route.c:2332:39:    expected unsigned int [usertype] flow_label
>> net/ipv6/route.c:2332:39:    got restricted __be32
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> Same remark, we need a Fixes: tag
> 
>> ---
>>   net/ipv6/route.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>> index b132feae3393..692c811eb786 100644
>> --- a/net/ipv6/route.c
>> +++ b/net/ipv6/route.c
>> @@ -2329,7 +2329,7 @@ static void ip6_multipath_l3_keys(const struct sk_buff *skb,
>>          } else {
>>                  keys->addrs.v6addrs.src = key_iph->saddr;
>>                  keys->addrs.v6addrs.dst = key_iph->daddr;
>> -               keys->tags.flow_label = ip6_flowlabel(key_iph);
>> +               keys->tags.flow_label = be32_to_cpu(ip6_flowlabel(key_iph));
>>                  keys->basic.ip_proto = key_iph->nexthdr;
>>          }
> 
> This is not consistent with line 2541 doing:
> 
> hash_keys.tags.flow_label = (__force u32)flowi6_get_flowlabel(fl6);
