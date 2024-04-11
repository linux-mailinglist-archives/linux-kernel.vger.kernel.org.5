Return-Path: <linux-kernel+bounces-140759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC68A18C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5517285E94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E465818042;
	Thu, 11 Apr 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R3YY2n/0"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5281175A6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849498; cv=none; b=mMWl5qvzVTe/C9SweY6fTjESGai8qlylFSK8vfmOw8d10UARKzFvNoJLegPm5X5fkpol6PhcPkSUYYXk4Ls/xI5Tc9bNKlg5jnZ4tkCv2yGyHTMdw8I0YFH2mY7+MMAEaElGYfGnMHMfYzE62xdvLjJNHq28ehM8VycSoxZOMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849498; c=relaxed/simple;
	bh=1F8FDCWi7kV0VWLSz4mlwqNZHS3BzwqFKom/1e6MPAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhcmkywuvYeReIX9O3w4BFjjBc99jD0kcLrkeDYp1BYmmISbJg8S7eCVsPxoqht1jzXNEIhd0qihVXNN+FfuYPDSg5qEKnqKAC3luvN9ASwjTW9cwIr0Z6TxLUzM/lO6kB+R+vJ/NnOtpYXMPZmgj4UE76UiuRWgC8tXOz4gxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R3YY2n/0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso37123405ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712849496; x=1713454296; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h26jApcI47a9THxXWamb//DMym3AleVu6sOiT6ZGH/o=;
        b=R3YY2n/0VwUwWve61b5CZ3IBPO30oLs/f2nMFH8EREXjpTHIHlEmK6get3jv1H+7Nr
         LzLwT/KT3I9cYPiTYeAtKbFQ6f901IeroZqNTuKDBaW3EylhQBA8i1SXI31oI+p33vMs
         5VvKi8iWLhGCK22xr7AnHWH+fsEQ0KNWXvrlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849496; x=1713454296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h26jApcI47a9THxXWamb//DMym3AleVu6sOiT6ZGH/o=;
        b=lBz866X6CARvjBkukdl2B9WgLZPPj5Kzb7DrRhCvzdQrH8R5ohhJ5BW/u6yKiLOQXP
         yLoXHI31MkrhLP6N612ovrRdBRHUXpCRAM0RDkNQrA2TT+rbhwkTHxcgpUU1J0raRc2t
         AqFUBzXwdx8DXz50BkRP/a0bKMnTqh93/uyMY/R4p5Qe6WxAT0Gnv33whdN/N/JQRlFy
         GoWKlEIk/qOvh2FoYfMQO8dB4Y7ohzaHQNEHHV/JnHzyggMxGEhbkynSJ+QQC+6fmbON
         suBa2mnpAmmAcETv+mcdL0tYUN+w8unzTZZCRpYvG2d2etjVNYBKoyJHN3G/CKtY4RkP
         3Kbg==
X-Forwarded-Encrypted: i=1; AJvYcCU+l8OrAUoLaB8uIyRe4bZU5K3EIvii5jCciQRXvEXPIkTOe2TUik4QzN7QXIIQRhM/3cAMzcxfckgcIyBMk+v+DUcNqXB2dPUbuVhx
X-Gm-Message-State: AOJu0Yz+uCxM+NNtm4qF7dcIYefwg88CjMchCe6tzDOMZLyAoT4ieH6n
	BnTio+rBf9uu0Dw8mfHxcvp+fN/zdODpJLZkSfS3lhxHBRohwpCq6JKf0z7zfw==
X-Google-Smtp-Source: AGHT+IEejten/fI5yIJ4OdU9ANzlh7kmTzwwsMRkhZrYGCJfDgxUgiz8KKlY5DuuhFAg3kagyyJlHw==
X-Received: by 2002:a17:902:e80f:b0:1e3:e0a2:ccc3 with SMTP id u15-20020a170902e80f00b001e3e0a2ccc3mr6911262plg.30.1712849495918;
        Thu, 11 Apr 2024 08:31:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b001e26191b9c2sm1304039plk.67.2024.04.11.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:35 -0700 (PDT)
Date: Thu, 11 Apr 2024 08:31:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] xfs: replace deprecated strncpy with strscpy_pad
Message-ID: <202404110829.D3A5A56@keescook>
References: <20240405-strncpy-xfs-split1-v1-1-3e3df465adb9@google.com>
 <202404090921.A203626A@keescook>
 <CAFhGd8pr5XycTH1iCUgBodCOV8_WY_da=aH+WZGPXfuOY5_Zgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8pr5XycTH1iCUgBodCOV8_WY_da=aH+WZGPXfuOY5_Zgg@mail.gmail.com>

On Wed, Apr 10, 2024 at 01:45:21PM -0700, Justin Stitt wrote:
> On Tue, Apr 9, 2024 at 9:22 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > -     /* 1 larger than sb_fname, so this ensures a trailing NUL char */
> > > -     memset(label, 0, sizeof(label));
> > >       spin_lock(&mp->m_sb_lock);
> > > -     strncpy(label, sbp->sb_fname, XFSLABEL_MAX);
> > > +     strscpy_pad(label, sbp->sb_fname);
> >
> > Is sbp->sb_fname itself NUL-terminated? This looks like another case of
> > needing the memtostr() helper?
> >
> 
> I sent a patch [1].
> 
> Obviously it depends on your implementation patch landing first; what
> tree should it go to?

This "flavor" of conversion may need to wait a release? There's no
urgency on the conversion, and there are plenty more to do for this
cycle. ;)

-Kees

> [1]: https://lore.kernel.org/r/20240410-strncpy-xfs-split1-v2-1-7c651502bcb0@google.com

-- 
Kees Cook

