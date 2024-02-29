Return-Path: <linux-kernel+bounces-86587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4A986C772
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9641C2312C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49337AE6F;
	Thu, 29 Feb 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EayRmfsz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A27A706
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204055; cv=none; b=TFrkYJsmE9EJIOSoLnLaYDzF19XavY9iRJ4QYCe+HwioGXYEZ6Q2Ojxl6rwen2cJFOX5Jb9wDow96WnkbYo8dTL0JLokoWoraUUhouaueCKhtyS9fpMygxCDmfhA5O1677jmNkOVXih7WuQQ2rfc43E0FcNkjkyJ2s4z0EL3cZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204055; c=relaxed/simple;
	bh=B4M+30LNGd4NCXPYSJh+SaoQaFHddiLAjc/rkLBvjH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iv9kGIzVG7pfz1RnVctXYoniTsOkvTIWyuGFQahD5slQ59DyI52RaAWRLyI8MpPfamhXC/QitXnGFSjTUJiZC3MxsCHYYyaBaCbEcJ+JnBRbJjHxoWwgDC4cY0mjPJkuC7iCdTpc4jpoUXUntkvPBNcykv45MXI+t/tln7Nd0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EayRmfsz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709204052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eH2k1QLODQKplEDD4hU7B8ByG4njU3dDRW2ps+j0zo=;
	b=EayRmfszo0ltf70axyHjkA9nJqTnG+jbmKA3pyymj813EYnQJia38v09oFJhToWqYWX3Bo
	mCwMxDvt+LPjH2eaNe/MwXlBx53ZxdZoayRwxDxUcAfoPexzd6UHj2g4bmpkG/VaX2Kael
	RpkxhiuhGse1u8kH9PkbkFapsk0LD3Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-Fs2jAfj6NnGl_A6Ft-UA6A-1; Thu, 29 Feb 2024 05:54:10 -0500
X-MC-Unique: Fs2jAfj6NnGl_A6Ft-UA6A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33d5aee5f0dso209283f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709204049; x=1709808849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eH2k1QLODQKplEDD4hU7B8ByG4njU3dDRW2ps+j0zo=;
        b=vFuAP6xnZdLre8tG9+YE9bMxdeH8CVVBFCRhyRun8oNGm42SI0Y69oARrrW67hZEf/
         l1I4+0A2uJ1baE2M7tEzM+Grlmyl4pSYYVYhfsIEnmt78stjkjvw5l/l8wlzbvsUF6F3
         bxIrqvGt0dtEcVPSUeYgDSgrWBdU/Li3IcBmHGwUYAHXvwv/SAnwkXYBXCZG3U32D5J0
         6QICDNBQ5SCswVeAx4Hp888Q5skIWYRrTGIj2YTaNQRrDbNyHtkfuRe91WrZ19OmPxyU
         WMYINt5TQbS0y1cvXbgVRXOIh+tF9H62jIzC5YftpwrvPGaaZHTI/WvnqAQKi002T6ne
         6+6A==
X-Forwarded-Encrypted: i=1; AJvYcCUkPS2ueIQYSmDf6QFSTRmiMAmJpUG0vcYkLRlh5wFFP4i6R6/TjJCCViFBMW+JhfMEv/FRVRHFaR5lx9R5DyvtXJ682GBnZEBwtXd5
X-Gm-Message-State: AOJu0YyjvgWtHKvjWkpqRLK/Nr2nsdb3hK5UFrJiL1B6je0yUn5wSbb4
	Q3uLeQWZV/00b+ZSqn+ne4kOJqpHW1ZkbaIZcIUkn6T2Vc3JETjSg2I0P1CXFU/cK9v2JinW9Vo
	Q7AvQ0nGJOEd272sbI7KAN1VEFKcbhX8E8Q7VCZLaXqeCJmvlAkWIomH26GJbTZReyozEoD3ltm
	2T7twM4xJQ99MiF4qW2NU/LmCPU+yINuL3C5+G
X-Received: by 2002:a5d:58fb:0:b0:33d:b627:c3ec with SMTP id f27-20020a5d58fb000000b0033db627c3ecmr1211600wrd.44.1709204049103;
        Thu, 29 Feb 2024 02:54:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc3MRlCSnB+DBS/s2eR1iycEUSBiNEdZSNDV8OZeLDEeFRdNF8jTPx6t31nT5oTVr7ObPu+B7iD89UKkArI8E=
X-Received: by 2002:a5d:58fb:0:b0:33d:b627:c3ec with SMTP id
 f27-20020a5d58fb000000b0033db627c3ecmr1211586wrd.44.1709204048819; Thu, 29
 Feb 2024 02:54:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
 <ZdYKSkqRckOc5aRO@sashalap> <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
 <ZdYSmdUKzQAYpprc@sashalap> <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>
 <2024022129-expiring-resurface-146c@gregkh> <288132ea-87cf-4b56-908e-2263b6c6b67f@redhat.com>
 <2024022236-stock-wielder-fcbc@gregkh> <7be9ad00-1432-4a19-a954-32fa0f24fecd@redhat.com>
 <2024022949-uncapped-crushing-e5f9@gregkh> <2024022918-deepen-composed-c680@gregkh>
In-Reply-To: <2024022918-deepen-composed-c680@gregkh>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Feb 2024 11:53:56 +0100
Message-ID: <CABgObfaH2BHK==ZgbeajH8SxAxM51=91idrvd4n4L7UNiNQkEw@mail.gmail.com>
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING
 in raid5d"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, cve@kernel.org, 
	Jiri Kosina <jkosina@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:05=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 29, 2024 at 06:32:03AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Feb 22, 2024 at 02:31:06PM +0100, Paolo Bonzini wrote:
> > > So if the reply-to points to LKML + the subsystem mailing
> > > list for the maintainers + a new ML for the security folks (and these=
 three
> > > are also CC'd on the announcements, at least the last two), that woul=
d be
> > > nice to have.  I can work on patches to vulns.git, for example to int=
egrate
> > > with get_maintainer.pl, if you ack the idea.
> >
> > That might be a bit noisy, for some commits, but sure, I can see the
> > value in being notified about a CVE for my subsystem.  If you have a
> > specific 'get_maintainer.pl' command line invocation you think would be
> > good, I can easily add it to the scripts.
>
> Would:
>         --no-keywords --no-git --no-git-fallback --norolestats --nol
>
> be a good pattern to follow?

I would include lists as well. it would be nice to exclude
reviewed-bys but that's not easy to do in get_maintainer.pI

Paolo


