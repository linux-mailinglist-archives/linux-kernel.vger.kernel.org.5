Return-Path: <linux-kernel+bounces-84844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A182686AC58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7091F23C73
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7B129A81;
	Wed, 28 Feb 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDHoail9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929A01419BF
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117224; cv=none; b=KXSWaD+5Y0ltAkrSD/4thGHhvl6DrFo/W8kLdA45CTiKUdFSut+5+V4VbupNr+dFq36UKok80+TtyMz+eY92LxSMmJwZ+SQAcJO0Xx/aXNi6Ljr8XGV+RA9Bj394RySombYHHMzkx7rNGvEF4zKA8Z9AY0YUSbij0i0k+r0AQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117224; c=relaxed/simple;
	bh=k7p6dEiqHUwJL4U0LJbIatYWo4aHYpi2+4FtB9a9Bo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejhYKusIMirvkcqcb5DeD2p7hbSI9zThQJLcoxvytslGX90kqkneswudPk/TsLUE+Lus2sLVssPvf9Gl7K9nBWhFKeD5T3T0PZDYEdPVVgr12xpMQDK0rQSZ7EoLFOrmE3MqKZJqU9muhuRsGYgTosbT/SO6Tneu0nxU2NnFmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDHoail9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709117221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Kc3+qohcYOv7xTer5tRFWbCV/ueH7+RPa9lqQ5Kk9yE=;
	b=gDHoail9yn2i/Zzq0jjFdgGx+o582oayRKeswSXS2/+C2u3Zn55z997JCjJRz7T/Na9qf0
	CR89aws9dyrN1NBp7EJ1z0lxr/0FeDVVikksVwZMvahyCXLaHoAqJcrBqaC/vDg4680N5M
	YIFCplnv/t2W77fI8IIQ1Uo5F/ohi+g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-ZEEreVnuMYCRfGFVYnOUcg-1; Wed, 28 Feb 2024 05:46:59 -0500
X-MC-Unique: ZEEreVnuMYCRfGFVYnOUcg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-513149e133cso1108173e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709117218; x=1709722018;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc3+qohcYOv7xTer5tRFWbCV/ueH7+RPa9lqQ5Kk9yE=;
        b=Ctft60oGiNipUvNu77eFpKr59GRGeD9vZ1IXlpQdffUTi6wJmcDsNNwFQEK+bgkggj
         jtvseF+V0qZSsmfyrGmM+Gx2SU+qxQZ6GVTnZRAHODmykqKEcUe3lpDyrUyw8i6Nf6Kd
         P7V2+NoYQtn09/Nxium+qjFcf60x0Cmrz5bXCppZzxSkxtRD9CyJpD+UM9CjtQBcG9y3
         dg2+RldXQdHWZZjLxShbokQQVig+KUNJqDTE9Zsmh+vInbCWN2ioFvvj5XLjXe4tklpR
         HUhHubHiVpjScYojATJxgmbCQDCadWhIBhJ1vUwCwdp/O7TmM2KV0+D3jeN4Wi8jEQnK
         UOew==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ymo3HDVM0p1trcqfZPRtxYp5mMeC6UPzhWonUYokGBRln7fp4kxwVKt9B5s7O/aVbkMSHjbKYQAF3VQmXfPdT4k/wwgylDDSY0tg
X-Gm-Message-State: AOJu0YwkA+52SwxjQq1ZwPkYa8Ut950/XpwLwn1fv3nZI088z2s03MXk
	+kB9eO0hBwFsMj8ipFAHw+3cSRPsc+l6TPta0UF6h74Izj45GPkESIzbRtAwhdTvHgtXYqLAypb
	bAX7I8mkxv+PKy+mRo3PWvc015N2RMAmLvRWQOXJfTv67OFYF58xN7H2ukG2hlQ==
X-Received: by 2002:a19:7619:0:b0:512:d907:3161 with SMTP id c25-20020a197619000000b00512d9073161mr7631211lff.66.1709117218342;
        Wed, 28 Feb 2024 02:46:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6CzADTyebzu2Slcxx0hE7NteAMQ7UJqGjlJVvgdrPVCvKtxmvbU8C0mLqHkB6o6gP7KsU+Q==
X-Received: by 2002:a19:7619:0:b0:512:d907:3161 with SMTP id c25-20020a197619000000b00512d9073161mr7631188lff.66.1709117217856;
        Wed, 28 Feb 2024 02:46:57 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id bv26-20020a0560001f1a00b0033e03a6b1ecsm701426wrb.18.2024.02.28.02.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 02:46:57 -0800 (PST)
Message-ID: <c47c032a-bf47-4c5b-b854-37c33a27cb39@redhat.com>
Date: Wed, 28 Feb 2024 11:46:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: userfaultfd: fix unexpected change to src_folio when
 UFFDIO_MOVE fails
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, aarcange@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240222080815.46291-1-zhengqi.arch@bytedance.com>
 <20240222130005.c3f24eed1c1a27c66947e9df@linux-foundation.org>
 <CAJuCfpHoxAZvRx2VN+SzsjefB5demhk5OV_wPe8JYnsejgA91w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpHoxAZvRx2VN+SzsjefB5demhk5OV_wPe8JYnsejgA91w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.02.24 22:56, Suren Baghdasaryan wrote:
> On Thu, Feb 22, 2024 at 1:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Thu, 22 Feb 2024 16:08:15 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>>> After ptep_clear_flush(), if we find that src_folio is pinned we will fail
>>> UFFDIO_MOVE and put src_folio back to src_pte entry, but the change to
>>> src_folio->{mapping,index} is not restored in this process. This is not
>>> what we expected, so fix it.
>>>
>>> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
>>
>> What are the expected worst-case userspace-visible runtime effects of
>> this flaw?
> 
> It can cause rmap for that page to be invalid. I guess memory
> corruption might be the visible effect?

At least swapout+migration would no longer work, because we might fail 
to locate the mappings of that folio.

Memory corruption, not sure.

-- 
Cheers,

David / dhildenb


