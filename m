Return-Path: <linux-kernel+bounces-77890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1306860BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96613285BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E10516428;
	Fri, 23 Feb 2024 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlGz9uju"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A29513AED
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675161; cv=none; b=l3Eqo4dRQ9HA7uUlyrJBhoKZSVV8dbgQSsIsgx4czOgDb+Es4lio7JBQD5TjWxkBP/XjmZgiBY5I0lZzGAh8vrmiGUzR/dA1QRRNH6BUw7PxCSnNZ62yAI/HSA+0eqPKv99079p/or6K54ois0F8kLJ9m5Y5+lRZqB+un7W9E80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675161; c=relaxed/simple;
	bh=58pIforKk3pYU+TpwduX/a4NUM9YeG6awVJjgoWgrqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jv9dz9SgbhMAvK5jVxFESJz0rzUryxVzrbkdOTJO9OR0+NZiG4b+3ffyxjOo6t8AyIlC/U0UnelW810wTSsQAnU3WZIkCd5//UE2tb/JVKrdsmnMm6S26F5/nIE66eO212wyCBgHWLIHxMMde1tGhlhSQuhtmHL9XZG0GbObS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlGz9uju; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc74435c428so77456276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 23:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708675159; x=1709279959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G20CYRRkwpc4XiQtt15MXyHAMAhYgyffA964Je/jszk=;
        b=jlGz9ujuBL0OVwwnb6+1lhy+p2v9dIuN6gO6lSkDB3ayuFGNmntSj8aD9IIhBMOPjX
         8lt7MR9kblpE0PMAEsKJuO81zM/YWKLICQ/UywGQgV0oKk6mqaXpzAgKwVnQUMLRHGqQ
         Ya+0atAznO7JUT2qDR26Rl7geGTHBomY2V2hN844uQC7Ers49QIfnt8EnkQXyW917rCz
         0VLEB1s4qumZYUtTJam+NrvoaFh0n1JtbmUrJoedGxbrG6uClQcSn43hlLEHftPCl/dA
         OB2OolZrk2EJhaORIFMrUZTKJkR6Sxue38LBYM06epbmVJPv4zNUF0W4y8RXOaVfzkfc
         L7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708675159; x=1709279959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G20CYRRkwpc4XiQtt15MXyHAMAhYgyffA964Je/jszk=;
        b=Wne7CGKD3R2j6H8AaP2IajMerGTUkgEKEEb0Rt0CBUIsWb4WyN0wrFi/1o1ykf0yMG
         XAYYzqY8lDZdjeM7uHrU8WZcVWu8MKVfwi6pHpSGlI08Cfcf6h8WtGBjXs74etmTNXkt
         NwWgCEvDn5AVu+1SxEMCymu48Uf7EwyzvvHAUhNFdozV7rsyDyIgWjT9EJfJuBmDk4a3
         tYDlV6PWLJDs6NMTAPmflskYl2/dW9YBIcMryhppOrB5u3hZ7NRbT7Tuvk7Q4pNSGg15
         4SDL3xNQ8oNGaOQ4I8SUiVMkuXaw7di7G+SCP6EzpzD0KdvdbG7rv5ObZD2G66R4i3hB
         1YaA==
X-Forwarded-Encrypted: i=1; AJvYcCWHTbsts4jxSxyFx4bw7rEc8mb3jtoO8PV/awoRFBdmM249fZMrVnO0gRqIK49/66tgovGx/nT+6MW1hEVbB/dK1PDalBnm+2aNjdMP
X-Gm-Message-State: AOJu0YzOd9R5fSPt6ISP+nSc9tAFYRmgf01pUroj8M2DnfCA21CPxjcb
	YjBXq/oI/Eap+tDFBtosVMsjU1iIOfoagLjUEGTXRd9SOQFX0kIEvjjcHK+yyKIVyfvMRwSBNvA
	Sv9aDfwVxT5573iuQbErEpl34870=
