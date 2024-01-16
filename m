Return-Path: <linux-kernel+bounces-28243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0091682FC13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9F528E064
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC6222310;
	Tue, 16 Jan 2024 20:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jfTgnP3S"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5621A16
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705436562; cv=none; b=NCrHJecAcN2q8GnzD0vBVewBidXHualHYhBfdbuXYKzVmFyI6mQULPyECqo5JApZcz1NV3LQrf1wGPjfwOyW4dm+ceUlHY5m6tKQOYHaPIi7YpYFTgD6mXlDQ8WR2mTp0aViyeNsElarFf9DOn3zc9aJaQm9gB55Ls7sksxE9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705436562; c=relaxed/simple;
	bh=GbewaLDE7ejqWTSe1Uw7vLL7HLyWHwBvBMoUDsHTfAA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=AkSfm0oOtjQj89KiJcxXnUT9cPi8a81O2Ch7MzDjRaXos9lXMmPkABEzPwlLQi83HsUJCFLdiokNSwDeqU1QWBU77rCjLmaxRv0XjiSINFTr/tpxhu323yBSJfCBQ//Zg9e2/7O3B5MRc9RlbjDTonYFPsS2g5+2HBP1IkgUTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jfTgnP3S; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28b0207c1dso837149266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705436559; x=1706041359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhueWCQdqElVocG4cseHtcllTglR0AY+WcF+ciYZaXU=;
        b=jfTgnP3SpkzMrXMJ5LjKl/LCj3d8fLGYgCR1vn/Ac/eZHaTKW4h6Rz7Iej2csT2B9w
         blZZQtLv9zh8XJA0EyBfAwDcIH0hDIK5mSM20bd0eeNH1xOv6aAQrQmYTRErDem3MPrK
         rUnwkEJIh7RyePM6peyD5kYjXb9suXCGazctkDkw+Fr/Zn9vAPJoly0zER0K/sDQ/bLT
         c/siVER0IPUWFdxSUGDf4OXqqOto8wNUKU97eK2/DdVReL1u1Zn81DLiBFxY0zN38wkI
         FEl2Cs8KDMiBNGZn7ktpRQnoL4x9JU7yeqJxh5BBW/QBt7kG/bfyyVlPvgRMamoS0eby
         uA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705436559; x=1706041359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhueWCQdqElVocG4cseHtcllTglR0AY+WcF+ciYZaXU=;
        b=ZRP8+ZwmwBMJonbXq8PhLQ0G99/PpRuYNJhogdLXz3nhzum/aV7mJzfCILx/nSmEUe
         H4VlPedMwp0D6YSP+3hxyNuryx7RuME1wSdqG1BtR+orsyY9UR3msxDx3stKNm2p7XoA
         T2AkRpaUV9KmraIGBLMWbe//qTC3OvHAXfk6117F1xcqfHmbyKcx7+OVrefiKO79MxOU
         k0ZdryI66KOJIw5zjRqx7k7WjLDrurth661cIB111gTHifVamy4mDnDCPVj1xY9eHEnS
         hdVDpUtAKUoqDbxz85lIF7L1mu/Fu2HBfnLO48FxRdYgYdpyCTnWJL5/Rc7SLkOQVhD+
         CAxA==
X-Gm-Message-State: AOJu0YwCCR3QIed3M5g3ke1UJoUAiDNt/6yqOaKgfsv/vFWzYT11jBeZ
	Ls1kglrXVtzntBOAmy89+WyhhSTDMNpohX2mb/ar8nJsIDnu
X-Google-Smtp-Source: AGHT+IFfbiFrflS7DGnikOyyoqgK5W6/ElyNOxA0Q/fC6CSvSvdhc7N31dE2i6e8q207dh6dl41p3jZSJ6nivQDSZkE=
X-Received: by 2002:a17:906:c24f:b0:a28:b35d:f240 with SMTP id
 bl15-20020a170906c24f00b00a28b35df240mr4342098ejb.10.1705436559223; Tue, 16
 Jan 2024 12:22:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230714194610.828210-1-hannes@cmpxchg.org> <ZLIVleBYOm4HIGTZ@casper.infradead.org>
 <20230717141250.GA866068@cmpxchg.org> <901409ed-504b-9500-54d8-e42f832e07b0@suse.cz>
 <20230717160227.GA867137@cmpxchg.org> <20240116120944.01f25e65d13f0fc7e2a2df34@linux-foundation.org>
 <ZabknuNmymSP0XgG@casper.infradead.org>
In-Reply-To: <ZabknuNmymSP0XgG@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 16 Jan 2024 12:22:03 -0800
Message-ID: <CAJD7tkZRnywCj4ha2hMcjQU7OjfR8DQ-Pi8K89NADxObCXvsMA@mail.gmail.com>
Subject: Re: [PATCH] mm: kill frontswap
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Christoph Hellwig <hch@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, konrad.wilk@oracle.com, 
	vitaly.wool@konsulko.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 12:18=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Tue, Jan 16, 2024 at 12:09:44PM -0800, Andrew Morton wrote:
> > On Mon, 17 Jul 2023 12:02:27 -0400 Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
> >
> > > The only user of frontswap is zswap, and has been for a long
> > > time. Have swap call into zswap directly and remove the indirection.
> >
> > This falls afoul of "mm: zswap: multiple zpools support".  Could we
> > please have a version against mm-unstable or linux-next?
>
> Did this email get caught in a timewarp?  Or is it referring to
> something that isn't commit 42c06a0e8ebe from six months ago?

+1. Both of these changes have been in Linus's tree for a while now.
Perhaps Andrew had this email prepared a while ago and never sent it,
and ended up fixing the problem himself.

