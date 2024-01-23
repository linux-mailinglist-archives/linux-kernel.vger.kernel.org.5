Return-Path: <linux-kernel+bounces-36001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399838399EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F0EB2258D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2482D8D;
	Tue, 23 Jan 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLqHEYAp"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B36482D7B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039917; cv=none; b=pBayuoUPWlICRp1ksolsz6eZlkSpYPCIPLFP1a/8gaeGKPYj870MtpWOa3+reEbJyc/BNqSmeO+82rnEYJ7iq9BzWM3YXJxTzGT8D5QrKfQGCFyy7yyLpswuzU1gf3XUdMpXWH42+fAxpn4ezK8FBVF9hZj1ymlK9wVJM1xAHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039917; c=relaxed/simple;
	bh=nYvo+rfNB69fdGKHBcdMDR6KR35HaCryt3kDT3duWoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtmWiOIrORZ+nNgz47JUMTU8+TLMPYxMQP0xLB/q+1/PxVDGcIQ24Uc2i5lJ60DjCWw8RsaTF9YytXs0ENMFwSmcfni2mnmPsn1wQXAsnM7wpYx02+RsQOaXR5bVXxNDHC8iXKa1ChP/Gaf5rN5Vv+9lUvB22fL1ndmz9rzEF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLqHEYAp; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc223d20a29so3777930276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706039915; x=1706644715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYvo+rfNB69fdGKHBcdMDR6KR35HaCryt3kDT3duWoQ=;
        b=XLqHEYApP2RjSr2hSZ6p4YNYENzVCXLFlQAe6CMdhFMEbnOs4MQUzThny1HNcEiRu5
         24M51JSBjRYmYZTo/IHScHE4IVCRkUUG8nP6d9PCvqHUW73kTjyWAQAyRjjK+70u0n2m
         SF6+YSP7WL0zXOBGXChwt9OQYRHNUUE+yxn4zMAkwj2kmUWBN53WLa/V0UJg/wgJOzT4
         BH1JAq1hEJmfpfOoT/SLbuiRgwYT/F7CrAlcNWVUrZxCMCS1QHLaBz6VG9/YJ/BYQGHp
         yv8T/pgYLodnL4QIxCvsioeL/7KFu9y4NdVKW/J2v9fDiy4Xl6yC/XUtEMefZwyvHkYW
         03Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706039915; x=1706644715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYvo+rfNB69fdGKHBcdMDR6KR35HaCryt3kDT3duWoQ=;
        b=BYS2DpoSG2h+qyekhF8Gy1F+a2iQCJd7rbTda2YeUIWax7SBZRqhujosadGBWRwDea
         ImdIfFxAOgJ8u12fkGp9QovkJhLZCzDCfE0QO9dSAEIEvqaglJb5Kc2RFLmL+meCm2Pw
         s6aeyGooxJHFF96gJhOlKKA2/6a9t2+fNMO5dkC8VNcoEVJGLZK1TgsMjU2fWjOMesio
         vG4PuCjhA04KKRGubMrbZBIyd7Y/JEdJOqRn7S5Bv+ykrp/0haD+sVkuGmzn1D/jjK1c
         ZgoCfVttIH7G4opSr5/vpGV2TuwnUOQ6OF7scd/fooJq34T2j9mydc7jtoLkp1PHUtGq
         +rcw==
X-Gm-Message-State: AOJu0YzxcvOx42A9nPiAd7vhIZO8zy/l4LrWRnn4HUQlo3PFwiQ336ci
	tEqOGGKK1vWXxiTrZ7RRfC34IRS4K13ONkJCkMTJkvedWtDAm20Ar9kLjc8Ndg8fa3LB/gnc00J
	XJFDdXIF8208Wpj9YPfBHzvOYA86qWZ8p+ss=
X-Google-Smtp-Source: AGHT+IHGoSEchkymg5ddhczryrZhgHLXWuEEwXlE6/ePL8YyPjoBb9/I9QQxbPyGzX8/yCnShMQwB4Yciia010VzKCo=
X-Received: by 2002:a25:2fce:0:b0:db7:dacf:6206 with SMTP id
 v197-20020a252fce000000b00db7dacf6206mr4150549ybv.88.1706039915535; Tue, 23
 Jan 2024 11:58:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e1c27b64ae7abe2ebe647be11b71cf1bca84f677.1704855495.git.senozhatsky@chromium.org>
 <202401101646.B1C4FDA@keescook>
In-Reply-To: <202401101646.B1C4FDA@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Jan 2024 20:58:24 +0100
Message-ID: <CANiq72nQsBvNFnr3Rp9aX17X4=G+jFQBB-7Uv3dXY3uKN+3xcA@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] Compiler Attributes: counted_by: bump min gcc version
To: Kees Cook <keescook@chromium.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 1:46=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> Yup, this is good. Miguel, I can take these patches if you want?
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks Kees -- just applied them on top of v6.8-rc1 so they should be
in -next soon, but if you need to pick them up for another reason,
please go ahead.

Cheers,
Miguel

