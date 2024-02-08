Return-Path: <linux-kernel+bounces-57700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0784DC82
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C681F214F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE356BB36;
	Thu,  8 Feb 2024 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm0R7rIS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA66BB2B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383495; cv=none; b=t0j+kzx2F4mEai7h4l/IuHsiCpz0xigl/+gRZkDjU8yi2nAmUGxLAMvqFHss0eC1iaWi4Fa5eu8j8hHqk2wXwilbI9bpq+Kizbo6nli9JK+dLsjr8POnWL+GxFZ/RzHASBUDkno94cbARDweCewWEq5bBTET1F+9l+/ZTBV2jgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383495; c=relaxed/simple;
	bh=Urc6EHEV1trg40jncFnSWzA6C6SNuCgkQqkElyHPFDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aywVNa0StIixAFxca6UP8596BYNMFp1C/oX025PMdMghEsjLM008PPPURA2NLpiefA7HGvFsjoPPa7+UdQZ9s3Fmzg46syIsYJPqd4xkyz9XHCiPd0tLt8Kp5rQaGG8gBZ+OCgh/iYV1DPT1oFvqrwcRMPVpUWRCEl3iWH7jg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gm0R7rIS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707383492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODP2WukdSN69Dkq02zl0rD7xO+0dL+boJwASghdWLqQ=;
	b=gm0R7rISWF1T5jnwHuwy6o7sFI9YvPOPHaEFDV8QK3YqJIEwutwsLSIeopGiQ3K0uq6VIx
	vMsnTpHzitg4v+fH1CeeMhLE6sD1fTNfBASwrqkVsV41muZiJwvxC/i84LNAmsvaQfHsCS
	Rv3Rc5pCQFSeilBbxNJ/5dzlOSVheDs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-UHrlApiJN_m-Qo5da50hXg-1; Thu, 08 Feb 2024 04:11:31 -0500
X-MC-Unique: UHrlApiJN_m-Qo5da50hXg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a29bb25df84so102373866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383489; x=1707988289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODP2WukdSN69Dkq02zl0rD7xO+0dL+boJwASghdWLqQ=;
        b=D3xcduB6a28WATp4A/zYkzeEg3G5/AmvXa79Nn4wifZA2Bl0DxdRr0mALXuQ8vE3/9
         PWYBuSNK2s6ZVMsmQHNLJ2KpdeRj4KX7pJkB9Gcku7CTakbclig/u6XvA+VxlNfVAz3L
         Wd2yhWzbqyHlyHEE1wgw2i7i4kd5czmDOGdAjyTukfU/85ndnDswhIMMjLPeVG+6stj/
         1f3iJISGcSuiG3JBsG+G5V09WAvpc0Hst1h9ee7xsD9KU2Hlq+15itiqo017YhBPfs0x
         jNb+AFL0L9aD+OPlR+LKdrXYfCdxBrPqrRmQUa/PTqm+UN1ymMGqtSqx9wA6SzHoYhIO
         N6tQ==
X-Gm-Message-State: AOJu0YwE8syytDl7lPSVcwI6u1rPwyGnmhgqI8+bSBNr3iRE2lYU9nFe
	dNTy4l0ELAp9d20KJGvz417QzqulfJjklo0h5R2lWLyFtoUhpeQzz/Wbp0Nw3yetWnR5vxq9L6l
	3tuHrAfB6Ygnv4DN5LiKfR5vnQWGI5T2LldZ3uT/Ng0jyyrqyWOrwpBz1LYuH3qWk6KBnPQ==
X-Received: by 2002:a17:906:646:b0:a35:e7a1:66ec with SMTP id t6-20020a170906064600b00a35e7a166ecmr6291431ejb.44.1707383489684;
        Thu, 08 Feb 2024 01:11:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGANjlv/Nug4PDqjzwTVjakLLFl/mzccGZyPhaDWJgBSzN0D7dtpnESyXcxKezhDz77kL+epg==
X-Received: by 2002:a17:906:646:b0:a35:e7a1:66ec with SMTP id t6-20020a170906064600b00a35e7a166ecmr6291406ejb.44.1707383489319;
        Thu, 08 Feb 2024 01:11:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkdRl1vJKg/b3td1NZr+chxeIyNwN7pTQt2rngSxHGoyMvttmXgtCzALoEA/eMUgPP7oxkgXqwdGK3XK6owIp7bPB0qTyD/dV9koGrIpQSS3l8bdUZSbRvw6CfzbJhBgYTP7FgFgBEyq6gPIgv03AU4Cghbn0M6HfPvlO5fQvwFTP/jedww8ys41FolFAEAYtBWs1AN+qpQfD8JKqQsm+lcpg8zsXS
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id tj7-20020a170907c24700b00a38a2fa2d4bsm910651ejc.45.2024.02.08.01.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 01:11:28 -0800 (PST)
Message-ID: <b42366a6-3586-48e9-a162-a3a03fe204a0@redhat.com>
Date: Thu, 8 Feb 2024 10:11:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3] platform/x86/fujitsu-laptop: Add battery charge
 control support
To: Szilard Fabian <szfabian@bluemarch.art>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 jwoithe@just42.net, ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de,
 Jelle van der Waa <jelle@vdwaa.nl>
References: <20240129163502.161409-2-szfabian@bluemarch.art>
 <20240129175714.164326-2-szfabian@bluemarch.art>
 <20240207023031.56805-2-szfabian@bluemarch.art>
 <e305a170-362d-48bb-a742-f4c8f010b2c7@redhat.com> <ZcQ0qGEuHOSoLC8R@N>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZcQ0qGEuHOSoLC8R@N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Szilard,

On 2/8/24 02:56, Szilard Fabian wrote:
> Hi,
> 
> On Wed, Feb 07, 2024 at 09:57:21AM +0100, Hans de Goede wrote:
>> Thank you for your patch. Do you happen to know if there also
>> is a noticeable fixed start threshold which is like say always 5%
>> lower then then end threshold ?
> There is a start threshold, it's always 11% lower than the end threshold.
> I don't know yet if it's a fixed value or if there is a way to set it to a
> different value.

Thanks that is useful to know. We can add this to the driver once we have
come up with a way to export these kind of fixed start offsets to userspace.

Regards,

Hans



