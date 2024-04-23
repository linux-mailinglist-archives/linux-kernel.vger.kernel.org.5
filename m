Return-Path: <linux-kernel+bounces-154460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05148ADC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F57B2121D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1012A1C695;
	Tue, 23 Apr 2024 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBVqJB88"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9FA18E1D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843401; cv=none; b=hJW4pZ/pWMvMoNh4ganu0o7eXgio1x2iOkoBx2Vk/97exHU5dP0GcNtmU0eOZjB4I76os8M5jCXwirCvi1vocJeFrG932La3EC9BbQVygZtTrQdB7yhtJWCmxv5XIzzm+nvmhBCLKC0VCGqeIVavfiiwkwn34UGE4WjyXhTk6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843401; c=relaxed/simple;
	bh=5vWsoypMS8KW9AyNG2fX2xop6xfTDebSOf8rMvu+fP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiHzpaS54VeP2vm3R/2f8vSZIQPY22qg7uWTSwEst9yJqCk8D5VVklLSf/M0JUYRbgjjQGNEQFc9KGRChT772s18UQjQao3t8s+cOOxC9JhmV4dxtsgdbIVSlx1oDBwTmnEMWIL6+k3vUM5i3dltgPl5QfvRzCLwOZqDpnW6Gyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBVqJB88; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713843398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AgcL8WISfu/qXNDjCu04c4243W33DII37P9yj0gbDx8=;
	b=aBVqJB88wTqrzlhJgYwE+XXgJw4wQ0wDUvXWa+97KkCkJMcrHugC9YcfupsFEt8BtYn0wB
	J78Pwzv5lQRkVO/wn86OD7zRCsuyZtsBDpmMsmZtrHo0GcuHCj9N+JDRPsUvelreEW2cqH
	KF98fjy4t2htsT6G+BJimDbTyoJeruQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-1FrMKfsGNPKm6FkfsLNgNw-1; Mon, 22 Apr 2024 23:36:36 -0400
X-MC-Unique: 1FrMKfsGNPKm6FkfsLNgNw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ae9176aad8so528394a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843395; x=1714448195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgcL8WISfu/qXNDjCu04c4243W33DII37P9yj0gbDx8=;
        b=CscCeAnQx/H7dzgC4g9ZBiP6+KNt3gua2WKQreCJ0LtkvDmto4o6hD6mQBoqO4bNOK
         0JkWvzgGtBF7OBtoDet+w2xC7zbYuXONpJdRpfCYsjVvFPtkLXWlMmkQzsclfvVrZhug
         18ciPYeSGUwDm0eEN+3tMAUih/W7DYP8QQxQxKSrvCWQUw8MQo+V6DTaxK5jdrDTgJQS
         7vDdv4VHK5VRX2GUYL7pQNQ57Z/r3GgM9BCkrDUZ9UlSpWBO2iQDR7JnS6a/Mf5DcluZ
         HzxPe5vK9ea5BvtrlmUvny07hiOLgkRSZfw0sToZq5BSFUgItfnuKORgGfWPvKdxjbDO
         9xPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBPuhA1g0QWXSElR/MxG9bZ/EBmd9C4HkwHI3/MqFFSxXc4BLZ1ZmJlKtrUhcmtKizvc+DJKNwAmUD+Mbf/V0y6sde8aK9eqBDvHO1
X-Gm-Message-State: AOJu0Yw/lOV0na6oUhYFLeJOdBiro5XJRKpM/eAOqBPpsC6DPePaEqOX
	uQOJgCwWWnBiXgcx7NGgeUZ4QTRvLp8UUxaIoCoH8hzWhC1C1ayazCenL4hQl9zQUyUmSaQZYRO
	M4bdOSgkRft9dd+p7bjYlP6J35f9OFVBsHqs+dYRx3KuNgug07LgZQj5+SoyiAA==
X-Received: by 2002:a17:903:11ce:b0:1e5:8175:4968 with SMTP id q14-20020a17090311ce00b001e581754968mr13010968plh.9.1713843395474;
        Mon, 22 Apr 2024 20:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmA/UxuttY5yGQe1dI0Jcby9qAk2r05g3/+ydlbjNUppckMjkp348qHRTTrErFgimcynXhrA==
X-Received: by 2002:a17:903:11ce:b0:1e5:8175:4968 with SMTP id q14-20020a17090311ce00b001e581754968mr13010950plh.9.1713843395116;
        Mon, 22 Apr 2024 20:36:35 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b001e3e0aa9776sm8877634plh.27.2024.04.22.20.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 20:36:34 -0700 (PDT)
Message-ID: <d5ced670-832a-48b0-8d87-c34273323ccb@redhat.com>
Date: Tue, 23 Apr 2024 13:36:28 +1000
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
 <8faa07aa-d330-4e3f-95b7-26437d448beb@redhat.com>
 <b41d65de-dc43-45f6-ba6c-ae722fbb70a8@redhat.com>
 <20240422164613-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240422164613-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 06:46, Michael S. Tsirkin wrote:
> On Mon, Apr 08, 2024 at 02:15:24PM +1000, Gavin Shan wrote:
>> On 3/30/24 19:02, Gavin Shan wrote:
>>> On 3/28/24 19:31, Michael S. Tsirkin wrote:
>>>> On Thu, Mar 28, 2024 at 10:21:49AM +1000, Gavin Shan wrote:
>>>>> All the callers of vhost_get_avail_idx() are concerned to the memory
>>>>> barrier, imposed by smp_rmb() to ensure the order of the available
>>>>> ring entry read and avail_idx read.
>>>>>
>>>>> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
>>>>> the avail_idx is advanced. With it, the callers needn't to worry
>>>>> about the memory barrier.
>>>>>
>>>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>
>>>> Previous patches are ok. This one I feel needs more work -
>>>> first more code such as sanity checking should go into
>>>> this function, second there's actually a difference
>>>> between comparing to last_avail_idx and just comparing
>>>> to the previous value of avail_idx.
>>>> I will pick patches 1-2 and post a cleanup on top so you can
>>>> take a look, ok?
>>>>
>>>
>>> Thanks, Michael. It's fine to me.
>>>
>>
>> A kindly ping.
>>
>> If it's ok to you, could you please merge PATCH[1-2]? Our downstream
>> 9.4 need the fixes, especially for NVidia's grace-hopper and grace-grace
>> platforms.
>>
>> For PATCH[3], I also can help with the improvement if you don't have time
>> for it. Please let me know.
>>
> 
> 1-2 are upstream go ahead and post the cleanup.
> 

Michael, a cleanup series has been sent for review.

https://lore.kernel.org/virtualization/20240423032407.262329-1-gshan@redhat.com/T/#t

Thanks,
Gavin


