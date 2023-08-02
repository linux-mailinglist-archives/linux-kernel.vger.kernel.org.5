Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE376C1A2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjHBAwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjHBAwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:52:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DEF213E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 17:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47C5861781
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFFAC433C7;
        Wed,  2 Aug 2023 00:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690937521;
        bh=Rry7/5lEtM23hnGJBoFCHXBtg1ivNSJ2NFNWWsfJ1N4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TDs6Ig2pHssApHpwKo8qXfJD7bM9L04puazIcC498rzQGVr77zidbgATq90GJjvuz
         wZbdMWMzGfMdwry0jAAgIDqGjem3lvPxsdFmJ3LzebxEyJ1FRGoHkDbtjexnM4PESI
         vMCNATtd6+kKDcan7FO8afUvXdFWx/cPqThsx1qYkQEO5CuxKNnX0whSUj2xqtYn+R
         C/xq6bezVWmxf3Y+IjpuIcQa/lMRIddB7M2MeCsYZFkEvxvT2p0njPo5imbXeeIdGk
         EXtpqb21WlcRFhNzXpe7xeW9jdvKkJWma/7MGTx4ikdX6UBNlWdb2gBtD9qg0YP+/j
         qHF5luMdoPrfQ==
Message-ID: <0e3e2d6f-0e8d-ccb4-0750-928a568ccaaf@kernel.org>
Date:   Tue, 1 Aug 2023 18:52:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, simon.horman@corigine.com
References: <20230801064318.34408-1-yuehaibing@huawei.com>
 <CANn89iJO44CiUjftDZHEjOCy5Q3-PDB12uWTkrbA5JJNXMoeDA@mail.gmail.com>
 <20230801131146.51a9aaf3@kernel.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230801131146.51a9aaf3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 2:11 PM, Jakub Kicinski wrote:
> On Tue, 1 Aug 2023 09:51:29 +0200 Eric Dumazet wrote:
>>> -               skb_push(skb, -skb_network_offset(pkt));
>>> +               __skb_pull(skb, skb_network_offset(pkt));
>>>
>>>                 skb_push(skb, sizeof(*msg));
>>>                 skb_reset_transport_header(skb);  
>>
>> Presumably this code has never been tested :/
> 
> Could have been tested on 32bit, I wonder if there is more such bugs :S

that pattern shows up a few times:

net/ipv4/ah4.c:	skb_push(skb, -skb_network_offset(skb));
net/ipv4/esp4.c:	skb_push(skb, -skb_network_offset(skb));
net/ipv4/esp4_offload.c:	skb_push(skb, -skb_network_offset(skb));
net/ipv4/esp4_offload.c:	skb_push(skb, -skb_network_offset(skb));
net/ipv4/xfrm4_tunnel.c:	skb_push(skb, -skb_network_offset(skb));
net/ipv6/ah6.c:	skb_push(skb, -skb_network_offset(skb));
net/ipv6/esp6.c:	skb_push(skb, -skb_network_offset(skb));
net/ipv6/esp6_offload.c:	skb_push(skb, -skb_network_offset(skb));
net/ipv6/esp6_offload.c:	skb_push(skb, -skb_network_offset(skb));
net/ipv6/ip6mr.c:		skb_push(skb, -skb_network_offset(pkt));
net/ipv6/mip6.c:	skb_push(skb, -skb_network_offset(skb));
net/ipv6/mip6.c:	skb_push(skb, -skb_network_offset(skb));
net/ipv6/xfrm6_tunnel.c:	skb_push(skb, -skb_network_offset(skb));
net/xfrm/xfrm_ipcomp.c:	skb_push(skb, -skb_network_offset(skb));
