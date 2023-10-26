Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244377D7E50
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbjJZIS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344585AbjJZISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92EB18F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698308255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5v3W9At/Vq1/YKmqFEoUDi5nqgEEeOO3wX7iXyPMOJ4=;
        b=Mtv9Z/XG3wrjQcw0RsGrtcAFD0wDO62is2gtKm6Qwtk/xa6j6et+hsh7pnlBFX9Mz7KvGm
        UhBVX5d9ZAFUEzLpDqVKoEbkqie/R+zYobfvyCCBK0slxK6lOB/DGEk1MHW41ZIQiUafxr
        LnacbbJkEAJzzJd3o2bUAkn+aIUKh4Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-qsVLDEXcOUGEWbAho2sMIg-1; Thu, 26 Oct 2023 04:17:34 -0400
X-MC-Unique: qsVLDEXcOUGEWbAho2sMIg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5344aaf2703so417361a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698308253; x=1698913053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5v3W9At/Vq1/YKmqFEoUDi5nqgEEeOO3wX7iXyPMOJ4=;
        b=V9f+tXtHEo404Ur10kDLtOxeIHGWam9BoCNUHNDMBXz0y8Upm902TQgPLllYoA7RbZ
         FWmkNp1KIHBfreOdd5Ls2mUY4zdcVubcOAAveH+usXNMmlGHgmdWapzsrzow5nEPMopc
         zEVnObrirhgJVPbfp/bIN5+zVHJOGWiLcv9+FqR+UwAp8x3kIEn3hZ1C/zYeBtQM8aAs
         RsWzw4qGTQl0RiA5BiT26Fv6YJ/KEBtKI5aGIyyMOkFhf2jp7YI6nMRxr+c70t33qN9f
         yH7u8BPAFNWQCoiN10U21ZwpkvVZdf2z4+uX3h5FaGmERmV14RzPoq/tz0or6jKBg0mP
         dAVA==
X-Gm-Message-State: AOJu0Yx+fg7i/AXmZhzRQMqB/WV+Z95NOR6UghWx4S7lE4rqr/qLahIz
        6KfMSpugHg3FAOE/t7EnTnghEgeHvZTVr/yJ1fDYQ3OLaZgqLF1+5J8ygzTYUjlXTHjZTLePaRU
        fbyCtaqiqhKgTIAbC8MDOUB3KeBv6uH3t
X-Received: by 2002:a05:6402:40cb:b0:540:2b93:af85 with SMTP id z11-20020a05640240cb00b005402b93af85mr9827489edb.26.1698308253106;
        Thu, 26 Oct 2023 01:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn75PPfZmDU/oZuUeKX2MtBN2ugKD900AyVytWXARr1JrUtqk1aXho1K+OXs7rsBdk3G9aJg==
X-Received: by 2002:a05:6402:40cb:b0:540:2b93:af85 with SMTP id z11-20020a05640240cb00b005402b93af85mr9827471edb.26.1698308252771;
        Thu, 26 Oct 2023 01:17:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029? (2001-1c00-2a07-3a01-06c4-9fb2-0fbc-7029.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029])
        by smtp.gmail.com with ESMTPSA id s21-20020a056402037500b0053e0395059csm10703970edw.21.2023.10.26.01.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 01:17:32 -0700 (PDT)
Message-ID: <015db941-d43d-4975-9615-8003f54ec8b4@redhat.com>
Date:   Thu, 26 Oct 2023 10:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/i8259: Skip probing when ACPI/MADT advertises PCAT
 compatibility
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        David Lazar <dlazar@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     kys@microsoft.com, hpa@linux.intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <87ttqhcotn.ffs@tglx> <87v8avawe0.ffs@tglx>
 <32bcaa8a-0413-4aa4-97a0-189830da8654@amd.com> <ZTkzYA3w2p3L4SVA@localhost>
 <87jzra6235.ffs@tglx> <875y2u5s8g.ffs@tglx>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <875y2u5s8g.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/25/23 23:04, Thomas Gleixner wrote:
