Return-Path: <linux-kernel+bounces-49143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DA384667B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EAB1F25612
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D001D289;
	Fri,  2 Feb 2024 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4Ai01dn"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020FC2D7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844257; cv=none; b=DcD5zm6caBClWoBBuSoT21KtiWAS0GHAVC6DT33SBYy18p0kpW1lgD4hUNgps+KENP88tGn3MGHEjHPfCs8tPaOEiyBkFh6EyNuYtDoEaSs3pIsLi7xdnfpitv5UjU5lmPVSRu3igzYcUcGjaep91/5YL39J7cPEAOtJ5eWmhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844257; c=relaxed/simple;
	bh=F3RU9i0uU3xxYEdybKRzetgfuHN+SaA1c3E4tkveiMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVRVlKs+xizsWK9kjpxsZE6GmSi08G2pjSeCXrou3+2S5X7QZtEHeTAdhR7A8FN6jvoox9+uN6L6v+jYFWF9KfW0cQVIJiMB460W285vHJ1idYaMMGKboSLWEg6KjzuIimPU2l37I58kvr4aZUCe5McSED4EfeiH0QO2iNISAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K4Ai01dn; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21428d99395so1220181fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 19:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706844255; x=1707449055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC8wVnR3b9FYoU326Hexqhd8UbKzrj1qBSp3p+CBSZw=;
        b=K4Ai01dn68Hk4OzXwV8MwazFSDe0UiHI3FyAjykAT6WTAF8du5repEyczPpQQKk8rL
         szQQbmxQ/DKXAWyG8tRIhvYLZ7MfCpSuJoy83bzg0XgMK2Qv3uMtHGfjY+ORozkIiX+Q
         mYxjjHrNTMSHhpgvrHLA5VNqa1s5RXKJfpaeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706844255; x=1707449055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SC8wVnR3b9FYoU326Hexqhd8UbKzrj1qBSp3p+CBSZw=;
        b=BY8KQFJpvsKsQgZg3J3S9bWO+raBK6LzaL+O9wk2YgpK8IwlF31U08bOoscJhl9hrb
         LjG3ZEU98VVfmPfv9GoR89Ml4yL6lo/W5PE0xJKtujq6XWlkcT5DC+toKzl0nmjf5ECw
         TXyJvHZmZhPlTrSI9AfSX/lcsUtMu3eCPYjwz8+K/3TXaqfFw0IfTu3X5W5GJLWCQ9dm
         cwLkC3NKpOd4TVFES8IryF1rF+fglxl+Mo4tfvrCXp+kFiYofNCYEO7jQrBor7HYmDil
         mt8PQXJ2YmDt8OISOT87fY3CRsUmy6oIvo5EY2sRgKKceERABrv5PJZaEullFs0QbpkJ
         NmZQ==
X-Gm-Message-State: AOJu0YwLwyCcREztY489ukvj20z3k+jpW2oLw2b9gh7hx6bsNbw+2zFi
	KRdLszaQI4vyWFn642xiZqKA021GmjAIMhViX+332JIcD6E/RDE8+9renKAkvlFetlqfI7oo5EM
	YwVQNtuwpIbR0yVX9SW2/HRZW/74dLQ9+9AxV
X-Google-Smtp-Source: AGHT+IFVtEYMlNn1ZPZd/WSM3dio26Xfg8lvB4X5Uex93ZbRv/CK5G/PNTz+uV80oEs86/m1pkKQAtE0anCQk5ztgRg=
X-Received: by 2002:a05:6870:b49f:b0:219:1f9d:e0d9 with SMTP id
 y31-20020a056870b49f00b002191f9de0d9mr161830oap.29.1706844254829; Thu, 01 Feb
 2024 19:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <60731.1706826280@cvs.openbsd.org> <2024020137-hacking-tightwad-a485@gregkh>
In-Reply-To: <2024020137-hacking-tightwad-a485@gregkh>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 1 Feb 2024 19:24:02 -0800
Message-ID: <CABi2SkVb1goM95FT5v2K18NHbaLitLpK6fL+wE6Y47z8yvW0Nw@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:06=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Feb 01, 2024 at 03:24:40PM -0700, Theo de Raadt wrote:
> > As an outsider, Linux development is really strange:
> >
> > Two sub-features are being pushed very hard, and the primary developer
> > doesn't have code which uses either of them.  And once it goes in, it
> > cannot be changed.
> >
> > It's very different from my world, where the absolutely minimal
> > interface was written to apply to a whole operating system plus 10,000+
> > applications, and then took months of testing before it was approved fo=
r
> > inclusion.  And if it was subtly wrong, we would be able to change it.
>
> No, it's this "feature" submission that is strange to think that we
> don't need that.  We do need, and will require, an actual working
> userspace something to use it, otherwise as you say, there's no way to
> actually know if it works properly or not and we can't change it once we
> accept it.
>
> So along those lines, Jeff, do you have a pointer to the Chrome patches,
> or glibc patches, that use this new interface that proves that it
> actually works?  Those would be great to see to at least verify it's
> been tested in a real-world situation and actually works for your use
> case.
>
The MAP_SEALABLE is raised because of other concerns not related to libc.

The patch Stephan developed was based on V1 of the patch, IIRC, which
is really ancient, and it is not based on MAP_SEALABLE, which is a
more recent development entirely from me.

I don't see unresolvable problems  with glibc though,  E.g. For the
elf case (binfmt_elf.c), there are two places I need to add
MAP_SEALABLE, then the memory  to user space is marked with sealable.
There might be cases where glibc needs to add MAP_SEALABLE it uses
mmap(FIXED) to split the memory.

If the decision of MAP_SELABLE depends on the glibc case being able to
use it, we can develop such a patch, but it will take a while, say a
few weeks to months, due to vacation, work load, etc.

Best Regards,
-Jeff

> thanks,
>
> greg k-h

