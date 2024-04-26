Return-Path: <linux-kernel+bounces-160084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE758B38E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5763D285FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1061482E4;
	Fri, 26 Apr 2024 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="OMZmZ/SU"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E232147C81
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139403; cv=none; b=QSPJ3CTa3KqdQK4tPXKBJvFR1sMaPOt2S82BHcpkLZY2sH2DqYj8N7cqykcyqrBnW4ZBeF40bbY8jHQekZu4+owT03z7FphIPgl08KZ851YrsYlrIilx7EgtVqF/fMrktRSn6UzUo5ybNg5SJYyadd8vbSzl6is3m/s0mN1rw2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139403; c=relaxed/simple;
	bh=yEHETsmy6A3pdmED7LIQsgDNKtWVkTM6epIFSP8k2Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMhfBsY0yM1D5QKuW8O8oYvCZQDXOxmnL2tEXEWxybcXo1ENwgEUn9LlW6rOdnMncma68zuVWDU272TxVUVotjtiOHjE/o+wsQoedxMMfv7h/i7vI8oB/pziBPi8LVWnlX6UGEKoeg7kJHzYsjdT6T2lQR90Am5dcw6uVzlmrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=OMZmZ/SU; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-439656c1b50so11687991cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1714139401; x=1714744201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hww4hDlFqZRQuN2jVnVqsCqso/mW8GodRjS6lEQgT4E=;
        b=OMZmZ/SURyJZcrtrfu1DjUQjCjXo5wuhCDrFti3R7+abe8cESNh8sFM/sh3CRbK2Ta
         XRCrRUdq1pe+jTarnoYCLNPxDK/fftmHJX6XRgaxhs39id79O5NZBQBBJMWFDoo+XAAr
         xr7FofHo7+d6CCaK1QzFz7S1sCcoJ7A12lHWwrSnZmEBUmUTvNUR/ScFfSROoVNgieBE
         J197F+4jNFGUqOQH8pGvBokEyJS8GE69dpj1ivRBa/nHmEbQyMhAudd3hmRH43no7pqE
         d5h0OhcTT6C81MaCdIZPDLQebPcOSDbw51o+zvCFpWKoKoL8srIu8KS1WzB2JEOyezUK
         h74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139401; x=1714744201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hww4hDlFqZRQuN2jVnVqsCqso/mW8GodRjS6lEQgT4E=;
        b=ifB5dzRieQaP53hIf+dQuyIrGEh8xUO6g0n7zIfjhD09cx4n99HSzj8TURbYSJ4tkQ
         RwlDYGWGQ+8H3f5Cw3yj9JOYo/Ku2vBL285GojRsycyFIbqvehxHTZawhSYwTiSejS7a
         WN0/SDxMy333LytMBleswzZ4SY/Txr+na3S49BsSVKUrcX1eHgu52XnAIZ8FBKx9IUQt
         Zz8hTHRjwe2vcBErGgY56ENnbtmIM3hGJGuZ2/qmhKII75kqCMt3BiKEMamT/FAn9qEc
         IN9SbGXRB1WwPp7/zev4ssg2vqmw0StVUomFY9O0EZ05NKuWPAcTmYG8oPQSmojjQm7P
         PcNA==
X-Forwarded-Encrypted: i=1; AJvYcCXKJVwFED6BtZ/EMaurASwzT65Eg85St3vPaoHQWiJtFZb4SQzVcUjwejje6i3l5g9DRX9KkZ/I68UVudoYGJwBewNyQBLrE/M8l8Cg
X-Gm-Message-State: AOJu0Yxcy6+fu07oCXegBahQNIRCs/wxh/hLvxUuQwU6hnlNSz8D+Fo3
	ak2WbIUdtIpWBwbOIQfxRSEDLcDbdq4EdFryqWK2F6Zl/uPu5Ok+UrenUtrSv/m4jhstus7EE+9
	bbhv2QFERlLXF5jDHxNLBAUReJvDAzr0lEVGeTQ==
X-Google-Smtp-Source: AGHT+IEQJm6kYqJSWyv4kAgbHk6X+OT2P1LduO5vFa6/5g2dJaFsMcv+gi7fN2vALs5HFxFMrnRXLC5G51Qg8kIXMJw=
X-Received: by 2002:a05:622a:5286:b0:434:9991:6498 with SMTP id
 dr6-20020a05622a528600b0043499916498mr3263799qtb.43.1714139401100; Fri, 26
 Apr 2024 06:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426034323.417219-1-pasha.tatashin@soleen.com> <2daf168e-e2b2-4b19-9b39-d58b358c8cd9@redhat.com>
In-Reply-To: <2daf168e-e2b2-4b19-9b39-d58b358c8cd9@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 26 Apr 2024 09:49:23 -0400
Message-ID: <CA+CK2bC4SWTCG2bnA16Xe+gX7=N=UYWB1wSns-K-jNqC1yrdvQ@mail.gmail.com>
Subject: Re: [RFC v2 0/3] iommu/intel: Free empty page tables on unmaps
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rientjes@google.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:42=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 26.04.24 05:43, Pasha Tatashin wrote:
> > Changelog
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > v2: Use mapcount instead of refcount
> >      Synchronized with IOMMU Observability changes.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This series frees empty page tables on unmaps. It intends to be a
> > low overhead feature.
> >
> > The read-writer lock is used to synchronize page table, but most of
> > time the lock is held is reader. It is held as a writer for short
> > period of time when unmapping a page that is bigger than the current
> > iova request. For all other cases this lock is read-only.
> >
> > page->mapcount is used in order to track number of entries at each page
> > table.
>
> I'm wondering if this will conflict with page_type at some point? We're
> already converting other page table users to ptdesc. CCing Willy.

Hi David,

This contradicts with the following comment in mm_types.h:
 * If your page will not be mapped to userspace, you can also use the four
 * bytes in the mapcount union, but you must call
page_mapcount_reset()
 * before freeing it.

Thank you,
Pasha

