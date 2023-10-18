Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630707CEA54
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjJRVxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJRVxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:53:51 -0400
X-Greylist: delayed 239 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 14:53:50 PDT
Received: from dsmtpq4-prd-nl1-vmo.edge.unified.services (dsmtpq4-prd-nl1-vmo.edge.unified.services [84.116.6.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3215A98
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:53:50 -0700 (PDT)
Received: from csmtpq3-prd-nl1-vmo.edge.unified.services ([84.116.50.34])
        by dsmtpq4-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <gareth.randall@virgin.net>)
        id 1qtEQH-00BRe8-8X
        for linux-kernel@vger.kernel.org; Wed, 18 Oct 2023 23:49:49 +0200
Received: from csmtp6-prd-nl1-vmo.nl1.unified.services ([100.107.82.136] helo=csmtp6-prd-nl1-vmo.edge.unified.services)
        by csmtpq3-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <gareth.randall@virgin.net>)
        id 1qtEQE-006Prw-Ej
        for linux-kernel@vger.kernel.org; Wed, 18 Oct 2023 23:49:46 +0200
Received: from [192.168.0.10] ([94.175.123.86])
        by csmtp6-prd-nl1-vmo.edge.unified.services with ESMTPA
        id tEQCqzMnnQDxRtEQDqawpY; Wed, 18 Oct 2023 23:49:46 +0200
X-SourceIP: 94.175.123.86
X-Authenticated-Sender: gareth.randall@virgin.net
X-Spam: 0
X-Authority: v=2.4 cv=MPKm2uVl c=1 sm=1 tr=0 ts=653052fa cx=a_exe
 a=mwdPpgLduwvwBeoi1XfOCA==:117 a=mwdPpgLduwvwBeoi1XfOCA==:17
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=0ygn4hyuA6Uwe3Jho9UA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virgin.net;
        s=meg.feb2017; t=1697665786;
        bh=iDvSE95X2IbecfwDgjBUXneuyU03nn6+tZAzCPcbd9o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fdzwD7kEZfIWlA/IiXGq3DJsTpfYg+uS2MHh6m+GQZDxg2rwaFZFqEEQLFb3YQhSD
         jm3GMHTE8UKu5czHxgvBknlbWWEbXFP44OpA3MAqu6YAs9oGmRy2OWUhyVdf08EnkG
         ezf7JCJLet98cO2IQ3CtTUSc4T19Qk2qmKGY//C63eeuhlWZqsMBmzbpJW1n/HVRcH
         cXakThnHwuxyZTpW0AiAR6ezCudXI2eDRVHyIf3xcreb9hdEpbXN4TqLhbVzMO5GBQ
         smxl5c8PuhTeGjKT87Uil4cUx7e9LbJXTmS0wCPBolXSFWImHCEkPnF8POlm/EYR1u
         l2FhLs70H25kg==
Message-ID: <11a2da09-bd42-4a2f-9b4b-a4c1b019e8aa@virgin.net>
Date:   Wed, 18 Oct 2023 22:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] input: gpio-keys - optimize wakeup sequence.
Content-Language: en-GB
To:     abhi1.singh@samsung.com
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SRI-N IT Security <sri-n.itsec@samsung.com>
References: <CGME20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93@epcms5p2>
 <1830198030.734987.1697538855953@mail-kr5-1.mail-kr5.knoxportal-kr-prod-blue.svc.cluster.local>
From:   Gareth Randall <gareth.randall@virgin.net>
In-Reply-To: <1830198030.734987.1697538855953@mail-kr5-1.mail-kr5.knoxportal-kr-prod-blue.svc.cluster.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKpRorcHekzKLWsZegZBkCQtny1sIrdpfk9fpkYBxlCMyzYl5CH9ZWRg1zlGeDyIC8MRdv3EnHpNhD1+yok/tVZfln3UC8wbhydMHW5XGDHH0VimwpWs
 gWxomKyyQ3/f0rkusdsK5WkMqUIkv6O0pLwVjxF8/5MA2BXJCO2FxqMgF2fDZVnTulHiPN92WBqJ6Yf51/h3HV33q/1Uho6b8sSZ6qnUYlQ1IMpo+VP5gtn4
 1CpXQ9bsat03j6XJscrT+7313KDOPrZ2hKVgoY0qust9dJ9xpfQ1mdVGeihYPaafZO+qnSUlqPSXkI7ZkMeSyQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr Singh,

I am not a maintainer but can point out some issues you need to resolve 
with this post.

1. Put the patch in the body of the email and not in an attachment.
2. You need a "Signed-off-by:" line.
3. The email needs to start with a description of the what the patch 
resolves. Don't put "suggested changes".

There are probably other issues as well but I hope this helps you to get 
started. Note that I am not involved in the review process.

Yours,

Gareth

On 17/10/2023 11:34, Abhishek Kumar Singh wrote:
> Dear Mr. Dmitry,
> 
> Greetings!
> 
> 
> 
> This patch is related to optimization in input key event driver of Kernel module.
> 
> Suggested change to avoid the many APIs call chain if there is no key press event triggered.
> 
> 
> 
> There is a call back function gpio_keys_resume() called for every suspend/resume of the device.
> 
> And whenever this function is called, it is reading the status of the key.
> 
> And gpio_keys_resume() API further calls the below chain of API irrespective of key press event.
> 
> 
> 
> APIs call chain:
> 
> static void gpio_keys_report_state(struct gpio_keys_drvdata *ddata)
> 
> static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
> 
> gpiod_get_value_cansleep(bdata->gpiod);
> 
> input_event(input, type, *bdata->code, state);
> 
> input_sync(input);
> 
> 
> 
> 
> Suggested changes to avoid the above APIs call chain if there is no key press event triggered.
> 
> It will save the device computational resources, power resources and optimize the suspend/resume time"
> 
> 
> Please help to review the attached patch and integrate in main line kernel code.
> 
>   
> 
> 
> 
> Thanks and Regards,
> Abhishek Kumar Singh
> Sr. Chief Engineer, Samsung Electronics, Noida-India

