Return-Path: <linux-kernel+bounces-82131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95947867FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37FAB237E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF212F362;
	Mon, 26 Feb 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuSKjN2Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765960DC5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971788; cv=none; b=oPBAB82uT0qRuSwTBHR8PnfDfBRSSsjp3gKulcqXb4k3PyTGhChQnRQSj7JK75loS/P/QkkpeXbrM02abhi8AO5EczL2rCDkSXgyd5mBL0aG36yeHcYJGqbfYBCxjKY3wedLgYAhg4uOKcZVV3q5lFOjbn5dwzSxVI10BtOvLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971788; c=relaxed/simple;
	bh=RPo0CahJUAemPbJcjB57kOndoscsxRQGrsYBH5xPQP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTxfIl3oz68OMJBasrPQH6ouJaxwWii3nRgqijQPYcGikWPMX4XsKjNe4fOcYlHDzf8FPDFwKxv2lNNYliHop9j8xSInH5iL4CjNH3n+4fmZgiCS+YdDgyg9pEwMZ5fJ/MKjftSpOGFLl642p+rI01f74pE0pKjvcjMElZzDpUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuSKjN2Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708971785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCyh1fS6CxovKv1gPz8IKomp8FTaiDcCxIal8qsZGls=;
	b=MuSKjN2QNZjiN4NQQwZNACrSoR3grQrNmV5gYPv47BnHopsZlCeBQcVBN7epzpE+lnTkIB
	77lr/IKY4Luwfwk6tAkkft7xP4m/eFLaprEVUO0YZKm66sFxYQcz5t8QM6rBAOLFTOCQ9Y
	6yHc3ODH0MC9GcJRZZJn7eDZjgdgw9k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-9gRqgehsPPKAz8ofh-7F9A-1; Mon, 26 Feb 2024 13:23:03 -0500
X-MC-Unique: 9gRqgehsPPKAz8ofh-7F9A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3f84b660b8so225052966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708971783; x=1709576583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCyh1fS6CxovKv1gPz8IKomp8FTaiDcCxIal8qsZGls=;
        b=myDTKCP4fd+wrzfrsGvKE0djYRXGUmRwtMTGte+mdYENslZlECb7Bpo+W6fbq0hPkl
         +HZHd7rvw7+yzaYdd/QTVtyr6OxwHe9vP7sg1TXtSrxt34VV6LUPTVr6AGCW7Dd2msAn
         w95kSlBXeBaOUec1Lw5AGafmIr0fSmB5KlBRD6yOUL+4Y8gFWHX/CdVBGef6UZUNUT1P
         4OVUTBwf0jNr4nZ8m/2mnJ0MRq5FaJZiJVqxHSLUEKNAv/Bj+vOwP4oS2i8drpkWNvwC
         6Rixfncug90NkvQdOpehksUysUwH7s5CtQX8qeWfZDcwlr3mH1vdnFRctUzgT5tlBMZr
         EAxw==
X-Forwarded-Encrypted: i=1; AJvYcCWh4Bq9E8gOEfg+bVoln8IaSOZ1vBB6rix5zoF13DJIwQmfQOKfgDohCgaF/EdGpqTb/FJ0K/xwRUY8+4a6em6oHjaF2R6JP033qIdu
X-Gm-Message-State: AOJu0Yz/9NKSP4NpZfNGlLhPusQEB3e8JqQO82oYYM7nsw0Dprv5Ho4P
	ZcXwvVRLA0/95HXYvF4YsAFeQ+cD5Hgi69LXH4NqDz7Kuzqk++g0HjZGNAHSPaXvuK9ja1v28Ep
	PT+43FCYLXtxJOaiyIwKw177TvTId6nHOQOFFTITtuSC8dD77iexQyKebbBVn5g==
X-Received: by 2002:a17:906:2419:b0:a3e:f7ae:49b6 with SMTP id z25-20020a170906241900b00a3ef7ae49b6mr4646492eja.49.1708971782726;
        Mon, 26 Feb 2024 10:23:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0xi5eTkheVkqPq6UtY8bISAGmavwy2kcsZ7HuesV1dnW2YMLuA1qidKdosRXmYke909YljQ==
X-Received: by 2002:a17:906:2419:b0:a3e:f7ae:49b6 with SMTP id z25-20020a170906241900b00a3ef7ae49b6mr4646480eja.49.1708971782421;
        Mon, 26 Feb 2024 10:23:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id w1-20020a170906b18100b00a3f28bf94f8sm2648002ejy.199.2024.02.26.10.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 10:23:01 -0800 (PST)
Message-ID: <7817a2a2-b07d-4e9d-85e6-c11c5720d66e@redhat.com>
Date: Mon, 26 Feb 2024 19:23:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fbcon: Defer console takeover for splash screens to
 first switch
To: Daniel van Vugt <daniel.van.vugt@canonical.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
 Jani Nikula <jani.nikula@intel.com>, Danilo Krummrich <dakr@redhat.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sebastien Bacher <seb128@ubuntu.com>
References: <20240202085408.23251-1-daniel.van.vugt@canonical.com>
 <20240202085408.23251-2-daniel.van.vugt@canonical.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240202085408.23251-2-daniel.van.vugt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

