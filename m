Return-Path: <linux-kernel+bounces-163138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3DC8B6641
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B281F2234F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B01194C6B;
	Mon, 29 Apr 2024 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ereFXtia"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9117BB1A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433490; cv=none; b=uioh/FDaO57vfResTS7y9aJOLIBh+un/8CeFFdiTcYM0n/ypQuABAs2wTPRzS7ZCi7XbVI/thWI8a0COQzb2afj1Q1j4KAzs5x6wQdAS8PsXJupvnyJ14Mi3pKP7qfLT4OHwIcZAgrMo5BFgas0xYvTDr4yzdFjux7OUBfzNod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433490; c=relaxed/simple;
	bh=uqj4V0skS+CEC8NZm0u8vNAfU7/jX2gON652FcP3oRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahl9mqVEwTlxIM6lXzr9TUOBAZ+7NZMmXETwJS3Y+7KDn/BtsFOlmVjAMDF0jf2cOphS1a6odFUiQlK/7kdFq6XMCUSKCDwZf5KSb89pqldWCiSZxlIX67FxJD9TOLaZNJkMZO9UB7sO5pwEUEmm/w0kwog6NypWjgpTNH8NaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ereFXtia; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714433488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSjdbinHyW1mkl/2RciXGi7LJcTI4CBgysLnfFPLy8s=;
	b=ereFXtiaQLeAKWXtmBsuzi5QzJhHc6x+EJogTgw+pT2OLVq0O5rO6Y4CD7HCScghr9wUF/
	09tzvqyIfRkpkFomIazxcOxyJFUZp3I8CSZOguWKC3r1stwE2d6kp6ofgO7qAOZH98M8ju
	1anx3qLbDCvR+dlHjFP/P0oTDBrq2N4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-ytkIzzI1OFu2L0SXNU7vyA-1; Mon, 29 Apr 2024 19:31:27 -0400
X-MC-Unique: ytkIzzI1OFu2L0SXNU7vyA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e2a5cb5455so57818625ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714433484; x=1715038284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSjdbinHyW1mkl/2RciXGi7LJcTI4CBgysLnfFPLy8s=;
        b=OWUkLt3YEhsToBWKlsRTnMDcG2NhVXNSsAikmiac0dd0egDCAdMb4SPcYerCDDKDdw
         YQg/byNgC5Q2jZWHgwUIXrKgONmZx6e03uG9NzrZpo848FuxBU2IaGwmvIl64o5091w6
         DfQotM/e7PsqTxV8tGWWRuTbjnG1XKLCaNGwZi4pkUcB+DV8TOTEN+NK4spT7rU1PqaZ
         Qh6HITs3cJYOsK4lBVtWIPgZT6YL/u52xD6elGMemEyOk3o+E9QXBpJmAxMD6fGFsLe2
         ML0aW0yhZP7ta6N2wNrJMH+jmBBUuTlCOGdR1JVu0CT0AXyutJHSDpM1t8GSo+JV5Oc1
         9c8w==
X-Forwarded-Encrypted: i=1; AJvYcCWlRi6gIwIXyWqPaT0FVx/VRTEtzqVKoU1E2AwbCJ/d0lfyZlQiM0i+drJoB990pDCjoD+F5tr5AegDHrht9zEbxiAtr5+pjL5VYP6t
X-Gm-Message-State: AOJu0Yz3yoLrrGmzoJXIwIhH4vB4qKbsSyAqsWHAdHkKIRiNe1hklWsI
	UUazEk7ULbDiEfWiS3NogSEYYzCHeK2a0E9x1ARg2e288GvDCr/CzgR4SAW1AGFMh/ssguIyORJ
	rOUTLWgBo/i6NJ1wWch3fp32zlRnQPvA7TqvXKuX6QaJkWMnhXfRZaWUuzmBJCw==
X-Received: by 2002:a17:903:2409:b0:1e9:a0ce:f618 with SMTP id e9-20020a170903240900b001e9a0cef618mr11564138plo.69.1714433484114;
        Mon, 29 Apr 2024 16:31:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3e9Pfy4WGNwSUUoxTKAPNsdqjkvEKIg+2mxHAdsBmatNV2ftHrHQ/ozCS3sFtSigko90WTQ==
X-Received: by 2002:a17:903:2409:b0:1e9:a0ce:f618 with SMTP id e9-20020a170903240900b001e9a0cef618mr11564121plo.69.1714433483816;
        Mon, 29 Apr 2024 16:31:23 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001eb3d459143sm5443739ple.48.2024.04.29.16.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 16:31:23 -0700 (PDT)
Message-ID: <4dbd2f9e-0769-4b9f-89af-d864f404c86a@redhat.com>
Date: Tue, 30 Apr 2024 09:31:18 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] vhost: Cleanup
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, shan.gavin@gmail.com
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429144955-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240429144955-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:50, Michael S. Tsirkin wrote:
> On Mon, Apr 29, 2024 at 08:13:56PM +1000, Gavin Shan wrote:
>> This is suggested by Michael S. Tsirkin according to [1] and the goal
>> is to apply smp_rmb() inside vhost_get_avail_idx() if needed. With it,
>> the caller of the function needn't to worry about memory barriers. Since
>> we're here, other cleanups are also applied.
>>
>> [1] https://lore.kernel.org/virtualization/20240327155750-mutt-send-email-mst@kernel.org/
> 
> 
> Patch 1 makes some sense, gave some comments. Rest I think we should
> just drop.
> 

Sure, v3 has been sent with PATCH[v2 2/3/4] dropped. Please take a look
when you getting a chance.

v3: https://lore.kernel.org/virtualization/20240429232748.642356-1-gshan@redhat.com/T/#u

Thanks,
Gavin


