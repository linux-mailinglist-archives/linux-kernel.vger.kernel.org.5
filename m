Return-Path: <linux-kernel+bounces-59257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C3184F3F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3ED0B29774
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F825629;
	Fri,  9 Feb 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cT62vK5F"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B72560F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476289; cv=none; b=EfwyQys89Ao+Zhz9c/I9fOb85Q3xWgzxYXekElLKeEKC+PrVurbLyKSy/MKTw8NCYUqth+OYYsUdNjsiSS5Vy0eccT7ORi3bKm/MZAE6oV1qDFeuFTZzFJmQZpqqH/n72pniDHT8gZSIo7FZvMuZCl1DrbnNHB3Lb1DNHgtZ6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476289; c=relaxed/simple;
	bh=c11N6rt1qsc/quKe3ZiQm8XBiFIblkdTzHhvOa9ARzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSmV1ntVf8SuedQO2pl4sdvBYyACNw/Sg6nHnOI1asXJnnhfq02h5lR1GSVkbNM88PflB6xmdGXE+87W8YcXG9L/cn+uLPOGd6kBGLxgDPRav710JAF1MGve+g/y//RzKu0PvNIaZkYbl5cjlEiZgB80BXXrVMepg4Ktn5PjFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=cT62vK5F; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b670e4092so80720f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 02:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707476284; x=1708081084; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Guc8Ta70RR+7fV/VbHknsGOIx5W7hGntsETb3HnHVd0=;
        b=cT62vK5FSaVQ8mSre9FlVfNs14YyrWcMKRC6XBhdj00fhzVZtu4x0wAX+sXWBtHYvb
         GiMOlQYcsisFQuhLpYrUH82Kneba0//6aAR29jRAH15a893Sicvb4OOjWt0c1gBRXx8n
         8njVIz+kxHBKX6n9H3fa3qPHMWC9OmYNpv8l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476284; x=1708081084;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Guc8Ta70RR+7fV/VbHknsGOIx5W7hGntsETb3HnHVd0=;
        b=u+a9BuOMHiGdJqT2J20uYk+4H9HM9Qy50SNh10EooVtJtTYWSTwNXUAh79pTRhntdt
         tc9CwYdnlc9K6A57wnU+tYkRmpsR5vjDsLutTxdOG0RatnkjuBgh2YVxwMBHEyEhAlZh
         a61sklZY/2qVfpmbDqM/Q9i2YeN5iI5CyZ0mfHWnB9AZYuLDPCk/m0QneCgn1BqoBanh
         +MVbtBslQVFzjuf1pwHvCuusafQyi3FrxVpOeJKe52b82559nRWlLbIcKkBZ1vuQRxS8
         tiXocCy3qXmUzbYSgq8JyrEochKViBKtTEz1mQZ3xLQE7+VpBHVoiQqMAugxSOAi2f3U
         YeiA==
X-Forwarded-Encrypted: i=1; AJvYcCVvLOZJb8/DhtkT5gd+XPDt9kYp2g51OZlaZIZlUJH4izW90f9T8vfqIO75RpC9rfowSqqZ0nQ4aiJf+gi+LXbrjq0P8QJMcwG9QMs3
X-Gm-Message-State: AOJu0YzUbR6mh+gonjfUTUkTinhA9dBDsk73LWm/qHDiKOf7a6+wbYQj
	HhBLdeVXTmmaKR5jq7JuTFCDr4e2UMfeTOREbXfPXefpgL9VFWkWCk2VhytjAiEEAsHo9rFfF24
	X
X-Google-Smtp-Source: AGHT+IGrdo0gLMZBH6PNa1mY6stJwfUa1QFrFIpGxUCUNgGhivVOv9uYu4NxO84ChM4EP4BQNTNhiQ==
X-Received: by 2002:a05:600c:3b04:b0:40f:dd10:180f with SMTP id m4-20020a05600c3b0400b0040fdd10180fmr920752wms.3.1707476284320;
        Fri, 09 Feb 2024 02:58:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnrlsp1yIad7A9lGxhn6SmJUTzOVXmu/EmpQbuCvU0YiUiNycF2UrK0XB7IyZ2UIC1lfFf9w8QPiF7zrxo1L/puv+z3tM3FheaJWAgZo9K4Z3p1wIep9i2sjC/VJL/5+ZFj+GpGZPHcDVnFqke960VmaatWpVVCnWhhsyHAColZ1tMEMDe5J4IWXS7X5fqn4gfVjca6WseRwWtHNhNyqIQd2NzT/9y8V936fv4LtoETEQa5REuU4zJNTzi78zATOZ36po/OWkAfdyJ/ljn5OBAPP13vQYn5FXchisCQy8dP0I+EYh5TVNCkHQsTFocBYCBONl1RBxey8ZJX0NzpU9GuF8LIiY+WsbP4Hjd
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c1c1000b0040ee51f1025sm253091wms.43.2024.02.09.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 02:58:03 -0800 (PST)
Date: Fri, 9 Feb 2024 11:58:01 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Daniel van Vugt <daniel.van.vugt@canonical.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>, andy.whitcroft@canonical.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>, Jani Nikula <jani.nikula@intel.com>,
	Danilo Krummrich <dakr@redhat.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fbcon: Defer console takeover for splash screens
 to first switch
