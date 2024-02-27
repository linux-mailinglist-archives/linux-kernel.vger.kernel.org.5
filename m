Return-Path: <linux-kernel+bounces-83974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD1286A0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF28A1C23545
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B114A4C9;
	Tue, 27 Feb 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RshvfPE2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E751004
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709065563; cv=none; b=QIFXGJRTTT+q8wP8WgbQjFGb5IPx11N068Qujs4awepN5mLzD9NvQWQKvnLHxR1z41MsRtHCULj41tjr4g0lv8x4a4vUA43OKj/DJiC8kE+l/UYF7UkcOJxGxDdhgwXwqfRLa78KElEqy7GHW7/orWrwnjrA9ykMNEBsGlgP2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709065563; c=relaxed/simple;
	bh=7S/l7jZJ21iUwVevZ8cOQI+LxMEGntYoU5b/Yq5y9hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I84SnmymGRFlmWQqAt/DkXSH02k/14MQtmKtXB6euIEy1I4n6FeNhUg8KHapRENkVyjEFv9EQfXx+f1T7apugxuKwaPHJj0YFTOilA98FfVnZt3V0TRiEjIDTLnkoxCkTWIMK04s7sLiZYASDneTK4KDS/yD2SYRzRWr2MCwYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RshvfPE2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709065560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+h7qK8aFxtDvDR5hE75ZYRCW8UfQrEkELzJmQTxV4sw=;
	b=RshvfPE2hBGUjCZF3iHIYU9PkgO+DtR5s1VGoWE9zQq4obHIdtHlD9ZdtvuSL167G2GvS7
	OKdvDVML6rKAOjNQjeY29YcW9DzHxCl2Y4MzrCZVazj/5vN3raDU3HhvXuheL1LcKt9y2a
	V7jOKA7S3yKIHtRCHs13rqaZbwu0tVU=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-sWBqFMPgOj6eDzOQ3pabQw-1; Tue, 27 Feb 2024 15:25:59 -0500
X-MC-Unique: sWBqFMPgOj6eDzOQ3pabQw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfe777fe22so346040339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709065558; x=1709670358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+h7qK8aFxtDvDR5hE75ZYRCW8UfQrEkELzJmQTxV4sw=;
        b=n5ZSRGLUxEi8qIAhS8VOZtr+sY2gGCY6JYwMaZ0ChVdpCGUnslrF/xFslc0hZ++SoA
         oMvHjQBNQkiB3EVbnfpgUMChl4ZoGL19wcH59YJslorpm2gL6wWdV7HLrOzUaV24IwK0
         +fdqn0zChyrmx20ymmPpNzRysxHjkIa+nWjv6XjGio+0vLT1LIjF+8NT5KjwzwDRL3vC
         7FApOcVKykN1D6UcPAyFtNEMNEsyw+eWWJbPXe11HVQkSuRkediBenrZEjHpOb5QA5yd
         LSKjYjcj8wgnlzq24ULzLtSwkOep+nWBZ8sdPGLvkpr2u+K/fKIE0rzNOHs0S5O9v8vj
         2tuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2n7UUdhl1Mb1P7mopTFHRyem4A3bGbD80a7reUorQd0VllqWbas+XZWY1slgzxmKl425ms/dPZBBoNtHhgymqK4rdQsRa10idDYix
X-Gm-Message-State: AOJu0YxKt0xEl3hk6P54nmcSBEqeQQVS27y3sIedxTwo44Cd9Vlgya5Q
	6q9TgCvzqGIrlfjVsniffKCYKcLPzgTtSoyOb9AEdIR4DC7ledHgysKXqlKK7n9qgN98B5vc9FY
	5nlP2E1EbnQ6RNklxF9y+1ONn9Rcexz1ie3Nwz4KEeZLEXKMPK/hB3yTH7b++rQ==
X-Received: by 2002:a5d:87c3:0:b0:7c7:f47b:79f8 with SMTP id q3-20020a5d87c3000000b007c7f47b79f8mr897094ios.11.1709065558449;
        Tue, 27 Feb 2024 12:25:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHci+23CQB98NMLlChr+k6ZWKSdNDJpBGejQs+zKcJAxWU9Z7kPda1p4il3PKo54WX87BWJQ==
