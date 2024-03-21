Return-Path: <linux-kernel+bounces-110005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD90D8858CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C101F21290
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31251768FB;
	Thu, 21 Mar 2024 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Of4woWHx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B5768F3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022787; cv=none; b=pm1rJIt0GFdJtZiZNHcTsss4PennvjXKvbEeNWJOGwGFqiLd2wCEbuR3Iw81oBXMqlhFflw8EB5ytJgNyQld2tl4wiK5/BhrB8ruP38gL+T4TAvAg3Ivp7XN2zS1dWcp44fq9OAL/uZbofR1CP0D6YsyrDw4foaV+aACzN3Njmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022787; c=relaxed/simple;
	bh=k3CJSaMRAsHvZqgMfwvwOFoj47VDXS22sIOAMkNiMLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwQkzJ+ywIQZ38BHh+ipf70xousAxrb7GpZQUGQ24IvgVJMrl4gq+XUzZsUQEtf9vxWAl1Wjgjfnd4NzND0GsPCMh/poI1Npvv3U+kK+7cU0EtmroX+9qGIg/UHmE9cGm2e8PVgwxiCuUWFwp2D+Eu38TmbDcgzAQrnpTrkbdMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Of4woWHx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711022784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaftwFTntyTyuVDa9i6qNAWKdEHOXUZrSNQMfaI1f0M=;
	b=Of4woWHxFKyvvfzRQv/NnoYoeGzZO5GGRXhObwWmvralrSwzKNtwMZKiyUtDoKg91OUowe
	iu5+KgtlqTTUHK4bfLzLQuS26qw4Fx0ycnhzcAAzXm3ewWwgm8K116vQSQ3OiU3TgAw7XW
	ig6/erIHx0+Oq23B445XQ31qM6mQk/Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-BrqeK4P_Ma6YMp9NcjlbVQ-1; Thu, 21 Mar 2024 08:06:23 -0400
X-MC-Unique: BrqeK4P_Ma6YMp9NcjlbVQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e027e54554so9148835ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711022782; x=1711627582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaftwFTntyTyuVDa9i6qNAWKdEHOXUZrSNQMfaI1f0M=;
        b=MxP0oq3ZpENoqo3kZh7tJ+HRXiDicR+KdmMR/ywTXYY7B5zgHpuluA+LNIPVvrbsg0
         ZUr8+/B0TQRZtGBeqYaui4i9W3+zvBPQnz0wdlllpDil9348wIKz+Eyl2DdNURfs2Reu
         ngYts9zMJV3bKKVHK6G8VO9k07c6OMBjTPztRW1FOT5IB+sYL++k7y56fxdsjkL5FrXY
         fKq45HEZrqoqmqp8xqmNX7J+PruLrAMx0vqxHEJujysoGP1d4BSZ7rc1HQGe6+h+lBHr
         0Z0c+avlwJI4oq8S7RD7MfOXdp89H9Z8XXZOhT9UjxU03BZlkAeOYKpqV5IKcvMnb75a
         Jj5A==
X-Forwarded-Encrypted: i=1; AJvYcCVEoPn18D+LaXveE7D0f7fUNeptevTJ8YBe/TuRPY/hyhGfQswYQTC715eahJeSq6QM8AugJWmdpjku1qk5JD/cR7+UwNhLkw6ihRis
X-Gm-Message-State: AOJu0YxPC6JKcU8gHVASWF308+ID582p6yn+keC6J0xNKqcscWTTJtSJ
	6w+4H10n7seI/PQO5FKKEq8OXBoFFWgCP8TBJa3Rhsw3wWDS3Dn66pXYYbb1W0TuvW6j8EZeNKT
	B+EfalFToMNp+Fq9gCGq85hat+fh+2lKGgoFcEvNeDww2vFA5Mu2HLJb7auY3GA==
X-Received: by 2002:a17:902:d549:b0:1dd:93f3:d575 with SMTP id z9-20020a170902d54900b001dd93f3d575mr5914492plf.30.1711022782361;
        Thu, 21 Mar 2024 05:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECnTXS5JWKv1pXKbA06u3gvbc+DZ5MivOM5zLUIw9sRi+g/m+s1qUdZJQCXBTcImopf4ZsuA==
X-Received: by 2002:a17:902:d549:b0:1dd:93f3:d575 with SMTP id z9-20020a170902d54900b001dd93f3d575mr5914451plf.30.1711022781958;
        Thu, 21 Mar 2024 05:06:21 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id j11-20020a17090276cb00b001dd88a5dc47sm5893220plt.290.2024.03.21.05.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 05:06:21 -0700 (PDT)
