Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BD67C4E87
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjJKJZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjJKJZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14E9B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697016297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPzSn9vWUnaVXWODF2M9d9VKpxpX+zUA3E9w940+qqs=;
        b=Zzn4GX2D3FiTcHtCPCUZn0qz7UaYOa+eF7WCTGxwD7R3Qb/gb1EB4ecZNt4GKnnjLqsU2F
        Lik6nbqBBbgtR/5eK5dp4T7PSQqX/3ZZxppn0TN5BKHhrJC/vFcKCZ5JaTL+0L9wmXa6rU
        zz+spWyFcNSvpA2gTPDgt1Znza4pG3U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-SzOT_NETNOOPtex_y8lqGA-1; Wed, 11 Oct 2023 05:24:55 -0400
X-MC-Unique: SzOT_NETNOOPtex_y8lqGA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94f7a2b21fdso492751466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697016294; x=1697621094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPzSn9vWUnaVXWODF2M9d9VKpxpX+zUA3E9w940+qqs=;
        b=WVUEsuO1CQjB+a+kaDlDiMnDoz6FjQ+YczrFzg+yMQzo3yyNg0nPaP/+TkSWaRKzPv
         2sC7E1U2BIY7IEi277fh50oaQgY8VwFQzh4ZzzDpRM9X01/jTY8f2hC4IX1eZSC286au
         QhRx/3khR0dZ4++Nunlf26uNFc+mihxkQGoZ6yCqyq1EUHurRGEpak7MJs73TD33Z+QN
         SqIGhJ5UscEKlNU8p4+u/m2gTzBN7Aw+TZIebCui3SPJsgmK4efRaKtS4LrctheKpo5j
         MVxN1Q2NWcx7hQ5qH17goRUD7vSP0KMvw/nMRQbl7QfJlrC2+VU6Yx8mVzyFhPIhym7q
         k+qA==
X-Gm-Message-State: AOJu0YzUd3eJ00ueNyfUN2AKA0TXK2/XXlg/fRAWUZy5uHImnRHwYzGF
        PEov1R4bTmv2+M7BKJZR78KZF5I5IxCOU0B8qej9G3Pfxk+ajkBvr+PoavX7Ej1NB556L3Q1WFz
        bSu/apffJ4GGN1jutY6A1a1Gv
X-Received: by 2002:a17:906:3ca1:b0:9b7:37de:6009 with SMTP id b1-20020a1709063ca100b009b737de6009mr16799529ejh.3.1697016294350;
        Wed, 11 Oct 2023 02:24:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHEzAlF5ztKmPbqb8Vn9ObdjP3Pt9FndCDWt0Qvblb1kl6soDHXxru4h911Wj1TWMzGAdqkA==
X-Received: by 2002:a17:906:3ca1:b0:9b7:37de:6009 with SMTP id b1-20020a1709063ca100b009b737de6009mr16799514ejh.3.1697016293958;
        Wed, 11 Oct 2023 02:24:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u16-20020a1709064ad000b009ae54585aebsm9387446ejt.89.2023.10.11.02.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 02:24:53 -0700 (PDT)
Message-ID: <4301d3af-4cb6-dd2e-4fbd-8c8ee96b7400@redhat.com>
Date:   Wed, 11 Oct 2023 11:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] platform/x86: wmi: Update MAINTAINERS entry
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231007233933.72121-1-W_Armin@gmx.de>
 <20231007233933.72121-2-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231007233933.72121-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/8/23 01:39, Armin Wolf wrote:
> Since 2011, the WMI subsystem is marked as orphaned,
> which means that a important part of platform support
> for modern notebooks and even desktops is receiving
> not enough maintenance.
> So i decided to take over the maintenance of the WMI
> subsystem.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch/series, I've applied this patch
(series) to the pdx86 fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in the pdx86 fixes branch once I've pushed
my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..ba309dea6e4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -378,8 +378,9 @@ F:	drivers/acpi/viot.c
>  F:	include/linux/acpi_viot.h
> 
>  ACPI WMI DRIVER
> +M:	Armin Wolf <W_Armin@gmx.de>
>  L:	platform-driver-x86@vger.kernel.org
> -S:	Orphan
> +S:	Maintained
>  F:	Documentation/driver-api/wmi.rst
>  F:	Documentation/wmi/
>  F:	drivers/platform/x86/wmi.c
> --
> 2.39.2
> 

