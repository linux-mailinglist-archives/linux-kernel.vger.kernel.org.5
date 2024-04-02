Return-Path: <linux-kernel+bounces-127446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDDD894B81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D192F1C222D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C771624A0E;
	Tue,  2 Apr 2024 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRWe0NAO"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC5241E2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039635; cv=none; b=Nf7BfAFympAePJMdayvpxGkAKs86GF1E7O2gjHd9lVUZZl2twSEfOcV/0LpVVUup8ABg2mlLvGYGPhEyNnjyRb3JY2DCHgCwJfpYsVty63V35JJrEUTpcjtCIUkqggHCe2be4rB8lFvTvX0Q+xEvWQfJ2BQXOzui8otRSxv0V/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039635; c=relaxed/simple;
	bh=WfJZUXB0Wucy4wWsY3edrboz9hVbKA+JvOoaZXPXl/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibfhRNqG6SKbC5DjplUcDCd/3kSrbNRoR+ClPigjQRM0tHMhodAft4Y2Rk7NhJdBBaAl7+nqNuOFyQ77Vtn6fsXRWfk/wE6VRAZaPGdSm2IRJtALStosRzM9058TXUOAJNiihVSJuE5AcaF1shv2MddD1tWitVsNALk7c3eBupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRWe0NAO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d8129797fcso26284181fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712039631; x=1712644431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfJZUXB0Wucy4wWsY3edrboz9hVbKA+JvOoaZXPXl/s=;
        b=PRWe0NAOejAmXQ3ITqRqMOjDbRWeR+WlTlWmvA9sWSXfABUNJmc4SAyay4Wno4aY0j
         XrJotDT+oy5RZC40WK7/doXUnClCtulww7MUTcb31XuA+dIYcOnRTNwOaGMVbHC7EbHw
         QlvchKbBAF5djQCiWp4+t3P1Zn6oXCMDujY/z30I9/ulj38BHymSjPWmqu8vSFyoGNCc
         PKQkJGd+67Cgc7mlKFZo0CGZfYTJrLFbSsGYGZZIzUmVD8N4NeXeOkOQGw+/Hyc/CRwA
         +rdwv0iTFjpklHIrxnA24cyqPwNARtCon23gNaY/7r2unRlozlATsHkIVeHVODTj0j+1
         y4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712039631; x=1712644431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfJZUXB0Wucy4wWsY3edrboz9hVbKA+JvOoaZXPXl/s=;
        b=uAdQTATJiCYJvcTY5lmqAU+yK1IPqk/oHn7A5eOyCd8Xew8fJ0oryvPD/ZHR2xAnBc
         7S2bEyrDhIsA+MagNhYOEwxlnW4W5ztjY682JV3CN38NOyIMIbn0NrUDked0PmQz23bY
         QQSFkNI+SfDLuIkgdr2Cp16Jl9TJ6057jHMRKGJF3KZNv28auf7Q+09tAR0l5CjmsSuI
         6om3x18xXfFhMoSzOitwlOevZSA8p/T7PLsg7qNqssTa5C5wrJGVYK6JGEtWg8EkRtT4
         aF9o+OZB2GIxeh9yFkNcQ3kUfT7MUmQL1JDTomBoiX5bhh0b2WoQ7tnv8dRcOBpyYEi3
         dROg==
X-Forwarded-Encrypted: i=1; AJvYcCUw9IYzvxq18Y+xxhHA4V5iYWj2HU5Fvd89oQZBSblZd5mo8+dx8nPYuwqIMOGXvts03/5DA+YbVXj+Sz9mjGpwA6//ZcSLRI7QG308
X-Gm-Message-State: AOJu0Yz9cunCiiyD4d5LZB7NbN5DcC1V+ece6+6JhcwLzqxBklU8kehl
	ZbwbmVwcqs3gtYU6HCf0vujp0zGraJIgJhFrRZXt/T9Xl95KrriMvn6TTPRofDqMexgkCkD+clq
	C7ejeMg5JrBdBd1YimppDSXE9DII=
X-Google-Smtp-Source: AGHT+IFrF+peqaqFCCGF16X35g5CpPH1YFC+SDa8pFRJeYm9hZc1mBc9E20qaewP7CYxn4hnM1CjsauVZLyC504KnbE=
X-Received: by 2002:a2e:954e:0:b0:2d7:1ce5:3e24 with SMTP id
 t14-20020a2e954e000000b002d71ce53e24mr5521022ljh.34.1712039631218; Mon, 01
 Apr 2024 23:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401081734.1433755-1-zhaoyang.huang@unisoc.com> <ZgtSfsRxXiTCkejS@casper.infradead.org>
In-Reply-To: <ZgtSfsRxXiTCkejS@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 2 Apr 2024 14:33:39 +0800
Message-ID: <CAGWkznEF1gSROzNc8c4BbdYzkvwAv=Wu6YuF635UY7TCjByb-Q@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] mm: fix unproperly folio_put by changing API in read_pages
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	NeilBrown <neilb@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 8:34=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, Apr 01, 2024 at 04:17:34PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > An VM_BUG_ON in step 9 of [1] could happen as the refcnt is dropped
> > unproperly during the procedure of read_pages()->readahead_folio->folio=
_put.
> > This is introduced by commit 9fd472af84ab ("mm: improve cleanup when
> > ->readpages doesn't process all pages")'.
>
> This patch is no less bullshit than the last time you posted it.
> I explained why here:
> https://lore.kernel.org/linux-mm/ZgQRtQ60mrvOUKXo@casper.infradead.org/
Yes. I get your point in your previous feedback. Could you please
check the timing sequence in v2's commit message, where the folio_lock
failed to prevent the race from happening. I also would like to insist
that the refcnt got from alloc_pages just paired with the one which is
checked in __remove_mapping but any other folio_put. The sequence of
read_pages->readahead_folio->folio_put happens to be right when no
race and then frees the folio immediatly.

