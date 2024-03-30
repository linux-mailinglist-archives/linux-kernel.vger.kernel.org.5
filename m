Return-Path: <linux-kernel+bounces-125633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3F58929DB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86DC1F21FE9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785ECBE4E;
	Sat, 30 Mar 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OODYTfOj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7FBA28
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789348; cv=none; b=vCCbSigayZguhQ4MSWSQvknHYtxOY8g2zErCHoXkT/Qev/jRC0g86NkrbNhclwdPZIc9qmyH3sK+SmR6dYI07KAIHMsJhaFY8rGBFxbGKXXXpX2qQH0RvCM5sylEyD8vA4JBFmNO/xXjkgAwkNmmhj8AV1ppM8ASM65C21oAPr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789348; c=relaxed/simple;
	bh=cG5S+JlQSNwbyc3gVBwNnpu42UAF6/3bXloXVCJ5xto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkjkDs5jqUxbLh7gS7sd2KENb2c695zQTSy+V8qfDMZQDjnAXwEg1BilU223+V60iFeBeMh0UBJRaGUK0PfaDW1BmcrGmFvF0vq4EFuxw/g0FBsunj5RE4hqzrPmXNJ7kVdROmkQ3AQNcREO1whu/ebGNPJh0JVFRfCEw4jg05k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OODYTfOj; arc=none smtp.client-ip=170.10.133.124
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
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-lkq_b7snNXi8Q1uT4vSprg-1; Sat, 30 Mar 2024 05:02:21 -0400
X-MC-Unique: lkq_b7snNXi8Q1uT4vSprg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5dc1548ac56so1816822a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 02:02:20 -0700 (PDT)
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
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id br8-20020a17090b0f0800b002a1f77bde90sm5220353pjb.46.2024.03.30.02.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 02:02:18 -0700 (PDT)
Message-ID: <8faa07aa-d330-4e3f-95b7-26437d448beb@redhat.com>
Date: Sat, 30 Mar 2024 19:02:11 +1000
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


