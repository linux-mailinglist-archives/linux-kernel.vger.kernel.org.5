Return-Path: <linux-kernel+bounces-84015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BAB86A15D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1738A1F21E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7774814F968;
	Tue, 27 Feb 2024 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjcvql2q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28DE14EFF4;
	Tue, 27 Feb 2024 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068300; cv=none; b=BJy3A3SKUHObRuWP+jLyz9b8W05Dc5uvwSfH+4etr5nRD0JEiiCgLQG9srQXn3pOfuiqYjbqZe/LN4V77Iq9qSENf61aQzwSREAwSryP2Jt26seQZ+zA3lVG/2JPKobkEfuQMZbnw9c628Z3hdIgtQsFqI9MJnM/FZlEOrd5UI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068300; c=relaxed/simple;
	bh=3GOPQWzlpl/NCJMRQDoGYUrGg6h8l1hMdmnNxjsJtqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3VW9xJrbO6Vvn/KKPevAOSFoDrVYH2L0eLC6HhaeTnE5TAUcjsEfFD4156ZBqfeGkByj0ovit8QQYzamychjuGhog9bxz0lFzOYjZAEmSVt62cehezV2IB51fsO7tfzFElYyMmalYewFdbhRhqvwZYXQ3KI+i8Pmz/P+ZWHo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjcvql2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E7FC43390;
	Tue, 27 Feb 2024 21:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709068300;
	bh=3GOPQWzlpl/NCJMRQDoGYUrGg6h8l1hMdmnNxjsJtqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tjcvql2qES5K0OIzzeGu/5anJPBD1HIMPUD0G6LlAGYpGN5CU+R8NSTlhGNHSaAtV
	 Dp/vpm+NM0VoeUxzIeVV1+Q37c2CYjeZRENnPZDs04ZAGm7p8lrONQxDjeCWcDPZq4
	 g3ciWDXOFpYGEBtjbpy1Lk6YjOqwIc0eYjMkDPWVFTFL4I6tB0tYrLCukYd27iUhG0
	 Q9o+EcWtAJErVGwxTKnteqGZ/AXnn/eGuw0GiWa/nxSX1NGZ199rI1H2UvD3Qbxwgv
	 KCUtUW7jAmirWVunN837Ak6YBlCPrgH6POGxWTLm5pWozfA4A4jPc+8Op0nifhf2Tb
	 s9xaO4tiJm9OA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513143d3c42so1060909e87.3;
        Tue, 27 Feb 2024 13:11:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+/qE3JZo7Wud566cuB2wyA9S5e7a+N6m2G3U5/pKJlFXfFN1h5FdT1GI7uU6knG5zKun6xFmntnw0hpHeHWTRmRAFpmTLZC+6vUGQ+6JvxDmUYLdU+pd1rev1VR55nMQTV9QDVPNDBA==
X-Gm-Message-State: AOJu0YyP+qAViFyTgDwiWW56rbeC4By20HbpES6K2puSoF/o2pJSSOgM
	4HSjGTFC39w38W9uhkDn7B+6De5UPjfrRq184H2TXPF0Z+7LBd46cGdo8J2+31fwsTIZfA9DEb7
	7OuN6Hdb8oQ4l/KOV2QMv4rVbHjc=
X-Google-Smtp-Source: AGHT+IFCCAMw+/0CQY67zz5dcFZZA6Oh2/9pIcTZvE3Y3RQnHeGnPMR/zOtcUoABuvX2PbDAaFYrfzKiGj90QUOP9aY=
X-Received: by 2002:ac2:5dd4:0:b0:513:17bf:87d5 with SMTP id
 x20-20020ac25dd4000000b0051317bf87d5mr474653lfq.63.1709068298248; Tue, 27 Feb
 2024 13:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227120327.1432511-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240227120327.1432511-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Tue, 27 Feb 2024 13:11:26 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4PRcbQbjoXQ_F=V4DxAJp9v_ybWHgwueCLA+iU52J7mQ@mail.gmail.com>
Message-ID: <CAPhsuW4PRcbQbjoXQ_F=V4DxAJp9v_ybWHgwueCLA+iU52J7mQ@mail.gmail.com>
Subject: Re: [PATCH md-6.9 v2 00/10] md/raid1: refactor read_balance() and
 some minor fix
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, paul.e.luse@linux.intel.com, shli@fb.com, neilb@suse.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:09=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v2:
>  - add new conter in conf for patch 2;
>  - fix the case choose next idle while there is no other idle disk in
>  patch 3;
>  - add some review tag from Xiao Ni for patch 1, 4-8
>
> The original idea is that Paul want to optimize raid1 read
> performance([1]), however, we think that the original code for
> read_balance() is quite complex, and we don't want to add more
> complexity. Hence we decide to refactor read_balance() first, to make
> code cleaner and easier for follow up.
>
> Before this patchset, read_balance() has many local variables and many
> branches, it want to consider all the scenarios in one iteration. The
> idea of this patch is to divide them into 4 different steps:
>
> 1) If resync is in progress, find the first usable disk, patch 5;
> Otherwise:
> 2) Loop through all disks and skipping slow disks and disks with bad
> blocks, choose the best disk, patch 10. If no disk is found:
> 3) Look for disks with bad blocks and choose the one with most number of
> sectors, patch 8. If no disk is found:
> 4) Choose first found slow disk with no bad blocks, or slow disk with
> most number of sectors, patch 7.
>
> Note that step 3) and step 4) are super code path, and performance
> should not be considered.
>
> And after this patchset, we'll continue to optimize read_balance for
> step 2), specifically how to choose the best rdev to read.
>
> [1] https://lore.kernel.org/all/20240102125115.129261-1-paul.e.luse@linux=
intel.com/

v2 looks good to me. Thanks! I will give Xiao some more time to review
it one more time before pushing it to md-6.9.

Song

