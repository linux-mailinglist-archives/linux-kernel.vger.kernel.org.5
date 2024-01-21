Return-Path: <linux-kernel+bounces-32157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA28835764
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5F91F21880
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA438396;
	Sun, 21 Jan 2024 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUITy5wK"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB3381CC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705865853; cv=none; b=sB/MyGyZUcgGPN6i3wBa/4XWIaQPEMhf9gstKeEISTY49jdx06QESedZd3ALrUOmooRXdhpQTNZtZFGHi5zHxG7BwYW4nOFtvxx2jZyUZ1gqwG6BkAR0eXViljuFF5G9BWMGAKzDiVnkj+039TNvNnPip1uDqdWITNMDx3BxylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705865853; c=relaxed/simple;
	bh=gjTKvJ4mVwTZuyhJPn7lfBzLf+l5KyVBbkDE7y3VjpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAwSvFFzYdYs6f2wvLdudylKUbJ8aRH3eCuI10Lke+rDEnNM+1zP8gaLh3yh65M/YxdlEAutswqKZ+wvcm5pn6yHr+xNttRj9sbznHVqUIlK8OsWiHA4Xtkd35I3TA9oB+kjdv9hItlR6ihDsLdcgIJU6JbHldMKZ/YwuEdLDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUITy5wK; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5f0c0ca5ef1so23215377b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 11:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705865850; x=1706470650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjTKvJ4mVwTZuyhJPn7lfBzLf+l5KyVBbkDE7y3VjpE=;
        b=NUITy5wKTs+GLltfhGUhNP4eLFcw2YsMJ8QL1jIBoRSsQ9kJV34JjocxsTtP8dqZqj
         Ks8t+dFP1AqH9Le7rib2MEXhTdG6J3VOJi0l521mmHquRhUQI+kvEDltBbxZz0lHc7hV
         Yr4bED1GoBZ7qi+Ps0ZOgAUNaSO9aF5DyeVMJfJEoVWp/rt3vugRfdHSvUZww4fdqFoQ
         qK4gtSUSyAzcfIB9btYdzEWZN7McfcxzSSY4wR/cg+fVcRsrFqrkncPhsAOBPI+0ZscX
         Huki3XHvboE6Ni4vMFl7DKKPoNB1lkP0/ZWUVMTB4NpiyGKiL4IaPWiPNhyTCkfB9Q77
         spvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705865850; x=1706470650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjTKvJ4mVwTZuyhJPn7lfBzLf+l5KyVBbkDE7y3VjpE=;
        b=vWMuTF3uRdexKDPLilEMKfJZ2fzEo4eKgQKPGNi3M7cuCgd5xrSL/FmRkdh7PlEnYh
         IHju8+M7BBlePD2vPtJ24/m6Bjo6+Tj2HAalVYL1rnIwWaUN+d9tjCuTfgIWlqQD2NTf
         oDJzyDMgR20thRo0Qp+sR2t8E+DBHKLATObsqCmNouNWefrI6aJ0BEybkk4quZPN2V1t
         3dwguKD00xk5MXPQEQTpIICMgG0pUqG16wmHGpgtPDeMKYxGQJS+O/Q4keWiA+IJ1kFg
         HCEVWaC+9UPzZt16kqHAcF9Tycn7kXaIMwO575IKyXF3gj1Z7e+UsBI+Y6LVptxtNoPp
         UE5Q==
X-Gm-Message-State: AOJu0YzU7rSPSx1LdMVe6uLUGm8bijz0JGYzHHXbA02FFltXoGddmkOo
	kO0xpf/ONUeA0pDdIWcqbBseqHjxqwF2GQ+mxQtmlNr2CmrX7dGdZnIA79HHo+qUYd0m5wXBBCD
	PZXOcb4PR1P96OVrKyZucT4B42sOaOuXibtLO4A==
X-Google-Smtp-Source: AGHT+IHYFpUhitOX2AdmDFG06pyApujnRuwmVINWEr2J0isFWHjtyNyUMSFT/nF3+dUi0DB8rtIWg+bPhrPNcXMIy1E=
X-Received: by 2002:a81:5dd7:0:b0:5f6:df70:bdda with SMTP id
 r206-20020a815dd7000000b005f6df70bddamr2639459ywb.32.1705865850566; Sun, 21
 Jan 2024 11:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119201356.7903-1-ansuelsmth@gmail.com> <20240119201356.7903-3-ansuelsmth@gmail.com>
 <CACRpkdaR_gtW6VmenfV5=xounqV18-kZyNprJUtLWkpgXUnkvA@mail.gmail.com> <65abfc33.df0a0220.65bf1.4e35@mx.google.com>
In-Reply-To: <65abfc33.df0a0220.65bf1.4e35@mx.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 21 Jan 2024 20:37:19 +0100
Message-ID: <CACRpkdbr3MqKNEM_AudEnknJOf6VaV7mBQre2puH_HLGWZYn8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: decompressor: add option to ignore MEM ATAGs
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Randy Dunlap <rdunlap@infradead.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Eric DeVolder <eric.devolder@oracle.com>, 
	Nathan Chancellor <nathan@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 6:00=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
com> wrote:
> On Sat, Jan 20, 2024 at 12:52:33PM +0100, Linus Walleij wrote:
> > On Fri, Jan 19, 2024 at 9:14=E2=80=AFPM Christian Marangi <ansuelsmth@g=
mail.com> wrote:
> >
> > > +#if defined(CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM)
> > > +#define do_ignore_mem 1
> > > +#else
> > > +#define do_ignore_mem 0
> > > +#endif
> >
> > Is there a reason why you can't just use:
> >
> > if (IS_ENABLED(CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM))
> > in the code?
> >
>
> Was following the pattern, yes I can totally do this change... Will send
> a v2 with this changed.
>
> Since the first patch has to be regression tested, is it ok to add the
> Tag in v2 or I should wait that to send v2?

Just add the tag.

Thanks,
Linus Walleij

