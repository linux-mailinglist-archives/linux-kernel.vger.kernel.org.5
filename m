Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684427844B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbjHVOvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbjHVOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9AC137
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692715820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAH/ryGiTaU20rxtZYgXGBs47r7l+mSCarD8RovE7Aw=;
        b=AA/Wd4w6rnfIv1hkDwhFYohAPPUvMfHNQmG3AJhjtnYK8NTy/tLqswgC1ZNuLtiUEJzC8Y
        nZshod6EsvjPCp7gxWyb0vCWmLNXI7sJJCZqXjMxW9u4q8PrdhjpnAjAyCnGmHh+eVnTqS
        IufmAA7XM00e4/ZE1TIAhxxH0CHLNJw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-oBr24f0tOaGWSno-jOkNKg-1; Tue, 22 Aug 2023 10:50:19 -0400
X-MC-Unique: oBr24f0tOaGWSno-jOkNKg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50091a3fd87so344893e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692715818; x=1693320618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAH/ryGiTaU20rxtZYgXGBs47r7l+mSCarD8RovE7Aw=;
        b=UQ2DIgmnv9zxVFB23JZrjm73wpvMrfNnMbFFq8GvXebMca0pWtjnW8frV4M7vSIA+N
         BpNsaJIonoSGrI5qCE5D4d3ePHQEVUFZuzsX7mqs/7UvKOs9x7Oa1xBckysniLRlsJH/
         /tt9ocrSi5H3/4hXKhdBE0+DnJs5H/EZcwbg7oGCKsOl5vWo+x36sDNN/rYTU/q99a3Z
         UGvgUvsiXS75RWyRjFakKsxMvMj1yep86yXUGugV++/vq4Erb2HIC3yHYR7C9ln55VNB
         i/1pdb4yQ7QU8+hBhj/to5RHt6ipOsuUg4TvJsMVdpzzKoeAGcJUBONf/v6pODfSMrLu
         zRFQ==
X-Gm-Message-State: AOJu0YzOs+PyhD6otCd4+nN+U0O/bmrxL38iNJ5fX+/NsmbLeLpz6Nd1
        H1XkCA3ueT/4PcJHLOJK5p+Y3bXhgqOZPCVc+c6hYcgZ6YYFZIbNFTx/24pQ/uEZvrbO8/rHHrW
        VJ3KFtqUZDOQE5z7HAETnQ1+0
X-Received: by 2002:a05:6512:b94:b0:4ff:8c0f:a745 with SMTP id b20-20020a0565120b9400b004ff8c0fa745mr8188728lfv.54.1692715817889;
        Tue, 22 Aug 2023 07:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiTDk5Bui7J0OrxHQ7Lrik1JVn/M1h3ENBHJe7+XVnhjGGlqt54RIc1grJP4zwK+xNqK/HxQ==
X-Received: by 2002:a05:6512:b94:b0:4ff:8c0f:a745 with SMTP id b20-20020a0565120b9400b004ff8c0fa745mr8188707lfv.54.1692715817512;
        Tue, 22 Aug 2023 07:50:17 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id e14-20020a50fb8e000000b00523653295f9sm7783110edq.94.2023.08.22.07.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 07:50:16 -0700 (PDT)
Message-ID: <a02b41a2-c390-8d05-ba2a-7a0a958013a8@redhat.com>
Date:   Tue, 22 Aug 2023 16:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] watchdog: simatic: Use idiomatic selection of P2SB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230822141859.2139630-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230822141859.2139630-1-andriy.shevchenko@linux.intel.com>
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

On 8/22/23 16:18, Andy Shevchenko wrote:
> While it's pretty much theoretical to be otherwise, make sure
> that P2SB is selected only for X86. This is idiomatic dependency
> which is used by all others who select it. Use it for Simatic
> as well.

Hmm, this already depends on SIEMENS_SIMATIC_IPC which itself
depends on X86, so as you already say this is not really necessary...

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Note this depends on / applies on top of 2 other
"config SIEMENS_SIMATIC_IPC_WDT" patches which
are currently pending in pdx86/for-next:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

so this should probably be merged after 6.6-rc1 once
these other changes have been merged.

Regards,

Hans



> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index a75f6acb986b..751458959411 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1685,7 +1685,7 @@ config SIEMENS_SIMATIC_IPC_WDT
>  	depends on SIEMENS_SIMATIC_IPC && PCI
>  	default y
>  	select WATCHDOG_CORE
> -	select P2SB
> +	select P2SB if X86
>  	help
>  	  This driver adds support for several watchdogs found in Industrial
>  	  PCs from Siemens.

