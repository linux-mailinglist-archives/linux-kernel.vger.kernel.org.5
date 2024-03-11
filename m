Return-Path: <linux-kernel+bounces-99220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2837D87851B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62701F26B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C25C4F8B1;
	Mon, 11 Mar 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TH9rFjT8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ECA4AEE4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173985; cv=none; b=VwkOewtreK9xosDmkPAO48/4479gd2/4afvCfr5xLYg1oYIYdIU4NtcYIubFmbucXTVR0OvwPgsWefWpxwhD9TV8rpNQHNHHZurs4I68QtG207yH59V4I6Qa3k+A9bXLRG/+LS96lpsG/LeNfA/9YvNHGO1+VRpL7w188aCIS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173985; c=relaxed/simple;
	bh=xEXzD4kw6+Z0h4GXKK73qPjqgcYopWBM+dQs7NidtYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxK2gLc6SbRtjNn/Qa5Asnz8eILqwb6UnIRo4MvK6ntqn4TJzKLSUFF0GzTYRQDvcG1RPqcWuHvRAVlXkXR3Lo1+nHfLGT3uKxgTbx63pMU30MX6wxbQtYKqi9LVSgqmC5q/fYBGmF606tf7aL1WGSwkogPgUw7qCKNH/dY+xy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TH9rFjT8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710173982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2mQahgGF7t5ilMRgxp66fiMOHm6Y8WHBX1CjCOYiUkk=;
	b=TH9rFjT8lol5h7+jzy4qt5b9Y41hOiCwle+guXB0o0e1Hn/6MzW3BJ4BlNW4ifLeucouKw
	H9zYE6r/ik0m4/SQEoJaMlLiSoCHYqGPnCA7mLA21sBhnfeo23I96J9e4NlZDiTNP/CfiI
	9MdGUxkUsM5eIxwQmYzHSSD6C2g3euM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-G0BnLGr-PjafHaXo9CX4kw-1; Mon, 11 Mar 2024 12:19:31 -0400
X-MC-Unique: G0BnLGr-PjafHaXo9CX4kw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a46376dcdcbso54657766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173968; x=1710778768;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mQahgGF7t5ilMRgxp66fiMOHm6Y8WHBX1CjCOYiUkk=;
        b=e0WnT9IbgD3N3527kO0hTNnbsCxhTjQyA8jj6cQgCc1+Ffen2KTiI38CurPac4WU4q
         EzErfPKbJhmRaIcsHz+ZUvwkB4+fRKm8Sm182N0EGkgenS+lFAPjs1nV4+Yg0N1fa+FV
         /RQrGTZOEL/mv5KS8tmvMOUgBYgBl9Ab03jhT76wZVtwGVza3p9fMCZ8IXzHGTN1yVC3
         n9GFDgm+O2PxOByqnr+uJhiaPxC0u+aQ4k+6yem6q3UzxVndObeGfnjKxqRldQwiFyst
         DA1PFoKiLEoFJU6qJDTofIAayG74wB00kilGA6Tvy+tDCSiHAfOSJDwAxIfXM2zYEIXu
         Vj1g==
X-Forwarded-Encrypted: i=1; AJvYcCVpHO23FUk0HZvlyqPSJ9Nd+zSlYhIDbyLMHcvFyaIxbbG0NtNEocLiW7LxlrSfMW7vNaGvGfWZhzn6nv1nCEORSUuZHPh4Sko8lk1F
X-Gm-Message-State: AOJu0Yz8brh/+naEdUztC0sJj+oBcWFnvet4VujwGF9dsbUpjtMnD2IV
	80nZ+UPVWwWpT1lhtQGiuvDTC0ntCbkwaxogPCwyjeB3HgvA35PCCm13AOmPtphVkJ72xjIM7KI
	cLOxBwEn8/ZWdODZBVXYqaVxAUuoSll3ZUEG6fhqO4s+dVSYSMdJ+1j4PWZ9bKw==
X-Received: by 2002:a17:906:358d:b0:a45:84e7:b25a with SMTP id o13-20020a170906358d00b00a4584e7b25amr5447608ejb.12.1710173968675;
        Mon, 11 Mar 2024 09:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoO7EDAZVtRfBv/pvsoBN7WxmHLuGVQTvibOB0sKCLOJ5yA2DM2cCu/w9a+YzK+thyglRvgw==
X-Received: by 2002:a17:906:358d:b0:a45:84e7:b25a with SMTP id o13-20020a170906358d00b00a4584e7b25amr5447590ejb.12.1710173968258;
        Mon, 11 Mar 2024 09:19:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:6100:aae:4b84:887c:15bb? (p200300cbc72f61000aae4b84887c15bb.dip0.t-ipconnect.de. [2003:cb:c72f:6100:aae:4b84:887c:15bb])
        by smtp.gmail.com with ESMTPSA id bn23-20020a170906c0d700b00a462e4d7216sm786317ejb.76.2024.03.11.09.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 09:19:27 -0700 (PDT)
Message-ID: <ef409d5e-5652-4fff-933c-49bda6d75018@redhat.com>
Date: Mon, 11 Mar 2024 17:19:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/khugepaged: reduce process visible downtime by
 pre-zeroing hugepage
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: mhocko@suse.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, songmuchun@bytedance.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240308074921.45752-1-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240308074921.45752-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.03.24 08:49, Lance Yang wrote:
> The patch reduces the process visible downtime during hugepage
> collapse. This is achieved by pre-zeroing the hugepage before
> acquiring mmap_lock(write mode) if nr_pte_none >= 256, without
> affecting the efficiency of khugepaged.
> 
> On an Intel Core i5 CPU, the process visible downtime during
> hugepage collapse is as follows:
> 
> | nr_ptes_none  | w/o __GFP_ZERO | w/ __GFP_ZERO  |  Change |
> --------------------------------------------------—----------
> |      511      |     233us      |      95us      |  -59.21%|
> |      384      |     376us      |     219us      |  -41.20%|
> |      256      |     421us      |     323us      |  -23.28%|
> |      128      |     523us      |     507us      |   -3.06%|
> 
> Of course, alloc_charge_hpage() will take longer to run with
> the __GFP_ZERO flag.
> 
> |       Func           | w/o __GFP_ZERO | w/ __GFP_ZERO |
> |----------------------|----------------|---------------|
> | alloc_charge_hpage   |      198us     |      295us    |
> 
> But it's not a big deal because it doesn't impact the total
> time spent by khugepaged in collapsing a hugepage. In fact,
> it would decrease.

It does look sane to me and not overly complicated.

But, it's an optimization really only when we have quite a bunch of 
pte_none(), possibly repeatedly so that it really makes a difference.

Usually, when we repeatedly collapse that many pte_none() we're just 
wasting a lot of memory and should re-evaluate life choices :)

So my question is: do we really care about it that much that we care to 
optimize?

But again, LGTM.

-- 
Cheers,

David / dhildenb


