Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CBA80C616
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjLKKLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjLKKLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B1CB8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702289465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezpyX3f9VoT7jM4ALDKRb6jfowJi43kmWWGKSXH5dwk=;
        b=ZjXOkjcHVvH2BNsLbkSv1FdYfIZRkJgzfEK/vwqSx0vzkcse6iS9R3F6XG6EWjCNhNCjTA
        RPcZCWuL9f6u4DEnWsuwcbccbIFBk7aK/yldIdKRMO+Z7LwDzGDFZfFSCPsCrs6wh6kYjz
        md/DhjBlkdjtV8QdEKDOlB1vbHggiM8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-jDXSc_E4MdGKoJRqdLde8g-1; Mon, 11 Dec 2023 05:11:04 -0500
X-MC-Unique: jDXSc_E4MdGKoJRqdLde8g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c9f545220cso32375661fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289463; x=1702894263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezpyX3f9VoT7jM4ALDKRb6jfowJi43kmWWGKSXH5dwk=;
        b=ABlkIZ8AuYI0VYbYBzdKsemdx/ztsMZQSZ38xDzgnlT8TM9nvskp1toZQGTq3W5b0/
         4vcDWqH+gZpaKbwe8la9orMmw6pXVwKCIAJuiVbStvJrr2a7d7GE8rPmjApI4Y34Iyxo
         1RUdJengQEnWIj39FLYTHULumglG9t4VWn25ou7/L1sZ96hR+w11qzVjEd9BHXWrx+db
         SCeOLH2j68+O+S4jjMERx+FIILjPIH/MIFmvAZSlzKtF0iZei4+pdZ7A7J01y1U9ytko
         p7RysUFcwig0BZQj/FF/DdrNNcE1ev3RxWZXTVppc7ut4e6M5TIPKOdk9hT9vtIArRl8
         i8Wg==
X-Gm-Message-State: AOJu0Yxrhe5MlqdVNonhRHt2bPzKtdYEPyQM0Y6u2DS4fclLImuM2GiN
        ueBGY9+X77tMTodww0keax+LI31QT3bH7VxfQUe0KGHWb9zb+iD+ub+iNQAWR8vihAEkSxku7iS
        spJixK18673KkIDvRTia6HlfG
X-Received: by 2002:a2e:bc8b:0:b0:2cc:1f90:5998 with SMTP id h11-20020a2ebc8b000000b002cc1f905998mr1295811ljf.98.1702289462818;
        Mon, 11 Dec 2023 02:11:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIKUq8HMjzDaeC3gKdW0s+eWE8fQtLYJA78Qm3O/rqIUpJfXkVDltyTxPImnwzJT6djKrmzQ==
X-Received: by 2002:a2e:bc8b:0:b0:2cc:1f90:5998 with SMTP id h11-20020a2ebc8b000000b002cc1f905998mr1295800ljf.98.1702289462431;
        Mon, 11 Dec 2023 02:11:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id tk10-20020a170907c28a00b00a1cfa7e0d40sm4557317ejc.61.2023.12.11.02.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 02:11:01 -0800 (PST)
Message-ID: <6cf13a55-cd6d-47a4-ba92-c0e9fe1ad2bc@redhat.com>
Date:   Mon, 11 Dec 2023 11:11:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] platform/x86: ips: Remove unused debug code
Content-Language: en-US, nl
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20231208134845.3900-1-ilpo.jarvinen@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231208134845.3900-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/8/23 14:48, Ilpo Järvinen wrote:
> Remove unused debug code inside #if 0 ... #endif.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

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
>  drivers/platform/x86/intel_ips.c | 33 --------------------------------
>  1 file changed, 33 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> index 4dfdbfca6841..e26e7e14c44c 100644
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -1105,39 +1105,6 @@ static int ips_monitor(void *data)
>  	return 0;
>  }
>  
> -#if 0
> -#define THM_DUMPW(reg) \
> -	{ \
> -	u16 val = thm_readw(reg); \
> -	dev_dbg(ips->dev, #reg ": 0x%04x\n", val); \
> -	}
> -#define THM_DUMPL(reg) \
> -	{ \
> -	u32 val = thm_readl(reg); \
> -	dev_dbg(ips->dev, #reg ": 0x%08x\n", val); \
> -	}
> -#define THM_DUMPQ(reg) \
> -	{ \
> -	u64 val = thm_readq(reg); \
> -	dev_dbg(ips->dev, #reg ": 0x%016x\n", val); \
> -	}
> -
> -static void dump_thermal_info(struct ips_driver *ips)
> -{
> -	u16 ptl;
> -
> -	ptl = thm_readw(THM_PTL);
> -	dev_dbg(ips->dev, "Processor temp limit: %d\n", ptl);
> -
> -	THM_DUMPW(THM_CTA);
> -	THM_DUMPW(THM_TRC);
> -	THM_DUMPW(THM_CTV1);
> -	THM_DUMPL(THM_STS);
> -	THM_DUMPW(THM_PTV);
> -	THM_DUMPQ(THM_MGTV);
> -}
> -#endif
> -
>  /**
>   * ips_irq_handler - handle temperature triggers and other IPS events
>   * @irq: irq number

