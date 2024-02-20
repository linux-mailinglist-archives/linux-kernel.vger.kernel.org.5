Return-Path: <linux-kernel+bounces-72815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D94F685B8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB54285166
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0408612C9;
	Tue, 20 Feb 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8aXIan1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D8612C2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424724; cv=none; b=GhSsVr2aGHdK+g83Zw+jnc//DUmuzZxaM9UCC7FNBsy7y+uDtzN2JmBIruunwsD6eBir1L8mtyIKpEZTQBCHnqc9OB/dB8Umg+t5tqiJIhIFK60/ZUqE6K/taIyZ5eGe8QzZ3NSn30Huo9sdUd9Gwij/pQCcQzE6ppX2daZMeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424724; c=relaxed/simple;
	bh=E1tm9W/v3jXRclKbHPuBtzfAnLGGVmHa4BlPy0BxmEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiwwSBVZgDdAhWGLkpAwXzR1R+KXO/WcciLccbY0AGUZthgoT6nMZk3YCJ6zL84q+bqhRtM5qCdIlgmSEkZLxqtmOG92/e5xMOwyLOaMaEoJ3uiywTqWWsHMJ92PX3qarMoiWFaPWEG5ClNOvQ0cEpgis9934ntF3au32BKsDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8aXIan1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708424721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYDQrIFcrmGFEDFd/lQJSQdjifAhTBQLYF8vyTIdB5w=;
	b=T8aXIan1md6zROmthD9dHf/wZuasBQ7Abn+MslOy86tK3Udvr1MQOnJNN/fNSu1CJgx7kk
	UytDlkf9BOcUdEsBOGv7yQzVgc19TVk/kHl2z/sXazA15+B8TygRrsvt2HNJFv40SOqqpG
	8Zodgoeql2BLD6EoFzQD3uCGn3aYkqE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-wZFUbPTAM1akWqIUV6DG2g-1; Tue, 20 Feb 2024 05:25:19 -0500
X-MC-Unique: wZFUbPTAM1akWqIUV6DG2g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-68f740ea9a8so28478906d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424719; x=1709029519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYDQrIFcrmGFEDFd/lQJSQdjifAhTBQLYF8vyTIdB5w=;
        b=XR1KR35z+CfERt8ln4oupQbl2OBIVBlMbvtKMNO4DKaamiaD344TPtKmioHIsEANxs
         WPPvsqRgUBX3NtRVs7w+wuqRFp+XCwue1iTYunL18Chva5sdAppPMKbWktNsMd3R1W0g
         0+wBQWfvhzw9/pUu9U/59XyKGiTo3lWuYtYN1IAeTQCCZHh3RzjtfCNbTixjQ/WJExE3
         D3dNt3Amg9Qh4QgGW6wiqGR+9xDB+icPWZDWK/3EfbHmBXyFfcEMNqSnpLu7TiX34OgH
         apO2qdEBpQDzBK1xqKYBVCLpb5Peow9rVj7gX3lPj35HOozbCp5tLFcdS56XPJCTvn3s
         cfZg==
X-Forwarded-Encrypted: i=1; AJvYcCVAnWQ0aQ4L0tFE2hckfYr42AQaDimPmxv+wXHFWUlJJVxmF8PbPI4WzeQA0wXM64Tc5+5j0akkjrW2tL+3ujEd1y9IZG3d5EqXkyLS
X-Gm-Message-State: AOJu0Yy+nHa55gbzBQbJlia9TQUtdWO4NwKQA16AfyEA7HeNkwi6KPSM
	llvheKDHwN5/EYu5ylkavHqeprkFSe/z+pjsEyKGj4186nx5vHQ0jyDrxlg9/Vuh2/Sg1ttwp96
	6R/W54cHbpFEP9NvNQ+HoYrShGCDCDEYOczo6yf4mkZVgHcJ6AQkctW0eyuMo
X-Received: by 2002:a05:6214:5d0f:b0:68f:4df8:fef1 with SMTP id me15-20020a0562145d0f00b0068f4df8fef1mr9410792qvb.11.1708424719099;
        Tue, 20 Feb 2024 02:25:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+3X6kRD0ZBg35AivR50jCJRUjHWkEAJBbACG4V/5NAALyyxhyTn6cv52exRIgQQkHwGN+DQ==
X-Received: by 2002:a05:6214:5d0f:b0:68f:4df8:fef1 with SMTP id me15-20020a0562145d0f00b0068f4df8fef1mr9410777qvb.11.1708424718810;
        Tue, 20 Feb 2024 02:25:18 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a022700b007871a4b423fsm3244801qkm.110.2024.02.20.02.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:25:18 -0800 (PST)
Message-ID: <129e1b9d-ed1c-4dcf-86eb-7fee32bbcd7c@redhat.com>
Date: Tue, 20 Feb 2024 11:25:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fpga: remove redundant checks for bridge ops
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240201155713.82898-1-marpagan@redhat.com>
 <ZdGByar/ZmzA81cc@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZdGByar/ZmzA81cc@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-18 05:04, Xu Yilun wrote:
> On Thu, Feb 01, 2024 at 04:57:12PM +0100, Marco Pagani wrote:
>> Commit 0d70af3c2530 ("fpga: bridge: Use standard dev_release for class
>> driver") introduced a check in fpga_bridge_register() that prevents
>> registering a bridge without ops, making checking on every call
>> redundant.
>>
>> v2:
>> - removed ops check also in state_show()
> 
> Don't put the history in changelog. 

You're right, sorry.

> 
> I could fix it.
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 

Yes, please.

>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
> v2:
> - XXXX
> 
> This way the history could be discarded when apply.
> 
>> ---
>>  drivers/fpga/fpga-bridge.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index a024be2b84e2..79c473b3c7c3 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c

[...]
Thanks,
Marco


