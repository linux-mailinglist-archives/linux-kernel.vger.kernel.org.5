Return-Path: <linux-kernel+bounces-129858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFFF89715A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B60B28414
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8125A1487C4;
	Wed,  3 Apr 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtzzaXqG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5B148308
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151634; cv=none; b=GuYqF0qm9vZ7jBsuWsyQF+wCHciIQ9IGxasXP1e84d/azZpkQSzj2rmQ2d9oU+1G9LhonkT+93JNQawuv6/A/A3Eqo7v6pBdQh+14XTXIS30v4KGrlsg0wwqp3sLW/UAP177O1p/gbAPwrdOxwYN7Agsf1hmhfbcTPz7n5j4WWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151634; c=relaxed/simple;
	bh=vvXjnTWhbK/AP27SJS5neO8uglMhuxHEZbqOiLd+OwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxDYB40+km3cQMBdICg19yDc8tj89Hu0+mJbKaOLQztz2RyyfoQG4/WYtgiLVJ1MRy5oCktUnDNAgKd01edg364BKQedknoh7dsignbrWcCQmYXT2lEBDl2JtgpjcR23Xoul4750IZ0TCH3FJhh897c2jG92ozDOQm0jXjbVgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtzzaXqG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712151631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kFvPsELnPBycEMhpctHKr6AzjIToWfAkKobOxDoJu0=;
	b=YtzzaXqGZDvi6YXWQbQ9BRgAXNYIHoIF4JStmujkTJYwpWi2bmmPx9tfL7oYbXGs0lc6D2
	+GgCjSKeRbi1EfFkmrj9LoTgChcg1kEXvpjK7ZcmmAMNCvTjbbZ+ZfMV67ZwOd1F4cWzh2
	BVaCBfMIpQtB2oXNI+ArCRiWVJBCI2w=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-Z4pbY_9ONbePwfr0of-png-1; Wed, 03 Apr 2024 09:40:26 -0400
X-MC-Unique: Z4pbY_9ONbePwfr0of-png-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5a553729aa5so9236185eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712151625; x=1712756425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kFvPsELnPBycEMhpctHKr6AzjIToWfAkKobOxDoJu0=;
        b=A++WJuU5BRqTHlnik6jPFfIXOf+DUMhNsAEQFj2OpARzoeUNw3PcG/D0wroljXKJhj
         ltrf7WCsgsWz8A/0Vhx2gXSwIJ3X4ko0dewMeHsjyjX+1lK0Id26kOP3hniZ3OL4SYy6
         dB+b9CNIUWTXPq1Ww2K61AqRyV1cTdm3N7Be/ix0dfJaPvK5n8Sd2uEvYFoiR3ITU3jp
         4d2G3bfLVHyMUThf+Omig+GdU+3r8BDCtGwirAhZdBnspqMQKQ4j44NnqeY4yvoHmsot
         5KImg8PfOMpj+0FU8RJEjTbHTSvjB1FpgT3lsI2+9gZnzovV0VGTLaIcH21aeK5LRJnb
         wcEA==
X-Forwarded-Encrypted: i=1; AJvYcCW2HjsE0PlJMoIUlw+Bmkb7vhMFi8p3vHhrCQ7NmrZECWVE9iluuQ5bsIV1t/OeDLu6GI4K+52u/YLZp8DojPdPkPH/5BIExhad0bM7
X-Gm-Message-State: AOJu0YzKX8KkTi4g62VmJJ3fk2s+Ypw4+VHH3MLC15wDqV1/8OL5crDB
	1fCs/Y7+lOIayL5bb3decFXVfZQsmCVLYGfUsyY2cttbzdNLFYizKPET+AVZZTAaNr3M5PUrZ04
	0esysAE/1Y8PsJGLZjFnxk+cVOPlZmUpDLxZ86d7ST1Yw4NdWzNHxId2I0F+6
X-Received: by 2002:a05:6358:342a:b0:17e:6a4d:777 with SMTP id h42-20020a056358342a00b0017e6a4d0777mr19134541rwd.19.1712151624789;
        Wed, 03 Apr 2024 06:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJfrdTcs7yrYrpjS2ZFxR2zgJ4gJKVUQWgLsmQEIoC2FQZOcDQy0V078Vo7dbZFQ4bbGUhPA==
X-Received: by 2002:a05:6358:342a:b0:17e:6a4d:777 with SMTP id h42-20020a056358342a00b0017e6a4d0777mr19134521rwd.19.1712151624512;
        Wed, 03 Apr 2024 06:40:24 -0700 (PDT)
Received: from [192.168.9.34] (net-2-34-25-239.cust.vodafonedsl.it. [2.34.25.239])
        by smtp.gmail.com with ESMTPSA id qp10-20020a05620a388a00b0078d3ad47448sm229648qkn.104.2024.04.03.06.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:40:23 -0700 (PDT)
Message-ID: <9d49402e-c5d4-4002-954f-7d2c48fdcfe4@redhat.com>
Date: Wed, 3 Apr 2024 15:40:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fpga: tests: use KUnit devices instead of platform
 devices
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Russ Weight <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329174849.248243-1-marpagan@redhat.com>
 <ZgujpnLfHTp+WRNL@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZgujpnLfHTp+WRNL@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-02 08:20, Xu Yilun wrote:
> On Fri, Mar 29, 2024 at 06:48:47PM +0100, Marco Pagani wrote:
>> KUnit now provides helper functions to create fake devices, so use them
>> instead of relying on platform devices.
>>
>> Other changes: remove an unnecessary white space in the fpga region suite.
>>
>> Reviewed-by: Russ Weight <russ.weight@linux.dev>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 
> Does this patch has dependency on module owner changes for fpga-mgr/bridge/region?

There is no dependency on module owner changes for mgr/bridge/region.

Thanks,
Marco


