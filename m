Return-Path: <linux-kernel+bounces-121365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27E88E6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F3B1C2E575
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5A213C3D3;
	Wed, 27 Mar 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDoQdytP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE37513C3C3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546252; cv=none; b=c3VDiX0QNzsgJAXL/VK5pjiN/vKwifZQxg1yA/wP6Y/F0ac/Krtwe/WHsPym+x0z958s4jnUnhvzhtPzWP4UNrpDNhSYBElNv1IaqatYBqfSXpWOzY3od67VVKYcuAVAg42DQ0a6OppVrZ3G98yvciZHfg6x6VLW/uKUe2+RUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546252; c=relaxed/simple;
	bh=0XY9//HMaNHTRAMknvvS4g417tWnY3ABPrd/afaOHBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwFMPE0buJDHoWhFA+IfHO+v3OnCdVd/F4H2OAEb3VA4ScBlYQbdulGWJi3r+o5edBN6TdugYw9LP1+WI6/xBR1/sLfdSYOfiH8SUja2voVjHAcVkWsmxqJM374o2/beMEUH0mrj2RVwziohbB+3JUytCH+OYoRe/ZGfGi5f2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDoQdytP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711546250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLg38MFVhLXh0D5Ryy6sGfzcGNzaaaxhoktXDmAvMEQ=;
	b=FDoQdytPN8kWK7BncF2pW9GCaG9myiez2trYAAtQDoZh/+wcAD7qOTGs67zUoora5z1yRc
	x80DqHfGsxtnl+APhnMGqTIKWi/luH++JH9P+i2xMPKDGZvXE+aomKFliDaDg3ocs0Pj9s
	6d2hSlTb9PY6wMfk3JKVITilH73LW+s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-tnoXk5jgOnWo_JpUZ45txQ-1; Wed, 27 Mar 2024 09:30:46 -0400
X-MC-Unique: tnoXk5jgOnWo_JpUZ45txQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4943e972d1so96823366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711546245; x=1712151045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLg38MFVhLXh0D5Ryy6sGfzcGNzaaaxhoktXDmAvMEQ=;
        b=jjkMxYrIGMxxrcdM5ROa71pZPOG42kmSJpMN94HaXw2IpT3whdjUb3Vj2ME3I7o1cP
         /lTC9dqlx+BLcb/RYpFVbUpNqfhf2mprtUcshslg6m3vFiQzpwLX4+ynJFXXZsW4G92h
         FgaL+G2NnwZJJ9ctsX8JQHmYk1yxf+TCwMaMZNETHxo6pRHbrR142gsyk5GGiiafbXAy
         cY12HoJPtZ4NIUAW/0pGKOjz3HfAUv3fk7iqqWpfSwZ6S/kws1ylsVnDPX2PDxNVskXF
         jh9MB9y6IYw7oKwVWwcR+NxoVAaabUH1Jb8p/ESTYdC1yLxF+yEz/SL5Q7W9zyIAzrM8
         i42w==
X-Forwarded-Encrypted: i=1; AJvYcCXj4Pydb7TsT24TpKNPN4ECyaSL9OPI46MEftoZwx+Xb7bhvodaTG0ofSfPGKcbcqNAF0Q0g4jaLRI8vTbtWUacoBaS8q1qnpjVWmw4
X-Gm-Message-State: AOJu0Yx4U2wXX7+1F7Vh9Sk2WEwNriQkco7IkTvhoc0rqWct5EADHu1V
	hEz+OBhXJQv5rDL1tAXrGfTliVvOgoYplwEYBgSCXtS1bohBw1OT/cOEtrJAIHHBi9P39jX6xqs
	WQpEcc9cOnv+GEmDplJLtiu/XNpkBkGToVEopFg5Uvz6ATQFuxtcObGuRmv0MZA==
X-Received: by 2002:a17:906:4552:b0:a4e:ca2:f597 with SMTP id s18-20020a170906455200b00a4e0ca2f597mr464555ejq.30.1711546245267;
        Wed, 27 Mar 2024 06:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxMNQa6I7wHwsl8AheMWybiN2BzRa3S3xpZTZlv2r8DjsDL3nA8c8TtS4ntqPeWCUGEfcy9w==
X-Received: by 2002:a17:906:4552:b0:a4e:ca2:f597 with SMTP id s18-20020a170906455200b00a4e0ca2f597mr464548ejq.30.1711546244934;
        Wed, 27 Mar 2024 06:30:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709060e4200b00a4674ad8ab9sm5383406eji.211.2024.03.27.06.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 06:30:44 -0700 (PDT)
Message-ID: <7a7d7216-ae22-4908-af63-6b1dd96359dd@redhat.com>
Date: Wed, 27 Mar 2024 14:30:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] ACPI: store owner from modules with
 acpi_bus_register_driver()
Content-Language: en-US, nl
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
 Daniel Oliveira Nascimento <don@syst.com.br>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Matan Ziv-Av <matan@svgalib.org>,
 Mattia Dongili <malattia@linux.it>, Azael Avalos <coproscefalo@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Jeff Sipek <jsipek@vmware.com>,
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org,
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev,
 platform-driver-x86@vger.kernel.org
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
 <CAJZ5v0hEiKJJWn-TVoyL6DEbCcMpL39_q+HLG_YZyjf9g29CXA@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0hEiKJJWn-TVoyL6DEbCcMpL39_q+HLG_YZyjf9g29CXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/27/24 2:16 PM, Rafael J. Wysocki wrote:
> On Wed, Mar 27, 2024 at 8:44 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Merging
>> =======
>> All further patches depend on the first amba patch, therefore please ack
>> and this should go via one tree: ACPI?
>>
>> Description
>> ===========
>> Modules registering driver with acpi_bus_register_driver() often forget to
>> set .owner field.
>>
>> Solve the problem by moving this task away from the drivers to the core
>> amba bus code, just like we did for platform_driver in commit
>> 9447057eaff8 ("platform_device: use a macro instead of
>> platform_driver_register").
>>
>> Best regards,
>> Krzysztof
>>
>> ---
>> Krzysztof Kozlowski (19):
>>       ACPI: store owner from modules with acpi_bus_register_driver()
>>       Input: atlas: - drop owner assignment
>>       net: fjes: drop owner assignment
>>       platform: chrome: drop owner assignment
>>       platform: asus-laptop: drop owner assignment
>>       platform: classmate-laptop: drop owner assignment
>>       platform/x86/dell: drop owner assignment
>>       platform/x86/eeepc: drop owner assignment
>>       platform/x86/intel/rst: drop owner assignment
>>       platform/x86/intel/smartconnect: drop owner assignment
>>       platform/x86/lg-laptop: drop owner assignment
>>       platform/x86/sony-laptop: drop owner assignment
>>       platform/x86/toshiba_acpi: drop owner assignment
>>       platform/x86/toshiba_bluetooth: drop owner assignment
>>       platform/x86/toshiba_haps: drop owner assignment
>>       platform/x86/wireless-hotkey: drop owner assignment
>>       ptp: vmw: drop owner assignment
>>       virt: vmgenid: drop owner assignment
>>       ACPI: drop redundant owner from acpi_driver
> 
> I definitely like this, so
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> for the series and I can pick it up if people agree.


> 
> Thanks!
> 


