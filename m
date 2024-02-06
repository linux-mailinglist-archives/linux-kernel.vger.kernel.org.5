Return-Path: <linux-kernel+bounces-55097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A684B7AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C7A1F274EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873C713249E;
	Tue,  6 Feb 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="b6ZaAiXl"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D14132480
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229275; cv=none; b=iJXLe/jlehXCUsj2XzwzeVLuMUrGed1YJbjUFmDpGAzULztWAY3x9sPWoQlDnCidPe2r6qMRrv/94luNuJEiQsUHbwT0Pq1LRRqF7GJG6NWCKiLSoSYuS0wSGjzfSIpZ5fB0PIMy5e6PkWRu36cYq3Qd0YZ8WVcps0xNP6UJ2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229275; c=relaxed/simple;
	bh=CUnjCo76/LggIQyrh7hM9viaEWjGMwz5mjjc2J93re8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJD64DVHNPeyzXMcEG7qZw18W8E6oMxL7kqDR4jzo/5avlt4MuFV1XXTkPyVDZJjCp0JXuIrKarNzkczjUS3KYamD72c++g23mxe6PLnEnMZUTVSfh3C215EmtoMuXo+A7n8V5fA2Qg5boqiqBF3LCvcdm1SiD9Z4DfptOPfLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=b6ZaAiXl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fd3b294beso7038005e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707229272; x=1707834072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cH4cinVRUE3M6YMj8iFULuCrqzQIuc0TJaFv9jLZwc=;
        b=b6ZaAiXl3AxUrRvCcysvmV8Wc8teJaKTglNBOc+/CwDr4QZ5qOGkzu91L4UPQq0cmQ
         20zRLo4DLIuBKqMUCkaG9TqXu0A/ws50VZrQwd2upIJMNgqHCfCtRK/vXiRC6ixmX4YC
         fQ35QJuPO8BruD0C8gOR64yHl7aw+zNO6dC/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229272; x=1707834072;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cH4cinVRUE3M6YMj8iFULuCrqzQIuc0TJaFv9jLZwc=;
        b=CSoM1bD5KW/SXGdR0qdjW2Qb8yRJfcu9s3H0HXjMvEVzNk2gmy1kUd7Lc66jUXSS3p
         kflqGq7QnF62GSCP7ITD3sLB5HOE/BCjuEzJYsGZB1LCrz61+qm2EP4o8NBcTSJ0V0AN
         9UJ4uw43CaaTBudejE6MnyYervlFZhtQAD8V2L7H7U0DGkMvJNaS7k2Jnlk4W4wZsuEZ
         GWdfRoOEjqxEcD+2UPbaJLqT5ClposAnjeD60v+J3Bl0DcZKC5XEdkRNAs5LIsf+a4lW
         GsDppi2wFKk0RfHu4P1QsLWdvI02qcWDIGLwAMnn77PpCtlkq3xxqkOvUPWjcePF10/3
         M2UQ==
X-Gm-Message-State: AOJu0Yw83706yIPGj6/kwwHHA+r6yqF4suETh3nCGvgsY1jV+dt82F7i
	yYWPn6xk2l/sV9ztUWew+xP6lYU0VLXiJ89vpM5KR2IyjFiMtkTYqovaiLqq/ac=
X-Google-Smtp-Source: AGHT+IGJg0nk0Vq5ScK0sm2/0DnUB3Eu8fRzGY48sYNzv3HCToc0vt80A464uq3LIaKMXGNrCimq4A==
X-Received: by 2002:a05:600c:198f:b0:40f:bda6:ccc0 with SMTP id t15-20020a05600c198f00b0040fbda6ccc0mr2335730wmq.1.1707229271976;
        Tue, 06 Feb 2024 06:21:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWvfccj3dIELWNuZ5cbWBfo92YLAuBIdF79eWwOGcB5Kom+Uk02ixbChm8cD/5S6PttjMHAhAtdhWg1I0WLwY/bovMBqa01X/ydI4/Ig8k5HRGLyS+eFur1ry+MrZFzkILNN14RV5o+WbX3ny9ACTzkp6SzB/DKi0CNw9mP3CI9F5BsoGXFMAAi4nqqACvjpBEbqd0TcqZjWyPBB5BvINbp8fkWh0gHzpK5KSg90Nc2pMJqW3D6d2i8Tjih2gLR34XcCS6j2WXWqMMgskMN/iNLn+w2B8I1+eBwEzzkbBpCyL8UzYvA35lskW7YS7oE
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040e813f1f31sm2212377wmf.25.2024.02.06.06.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:21:11 -0800 (PST)
Date: Tue, 6 Feb 2024 15:21:09 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Daniel van Vugt <daniel.van.vugt@canonical.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>,
	Danilo Krummrich <dakr@redhat.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fbcon: Defer console takeover for splash screens
 to first switch
