Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D57B7292
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbjJCUd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240954AbjJCUd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:33:57 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934E7AD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 13:33:52 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nm5UqMLsanmFYnm5UqMmLO; Tue, 03 Oct 2023 22:33:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696365230;
        bh=4szZBF58NVDMkJwPCQGcaCq/8DXhNFlNUXK9ISU4JTg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jMM5hJEqTl55wNmQJ4+r0YBYKX0Tt7hC93DBUR4UNEOanbF1mI9FB5vNtzYC2Pde+
         C8uatHITU/+hpj/uqY+xb1UDRcQNixIQ0QRqZB5BX1rnOdJR+PV2qgNjdXxQfoBT/q
         5mH067tDe9dQK9bITKkPOVeZS3Grb0t7xas5Um2HHzjy8eawGUpSaPkrxJLOAQWaOt
         FqiQqCllcVli5oAHKFhBhF+Ushb8praKuB+JIwc9S2J7+rEW+RJVDPL9+x0xTaAAu+
         QNHIBIeTTl8ZTcGMnXT6+6FXDCqrD5IzyWDMvBx3LZVqP+/1kvhJ4MrlpwYFc7VkWz
         CuKV7HsUbuTVQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 03 Oct 2023 22:33:50 +0200
X-ME-IP: 86.243.2.178
Message-ID: <abf8d279-b579-4a03-9ae9-053cf5efec3d@wanadoo.fr>
Date:   Tue, 3 Oct 2023 22:33:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] iavf: Avoid a memory allocation in
 iavf_print_link_message()
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <966968bda15a7128a381b589329184dfea3e0548.1695471387.git.christophe.jaillet@wanadoo.fr>
 <a5e933fe-4566-9ae6-9a5d-b3a4c186fe0b@intel.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <a5e933fe-4566-9ae6-9a5d-b3a4c186fe0b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/10/2023 à 19:14, Jesse Brandeburg a écrit :
> On 9/23/2023 5:17 AM, Christophe JAILLET wrote:
>> IAVF_MAX_SPEED_STRLEN is only 13 and 'speed' is allocated and freed within
>> iavf_print_link_message().
>>
>> 'speed' is only used with some snprintf() and netdev_info() calls.
>>
>> So there is no real use to kzalloc()/free() it. Use the stack instead.
>> This saves a memory allocation.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
>> index 8ce6389b5815..980dc69d7fbe 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
>> @@ -1389,18 +1389,14 @@ void iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid)
>>   static void iavf_print_link_message(struct iavf_adapter *adapter)
>>   {
>>   	struct net_device *netdev = adapter->netdev;
>> +	char speed[IAVF_MAX_SPEED_STRLEN];
>>   	int link_speed_mbps;
>> -	char *speed;
>>   
>>   	if (!adapter->link_up) {
>>   		netdev_info(netdev, "NIC Link is Down\n");
>>   		return;
>>   	}
>>   
>> -	speed = kzalloc(IAVF_MAX_SPEED_STRLEN, GFP_KERNEL);
>> -	if (!speed)
>> -		return;
>> -
>>   	if (ADV_LINK_SUPPORT(adapter)) {
>>   		link_speed_mbps = adapter->link_speed_mbps;
>>   		goto print_link_msg;
>> @@ -1452,7 +1448,6 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
>>   	}
>>   
>>   	netdev_info(netdev, "NIC Link is Up Speed is %s Full Duplex\n", speed);
>> -	kfree(speed);
>>   }
>>   
>>   /**
> 
> Hi Christophe!
> 
> I had a slightly different proposal that gets rid of all the -Wformat=2
> warnings in this code by using kasprintf to handle the varying string
> lengths.
> 
> any thoughts about this instead and drop yours? I'm less worried about
> the "extra allocation" here in this function since it's slow path, and
> the same comment applies to your patch as well.

kasprintf() is much better.

> 
> your patch still shows these errors

I built-tested the patch before sending, so this is strange.

However, I got a similar feedback from Greg KH and the "kernel test 
robot" for another similar patch.

What version of gcc do you use?
I use 12.3.0, and I suspect that the value range algorithm or how the 
diagnostic is done has been improved in recent gcc.

The other report was from 11.3.0.

CJ

>> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c: In function ‘iavf_virtchnl_completion’:
>> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1446:60: warning: ‘%s’ directive output may be truncated writing 4 bytes into a region of size between 1 and 11 [-Wformat-truncation=]
>>   1446 |                 snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
>>        |                                                            ^~
>>   1447 |                          link_speed_mbps, "Mbps");
>>        |                                           ~~~~~~
>> In function ‘iavf_print_link_message’,
>>      inlined from ‘iavf_virtchnl_completion’ at drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1965:4:
>> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1446:17: note: ‘snprintf’ output between 7 and 17 bytes into a destination of size 13
>>   1446 |                 snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
>>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   1447 |                          link_speed_mbps, "Mbps");
>>        |                          ~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> <my iavf patch pasted as a quote so my mail client won't wrap the lines...>
> 
> 
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
>> index 8ce6389b5815..82b84a93bcc8 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
>> @@ -1378,8 +1378,6 @@ void iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid)
>>                                    VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2);
>>   }
>>
>> -#define IAVF_MAX_SPEED_STRLEN  13
>> -
>>   /**
>>    * iavf_print_link_message - print link up or down
>>    * @adapter: adapter structure
>> @@ -1397,10 +1395,6 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
>>                  return;
>>          }
>>
>> -       speed = kzalloc(IAVF_MAX_SPEED_STRLEN, GFP_KERNEL);
>> -       if (!speed)
>> -               return;
>> -
>>          if (ADV_LINK_SUPPORT(adapter)) {
>>                  link_speed_mbps = adapter->link_speed_mbps;
>>                  goto print_link_msg;
>> @@ -1438,17 +1432,17 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
>>
>>   print_link_msg:
>>          if (link_speed_mbps > SPEED_1000) {
>> -               if (link_speed_mbps == SPEED_2500)
>> -                       snprintf(speed, IAVF_MAX_SPEED_STRLEN, "2.5 Gbps");
>> -               else
>> +               if (link_speed_mbps == SPEED_2500) {
>> +                       speed = kasprintf(GFP_KERNEL, "%s", "2.5 Gbps");
>> +               } else {
>>                          /* convert to Gbps inline */
>> -                       snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
>> -                                link_speed_mbps / 1000, "Gbps");
>> +                       speed = kasprintf(GFP_KERNEL, "%d Gbps",
>> +                                         link_speed_mbps / 1000);
>> +               }
>>          } else if (link_speed_mbps == SPEED_UNKNOWN) {
>> -               snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%s", "Unknown Mbps");
>> +               speed = kasprintf(GFP_KERNEL, "%s", "Unknown Mbps");
>>          } else {
>> -               snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
>> -                        link_speed_mbps, "Mbps");
>> +               speed = kasprintf(GFP_KERNEL, "%d Mbps", link_speed_mbps);
>>          }
>>
>>          netdev_info(netdev, "NIC Link is Up Speed is %s Full Duplex\n", speed);
> 
> 
> 

