Return-Path: <linux-kernel+bounces-146503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546BC8A6637
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B400EB25C24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4E82860;
	Tue, 16 Apr 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeZbOWaa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83476EEB7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256529; cv=none; b=nakA5Ys4hqo8C6ainXX1w4d2hPpiyPt0lePmGNlbjNdyZoymZEVmYPkmzvEgSOQ9iQPf0VeAd7l2yBzwXTXPS3rEppwyXYW7O3lZwhL4xD/Ry0UeDJFDnR0dVNbfWAvQ6d8bJYrBZV0pF0Z4Pv7Rfpjj7yusRprpEjwamkJhleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256529; c=relaxed/simple;
	bh=t96Grci89Hj3Fv+275ZZvzDuX9j3ZzLEJyheAvKRgig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcjdRQSCp3BIIM2su6Ksv/36z/ObitKA+sXDHdhO4sDWvrdkNtgWRg4EjXh3J4qDLU7PPcfZSMLbLJ+jCg0c1Gxf/Le96fNJVYTZbs/PkAfe/DD40+Fb0slXDfCx/ayieX1B78fO83/E6gco+O9wo5WpIZ1YND+qenfK1nd8xPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GeZbOWaa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713256526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqB42b0Dt4aCzlHrsBwMSNL2dlraPP0p7qf/q2hbpaA=;
	b=GeZbOWaa0OuiTv3Jw4PYOGGnKZ/TNW3kSosIDhVz1ujFU9i3wjQf0c079+HopAxgZkYZDa
	0vaqgUEhP+W4uDyd9QctRi2p6Hj9oHezSAv2Ftxu8sgY5BM6hYW3M/5fZJ76AP/G8ITxKB
	x+c2NdVetUpf++Z7eOiNaj7r130cFlo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-WEQWRE1eP8-HQyLEef1vAQ-1; Tue, 16 Apr 2024 04:35:25 -0400
X-MC-Unique: WEQWRE1eP8-HQyLEef1vAQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5704900f94fso137453a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713256524; x=1713861324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqB42b0Dt4aCzlHrsBwMSNL2dlraPP0p7qf/q2hbpaA=;
        b=TdxKUKJ+N4ls+QQIrdExVU1rBfUqb6t5TQrPOoXtS0f9yQ6pSI1VU/5vomrdhc60Wl
         Z9+6nE+fuS1Liv7q/Ewspacy0WxoNkY0cpdxoc7vVeeyDFb4M1tUwcFIZH/6d59Wg99Q
         mGtE9rF7DiH0vsWy637ibU/cXYdblO2YkGx9k7SFbeD8Pg6AvBc7UjzpP+2dROl2MggB
         hZdSpLykrYNY4lfIDFWkaOX+hvtwwrUVr/DITwGZwaNBUX+gTBGyYk43xq1WpnI+spny
         ukRjJw6VH2KcNc4bVzkz7df3zhGwb15+b86T1+9zAz09opBwDGePcOYUBlrTulTD3HG5
         PPcw==
X-Forwarded-Encrypted: i=1; AJvYcCVnOopDgO66cokpvW8MioBfvRgnAj2XkJVH8KJpXm+I6Bwx7wQM532b/50D1opd2lAGuSPqtid/ri3/0n0d/UX7Kxt/bnxtogX2dwEh
X-Gm-Message-State: AOJu0YwNOof7+3YqaUGfjwKYTkJ5+x5ujbA4q/WSJU5pm4SKwtbpyy5b
	vLALwhEff6dWzasars5PNjwSOT2BuRqrQ/03B4ge0ae7xSoAJ2yATKHkWf5Ncoz33OpUAfaqen0
	vW4g7mFKCDTr6SScooXUMhCcV1QyfY93JM4TbIFfZepHgjXbHpZlB2HuzzQfqE2DpkWuk8A==
X-Received: by 2002:a50:cd04:0:b0:56d:f637:451c with SMTP id z4-20020a50cd04000000b0056df637451cmr7419236edi.32.1713256523852;
        Tue, 16 Apr 2024 01:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH09YFiUxZaU1utW3PoJytxXwlh9BUF5b0iDmnwb9dAZxMMtiyt2VQVzkI0t44Hn5rRN+kOdQ==
X-Received: by 2002:a50:cd04:0:b0:56d:f637:451c with SMTP id z4-20020a50cd04000000b0056df637451cmr7419225edi.32.1713256523511;
        Tue, 16 Apr 2024 01:35:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id n7-20020a056402434700b0056e66f1fe9bsm5766826edc.23.2024.04.16.01.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:35:23 -0700 (PDT)
Message-ID: <ab98ff25-2ab3-4ab6-ae46-84aef6369c3c@redhat.com>
Date: Tue, 16 Apr 2024 10:35:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info
 keycodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Peter Hutterer <peter.hutterer@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nitin Joshi1 <njoshi1@lenovo.com>, Vishnu Sankar <vsankar@lenovo.com>
References: <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com> <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
 <ZhcogDESvZmUPEEf@google.com>
 <91593303-4a6a-49c9-87a0-bb6f72f512a1@app.fastmail.com>
 <Zh2CtKy1NfKfojzS@google.com>
 <484638e2-1565-454b-97f8-4fcc6514a69c@redhat.com>
 <Zh2G85df29tPP6OK@google.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zh2G85df29tPP6OK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/15/24 9:58 PM, Dmitry Torokhov wrote:
> On Mon, Apr 15, 2024 at 09:50:37PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 4/15/24 9:40 PM, Dmitry Torokhov wrote:
>>> On Wed, Apr 10, 2024 at 10:48:10PM -0400, Mark Pearson wrote:
>>>>
>>>> I have a stronger preference to keep the KEY_DOUBLECLICK - that one seems less controversial as a genuine new input event.
>>>
>>> Please see my response to Peter's letter. I think it very much depends
>>> on how it will be used (associated with the pointer or standalone as it
>>> is now).
>>>
>>> For standalone application, recalling your statement that on Win you
>>> have this gesture invoke configuration utility I would argue for
>>> KEY_CONFIG for it.
>>
>> KEY_CONFIG is already generated by Fn + F# on some ThinkPads to launch
>> the GNOME/KDE control center/panel and I believe that at least GNOME
>> comes with a default binding to map KEY_CONFIG to the control-center.
> 
> Not KEY_CONTROLPANEL?

No when this was added most distros were still using X11 not Wayland so
it was preferable to use KEY_foo symbols with codes below 240.

> Are there devices that use both Fn+# and the doubleclick? Would it be an
> acceptable behavior for the users to have them behave the same?

That is a good question, at least my current ThinkPad does not have
the Fn + F## combo for the control center anymore. So I guess we could
indeed re-use KEY_CONFIG for the double-tap.

Regards,

Hans



