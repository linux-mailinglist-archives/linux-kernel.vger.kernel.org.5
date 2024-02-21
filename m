Return-Path: <linux-kernel+bounces-74953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6743685E06F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB30286D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D667FBD2;
	Wed, 21 Feb 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="do9bUBOQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C807FBA9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527774; cv=none; b=ZqmyrC7pA8GbuIC0AV/ViyerzDQ9mongYbCf+Gzd1DQOtERXAUumK/SWbxHRvbUjX3EP+rf4WYIsas7e1Vu6eA9RUu8rfQzCeuNZhZby4V/FR5czLXhgsazxZoXCHulxAmmn4ZbJlM72ketwVtHx/0oN23z977myr/mLEjjJ+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527774; c=relaxed/simple;
	bh=IA04EINEhiUmPausJhAIhNYoBrh5gGBDp2/hkWPg5UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aP0ESfeSSfN3h2n4vvolgsoFac8sy7587570KJdXJswTK17JsAbrzTpN2NTY9TxzO7q4Phm1Sglp9Lyj1i86L9pRnkupcn+OTY5Oc3nCxYqRYmdemnPR7eX7Le8YBxUWeNRyZObNlRZr0kmHSpHKwW4H7gfJ64PJV+8H2RgV+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=do9bUBOQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708527772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I/8ZW7ehoVJm2qwscz6N6lVDOiwYLRnszTC5mnwo62I=;
	b=do9bUBOQvYA+/ZP+wtGq4/Nfwr/9xTsBbzhhZvBRQoJMPtNiCG6zGOCIpZHmvhreg+6hoe
	d4cekELr5N/X1d0u4VSBXkVp1B4EgozOgarw0TJyYDXGcekVLfz453nCIa0kNOTmj0wA16
	6OUsX0GQInSvMx0ojeHw04I4oK6Cge0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-GoGBrqZeNrapIN-UUqWtHg-1; Wed, 21 Feb 2024 10:02:50 -0500
X-MC-Unique: GoGBrqZeNrapIN-UUqWtHg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41277d0cbc0so2395155e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708527767; x=1709132567;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/8ZW7ehoVJm2qwscz6N6lVDOiwYLRnszTC5mnwo62I=;
        b=Xn+OMstoqaGBrRHEZ+0HZxpMAXoUy3zYqMvxw1blloglnvAedQyesxjIOhoa1+jjoc
         BBCVaRB2kwzntC9YoIiIa050CQBZqjcn3CxVo/ydgdxpcMkGdX3NHRZAby5PQUyVkh+O
         ZG7JHGMiwtVr3BFilRhCgag8oMQV94UTfw2S6INDBN9g1lQ8w+7HNK6s9SGptcV1l/Al
         QqEH7aWx1DOtJDdC2itj6/T5G2HPipkgr8OjtEVfPtptyWiRuOHgSwrJcHK5vsz58wVW
         bHGmW5Y58mfWir8YSuwxFM+vdd4kF7BzoOaarCQSelu7iMzuxVH42ryGhXYVHNACccCM
         0xpA==
X-Forwarded-Encrypted: i=1; AJvYcCXj8sNfqoGtcjkjqrqp4afx3lIHXcJuHyBeXOe5tKHpzJrC6TdoaKzWhnSbJ6fXkXGWws92a4kjFA6WJ8q++pMMZje9XuMzan9cpH4r
X-Gm-Message-State: AOJu0Yx9xS1JJp47HZeIJI8cQHAmrh/I5c/KVwvLhI87QqYJ2jvHQ7a+
	OSAVfyLhujvJwa+k6iPV/0YU9TWJ+DIGrH6XI5kr3SXF5BO6+XK/8JEmz2cOkawPF2gat0eTgWB
	rN9/D9fpKXIO6W2g+PujvD0ds7qU0tdYtdJP9n/4JBg6kLQ+krmP/GS4bG9GUHA==
X-Received: by 2002:a05:6000:120f:b0:33d:3c05:ce4b with SMTP id e15-20020a056000120f00b0033d3c05ce4bmr6141271wrx.60.1708527767531;
        Wed, 21 Feb 2024 07:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBgxqKp5L8LW1pipPH/hbqBw/uqVR71+hXezyMWvFcMTmbBmgKlDVlbUwu4tetHkSPduKGrg==
X-Received: by 2002:a05:6000:120f:b0:33d:3c05:ce4b with SMTP id e15-20020a056000120f00b0033d3c05ce4bmr6141256wrx.60.1708527767109;
        Wed, 21 Feb 2024 07:02:47 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id x11-20020a5d490b000000b0033cf29a67c7sm17283919wrq.7.2024.02.21.07.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:02:46 -0800 (PST)
Message-ID: <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
Date: Wed, 21 Feb 2024 16:02:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING
 in raid5d"
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org
References: <2024022009-subsoil-halt-4b28@gregkh>
 <7ae646b3-28e4-4344-a7a4-730a0d6e3f38@redhat.com>
 <CABgObfYDcFPRNpGtsY=UbstXbqVCMcxy3LPS_xJ65aFcByC=Nw@mail.gmail.com>
 <ZdXt09vL4GJy6PbP@sashalap> <0e8675e0-165d-4cf7-9755-666278868ab8@redhat.com>
 <ZdX2LcAWR6wyvYC5@sashalap> <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
 <ZdYKSkqRckOc5aRO@sashalap>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZdYKSkqRckOc5aRO@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/24 15:35, Sasha Levin wrote:
> On Wed, Feb 21, 2024 at 02:15:12PM +0100, Paolo Bonzini wrote:
>>> On 2/21/24 14:10, Sasha Levin wrote:
>>>> On Wed, Feb 21, 2024 at 01:58:04PM +0100, Paolo Bonzini wrote:
>>>>> On 2/21/24 13:34, Sasha Levin wrote:
>>>>>> [snip]
>>
>> This conversation needs to be public.
> 
> I've cc'ed lkml.

This is an empty message, so it's not going to help making public the 
part of the discussion that was CC'd to the moderator-only list.  I take 
it that I can quote any part of the private thread?  I'd like to have 
your explicit permission for that, if you are not going to resend your 
answer.

> You'll find that the convention for *-announce mailing list is that
> they, as the name suggests, are used only for announces and are
> moderated.

Indeed, all two of them.  ¯\_(ツ)_/¯

Paolo