X-Google-Smtp-Source: AGHT+IGpZlkojZBuQ5KldQ9ONWwa0S0G4VmAypoUsFHq2B8Mwk1MF1kK5xY+uEXuh6dMkcAp3ymzBoFW3a5ZevC4SWA=
X-Received: by 2002:a05:6902:1b85:b0:dcf:30d9:1d7b with SMTP id
 ei5-20020a0569021b8500b00dcf30d91d7bmr1453488ybb.45.1708675159252; Thu, 22
 Feb 2024 23:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
 <CAK1f24nk19eciysFqvTd=rqpiKePhstDWEEQ_mvT89WCDNrWNQ@mail.gmail.com>
 <CAHbLzkoNFn6UE4Hn0gXTm2pLHD7pK4gYUe1zVh3247m30A5u2g@mail.gmail.com> <20240222131151.4d24563d58240e76a3b535db@linux-foundation.org>
In-Reply-To: <20240222131151.4d24563d58240e76a3b535db@linux-foundation.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 23 Feb 2024 15:59:07 +0800
Message-ID: <CAK1f24nzfh9n5qZ=uMSC_WP8g0HCmOpRrZZAM0FYOfpp1CD-Yw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Andrew Morton <akpm@linux-foundation.org>, Yang Shi <shy828301@gmail.com>
Cc: mhocko@suse.com, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for taking the time to look into this!

Thanks, Yang and Andrew!

Best,
Lance

On Fri, Feb 23, 2024 at 5:11=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 22 Feb 2024 12:23:21 -0800 Yang Shi <shy828301@gmail.com> wrote:
>
> > > VMA Count |   Old   |   New   |  Change
> > > ---------------------------------------
> > >     50     |   23us  |    9us  |  -60.9%
> > >    100     |   32us  |    9us  |  -71.9%
> > >    200     |   44us  |    9us  |  -79.5%
> > >    400     |   75us  |    9us  |  -88.0%
> > >    800     |   98us  |    9us  |  -90.8%
> > >
> > > IIUC, once the count of VMAs for the process
> > > exceeds page_to_scan, khugepaged needs to
> > > wait for scan_sleep_millisecs ms before scanning
> > > the next process. IMO, unnecessary scans could
> > > actually be skipped with a very inexpensive
> > > mm->flags check in this case.
> >
> > Thanks for following up on this, can you please capture all the
> > information in the commit log?
>
> I added it.
>
> --- a/txt/mm-khugepaged-bypassing-unnecessary-scans-with-mmf_disable_thp-=
check.txt
> +++ b/txt/mm-khugepaged-bypassing-unnecessary-scans-with-mmf_disable_thp-=
check.txt
> @@ -9,6 +9,24 @@ and the MMF_DISABLE_THP flag is set later, this scanning=
 process
>  becomes unnecessary for that mm and can be skipped to avoid redundant
>  operations, especially in scenarios with a large address space.
>
> +On an Intel Core i5 CPU, the time taken by khugepaged to scan the
> +address space of the process, which has been set with the
> +MMF_DISABLE_THP flag after being added to the mm_slots list, is as
> +follows (shorter is better):
> +
> +VMA Count |   Old   |   New   |  Change
> +---------------------------------------
> +    50    |   23us  |    9us  |  -60.9%
> +   100    |   32us  |    9us  |  -71.9%
> +   200    |   44us  |    9us  |  -79.5%
> +   400    |   75us  |    9us  |  -88.0%
> +   800    |   98us  |    9us  |  -90.8%
> +
> +Once the count of VMAs for the process exceeds page_to_scan, khugepaged
> +needs to wait for scan_sleep_millisecs ms before scanning the next
> +process.  IMO, unnecessary scans could actually be skipped with a very
> +inexpensive mm->flags check in this case.
> +
>  This commit introduces a check before each scanning process to test the
>  MMF_DISABLE_THP flag for the given mm; if the flag is set, the scanning
>  process is bypassed, thereby improving the efficiency of khugepaged.
>

