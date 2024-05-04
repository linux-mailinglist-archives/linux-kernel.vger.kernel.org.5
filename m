Return-Path: <linux-kernel+bounces-168518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DF78BB97F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 06:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D2FB22052
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009254A18;
	Sat,  4 May 2024 04:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msK0SZct"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC2368
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714798041; cv=none; b=MEB7+v1N8VmYX9u68bzC2Vhyq95ccwva//5lUWtcO7DYY/m5AqYYuMq2YuDIGN/fO8cL38rzVk4E9zjjM/cyvfIRN5NTUbxqlXprPzVMhmBapjLg+ZLP5dkEsuSfkP9frLyOo7srwhKxarXo26oGLm1Il4hJ+HbDd8VBw1FdOtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714798041; c=relaxed/simple;
	bh=ogyv2I8i/GbJScBtLB+NEg+dy79yutIqsK7sVGv5AVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHdHfAYHq4xpo+2GTTDbigWgADjl62PBAwK8MML89LW0GimsYQwLi6lgrjn+w6rVfAhd1MoPEztpGp+8XNFjimSvNZAe8QCvvB63d8v9RXfOAvpRt6bAG3BSeem3dMJIvsdz+FFxWDUYCYFdsi9OLwhdINQcaWM/P+UzzerELFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msK0SZct; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de60380c04aso406681276.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 21:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714798039; x=1715402839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDUY0pEyHcwLGLCcYTguMfsPJMq4nVW4kSPub1k/aNI=;
        b=msK0SZctZ5xQ3r9DW1gWPzmCPZFpIBEkjvHIdip1grNZkniQO/YESDp6vLu18aeJCy
         ZteI4jZNMcfOu0+fFqFl3H+nUd82zZGF2NKUC+mxxC3M9s5M+h/PZGaKXG/iZHNQ2LNo
         Uzg7d/l1qK8mvcY2Wsqj5hPOIL6YUGU2D5O3ahnE1EwjG1JwWQ8uAfcTWolpIdzq8uX+
         l1hWYMzSwO9cex5CmC+eaQW9wJK2fqoIkIVp/c2jvWFxqtB9vAKrz7yCQCC1M/du+gbS
         a/VqQgDVRg+pgz18WJieUwuEPuz4F2tF5gDmQaWkAXs+sz1nSguagt0etzSkao22FPed
         vYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714798039; x=1715402839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDUY0pEyHcwLGLCcYTguMfsPJMq4nVW4kSPub1k/aNI=;
        b=t3doUCI+f4KFVZq36mFGlZH4XDMKwoXAMk0lNlCKn+9e3EWf/EU+nfdxkuWM2DTttv
         JbxV/cebUat5WWw7ANUeEs0Z0XdPu2tLpyl3/ZngNi9OfuuTZ5YpWTsAFyHtMTqoaV/E
         Yp/h7OXcVfIYl6LRUFfEMvICK93VDZXddNDRxpmMk37YcPHp//4HmfqdqF8i2r7K5UEp
         ZttmujhzKNMiqlnnDC96lSjQudb9fbh+CgxECn4QEuVKSN/Gri+KtE5gX5EBNMt3F6Xr
         lvZOXLiG8xDmw12yjXLzCL1gz62IsC9njhM3vmEH7mikvTlrwSCDq8Z2J7+qaZx1THqf
         IcpA==
X-Forwarded-Encrypted: i=1; AJvYcCW78DuDs3oshB5b9wYw8oCXZPIkqOy+6KK7P0R3ezl7M8s9Xy62jNZqCQKwsgH5kJ4YMBMQfYZeBjIOXFGFwk0NCIzrwQUvnLi5xERs
X-Gm-Message-State: AOJu0Ywi7IuyIVaPEsu3OmSw4JF1ZtEmtcMp2FFP3WjrfgOG9c719Gje
	vOhEhlhIzQvB8v57qtdB1O08afKHK6oXfJaMfKOy6A+ZMHlFhmxmCp/wr6gOeIesIGQznoaYAp3
	UNWw0O+CorNr33mQvkCX880x5Zl8=
X-Google-Smtp-Source: AGHT+IEyCObDSnKTFetVhKZvIIIM96ux29apOjfs1Jgpir5tJ0Jqi/UV7RbAAlROLZzxT63wEHzGGVUzzDrlIbZ5rZE=
X-Received: by 2002:a05:6902:e05:b0:de4:613c:a63 with SMTP id
 df5-20020a0569020e0500b00de4613c0a63mr5724837ybb.53.1714798038908; Fri, 03
 May 2024 21:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-3-21cnbao@gmail.com>
 <e0c1cbb2-da06-4658-a23a-962496e83557@arm.com> <CANeU7QkYXmpmTAVjGqin4Wpg9hydPPYZKho-MwQMMt9uJ8Lu4Q@mail.gmail.com>
 <ZjWzoGg3MRs0yiBR@infradead.org> <CAGsJ_4xdgD8grbW98Gfoc7X-fAVYzFtobczNCWApw-oPhj9dwg@mail.gmail.com>
 <ZjW5h_Ic3k9IlGtV@infradead.org>
In-Reply-To: <ZjW5h_Ic3k9IlGtV@infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 4 May 2024 12:47:06 +0800
Message-ID: <CAGsJ_4wfeaVeaFXAKz-7U-=ESf2uh9Ow=VDGdRXqnypHhLDJfw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mm: remove swap_free() and always use swap_free_nr()
To: Christoph Hellwig <hch@infradead.org>
Cc: Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	ziy@nvidia.com, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 12:29=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Sat, May 04, 2024 at 12:27:11PM +0800, Barry Song wrote:
> > swap_free_nr() isn't separate, after this patch, it is the only one lef=
t.
> > there won't be swap_free() any more. it seems you want to directly
> > "rename" it to swap_free()?
>
> Yes.  Avoid the pointless suffix if it is the only variant.

well. it seems you are right. We usually use a suffix to differentiate
two or more cases, but now, there is only one case left, the suffix
seems no longer useful.

one more problem is that free_swap_and_cache_nr() and
swap_free_nr() are not quite aligned.

extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);

static inline void free_swap_and_cache(swp_entry_t entry)
{
           free_swap_and_cache_nr(entry, 1);
}

The problem space is the same. I feel like in that case, we can also drop
free_swap_and_cache_nr() and simply add the nr parameter?