X-Received: by 2002:a5d:87c3:0:b0:7c7:f47b:79f8 with SMTP id q3-20020a5d87c3000000b007c7f47b79f8mr897080ios.11.1709065558190;
        Tue, 27 Feb 2024 12:25:58 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id r25-20020a056602235900b007c7de4a670esm684477iot.6.2024.02.27.12.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:25:57 -0800 (PST)
Date: Tue, 27 Feb 2024 13:25:56 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yisheng Xie <ethan.xys@linux.alibaba.com>, akpm@linux-foundation.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] vfio/type1: unpin PageReserved page
Message-ID: <20240227132556.17e87767.alex.williamson@redhat.com>
In-Reply-To: <abb00aef-378c-481a-a885-327a99aa7b09@redhat.com>
References: <20240226160106.24222-1-ethan.xys@linux.alibaba.com>
	<20240226091438.1fc37957.alex.williamson@redhat.com>
	<e10ace3f-78d3-4843-8028-a0e1cd107c15@linux.alibaba.com>
	<20240226103238.75ad4b24.alex.williamson@redhat.com>
	<abb00aef-378c-481a-a885-327a99aa7b09@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 11:27:08 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 26.02.24 18:32, Alex Williamson wrote:
> > On Tue, 27 Feb 2024 01:14:54 +0800
> > Yisheng Xie <ethan.xys@linux.alibaba.com> wrote:
> >  =20
> >> =E5=9C=A8 2024/2/27 00:14, Alex Williamson =E5=86=99=E9=81=93: =20
> >>> On Tue, 27 Feb 2024 00:01:06 +0800
> >>> Yisheng Xie<ethan.xys@linux.alibaba.com>  wrote:
> >>>    =20
> >>>> We meet a warning as following:
> >>>>    WARNING: CPU: 99 PID: 1766859 at mm/gup.c:209 try_grab_page.part.=
0+0xe8/0x1b0
> >>>>    CPU: 99 PID: 1766859 Comm: qemu-kvm Kdump: loaded Tainted: GOE  5=
10.134-008.2.x86_64 #1 =20
> >>>                                                                      =
^^^^^^^^
> >>>
> >>> Does this issue reproduce on mainline?  Thanks, =20
> >>
> >> I have check the code of mainline, the logical seems the same as my
> >> version.
> >>
> >> so I think it can reproduce if i understand correctly. =20
> >=20
> > I obviously can't speak to what's in your 5.10.134-008.2 kernel, but I
> > do know there's a very similar issue resolved in v6.0 mainline and
> > included in v5.10.146 of the stable tree.  Please test.  Thanks, =20
>=20
> This commit, to be precise:
>=20
> commit 873aefb376bbc0ed1dd2381ea1d6ec88106fdbd4
> Author: Alex Williamson <alex.williamson@redhat.com>
> Date:   Mon Aug 29 21:05:40 2022 -0600
>=20
>      vfio/type1: Unpin zero pages
>     =20
>      There's currently a reference count leak on the zero page.  We incre=
ment
>      the reference via pin_user_pages_remote(), but the page is later han=
dled
>      as an invalid/reserved page, therefore it's not accounted against the
>      user and not unpinned by our put_pfn().
>     =20
>      Introducing special zero page handling in put_pfn() would resolve the
>      leak, but without accounting of the zero page, a single user could
>      still create enough mappings to generate a reference count overflow.
>     =20
>      The zero page is always resident, so for our purposes there's no rea=
son
>      to keep it pinned.  Therefore, add a loop to walk pages returned from
>      pin_user_pages_remote() and unpin any zero pages.
>=20
>=20
> BUT
>=20
> in the meantime, we also have
>=20
> commit c8070b78751955e59b42457b974bea4a4fe00187
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri May 26 22:41:40 2023 +0100
>=20
>      mm: Don't pin ZERO_PAGE in pin_user_pages()
>     =20
>      Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a p=
ointer
>      to it from the page tables and make unpin_user_page*() corresponding=
ly
>      ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunnin=
g a
>      zero page's refcount as we're only allowed ~2 million pins on it -
>      something that userspace can conceivably trigger.
>     =20
>      Add a pair of functions to test whether a page or a folio is a ZERO_=
PAGE.
>=20
>=20
> So the unpin_user_page_* won't do anything with the shared zeropage.
>=20
> (likely, we could revert 873aefb376bbc0ed1dd2381ea1d6ec88106fdbd4)


Yes, according to the commit log it seems like the unpin is now just
wasted work since v6.5.  Thanks!

Alex