> David and a few others reported that on certain newer systems some legacy
> interrupts fail to work correctly.
> 
> Debugging revealed that the BIOS of these systems leaves the legacy PIC in
> uninitialized state which makes the PIC detection fail and the kernel
> switches to a dummy implementation.
> 
> Unfortunately this fallback causes quite some code to fail as it depends on
> checks for the number of legacy PIC interrupts or the availability of the
> real PIC.
> 
> In theory there is no reason to use the PIC on any modern system when
> IO/APIC is available, but the dependencies on the related checks cannot be
> resolved trivially and on short notice. This needs lots of analysis and
> rework.
> 
> The PIC detection has been added to avoid quirky checks and force selection
> of the dummy implementation all over the place, especially in VM guest
> scenarios. So it's not an option to revert the relevant commit as that
> would break a lot of other scenarios.
> 
> One solution would be to try to initialize the PIC on detection fail and
> retry the detection, but that puts the burden on everything which does not
> have a PIC.
> 
> Fortunately the ACPI/MADT table header has a flag field, which advertises
> in bit 0 that the system is PCAT compatible, which means it has a legacy
> 8259 PIC.
> 
> Evaluate that bit and if set avoid the detection routine and keep the real
> PIC installed, which then gets initialized (for nothing) and makes the rest
> of the code with all the dependencies work again.
> 
> Fixes: e179f6914152 ("x86, irq, pic: Probe for legacy PIC and set legacy_pic appropriately")
> Reported-by: David Lazar <dlazar@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: David Lazar <dlazar@gmail.com>
> Cc: stable@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218003

Thank you for this fix / workaround.

The patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
> ---
>  arch/x86/include/asm/i8259.h |    2 ++
>  arch/x86/kernel/acpi/boot.c  |    3 +++
>  arch/x86/kernel/i8259.c      |   38 ++++++++++++++++++++++++++++++--------
>  3 files changed, 35 insertions(+), 8 deletions(-)
> 
> --- a/arch/x86/include/asm/i8259.h
> +++ b/arch/x86/include/asm/i8259.h
> @@ -69,6 +69,8 @@ struct legacy_pic {
>  	void (*make_irq)(unsigned int irq);
>  };
>  
> +void legacy_pic_pcat_compat(void);
> +
>  extern struct legacy_pic *legacy_pic;
>  extern struct legacy_pic null_legacy_pic;
>  
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -148,6 +148,9 @@ static int __init acpi_parse_madt(struct
>  		pr_debug("Local APIC address 0x%08x\n", madt->address);
>  	}
>  
> +	if (madt->flags & ACPI_MADT_PCAT_COMPAT)
> +		legacy_pic_pcat_compat();
> +
>  	/* ACPI 6.3 and newer support the online capable bit. */
>  	if (acpi_gbl_FADT.header.revision > 6 ||
>  	    (acpi_gbl_FADT.header.revision == 6 &&
> --- a/arch/x86/kernel/i8259.c
> +++ b/arch/x86/kernel/i8259.c
> @@ -32,6 +32,7 @@
>   */
>  static void init_8259A(int auto_eoi);
>  
> +static bool pcat_compat __ro_after_init;
>  static int i8259A_auto_eoi;
>  DEFINE_RAW_SPINLOCK(i8259A_lock);
>  
> @@ -299,15 +300,32 @@ static void unmask_8259A(void)
>  
>  static int probe_8259A(void)
>  {
> +	unsigned char new_val, probe_val = ~(1 << PIC_CASCADE_IR);
>  	unsigned long flags;
> -	unsigned char probe_val = ~(1 << PIC_CASCADE_IR);
> -	unsigned char new_val;
> +
> +	/*
> +	 * If MADT has the PCAT_COMPAT flag set, then do not bother probing
> +	 * for the PIC. Some BIOSes leave the PIC uninitialized and probing
> +	 * fails.
> +	 *
> +	 * Right now this causes problems as quite some code depends on
> +	 * nr_legacy_irqs() > 0 or has_legacy_pic() == true. This is silly
> +	 * when the system has an IO/APIC because then PIC is not required
> +	 * at all, except for really old machines where the timer interrupt
> +	 * must be routed through the PIC. So just pretend that the PIC is
> +	 * there and let legacy_pic->init() initialize it for nothing.
> +	 *
> +	 * Alternatively this could just try to initialize the PIC and
> +	 * repeat the probe, but for cases where there is no PIC that's
> +	 * just pointless.
> +	 */
> +	if (pcat_compat)
> +		return nr_legacy_irqs();
> +
>  	/*
> -	 * Check to see if we have a PIC.
> -	 * Mask all except the cascade and read
> -	 * back the value we just wrote. If we don't
> -	 * have a PIC, we will read 0xff as opposed to the
> -	 * value we wrote.
> +	 * Check to see if we have a PIC.  Mask all except the cascade and
> +	 * read back the value we just wrote. If we don't have a PIC, we
> +	 * will read 0xff as opposed to the value we wrote.
>  	 */
>  	raw_spin_lock_irqsave(&i8259A_lock, flags);
>  
> @@ -429,5 +447,9 @@ static int __init i8259A_init_ops(void)
>  
>  	return 0;
>  }
> -
>  device_initcall(i8259A_init_ops);
> +
> +void __init legacy_pic_pcat_compat(void)
> +{
> +	pcat_compat = true;
> +}
> 