Message-ID: <ZcJAVSyH3gRYx3EG@phenom.ffwll.local>
Mail-Followup-To: Daniel van Vugt <daniel.van.vugt@canonical.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>, Jani Nikula <jani.nikula@intel.com>,
	Danilo Krummrich <dakr@redhat.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <f037df4a-8a97-4fcd-b196-43f484b63d8d@amd.com>
 <20240206101100.25536-1-daniel.van.vugt@canonical.com>
 <20240206101100.25536-2-daniel.van.vugt@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206101100.25536-2-daniel.van.vugt@canonical.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Tue, Feb 06, 2024 at 06:10:51PM +0800, Daniel van Vugt wrote:
> Until now, deferred console takeover only meant defer until there is
> output. But that risks stepping on the toes of userspace splash screens,
> as console messages may appear before the splash screen. So check the
> command line for the expectation of userspace splash and if present then
> extend the deferral until after the first switch.
> 
> V2: Added Kconfig option instead of hard coding "splash".
> 
> Closes: https://bugs.launchpad.net/bugs/1970069
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Daniel van Vugt <daniel.van.vugt@canonical.com>
> ---
>  drivers/video/console/Kconfig    | 13 +++++++++++
>  drivers/video/fbdev/core/fbcon.c | 38 ++++++++++++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index bc31db6ef7..a6e371bfb4 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -138,6 +138,19 @@ config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>  	  by the firmware in place, rather then replacing the contents with a
>  	  black screen as soon as fbcon loads.
>  
> +config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> +	string "Framebuffer Console Deferred Takeover Condition"
> +	depends on FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> +	default "splash"
> +	help
> +	  If enabled this defers further the framebuffer console taking over
> +	  until the first console switch has occurred. And even then only if
> +	  text has been output, and only if the specified parameter is found
> +	  on the command line. This ensures fbcon does not interrupt userspace
> +	  splash screens such as Plymouth which may be yet to start rendering
> +	  at the time of the first console output. "splash" is the simplest
> +	  distro-agnostic condition for this that Plymouth checks for.

Hm this seems a bit strange since a lot of complexity that no one needs,
also my impression is that it's rather distro specific how you want this
to work. So why not just a Kconfig option that lets you choose how much
you want to delay fbcon setup, with the following options:

- no delay at all
- dely until first output from the console (which then works for distros
  which set a log-level to suppress unwanted stuff)
- delay until first vt-switch. In that case I don't think we also need to
  delay for first output, since vt switch usually means you'll get first
  output right away (if it's a vt terminal) or you switch to a different
  graphical console (which will keep fbcon fully suppressed on the drm
  side).

I think you could even reuse the existing
CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER for this, and then just
compile-time select which kind of notifier to register (well plus the
check for "splash" on the cmdline for the vt switch one I guess).

Thoughts?

Cheers, Sima


> +
>  config STI_CONSOLE
>  	bool "STI text console"
>  	depends on PARISC && HAS_IOMEM
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 63af6ab034..98155d2256 100644
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
> @@ -3358,6 +3359,26 @@ static int fbcon_output_notifier(struct notifier_block *nb,
>  
>  	return NOTIFY_OK;
>  }
> +
> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> +static int initial_console;
> +static struct notifier_block fbcon_switch_nb;
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
> +#endif
>  #endif
>  
>  static void fbcon_start(void)
> @@ -3370,7 +3391,16 @@ static void fbcon_start(void)
>  
>  	if (deferred_takeover) {
>  		fbcon_output_nb.notifier_call = fbcon_output_notifier;
> -		dummycon_register_output_notifier(&fbcon_output_nb);
> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> +		if (cmdline_find_option_bool(boot_command_line,
> +		      CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION)) {
> +			initial_console = fg_console;
> +			fbcon_switch_nb.notifier_call = fbcon_switch_notifier;
> +			dummycon_register_switch_notifier(&fbcon_switch_nb);
> +		} else
> +#endif
> +			dummycon_register_output_notifier(&fbcon_output_nb);
> +
>  		return;
>  	}
>  #endif
> @@ -3417,8 +3447,12 @@ void __exit fb_console_exit(void)
>  {
>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
>  	console_lock();
> -	if (deferred_takeover)
> +	if (deferred_takeover) {
>  		dummycon_unregister_output_notifier(&fbcon_output_nb);
> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> +		dummycon_unregister_switch_notifier(&fbcon_switch_nb);
> +#endif
> +	}
>  	console_unlock();
>  
>  	cancel_work_sync(&fbcon_deferred_takeover_work);
> -- 
> 2.43.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

