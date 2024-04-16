Return-Path: <linux-kernel+bounces-146501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9778A662D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D98B2145C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE7684D09;
	Tue, 16 Apr 2024 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7Gc0cIO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435B084A23
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256388; cv=none; b=f60FlccbZytKpgGhPymT9AEXT6OuMVNTrtVK9Wk6pgpOAjWJ5q38UYo3N7daQz5RXOcmLUv1QPVfNZNQFNiIESWkPfmlplojWU9ZOXThVwDUSuaV6zI4PttoVd4eF6enUS7mHUpHGPoOfQjfSFqA4F4V8NrWA3oGHSzvq841GfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256388; c=relaxed/simple;
	bh=E61E8H16GakIaEmE/TXSR6XZKZtY7a81hn578ZQMSOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svIageSYUX5mhSva4/7xevlA2bSC72JnqUzw/1BA/t5qkzO+q2ss9t6YMvW8HhgqWRAPAgD8HQbdxnTDjjutdnV/1ZzD8VotVTD2UWgAy7egENY9J0SPi8p1POv7e07PUIvvXLr6v+i+7GL7ITD/ktQTJZEgkR4jv0TuiIHtFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7Gc0cIO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713256386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzpK2jyxFnbS3uykXAlBWfyvSN7g3DKEoILwHz1vuj8=;
	b=D7Gc0cIOik8AqGwLjWsyHCmfi7O9e7Ce+XZHQCwxo1iCUTlPRRUzG3q9JOzG2+e8wruxiQ
	LmVaBY4gosdmWS9U2OQ+ALkcuTscLRF3+cyMD4b7Pbzt1aZH1v1eD9YO8Nbal7S5nUGoEw
	JIMARrecwgL3W7+cg8we7OZ0X58s6lc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-BM-9IFCPMlOaU0fK6HgIuQ-1; Tue, 16 Apr 2024 04:33:03 -0400
X-MC-Unique: BM-9IFCPMlOaU0fK6HgIuQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56e6ecbf5c6so2449242a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713256382; x=1713861182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzpK2jyxFnbS3uykXAlBWfyvSN7g3DKEoILwHz1vuj8=;
        b=w0oe7voe6F/bogblQn7q/OuZ67sc8/VzibRlwm1S44zwxrrV9PZTMhiaoJyFHE6X36
         PDKxEj5jizDYDDMYSZIUoR1O/ZmnECZYZ6FGKzoPd4+vxmAWifvjLk33vJP1Xm7k7MNv
         PwgH/acSGtk+KMUYNW9IDP6Dt0z5baWAeZQT7dlE09TyZou2eRmOkHOD6Xs6Tv8HjP7l
         zNUqjyB9NdqPErve63eqUNDlXepiYXsYP/pyuYOknD0l6ZN+2GP/3jPZS6+6wccD4Cz7
         i3VQo35CEg/AQbuZzZtRPX5acp1BEZXteSAXFHSWdF/fQk5etl2NWAvodEXsA6k1RPzq
         N9kA==
X-Forwarded-Encrypted: i=1; AJvYcCWWpfDJm00JBNe68m4t6jzxPln7+A/YvHpNX5YZ3RsemYnl3pbFYmHenwjvnKq0vud0Ymkhmr8wdprx4crNF5tW52vvQxbqoGxC3pFW
X-Gm-Message-State: AOJu0YzkPYFI7Tt8uRN7zWwYczTPrbqH95P6h0OgHcmolP52/KLC2ULg
	3u3QZgNhG9XX2g1lbN6Jk198ZBF6lkRduZptUcOE1H9aniFWAHhW+dCg157NFSDm+1PNRDYKhtK
	GbJg/FSMUBo+Lj6172l5NXRUucbDIVvYyF6dOS4qbc4hOJT7ih3O+Zh4dNZWPNQ==
X-Received: by 2002:a50:d716:0:b0:56e:63d3:cb3e with SMTP id t22-20020a50d716000000b0056e63d3cb3emr8580022edi.41.1713256382584;
        Tue, 16 Apr 2024 01:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmGRIbPaa1zBElQ+wLeSk/BgoY6QqwrgiNVIehp0etno1auNVqL5G4D3OtM6pxepLqXW5HPA==
X-Received: by 2002:a50:d716:0:b0:56e:63d3:cb3e with SMTP id t22-20020a50d716000000b0056e63d3cb3emr8580010edi.41.1713256382220;
        Tue, 16 Apr 2024 01:33:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l3-20020a056402124300b00570229afc16sm2671144edw.7.2024.04.16.01.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:33:01 -0700 (PDT)
Message-ID: <27b1b6cf-759c-4778-a53c-5d01442120b7@redhat.com>
Date: Tue, 16 Apr 2024 10:33:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info
 keycodes
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nitin Joshi1 <njoshi1@lenovo.com>, Vishnu Sankar <vsankar@lenovo.com>
References: <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com> <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
 <ZhcogDESvZmUPEEf@google.com>
 <91593303-4a6a-49c9-87a0-bb6f72f512a1@app.fastmail.com>
 <Zh2CtKy1NfKfojzS@google.com>
 <484638e2-1565-454b-97f8-4fcc6514a69c@redhat.com>
 <Zh2G85df29tPP6OK@google.com>
 <539776c5-6243-464b-99ae-5b1b1fb40e4b@app.fastmail.com>
 <Zh2wO0Bnyr8vFSpc@google.com>
 <7de52ec3-86f3-4a1d-ac87-a106ae1acb5d@app.fastmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <7de52ec3-86f3-4a1d-ac87-a106ae1acb5d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 4/16/24 1:57 AM, Mark Pearson wrote:
