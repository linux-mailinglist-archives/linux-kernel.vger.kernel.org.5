Return-Path: <linux-kernel+bounces-154835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633368AE1B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187272814B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B7E604C8;
	Tue, 23 Apr 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qme0d+1F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837545FBAA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866645; cv=none; b=n/xu7Vr0tbV8rWhXEF3TS6P1DFig5r8BPld1RxwDRTJIjc8rQSO8oZLQLG/PV2cFVUK4D2D5PMUfvqyxX5znIu3jpopSXlI5lHkTuDksIOWvMF4rZ1WU65jupHAm7kjmYPopzWedmroXGi9YYVK3Y+4E2lrovGjtWShcH08eY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866645; c=relaxed/simple;
	bh=QkvsqUOUIxDjQ4fehjx1w2ckvk/UVlRlqPUBOKypMgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8waJyuu7gYfoAAb1eU3Bg3znOC0HeqNf+B9AvLfVslaKDZ9ILXZx6g8MgcseoLGA3nn5Nkr93F20+H7GVF1V976+gZ+Qf2E/TBiVho8d8FDez7TbnP+4TVHnoM/QrgpSGFatTa8vN4PYhz5kzcAsiYrr+HC/5uLhut44cyfdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qme0d+1F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713866640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ROHAHkC9G7JwPNLv0bg25AQnmJ1DAVE/hNqmAzXfSzM=;
	b=Qme0d+1Ff8tEW7H+yuYgHnT3UWxEdBeSBrnGmxD14Dsdbn61dJxHd5jwKxhPxBJOM0Rptv
	kAikCF4+7p/vDOz4k/PLjNP3W+qa2LpUh/wGS0Z1dcx0WsFCuOkLE/2GzFCPzgOAFKInMV
	eU4jwO/wEspP4C1u+JhYmH+e+1d1H0k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-sEHHNs79NMCL6ZzfWg2eEQ-1; Tue, 23 Apr 2024 06:03:59 -0400
X-MC-Unique: sEHHNs79NMCL6ZzfWg2eEQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-349e1effeb5so2931885f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713866638; x=1714471438;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROHAHkC9G7JwPNLv0bg25AQnmJ1DAVE/hNqmAzXfSzM=;
        b=PGMWc+yTkxI5D+bNF4lpolO+GXLj3kQa9MeVUE+HzKJPXHlMKtRRiHGfmNsXFqpueT
         GGgCb6tFc7R3HBIjje+D2yNovt0AtAaAGFIhai4QMxCFvTriUTeZekkaX3YUsvdyWEmc
         sqZWFxi4imqxM2Cm4myZ53wTSxvPXAHY4Hh+CjOGZCKbL22mcCLjIc+A0qUvwB+15tQ1
         b4jN/w8LQzhy6vBJwf3GLwpL6ZDMb+Abo5nHQBxn+WcaT5l1/3Fj3NVqvQi61JSvDGn2
         vUXlgaABKbQSWO/6Hk1eqqGJpyJwSQooqRxR54w8KSezi2wkZtynP3m81OLnLxlgxIDD
         KWnw==
X-Forwarded-Encrypted: i=1; AJvYcCWOT/eWfihvWZeuAFeVShmo5MNAoJkeUSy3PBRLTJaLLboyQCHHmBHFTcVBHj07W3Sf1W+DTjXaFR8dzuDjSJMGvnauuPIcBdqzkX4P
X-Gm-Message-State: AOJu0YyZPAJAy+CH8XrIY3RChPHoBGGV3za3gAgGvMuJXHb1b6rtXfTq
	ojaYo9MxUZ6HTMMsHSbduJfPfWtjcZ0kZo1WzjId4htj9hgQ1+fJdvaEHT+LENRB4LEa/W37CwM
	1LiZSBEXq2F+JCu+41f8EdNDGUnMxRlJXfi1jc+wWo69O9fa8160EfJz8wHTtZQ==
X-Received: by 2002:a05:6000:174c:b0:347:e6d1:2fb8 with SMTP id m12-20020a056000174c00b00347e6d12fb8mr1382333wrf.34.1713866637973;
        Tue, 23 Apr 2024 03:03:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/aUN8L1+KJ5mn2QLrXc7q/M8mNESOVOZCGh5yFRpoIYd2BISgnEYa/7dz1oE9mdjQ5P5DSQ==
X-Received: by 2002:a05:6000:174c:b0:347:e6d1:2fb8 with SMTP id m12-20020a056000174c00b00347e6d12fb8mr1382316wrf.34.1713866637505;
        Tue, 23 Apr 2024 03:03:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fd00:fb07:92f8:8f0c:6a08? (p200300cbc706fd00fb0792f88f0c6a08.dip0.t-ipconnect.de. [2003:cb:c706:fd00:fb07:92f8:8f0c:6a08])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d4bc1000000b0034ae73a8b25sm6322137wrt.37.2024.04.23.03.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 03:03:57 -0700 (PDT)
Message-ID: <de45132d-501a-448f-8513-5e55c714b54c@redhat.com>
Date: Tue, 23 Apr 2024 12:03:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] virtio_balloon: separate vm events into a function
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240423034109.1552866-1-pizhenwei@bytedance.com>
 <20240423034109.1552866-2-pizhenwei@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240423034109.1552866-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.04.24 05:41, zhenwei pi wrote:
> All the VM events related statistics have dependence on
> 'CONFIG_VM_EVENT_COUNTERS', separate these events into a function to
> make code clean. Then we can remove 'CONFIG_VM_EVENT_COUNTERS' from
> 'update_balloon_stats'.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


