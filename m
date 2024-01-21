Return-Path: <linux-kernel+bounces-32196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF601835809
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F4B1F21774
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289338DF7;
	Sun, 21 Jan 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y6tApZUt"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D42383A7
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705874776; cv=none; b=PwI5dN+HJvvvghwObC8OY/O7C8wKlUwPHc7ccDGCULSPa6r6i6x5h0yI84o/oadVX2SegVQvJwYtWh/dH4eL8xiB8+7l9P7rPaFJIVIxRJAFYSub3CjQFTZi2W2OUrVM8tJJtOvsVTyTt11/dmALLS17TWQVKLuwXbPUO2cm3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705874776; c=relaxed/simple;
	bh=eKWkdKMEDARbLDRUqfnzbi3sl/rOE8242LOsXnrFZJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcD0xb1fANdZxDX5DpIkgYFCMcq2PaOjQ2Bce95PIY9EwsssDd0zP6knxtGXLa1F76DUeDubEd/Fv4QV/kqiNP/sqPr5bCWQVYZYOl0aOhnwiH7om0QkPWtG0cmSYUE9KirrvbfXD+2cX94TjzJP6OHOwmCRGahLnwvP9qQWDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y6tApZUt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso29310905e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 14:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705874773; x=1706479573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QlVOU0qgbHsfmWmBhtAfMlGMpRk/E6kiXNX1BeiPg/E=;
        b=Y6tApZUttmXQUVvSePu4UVzB7eZZ06lPwCsR/vaEQpm0GdT0hJBYVbE9PvfHWqLJC4
         YS2uNS69B12K6fdiMRbq0CAHyP8GjPrybMYX7eyBr9zPRdh8EsPoaODeqlBDnTuyHeFk
         BmgJx9NugO/gnZ6PRHdVbrU19wSYPvb+CoK+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705874773; x=1706479573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlVOU0qgbHsfmWmBhtAfMlGMpRk/E6kiXNX1BeiPg/E=;
        b=PBMmyN3aLGzKgcYvU2PeB/I3UZvIMe5Ur4Uafx5/Wp2eQryA+c85FnZSG3RYpLglLL
         Ib+iCIzHozOTRXfxzKmT3lBCFWkQmuDwpPCVuGEvpsvcyx+NQ4scJr0c9EeCH/VaGD6K
         F4tNIao1smP1fTBkiIvLeGqqLKg6wr8irDpLkwntFiVOXXqDReLlSgWg3lIPXGlRX494
         omqEMZFP5dSdcMO4payc9SEfXh0HgCOaUA56MXs63br9OMjmHZznCARv/+1Wxuku2Drn
         CW8nhsccVB2ufvRWol0dks2qqj2HkCy1dyaDtjHDRhlJCC5D5wQj6WEnTWudZG7lsmzp
         YJZg==
X-Gm-Message-State: AOJu0YwriQCryRlXvoKrVBn0ovXuG/I/Hnit1b38heIuN2O/z/TUP4Bc
	1FyGFE7Iwrp92JVJaMLhHoiREXUnUxw6rh+hhS2KAXvlPjSHjZlgaI4wwBBtQkZsClxtnVWtFdm
	gZtMi4w==
X-Google-Smtp-Source: AGHT+IE24OJx0oEcXT7QN3fTq6f/AyTKfqwOI2K1T1PZjYu6VVoRVXq2tQWomelQfxgVLVgeq4KLIA==
X-Received: by 2002:a1c:4c05:0:b0:40e:5437:4f91 with SMTP id z5-20020a1c4c05000000b0040e54374f91mr1829803wmf.129.1705874772709;
        Sun, 21 Jan 2024 14:06:12 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id ti14-20020a170907c20e00b00a2cea055d92sm11295559ejc.176.2024.01.21.14.06.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 14:06:12 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so2910978a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 14:06:12 -0800 (PST)
X-Received: by 2002:a05:6402:1a2f:b0:55a:6d67:6319 with SMTP id
 be15-20020a0564021a2f00b0055a6d676319mr1539223edb.54.1705874771698; Sun, 21
 Jan 2024 14:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a34bqdrz33jw26a5px4ul3eid5zudgaxavc2xqoftk2tywgi5w@ghgoiavnkhtd>
In-Reply-To: <a34bqdrz33jw26a5px4ul3eid5zudgaxavc2xqoftk2tywgi5w@ghgoiavnkhtd>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 14:05:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKjvytH19t2mMHZbkY2bpGurGbG4Tb7xmTjfzA71Lb7g@mail.gmail.com>
Message-ID: <CAHk-=wjKjvytH19t2mMHZbkY2bpGurGbG4Tb7xmTjfzA71Lb7g@mail.gmail.com>
Subject: Re: [GIT PULL] More bcachefs updates for 6.8-rc1
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jan 2024 at 13:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Hi Linus, another small bcachefs pull. Some fixes, Some refactoring,
> some minor features.

I'm taking this, but only because bcachefs is new.

You need to be aware that the merge window is for *merging*. Not for
new development.

And almost all of the code here is new development.

What you send during the merge window is stuff that should all have
been ready *before* the merge window opened, not whatever random
changes you made during it.

Now, fixes happen any time, but for that argument to work they need to
be real fixes. Not "reorganize the code to make things easier to fix"
with the fix being something small on top of a big change.

                Linus