> Hi Dmitry,
> 
> On Mon, Apr 15, 2024, at 6:54 PM, Dmitry Torokhov wrote:
>> On Mon, Apr 15, 2024 at 04:28:19PM -0400, Mark Pearson wrote:
>>> Hi
>>>
>>> On Mon, Apr 15, 2024, at 3:58 PM, Dmitry Torokhov wrote:
>>>> On Mon, Apr 15, 2024 at 09:50:37PM +0200, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 4/15/24 9:40 PM, Dmitry Torokhov wrote:
>>>>>> On Wed, Apr 10, 2024 at 10:48:10PM -0400, Mark Pearson wrote:
>>>>>>>
>>>>>>> I have a stronger preference to keep the KEY_DOUBLECLICK - that one seems less controversial as a genuine new input event.
>>>>>>
>>>>>> Please see my response to Peter's letter. I think it very much depends
>>>>>> on how it will be used (associated with the pointer or standalone as it
>>>>>> is now).
>>>>>>
>>>>>> For standalone application, recalling your statement that on Win you
>>>>>> have this gesture invoke configuration utility I would argue for
>>>>>> KEY_CONFIG for it.
>>>>>
>>>>> KEY_CONFIG is already generated by Fn + F# on some ThinkPads to launch
>>>>> the GNOME/KDE control center/panel and I believe that at least GNOME
>>>>> comes with a default binding to map KEY_CONFIG to the control-center.
>>>>
>>>> Not KEY_CONTROLPANEL?
>>>>
>>>> Are there devices that use both Fn+# and the doubleclick? Would it be an
>>>> acceptable behavior for the users to have them behave the same?
>>>>
>>> Catching up with the thread, thanks for all the comments.
>>>
>>> For FN+N (originally KEY_DEBUG_SYS_INFO) the proposal was to now use
>>> KEY_VENDOR there. My conclusion was that this is targeting vendor
>>> specific functionality, and that was the closest fit, if a new keycode
>>> was not preferred.
>>
>> Fn+N -> KEY_VENDOR mapping sounds good to me.
>>
>>>
>>> For the doubletap (which is a unique input event - not related to the
>>> pointer) I would like to keep it as a new unique event. 
>>>
>>> I think it's most likely use would be for control panel, but I don't
>>> think it should be limited to that. I can see it being useful if users
>>> are able to reconfigure it to launch something different (browser or
>>> music player maybe?), hence it would be best if it did not conflict
>>> with an existing keycode function. I also can't confirm it doesn't
>>> clash on existing or future systems - it's possible.
>>
>> So here is the problem. Keycodes in linux input are not mere
>> placeholders for something that will be decided later how it is to be
>> used, they are supposed to communicate intent and userspace ideally does
>> not need to have any additional knowledge about where the event is
>> coming from. A keyboard either internal or external sends KEY_SCREENLOCK
>> and the system should lock the screen. It should not be aware that one
>> device was a generic USB external keyboard while another had an internal
>> sensor that recognized hovering palm making swiping motion to the right
>> because a vendor decided to make it. Otherwise you have millions of
>> input devices all generating unique codes and you need userspace to
>> decide how to interpret data coming from each device individually.
>>
>> If you truly do not have a defined use case for it you have a couple
>> options:
>>
>> - assign it KEY_RESERVED, ensure your driver allows remapping to an
>>   arbitrary keycode, let user or distro assign desired keycode to it
>>
>> - assign KEY_PROG1 .. KEY_PROG4 - pretty much the same - leave it in the
>>   hand of the user to define a shortcut in their DE to make it useful
>>
>>>
>>> FWIW - I wouldn't be surprised with some of the new gaming systems
>>> we're seeing (Steamdeck, Legion-Go, etc), that a doubletap event on a
>>> joystick might be useful to have, if the HW supports it?
>>
>> What would it do exactly? Once we have this answer we can define key or
>> button code (although I do agree that game controller buttons are
>> different from "normal" keys because they map to the geometry of the
>> controller which in turn defines their commonly understood function).
>>
>> But in any case you would not reuse the same keycode for something that
>> is supposed to invoke a configuration utility and also to let's say
>> drop a flash grenade in a game.
>>
> 
> Understood.
> 
> I don't see a path forward within your stated parameters. I did not realise that there were such limitations, so my apologies for wasting everybody's time, and thank you for your patience and guidance.
> 
> I will drop this patch from the series and proceed using existing defined codes only.
> 
> Hans, I'll need to rejig things a bits but I have some ideas and I think I can make it work and stay within the pdx86 tree, which will make it simpler.

Ok this sounds good to me. For Fn + N using KEY_VENDOR sounds good for
me and for the doubletap any one of KEY_CONFIG/KEY_CONTROLPANEL/KEY_INFO/KEY_PROG1
or some other suitable KEY_foo define works for me.

Regards,

Hans




