Return-Path: <linux-kernel+bounces-126171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C52B893317
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2881F26500
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816B150982;
	Sun, 31 Mar 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OODYTfOj"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E381474BA
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902489; cv=pass; b=lTqN0jTw4kXUQDH64ZRcupkmB8Poj6DbEFzviZaqrQv2lP6rmMrZlsS95wjJO3o/FTqQrfI0fhJX1n4tLbCa6o6At7sGDlVQcbvrWJRKuXtvqpEKhSdal5KtkNtjaJgHgu/WCeeFe9FibBJiY7usIP9BIYrbWRCRzVq+M88EFk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902489; c=relaxed/simple;
	bh=cG5S+JlQSNwbyc3gVBwNnpu42UAF6/3bXloXVCJ5xto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIivTQrh/o7MTSnhlGHXwbG/OKcr85J3656Uavb9/j1E6HxhYGu8y5ni/Ku0HusUkknRaAI8+7yT8PVJUaxdjYGS7Q7ggQrwfkUpi0surhzpRDT9ENyYXjqUUvoD2pi6cXYrXiM8BIpDyV91nvBznwAiRBGIX1Mcn5qasx1MM70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OODYTfOj; arc=none smtp.client-ip=170.10.133.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9A7B3208CE;
	Sun, 31 Mar 2024 18:28:05 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i16HuouXgDHp; Sun, 31 Mar 2024 18:28:05 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 13289208C2;
	Sun, 31 Mar 2024 18:28:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 13289208C2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 063DA800057;
	Sun, 31 Mar 2024 18:28:05 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:28:04 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:46 +0000
X-sender: <linux-kernel+bounces-125633-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoA677p8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgApAAAAl4oAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 14828
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125633-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5908220872
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789348; cv=none; b=vCCbSigayZguhQ4MSWSQvknHYtxOY8g2zErCHoXkT/Qev/jRC0g86NkrbNhclwdPZIc9qmyH3sK+SmR6dYI07KAIHMsJhaFY8rGBFxbGKXXXpX2qQH0RvCM5sylEyD8vA4JBFmNO/xXjkgAwkNmmhj8AV1ppM8ASM65C21oAPr0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789348; c=relaxed/simple;
	bh=cG5S+JlQSNwbyc3gVBwNnpu42UAF6/3bXloXVCJ5xto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkjkDs5jqUxbLh7gS7sd2KENb2c695zQTSy+V8qfDMZQDjnAXwEg1BilU223+V60iFeBeMh0UBJRaGUK0PfaDW1BmcrGmFvF0vq4EFuxw/g0FBsunj5RE4hqzrPmXNJ7kVdROmkQ3AQNcREO1whu/ebGNPJh0JVFRfCEw4jg05k=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OODYTfOj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711789345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ox4bLWBHssSahIs5vyxVp5VuZqHQaMHkELMh6pm/WAU=;
	b=OODYTfOjUhDEiBX1e1iSNGdpsguXCTikCg64gTXgrZH2+noW7EYq+MCzXKyavqf7uIUjjX
	CFmGK58I1SVtT8UE1ReV9Us7EGTFFE/PcAMLsvi8FXsZGP17ni/LHZ+FpsIEl59CxFdO1A
	tSbfzsUvtZ2FvS7JV7d5HjOPEgfaIvM=
X-MC-Unique: lkq_b7snNXi8Q1uT4vSprg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711789340; x=1712394140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ox4bLWBHssSahIs5vyxVp5VuZqHQaMHkELMh6pm/WAU=;
        b=i5/kcCAyLFwvQEKPHoq3U3zV58cXlbJm9Ppu0yd3ohXAeaCbc75QdoElzg4vCw+I/u
         XVIXi5Xn0Bn1SsD6GCm8lQaJFpWPoW78/TqvKSa53xWNLxY3CEP3/wM5ac2AIBhYBGM5
         zbEM+fc5ljdBDQ6vGmHbM5uSQCH6/ELx3nwdxSdJRXmB8LNQVlZFnDSC3JaasdSQx66Y
         ZnT97MHUJlnPgVgDPEXPaj9gkclgntMx0uyGF8Zk9yPbHrzlNBMyBfg9009ofPamNZas
         Az+dDkfZUMtQjRd0WvBQkzlc1Fp5VNYDKtFW0otUzMpY453H2PtTANEfrgR0/gkFjS7E
         oDyg==
X-Forwarded-Encrypted: i=1; AJvYcCUOgpJfXihjcRuhD8q51BVbYZ9eaHvh9Lb+YwP2p/zw0kw6X3dWL+1spxC9ME8ehS7V3UjmYrmfICLxe6ulzVhC3KP2gcqbAn8+BeJh
X-Gm-Message-State: AOJu0YyFqrvIxXAxt+BNGsKYf1PT8huIeD1oUKFiuPHFHAzbhmlwEwoT
	1fLvT0pdKHFfT8WweTmck0JVStGw6XqBdgzk4Ogz5NN21KrOPyVvMKQemldS2Z14jQeWG5ORD/b
	Kkpe4Gg7oqgSR8rSC6uu9ERA9q4Vd/UoUFzYRlsBDHzmrUroJ/ukT13gqWZMT5Q==
X-Received: by 2002:a05:6a20:12c3:b0:1a3:c4f8:e9ab with SMTP id v3-20020a056a2012c300b001a3c4f8e9abmr4041440pzg.46.1711789340011;
        Sat, 30 Mar 2024 02:02:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+p/3De9y5/QlaUrTE+vbSXYudi66PREZzXboJoWujecgs+DaAf6ZzPy7h/4IF/TlSveFIgQ==
X-Received: by 2002:a05:6a20:12c3:b0:1a3:c4f8:e9ab with SMTP id v3-20020a056a2012c300b001a3c4f8e9abmr4041405pzg.46.1711789339663;
        Sat, 30 Mar 2024 02:02:19 -0700 (PDT)
Message-ID: <8faa07aa-d330-4e3f-95b7-26437d448beb@redhat.com>
Date: Sat, 30 Mar 2024 19:02:11 +1000
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
 stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
 yihyu@redhat.com, shan.gavin@gmail.com
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-4-gshan@redhat.com>
 <20240328052814-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240328052814-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On 3/28/24 19:31, Michael S. Tsirkin wrote:
> On Thu, Mar 28, 2024 at 10:21:49AM +1000, Gavin Shan wrote:
>> All the callers of vhost_get_avail_idx() are concerned to the memory
>> barrier, imposed by smp_rmb() to ensure the order of the available
>> ring entry read and avail_idx read.
>>
>> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
>> the avail_idx is advanced. With it, the callers needn't to worry
>> about the memory barrier.
>>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> 
> Previous patches are ok. This one I feel needs more work -
> first more code such as sanity checking should go into
> this function, second there's actually a difference
> between comparing to last_avail_idx and just comparing
> to the previous value of avail_idx.
> I will pick patches 1-2 and post a cleanup on top so you can
> take a look, ok?
> 

Thanks, Michael. It's fine to me.

Thanks,
Gavin



