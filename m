Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A85761BED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjGYOjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjGYOjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC9FE5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690295906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GlLyTOX+0T4BQUjuuprKNGe/wk35wQO5DAolXb81K+Q=;
        b=bwyYVHtUN7L1F6LHQ4lZkzIj1KK6b35FZqmPTgrPjMxIF9dr3tSKA7oH0rCEHzcwDZj4z3
        yS8GLVI6qBURr8bB36tozRE2V7vFm5a0WVLINNxPKLjoC49aUtKfLvjNpuGuOE764JOTk1
        ekVj01xOj9dy6JhrJ6gFxs2ecYM9+Lc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-auVce64ANqu_7lRPRoLZvA-1; Tue, 25 Jul 2023 10:37:24 -0400
X-MC-Unique: auVce64ANqu_7lRPRoLZvA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-997d069a914so380932566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295843; x=1690900643;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlLyTOX+0T4BQUjuuprKNGe/wk35wQO5DAolXb81K+Q=;
        b=KtZEELKTkL1CuBMnw8KD5q4LJEsQe7oAhQuoDfCFCLebi+s6ruWxGnmDzvbN9DU7sU
         KBmcOiElH2RmEfp9G2sexE2wqsNfNthG1L/W0ilqwcguPYamg3TnLnvaP8/RHja1NMIA
         kYM9AHBsYWKn6fTImbhDtDM90lxP+WvWFSJpQR7fgSqz4H7FrRhnIGRB2URJENGKny8F
         iiw8VWVYP462X0MnMbc1SR0xeSr/sMJ8896Ua5068YBRD/WJnVsW4xomPIflTeGtENoE
         mlp83/fA+d73F+lPH6u7tAtotZXU1nYcY5ALvzLmS3on37OuBTylVUyJ6C5tI1JY4CUe
         +gZQ==
X-Gm-Message-State: ABy/qLb9X5nm7Y9dtYbdF37pkWMnPfFpMvbVeW2xWdsBHwH9i1n81qMP
        cJbVAOB5GU4dVQdg5yh5qgiXB8igw2zJz/Jq2XoLpRBcdl9hwpKbgfEx+tDcFO1aMutmuLpEV42
        jHXqTBIdbXgNcnugxqFsYK3aL
X-Received: by 2002:a17:906:3059:b0:994:673:8afa with SMTP id d25-20020a170906305900b0099406738afamr12186712ejd.28.1690295843572;
        Tue, 25 Jul 2023 07:37:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGJIAXNFgHb9mK33McQ2AcRw5kTac2VE6oPd4LHiNpSDEBlQj+eKP35q0/qcpTTPNQ1A5OeQ==
X-Received: by 2002:a17:906:3059:b0:994:673:8afa with SMTP id d25-20020a170906305900b0099406738afamr12186701ejd.28.1690295843297;
        Tue, 25 Jul 2023 07:37:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id qx26-20020a170906fcda00b00982cfe1fe5dsm8320354ejb.65.2023.07.25.07.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 07:37:22 -0700 (PDT)
Message-ID: <8ceb0052-f402-0217-2889-f9ef48a5f11f@redhat.com>
Date:   Tue, 25 Jul 2023 16:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI
 Wind U100
Content-Language: en-US, nl
To:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Mark Gross <markgross@kernel.org>
Cc:     Matthew Garrett <matthew.garrett@nebula.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721145423.161057-1-maxtram95@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230721145423.161057-1-maxtram95@gmail.com>
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

Hi,

On 7/21/23 16:54, Maxim Mikityanskiy wrote:
> Only the HW rfkill state is toggled on laptops with quirks->ec_read_only
> (so far only MSI Wind U90/U100). There are, however, a few issues with
> the implementation:
> 
> 1. The initial HW state is always unblocked, regardless of the actual
>    state on boot, because msi_init_rfkill only sets the SW state,
>    regardless of ec_read_only.
> 
> 2. The initial SW state corresponds to the actual state on boot, but it
>    can't be changed afterwards, because set_device_state returns
>    -EOPNOTSUPP. It confuses the userspace, making Wi-Fi and/or Bluetooth
>    unusable if it was blocked on boot, and breaking the airplane mode if
>    the rfkill was unblocked on boot.
> 
> Address the above issues by properly initializing the HW state on
> ec_read_only laptops and by allowing the userspace to toggle the SW
> state. Don't set the SW state ourselves and let the userspace fully
> control it. Toggling the SW state is a no-op, however, it allows the
> userspace to properly toggle the airplane mode. The actual SW radio
> disablement is handled by the corresponding rtl818x_pci and btusb
> drivers that have their own rfkills.
> 
> Tested on MSI Wind U100 Plus, BIOS ver 1.0G, EC ver 130.
> 
> Fixes: 0816392b97d4 ("msi-laptop: merge quirk tables to one")
> Fixes: 0de6575ad0a8 ("msi-laptop: Add MSI Wind U90/U100 support")
> Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/x86/msi-laptop.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
> index 6b18ec543ac3..f4c6c36e05a5 100644
> --- a/drivers/platform/x86/msi-laptop.c
> +++ b/drivers/platform/x86/msi-laptop.c
> @@ -208,7 +208,7 @@ static ssize_t set_device_state(const char *buf, size_t count, u8 mask)
>  		return -EINVAL;
>  
>  	if (quirks->ec_read_only)
> -		return -EOPNOTSUPP;
> +		return 0;
>  
>  	/* read current device state */
>  	result = ec_read(MSI_STANDARD_EC_COMMAND_ADDRESS, &rdata);
> @@ -838,15 +838,15 @@ static bool msi_laptop_i8042_filter(unsigned char data, unsigned char str,
>  static void msi_init_rfkill(struct work_struct *ignored)
>  {
>  	if (rfk_wlan) {
> -		rfkill_set_sw_state(rfk_wlan, !wlan_s);
> +		msi_rfkill_set_state(rfk_wlan, !wlan_s);
>  		rfkill_wlan_set(NULL, !wlan_s);
>  	}
>  	if (rfk_bluetooth) {
> -		rfkill_set_sw_state(rfk_bluetooth, !bluetooth_s);
> +		msi_rfkill_set_state(rfk_bluetooth, !bluetooth_s);
>  		rfkill_bluetooth_set(NULL, !bluetooth_s);
>  	}
>  	if (rfk_threeg) {
> -		rfkill_set_sw_state(rfk_threeg, !threeg_s);
> +		msi_rfkill_set_state(rfk_threeg, !threeg_s);
>  		rfkill_threeg_set(NULL, !threeg_s);
>  	}
>  }

