Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFF07ADD05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjIYQ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjIYQ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:27:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57FEB8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:26:54 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id koQ6q3Yk8DuGykoQ6q06qm; Mon, 25 Sep 2023 18:26:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695659211;
        bh=bqF3lbG0kh1bVAZBrRIplUrNJ8DhjKKRSQSx2fty2V0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OkHLq97M1aXHkJYZD8y4nPXi5uJJJzBTnQTJHMkVqdde8rtX3Eje3PNapDsW9TQ/a
         6uYvQQsmyKopFlG87IIc28UPfubipI7y0mSEKZIv1N8X6GlpuT+6fVQUUHSKWbGVVv
         4A7bNtXHeejeiXGvFUQICEsw0egoUTZA4/0nWMJcgWqrkaBFLplSwg/vHHQL3Kkyqx
         ZY2gisEycvYzR1TUerI928arUdUUhy8YU3cGnrZq8wh+SKPuEUcDfS4R3yy/o3ji7U
         ScU7TnjYanEelaovZjtUA2fltxxLiLSRylCHUeA9NDlz9i5kEfe0LaSZXI2sVjwFMd
         9JUn79JwI4Nag==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 25 Sep 2023 18:26:51 +0200
X-ME-IP: 86.243.2.178
Message-ID: <f705117e-41dd-cb2f-ed06-6c47876fd6a2@wanadoo.fr>
Date:   Mon, 25 Sep 2023 18:26:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next] udp_tunnel: Use flex array to simplify code
Content-Language: fr, en-CA
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org
References: <4a096ba9cf981a588aa87235bb91e933ee162b3d.1695542544.git.christophe.jaillet@wanadoo.fr>
 <65105d3a8e70e_12c73e29410@willemb.c.googlers.com.notmuch>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <65105d3a8e70e_12c73e29410@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/09/2023 à 18:00, Willem de Bruijn a écrit :
> Christophe JAILLET wrote:
>> 'n_tables' is small, UDP_TUNNEL_NIC_MAX_TABLES	= 4 as a maximum. So there
>> is no real point to allocate the 'entries' pointers array with a dedicate
>> memory allocation.
>>
>> Using a flexible array for struct udp_tunnel_nic->entries avoids the
>> overhead of an additional memory allocation.
>>
>> This also saves an indirection when the array is accessed.
>>
>> Finally, __counted_by() can be used for run-time bounds checking if
>> configured and supported by the compiler.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   net/ipv4/udp_tunnel_nic.c | 11 ++---------
>>   1 file changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
>> index 029219749785..b6d2d16189c0 100644
>> --- a/net/ipv4/udp_tunnel_nic.c
>> +++ b/net/ipv4/udp_tunnel_nic.c
>> @@ -47,7 +47,7 @@ struct udp_tunnel_nic {
>>   
>>   	unsigned int n_tables;
>>   	unsigned long missed;
>> -	struct udp_tunnel_nic_table_entry **entries;
>> +	struct udp_tunnel_nic_table_entry *entries[] __counted_by(n_tables);
>>   };
>>   
>>   /* We ensure all work structs are done using driver state, but not the code.
>> @@ -725,16 +725,12 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *info,
>>   	struct udp_tunnel_nic *utn;
>>   	unsigned int i;
>>   
>> -	utn = kzalloc(sizeof(*utn), GFP_KERNEL);
>> +	utn = kzalloc(struct_size(utn, entries, n_tables), GFP_KERNEL);
>>   	if (!utn)
>>   		return NULL;
>>   	utn->n_tables = n_tables;
> 
> Should utn->n_tables be initialized before first use of
> struct_size(utn, entries, n_tables)?
> 

It can't be.
struct_size() is used to compute the memory size to allocate.

Before the kzalloc() call, utn does not exist, so we can't write 
anything to utn->n_tables. It is undefined at this point.

It is initialized the line just after, after the allocation, but before 
any use.


CJ
