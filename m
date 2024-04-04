Return-Path: <linux-kernel+bounces-131823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72076898C35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFBA28AEAB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C151BDCD;
	Thu,  4 Apr 2024 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBjNgdzA"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BAD18039
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248478; cv=none; b=j8NNrvVHPMnVJfWfVI9T4H4wxceD9Ttd0fmcU1GGY7dpJDPL/AbjCZh7K5snJsgsVNE28b40hH2kYYvsv+b/0nxT9aezN5xWHxLL6aWoAHK55RiOi5G93A1gxVOk00Ozb3FuXr6PZgXNyd/AWclm/NHHtrmWEzHtXQ93TKICga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248478; c=relaxed/simple;
	bh=IxZOemwIBDjGfb04Lkg6+NbqNiNba59ltvQmSjxuciU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giodIDGd4H2nD15AIGsiz/T0cx4iI5XmQNQxoybbw5vM7SPZriUyvP2I5PYIq3GK5QX7nIo2MPEYNovkMWmhkWqmixkxJVcpDmARdE6ll8m79AqnqTSWvD7gvOIxUrtWtDNtnQqbbWLLmmGdDcRb/QkLUFEccuE/J+l/JsUN+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBjNgdzA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33edbc5932bso882451f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712248475; x=1712853275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BCQK2GpcjyvGUKe27rxi+yOrz8/xQNkqCCTTXVYKDI=;
        b=nBjNgdzAoH7FcEsvy8PqywVECvBerUNxdKT6cR1flj97w1ixzU3/6+CStLm6kmxafi
         5wJoV9jBdWyJd5EoDZi+cr8Q8FCcHfF2EyJTbS5moot8X/cxmSEu6nKxHskSSiHgFCdU
         MerphfEU5H0QIiofpSKU6NXGK2k6hhdn4slxNCLByu626uag4HHmptnqnT2KJFhby7yq
         ZlkFkoagEVAwxn4pux3ukg/+HmT6OyDoUCiSK6/FNJHL61TwopeG2/CnfdBsA6kJUsn1
         F1cTxoCIZ9niVgwZ5LeVlegjIqrUkoL4lVy5zUdufWjn4zFnClNPO/fpAzBHxnFBZxAJ
         qLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248475; x=1712853275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BCQK2GpcjyvGUKe27rxi+yOrz8/xQNkqCCTTXVYKDI=;
        b=C1O0UvTe1s7OG1Y23N4EaMuAPMao3OIouFi7GwSbrXyXhEhAyL9j1KDM5C3axf1ULc
         z9dJCk5T9VKTin6yU98WeY26s2bRBlp7GJsEGVld1p6AUvZxUjb4js8I+bdiM8Tkz0z7
         WKUm1AngQSYgPnUe6XNqvA3umR5zYOVLPvZChXoeE2Hz0ea4bzg+YgyRshX26DVfYT/F
         k0boMU8dIkhMfJoqy3KEJJt64pNyxgIIdZKDgFrrw5Hno7xPP+1uaMxJcd14ib+Gn253
         9ODRuS94BGMnJDrT/hnR+YqCqTNrHc8PyH6diOB+99kNpmPjeqW0PBTTmfihVyPvM1P1
         9hCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNQVYX7INFG9rzIcn/YsPLqVK6yXF7eY4/7Z8uYz3ckwDsXiRs5fHJaleFA5bj55cd9Nu5/478Js0swvrM4h3T2LwTTF/Xb2hmS5iw
X-Gm-Message-State: AOJu0YyYY/lc4E25C0AF6QnXGMgwmLpPE9FiLd5XucwQ6xwEWDnfCmbp
	VItJXWqSWGOi4t1CRcz0OQI1CUKeThCPmC76lak+WHS691KH36Ai6Vae6jEv99c2a61hfn6lgeF
	c1sdpnU6ropaqjqdHQoAeFpLFTc/HGlSBEmiz
X-Google-Smtp-Source: AGHT+IH1HZji000oYGtwTRIYZZmon6pxkGZKF7LVCOK3aZpyYUspDitssTu1QfsYUQ8hLLd+O52wvFiM2I4yiwmS2gM=
X-Received: by 2002:adf:fa50:0:b0:33e:cb03:2471 with SMTP id
 y16-20020adffa50000000b0033ecb032471mr2309020wrr.30.1712248474890; Thu, 04
 Apr 2024 09:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c6d4f0d-2064-4444-986b-1d1ed782135f@collabora.com>
In-Reply-To: <0c6d4f0d-2064-4444-986b-1d1ed782135f@collabora.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 4 Apr 2024 09:34:20 -0700
Message-ID: <CAKwvOd=ueTmUThCOkBGUjhMGr6mKDtbTt-d7tHKe7A2nrchWMw@mail.gmail.com>
Subject: Re: [Bug Report] selftests: Clang: kselftests build errors in KernelCI
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Gustavo Padovan <gus@collabora.com>, llvm@lists.linux.dev, 
	kernelci@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, 
	Mark Brown <broonie@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the report.  We've been tracking getting this working for a
while: https://github.com/ClangBuiltLinux/linux/issues/1698.  Other
fires have continued to take priority.

On Thu, Apr 4, 2024 at 9:30=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi,
>
> We have caught bugs in kselftest suites on linux-next and on stable-RCs e=
tc
> when using clang. There are two types of bugs (logs with clang-17 are
> attached.):
> As usually people use GCC, there are GCC-specific flags added to the
> Makefiles that clang doesn't recognize. For example:
> * clang: error: argument unused during compilation: '-pie'
> [-Werror,-Wunused-command-line-argument]
> * clang: error: unknown argument '-static-libasan'; did you mean
> '-static-libsan'?
> * clang: error: cannot specify -o when generating multiple output files
>
> Clang has best static analysis tools. It is reporting static errors. For
> example:
> * test_execve.c:121:13: warning: variable 'have_outer_privilege' is used
> uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized=
]
> * test_execve.c:121:9: note: remove the 'if' if its condition is always t=
rue
> * test_memcontrol.c:727:6: warning: variable 'fd' is used uninitialized
> whenever 'if' condition is true [-Wsometimes-uninitialized]
>
> We have found these issues through our new KernelCI system when enabling
> kselftest and clang there. The new system dashboard is a WIP, so It is no=
t
> the web dashboard you are used-to with in KernelCI. We can show you ways =
of
> pulling the data if you are interest into.
>
> Unless the above is some sort of false-positive or misconfiguration, it
> would be great to support clang for kselftests. What we can do from our
> side is that clang kselftests builds should be enabled on KernelCI to fin=
d
> and fix the errors. What is your stance about this?

As with anything kernel related; help send patches for obvious fixes.
Or provide steps to reproduce in
https://github.com/ClangBuiltLinux/linux/issues/1698.

--=20
Thanks,
~Nick Desaulniers

