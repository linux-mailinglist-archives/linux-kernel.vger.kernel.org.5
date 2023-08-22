Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C92784644
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbjHVPxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjHVPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE07185
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692719563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LU7RpLBguhoOX8lOaafIfbEZOe2pmgT+SMvnhEmnYZA=;
        b=IQ1O9CIHJI2CnibHS1D75QIuPCwsT/bviBk6euuz2A6/JVRjL8JHSjRItAOPAxMVLQMbcZ
        arq+Gaw1Rj817H2nxTZZYWxbZMOC8U9GNe2lm08g6x04IlmWUWIQpb8y+CqDSrXCq5lxfN
        7MoaIAZOv6q0/ZZt9dcnnJLlTQN/Joo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-OxRjbDGxO-at9RWQxa3X3w-1; Tue, 22 Aug 2023 11:52:41 -0400
X-MC-Unique: OxRjbDGxO-at9RWQxa3X3w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993831c639aso326702866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692719560; x=1693324360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LU7RpLBguhoOX8lOaafIfbEZOe2pmgT+SMvnhEmnYZA=;
        b=CdGWfj7qOA27QtwzKR/p7Wv9+NayemJ/JNCYcpOBx4TMhQHa6g49WMPLk+nNuQkCSf
         Xz2R0BDDaaMvK8U+3i3SlGOtqA5iUNoStky8qwybnnQLaJFC4/6mAAOtMh+jHk+1wf9J
         JmkDXVsMFCSL9+CmcDEy4eEWxwsZbwsts5O+JElnznGOBUTbS06PF14G4vcJ3NgfBaZB
         eyI9G7s0ayC8DI0qi+Lq53hHNleH4lRYGspfDNpzySDDuxdiwBHZJMz2oHg6txl/ISrC
         5zvymjqSjnTCdNK6w1bmyf/Q9IqcmdQm5l7yfrL330NhMM2xjHWoGkgXTbTfsgVYAzrh
         jEGg==
X-Gm-Message-State: AOJu0YwHrH0va/kxe9LF8ydZ3Fbk+aftbhSd03hJk+aqPJilF+b3gqKe
        xqL3vv+opmiR5IGt4neCzS9BtHLa3ULBLf7A/1ny/oLfGoOfsq+/WD7j/0PN4ivw6l1//XOoerb
        iLeH/KN8HNh0jGXgc4P0NKt1UPPWw7Cjm
X-Received: by 2002:a17:906:76d0:b0:9a1:bd82:de1c with SMTP id q16-20020a17090676d000b009a1bd82de1cmr1479819ejn.41.1692719560074;
        Tue, 22 Aug 2023 08:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkf7wR8AO/HLyyOaLr/j9/FZQhxB3cXB/Bf3ZryR5S8ei0G6Rse1Q2kwZDg6mGEoVdd2oDBw==
X-Received: by 2002:a17:906:76d0:b0:9a1:bd82:de1c with SMTP id q16-20020a17090676d000b009a1bd82de1cmr1479809ejn.41.1692719559824;
        Tue, 22 Aug 2023 08:52:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id p18-20020a1709060e9200b009888aa1da11sm8395265ejf.188.2023.08.22.08.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:52:39 -0700 (PDT)
Message-ID: <60d35a07-eef4-8f23-a636-800575bcfdd5@redhat.com>
Date:   Tue, 22 Aug 2023 17:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] platform/x86: p2sb: Make the Kconfig symbol hidden
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20230822142514.2140897-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230822142514.2140897-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/22/23 16:25, Andy Shevchenko wrote:
> The P2SB is used purely as a library and all users must select it with
> 
> 	depends on PCI
> 	select P2SB if X86
> 
> statement. Without this the combination of different configuration
> options may lead to build failures.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 228fadb1c037..06b9a5ae5a63 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1102,7 +1102,7 @@ config SEL3350_PLATFORM
>  endif # X86_PLATFORM_DEVICES
>  
>  config P2SB
> -	bool "Primary to Sideband (P2SB) bridge access support"
> +	bool
>  	depends on PCI && X86
>  	help
>  	  The Primary to Sideband (P2SB) bridge is an interface to some

