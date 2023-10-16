Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E117CB672
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjJPWSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPWSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:18:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2429F95;
        Mon, 16 Oct 2023 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blemings.org;
        s=201708; t=1697494722;
        bh=d6znq/+hwOoOtlAq0vxf3t3uFvVHfxb7ymnzjeKSrkc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RCKsOt0wc6mBzYU1kS1/U/XycX/WkrH8liDOp4mgWoaiLDF2i0+Z4T9PfWGyofehT
         HpSRBKYHViKBY2X8toNH9lTpasWbtah2wRh9bcsT0jbF+2rOpEN8Q/8K5DQuYG0KDT
         8cznpFi9iMDLLzTF2V/OzQrrdLcCeiZW5LROUtvhsgS2oxZyiDzNi8fg94mmNar/AE
         zKvuk9qx3XqMkdjk/d6RPiHAPZYln9PdkxUUnGYJkjaK4qc3ZXp1lZgCFK7kTHD2jp
         vr3fIkszmh4vDyPweWNVKv2K4t61wa7zzED66ipqQxih8LJfNlyG4BOLS7biTE6hzT
         RO4KlClzvJ0/w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8WjC6qqXz4wcN;
        Tue, 17 Oct 2023 09:18:39 +1100 (AEDT)
Message-ID: <2b9fa498-e099-4987-89d3-dd1a5df24705@blemings.org>
Date:   Tue, 17 Oct 2023 09:18:38 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hamradio: replace deprecated strncpy with strscpy
Content-Language: en-AU
To:     Kees Cook <kees@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <horms@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Thomas Sailer <t.sailer@alumni.ethz.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com>
 <20231015150619.GC1386676@kernel.org>
 <ede96908-76ff-473c-a5e1-39e2ce130df9@kadam.mountain>
 <FA371CE1-F449-44D4-801A-11C842E84867@kernel.org>
 <123F9651-9469-4F2B-ADC1-12293C9EA7FE@kernel.org>
From:   Hugh Blemings <hugh@blemings.org>
In-Reply-To: <123F9651-9469-4F2B-ADC1-12293C9EA7FE@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/10/23 04:03, Kees Cook wrote:
> 
> 
> On October 16, 2023 10:01:20 AM PDT, Kees Cook <kees@kernel.org> wrote:
>>
>>
>> On October 15, 2023 10:47:53 PM PDT, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>> On Sun, Oct 15, 2023 at 05:06:19PM +0200, Simon Horman wrote:
>>>> On Thu, Oct 12, 2023 at 09:33:32PM +0000, Justin Stitt wrote:
>>>>> strncpy() is deprecated for use on NUL-terminated destination strings
>>>>> [1] and as such we should prefer more robust and less ambiguous string
>>>>> interfaces.
>>>>>
>>>>> We expect both hi.data.modename and hi.data.drivername to be
>>>>> NUL-terminated but not necessarily NUL-padded which is evident by its
>>>>> usage with sprintf:
>>>>> |       sprintf(hi.data.modename, "%sclk,%smodem,fclk=%d,bps=%d%s",
>>>>> |               bc->cfg.intclk ? "int" : "ext",
>>>>> |               bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc->cfg.bps,
>>>>> |               bc->cfg.loopback ? ",loopback" : "");
>>>>>
>>>>> Note that this data is copied out to userspace with:
>>>>> |       if (copy_to_user(data, &hi, sizeof(hi)))
>>>>> ... however, the data was also copied FROM the user here:
>>>>> |       if (copy_from_user(&hi, data, sizeof(hi)))
>>>>
>>>> Thanks Justin,
>>>>
>>>> I see that too.
>>>>
>>>> Perhaps I am off the mark here, and perhaps it's out of scope for this
>>>> patch, but I do think it would be nicer if the kernel only sent
>>>> intended data to user-space, even if any unintended payload came
>>>> from user-space.
>>>>
>>>
>>> It's kind of normal to pass user space data back to itself.  We
>>> generally only worry about info leaks.
>>
>> True but since this used to zero the rest of the buffet, let's just keep that behavior and use strscpy_pad().
> 
> I'm calling all byte arrays a "buffet" from now on. ;)
> 
A tasteful change to the sauce I think.  ;)
