Return-Path: <linux-kernel+bounces-49968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D35A847239
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819A11C21A86
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929FA13E200;
	Fri,  2 Feb 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcPGU/cl"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B0B2B9A1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885586; cv=none; b=amTkBFNWMmhD9kMrAXBoGAfdnzV2F7xMqQ2Z1+ksVylEvCUSquyyx9XARzbWdv/3wBcc9Ppk4ArwZefdho2Ag+ikZvF0ijKYhjaso4AvOs5rpQTKwp/ZhU0s/CeEJ3hysPo1rgu3yRp0djeuFKYnd4UKH0yAnXu9HQpDxE0z86s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885586; c=relaxed/simple;
	bh=p7uCEIue/vRXtk5xoPvtw6k0UBZtBQleKzh1H1rbml0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtsFkVbudzgp0VbhBmmctO2N0jJ6AgtNfXC5dZEaxHhgAdnFZgrpOXHwIDoOmIPKT8/VZqeH/u0f69019GI4cH/IEO+ujPBCu532BLQM6BLNg6eumqkjpaBtOSQ6jO5nla2e1C9pU+nlJoj3TVo96WFgyQeLjsMugSuQSkiSHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcPGU/cl; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6dcd91364so1592659276.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 06:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706885584; x=1707490384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7uCEIue/vRXtk5xoPvtw6k0UBZtBQleKzh1H1rbml0=;
        b=NcPGU/cl2diu7eqMQOOaGr2spdcVeDZ2ATRY5q9QZwWR0Kr8iiEYBk+v279qUgy747
         /4FOtLQm8yCj1EWk9BEIi72AOTYW9LyejHAFwWY7Vb+DI83vAHLHVKtbn9Xhbse8Ftue
         42Li8AAu7muVerX32H3fd8K2dHMpqPkG8UaWtleOH/Kb3VxTMHF2dA4aiRa630kL3WL8
         G1b1/eE9UQH488Cgtx8zh/E9qZwU6hKno+LL70jEAsAQL26GWAjmX0vxYFmhXiWbaHHH
         il8qI2JCJhBcwb4WpGAckcBLpSQ9Q/AzDjzEakfJK3rKPaXoCjSZhIwiziDTLeL8GAVs
         cncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885584; x=1707490384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7uCEIue/vRXtk5xoPvtw6k0UBZtBQleKzh1H1rbml0=;
        b=RbRLHPq53vZfKKPHxfR5lNo4E2k2idlOB57hwHzsbokLzQpVPCfa3z7tIwqNIJyvzP
         XrNBHG6vmgKF2dLUc04ctvYiBkqNN3NJrCAgG8oQjSnhQNXvIeF5pKhU/N3J4iZNAmxz
         TOJh+0RZOW5Gn/ik0VxmZoEkyKlNWFuQepfWDETVzWuAOwIjF6SSwt5XBOrx5sz8i6u4
         Weq4Z3P08VarJrJwtYqS9e7HE5ixHfrBo8xyoHi3i9uX0tsb4kTNFfb1cV7/rwM8Q4lt
         7ZBzck8MWEs37BFYvVh4AEAW8fdGrShp/PcCpWDzQ3jAUmhyroCW3yKTQlzk4kYLLEes
         3Jgg==
X-Gm-Message-State: AOJu0YzEj5KexRVu290hOvBZtxmvVLLiu3UcQ4f/7HwqCOWLKmfBlsil
	7+QZACys3hjgIdL406H2oY8V7m0Qzscclbfpr/Le1VwERt0nFMjR95TsPCzVcpUEUuQrTRlcUXR
	n2NG4IV4j7Sw/ZhEmbpBUhc6OX9c=
X-Google-Smtp-Source: AGHT+IGxRWU1t838GRLlDK4UGgYqjiicH6Z9Fpk+v5YhZjb/sQilVodpYHxZGTSvCWxUyGMDLU9A+g8HXqpK6cR5TOI=
X-Received: by 2002:a25:2f56:0:b0:dc6:9ea:3d5d with SMTP id
 v83-20020a252f56000000b00dc609ea3d5dmr8113368ybv.34.1706885584427; Fri, 02
 Feb 2024 06:53:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com> <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka> <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
 <ZbzmvwyTGeW18nJy@tiehlicka> <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
 <Zbz_ao0uBKabzKB1@tiehlicka>
In-Reply-To: <Zbz_ao0uBKabzKB1@tiehlicka>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 2 Feb 2024 22:52:49 +0800
Message-ID: <CAK1f24nHmvqm1XD_UkWUB7DmNdH0NEOKzpLgKDJ=UuPWO=rEHw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How about blocking khugepaged from
collapsing lazyfree pages? This way,
is it not better to keep the semantics
of MADV_FREE?

What do you think?

Thanks,
Lance

On Fri, Feb 2, 2024 at 10:42=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Fri 02-02-24 21:46:45, Lance Yang wrote:
> > Here is a part from the man page explaining
> > the MADV_FREE semantics:
> >
> > The kernel can thus free thesepages, but the
> > freeing could be delayed until memory pressure
> > occurs. For each of the pages that has been
> > marked to be freed but has not yet been freed,
> > the free operation will be canceled if the caller
> > writes into the page. If there is no subsequent
> > write, the kernel can free the pages at any time.
> >
> > IIUC, if there is no subsequent write, lazyfree
> > pages will eventually be reclaimed.
>
> If there is no memory pressure then this might not
> ever happen. User cannot make any assumption about
> their content once madvise call has been done. The
> content has to be considered lost. Sure the userspace
> might have means to tell those pages from zero pages
> and recheck after the write but that is about it.
>
> > khugepaged
> > treats lazyfree pages the same as pte_none,
> > avoiding copying them to the new huge page
> > during collapse. It seems that lazyfree pages
> > are reclaimed before khugepaged collapses them.
> > This aligns with user expectations.
> >
> > However, IMO, if the content of MADV_FREE pages
> > remains valid during collapse, then khugepaged
> > treating lazyfree pages the same as pte_none
> > might not be suitable.
>
> Why?
>
> Unless I am missing something (which is possible of
> course) I do not really see why dropping the content
> of those pages and replacing them with a THP is any
> difference from reclaiming those pages and then faulting
> in a non-THP zero page.
>
> Now, if khugepaged reused the original content of MADV_FREE
> pages that would be a slightly different story. I can
> see why users would expect zero pages to back madvised
> area.
> --
> Michal Hocko
> SUSE Labs

