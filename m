Return-Path: <linux-kernel+bounces-155942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E378AFB21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8D52886B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089A4143C74;
	Tue, 23 Apr 2024 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rfh3yqj7"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812A140E40
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908895; cv=none; b=tRscQ19Ed+7uxjHfaEIl1jTdtf6UizHe+dXu21XZoyJhET5xP33QDVGCJprOjLFyNM+kqwTQ7T8j/wU8szz7a0EQXgLNLqn9VJareQy/z0An8irndq4yoiTGbL68pk1ZwVW1hCnJeoJJy/g4KazOoWjcEanvYBdx5pb1/5F77o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908895; c=relaxed/simple;
	bh=ztw70WIqVQBaNSH45npjc3+FwzycdJ4D/SvQ14SFB8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMd/lOmxk+BaUWjhL+n+2hvvHRHvSy8qlptsFigZPol0NJqJUYKZC6nJF4HbJmtVgloUmAE4GPXyKo9A2R003KMuv+0WPqCbUH3jwXSTzxLLQPVWnQ/bt1We6t2BmGGWjch9vShca1I/G4ZhL7wuLdif6cop5j/cSRkLd7M9zaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rfh3yqj7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-436ed871225so43601cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713908892; x=1714513692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOksILe6nmVL7yfoj3z4gNTzqZws1cudHPepaiKTCFw=;
        b=Rfh3yqj7EZCXEZF3vw1zrM9hY36tMpEXRQauZA93WUA2LvkOeuwKYSE7+K92SR3Alx
         O+7HyGgU72a/sES+AVgRtrriJDpirGB9CSeyvooY1AjeA9tpJBxvJCRSBMtcoMB215xT
         hVkIf7nD4R/FhDpQYmA86rU2nHT7GuhzyJZcOrw4Li3yZ+d9O2+Loy5yxheMRsAu08QH
         pCbbVvoG0gf9+6L3mfYVZNi2Up1KUhlpjFLBhoU2YSJh9H7lkH0UNFoxyzJRQGEBcUn7
         X5nksqFtRBFfWLSfcFPkV9OXpfPW7ekU3uY1RcVlZc/oY545hZdmMYzFkfwZaBDTKd9E
         z3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713908892; x=1714513692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOksILe6nmVL7yfoj3z4gNTzqZws1cudHPepaiKTCFw=;
        b=UwEbZfXofcTZJq6ex2clZXC5CeyxfR5qCVGJBwm7DthM36bKTRuAqBiyg6RtLAvXDX
         NJlx2qmMwOxE6R1XN1swa0xW65a9c4sGtcvGfrk2u4GPB8RWnmsiXUfq+hubV/ziwzTF
         IhaJcU/Zc3ymUKVbHZiR0zYEWJWOYSY7Qhxn94QFUxVjHm9KWrSGqj3zDdZTxvmhRSF0
         p7EYFHJOxoalu4mL+bEyIB+tIlE93Bg4zpoDoDiIHRAudDb4phedzcMPT2lOJmLrnXNi
         Kopuat/cPVpsfp6mmKKa/Habn8D7JbnsLbc91iR79AQYBwqGuEqnLKPMdaeHx0w5JRtN
         Fx2w==
X-Forwarded-Encrypted: i=1; AJvYcCXNIeXLByo50HKmohqUKm8o/HhGaSWZ8mVNYUihb1cWB+L8+QdDer5skzAd4nHkyXMhItIzvvvjTzdi7pFAL+40VDgaFqN5jblCyUm0
X-Gm-Message-State: AOJu0YxcmLqvjSFXZPf50ah3nVKzxRUd95yKJLqmRmtEmNmIv6ZX7qQA
	Urgcgbx35TDFHKUr5ZFnPR/aqUplqffBz1g/W9uXkZZ2kc+/uZ45I+R+A6d+wZozAeDQ5hJ41Al
	iNoR/LboqQJ/BL4O32YlLME2OUnxgRkx2pbq4
X-Google-Smtp-Source: AGHT+IHmfmt+n8ZHr2UBZvi0KLd1MiLpZSd36KI5Slq28e1mUs9ISGikELJmw2vgTIXu80YXGqN4ALSywcsgHOYDleI=
X-Received: by 2002:ac8:5482:0:b0:437:c4ae:f3b4 with SMTP id
 h2-20020ac85482000000b00437c4aef3b4mr82800qtq.26.1713908891776; Tue, 23 Apr
 2024 14:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZigRDKUGkcDqD-yW@x1>
In-Reply-To: <ZigRDKUGkcDqD-yW@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Apr 2024 14:48:00 -0700
Message-ID: <CAP-5=fV0sX2V5+yjTymzDFXakxZxFxKvokCOqobOFgZHn6eVsw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tests shell kprobes: Add missing description as
 used by 'perf test' output
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Veronika Molnarova <vmolnaro@redhat.com>, Michael Petlan <mpetlan@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 12:50=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Before:
>
>   root@x1:~# perf test 76
>    76: SPDX-License-Identifier: GPL-2.0                                : =
Ok
>   root@x1:~#
>
> After:
>
>   root@x1:~# perf test 76
>    76: Add 'perf probe's, list and remove them.                        : =
Ok
>   root@x1:~#
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Veronika Molnarova <vmolnaro@redhat.com>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/base_probe/test_adding_kernel.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/to=
ols/perf/tests/shell/base_probe/test_adding_kernel.sh
> index a5d707efad85cb40..63bb8974b38e0b0d 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> @@ -1,4 +1,5 @@
>  #!/bin/bash
> +# Add 'perf probe's, list and remove them
>  # SPDX-License-Identifier: GPL-2.0
>
>  #
> --
> 2.44.0
>

