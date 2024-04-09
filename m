Return-Path: <linux-kernel+bounces-136248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B922B89D1E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECCA4B22E88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC490433BC;
	Tue,  9 Apr 2024 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCnTq9pi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00F56455
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 05:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712640250; cv=none; b=jZjWcJnm+pUW6PkNj+neQfTbfaMVxQpdR4DaqgFSayBTyA2yw9I6ZajkK5AmxFKDbMKj6OVypWWhDnzcUEzTCeviQ/skB9PQ5b8wFQB70t66bbjCZ9fmpNXGm3LLOCYB338WUvbQJFXOc0PRFypJkNyDK2PGq+pujYYNF0t0+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712640250; c=relaxed/simple;
	bh=2yzdMPsQjZBKbu2RsG7bppQbPga9w4g4BiLWfpVbzx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIvr8KxXFuPac1p41qnjPoOBcAPh5jCHqW0Ko3DdyLgy76nNpDHL4TogW5kCDzTXg0YY1GhG2+HBqGWgMIA393DLvizzxmx0GR4+rahFe53/jGHpJ8rgXZ53/B1lrLfloEKWBYwlZdDE7OWleAsN8yTMWQUf6UqxbTXFMHA+Cdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCnTq9pi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712640247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdDr1Hl3PFGnhdknuMQtRh93bfh1USz5GSeKZpt2kZY=;
	b=XCnTq9pioMPYFoyfPPxsIl1/RRUxvqYLSrX+eam60YrtGIno8vzv1rRkNLMdV8327P/UPE
	BlHgJxCpcrQL4E4PiYSQqyq4hWlII2z5bZvnyPhvIDwRfPlAPrml7bM2RUfFZN2eUGgTWq
	80O6QCWgle8AjyKVKTnr3l/fIjErXxE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-diXIfWJSPnWiVnoGRbcTUA-1; Tue, 09 Apr 2024 01:24:04 -0400
X-MC-Unique: diXIfWJSPnWiVnoGRbcTUA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a4f59746f7so1653839a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 22:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712640240; x=1713245040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdDr1Hl3PFGnhdknuMQtRh93bfh1USz5GSeKZpt2kZY=;
        b=H9XRQoN0KDW2TbYuNdUV/PI6natfXI1OD8fz97Vrx947Pfsd6XHOzFUoTaY0eZ99sT
         LSEbetBQoO1+92LepoZn5uKXrJrxcnqSHpXYDVZZdhGgaF/hi30b4AjejEFBin+LAErg
         SrTRlvWMJKyaEp4RTEUpWQNWU5aKPVS5vIg0r1ieP/6ckju+jEgYJ7F3G1ZvHd/CaBsc
         /qI9pCVHDJaot3FddOHBuDwQ2EXF0sVJsQ9yKdqnjqhbp0TCFYaFTUXQeabQlJ1s2xnA
         zwbBluWLMaGACzPdyfzl6A8S9Gk80cJDG8xuKzrzrNq+2fQqgl3p2RoO+UMlOc8wIDZp
         U50Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHIvxzagSjQiSJx7qZBnTqDeddDa/HX/RNwBziViG4FCwbqkgDQUJkn+b0oQ4z2fwUh2zoDurHbsjlZLwim6sRGJOVo55WX0+4su1W
X-Gm-Message-State: AOJu0YwKfSr6QbIAnhIRuoMYCA4wHSoNYyJn3e816IFoGpMAxTltLWSk
	ZHIwVX5kfHCmoP2RWK9H8Y93aLXdjJb5BMXV2ARHbB4e8u3+7fJ8JjcpBIQpfFfk2Yu4QFb11bk
	HWqTL//r/tiZQpy7LgfoCxNQq6AR1jN4+xxQb+ObTqgnMwefTAMysWHC0a++khA==
X-Received: by 2002:a17:90a:17c6:b0:2a2:bc9d:f44f with SMTP id q64-20020a17090a17c600b002a2bc9df44fmr7783878pja.13.1712640240446;
        Mon, 08 Apr 2024 22:24:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHaRZwSrquXWFWvjYyvbfJbti9WAgNhMn8ACwIQ4BNfAmRp+5jeTjoHsnaXWUTVhQlgYU/Dw==
X-Received: by 2002:a17:90a:17c6:b0:2a2:bc9d:f44f with SMTP id q64-20020a17090a17c600b002a2bc9df44fmr7783868pja.13.1712640240075;
        Mon, 08 Apr 2024 22:24:00 -0700 (PDT)
Received: from [192.168.1.240] (117-20-68-143.751444.bne.nbn.aussiebb.net. [117.20.68.143])
        by smtp.gmail.com with ESMTPSA id cu12-20020a17090afa8c00b002a2f6da006csm7344186pjb.52.2024.04.08.22.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 22:23:59 -0700 (PDT)
Message-ID: <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
Date: Tue, 9 Apr 2024 15:23:52 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info
 keycodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, hmh@hmh.eng.br,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 njoshi1@lenovo.com, vsankar@lenovo.com
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
Content-Language: en-US, en-AU
From: Peter Hutterer <peter.hutterer@redhat.com>
In-Reply-To: <ZhR-WPx7dgKxziMb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/04/2024 09:31, Dmitry Torokhov wrote:
> Hi Mark,
> 
> On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
>> Add support for new input events on Lenovo laptops that need exporting to
>> user space.
>>
>> Lenovo trackpoints are adding the ability to generate a doubletap event.
>> Add a new keycode to allow this to be used by userspace.
> 
> What is the intended meaning of this keycode? How does it differ from
> the driver sending BTN_LEFT press/release twice?
>>
>> Lenovo support is using FN+N with Windows to collect needed details for
>> support cases. Add a keycode so that we'll be able to provide similar
>> support on Linux.
> 
> Is there a userspace consumer for this?

Funnily enough XKB has had a keysym for this for decades but it's not hooked up anywhere due to the way it's pointer keys accessibility feature was implemented. Theory is that most of userspace just needs to patch the various pieces together for the new evdev code + keysym, it's not really any different to handling a volume key (except this one needs to be assignable).

Cheers,
   Peter


