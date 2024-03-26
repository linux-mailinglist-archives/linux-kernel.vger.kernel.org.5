Return-Path: <linux-kernel+bounces-119857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7EC88CDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556321C631FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261BF13D28E;
	Tue, 26 Mar 2024 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrypmnLm"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3403DABE1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483593; cv=none; b=HkIQLYzBfmpZEXb10ca1rq40MDMLpd5zZb7FSr1BfhterOe8TY6Q/ZHS+tPBy5GKYH7Ht1sa26v2/cV2ivq87C3Di8XFncSbkmHrDZkw1lUBOj7ijdsljI4ErqaLcn/s2toaagv3q/Ovc7Br5UqMyJjI4e16iUBEbTTn1XS5SYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483593; c=relaxed/simple;
	bh=9BM4bBhrz9QEKTRb/ZcUtAdSisba0Yfq5/fU5VxPMQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuTxWFvq/UGqGiKQxdDyP/lUNDDOdgKrxXW7KARx1gY8PJogaDNCFO5dQBZaLIEuIpf378VHhHWuVytqh/t2m/d5lsP4U9EmQHZ8ngxmgSKfD2n//72Q95bIGmzvh+42cZYRoUy5bcR/nKHzzkjJDxIHx3QgIFZ39WGnNuQSCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrypmnLm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso5987930276.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711483591; x=1712088391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXt48dRidL8rW35RYbRjHW/tPWj+iNgp6Je58Y5ZAVY=;
        b=GrypmnLmpQF78JBcr1mzru3fX+Et0rendxSSSpMN+b9xZ5WLl/bagT1Gh2GCnDPItc
         euYSFnK+KbnJAr+jqK83dxLGJ3RnrF8ZMqRZXMb09QqCy2FFbc2ER3+wlcSJQ4XlAO8h
         qr9CxgcM/e4E0Gwxp8+B105PaOk3YKEUVHtYW4ohE5hqHq91W3d41hD11HyoFRr+jz1s
         gVge++A3CtIaUWcacXCicrUYhA19wU4pgpNuqmM26wukO3Yadld298fmc8jt2bZti751
         kzitCJmy9a0Nt41Dms3BYpXbuyCE3sBokBm5Bnz1I/jxgQcJpK/xzoA04y1xOrmwEVfg
         zhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711483591; x=1712088391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXt48dRidL8rW35RYbRjHW/tPWj+iNgp6Je58Y5ZAVY=;
        b=pugA3EPbsBLJJxfSHImawQAfw3Lgd1VSvImr+zwOHCKhN3xP9lEcMUuSFVW/Srxemv
         JtV7+HP8ZDgrzTI7JoepPtAdKjkEz+Jq8uU0jkEYU1Wl/xUsL2TXlJfdMEhn+sM0Lxwd
         UkFtTEPWWlO7XWUvWhkCsWooy4qspqSdNccigAXuLBpqFRYZ82FVEb2HLYOqXkke6D9W
         8baBKPH7Dcw4/65M+i94LQIRAC2vacCN/0bAwFp+2e2e7U05Frp08ntjZDryfob0IY7G
         XUmwz7Lo7Qb5p7DjQjnxSGXC8kBlabporrvJ03jKvWoGh0SnVzBjpYD1L4J8dgjhi5j2
         VGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwtjMPAS3sLI/c+csvxVyEc17PycIbs+7pNILKoxiobhggChlCrkJSMRCG+Ie7kwLYsz/69KVARbEIjA9xqVfuQ8KvVAjawX5+MzBg
X-Gm-Message-State: AOJu0YwrbzlPKyEGKQIkCT4UNZKCpgzB2cjPCGsyvIHRgYozVEIHNHPF
	fw5BH9xl8pOdAe4v32dJcJgqR2xLdXbagCaAzYSbZMbJQxbBrQGfQwbKitq2NWrpCcZLZQaFpw4
	PJOG5qgK/8x/sbmwv6TNgt+vMiLI=
X-Google-Smtp-Source: AGHT+IEMwWmrbf02ClLpAypBNG2HXYX9kuwZTxGsGtjCx6uDmGclNQ7+sDAByyPpBx+PAx6AdtVzd9BHPxNNj/j6dl0=
X-Received: by 2002:a5b:5c7:0:b0:dc6:421a:3024 with SMTP id
 w7-20020a5b05c7000000b00dc6421a3024mr8790962ybp.43.1711483591039; Tue, 26 Mar
 2024 13:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325223339.169350-1-vishal.moola@gmail.com>
 <20240325223339.169350-5-vishal.moola@gmail.com> <ZgI1CF2dw-mauoIZ@casper.infradead.org>
In-Reply-To: <ZgI1CF2dw-mauoIZ@casper.infradead.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 26 Mar 2024 13:06:19 -0700
Message-ID: <CAOzc2pyj54X7QpzMXcRBtoG650k3C3G+SYrsOGKDWjHXQ1yvrQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: Make pgoff non-const in struct vm_fault
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 7:38=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Mar 25, 2024 at 03:33:38PM -0700, Vishal Moola (Oracle) wrote:
> > Hugetlb calculates addresses and page offsets differently from the rest=
 of
> > mm. In order to pass struct vm_fault through the fault pathway we will =
let
> > hugetlb_fault() and __handle_mm_fault() set those variables themselves
> > instead.
>
> I don't think this is a great idea.  I'd rather not do patch 5 than do
> patch 4+5.  If you look at the history, commits 742d33729a0df11 and
> 5857c9209ce58f show that drivers got into the bad habit of changing
> address & pgoff, so they got made const to prevent that.
>
> So can we make hugetlbfs OK with using addresses & pgoffsets that aren't
> aligned to HPAGE boundaries?  Worth playing with for a bit to see how
> deep that assumption runs.

Hmmm, I'll take a look. I don't think there should be too many issues
with that.

