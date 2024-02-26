Return-Path: <linux-kernel+bounces-81841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAEF867BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04424B303E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D81712C52D;
	Mon, 26 Feb 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egPD9z/b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F812BEBD
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962581; cv=none; b=JJkeAgAnO4hq2eeuj9ozAi7GVeDLJMmlqYfF//JtTOf5GfkIVC6muOIh8lB1bGMyIYW8lZBBrtnwJehTxw7SE1uyRmS1diIzRvycVuQD6rvyyR9LQ1O+P2plIyvP4Fj8SUdoYohup1e3K7WRARqTq0rsQ8IrQJyFhMb3+RwjKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962581; c=relaxed/simple;
	bh=Oh5CsBBlobRYygAYm4MkY9Kh99N79OCnEqvDML9+AVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahxtP0SbkszHR3jRkTI2xeoqFOPqx6oNJEDlv5ytqR95vT8Wf4yIHp9yeDRO/3LJoGEYYEt2IbOQd79Iu9iOUnqmKv9O8m6VPX+t/wEWOfyeBrC3NjVPH9h4Zuj8TudSjcgpGnCTzx1E90hqRZY3m9riwOGFul6mJsCqRNnlpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egPD9z/b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708962578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhYMCOuaBDTEq4hFntP2XN/jZc/12pZFEht7y217G0c=;
	b=egPD9z/bGL1tp4fVSa+vreLqOl7Q6CE7p1Rifc1xn7pey1+GWBYu5ZWLt6GGRTepT319PS
	SVzCwfUWHyz5GswZUTrlLckpLyi7VDF31Gt2W+dnFKcHHIVAP04v3jGWHA+utLn/uQ2F+j
	wzJDg9H/p3TDeLHOgt7ahGFhd5YWgIo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-dlolbgQjOQK-DocPXG8W5g-1; Mon, 26 Feb 2024 10:49:37 -0500
X-MC-Unique: dlolbgQjOQK-DocPXG8W5g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68f74a0a3c7so49398936d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962576; x=1709567376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhYMCOuaBDTEq4hFntP2XN/jZc/12pZFEht7y217G0c=;
        b=FV+cVyzUCG5KNFWEv4MmlL1+Z+3EoyUKJoACVwfWiUjE2AUdZfmKUcplfcMiVwfo6x
         WuQRIC8u6H0WTgGn0IBj9xOaMeoeD+DA0RDRx4M0etTbu+E1WAtOCjTnS+YuryImo6FE
         QuBwhAaByfHtIbo9SQgRljR6m02MhJ8XWwvPptnQa8JoP1pR9hTqbH4Btbx3vntUvWUS
         l11/MimObk1vbf2XhpRj43RN4nDsaBX38fYz3MvWBWOqtWnM1JuMdNoWNempZMxbLfqm
         IxdTfRv24Urf2Ph0DfYwLxopvlZT1mPcuYs8AlBPq21szy/dZPp+a7hRUcoh38EQuUxe
         cKKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW59SMhPlvtkFJCDKuJY4j1CqxH+h+v9AG7vVgi0nU6Sei6juF288X0RZF6gRocUi9wOjq/hVjNgRYsCVAKbCmP7+gz4KAWlIXQlweB
X-Gm-Message-State: AOJu0YyJjHUhyt2FURzKM/0JW1q9TWK7BFgwiXkSfOde7Rccniw5oY/I
	6DQjAqV8nAOXwX6ZqjOf+E3JRI9yx5AFq2ac0hk1yVs8Lj1ZpEHd/XmBL/7NJ0E4e5sKHLlhILY
	TkBY/njWONAhsXkce2l6P5tU/7c3OFrHUeYqkH6e9pjDLRee4woYS4BgvtJt4cQ==
X-Received: by 2002:a0c:f103:0:b0:68f:4fd6:ae35 with SMTP id i3-20020a0cf103000000b0068f4fd6ae35mr8036375qvl.6.1708962576707;
        Mon, 26 Feb 2024 07:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHnNM8x1qAleAD38+Gu2vMTLOhwZtljhx/ociuJFMUmmimUfOHk7mxa9cX80DmzHTa50cvaQ==
X-Received: by 2002:a0c:f103:0:b0:68f:4fd6:ae35 with SMTP id i3-20020a0cf103000000b0068f4fd6ae35mr8036362qvl.6.1708962576461;
        Mon, 26 Feb 2024 07:49:36 -0800 (PST)
Received: from [10.0.0.33] (modemcable096.103-83-70.mc.videotron.ca. [70.83.103.96])
        by smtp.gmail.com with ESMTPSA id em19-20020ad44f93000000b0068f0ff36defsm3035281qvb.47.2024.02.26.07.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:49:36 -0800 (PST)
Message-ID: <def1a153-3cfb-431d-a7d2-a13bb7d65f4f@redhat.com>
Date: Mon, 26 Feb 2024 10:49:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/mellanox: mlxbf-pmc: Fix module loading
Content-Language: en-US, en-CA
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 shravankr@nvidia.com
Cc: davthompson@nvidia.com, ndalvi@redhat.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, hdegoede@redhat.com
References: <cover.1708635408.git.luizcap@redhat.com>
 <170895404513.2243.14840310263795846559.b4-ty@linux.intel.com>
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <170895404513.2243.14840310263795846559.b4-ty@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-26 08:27, Ilpo Järvinen wrote:
> On Thu, 22 Feb 2024 15:57:28 -0500, Luiz Capitulino wrote:
> 
>> The mlxbf-pmc driver fails to load when the firmware reports a new but not
>> yet implemented performance block. I can reproduce this today with a
>> Bluefield-3 card and UEFI version 4.6.0-18-g7d063bb-BId13035, since this
>> reports the new clock_measure performance block.
>>
>> This[1] patch from Shravan implements the clock_measure support and will
>> solve the issue. But this series avoids the situation by ignoring and
>> logging unsupported performance blocks.
>>
>> [...]
> 
> 
> Thank you for your contribution, it has been applied to my local
> review-ilpo branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo branch only once I've pushed my
> local branch there, which might take a while.

Thank you Ilpo and thanks Hans for the review.

The only detail is that we probably want this merged for 6.8 since
the driver doesn't currently load with the configuration mentioned above.

- Luiz

> 
> The list of commits applied:
> [1/2] platform/mellanox: mlxbf-pmc: mlxbf_pmc_event_list(): make size ptr optional
>        commit: c5b649996ac63d43f1d4185de177c90d664b2230
> [2/2] platform/mellanox: mlxbf-pmc: Ignore unsupported performance blocks
>        commit: 4e39d7be4123f65adf78b0a466cbaf1169d7cedb
> 
> --
>   i.
> 
> 


