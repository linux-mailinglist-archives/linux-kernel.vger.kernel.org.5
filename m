Return-Path: <linux-kernel+bounces-153289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CFB8ACC07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B8CB23892
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCA21465BD;
	Mon, 22 Apr 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsCdLKch"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C23B146595
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785315; cv=none; b=Z4KlR8w6Dlrc15l5ZVv/8bqIWJYu0pbeWD4IG5tiHyUpP98RE4xGQlVwmuBzUIM59NZAFXjb2LOUwDBCNmxFNQrEb1ARfmdXtdewxnG+FoOI+V/czSVuJycJhVkzEpVPYTUQosOFmQ4c8DOyYAMrcWUnjrWga43BddVHzyzs208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785315; c=relaxed/simple;
	bh=LlC9TFfkOyKE9KBJ0ruLXt/YXgDvS60W07+SiC4G7dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vujfko2BDip6ms2mRxYBNKjZvNxqIukgfbBKzc0m2ZYI7r8lpTjfsCIE4IxKezncS/B4Qi02xyt0uOa6trm1rWRIQoStsjzRDoyumXG3verMkyN9kSKVyv3UlSG918DZkB9t1Nxy4xCYgvchcB4hgGusFr/RXXVCVo/kXx87T1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsCdLKch; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713785313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdP6aBlHUd1XAByP0AzLdNCgpA2tCV7wBjkJeHqJq1E=;
	b=OsCdLKchTpRYVLSPuF2O5uVN1aCbmgbcwcE8YSOgLv2zehuNZ+gbIbBWll5ussYLt/Mb4O
	WkCTxTnDonZC2oZlyDJ2TilLlxhXmHOxxkZnqhIOS0NhkQj8W9hs2Uh0RZ2dDMAkQ/bWMK
	I+plgp2kolhnSpgLvSHWAiuiV1j1W9c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-wCZ27D8NPYCTmKuChlrV3Q-1; Mon, 22 Apr 2024 07:28:31 -0400
X-MC-Unique: wCZ27D8NPYCTmKuChlrV3Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a52539e4970so226278066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 04:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713785310; x=1714390110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdP6aBlHUd1XAByP0AzLdNCgpA2tCV7wBjkJeHqJq1E=;
        b=E+1gBYPb/Fwqm1CqhVysJIhlrRYKsAzqY5i6j+tyL1RhW/ygTYhUEadIg4+Yi8YeRx
         5iuQ5OTax+OhXcCD7U0DGsF6sdi7umNIzN1JjLHa3I7ztQjITbaeUFs6MhtmaWtH8sdV
         BnuXrGbUHmuE/tLuJUAS+FyMAaUJ2lcrfK3tOpTlOMZ5XITsR00iYfkxrRXQJYJf17W3
         30B2ysFy88mrT8bPiM+17QDNmfX9ckDVXrWkihOwTSBvyjbMYcr+m/2t+QdrO6Yh6fQF
         oei7UpUOkGAbggCjLcU9CoCX7jpdDjKveRnbl3Fxj4grXr+wsMyGYqA2O3mJ6j+uw50X
         qoUA==
X-Forwarded-Encrypted: i=1; AJvYcCVKFWXkCR3lOwzVXx+zp7ekLfvXLuABbxtg5DjUJQ3AXGqYYOjh/vG/nxMtP90s3zwxoEo0+XTyXoWwumLT4CqK2CQNYErn2eZ+sF0q
X-Gm-Message-State: AOJu0YyAhGZH+py0jowxJJcJPzS3h9uGtgiNFmun+wNNdgI5WTYKlk8f
	RiXy10ZRcw8cKTSspfg9QVliAy/nuBOoSLukcQTs4AIytFcLEqItJmmaWPDRaPx6Q5Q0Er5/Cb9
	+U51Xf2ld4lPzykCSK5SOvD1bvqV4swhRFnbSxIrzsU6OOXvtYNcRuBeXGsMcIg==
X-Received: by 2002:a17:907:94c7:b0:a55:aee0:517 with SMTP id dn7-20020a17090794c700b00a55aee00517mr2715572ejc.30.1713785310805;
        Mon, 22 Apr 2024 04:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYltrgJMhWpRSqD48zzNpCNz3G5JP8VifbDGgrJ1pm53j5xEijUgLtV36FCwtzF7rrmcTjmg==
X-Received: by 2002:a17:907:94c7:b0:a55:aee0:517 with SMTP id dn7-20020a17090794c700b00a55aee00517mr2715553ejc.30.1713785310475;
        Mon, 22 Apr 2024 04:28:30 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906640d00b00a5267ee40efsm5731727ejm.18.2024.04.22.04.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:28:30 -0700 (PDT)
Message-ID: <44b64f19-8141-4c6e-855f-d2b4e821e0c9@redhat.com>
Date: Mon, 22 Apr 2024 13:28:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] Input: support overlay objects on touchscreens
To: Gregor Riepl <onitake@gmail.com>,
 Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeff LaBundy
 <jeff@labundy.com>, Conor Dooley <conor+dt@kernel.org>,
 Bastian Hecht <hechtb@gmail.com>,
 Michael Riesch <michael.riesch@wolfvision.net>
References: <20240422-feature-ts_virtobj_patch-v9-0-acf118d12a8a@wolfvision.net>
 <9d898a98-cb7d-45d8-80c2-2ef428288e6b@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9d898a98-cb7d-45d8-80c2-2ef428288e6b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gregor,

On 4/22/24 1:22 PM, Gregor Riepl wrote:
>> In order to generate proper key events by overlay buttons and adjust the
>> touch events to a clipped surface, this series offers a documented,
>> device-tree-based solution by means of helper functions.
>> An implementation for a specific touchscreen driver is also included.
> 
> I believe there's at least some x86 tablets that have such a layout, so maybe ACPI bindings would also make sense? Or can this be supported by your DT-based solution?
> 
> I'm not sure if it would really be needed for existing devices, though. It's possible they were all handled by touchscreen controller firmware so far.
> 
> Hans, do you remember if we've encountered any Silead or Goodix devices where the soft button overlay didn't work due to missing firmware support?

The x86 devices with Silead or Goodix touchscreens with soft buttons which are
part of the touchscreen digitizer that I know off all handle the soft buttons
in firmware and do not report regular touches for the soft buttons area.

So I don't think that something like this is necessary for x86 devices atm.

Regards,

Hans


