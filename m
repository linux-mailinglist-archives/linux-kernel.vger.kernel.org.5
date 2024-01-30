Return-Path: <linux-kernel+bounces-43907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DFC841AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC30287ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDDC37157;
	Tue, 30 Jan 2024 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LJCgy2aD"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D7936133
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585947; cv=none; b=kHIxMTwoNsJuGR0jMpd7ov/lDMn8LJieLdLb8cxRBj3GjlMfRDKK9PH8TLhKD5zk/TOcxtwuhVL8viCUsoBgy+2wGwBNa8i8cu06cJijp3PrvS3kEU/MxDay/FBUMzgfnXCYmFot8XruCXxiRzHYUba6OxWfUFkWShxUFsN3Kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585947; c=relaxed/simple;
	bh=hAWYNp9wL92jPFJAU7tP7WntW2M6It1Mkm3fwcNDzio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gi6zDUyHawwh7vKp+0S3jj0LPQKjQcUqKkB/lkDU3/LmBb2pA4lyFVCp3bwY29Z71cbohsCXtBgNMJynorC/IjiFBiJSRIeAZTRzFt7KVLBEV5GrHYRSidQaJSClAH2CC5goagQlIOxmvki/T4skC8BTSSkYhUQpk/AYNwjz+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LJCgy2aD; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59a1a03d067so808157eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706585945; x=1707190745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00lo/QjQQeVff3/KwlNH4541JlMutDM7rW2whSJGlac=;
        b=LJCgy2aDLmhch91z7PV/97VARPrDu1pLCZ7TkZaplUidG06volmOEvA8dEHr6k6fZl
         M671vTsSmBRqUrv5RDpMdd21C0LDvNpWsOFIuCYkE/8MM98QROioKYqofIp+JY/orZFR
         uO0cTsXkXNaGm7RGYl2q4QWWvlzcP6xhe+t7NZQUaZFAvEGoA7wJDLAEeRc9RZCnQoJ0
         5fyq9OIN51D04MjINOfQhri2EzwxiXrpiwarnHXdWGRVPmleR1VLx7CDlGyv0dJNLrwp
         DjT9Rc6p9WRMCGosYBcucyZnDYewJOs3qilSjpPP8PBcZ+edXCArro0va0PReN9fg/s/
         RI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706585945; x=1707190745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00lo/QjQQeVff3/KwlNH4541JlMutDM7rW2whSJGlac=;
        b=b8ZRjTMfPiP3zezHnOV+j3RcG7urXPQg3xkMZd+23wy1mGxjz/GGrPtwzMqJSadMYE
         bh66JdvdqxiMa+SFe/oUsLXNHZNZtQYa7+SkF8lr+ibndeNCSFxouZ2JtcD1UDHR/brs
         LVnr4LQ8qdm3ImazYUmktiHQoHOb3jqD4UsKkH3CEyrcgFD2Vz9uQVVKAf9TarlTOz1Q
         Tud4VPFoy5rDpHDvebUgIWtz1g1YXwAvMNz867odLDAXwTeDIZs8zSzYbSUW7QTAUlt9
         NsEvuX9MpVaHl1GL+011ZP/sjAVPY3eN+MgXaslwiGnRluH5lHXbWJr12NVHKl7o21sG
         LyHA==
X-Gm-Message-State: AOJu0Yy+9uEzmh4o3BtX1OqW8X114LopqtEgKk66OJZr25GP7cpZ9yYh
	cWngwXIBesTcOesg0bCc1hQ3p3NSZGQxqHBSBJwMxzbJ7MIYCalmWJposXFarzC08ZV57DuVXpH
	I
X-Google-Smtp-Source: AGHT+IEay3Qyiuk94oPutgEb+dSLkLHlgffqFbi5L8ehUfVRL9zNUJteBJfej28RaJHDEwC19jQXYw==
X-Received: by 2002:a05:6358:4411:b0:176:92d1:568f with SMTP id z17-20020a056358441100b0017692d1568fmr4719844rwc.18.1706585945382;
        Mon, 29 Jan 2024 19:39:05 -0800 (PST)
Received: from [10.4.207.234] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y17-20020a63b511000000b005d8b481c4d3sm5561909pge.87.2024.01.29.19.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 19:39:05 -0800 (PST)
Message-ID: <f14b7f55-3e02-461d-94eb-a89980161ee7@bytedance.com>
Date: Tue, 30 Jan 2024 11:39:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH 04/20] mm: zswap: warn when referencing a dead
 entry
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240130014208.565554-1-hannes@cmpxchg.org>
 <20240130014208.565554-5-hannes@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240130014208.565554-5-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/30 09:36, Johannes Weiner wrote:
> Put a standard sanity check on zswap_entry_get() for UAF scenario.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/zswap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 9f05282efe3c..0c6adaf2fdb6 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -542,6 +542,7 @@ static void zswap_entry_free(struct zswap_entry *entry)
>  /* caller must hold the tree lock */
>  static void zswap_entry_get(struct zswap_entry *entry)
>  {
> +	WARN_ON_ONCE(!entry->refcount);
>  	entry->refcount++;
>  }
>  

