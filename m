Return-Path: <linux-kernel+bounces-148197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CD78A7EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC571F26587
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3251292F2;
	Wed, 17 Apr 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLrHvtZJ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41937E572
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344493; cv=none; b=kQflJpMOWzhG3rn7fSUZ2uGcpW6ieZooVCcIkZL6UJ1ipJQ+1Rn4xb6D5hYutRTXN6meInczddLewSTLFEBx4X3z+4//M4KuykfsnQIz6gkVP3hZFgevFfBHvCdDGBezCBKDJ8gnIk8pTA5/5z52ypkAraNeKVq/c2eblQqvMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344493; c=relaxed/simple;
	bh=yBuw1CTzxTdo9os+sgXjpeYRcWGrtFbwBzfIdKhm0bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQ7o1Qce1w2NrtS18TE9Y4776XY2P7mgg4hRq2MmpcAbJHR66YjZvGYU6JS0c1lUGzEKLQdJ7UdQ0zDpkKuR6C4Y/YPU8NhW40FJyh55KhufaBcDaNGZlDnxn1YGSmz+eJGq+oIzcVb5R3NsRpVefqU2KaylpGJnEHU7YEbQqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLrHvtZJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5708d8a773aso203317a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713344490; x=1713949290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IQPpzwWcfVU7n9t+qjpbVgRash+OxFdYmO+ZwvUXnE=;
        b=KLrHvtZJXD2ryFb9SBN8kqeq6hiQnsjFZM78SLWVUSvzjBQRJGsUUhSYtbItNeG/My
         NTAdDVSONy3XU4wa/ZxpHNM7puvvUK2az4bI34BUCC9EZ5VPLptg4Q641UATYTVtc+n7
         8+x0X2A522aEeToC0KkFQU/o11cNw5PG1iM+OP5IMePycWGWn9Kb+0J4S+kVzqsOi5ig
         /UoJgYMZ2CoycdZJTg2PNQyw5ukcNKPAV0A6Sbr7cfQY+AkJQvv+ZfTiAgfS23mRssHA
         TeHXvaHee4fpXq4lS2S/walgMR8G9BY3TQTq2Ieg2hF4mZ6nmF1G8HfkYBqR4I+uBUSx
         o2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344490; x=1713949290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IQPpzwWcfVU7n9t+qjpbVgRash+OxFdYmO+ZwvUXnE=;
        b=kRALJOGWAQJ31h7Cwr+wjdtww8uQxZ+enp/ArD1PI+3PVDaEWewFEa3oFx/+Bx7FUP
         SGX4PWqzHsz+BRhu8PLTqzotFVaZ/6As+WpWAWClsBID91xuM5hqKyszs8kh7h8oL7HG
         9CzDaVArqGG344O+Gw7fuaT+wrsatpcJwQUOhxglRk8ihqmhxN5suqa0mWPu1V8lYZTu
         JuCxk7CoDmA+Wz121fvlfwDMk9NLB1jd1hKZgkQVwttXJpCUit1M1ljAJ8vTi94AdSWg
         Fd4hvj1kbweEWTiPd85hyvcKGMOa2jAheQ38pKRzTFVzsZvNtcD0BTbpLziJdfKz6dXt
         5mtw==
X-Forwarded-Encrypted: i=1; AJvYcCVMh6xcjMOlrwRO9MnP6xlwWKJju6zwrgV+Uy2Ag8d54rQ0u5wB6qOpMppwKYlXOa7+K5N0W1oxw3Hvzi3Qk3kCk9xYkKZY67hYZRhp
X-Gm-Message-State: AOJu0YxUdB2/oXdXY71ycbV8KXL0tgtUSOzXQCtm9XREsrcrAz7mdc0c
	M3mbCKG/wIlv0CW0B+7KWtPJfUdiCeIPi2b3SjgrNFJmw3XS1a0OFMbISCXH5OcaegJIysJtXUg
	9c+ticXN9kOMzn41h1HfvF3Omz1s=
X-Google-Smtp-Source: AGHT+IGXg0YVptrsLyFBykOpuIjh8UGp+Bh7094A1mQjXyrv8LDWn99rHXcHRn0HHvhLAW5O8SqjsJcGUb1GCKM+ENw=
X-Received: by 2002:a50:aa9c:0:b0:56e:2ff3:bb89 with SMTP id
 q28-20020a50aa9c000000b0056e2ff3bb89mr9695343edc.28.1713344490228; Wed, 17
 Apr 2024 02:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK1f24mEoC_Pg7-49G=y7dMUaGhzW11_A5sK0EWVhH6K1kjMMA@mail.gmail.com>
 <20240417050426.66194-1-ioworker0@gmail.com> <76d22c08-82db-4ea8-a7cd-c77589e132e3@redhat.com>
In-Reply-To: <76d22c08-82db-4ea8-a7cd-c77589e132e3@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 17 Apr 2024 17:01:18 +0800
Message-ID: <CAK1f24mFfwXky9Patwmcq-VQ8y1hxcRm8K4B4o0RO+dsr-7Q=A@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] mm/madvise: introduce clear_young_dirty_ptes()
 batch helper
To: David Hildenbrand <david@redhat.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, fengwei.yin@intel.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	minchan@kernel.org, peterx@redhat.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com, 
	xiehuan09@gmail.com, zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 4:19=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 17.04.24 07:04, Lance Yang wrote:
> > Hey David, Ryan,
> >
> > How about this change?
> >
> > static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
> >                                         unsigned long addr, pte_t *ptep=
,
> >                                         unsigned int nr, cydp_t flags)
> > {
> >       if (flags =3D=3D CYDP_CLEAR_YOUNG) {
> >               for (;;) {
> >                       ptep_test_and_clear_young(vma, addr, ptep);
> >                       if (--nr =3D=3D 0)
> >                               break;
> >                       ptep++;
> >                       addr +=3D PAGE_SIZE;
> >               }
> >               return;
> >       }
> >
> >       pte_t pte;
> >
> >       for (;;) {
> >               pte =3D ptep_get_and_clear(vma->vm_mm, addr, ptep);
> >
> >               if (flags & CYDP_CLEAR_YOUNG)
> >                       pte =3D pte_mkold(pte);
> >               if (flags & CYDP_CLEAR_DIRTY)
> >                       pte =3D pte_mkclean(pte);
> >
> >               if (--nr =3D=3D 0)
> >                       break;
> >               ptep++;
> >               addr +=3D PAGE_SIZE;
> >       }
> > }
>
> Likely it might be best to just KIS for now and leave it as is. The
> compiler should optimize out based on flags already, that's what I ignore=
d.

Got it. Let's keep it as is for now :)

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

