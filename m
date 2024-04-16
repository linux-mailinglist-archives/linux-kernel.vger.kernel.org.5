Return-Path: <linux-kernel+bounces-147084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C848A6F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C666281E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1DC13048D;
	Tue, 16 Apr 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVsrEKEv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A712E1E4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279743; cv=none; b=gmV9212K7vdGm8qMIG27UQUGem3WbkJSgU8DF1GezHjlP60vvOi1oHrL6H+vr32m1F9z05ZjU4fHmNFlradjSaQCTAgHfGjFnrS9JkRZ4FyJz1KtB9kwzXQJan0CwHZ4W/IYLNb2eKqLZc7b56HyCudWjogJ1S9chmXd9rVLr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279743; c=relaxed/simple;
	bh=ZbcUx0LjIshTKQSB2RWvHwkodSiKalk8PnN6LGYty9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQC7EkN2cugh0Xk8E7cNksCs3cflrexjV+DxNr3q6iebvz8kb2FPeTU+0of8sHVXtYduAwhiDS6B85AW7y9ujnQGvZoTk02p0NkHJGvieO4U/f9to5YeRY7o2M0ryhl/Wd4Rs5569sOfYWFQULfH5Kt96jZhjL6GBgwxmKe+q4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVsrEKEv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713279741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=20Zel+aRdlxG5vA0u0sR8PKm+d7Ok5LOR3V8qTEvc4o=;
	b=YVsrEKEvZlTTe9S2e5w6v6x0/d8XmeSrHomwv8pxqez3p9hRk9s9kxTISZc7/81a3RfP7g
	Rp8bM5lRQsudmfo2LsN80UL4FDeld5aAcl+gDrh3olBebT8+Un8Qkb4JFzNVrdij/NXBHe
	ZnOvMAoLnBOUjG3NON7W2EnM7YVwIrI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-XLDehmTtP32UjuSPGpPTtQ-1; Tue, 16 Apr 2024 11:02:19 -0400
X-MC-Unique: XLDehmTtP32UjuSPGpPTtQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-417c92b77e1so19477395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713279738; x=1713884538;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=20Zel+aRdlxG5vA0u0sR8PKm+d7Ok5LOR3V8qTEvc4o=;
        b=O49q2el9We+jg5TU25r1Hznxo//9EiWx2poHHYGavxVvf4FUBbF9P/e60FM4VeSDn1
         IieMTKZ4KrVqRPnYaAYJXz8IBwpbpq7nStZCTV4qmf9LZ2VUmV1JGqDM7SZ8yNlDrOYc
         ie7kMw39EE+X/ILAag5JP9Bm3p5EsFBHu0GKK5oEM5yUQWMLPBgv2D6LsBKFiUz+H/zk
         N0dyvH86PKkqz5JSV0ddVwlFrnCILm5/d/DQBiBYEHEH/AgHelqnOL+TH44tc3XJeYrc
         ++KSRoVcQUMrre1qbcT5tCvw2NbEMQ/i4TiGDBgUrCae6dCBy3ymRdnIfns9EmqWzX3+
         0S1A==
X-Forwarded-Encrypted: i=1; AJvYcCXMsBKydfABFQ9G9EHLBes5W9SMfAXErocyecCId5UKeTRRZrVGL+d01/eWJkXgvU3agmQ8H31dN3qdAM+3gNwC/P8S45RHvrMCqI+W
X-Gm-Message-State: AOJu0YzT/ir8+Y2VPB8Ayd1JmwSM5lh+m9Vb9C9dtbBD9YDYiJScoZSW
	QcbrlEBmdT0YxcHvAjEGbwjZtewCKvPvWVuEaonGkEQFKLoJ3algg37sWZXINn8/VRn0HN0bq+H
	nQqy/LNiqxJ+Hs2W0IeqAQsgvR9RNJjWg6BcowjtSdOOuY5jyrXv2s0d+li7nDw==
X-Received: by 2002:a05:600c:501e:b0:418:5ed2:5aa7 with SMTP id n30-20020a05600c501e00b004185ed25aa7mr4790477wmr.14.1713279738255;
        Tue, 16 Apr 2024 08:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi2pKS93+Xt7rzUXlMXsLMRf4Zlz0vXqPpUsXZElodhI+YuY++sL82WC1J9WjtGv0jYrQpGw==
X-Received: by 2002:a05:600c:501e:b0:418:5ed2:5aa7 with SMTP id n30-20020a05600c501e00b004185ed25aa7mr4790456wmr.14.1713279737963;
        Tue, 16 Apr 2024 08:02:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:6400:7621:b88a:e99e:2fa8? (p200300cbc71864007621b88ae99e2fa8.dip0.t-ipconnect.de. [2003:cb:c718:6400:7621:b88a:e99e:2fa8])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b004182a36b185sm13074649wms.2.2024.04.16.08.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 08:02:17 -0700 (PDT)
Message-ID: <0e692fb6-023d-4d24-bdaa-99dec7569ce4@redhat.com>
Date: Tue, 16 Apr 2024 17:02:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] mm/arm64: override clear_young_dirty_ptes() batch
 helper
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240416033457.32154-1-ioworker0@gmail.com>
 <20240416033457.32154-3-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240416033457.32154-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.04.24 05:34, Lance Yang wrote:
> The per-pte get_and_clear/modify/set approach would result in
> unfolding/refolding for contpte mappings on arm64. So we need
> to override clear_young_dirty_ptes() for arm64 to avoid it.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>

I could have sworn my suggestion would have better applied to patch #1 :)

-- 
Cheers,

David / dhildenb


