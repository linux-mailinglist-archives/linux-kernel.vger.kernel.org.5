Return-Path: <linux-kernel+bounces-88199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F87386DE7F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D47F0B26243
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D616A8BF;
	Fri,  1 Mar 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lym7PwvR"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3423BD;
	Fri,  1 Mar 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286175; cv=none; b=Gfp4mSsRgAyCw8UGXinvHUjTKclm4BceO48zahkWIotU813QXtkjNirPXJJmT/Oz0pWi4+pbU/sDuoNSNaHN18LRJrR1mJIRqXRHnB111XeIu0bzYZTqcYNxTioS478K2AMilqLCaR2r/ST3zH0sKgV+6LvhDp2P0K9z9CP7E/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286175; c=relaxed/simple;
	bh=GheA9YkRjWROmqg+lVjcKOm6fIRi4kXVh6dbszWjll4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jY/+93lWtbi9TPVHOkpdzlX7d99Jg+QxO/muagPjKKKh+CE665UE6ou5AqIgbbMYmVjZdCWEOjEd4wphm2e+fxDdLLwyGr+abL1CC9Dg5dfgYBmr5yiTsHEQrrnbJpNXdA0xQprX1316KKmbvAaAgiCNgCNMts89aHdZrsFyAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lym7PwvR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29b2a5e1726so86056a91.0;
        Fri, 01 Mar 2024 01:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709286174; x=1709890974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GheA9YkRjWROmqg+lVjcKOm6fIRi4kXVh6dbszWjll4=;
        b=lym7PwvR46odGVrKo+bZUuW338aBrT7fsC5cMaZPqX4t6zj80diZ41IYZd4p40En/e
         /yhCwD0YPg7pYX6Sw5wtE9rrVjsIuoz01UasCAOmoWd0tNc9qNMpIfr/7eElpeGL9rIB
         0dxmZBqBm8HFJ6JO/YkskeiAhq7auYRoS8Gz3uTn+Fa8zHx89P0gSDDXsyVg6RW6SRwX
         9+FZQO8PZ1R9KJs3JIPk9EXIpZNNHmkn4wjehK7iIAD5iwQBCaibNQFMlyGdaD5GSbOH
         R/o2lMa7BGOhDW/Q47Ja0sZRmJmptR0sM6HsJPiAQQ788jDExplFtuNKy4fxKZh+MYHB
         Fjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709286174; x=1709890974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GheA9YkRjWROmqg+lVjcKOm6fIRi4kXVh6dbszWjll4=;
        b=bpaa1D2Q1iCVYGGO8qeex8GuT223KnRBpVWnNn23uWZ/eKrZgqyc91Yw5NSp0z2VXO
         VQD7aAaLAyj9lL85Ge/Oe17gCxJA2IcBINoUp9l4yFssqGrAvHO19yQHl5tWioE4xr4g
         4Ph5q12+l1sYfX1JKZRyzOYbzqUF7eUF+nOYiPLPbteuCgxnKrQ53z4pBj1h+yVB9j9j
         4PfVsvJ5M9YK3Sd/DpZm4T2lvzUUf3Zpqp82zNbXlCrUApTiN/pfXi1z6G5mYNpi0QIP
         MjBJeIj1SCoDMILrJMjm7hiZd5Qgz8Oui489i4r/RNYDpl/v0ltZGDHRJNDq+cRoLlhC
         5UIw==
X-Forwarded-Encrypted: i=1; AJvYcCWAicBTnKn7ARGccID2bdbXEW7b/hLkJsp4LpD1ArGAmq7frp3LvuYU0vm/ySCLo7/kNfOquJDYljLXpalRJ5oL99C5m/LZgEcUqHwXS2Tpzb4SnuLadCD9UbOHItJ2dITw4cnDkQ0SYw==
X-Gm-Message-State: AOJu0YzG46+d4gZB0o8P8PO/ccBOCFwdMuq41GlGl3AzbvOCGAwq393H
	HKGVTds71+G+2o1o8H5yWHbPOy+P7WYOgD7+gV0RQbRHv+p8Sg3DdxFppgqyrYt+zgXENKigAjy
	Mtg2FZzQEckSMPfx6tTOkkiPEh1pZ8/grMqyNVw==
X-Google-Smtp-Source: AGHT+IHsGmgAGusC1c4MKByGLQca8Om4uRqYIeRuPtqzqBdpcp0b3V6rIiEIYPPYSQidp5LHt9BbkDV8+wkwvI86N3A=
X-Received: by 2002:a17:90b:103:b0:29a:e097:50b4 with SMTP id
 p3-20020a17090b010300b0029ae09750b4mr939480pjz.46.1709286173681; Fri, 01 Mar
 2024 01:42:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301153347.3b909702@canb.auug.org.au>
In-Reply-To: <20240301153347.3b909702@canb.auug.org.au>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 Mar 2024 10:42:41 +0100
Message-ID: <CANiq72=q+aFCRw_76dGYNr2EGp+Rm3ri_hs9+PzOAFZ-FLcBmA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the
 mm-nonmm-stable tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 5:33=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> I fixed it up (see below) and can carry the fix as necessary. This

The resolution looks good -- thanks!

Cheers,
Miguel

