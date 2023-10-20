Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4460D7D1271
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377601AbjJTPRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377620AbjJTPRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8554D52
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697815014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uL74QOOODH8z7/HLBYoyiSfFz8MZP6UcEZUC9sHk/D4=;
        b=T7omDvdqOos6XSRoRVNApj7ssyFrooUJSvPMHT7dXwQZieVp0Gra56BUhJNmTokuY6XT6p
        5Br/fqYy64+VAG9r94MHV9GHUzEotd922yEAstBMV7oJuKbsVBXLWKP3sNl3qe3c64fxng
        KhRpheIWExa4lzfuVvY+ar3bUSUga6M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-cby8rI-DNJG2cKvASd6qBA-1; Fri, 20 Oct 2023 11:16:52 -0400
X-MC-Unique: cby8rI-DNJG2cKvASd6qBA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-53dfe3af1b9so613332a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815011; x=1698419811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uL74QOOODH8z7/HLBYoyiSfFz8MZP6UcEZUC9sHk/D4=;
        b=p3JkEJ3iSKsBoIYLQbU997ptISel2s6yDFOGExO4O9CcSuYjuJsRmIwr80BY6mtmNI
         nmoWunX5IgNtWTq+oZ0iK4/Wj6tn7FwJxB/HDKylWw+THrq4ehT4CTBedTUm3TEnANSI
         SHGkGSS2X/a4Lau+q+C674jBpd/fie7EI4VgBKpH0vD+vov/SRbBdg2DwNGio5TQ9Lec
         JhgAPDoNHUpMazCuMgatRDXIgjWvEUy/xbbmjq4kgDr6rhn6q6kwl4NNn/l2FudWI4gE
         vqPTnQtR9ulOY8QPbc8GTTx4CY4PVG2R6uA9jchz7ob59Y2T1pYUdEDbrEbfeJKkq2+9
         bTqA==
X-Gm-Message-State: AOJu0YwdamFo4ZHb8lYZGzZxVZezJyG7tL/cl7v0RE/GFoCnWQ7gh1j+
        gykEFimJT3GGpCWpae5KwxVh9rqlFmNKvhTBSNk1JQ5i1BerCoxFITUV458GYk1+eXwMcSHoKqG
        QnDqhzTbl0CCF1ODVSeKbj5wz
X-Received: by 2002:a05:6402:2787:b0:53e:fc60:85bd with SMTP id b7-20020a056402278700b0053efc6085bdmr2276509ede.24.1697815011255;
        Fri, 20 Oct 2023 08:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYdNibxJHxyJGPVR5i/Yhr/fTPmr4VyB6rpDzVOAKQ0gtTV4BCXCGgLN2G0yHVvbXa7P8C6A==
X-Received: by 2002:a05:6402:2787:b0:53e:fc60:85bd with SMTP id b7-20020a056402278700b0053efc6085bdmr2276476ede.24.1697815010854;
        Fri, 20 Oct 2023 08:16:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id co2-20020a0564020c0200b0053ed70ebd7csm1621946edb.31.2023.10.20.08.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:16:49 -0700 (PDT)
Message-ID: <789ff693-a4f0-eef7-7991-59c031fefe49@redhat.com>
Date:   Fri, 20 Oct 2023 17:16:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: PIC probing code from e179f6914152 failing
Content-Language: en-US, nl
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>, kys@microsoft.com,
        hpa@linux.intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On 10/19/23 23:20, Mario Limonciello wrote:
> On 10/18/2023 17:50, Thomas Gleixner wrote:

<snip>

>> But that brings up an interesting question. How are those affected
>> machines even reaching a state where the user notices that just the
>> keyboard and the GPIO are not working? Why?
> 
> So the GPIO controller driver (pinctrl-amd) uses platform_get_irq() to try to discover the IRQ to use.
> 
> This calls acpi_irq_get() which isn't implemented on x86 (hardcodes -EINVAL).
> 
> I can "work around it" by:
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 76bfcba25003..2b4b436c65d8 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -187,7 +187,8 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
>         }
> 
>         r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> -       if (has_acpi_companion(&dev->dev)) {
> +       if (IS_ENABLED(CONFIG_ACPI_GENERIC_GSI) &&
> +            has_acpi_companion(&dev->dev)) {
>                 if (r && r->flags & IORESOURCE_DISABLED) {
>                         ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
>                         if (ret)
> 
> but the resource that is returned from the next hunk has the resource flags set wrong in the NULL pic case:
> 
> NULL case:
> r: AMDI0030:00 flags: 0x30000418
> PIC case:
> r: AMDI0030:00 flags: 0x418
> 
> IOW NULL pic case has IORESOURCE_DISABLED / IORESOURCE_UNSET
> 
> This then later the GPIO controller interrupts are not actually working.
> For example the attn pin for my I2C touchpad doesn't work.

Right the issue is that with the legacy-pic path disabled /
with nr_legacy_irqs() returning 0 them there is no mapping
added for the Legacy ISA IRQs which causes this problem.

My hack to set nr_legacy_irqs to 16 also for the NULL PIC from:
https://bugzilla.kernel.org/show_bug.cgi?id=218003

Does cause the Legacy ISA IRQ mappings to get added and makes
the GPIO controller actually work, as can be seen from:

https://bugzilla.kernel.org/attachment.cgi?id=305241&action=edit

Which is a dmesg with that hack and it does NOT have this error:

[    0.276113] amd_gpio AMDI0030:00: error -EINVAL: IRQ index 0 not found
[    0.278464] amd_gpio: probe of AMDI0030:00 failed with error -22

and the reporter also reports the touchpad works with this patch.

As Thomas already said the legayc PIC really is not necessary,
but what is still necessary on these laptops with the legacy PIC
not initialized is to have the Legacy ISA IRQ mappings added
by the kernel itself since these are missing from the MADT
(if I have my ACPI/IOAPIC terminology correct).

This quick hack (which is the one from the working dmesg)
does this:

--- a/arch/x86/kernel/i8259.c	
+++ a/arch/x86/kernel/i8259.c	
@@ -394,7 +394,7 @@ static int legacy_pic_probe(void)
 }
 
 struct legacy_pic null_legacy_pic = {
-	.nr_legacy_irqs = 0,
+	.nr_legacy_irqs = NR_IRQS_LEGACY,
 	.chip = &dummy_irq_chip,
 	.mask = legacy_pic_uint_noop,
 	.unmask = legacy_pic_uint_noop,

But I believe this will break things when there are actually
non legacy ISA IRQs / GSI-s using GSI numbers < NR_IRQS_LEGACY

Thomas, I'm not at all familiar with this area of the kernel,
but would checking if the MADT defines any non ISA GSIs under
16 and if NOT use nr_legacy_irqs = NR_IRQS_LEGACY for the
NULL PIC be an option?

Or maybe some sort of DMI (sys_vendor == Lenovo) quirk to
set nr_legacy_irqs = NR_IRQS_LEGACY for the NULL PIC ?

Regards,

Hans



