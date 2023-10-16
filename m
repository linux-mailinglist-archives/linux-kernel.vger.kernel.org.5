Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461C87CB301
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjJPSvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjJPSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:51:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F694F2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:51:24 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79f9acc857cso177437239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1697482283; x=1698087083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IrOXvmEa8YyoLJzx/PGZSqDeo/LS1eI0QuaJeU9peOs=;
        b=PS32iPcDBuRIKGW2k548mv7F66L2uuJZmwkTrwXrrM/IqN+Hf0pAzllfPyZyj8lH2S
         44qUAX8APDD08xD/Bcu0QbP9tL6P1b3R5O/ih2BZNS0mpjvh7WK3ZfWHesJm1b6X1vS0
         j5VqxMe56a49da1a2EL5/Wd3FaNTTGoD/xVi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697482283; x=1698087083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrOXvmEa8YyoLJzx/PGZSqDeo/LS1eI0QuaJeU9peOs=;
        b=K3TCcFQbsGlFSJf4ZocKESv2HMqZ17hZ69WdrLyX4oZxVNmXdqc1yIEVBMs5aEVgUL
         z0oP58bAa2mqw+6hESGwUg8n4rpPXjkhgLAJ78uARLskafCWd8w6MHaqJs4/CO92Kmll
         qFcdMK/K+Xn+Y7CnrSAb+fI6h6nmBQEuMuPUIYYodGWxvqczfDlo9dsSYWH1uAKwnYwW
         onl5yaRs2nocJxqs6cqiIzLosBJpNwZRdXuAaiFAQxpZcurI0Pl8guKi/hB+B7I3j7m3
         wU0SYCkP1kSE/Gw2DjcnfHfeeBSTQFmNLTr6tBd5H4wNkARcKRxLMHAjmUqR8vk/q93x
         T/2w==
X-Gm-Message-State: AOJu0YzzbZPkeuuVi/oOVQyRg/qyvY0LBpJS8QRBwk7bkxINb0h6p5fc
        mwIyy+N/9xqi822VNWFpeDNj5g==
X-Google-Smtp-Source: AGHT+IHs480o1L9FEIJ8LaoiM8E2Os/FNZvY3FJ893JpFmPBVzKqcg87nz1aM7rPedjOPEsxEKZXsg==
X-Received: by 2002:a05:6e02:1ba9:b0:351:5a77:f169 with SMTP id n9-20020a056e021ba900b003515a77f169mr335462ili.29.1697482283622;
        Mon, 16 Oct 2023 11:51:23 -0700 (PDT)
Received: from [192.168.0.166] (d14-69-55-117.try.wideopenwest.com. [69.14.117.55])
        by smtp.gmail.com with ESMTPSA id t7-20020a056e02010700b0035298bd42a8sm3509466ilm.20.2023.10.16.11.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 11:51:23 -0700 (PDT)
Message-ID: <4be64c29-f495-4fdb-a565-2540745d5412@fastly.com>
Date:   Mon, 16 Oct 2023 14:51:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net] ipv4: Fix broken PMTUD when using L4 multipath hash
Content-Language: en-US
To:     David Ahern <dsahern@kernel.org>, sbhogavilli@fastly.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jdamato@fastly.com, srao@fastly.com, dev@nalramli.com
References: <20231012005721.2742-2-nalramli@fastly.com>
 <20231012234025.4025-1-nalramli@fastly.com>
 <e18c52e8-116e-f258-7f2c-030a80e88343@kernel.org>
From:   "Nabil S. Alramli" <nalramli@fastly.com>
In-Reply-To: <e18c52e8-116e-f258-7f2c-030a80e88343@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thank you for your quick response.

On 10/13/2023 12:19 PM, David Ahern wrote:
> On 10/12/23 5:40 PM, Nabil S. Alramli wrote:
>> From: Suresh Bhogavilli <sbhogavilli@fastly.com>
>>
>> On a node with multiple network interfaces, if we enable layer 4 hash
>> policy with net.ipv4.fib_multipath_hash_policy=1, path MTU discovery is
>> broken and TCP connection does not make progress unless the incoming
>> ICMP Fragmentation Needed (type 3, code 4) message is received on the
>> egress interface of selected nexthop of the socket.
> 
> known problem.
> 
>>
>> This is because build_sk_flow_key() does not provide the sport and dport
>> from the socket when calling flowi4_init_output(). This appears to be a
>> copy/paste error of build_skb_flow_key() -> __build_flow_key() ->
>> flowi4_init_output() call used for packet forwarding where an skb is
>> present, is passed later to fib_multipath_hash() call, and can scrape
>> out both sport and dport from the skb if L4 hash policy is in use.
> 
> are you sure?
> 
> As I recall the problem is that the ICMP can be received on a different
> path. When it is processed, the exception is added to the ingress device
> of the ICMP and not the device the original packet egressed. I have
> scripts that somewhat reliably reproduced the problem; I started working
> on a fix and got distracted.

With net.ipv4.fib_multipath_hash_policy=1 (layer 4 hashing), when an
ICMP packet too big (PTB) message is received on an interface different
from the socket egress interface, we see a cache entry added to the
ICMP ingress interface but with parameters matching the route entry
rather than the MTU reported in the ICMP message.

On the below node, ICMP PTB messages arrive on an interface named
vlan100. With net.ipv4.fib_multipath_hash_policy=0 - layer3 hashing -
the path from this cache to 139.162.188.91 is via another interface
named vlan200.

When the ICMP PTB message arrives on vlan100, an exception entry does
get added to vlan200 and the socket's cached mtu gets updated too. TCP
connection makes progress (not shown).

sbhogavilli@node20:~$ ip route sh cache 139.162.188.91 | head
139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
  cache expires 363sec mtu 905 advmss 1460
139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
  cache expires 363sec mtu 905 advmss 1460

With net.ipv4.fib_multipath_hash_policy=1 (layer 4 hashing), when TCP
traffic egresses over vlan200 (with ICMP PTB message arriving on vlan100
still), the cache entry still shows mtu of 1500 on the TCP egress
interface of vlan200. No exception entry gets added to vlan100 as you noted:

sbhogavilli@node20:~$ ip route sh cache 139.162.188.91 | head
139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
  cache mtu 1500 advmss 1460
139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
  cache mtu 1500 advmss 1460

In this case, the TCP connection does not make progress, ultimately
timing out.

If we retry TCP connections until one uses vlan100 to egress, then the
exception entry does get added with an MTU matching those reported in
the ICMP PTB message:

sbhogavilli@node20:~$ ip route sh cache 139.162.188.91 | head
139.162.188.91 encap mpls 240583 via 172.18.144.1 dev vlan100
  cache expires 153sec mtu 905 advmss 1460
139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
  cache mtu 1500 advmss 1460

In this case the TCP connection over vlan100 does make progress.

With the proposed patch applied, an exception entry does get created on
the socket egress interface even when that is different from the ICMP
PTB ingress interface. Below is the output after different TCP
connections have used the two interfaces this node has:

sbhogavilli@node20:~$ ip route sh cache 139.162.188.91 | head
139.162.188.91 encap mpls 240583 via 172.18.144.1 dev vlan100
  cache expires 565sec mtu 905 advmss 1460
139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
  cache expires 562sec mtu 905 advmss 1460

Thank you.
