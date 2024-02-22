Return-Path: <linux-kernel+bounces-76523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C085F860
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA2A1F26929
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B96D12DD96;
	Thu, 22 Feb 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeJWNPbz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3512D756
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605553; cv=none; b=UlFgqhkIcYQw7ukAYiyIRCyLpKHEpWF4E1zlnUWQqzezcRodMgC3JuzUdQjYNUEeWB003v0XfESLARB2rXP1FmT98GKsipz+vgrDOpy0IqLU7hfIsvI7bq7bhSYSEmJart6HnA8xFh04KXfDQEhdzowKOpw0U6xZplVrtvWDdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605553; c=relaxed/simple;
	bh=A9/2Z2e/Wolvr+TkJMMv6W92q5TwTKl5h3cwWrEQIqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEeE7vpMx7fY+muy+F/T6hBGHA2s7LRCK6PC0WJ+yiObSCj31t/QEl2ohO7hGo8LsQv4ejPJgO6nsLwSq3Obx2VC4fI1aZk8xHJatK2Us78kJKl+keH389B4GGvORTE88s9J1UzqnWib2Z/avqN7izUyvqjH6nVFAhbI6sCFnoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeJWNPbz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708605550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BERBpKjH6+/bGhkBw+85S7JQ5x9o2AKS4RztDXQg4B4=;
	b=BeJWNPbzDCebiWi6zA4I760T2e+nFaJbnHkzkkMXDKAyEx7tA4p+FPSWlaHcdVjseliyuL
	kUX0giCkY8LucPYLbDUlhV8+urqOvB/47OBYWsnJIBPjhK7vlfefHTxj+obw0S/VrAQRrQ
	UrV4xFyaoolBee/DwVukMoUVeFmcb4k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-guD2SgfiM6y5fBebnaMrnQ-1; Thu, 22 Feb 2024 07:39:09 -0500
X-MC-Unique: guD2SgfiM6y5fBebnaMrnQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3ee69976dfso154110066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708605548; x=1709210348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BERBpKjH6+/bGhkBw+85S7JQ5x9o2AKS4RztDXQg4B4=;
        b=tlI9d/4NC/oXfogNHVx4AYnV6CE6e3u26EmmpqMUv36OglnR5NyFCOBHlEp5r4xGcC
         pp6PDVfcNxfH2vY0AjBTDs0MNK5OwPH+66OcAh0cSkzPEN9Xq7mKMT7djnAQ0EhVvYqB
         j1Rdc5l/eJcjOE1uBuDriKlcbxHNlk+rvV5S9uLwe7IjurK84KPk8EP5Oz/r6F/6zqkJ
         +/eZHoPfQJXWfIkmWUU73dgoRivgSkfcrT0lk3hw6yBLXJj4hHcTGSQf1p830LKbGlOK
         M1GwwHlD8jbooQAIgImhzjlnDcjuUcpf1YFSiGX9SK1jWc5zFpVGll5QrAfMhK2dFl9Z
         jgVw==
X-Forwarded-Encrypted: i=1; AJvYcCV9JVYHSjhH36tOeLSrB/GwkXq5GMuWp+5aAM+SOSKMkGB8uikA5v7IdUMTgt5HW7z71vKg4husu0F2yG3I22uSHl4ZY4mC4JEEsEEG
X-Gm-Message-State: AOJu0YzKH8yVR2D49vINRj+ElvSzdp64JIrtaavbJi8CkARm7xMCi76d
	e+MynQumPV47owQsUYNK+I3enFTrABtFMyoa+hdq3oiOtu3g5nYqUSHRXBSScRCjWPZ7ArOmhNk
	DdEbbMNs1j/epuOLGOwTsnwXAte4AZUT/5IB0eekfcjrfXM+YGTOO/kWDOORgloL0Lv40OA==
X-Received: by 2002:a17:906:407:b0:a3e:a3dc:45c9 with SMTP id d7-20020a170906040700b00a3ea3dc45c9mr7716004eja.72.1708605548117;
        Thu, 22 Feb 2024 04:39:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj7dB0iOnvtjM8nL87yde9xp+FwpKAGy0QKGBTz8j82TooN3WqgozN46dnwDBExLoaRc63YQ==
X-Received: by 2002:a17:906:407:b0:a3e:a3dc:45c9 with SMTP id d7-20020a170906040700b00a3ea3dc45c9mr7715991eja.72.1708605547809;
        Thu, 22 Feb 2024 04:39:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lu16-20020a170906fad000b00a3d5efc65e0sm4599899ejb.91.2024.02.22.04.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 04:39:07 -0800 (PST)
Message-ID: <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>
Date: Thu, 22 Feb 2024 13:39:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Future handling of complex RGB devices on Linux v2
To: Gregor Riepl <onitake@gmail.com>, Werner Sembach <wse@tuxedocomputers.com>
Cc: Lee Jones <lee@kernel.org>, jikos@kernel.org,
 linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>
References: <0cdb78b1-7763-4bb6-9582-d70577781e61@tuxedocomputers.com>
 <7228f2c6-fbdd-4e19-b703-103b8535d77d@redhat.com>
 <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
 <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
 <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com>
 <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
 <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
 <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
 <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/22/24 12:38, Gregor Riepl wrote:
>> This certainly is the most KISS approach. This proposal
>> in essence is just an arbitrary command multiplexer /
>> demultiplexer and ioctls already are exactly that.
>>
>> With the added advantage of being able to directly use
>> pass the vendor-cmd-specific struct to the ioctl instead
>> of having to first embed it in some other struct.
> 
> There's also the question of how much complexity needs to remain in the kernel, if vendor-specific ioctls are made available.
> 
> Does every vendor driver implement a complex mapping to hardware registers? What about drivers that basically implement no mapping at all and simply forward all data to the hardware without any checking? The latter case would match Pavel's concerns, although I don't see how this is any different from the situation today, where userspace talks directly to the hardware via libusb etc.

This whole discussion got started by embedded-controller driven
keyboards in laptops with per key RGB lighting. We cannot just
allow userspace raw-access to the embedded-controller.

So these per vendor ioctl commands will need to do the minimum
to make sure userspace cannot do bad things. But yes complex
stuff like figuring out which LED(s) maps to say the enter key
should be left to userspace.

Especially since this can differ per keyboardlayout.

> To be honest, I think the kernel shouldn't include too much high-level complexity. If there is a desire to implement a generic display device on top of the RGB device, this should be a configurable service running in user space. The kernel should provide an interface to expose this emulated display as a "real" display to applications - unless this can also be done entirely in user space in a generic way.

We really need to stop seeing per key addressable RGB keyboards as displays:

1. Some "pixels" are non square
2. Not all "pixels" have the same width-height ratio
3. Not all rows have the same amount of pixels
4. There are holes in the rows like between the enter key and then numpad
5. Some "pixels" have multiple LEDs beneath them. These might be addressable
   per LEDs are the sub-pixels ? What about a 2 key wide backspace key vs
   the 1 key wide + another key (some non US layouts) in place of the backspace?
   This will be "2 pixels" in some layout and 1 pixel with maybe / maybe-not
   2 subpixels where the sub-pixels may/may not be individually addressable ?

For all these reasons the display analogy really is a bit fit for these keyboards
we tried to come up with a universal coordinate system for these at the beginning
of the thread and we failed ...

Regards,

Hans