On 2/2/24 09:53, Daniel van Vugt wrote:
> Until now, deferred console takeover only meant defer until there is
> output. But that risks stepping on the toes of userspace splash screens,
> as console messages may appear before the splash screen. So check for the
> "splash" parameter (as used by Plymouth) and if present then extend the
> deferral until the first switch.

Daniel, thank you for your patch but I do not believe that this
is the right solution. Deferring fbcon takeover further then
after the first text is output means that any errors about e.g.
a corrupt initrd or the kernel erroring out / crashing will not
be visible.

When the kernel e.g. oopses or panics because of not finding
its rootfs (I tested the latter option when writing the original
deferred fbcon takeover code) then fbcon must takeover and
print the messages from the dying kernel so that the user has
some notion of what is going wrong.

And since your patch seems to delay switching till the first
vc-switch this means that e.g. even after say gdm refusing
to start because of issues there still will be no text
output. This makes debugging various issues much harder.

Moreover Fedora has been doing flickerfree boot for many
years without needing this.

The kernel itself will be quiet as long as you set
CONFIG_CONSOLE_LOGLEVEL_QUIET=3 Ubuntu atm has set this
to 4 which means any kernel pr_err() or dev_err()
messages will get through and since there are quite
a few false positives of those Ubuntu really needs
to set CONFIG_CONSOLE_LOGLEVEL_QUIET=3 to fix part of:
https://bugs.launchpad.net/bugs/1970069

After that it is "just" a matter of not making userspace
output anything unless it has errors to report.

systemd already is quiet by default (only logging
errors) when quiet is on the kernel commandline.

So any remaining issues are Ubuntu specific boot
process bits and Ubuntu really should be able to
make those by silent unless they have important
info (errors or other unexpected things) to report.

Given that this will make debugging boot issues
much harder and that there are other IMHO better
alternatives I'm nacking this patch: NACK.

FWIW I believe that I'm actually saving Ubuntu
from shooting themselves in the foot here,
hiding all sort of boot errors (like the initrd
not finding /) until the user does a magic
alt+f2 followed by alt+f1 incantation really is
not doing yourself any favors wrt debugging any
sort of boot failures.

Regards,

Hans





> Closes: https://bugs.launchpad.net/bugs/1970069
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Daniel van Vugt <daniel.van.vugt@canonical.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 63af6ab034..5b9f7635f7 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -76,6 +76,7 @@
>  #include <linux/crc32.h> /* For counting font checksums */
>  #include <linux/uaccess.h>
>  #include <asm/irq.h>
> +#include <asm/cmdline.h>
>  
>  #include "fbcon.h"
>  #include "fb_internal.h"
> @@ -146,6 +147,7 @@ static inline void fbcon_map_override(void)
>  
>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>  static bool deferred_takeover = true;
> +static int initial_console = -1;
>  #else
>  #define deferred_takeover false
>  #endif
> @@ -3341,7 +3343,7 @@ static void fbcon_register_existing_fbs(struct work_struct *work)
>  	console_unlock();
>  }
>  
> -static struct notifier_block fbcon_output_nb;
> +static struct notifier_block fbcon_output_nb, fbcon_switch_nb;
>  static DECLARE_WORK(fbcon_deferred_takeover_work, fbcon_register_existing_fbs);
>  
>  static int fbcon_output_notifier(struct notifier_block *nb,
> @@ -3358,6 +3360,21 @@ static int fbcon_output_notifier(struct notifier_block *nb,
>  
>  	return NOTIFY_OK;
>  }
> +
> +static int fbcon_switch_notifier(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct vc_data *vc = data;
> +
> +	WARN_CONSOLE_UNLOCKED();
> +
> +	if (vc->vc_num != initial_console) {
> +		dummycon_unregister_switch_notifier(&fbcon_switch_nb);
> +		dummycon_register_output_notifier(&fbcon_output_nb);
> +	}
> +
> +	return NOTIFY_OK;
> +}
>  #endif
>  
>  static void fbcon_start(void)
> @@ -3370,7 +3387,14 @@ static void fbcon_start(void)
>  
>  	if (deferred_takeover) {
>  		fbcon_output_nb.notifier_call = fbcon_output_notifier;
> -		dummycon_register_output_notifier(&fbcon_output_nb);
> +		fbcon_switch_nb.notifier_call = fbcon_switch_notifier;
> +		initial_console = fg_console;
> +
> +		if (cmdline_find_option_bool(boot_command_line, "splash"))
> +			dummycon_register_switch_notifier(&fbcon_switch_nb);
> +		else
> +			dummycon_register_output_notifier(&fbcon_output_nb);
> +
>  		return;
>  	}
>  #endif
> @@ -3417,8 +3441,10 @@ void __exit fb_console_exit(void)
>  {
>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>  	console_lock();
> -	if (deferred_takeover)
> +	if (deferred_takeover) {
>  		dummycon_unregister_output_notifier(&fbcon_output_nb);
> +		dummycon_unregister_switch_notifier(&fbcon_switch_nb);
> +	}
>  	console_unlock();
>  
>  	cancel_work_sync(&fbcon_deferred_takeover_work);


