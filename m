Return-Path: <linux-kernel+bounces-40559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4389583E271
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C164DB24480
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556C0224E6;
	Fri, 26 Jan 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCUvL8Pw"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA0D224DB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297039; cv=none; b=dn1z4Bo0MbvVJcgKIyU+H25iOmfMlO03bQzRhnTFWzqIzWnHhp0jeQtygR86nTvdhxV4gJoVwwJ+1L20I5k3DCpDPHvFFiFd4nojhb7HBB00uqKntNDRDKyWB6YlZfuw5SdKp9R/GINZbXNm5JmHnpurg+Iy1x0MSV1FuObcqw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297039; c=relaxed/simple;
	bh=/prchrmS9v6pk/30tmSIoCVni3gFDegNALlJ0+Z8LdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XP/2S48yzkLTisCYIx6jkPd2JuOwfCFb7dXQmXs+KGQTQknocQj9sxqH2IqfnvTmNtB2i2SsI5pxwJy/rDVdBoNvwIb1rNaViTS/L9NW+HzOve1vJRPwtfUBqssIgOFTXZOmLZjtyQG4hoye55yKPUN0GJtY/YwaEYVLqZwbCTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCUvL8Pw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29359a09b1bso546458a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706297037; x=1706901837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2W0Zl7xzd2wxRa6YlVpFynbgqiu+nXpKSSPE3EaefE=;
        b=DCUvL8PwCKNFtpeV/F5Bzc/ALXFzkUU718Jw+l10aVCgR8SRrK14uNCYQIe5oPAii9
         ck0nGczynQ6DeI1W4JEUCizStc7YBCzE6WSHvJ2Yq2GxuvjvDQ8qK61L66+ZhcuyO76n
         MC679tDwnvFoK2a3oyPh3F8rDGYQzrDMa33ylnNx3Ubf/18wL9Axtm6sG52XgRC1eSma
         s3VKNFHBRwiozddSs4ZNl2AyKZDqFtT61e7Ws3xOHXvAsIWjubFxO3Hc0qEpVumn5FC8
         +lz4cfKKb5HNXycqrlqib85sxY+NAiE5gbHaAUm/HefXBL5BmB/zYdeb3Fm8aGBOsUt8
         okrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297037; x=1706901837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2W0Zl7xzd2wxRa6YlVpFynbgqiu+nXpKSSPE3EaefE=;
        b=SzzaBwprbrtDLkYQyfUp6iJfIRu8UxyYK0evDiumaGqfIMDn7X2lwXPosOlmFG5KC+
         zWkjw90oE3Zu8cOQBAs5gcEWgL5naE46bCt0MFDa0GCqlKsqjBJPBaTwRwn7G6xXfuTw
         ZjxMC2BGY1ZEfGTDCcp5nSo/t6vpNfw2GUFkEoMPVjHon/ti0nzLKy8IvvD7bfId7H3u
         tnweQFw4/bUGccOKQa312ER0Sud2CGvzAW+Gn7hLsxBdqwS87bty/SoxPsT69gz8+p/P
         II1jjiQCpfc6OJqMm6oR2Hfw4haMZhgsYI/ggfNn1p1FLvBhlCaUhopc6vIPh+pORKEn
         hf0g==
X-Gm-Message-State: AOJu0YyzQYHa9gQP1b+9QF+ZFKP6hpWNzhupTa/79gPUAHbmZ5ps0URe
	8m8aSZueNQACL8PiVrewY6ZpKNx+v6ZYf/t6leC02paKABEsz8nAK04trK3spFllWQ5niVeENPN
	xL6z/djvW2GCEZ3VTE7S4Ffu8mQ==
X-Google-Smtp-Source: AGHT+IGAupg42rEVh/vaOuBwDb7XGOLdEvwyP1ZIUaCiKEh7/r+/dL8F+veFfdVgaJ2G5E9eWWup5Q0gZEIfxJuvKts=
X-Received: by 2002:a17:90a:4891:b0:28e:7686:8e25 with SMTP id
 b17-20020a17090a489100b0028e76868e25mr344648pjh.42.1706297037455; Fri, 26 Jan
 2024 11:23:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALGdzuqqU1PJ3BZ2PRtCHXyrsZ2xtzk38abB0=K7V-kOCYgHfA@mail.gmail.com>
 <ZbPnsnwnVKvI1rQ4@casper.infradead.org> <CALGdzuo7V-3-US9U+rjyBfmZD=d-gUfAxJejsTUsmnSZNDnh5A@mail.gmail.com>
 <ZbP7ThrtxhIBJChT@casper.infradead.org> <46490518-0cdb-4d11-be9a-374ed5792da8@nvidia.com>
In-Reply-To: <46490518-0cdb-4d11-be9a-374ed5792da8@nvidia.com>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Fri, 26 Jan 2024 13:23:46 -0600
Message-ID: <CALGdzuqfyB66WvWiZWTqB4Nx1+vS04R2tq8Nu08OFzsggipDmg@mail.gmail.com>
Subject: Re: [Linux Kernel Bug][mm/gup] 3 Warning Crashes: kmalloc bug in
 gup_test_ioctl, is_valid_gup_args, pin_user_pages_fast
To: John Hubbard <jhubbard@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	Zijie Zhao <zzjas98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello John and Matthew,

Thanks a lot for your further explanation of this issue! It really
helps me have a deeper understanding of the testing interface used in
the kernel.

Best,
Chenyuan

On Fri, Jan 26, 2024 at 1:09=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> On 1/26/24 10:34, Matthew Wilcox wrote:
> > On Fri, Jan 26, 2024 at 11:31:26AM -0600, Chenyuan Yang wrote:
> >> In this context, I would like to seek your valued opinion. Do you
> >> believe it would be more prudent to avoid fuzz testing the
> >> `gup_test_ioctl`, or are the warnings in `gup_test_ioctl` an
> >> anticipated outcome?
> >
> > It seems like a waste of time.  Debian certainly disables it, so
> > unless you can find a distro who enables it, I wouldn't bother.
>
> +1000! The purpose of gup_test_ioctl is to provide a way to invoke,
> from user space, direct testing of some kernel interfaces that are
> not actually exposed to user space for production systems.
>
> Fuzzing this interface is exactly what you should never do. :)
>
> >
> >> It seems that `gup_test_ioctl` can indeed be exposed in the kernel by
> >> accessing /sys/kernel/debug/gup_test.
>
> That's a debug interface.
>
> >
> > If someone wants to fix these things, they can, but it just doesn't
> > seem worth doing.  Part of the art of fuzz testing is finding things
> > that are worth testing.
>
> I'll go just slightly further, even: some conceivable "fixes" could end
> up hurting test coverage. Without providing any real benefit.
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
>

