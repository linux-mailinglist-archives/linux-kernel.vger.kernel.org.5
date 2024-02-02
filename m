Return-Path: <linux-kernel+bounces-50018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FAC84731F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934361F24AB0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D599A145B29;
	Fri,  2 Feb 2024 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ji/VnUbL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2E145B1D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887614; cv=none; b=COdbqyLaRk2XTbD5/ObNBrXe8JyXCcGpi/G3Ih24kJPZrzSok/ICZv/EcPZaNXo2CRv1j3kiBhLH6LvGQRBViA+u9/c3jb14weL54UJomaJH9b6Y66ULbDAmiBxCLN84HULAPUhj4AVS5A+2FIMbtgq7YX4GG1AK20RU3Uukqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887614; c=relaxed/simple;
	bh=frEghVvtOcqRHxqvaJFaT8xusvbZLMxwXFTsRAh2TJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIHgspXCoA6+gO0Ck84ubK/0VuqjLJjtEDExhl2unO4hwYD8JXD/vw15MloAwOlLQEc2MK5qCUqXwQV08D+0pHKPdtW82x6IzTDoMFkunn/xbiN0BSgj98AFJ1C/genlwbA1wS22Yj2/5S2gruGUGFLaNjZROKFZRlAYTp4seQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ji/VnUbL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706887611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qxRm5m6KJDjNeDVlu/jjjkp6g7evJhqJY6iswQP8IY0=;
	b=Ji/VnUbLTPerlBWJBhBUE1uy3u3hhbcP8ZzwHyFJipDBRaoauOFSfLizNIVbaj8JuuzHC7
	QUP6G8HGr+pG9+BwjF23cCFHgARlWF+TMEugoDIc5UoTIKsJhNFImrcN38SgWjJM0SAJwe
	8m3XQ09IdaCjhY2aoBJCJri4iVieP2s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-TAEIqI03OmWGq1t4nNbxyg-1; Fri, 02 Feb 2024 10:26:50 -0500
X-MC-Unique: TAEIqI03OmWGq1t4nNbxyg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-337bf78ef28so681974f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887609; x=1707492409;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxRm5m6KJDjNeDVlu/jjjkp6g7evJhqJY6iswQP8IY0=;
        b=cUDf5ncN5Q/K2/a+lOi9/6uD5GMIcY24fW6zDebb44Kud9wMPZtcVvDN4Dlk2JXQaE
         QZLLdW+0Yim8SFkQiidHpK+aDeOofBRFUEnHXw6Fz8CD5JGWFGitNAxD233R8Tpo5MUL
         TNKsl9c8vfruXS08PKrSx+/ojPMk4XgAs8T6jCAhv8mNPLUDTHVmbptQE2RKhF7A1kNW
         YCmLXuyvzuV9swdC7VjhPaop7EEGEVfMdL0GQCERgGVF1i0IysHZZy2BBXGlsVAxRTvd
         OKDqp9Gq6sDtCekEA6evqrzRx46/taoCgjgvvYtjcBfZYoxQs4cve9HKFDPZ6UJPq/3z
         5HAw==
X-Gm-Message-State: AOJu0YzNOVkRTgGoi2Narb/ckvdX2158LgCLALc7x54lREWGlKHGlBlf
	pm6o8iToycA2T0bxU2gIakBJecgpZcMyK7KsySpLDfsHKPvn2VYGrpMEN9k0Id28cwYNj5bWMhN
	IcZ7YyPOk61iVe2wDdffPOYgJQywES4uyJ8PuYorKOXN3ieD9T8ZDQxi5Gy3xZQ==
X-Received: by 2002:adf:fd45:0:b0:33b:d78:35f4 with SMTP id h5-20020adffd45000000b0033b0d7835f4mr1807652wrs.60.1706887608935;
        Fri, 02 Feb 2024 07:26:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+Nt3k+rITHPyM7Rq6az7HHf+AUDvB2Fe2k0X+HJrdG3q7UuLDPSGYT7jqX2YU83DN3u60tw==
X-Received: by 2002:adf:fd45:0:b0:33b:d78:35f4 with SMTP id h5-20020adffd45000000b0033b0d7835f4mr1807633wrs.60.1706887608460;
        Fri, 02 Feb 2024 07:26:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXfK1MuTXHAn2gomZ94ThB8mz+ivWEY8uE8UzsJ6pvnTTMG0VwxwnLiRPseJbP+DJIXQVQDYFM2hU4YUHBXNbXPR8ayZ6TE20HIbFe4NWjMfvoDDxGllaGLKOFkW0CnZfNp7ju0guYw4Go73u+irOPjO43IyBmjvvI/vpQ1L7r9uJvEjYRiGoAV0wTG6iAnFEcwt05qcsGQ3ZE+p9du3LTBQco0Dr8+gCORdlEkjDmFLzcJzXw86ZyFOv/0rD6elT92j/Z5HrNj4P1E5aMGTRm66/jG+FcxbThQz9o=
Received: from ?IPV6:2003:cb:c710:f400:4580:64b5:8bf5:4809? (p200300cbc710f400458064b58bf54809.dip0.t-ipconnect.de. [2003:cb:c710:f400:4580:64b5:8bf5:4809])
        by smtp.gmail.com with ESMTPSA id n21-20020adf8b15000000b0033924b4d1f9sm2155636wra.94.2024.02.02.07.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 07:26:48 -0800 (PST)
Message-ID: <330729ec-cee3-4804-b8b2-eeb1548a1643@redhat.com>
Date: Fri, 2 Feb 2024 16:26:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on
 collapse
To: Lance Yang <ioworker0@gmail.com>, Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, songmuchun@bytedance.com,
 shy828301@gmail.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240201125226.28372-1-ioworker0@gmail.com>
 <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka>
 <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
 <ZbzmvwyTGeW18nJy@tiehlicka>
 <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
 <Zbz_ao0uBKabzKB1@tiehlicka>
 <CAK1f24nHmvqm1XD_UkWUB7DmNdH0NEOKzpLgKDJ=UuPWO=rEHw@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24nHmvqm1XD_UkWUB7DmNdH0NEOKzpLgKDJ=UuPWO=rEHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.02.24 15:52, Lance Yang wrote:
> How about blocking khugepaged from
> collapsing lazyfree pages? This way,
> is it not better to keep the semantics
> of MADV_FREE?
> 
> What do you think?

Why do we even want to change any behavior here? A lot of things "might 
cause confusion among users". Even worse, a lot of things do cause 
confusion ;)

-- 
Cheers,

David / dhildenb