Message-ID: <fa91d7bc-f4e5-4a1b-b35a-8e0ccfe1af2b@redhat.com>
Date: Thu, 21 Mar 2024 22:06:15 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Content-Language: en-US
To: Keir Fraser <keirf@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will@kernel.org>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
 shan.gavin@gmail.com, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <ZfsZljA_mmHKkBsA@google.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ZfsZljA_mmHKkBsA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 03:15, Keir Fraser wrote:
> On Wed, Mar 20, 2024 at 03:24:16PM +1000, Gavin Shan wrote:
>>
>> Before this patch was posted, I had debugging code to record last 16 transactions
>> to the available and used queue from guest and host side. It did reveal the wrong
>> head was fetched from the available queue.
>>
>> [   11.785745] ================ virtqueue_get_buf_ctx_split ================
>> [   11.786238] virtio_net virtio0: output.0:id 74 is not a head!
>> [   11.786655] head to be released: 036 077
>> [   11.786952]
>> [   11.786952] avail_idx:
>> [   11.787234] 000  63985  <--
>> [   11.787237] 001  63986
>> [   11.787444] 002  63987
>> [   11.787632] 003  63988
>> [   11.787821] 004  63989
>> [   11.788006] 005  63990
>> [   11.788194] 006  63991
>> [   11.788381] 007  63992
>> [   11.788567] 008  63993
>> [   11.788772] 009  63994
>> [   11.788957] 010  63995
>> [   11.789141] 011  63996
>> [   11.789327] 012  63997
>> [   11.789515] 013  63998
>> [   11.789701] 014  63999
>> [   11.789886] 015  64000
> 
> Does the error always occur at such a round idx value?
> 
> Here, 64000 == 0xFA00. Maybe coincidence but it's improbable enough to be interesting.
> 
> This debug code seems rather useful!
> 

Keir, Nope, it's just coincidence. We don't have such kind of pattern.

Thanks,
Gavin

> 
> 
>> [   11.790068]
>> [   11.790068] avail_head:
>> [   11.790529] 000  075  <--
>> [   11.790718] 001  036
>> [   11.790890] 002  077
>> [   11.791061] 003  129
>> [   11.791231] 004  072
>> [   11.791400] 005  130
>> [   11.791574] 006  015
>> [   11.791748] 007  074
>> [   11.791918] 008  130
>> [   11.792094] 009  130
>> [   11.792263] 010  074
>> [   11.792437] 011  015
>> [   11.792617] 012  072
>> [   11.792788] 013  129
>> [   11.792961] 014  077    // The last two heads from guest to host: 077, 036
>> [   11.793134] 015  036
>>
>> [root@nvidia-grace-hopper-05 qemu.main]# cat /proc/vhost
>>
>> avail_idx
>> 000  63998
>> 001  64000
>> 002  63954  <---
>> 003  63955
>> 004  63956
>> 005  63974
>> 006  63981
>> 007  63984
>> 008  63986
>> 009  63987
>> 010  63988
>> 011  63989
>> 012  63992
>> 013  63993
>> 014  63995
>> 015  63997
>>
>> avail_head
>> 000  074
>> 001  015
>> 002  072
>> 003  129
>> 004  074            // The last two heads seen by vhost is: 074, 036
>> 005  036
>> 006  075  <---
>> 007  036
>> 008  077
>> 009  129
>> 010  072
>> 011  130
>> 012  015
>> 013  074
>> 014  130
>> 015  130
>>
>> used_idx
>> 000  64000
>> 001  63882  <---
>> 002  63889
>> 003  63891
>> 004  63898
>> 005  63936
>> 006  63942
>> 007  63946
>> 008  63949
>> 009  63953
>> 010  63957
>> 011  63981
>> 012  63990
>> 013  63992
>> 014  63993
>> 015  63999
>>
>> used_head
>> 000  072
>> 001  129
>> 002  074          // The last two heads published to guest is: 074, 036
>> 003  036
>> 004  075  <---
>> 005  036
>> 006  077
>> 007  129
>> 008  072
>> 009  130
>> 010  015
>> 011  074
>> 012  130
>> 013  130
>> 014  074
>> 015  015
>>
>> Thanks,
>> Gavin
>>
>>
>>
>>
> 