Message-ID: <ZcYFOXdcAmJ6eeCa@phenom.ffwll.local>
Mail-Followup-To: Daniel van Vugt <daniel.van.vugt@canonical.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	andy.whitcroft@canonical.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>, Jani Nikula <jani.nikula@intel.com>,
	Danilo Krummrich <dakr@redhat.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <f037df4a-8a97-4fcd-b196-43f484b63d8d@amd.com>
 <20240206101100.25536-1-daniel.van.vugt@canonical.com>
 <20240206101100.25536-2-daniel.van.vugt@canonical.com>
 <ZcJAVSyH3gRYx3EG@phenom.ffwll.local>
 <e4fc61ae-97f5-4fa1-bfed-1312466a2a22@amd.com>
 <26893900-2d0d-4624-94f1-c4aa88386e9c@canonical.com>
 <ZcNSleQOrBtSn3uM@phenom.ffwll.local>
 <88f3ff47-8c4b-424c-bf83-1570882cbb54@amd.com>
 <2a153cb6-4ece-4a37-9711-abdf4ba0ad50@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a153cb6-4ece-4a37-9711-abdf4ba0ad50@canonical.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Thu, Feb 08, 2024 at 09:16:50AM +0800, Daniel van Vugt wrote:
> On 8/2/24 04:21, Mario Limonciello wrote:
> > On 2/7/2024 03:51, Daniel Vetter wrote:
> >> On Wed, Feb 07, 2024 at 10:03:10AM +0800, Daniel van Vugt wrote:
> >>> On 6/2/24 23:41, Mario Limonciello wrote:
> >>>> On 2/6/2024 08:21, Daniel Vetter wrote:
> >>>>> On Tue, Feb 06, 2024 at 06:10:51PM +0800, Daniel van Vugt wrote:
> >>>>>> Until now, deferred console takeover only meant defer until there is
> >>>>>> output. But that risks stepping on the toes of userspace splash screens,
> >>>>>> as console messages may appear before the splash screen. So check the
> >>>>>> command line for the expectation of userspace splash and if present then
> >>>>>> extend the deferral until after the first switch.
> >>>>>>
> >>>>>> V2: Added Kconfig option instead of hard coding "splash".
> >>>>>>
> >>>>>> Closes: https://bugs.launchpad.net/bugs/1970069
> >>>>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>> Signed-off-by: Daniel van Vugt <daniel.van.vugt@canonical.com>
> >>>>>> ---
> >>>>>>    drivers/video/console/Kconfig    | 13 +++++++++++
> >>>>>>    drivers/video/fbdev/core/fbcon.c | 38 ++++++++++++++++++++++++++++++--
> >>>>>>    2 files changed, 49 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> >>>>>> index bc31db6ef7..a6e371bfb4 100644
> >>>>>> --- a/drivers/video/console/Kconfig
> >>>>>> +++ b/drivers/video/console/Kconfig
> >>>>>> @@ -138,6 +138,19 @@ config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> >>>>>>          by the firmware in place, rather then replacing the contents with a
> >>>>>>          black screen as soon as fbcon loads.
> >>>>>>    +config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> >>>>>> +    string "Framebuffer Console Deferred Takeover Condition"
> >>>>>> +    depends on FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> >>>>>> +    default "splash"
> >>>>>> +    help
> >>>>>> +      If enabled this defers further the framebuffer console taking over
> >>>>>> +      until the first console switch has occurred. And even then only if
> >>>>>> +      text has been output, and only if the specified parameter is found
> >>>>>> +      on the command line. This ensures fbcon does not interrupt userspace
> >>>>>> +      splash screens such as Plymouth which may be yet to start rendering
> >>>>>> +      at the time of the first console output. "splash" is the simplest
> >>>>>> +      distro-agnostic condition for this that Plymouth checks for.
> >>>>>
> >>>>> Hm this seems a bit strange since a lot of complexity that no one needs,
> >>>>> also my impression is that it's rather distro specific how you want this
> >>>>> to work. So why not just a Kconfig option that lets you choose how much
> >>>>> you want to delay fbcon setup, with the following options:
> >>>>>
> >>>>> - no delay at all
> >>>>> - dely until first output from the console (which then works for distros
> >>>>>     which set a log-level to suppress unwanted stuff)
> >>>>> - delay until first vt-switch. In that case I don't think we also need to
> >>>>>     delay for first output, since vt switch usually means you'll get first
> >>>>>     output right away (if it's a vt terminal) or you switch to a different
> >>>>>     graphical console (which will keep fbcon fully suppressed on the drm
> >>>>>     side).
> >>>>>
> >>>
> >>> I had similar thoughts, and had prototyped some of this already. But in the end
> >>> it felt like extra complexity there was no demand for.
> >>
> >> For me this one is a bit too complex, since if you enable the vt switch
> >> delay you also get the output delay on top. That seems one too much and I
> >> can't come up with a use-case where you actually want that. So just a
> >> choice of one or the other or none feels cleaner.
> 
> Remember the output "delay" goes to zero if any putc has occurred prior to
> registration (see dummycon.c).
> 
> My current reason for using both is that in theory it prevents fbcon from
> taking over *earlier* than it did before, in case there was never any output.
> But I don't think there is "never any output" by the time you've tried to
> manually VT switch so maybe that's unnecessary.

Yeah, but I'm not sure that's like a choice anyone needs, just these
three:

- no delay
- wait until first output, and set debuglevel appropriately (what fedora
  and other distros do)
- wait until first vt switch (what ubuntu wants)

I don't ever expect fedora to just enable this, because they have
something that works. Plus many distros are moving away from CONFIG_VT and
all the in-kernel consoles anyway, so they want this even less.

So if just the delay to first vt-switch is enough for you, I think it's
best we just implement that. The entire vt switch/ownership rules with drm
and fbdev and all that is already really complex and in many cases it's
impossible to tell what's accidental cargo-culted behaviour and what is
actually required. That's why I'd prefer we exactly implement what you
need in this area, nothing more, nothing less.

And from the testing you discuss below it sounds like you don't need both
delays?

Cheers, Sima

> >>> If you would like to specify the preferred Kconfig design then I can implement
> >>> it. Though I don't think there is an enumeration type. It could also be a
> >>> runtime enumeration (deferred_takeover) controlled by fbcon=something.
> >>
> >> There's a choice in Kconfig, see e.g. kernel/Kconfig.hz for an example.
> 
> Thanks!
> 
> >>
> >>>> IIUC there is an "automatic" VT switch that happens with Ubuntu GRUB + Ubuntu
> >>>> kernels.
> >>>>
> >>>> Why?
> >>>>
> >>>> Couldn't this also be suppressed by just not doing that?
> >>>
> >>> I have not seen any automatic VT switches in debugging but now that you mention
> >>> it I was probably only debugging on drm-misc-next and not an Ubuntu kernel.
> >>
> >> Hm but I don't see how the output delay would paper over a race (if there
> >> is one) reliable for this case? If you do vt switch for boot splash or
> >> login screen and don't yet have drm opened for display or something like
> >> that, then fbcon can sneak in anyway ...
> 
> There is no VT switch according to my logs, so there is no race with the
> patchset. The only race that occurs is without this patchset, which is what's
> being fixed here.
> 
> > 
> > Ubuntu has had in (at least some) kernels:
> > 
> > https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/unstable/commit/?id=320cfac8ef31
> > 
> > I'm unsure if it's still there today, but maybe it would be best if the author
> > (Andy) could enlighten us?  Any idea why that didn't go upstream?
> > 
> > I had thought that tied with a automatic VT switch that was trying to hide
> > fbcon as well.
> 
> I checked the current Ubuntu 24.04 kernel yesterday and there is no VT switch
> (anymore). The vc_num stays at zero until you do a manual VT switch. This seems
> to be true for both drm-misc-next and Ubuntu kernels.
> 
> There is still vt.handoff=7 on the command line for Ubuntu, but I'm not sure it
> has a function anymore. Maybe it was primarily for legacy BIOS? Andy can confirm.
> 
> > 
> >>
> >> Cheers, Sima
> >>>
> >>> - Daniel
> >>>
> >>>>
> >>>>> I think you could even reuse the existing
> >>>>> CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER for this, and then just
> >>>>> compile-time select which kind of notifier to register (well plus the
> >>>>> check for "splash" on the cmdline for the vt switch one I guess).
> >>>>>
> >>>>> Thoughts?
> >>>>>
> >>>>> Cheers, Sima
> >>>>>
> >>>>>
> >>>>>> +
> >>>>>>    config STI_CONSOLE
> >>>>>>        bool "STI text console"
> >>>>>>        depends on PARISC && HAS_IOMEM
> >>>>>> diff --git a/drivers/video/fbdev/core/fbcon.c
> >>>>>> b/drivers/video/fbdev/core/fbcon.c
> >>>>>> index 63af6ab034..98155d2256 100644
> >>>>>> --- a/drivers/video/fbdev/core/fbcon.c
> >>>>>> +++ b/drivers/video/fbdev/core/fbcon.c
> >>>>>> @@ -76,6 +76,7 @@
> >>>>>>    #include <linux/crc32.h> /* For counting font checksums */
> >>>>>>    #include <linux/uaccess.h>
> >>>>>>    #include <asm/irq.h>
> >>>>>> +#include <asm/cmdline.h>
> >>>>>>      #include "fbcon.h"
> >>>>>>    #include "fb_internal.h"
> >>>>>> @@ -3358,6 +3359,26 @@ static int fbcon_output_notifier(struct
> >>>>>> notifier_block *nb,
> >>>>>>          return NOTIFY_OK;
> >>>>>>    }
> >>>>>> +
> >>>>>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> >>>>>> +static int initial_console;
> >>>>>> +static struct notifier_block fbcon_switch_nb;
> >>>>>> +
> >>>>>> +static int fbcon_switch_notifier(struct notifier_block *nb,
> >>>>>> +                 unsigned long action, void *data)
> >>>>>> +{
> >>>>>> +    struct vc_data *vc = data;
> >>>>>> +
> >>>>>> +    WARN_CONSOLE_UNLOCKED();
> >>>>>> +
> >>>>>> +    if (vc->vc_num != initial_console) {
> >>>>>> +        dummycon_unregister_switch_notifier(&fbcon_switch_nb);
> >>>>>> +        dummycon_register_output_notifier(&fbcon_output_nb);
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    return NOTIFY_OK;
> >>>>>> +}
> >>>>>> +#endif
> >>>>>>    #endif
> >>>>>>      static void fbcon_start(void)
> >>>>>> @@ -3370,7 +3391,16 @@ static void fbcon_start(void)
> >>>>>>          if (deferred_takeover) {
> >>>>>>            fbcon_output_nb.notifier_call = fbcon_output_notifier;
> >>>>>> -        dummycon_register_output_notifier(&fbcon_output_nb);
> >>>>>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> >>>>>> +        if (cmdline_find_option_bool(boot_command_line,
> >>>>>> +              CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION)) {
> >>>>>> +            initial_console = fg_console;
> >>>>>> +            fbcon_switch_nb.notifier_call = fbcon_switch_notifier;
> >>>>>> +            dummycon_register_switch_notifier(&fbcon_switch_nb);
> >>>>>> +        } else
> >>>>>> +#endif
> >>>>>> +            dummycon_register_output_notifier(&fbcon_output_nb);
> >>>>>> +
> >>>>>>            return;
> >>>>>>        }
> >>>>>>    #endif
> >>>>>> @@ -3417,8 +3447,12 @@ void __exit fb_console_exit(void)
> >>>>>>    {
> >>>>>>    #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> >>>>>>        console_lock();
> >>>>>> -    if (deferred_takeover)
> >>>>>> +    if (deferred_takeover) {
> >>>>>>            dummycon_unregister_output_notifier(&fbcon_output_nb);
> >>>>>> +#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
> >>>>>> +        dummycon_unregister_switch_notifier(&fbcon_switch_nb);
> >>>>>> +#endif
> >>>>>> +    }
> >>>>>>        console_unlock();
> >>>>>>          cancel_work_sync(&fbcon_deferred_takeover_work);
> >>>>>> -- 
> >>>>>> 2.43.0
> >>>>>>
> >>>>>
> >>>>
> >>
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

