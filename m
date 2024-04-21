Return-Path: <linux-kernel+bounces-152595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CFB8AC0EE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4511C208BE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C303FB8B;
	Sun, 21 Apr 2024 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJYXt8o3"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996523D38F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713727419; cv=none; b=Su3Y9ieK71FEH9CmythN9OsSPSLSCyXC8dGgKoirtpEWJqoeuUDBkIisHlPlzduWsiPjTJP916LkPstm8+CZM81ESAkxtrW1TKI0CQzy1FyF0e8Vf2k2/SV5R8XXj1f3EnxFSP5RDu8tS3Wit3s2nDeSDefNCiN3axxuILyHZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713727419; c=relaxed/simple;
	bh=ko3baWa0bXarvAUBkLoisnJ87lFgJ97JsurMB9rDxfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8P7g/HVjfOQZLWfjgwCSoPjtP3HUhHHIJXrhDf0PFRfv80Xx4dVbqII/xXF7H94oH2Y6bwqidqEyV7iukx+5zfL6pGrEdx1yGaASaUEdJY6ItegD5GZSBbw8OS6rZcw5296VxBoey/rpgDAvoGBlz7BnW4X9G8hd9VWkmlNHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YJYXt8o3; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-437b3f256easo18510361cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 12:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713727416; x=1714332216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqhW4D4jLVsKH1utbHDn/iKJztmh2klhA7VKP20qINw=;
        b=YJYXt8o3ISIOOewEaP0VkMBiYskRWkaijkP77qqV275dtOHf4fGO3AYekbZ2+NH9qu
         ir2kRyADd48L3HOnKxn+logXIIFNoHhp1A10YbKNGrhXANPjHvI37n/YZ6uL7tx76YzQ
         WE29s1Gxv8rnVw6yiiTbzOvewZ5JlqCetlyt8Pdj0UBLSq5CsNzNVcU3l/mEuGsgw1Kh
         r3gp6K+bMoP9z4olFRBNCbmCAS7DtMS9meakHSUgVF/KOerCio3PRsCsrh1E61jGW/Z+
         84t3TT6pTCgmCEDE3g4Bmbfj9fSQD2Vd5/5ReVYDzbolFDzDcMP/5miHVOUasFA5f+6N
         gJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713727416; x=1714332216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqhW4D4jLVsKH1utbHDn/iKJztmh2klhA7VKP20qINw=;
        b=L86exAPKHHw8TjVxwN9nbR9IMrxjJtFV8qhdWXSLnN0u1RpbvHqt9KzHUTSeoYCumL
         anmiVA2kQKEIaG/5ovYYz9Fxruv4SLru1uQNHEQ1rELjXtw5ngumZIrFJWWAfWFzp8Dm
         UwGtywlINftFn+q7/3O3KX7c1Ps95ScS2shsmWSYWivkU4gqOF108RD4FlZ4ozWCLdBf
         Eh6uM8a+kYOeM7oHgjNFnpn+dORy7eZrqvlxXAxNn6ieQhYl0ui/BlrJkZ1A3F9p/vJi
         9uir+b/rwDCQTxzPE3ecCjSwzQtY5Z4kcjxcEL1YqJnHQw5eHC+4EV6hTuoZKAJElW3O
         TUWA==
X-Forwarded-Encrypted: i=1; AJvYcCXd4KIkZhI9h1l0snfZ932fk2fn5e71arDKbh5pY/c9358djXj3n1Y2VHVRgxcp/YmpR5lMEkSujFTv1KuLWOfXnap5gjzdcIrAMg1x
X-Gm-Message-State: AOJu0YzawD+n6Zpdc1a7KdkCSwZUCdjLl2saFWNYmfkPEQ9NvorAbxZc
	W+AQGnb+6NLeLiRFurGna9zpbqcXFqFclQfakudyIDS7TqAxRHcijJFe9CxGOcc=
X-Google-Smtp-Source: AGHT+IFG+MgI9P5zvYhi3oK9zNce0+Wm/zV3xYro6FQoOvWRlykWswFzedE1EssCx/FegZrr7XDg8Q==
X-Received: by 2002:a05:622a:1a02:b0:437:9f6e:81be with SMTP id f2-20020a05622a1a0200b004379f6e81bemr11102550qtb.25.1713727416517;
        Sun, 21 Apr 2024 12:23:36 -0700 (PDT)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id w2-20020ac84d02000000b00435163abba5sm3604873qtv.94.2024.04.21.12.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 12:23:35 -0700 (PDT)
Message-ID: <5d580dd8-8510-4754-982a-131ea994923e@linaro.org>
Date: Sun, 21 Apr 2024 14:23:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] mailmap: add entries for Alex Elder
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>, Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mka@chromium.org, quic_cpratapa@quicinc.com,
 quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
 quic_subashab@quicinc.com, elder@kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240421151732.2203345-1-elder@linaro.org>
 <kabhsybtcfg6ky46rwry462dpql2k6mcrnb7w7xtb5d2httg7r@lg6rbbmaiggp>
From: Alex Elder <alex.elder@linaro.org>
In-Reply-To: <kabhsybtcfg6ky46rwry462dpql2k6mcrnb7w7xtb5d2httg7r@lg6rbbmaiggp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/24 11:16 AM, Bjorn Andersson wrote:
> On Sun, Apr 21, 2024 at 10:17:32AM -0500, Alex Elder wrote:
>> Define my kernel.org address to be the canonical one, and add mailmap
>> entries for the various addresses (including typos) that have been
>> used over the years.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>   .mailmap | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/.mailmap b/.mailmap
>> index 8284692f96107..a78cd3d300eb1 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -38,6 +38,18 @@ Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
>>   Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
>>   Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
>>   Alexey Makhalov <alexey.amakhalov@broadcom.com> <amakhalov@vmware.com>
>> +Alex Elder <elder@kernel.org>
>> +Alex Elder <elder@kernel.org> <aelder@sgi.com>
>> +Alex Elder <elder@kernel.org> <alex.elder@linaro.org>
>> +Alex Elder <elder@kernel.org> <alex.elder@linary.org>
>> +Alex Elder <elder@kernel.org> <elder@dreamhost.com>
>> +Alex Elder <elder@kernel.org> <elder@dreawmhost.com>
>> +Alex Elder <elder@kernel.org> <elder@ieee.org>
>> +Alex Elder <elder@kernel.org> <elder@inktank.com>
>> +Alex Elder <elder@kernel.org> <elder@kernel.org>
>> +Alex Elder <elder@kernel.org> <elder@linaro.org>
>> +Alex Elder <elder@kernel.org> <elder@newdream.net>
>> +Alex Elder <elder@kernel.org> Alex Elder (Linaro) <elder@linaro.org>
> 
> Isn't this form (with the name in the middle) when you want to be able
> to map one email with two different names, to two different addresses?
> 
> As described in last example in the "gitmailmap" man page?
> 
> I think thereby this would be a duplicate with the entry two lines
> above?

I interpreted this form as meaning "change both the
name and the e-mail" but I tried deleting that last
one and it still mapped properly.  I also just noticed
that I mapped @kernel.org to @kernel.org, which is
dumb.

I'll send v2.  Thank you.

					-Alex

> 
> Regards,
> Bjorn
> 
>>   Alex Hung <alexhung@gmail.com> <alex.hung@canonical.com>
>>   Alex Shi <alexs@kernel.org> <alex.shi@intel.com>
>>   Alex Shi <alexs@kernel.org> <alex.shi@linaro.org>
>> -- 
>> 2.40.1
>>


