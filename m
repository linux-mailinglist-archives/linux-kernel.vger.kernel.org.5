Return-Path: <linux-kernel+bounces-149412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2D48A90CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F5B283888
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05725757;
	Thu, 18 Apr 2024 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mgt2iQSu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2883BBEC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404417; cv=none; b=qJ+UfSDFAyVZBBf62zV6Tc/6vAuTu7n2vvdq6DzLASxJJ8KyMDgEweGyqNAdVhRG66FWomwT+OkRyr38qik03DUrOBp6ia2Ws+S/KpRB8ezmsPUCoWqA9Z2JHZ0qvdDG+jKHcrZi5Vp9kCRs7Ome27tD2bi/Zc4QXh/UH3aKr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404417; c=relaxed/simple;
	bh=e3bCTdtHrF2UnBnEbVCk1MkmyVmZb9X8WMo8KFpypjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUnr+PI19ypTVV1wT94dm7xl0KbadtZI9+JGGvHN1MH4lVc9y7WuuV0yG4zqU0X+tUwdrGURO/1CY0g/CMdUx5J5cYDMe2UZv7Wmc+Rc3BIawZAOlHxQ/ClulwwH9FOzlYcI7DpQoqYf8Lg1prEG9jroRIh34ajuiZCk900R5us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mgt2iQSu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713404414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVgKAS9nz/LG4ge1C9xAdcQzyy8X8VEwsLz7Mq7LgFw=;
	b=Mgt2iQSuFwm+ip7wsMoAXotGtV2PaUbnNw3CqrgYX3V0iMsFA7cxNGXPpzchfzVu7GSMTA
	TaWiym1TTVRAwOPySzLWkPtEEhwTQSxDBv+3ZiJaPDH/4daiMG0K1NfGXxi7uOktMZOOLw
	5NVfjNb0Tpn4SyWgJFtAPSZbR1XR+7w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-kfbkFV6UMVerNtS2MSZ32g-1; Wed, 17 Apr 2024 21:40:13 -0400
X-MC-Unique: kfbkFV6UMVerNtS2MSZ32g-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e2a553aad6so4124615ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713404412; x=1714009212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVgKAS9nz/LG4ge1C9xAdcQzyy8X8VEwsLz7Mq7LgFw=;
        b=WQ5957R9YLrzUj1XV6XBsMqmOc3+1pflkYYq3EHVzTwqIQnxsgRerYB7B0pIUuexv8
         jEe8/VRLuv2U3kzXLuf6ZQeJu93w5a/qtdfyiNCoNBOLMn/aRrE0ABKXZVvnXfc2ELUO
         pl65Ga7w9+bdWyoeVYarGE0RCx/d2+PjKYDi6XbcijgD95CXws2vHNS17mrIf2dPUHN2
         31Iybn2xHOP7LO2aAfKwtbt3SDAPOh+CVTUcVjPa7MoUe7lssQK4HrLQ0fv2qz7kNIZV
         H0gbEf1mOoN0t9384qUKMnc+FMmgE/lIfXQ2yFr/UMuObK0RSklsYllt/m/W5McVmaqJ
         ZzOg==
X-Forwarded-Encrypted: i=1; AJvYcCXM1Y/eQ15MadpnPOgmmfLtMv0r9sd1bxtsH2OoqhuONdZK/w1989xpnYHYi8zkfVyII6N+gBrhKPYOYrJvcS3miyW73KN7dS5oaV6+
X-Gm-Message-State: AOJu0Yz4akKAhkmTnYFTt/tKsbCZOVV4+4Z+WNiGVJjJ8qXjKW/KX/zu
	U5e4tcZArXgiTvWB4MU/CMngT2NM75LjWxMbIaQH7uoazvTMdzD4a5xmjpqEBtrYz3tH15nOWzj
	oQedG6ZqOCwNu9jWH+xs/PhU1Uqq6vWWL3qOhZRg3f4JLNrHWjXKb4Jlxn/cFfw==
X-Received: by 2002:a17:903:228b:b0:1e4:55d8:dfae with SMTP id b11-20020a170903228b00b001e455d8dfaemr1685029plh.4.1713404412271;
        Wed, 17 Apr 2024 18:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6VvtdAGo5TIQeytuXP1dbMJEhF6NhbLbnVJumMJQ8ijnoQzNd5M6jQzcmCzrBaveFaQNpmw==
X-Received: by 2002:a17:903:228b:b0:1e4:55d8:dfae with SMTP id b11-20020a170903228b00b001e455d8dfaemr1685010plh.4.1713404411924;
        Wed, 17 Apr 2024 18:40:11 -0700 (PDT)
Received: from [10.72.116.40] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902b21400b001e3e081dea1sm314514plr.0.2024.04.17.18.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 18:40:11 -0700 (PDT)
Message-ID: <e5b9172c-3123-4926-bd1d-1c1c93f610bb@redhat.com>
Date: Thu, 18 Apr 2024 09:40:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] ceph: drop usage of page_index
To: Matthew Wilcox <willy@infradead.org>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
 <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
 Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
References: <20240417160842.76665-1-ryncsn@gmail.com>
 <20240417160842.76665-5-ryncsn@gmail.com>
 <fc89e5b9-cfc4-4303-b3ff-81f00a891488@redhat.com>
 <ZiB3rp6m4oWCdszj@casper.infradead.org>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <ZiB3rp6m4oWCdszj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/18/24 09:30, Matthew Wilcox wrote:
> On Thu, Apr 18, 2024 at 08:28:22AM +0800, Xiubo Li wrote:
>> Thanks for you patch and will it be doable to switch to folio_index()
>> instead ?
> No.  Just use folio->index.  You only need folio_index() if the folio
> might belong to the swapcache instead of a file.
>
Hmm, Okay.

Thanks

- Xiubo


