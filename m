Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD480F168
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377144AbjLLPpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377023AbjLLPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3049099
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702395950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6Jd58ewzGFdt/Wd1AvGxYU7GlBPwnx7Q4Vswy/zEE8=;
        b=iJiN6QU3FVREHwmLZHMgaRV5AGDFAavwuBKHGVrk+YS4kDVj+lTzlLLRis6xgHKvec4xhn
        fbprTOFCe39Vw/jGhIYONOBKmIPhy31f0swjY7mGPhuwpOXsu5a1hSgcODZZrsCewL+yTI
        Slh4RaYpK3n1chxNHD9fHd5tncSenhE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-4xa9sEYPMRqcazRVt8XzKQ-1; Tue,
 12 Dec 2023 10:45:48 -0500
X-MC-Unique: 4xa9sEYPMRqcazRVt8XzKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B90B1C0BA4E;
        Tue, 12 Dec 2023 15:45:48 +0000 (UTC)
Received: from [10.45.225.77] (unknown [10.45.225.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B40961C060AF;
        Tue, 12 Dec 2023 15:45:47 +0000 (UTC)
Message-ID: <a79a13b9-b4d1-45ba-a104-01e911631863@redhat.com>
Date:   Tue, 12 Dec 2023 16:45:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failed to start Raise network interfaces error
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.22.394.2312102317350.3198@hadrien>
 <21977757-3a63-4586-ae03-e6630c1f009d@redhat.com>
 <d87c79b9-d0d2-2819-030-12c7df86eb38@inria.fr>
From:   Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <d87c79b9-d0d2-2819-030-12c7df86eb38@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 12. 23 16:08, Julia Lawall wrote:
> 
> 
> On Tue, 12 Dec 2023, Ivan Vecera wrote:
> 
>> On 10. 12. 23 23:28, Julia Lawall wrote:
>>> Hello,
>>>
>>> Starting with the commit:
>>>
>>> commit 9e479d64dc58f11792f638ea2e8eff3304edaabf
>>> Author: Ivan Vecera <ivecera@redhat.com>
>>> Date:   Fri Oct 13 19:07:51 2023 +0200
>>>
>>>       i40e: Add initial devlink support
>>>
>>> I am not able to boot normally.  The console shows the message
>>>
>>> Failed to start Raise network interfaces
>>>
>>> Searching for this message on th internet produces some old discussions
>>> that suggest to look at the file /etc/network/interfaces.  That file on my
>>> system contains:
>>>
>>> # This file describes the network interfaces available on your system
>>> # and how to activate them. For more information, see interfaces(5).
>>>
>>> source /etc/network/interfaces.d/*
>>>
>>> # The loopback network interface
>>> auto lo
>>> iface lo inet loopback
>>>
>>> auto enp24s0f0
>>> iface enp24s0f0 inet dhcp
>>
>> The problem is maybe with interface name... after this commit the interface
>> should contain port_name suffix. In your case the name should be
>> `enp24s0f0np0`.
>>
>> Could you please check it?
> 
> Thanks for the feedback.  But I'm not clear on how this would work.  Does
> there have to be one name for kernels before this patch and another name
> for kernels starting with this patch?  Or is the new name also acceptable
> for older kernels?

The name of a network interface is configured by udev. And it takes 
network interface attributes and compose a name for it. One of these 
attributes is phys_port_name [1] and if it is provided then its value is 
appended to the name.

Prior this commit the i40e driver didn't provided this attribute so the 
name is (in your case) enp24s0f0. After this commit the value is 
provided so it is appended -> enp24s0f0np0

Look at 'systemd.net-naming-scheme' man page for details how the 
interface names are composed.

Thanks,
Ivan

[1] /sys/class/net/enp2s0f0np0/phys_port_name

