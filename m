Return-Path: <linux-kernel+bounces-42393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073138400C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4981F23E79
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E377254F86;
	Mon, 29 Jan 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHqB94Kj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4D54BEE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518761; cv=none; b=W8pOErNfeKgSnXuhuoM/dJz4UgH7ESHoojaFF7LU3cAv2827Jm5Q8fwUm9qNSlFgI8ojKpt4opPxNcNpkysCd60Q9RdhNAI1QViWRwf1gK6boHt9m612Ok5L8HbEuJbG4MbG08WhmeeujURIc9G5Zni9Wl6BDB6Jkx/zjfexysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518761; c=relaxed/simple;
	bh=SjgxZgEJ0zE2xG68u2eXZKUCpalABl62X6Kdteb45Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOEbbTYlwV+vyK6yMovQDWwHkkvmlKnyHf0ayuyADQIYxKExf4HKQcqfGhnNJmIHiZazKD7oJmn+CkpMBKhK6xCo7ddaAKkDTFet0nbRSEHsQeVoKdhVC2qZyksuVrzZL9OyL5rJxd+TR52BbZENV5qdLxkxNp8IobdAo9kERzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHqB94Kj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706518758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mz0NTo7T3zvbZQvTXWnrEg5YVgGabir9bR7S1JM1MOk=;
	b=FHqB94Kjf1VUfl0iieveXA5eAgH/PpuctkckezJDDVtHrZHeFxBMORM4wjca2t02jYBq5J
	H2e6pX9/Y6hQYz2aIPCVZK9JXBb5p0QbxDYch06yJbiszo92AQXV73NrAPSX8/0trq9QEm
	ywZLudkLujukJtdHwU1Z7zDPncu7Lrw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-EOD3GPEFOgeaNRwP6Rn4OA-1; Mon, 29 Jan 2024 03:59:15 -0500
X-MC-Unique: EOD3GPEFOgeaNRwP6Rn4OA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a27eddc1c27so107774166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 00:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706518754; x=1707123554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mz0NTo7T3zvbZQvTXWnrEg5YVgGabir9bR7S1JM1MOk=;
        b=wgoS4p6yAepT8/iYyLBna/XclWKHk1LTmK/BfEvL33lpvKsK4IpcT+dfNXfeVpcy3+
         TqMQzrj3u78vcn9x8waRDm7No0wVoUNSXlOLZ+Q4gU7oZZuOofzi+fZWu9TU5a0czYzs
         PYAGuRUvA9sy0/WdA9wLOEdp9q54+1qlUG0WSDZ+Y0xN7Gw3OR0s0CR0qGtZUSYKRZYU
         4pi+MpFMY9VgWtlaMgoyqZ6r+xMU9yARMGUeFSu7JAOkim0i2JNbFkRaqW7yL+zh6p24
         oFERe6pL/IDOAlEj1Yrf3cVrJjWrbMvBDBZq4xMMsmQX1L68O07e00QeVHgSG7ZQZzX/
         VT0Q==
X-Gm-Message-State: AOJu0YzrZwAcztFcGOOYQzy+5SvNErRTSasbF7JpbC87WakHPK7LJNWN
	9LDSqDezrT5iZ+3XuixITe2ht/d4hXB4OAgr7m5+i1ItkCORzYhOUa7a4Ezfq78+Pvv0ZPJkYP/
	qnWmXLuXdDHSonodnO6DFmX0eodxC2YqIEPrClW8Gf/mXDwHZV2saRQt9+7vFuw==
X-Received: by 2002:a17:906:a219:b0:a35:6601:e401 with SMTP id r25-20020a170906a21900b00a356601e401mr2937543ejy.5.1706518754369;
        Mon, 29 Jan 2024 00:59:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHf/JYvN1cOiBBS6nmvk4erwpIf/mxbTQA/LtkKLl9FgSRVphAi5XD9/o+bV8doYWxYglG3RA==
X-Received: by 2002:a17:906:a219:b0:a35:6601:e401 with SMTP id r25-20020a170906a21900b00a356601e401mr2937532ejy.5.1706518754117;
        Mon, 29 Jan 2024 00:59:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ub14-20020a170907c80e00b00a3109a492d4sm3647222ejc.20.2024.01.29.00.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 00:59:13 -0800 (PST)
Message-ID: <bbcf1b06-2a65-4f87-b15a-583a668dfc1e@redhat.com>
Date: Mon, 29 Jan 2024 09:59:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] platform/x86/amd/pmf: Fix memory leak in
 amd_pmf_get_pb_data()
Content-Language: en-US, nl
To: Markus Elfring <Markus.Elfring@web.de>, Cong Liu <liucong2@kylinos.cn>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <901291c8-ca9c-47b2-8321-256b314690da@redhat.com>
 <2b3b4754-4c20-48ef-9844-f5db6a7f527e@web.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2b3b4754-4c20-48ef-9844-f5db6a7f527e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/28/24 11:45, Markus Elfring wrote:
>> Thank you for your patch/series, I've applied this patch
>> (series) to my review-hans branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>
>> Note it will show up in the pdx86 review-hans branch once I've
>> pushed my local branch there, which might take a while.
> 
> Will development interests grow for the application of known scripts
> also according to the semantic patch language?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/coccinelle.rst?h=v6.8-rc1#n71

Markus,

I'm not sure what your question here is?

Is it: "Will coccinelle scripts be run as part of the regular patch
test/merge workflow?" then the answer is that there are no plans
that I'm aware of to do that at this moment.

If such a thing were to be done, IMHO it would be best to have one
of the existing CI systems like e.h. Intel's LKP test bot run this
on linux-next, or on all the trees LKP already monitors.

And it does sound like something interesting to do, but someone
would need to actually setup and maintain such a CI system.

If the question is: "Are patches generated by coccinelle welcome?"
then the answer is "Yes patches generated by coccinelle are very
much welcome".

Regards,

Hans






