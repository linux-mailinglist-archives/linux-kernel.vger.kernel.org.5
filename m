Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C9D77C90C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjHOIBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjHOIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E575C172A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692086391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KZLo74+LHcrwYdc0Zg+AGvqD5Lwoz/F20AvTdhQ8cE=;
        b=V7V5gy7sVKY6Pyir0KgJW/uT60W1aqOEiNS2aGy9txnfMcxKXwzGTwU3mc8nHAL0FUxc+V
        IS5vvho4Xfp3YVZN2SPBJ7vBp806AsyrPBu7pZWOSmZB+dDsETtOqlPhqgUHc4Do6Yb1d0
        pdCWxh8ZmSfRHirSY2TJ1tBsUOP96ng=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-HcZL4br2OaSZO2ubMneG_g-1; Tue, 15 Aug 2023 03:59:49 -0400
X-MC-Unique: HcZL4br2OaSZO2ubMneG_g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bca0b9234so304940466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692086388; x=1692691188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KZLo74+LHcrwYdc0Zg+AGvqD5Lwoz/F20AvTdhQ8cE=;
        b=JtfmCReooSFMnE0RXuqDOFH5sOaRWFGW8yL0uH1L0KknGlu8jKC02Ap0xYRfskggSw
         ZIJRW/ju4h9lKA5XGXxGF7LnMY5GjSAU1a6gCogXHqXtcyXB5YctGZGw9S/5/GKWsURD
         ibCeg5KMxvX/u0qim0X2CNqrL3GCSfGFZ5l+WIRsf10UVCDtVH1SmmEK4CMoBrWoBDl2
         YNvG5KrIGJHHemU3AinDel/cq7Flw1Vda+n8wPxYn+LpxumF1RvCeuf3hzb8NAPm6/py
         udqym/EAS2rGc+8Ow1XRuk/S47yg7wBl1RDOMWJMQxiaHBufe2Uly9EhaLckKY2uPzP8
         E1qQ==
X-Gm-Message-State: AOJu0YxqzM4XtRZv3p+en+rEU2pZQ6O1TzlBh34MR/8T8l/UmPP5UEIP
        N+S1RqgnqhDH4f+VMokSjSA13wKDDavIQVmjrRLLjthqdpiH3zEnWtPehYRmv3jitkECNaHV0xB
        cyFFpnCl8C9h4zsNX+47JZqVL
X-Received: by 2002:a17:906:5a62:b0:99b:49ce:b4cc with SMTP id my34-20020a1709065a6200b0099b49ceb4ccmr9304309ejc.64.1692086388521;
        Tue, 15 Aug 2023 00:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvBZsOwV9G6hiMJbLnkCKX+bcgTZ5xKfSflUX/u7PlyMb4b3+3j0ki6z/Mq3SdqVR+gX/EmQ==
X-Received: by 2002:a17:906:5a62:b0:99b:49ce:b4cc with SMTP id my34-20020a1709065a6200b0099b49ceb4ccmr9304299ejc.64.1692086388208;
        Tue, 15 Aug 2023 00:59:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ov14-20020a170906fc0e00b0099290e2c163sm6663756ejb.204.2023.08.15.00.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 00:59:46 -0700 (PDT)
Message-ID: <2f9489b4-2414-9f03-4f66-9838b8ee6be0@redhat.com>
Date:   Tue, 15 Aug 2023 09:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: duplicate patch in the drivers-x86 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>
Cc:     Henning Schild <henning.schild@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230815165725.30a01fe9@canb.auug.org.au>
 <20230815165856.051fb20f@canb.auug.org.au>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230815165856.051fb20f@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/15/23 08:58, Stephen Rothwell wrote:
> Hi Stephen,
> 
> On Tue, 15 Aug 2023 16:57:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> The following commit is also in the watchdog tree as a different commit
>> (but the same patch):
>>
>>   3fce06406c59 ("watchdog: make Siemens Simatic watchdog driver default on platform")
>>
>> This is commit
>>
>>   926df9ae133d ("watchdog: make Siemens Simatic watchdog driver default on platform")
> 
> in the watchdog tree.

Guenter, IIRC we agreed that I would merge this one through
the pdx86 tree?

specifically through the platform-drivers-x86-simatic-ipc branch:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=platform-drivers-x86-simatic-ipc

I even Cc-ed you on the pull-req for the the ib-pdx86-simatic-v6.6-2
tag for which I send a pull-req to Lee because it contains some bits
which are dependencies for some LED driver patches:

https://lore.kernel.org/linux-leds/f16554b9-d34e-4e19-052b-c818ef81d361@redhat.com/

Regards,

Hans


