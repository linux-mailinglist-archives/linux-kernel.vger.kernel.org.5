Return-Path: <linux-kernel+bounces-96361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DCB875B04
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3699B21BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C7D3EA93;
	Thu,  7 Mar 2024 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZLaomJQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453272E648
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853624; cv=none; b=a/TQdqpf7e83jI6LaazvjlFDnB1KtwI2jwGdFURcLfXkLf7rlbgkNS9dAo/up1/aPouZ8lnTwb8kb2k4e4R06IPvUriDRIGM2dRS2AmY4ef1elFd7MDB6u6egZGTnwbM+Y6Rj3WVXPPkxV/hlVW3RGWDxROOBiHMpeduG+tI5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853624; c=relaxed/simple;
	bh=agNt3C2jOYAHGie0SAiQxmpT+38zGiDHSuMBI7hCg3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KCsEJCZCsPTaUJBi41zeBOO78sk07NtDxXRlr5N6fmIoxwUeNloj6/FBEEOtH+/mMeTV/ONkRivq8RQHTergw+g4gdm4Z8uvwGv5Ld81FXeZpusvFHu+xWu6uLecu7DmkEeYMocN+14gmnY6+hGb6qD9pD6aFv96fyxF46TFUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZLaomJQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709853621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxxmZE6gWr1Q0ffkqL6nm6WL/FHa8/Xvq98NPQWjXwc=;
	b=iZLaomJQ95d01remrWRl6FW2yUet4VucVweoXDVcBgX6Jmiq1du6juPv9Zd2Vf0Twkb1Gk
	OUqUbPlFTN6gS9iSzkb7RjjbEFoBQBV77bDYMouzQ0Mc0Oj6d5a5LIpWEPE+ru4VB87BEO
	OehmhWLV1BhHUIRvdUG3+KqUY+IHz64=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-ZyXzrZylNr-gdPOleTzKzw-1; Thu, 07 Mar 2024 18:20:19 -0500
X-MC-Unique: ZyXzrZylNr-gdPOleTzKzw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4131765ac62so802065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 15:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709853618; x=1710458418;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxxmZE6gWr1Q0ffkqL6nm6WL/FHa8/Xvq98NPQWjXwc=;
        b=hTW1tDYX8wuy3W3HfJ4J7YDDO6MhuGH7sBuT1zHUezcAWMvUXk43XFHjaSlXLk6lPJ
         4hCYMeTdFfpEtZ0JpwxYjbrtc3GK6WWzhmkZsE1LXvh/THWnHTCTPBW66aiAN4JWKztG
         xUzHhysqbFG9AjFhk0oScwE830vygHCCJYtm4dVW+GphBGM5XIZnRCss5wN//lVzYRou
         tblcGYWaTgFJ3j5AWzK2uDy9XtmzA7Rj+KWVGZwqF50yvefBDKTmJxGoBxkt/5kjQXk9
         Dup7w6E+hiTX007Bv7Tpob6KYRjZZdINqcG/ItP7PjF4UEevpHhOHiRJwgxJF9C/hqM1
         muVg==
X-Gm-Message-State: AOJu0YyC4+9Reo+98j3BWLkuXmEHIJLeQiqDV0JCFZKQWenSCwIhInDR
	XgdGE6/d/y72dkASbV/aUePKowqRNucuJH3YU9SFP5/4o5s2fFuWG84wTpt/wG9U/CQgiazHCvn
	7kMuGu9nDDL2D2+EXcYGEpfF/UiTyYxWsNGvZMConesfRKACMiqdaLtqa+sATvg==
X-Received: by 2002:a05:600c:4e0b:b0:412:f6d0:5e4a with SMTP id b11-20020a05600c4e0b00b00412f6d05e4amr4613103wmq.26.1709853618176;
        Thu, 07 Mar 2024 15:20:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJrmXULn39Ym+I+StRYJc4YygrseCvY2zmMJvlg/LzhqDYc62LWNr63chYuj8PKFhtlL3y5A==
X-Received: by 2002:a05:600c:4e0b:b0:412:f6d0:5e4a with SMTP id b11-20020a05600c4e0b00b00412f6d05e4amr4613089wmq.26.1709853617606;
        Thu, 07 Mar 2024 15:20:17 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b0041312cf472fsm2373714wmq.25.2024.03.07.15.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:20:17 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, javier@dowhile0.org, Andrew Halaney
 <ahalaney@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] driver core: Don't set a deferred probe timeout if
 modules are disabled
In-Reply-To: <2024030722-explicit-juror-9ba7@gregkh>
References: <20240227231001.648698-1-javierm@redhat.com>
 <2024030722-explicit-juror-9ba7@gregkh>
Date: Fri, 08 Mar 2024 00:20:16 +0100
Message-ID: <875xxxsk7j.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Wed, Feb 28, 2024 at 12:09:02AM +0100, Javier Martinez Canillas wrote:
>> There is no point to schedule the workqueue to timeout the deferred probe,
>> if all the initcalls are done and modules are not enabled. The default for
>> this case is already 0 but can be overridden by the deferred_probe_timeout
>> parameter. Let's just skip this and avoid queuing work that is not needed.
>
> As the option is already there to set the timeout to 0, why confuse
> things by trying to tie this to if modules are enabled or not?  And even

Because the timeout is already tied to whether modules are enabled or not [0]:

#ifdef CONFIG_MODULES
static int driver_deferred_probe_timeout = 10;
#else
static int driver_deferred_probe_timeout;
#endif

static int __init deferred_probe_timeout_setup(char *str)
{
	int timeout;

	if (!kstrtoint(str, 10, &timeout))
		driver_deferred_probe_timeout = timeout;
	return 1;
}
__setup("deferred_probe_timeout=", deferred_probe_timeout_setup);

Since that's already the case, it makes no sense to allow this option to
be set when modules is not enabled IMO.

That will just cause to schedule a workqueue for no good reasons, since it
happens at late_initcall() after all the initcall functions for built-in
drivers have already been executed.

[0]: https://elixir.bootlin.com/linux/v6.8-rc7/source/drivers/base/dd.c#L259

> if you do want to do that, where did you now document this new system
> behavior?
>

I thought about it but the current behaviour is also not documented [1],
in fact most of the help text for the deferred_probe_timeout= option is
still from the time when it was introduced _only_ as a debugging option
by 25b4e70dcce9 ("driver core: allow stopping deferred probe after init").

Later, c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state()
logic") and e2cec7d68537 ("driver core: Set deferred_probe_timeout to a
longer default if CONFIG_MODULES is set"), tied the behavior and default
timeout to whether the modules were enabled or not. And those two commits
did not document the behavioural changes in the kernel option help either.

I can update the kernel-parameters.txt in the next iteration if you agree
with the change.

[1]: https://elixir.bootlin.com/linux/v6.8-rc7/source/Documentation/admin-guide/kernel-parameters.txt#L1035

> thanks,
>
> greg k-h
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


