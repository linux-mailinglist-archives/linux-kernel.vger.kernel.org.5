Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6559B76391F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGZOaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjGZOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDF310D1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690381749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iFI15BErMUMYozQzCLDVmnaZDqYBA9U7yWV7ZJN6KOE=;
        b=GCXdVeOBrrTbBUHb6VRmybDkjSIRzNGJDoYDX2ptFpdy0l7MsHVkR+3iaWTl7Ctd7CGln9
        BgFKfsuELNR/lyuh3upkOHCKUn0VABcAtXN9fbcQzgllhxG8OkzP6MBsKl6N/tqONnNnDN
        84RUwrj0TfK7XXvhO8T7twrbZa/TBmQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-oqrkBBSSM3aJoovmC3GEGA-1; Wed, 26 Jul 2023 10:29:07 -0400
X-MC-Unique: oqrkBBSSM3aJoovmC3GEGA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-992e6840901so118123366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381730; x=1690986530;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFI15BErMUMYozQzCLDVmnaZDqYBA9U7yWV7ZJN6KOE=;
        b=NwqWuY05aN1RVW0LJcmLQ66gnGJQ1uylTjG4lGlv+W3kNhrrgjPFWzEdu4EwVbAvEk
         QV5GdolX25ocFdYpr79WPrUblztubxVWmP2WLZKSROW1wf26GorwB8D3Y0Ttq/pwZIa1
         YnDbbR4cGiEgi+wk7zq+k1LSjC+97jgoHdUxjeXJfIl1+dyLuU42rRHVE3GrdcXOphoX
         2pYtyVpfYxeYAViXvuuX4wdpUbWteqgiKdbuarTtXHkQKGil//azDNnrJPI3mJuSz8uw
         UwydDCCszCSjQo12OPLVVWF7MkSReJYt4PFgITBSir5SGFweX9sXlpVD1TbBR+tSYrFl
         qfSw==
X-Gm-Message-State: ABy/qLZsKxmiQcGEYH92spGPBjguYn0inI7Go0sWAXW55go6Rp17qMnj
        npb374RTGUR6Kmdsqi4cjeztcObyW16L+ya3ho6ArjYACt/lg57jfmmCIXqYg1BBWsOC937aMCx
        jhT7LAA9hbgoEejyYCM9gPUTF
X-Received: by 2002:a17:907:96a2:b0:96f:9cea:a34d with SMTP id hd34-20020a17090796a200b0096f9ceaa34dmr6196764ejc.21.1690381730537;
        Wed, 26 Jul 2023 07:28:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECesgJHGpkINCxNmWn//tbKLvydmg+M/mAbr5aJJLMlb8wj3zr6vjMVp1A0jXNigpG3bvGTA==
X-Received: by 2002:a17:907:96a2:b0:96f:9cea:a34d with SMTP id hd34-20020a17090796a200b0096f9ceaa34dmr6196753ejc.21.1690381730199;
        Wed, 26 Jul 2023 07:28:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id y25-20020a1709064b1900b00992e265495csm9695197eju.212.2023.07.26.07.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 07:28:49 -0700 (PDT)
Message-ID: <79f81c1c-3ec2-dc0f-56ee-2946987be8b3@redhat.com>
Date:   Wed, 26 Jul 2023 16:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] hp-bioscfg: Address memory leaks and uninitialized
 variable errors
Content-Language: en-US, nl
To:     Jorge Lopez <jorgealtxwork@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de, ilpo.jarvinen@linux.intel.com,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20230725220056.25560-1-jorge.lopez2@hp.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230725220056.25560-1-jorge.lopez2@hp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On 7/26/23 00:00, Jorge Lopez wrote:
> Submit individual patches to address memory leaks and uninitialized 
> variable errors for each source file listed below.
> 
> - hp_populate_string_elements_from_package()
> drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> 
> - hp_populate_ordered_list_elements_from_package()
> drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> 
> - hp_populate_integer_elements_from_package()
> drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> 
> - hp_populate_enumeration_elements_from_package()
> drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> 
> - hp_populate_password_elements_from_package()
> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> 
> Changes were tested with a HP EliteBook x360 1030 G3

Thank you for the patches fixing this.

I'm going to wait a bit with applying these to give other people who have looked at these issues a chance to review these patches (added Dan Carpenter and Christophe JAILLET to the To: list).

For future patches please write one patch for each issue you are addressing instead of one patch per file. Since the fixes are the same for all 5 files in this case that would have meant doing 2 patches:

1. To fix the memory leak errors in all 5 files
2. To fix the uninitialized variable in all 5 files.

There is no need to send a new version unless changes are requested by one of the reviewers, I'll just squash all these 5 patches into 1 patch when merging this (and keep the uninitialized variable changes as part of the same patch).

Also these patches should have something like this as part of the commit msg (directly above your Signed-off-by:) :

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/platform-driver-x86/176e14a2-41f8-41b2-854e-77319ec2416d@moroto.mountain/

Regards,

Hans








> 
> 
> Jorge Lopez (5):
>   hp-bioscfg: Fix memory leaks in string_elements_from_package()
>   hp-bioscfg: Fix memory leaks in ordered_list_elements_from_package
>   hp-bioscfg: Fix memory leaks in integer_elements_from_package
>   hp-bioscfg: Fix memory leaks in enumeration_elements_from_package()
>   hp-bioscfg: Fix memory leaks in password_elements_from_package()
> 
>  drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c   |  8 +++++++-
>  drivers/platform/x86/hp/hp-bioscfg/int-attributes.c    |  7 ++++++-
>  .../platform/x86/hp/hp-bioscfg/order-list-attributes.c | 10 ++++++++--
>  .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 10 +++++++++-
>  drivers/platform/x86/hp/hp-bioscfg/string-attributes.c |  5 ++++-
>  5 files changed, 34 insertions(+), 6 deletions(-)
> 

