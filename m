Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A987ECA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjKOSDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKOSDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:03:35 -0500
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BA61A8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:03:31 -0800 (PST)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTPS
        id 3HpIr8c1GL9Ag3KEdrx1ob; Wed, 15 Nov 2023 18:03:31 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 3KEcrq8Pl1b9N3KEcrBhp1; Wed, 15 Nov 2023 18:03:30 +0000
X-Authority-Analysis: v=2.4 cv=FLYIesks c=1 sm=1 tr=0 ts=655507f3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=S00qe9fmEFB4g_Oc0sEA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d3z9OY1ASsj06BcNejAFwfI5K6xeH/UKNLHo3vm3gFw=; b=wSPavG1dD8LzP7Sj10g9wwA6x9
        xeOnDrihtD/QS8OreY+1XsqjwNBnZiQMlytNkwpXPpsfATBHVSC0UOs/Pp+V/RRzmMbTk/pskVGnm
        8pWYtvGvk+8uZat6N9UCAWNKQxsVJ06yAWsP1S4q+JxXQyi1QohZhTnDu1ab+CzsNiqv+iAAVhBSw
        CVFyoFH29KZHh99tk3ojYkKA4Kov78Bx+SYKbRajtggRAT1CgXT4J8LOvMKbiNsdH74IkzJ+n623Q
        DkX1bzpDXDThoiymiy9raUdDcvffFiDsjJx4v+RfMYlSji5QpK+muEgLdg5cUFlxAGa5MdCzm1BsL
        OiqMUsFQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:37850 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r3KEb-002hns-1z;
        Wed, 15 Nov 2023 12:03:29 -0600
Message-ID: <f8f106ee-bccf-4ae3-b9c2-684f6bd938f5@embeddedor.com>
Date:   Wed, 15 Nov 2023 12:03:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] hwmon: (aspeed-pwm-tacho) Fix
 -Wstringop-overflow warning in aspeed_create_fan_tach_channel()
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZVPQJIP26dIzRAr6@work>
 <9ed5116f-cf36-49f6-833e-75eeab4570b4@roeck-us.net>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <9ed5116f-cf36-49f6-833e-75eeab4570b4@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1r3KEb-002hns-1z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:37850
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLG5qFVCLp9p4fLVonxnAjiVTgdz5RNxQsTAJa201rWSeJ32pUszy+81+9o8fuJBTrXtm6AEWxPHaWyDjRFHYdWV927QRcpVnxb2280sEuIpKI+a1wpM
 PTZnuicV4iJmr67n2zzwIt5ABY0DPiGD8iQO2UlCOxSCkvoaQJDvGRJOFP439Ows9x9QqO7JkrdmGPr29+NRaAVSYZOCFk9p2FBzfP1SdUPADU5ov/jW3HOA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/23 07:12, Guenter Roeck wrote:
> On Tue, Nov 14, 2023 at 01:53:08PM -0600, Gustavo A. R. Silva wrote:
>> Based on the documentation below, the maximum number of Fan tach
>> channels is 16:
>>
>> Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt:45:
>>   45 - aspeed,fan-tach-ch : should specify the Fan tach input channel.
>>   46                 integer value in the range 0 through 15, with 0 indicating
>>   47                 Fan tach channel 0 and 15 indicating Fan tach channel 15.
>>   48                 At least one Fan tach input channel is required.
>>
>> However, the compiler doesn't know that, and legitimaly warns about a potential
>> overwrite in array `u8 fan_tach_ch_source[16]` in `struct aspeed_pwm_tacho_data`,
>> in case `index` takes a value outside the boundaries of the array:
>>
> 
> Still messes the point. This isn't about "the compiler doesn't know that",
> it is a real bug which may result in out-of-bounds accesses.

Oh, I mentioned that in anticipation of people saying something in the tone of
'that's never going to happen.' :p

However, if this is a real bug, it should probably be tagged for -stable.

> 
> Oh, never mind, I'll just apply it.

Thank you!

--
Gustavo

