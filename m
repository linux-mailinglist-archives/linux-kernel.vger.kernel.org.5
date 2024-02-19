Return-Path: <linux-kernel+bounces-71331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1F685A39D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33346B223BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A371C31759;
	Mon, 19 Feb 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lqtwvkjg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEB2E645
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346303; cv=none; b=Q0AzpxWGROK/+LuYAejMWd/OnOwioXxo/Ej5Ypk+R1lqcf+9sg+JZF8n8DJX1ajJcwdsQoR2dUb6BlMWsrZgCmCkwBS7ZDI8nGZdEpDNTRZk3fyKhCQblROXNdVor12H/GME9fr818pXkzsJeqPOUOhaxCFGQobcpilbyziOo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346303; c=relaxed/simple;
	bh=gzjCQw/WkyJ81heO1U1AhwhMls24RaDiBVDZWODcvSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7RI+si1cNP88ctsYdNEyys6z3tbGcvS+CLfdGBr3/nHk/WVE5UoUYBh7jlm+XaVrzAbA3zWwZUfyYWXOjZESmt9qFWJm6rPlzGaHfSV02xis1A5ctjIy60hBya0FWxqMSi/bVrOBJ4VYOSksK5fokd9prCpyS63vnR1JZ0B244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lqtwvkjg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708346300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yk2rigtIP1TrPPA5XNRdEMM1GL9bmAZcBohhgdFvSDI=;
	b=Lqtwvkjgd08IRgwSJGnymMLSyP4myvnkGEp21xt4fCrAhciiE3OyN+OfU72X/RKtYP+Qpb
	H0yZ/khHDs3LhH3TZcRM6GIZxg7kNHYFmp3dBVUS1ep66pLy9T8woWi4Tmx3q+pWIacUpU
	K1nQSpI0Km4lQ0xRrdn2NRcQn8YE/ic=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-9A9IdWE2MUeU-KRlXknBag-1; Mon, 19 Feb 2024 07:38:18 -0500
X-MC-Unique: 9A9IdWE2MUeU-KRlXknBag-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-512bad7d985so618875e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346297; x=1708951097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yk2rigtIP1TrPPA5XNRdEMM1GL9bmAZcBohhgdFvSDI=;
        b=s1S1xItwDYNFFe/sNZ2FZhaZ0doORzE4v9Cv1HbLJO5+rPVRCWYqCwjD/1KdFLFEjD
         DGdk4xLVSE5ndyyUbBlneDJCumf1B2htRnDW45llNuOoxSI+V5r3KouchpSKhoMTu//J
         d5MPKB6x6kLeqev+0BLBJvyvSE+M/hz18K2XmzecJntywbOE/IQQ0Xok7AM13+pGOvaT
         fHLWDiMZe2Yrs3QNq0pba8iZeHPrsYLapc7tOPMj7qR/s2so42x76y1EgyMSnGZdv7Vj
         P8vB4KP+KNGNcg+bMud9WyozN4A9FcEm7tqh7MWiHj0yVkvGmCSuX4+54O9n1lZPyguZ
         HSAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX514fArOClUu6o40rtQHzzPW7lWo28+Y6c2C/cW/9hD7CSh13f4eDcSanOvqvVD+En63K4W+NzUfyDVwbINo8kBioomg3SDUL6NRii
X-Gm-Message-State: AOJu0Yx6ViujpQAKUFOQOiiUVSTlPi4ukK/0JBCs7N/frq+83Q/d7Gru
	CJJOUTy9A2X1iAMsEALhrD9zJF9vvRyyUTA5em5soudPyNcJLo0ZALi03nQjzIt4bkJDovBsGoH
	OMz6tt3Y/KEbF40IUfYQJP5EgB6knqOyNr9+mnHBPtRVj45ixGgm9m+cLgWkF6Q==
X-Received: by 2002:a05:6512:2312:b0:511:79ce:805d with SMTP id o18-20020a056512231200b0051179ce805dmr9233604lfu.7.1708346296963;
        Mon, 19 Feb 2024 04:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTIrJSMSE88u6rez8enAJWFXxtTIeYnpfd/46RCais8tXQSS6eAQbycVH8j6AMohdHKR/9Dw==
X-Received: by 2002:a05:6512:2312:b0:511:79ce:805d with SMTP id o18-20020a056512231200b0051179ce805dmr9233589lfu.7.1708346296662;
        Mon, 19 Feb 2024 04:38:16 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id wp1-20020a170907060100b00a3e2e03c155sm2363377ejb.155.2024.02.19.04.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 04:38:16 -0800 (PST)
Message-ID: <1d5dd3de-5561-4231-94bd-65ac05f1fc50@redhat.com>
Date: Mon, 19 Feb 2024 13:38:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] AMD PMF Smart PC error handling cleanups
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, Shyam-sundar.S-k@amd.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217014107.113749-1-mario.limonciello@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240217014107.113749-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/17/24 02:41, Mario Limonciello wrote:
> While debugging the suspend issue for amd-pmf the initial bisect result
> pointed at red herrings of cleanup flow problems for
> amd_pmf_init_smart_pc().  The actual issue wasn't in this code, but still
> a lot of memory is allocated and not immediately released if any of the
> error branches are taken.
> 
> This series cleans that up so that every step is cleaned up. I believe
> this actually fixes driver bugs that "could" occur if a BIOS advertisd
> Smart PC as well as ITS auto or CNQF but didn't include a policy in the
> BIOS.
> 
> Mario Limonciello (2):
>   platform/x86/amd/pmf: Add debugging message for missing policy data
>   platform/x86/amd/pmf: Fixup error handling for amd_pmf_init_smart_pc()

Thank you for your patch-series, I've applied this series
to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



