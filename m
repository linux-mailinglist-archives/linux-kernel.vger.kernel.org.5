Return-Path: <linux-kernel+bounces-167723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79B8BAE05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD771F233BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5B3153BE8;
	Fri,  3 May 2024 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Eo4oUO0N"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B411153BE3
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744094; cv=none; b=IF3+UwXI6Ky6buVy2VWl2WMtsPyU8W622VjOdzBa1CAgHgWHbgWK0/RGydxrBjD22ZBtwtmDWHA85893ZXcFFxTVoe3GnElWEuagB1FhOId/ESh5F4RWRJ8tAZpn8EzDYVj0PpefpNcfNk5fyFdqcojGV3Pyzk5tsQGEiv5OyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744094; c=relaxed/simple;
	bh=ZtEDfOvwvxE7Fvlei3awx6n7b16lJ64hGqs3ri5Vvno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skEvtvTfloSBgg0x0iNmHukMWbFxvo6ZKvNWrkiwTWn2po5J0eA0UfGkZbxdCoycK+/pR91KBFVgxkh/EceDkBHF1tIpwRMFMy4+FX32rYgDw9UsSk2eVePD/sCxN7BIGKo/lYhHuMvsQcqIzQi8Rzh5n1cTYOjdG9bdP9sIHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Eo4oUO0N; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f44b296e1fso606413b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1714744092; x=1715348892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6o8JjInWH3LKnqSsl6S6HrXQoEHLETqeq/r/V572dU=;
        b=Eo4oUO0NyGT18aCFzFdFLe56ucL/AJueYCJUdmnHl9Nt23FCxhv5x37MaOUQ4mh6Rg
         6rJn7CuSsD3GRMFq5Spa4vSs2Y6E/sn+whqdcgZfPtnfK0N0uG/rm4XIJzYVogyjq5cy
         T8gOz15Y0vP937ik8/MQs2ywKuHg/sWL6CQ/IJn0fQFnkVjd1NEBIL4WSTEDva/JujcI
         H6RvqEgEq7x/22Kzc1WfR+te5bXod4QDkYGax6eZR+WzdpL1b0kO6ZiyL8PeKwpKi6zH
         36NuwY5Jj+qVik3dnrT6dxhciqxhsCWIz46r2bmQh9zOv3o9tINJDeTu0AbtuOMKxL0g
         tqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744092; x=1715348892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6o8JjInWH3LKnqSsl6S6HrXQoEHLETqeq/r/V572dU=;
        b=Lli10EEmYz3LtTAFeXZK4veSCL+a+b4R+lMkxP+5QDLaFHFyrF4LS/Bc4/FyAzUefH
         n5u5N8tqAtTu3CdbGiS6QqRCemu+i7jb6sU9QLb08UiZ+EjG/LwYTy7qKKrmLIpHbFO8
         EZJyF4BsoJ4NcZDlV1FM9CQO/M1A3RkrpWNlFQwnPtba+GHxD3ETWGnRdmVQ74YB1j9B
         VCkNRM3figR8ZWQ1o9U+FhPH6LVy9mPc/PomQfYW83yksrOvLmAr9jCummfVOMh+Wt6H
         yWbWrRJqXwmaJT87LbV+YmDeEzpvSHNBReLLR+0uka2RXxyHV3MG0I0i8sAWAWby+prD
         0ycw==
X-Forwarded-Encrypted: i=1; AJvYcCXF81/WlvzlxwN5VSIxfgzrhmQEzXI5r9kDCNhF0TAv0Jptst62WQxhtGbPL5X/tUMbyXIs0QJDR7MlWbL4fCCORPvbcQOCma/anMGj
X-Gm-Message-State: AOJu0YzBy2nvA4rIFSLQgtkr6mzVj7kAdFxvwAAWo1lm7Krxr22jztLD
	whH7OQpMEl2QDRoA+lJGcfc2w2IeFwtnie3JY/B4IoDwMbiT/BE6e0b0iErOAPFfGpp7hmAT+Wt
	tWbz9L/FIQyYkpy/hE0bx7YBY/OSL2VZ+SaCV
X-Google-Smtp-Source: AGHT+IGcHQbk7BIXmDO++MVBetSDEcok6GyH2AElax21yCwgfaWPhGQ74GzYA7sVljZdG8KJzwLOECLgom2T9Etb/J0=
X-Received: by 2002:a05:6a20:a7a9:b0:1ac:de42:bc5c with SMTP id
 bx41-20020a056a20a7a900b001acde42bc5cmr2278110pzb.42.1714744092194; Fri, 03
 May 2024 06:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503032956.89290-1-jhubbard@nvidia.com>
In-Reply-To: <20240503032956.89290-1-jhubbard@nvidia.com>
From: Dmitry Safonov <dima@arista.com>
Date: Fri, 3 May 2024 14:48:00 +0100
Message-ID: <CAGrbwDTv7qikmnKVHECrX0SpxLV5-3RExxCEtPykfmMrVeBhQA@mail.gmail.com>
Subject: Re: [PATCH] selftest/timerns: fix clang build failures for abs() calls
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrei Vagin <avagin@openvz.org>, Andrei Vagin <avagin@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Obst <kernel@valentinobst.de>, 
	linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 4:30=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> First of all, in order to build with clang at all, one must first apply
> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
> building with clang, via:
>
>     make LLVM=3D1 -C tools/testing/selftests
>
> ...then clang warns about mismatches between the expected and required
> integer length being supplied to abs(3).
>
> Fix this by using the correct variant of abs(3): labs(3) or llabs(3), in
> these cases.
>
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f=
9ed7d1c49f@valentinobst.de/
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

LGTM, even potentially fixes the testing post-2038.

Reviewed-by: Dmitry Safonov <dima@arista.com>

> ---
>  tools/testing/selftests/timens/exec.c       | 6 +++---
>  tools/testing/selftests/timens/timer.c      | 2 +-
>  tools/testing/selftests/timens/timerfd.c    | 2 +-
>  tools/testing/selftests/timens/vfork_exec.c | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selfte=
sts/timens/exec.c
> index e40dc5be2f66..d12ff955de0d 100644
> --- a/tools/testing/selftests/timens/exec.c
> +++ b/tools/testing/selftests/timens/exec.c
> @@ -30,7 +30,7 @@ int main(int argc, char *argv[])
>
>                 for (i =3D 0; i < 2; i++) {
>                         _gettime(CLOCK_MONOTONIC, &tst, i);
> -                       if (abs(tst.tv_sec - now.tv_sec) > 5)
> +                       if (labs(tst.tv_sec - now.tv_sec) > 5)
>                                 return pr_fail("%ld %ld\n", now.tv_sec, t=
st.tv_sec);
>                 }
>                 return 0;
> @@ -50,7 +50,7 @@ int main(int argc, char *argv[])
>
>         for (i =3D 0; i < 2; i++) {
>                 _gettime(CLOCK_MONOTONIC, &tst, i);
> -               if (abs(tst.tv_sec - now.tv_sec) > 5)
> +               if (labs(tst.tv_sec - now.tv_sec) > 5)
>                         return pr_fail("%ld %ld\n",
>                                         now.tv_sec, tst.tv_sec);
>         }
> @@ -70,7 +70,7 @@ int main(int argc, char *argv[])
>                 /* Check that a child process is in the new timens. */
>                 for (i =3D 0; i < 2; i++) {
>                         _gettime(CLOCK_MONOTONIC, &tst, i);
> -                       if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
> +                       if (labs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
>                                 return pr_fail("%ld %ld\n",
>                                                 now.tv_sec + OFFSET, tst.=
tv_sec);
>                 }
> diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selft=
ests/timens/timer.c
> index 5e7f0051bd7b..5b939f59dfa4 100644
> --- a/tools/testing/selftests/timens/timer.c
> +++ b/tools/testing/selftests/timens/timer.c
> @@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
>                         return pr_perror("timerfd_gettime");
>
>                 elapsed =3D new_value.it_value.tv_sec;
> -               if (abs(elapsed - 3600) > 60) {
> +               if (llabs(elapsed - 3600) > 60) {
>                         ksft_test_result_fail("clockid: %d elapsed: %lld\=
n",
>                                               clockid, elapsed);
>                         return 1;
> diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/sel=
ftests/timens/timerfd.c
> index 9edd43d6b2c1..a4196bbd6e33 100644
> --- a/tools/testing/selftests/timens/timerfd.c
> +++ b/tools/testing/selftests/timens/timerfd.c
> @@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
>                         return pr_perror("timerfd_gettime(%d)", clockid);
>
>                 elapsed =3D new_value.it_value.tv_sec;
> -               if (abs(elapsed - 3600) > 60) {
> +               if (llabs(elapsed - 3600) > 60) {
>                         ksft_test_result_fail("clockid: %d elapsed: %lld\=
n",
>                                               clockid, elapsed);
>                         return 1;
> diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/=
selftests/timens/vfork_exec.c
> index beb7614941fb..5b8907bf451d 100644
> --- a/tools/testing/selftests/timens/vfork_exec.c
> +++ b/tools/testing/selftests/timens/vfork_exec.c
> @@ -32,7 +32,7 @@ static void *tcheck(void *_args)
>
>         for (i =3D 0; i < 2; i++) {
>                 _gettime(CLOCK_MONOTONIC, &tst, i);
> -               if (abs(tst.tv_sec - now->tv_sec) > 5) {
> +               if (labs(tst.tv_sec - now->tv_sec) > 5) {
>                         pr_fail("%s: in-thread: unexpected value: %ld (%l=
d)\n",
>                                 args->tst_name, tst.tv_sec, now->tv_sec);
>                         return (void *)1UL;
> @@ -64,7 +64,7 @@ static int check(char *tst_name, struct timespec *now)
>
>         for (i =3D 0; i < 2; i++) {
>                 _gettime(CLOCK_MONOTONIC, &tst, i);
> -               if (abs(tst.tv_sec - now->tv_sec) > 5)
> +               if (labs(tst.tv_sec - now->tv_sec) > 5)
>                         return pr_fail("%s: unexpected value: %ld (%ld)\n=
",
>                                         tst_name, tst.tv_sec, now->tv_sec=
);
>         }
>
> base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
> --
> 2.45.0
>

