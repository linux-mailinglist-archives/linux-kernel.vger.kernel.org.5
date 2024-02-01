Return-Path: <linux-kernel+bounces-47552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301CA844F45
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39AD1F2BFCE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194539FF7;
	Thu,  1 Feb 2024 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDkzbTij"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247A3A1B2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756386; cv=none; b=mhEp3YsrsrTdAf70RqBcdv8vuAdNhnGZ/B895RN96qFqkjpufBLZjoyJjLwA1J1PTDMzrItVT/ZiwIv9yChztnU5Or233dEbe1ER8ku8V5Fej7WJoq8Ho0iHlr0tIHv/+lev5fx14qLyI+DHooW2pafUrvaFwf/tH1WUu/zVe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756386; c=relaxed/simple;
	bh=5gKmwqTiX//bw8dcuurwVdti6uUWSqDtZl+dcrFZ1I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9wW1RJAOy8HKz0HLpOpZOnIEJrBo0CQLjCHSTnHXQBnaD4C2OHKk9D7Nvi+qx/oGjaBZZhn+BIL2ADaw91ydr5uN+wRPhQUd1oeO2qKQ6HimYHIHYyqhLbl0W721EjBq9HjMj0cIIN3n46XY2xyZZDh4wLO5WYY0G0uJFbC5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDkzbTij; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706756384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K09n4KM4GfA4ieYr3u7htlPmiCBvQiYCmB4ilutQSI=;
	b=JDkzbTijMGR1Tpwh4grFA5TIzH2nQuYbHUQjCXd4+muHBp2OdTsACmo1VJCfKwFS4hCH+j
	tjhJFBIbzPRUVBOEgOMqiKO5xccSacbCthR1ogVtBpZxj4LECQUKR2aNIs1PYQYyOpxw9u
	M0dAEgk0b6DF55dKxJkm8Tu6ehRjW8g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-kcaFYLpwNayPW_BKEVXs_Q-1; Wed, 31 Jan 2024 21:59:42 -0500
X-MC-Unique: kcaFYLpwNayPW_BKEVXs_Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-292bc8b6b7cso391637a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706756381; x=1707361181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0K09n4KM4GfA4ieYr3u7htlPmiCBvQiYCmB4ilutQSI=;
        b=PSJiriWSUtDFlfC3x+C1QeXdhff47CFDGR+y1oLglbRFuKOfFst3r5++4UTTqz6bGO
         0QFA/kUbQftMLAMTDMdLYP3tZtYTUeT3334hsIX2tvqPzTIlNFlJlaXSf4aqQwsIh3n3
         cVD61kkNSJp4FcdGO00vu3yfpGrCpxRQTzpOobIG433f9lw+ESZXBCzb2GNhqPuXfdV9
         jCO/00+gJ+n345HAI3J05eImcStdUkRkOVxUKZZh1RQ9yOtUGkInh/2RHBe84au+TqDy
         83KzQ1J/Vk85xBfCeVEoqQ1InqzT3O8xT1OTFXnoP9AVIDcN36pq5ADhXta+WxPo74Qg
         Wimw==
X-Gm-Message-State: AOJu0Yz9VchRz0o6X919Y2d2oLScA03vfzKyjkdxDSCuhDurEvKzpdxH
	C9o098mkJmQCVzuc9/u9a7DCPWwsoPJlHeEUnuV5r9gKBuy+6GXvw0zx2l6WD7M8vLMHW5Z5xP5
	0dkMvzfzivivoIjEDHWc9H+7oP8qud+daEiUfuJwKUrXp1qXaMymNEu/cSgxD7g==
X-Received: by 2002:a17:90a:ce18:b0:294:7038:777d with SMTP id f24-20020a17090ace1800b002947038777dmr3901981pju.13.1706756381074;
        Wed, 31 Jan 2024 18:59:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0ZQ2E5GxhjYagXcM2WpAQ5CV3eNZ5+T0wmWcpW9bT04Oir0NC6ttw5pobxxz+SLpJhTJo0Q==
X-Received: by 2002:a17:90a:ce18:b0:294:7038:777d with SMTP id f24-20020a17090ace1800b002947038777dmr3901969pju.13.1706756380799;
        Wed, 31 Jan 2024 18:59:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVsjvS8L1o8MG8eurFUAa7zDMjUJgz7DPAVdr13C1+E7gDNRiJUiMRYodfSCKOiaKxZOxE2VZtzSnPzmXvRWCQ2VUGoeu++Ovg8wbdO/9vvgRQDc1tkd1CYI6sYttHd/336382BGsRYwjCIaCII8i/GcCsvSKaYKPXw+HLH869NJx6RTmpLkDQt3Ktfjim/OnmkAOQsbDk8KFRYy43G5MrZgajVitt3fqRzTC5hn2s21grwSOR/vz9yaZzHilnZPEn3XTIDswmDHsA4MVUpdQG81c8CH3jOjJ5KzL7RBg==
Received: from [10.72.113.26] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v6-20020a17090a088600b00295be790dfesm2225567pjc.17.2024.01.31.18.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 18:59:40 -0800 (PST)
Message-ID: <2fccdb02-3b66-40b9-a0d7-a79fe7c5580a@redhat.com>
Date: Thu, 1 Feb 2024 10:59:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fscrypt: to make sure the inode->i_blkbits is
 correctly set
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, tytso@mit.edu, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, idryomov@gmail.com,
 ceph-devel@vger.kernel.org, jlayton@kernel.org, vshankar@redhat.com,
 mchangir@redhat.com
References: <20240201003525.1788594-1-xiubli@redhat.com>
 <20240201024828.GA1526@sol.localdomain>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240201024828.GA1526@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/1/24 10:48, Eric Biggers wrote:
> On Thu, Feb 01, 2024 at 08:35:25AM +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> The inode->i_blkbits should be already set before calling
>> fscrypt_get_encryption_info() and it will use this to setup the
>> ci_data_unit_bits later.
>>
>> URL: https://tracker.ceph.com/issues/64035
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> Thanks, applied.  I adjusted the commit message to make it clear what the patch
> actually does:
>
> commit 5befc19caec93f0088595b4d28baf10658c27a0f
> Author: Xiubo Li <xiubli@redhat.com>
> Date:   Thu Feb 1 08:35:25 2024 +0800
>
>      fscrypt: explicitly require that inode->i_blkbits be set
>
>      Document that fscrypt_prepare_new_inode() requires inode->i_blkbits to
>      be set, and make it WARN if it's not.  This would have made the CephFS
>      bug https://tracker.ceph.com/issues/64035 a bit easier to debug.
>
>      Signed-off-by: Xiubo Li <xiubli@redhat.com>
>      Link: https://lore.kernel.org/r/20240201003525.1788594-1-xiubli@redhat.com
>      Signed-off-by: Eric Biggers <ebiggers@google.com>
>
Ack, thanks Eric.

- Xiubo



