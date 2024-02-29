Return-Path: <linux-kernel+bounces-87186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A70286D0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F267828AE47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64AA7A138;
	Thu, 29 Feb 2024 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rd9MhTOI"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6045C7829A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228194; cv=none; b=BVKdBB1ygPcWkjKmxmJl5q7PkJFTIU5wivOoP4nUQKuwGBurPV6mO4ws+clvcALWzX0IZyJZvbdWXcRn84cNNzJNTr8LdIDZBe3mIu3FhjbiduE5NgO23KcYwi3dkCAx4WwQJ0SGasyV15cXkx00LQ0VYM3E/Rtji9OpcrcVgw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228194; c=relaxed/simple;
	bh=XxtJ7jXJTjPlR4mstnG7fJZz2zY0A00CPFRcejRX8R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFpqjxYjNuuit5SnTaMd4UMKqFqlBeqbDvscljuJgzimjuFoTj3Az+AXB4LFgK766J5DQmFIY1sQYSWNbrzIZkh8Po+bha2YcRbhvhXTGhadhT5BnhWCnbphxR67tKqHS+mj0g6/7CGtjd1R5Gzm27taQGYAnc+IVgmOle/HRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rd9MhTOI; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so2298073276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709228192; x=1709832992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq8+vF+sBJbpatRsF/qs7fhGnn/m6N9DS5GfYF//cWc=;
        b=rd9MhTOIipPrUeu5bjQUrM9Zi8GwyqlAbUOR/MJTgYaREsyXRCOdSHR2T5Xppn7XD1
         TAzvQZLaT5W9uF8qyfC0r3SJLY9FFauPKfzfNhnKCP/7qJe3zbqBmuv7dnU9YaIWDLsA
         vosCdv9I+pblRWvGUulN+X08G1wKwfVsze62+h3yV4HD8cgtZOMf4e3yh4y08irfFUBM
         +kES4+Cw+sKYnBEZg9AWYbRXx3dihAD4aeoZ8GvhcHujKikHOeSTjuCKS1AcR5W/vDiA
         Q0fLKJ23NbevUvgPyY1Gu3C++O0YhILb3PYvLs2mSAjlCq9zwy3SY/QUxMcLyzQTedXQ
         dUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228192; x=1709832992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wq8+vF+sBJbpatRsF/qs7fhGnn/m6N9DS5GfYF//cWc=;
        b=wtn+OuxqOYjg7rtXQq0CNw0rbyeo9Q8U/453cxkHFC61FLKkCtIczf5Wd9KgImLZEP
         /e2kaXJqLU7+6Avs8doPtL5hcbRcPqC1srTYEk+4CrBTc8FgRJO+wCJokCuspaha8dan
         4m4TF6383FNcqWMf8LTSL/X3lVnFJImz3dDeoj9pC2aoLVCDUo+w5LIcohU1robXY/OM
         SReml7Nm+TGEX0ex/V7XRuPB75cQqoyGLUMKeESS+D/i1qiwlpFVgmsRD4Q+beGz0s5a
         fdy1Rlys707dyj7IAQwTt9sSh4Ya6t3na5VOtF6UdCAqLpNo8bpUXrOxZ1ieEagxSbn8
         8i3A==
X-Forwarded-Encrypted: i=1; AJvYcCXsF3rOdIno0vQuKiNRsfi+CnYjIBZTvc5X8PcSQfkLosk/roetszk1h6Xe2RxpK/rak2VeXejb10bNHy8PMhpW+iN4VDovHh/R0Bq+
X-Gm-Message-State: AOJu0YzpFzOeYW2I5PB1rDN/77NGDyf947/TLgPAjyN1VKgi0xwUNl73
	8CK5PiCrcfM+uU5r8SUvRLMEBrA38ho+Y2wpw8Fz+41nw3y3op+M6qWMDor2W/6TShgR4x346aa
	/MygQtDmd/6LcoI3jVtnb6q+oeur8M8bKY2xP
X-Google-Smtp-Source: AGHT+IErWnCnjkIf5zZiARbQN2JZLq+/wJWUBjtZ9tfujESUi10WDrJhd5YqzjLadSeVYcHUQ0BM/vuT9ii6QjoGaTk=
X-Received: by 2002:a25:ac5e:0:b0:dc6:d1d7:c762 with SMTP id
 r30-20020a25ac5e000000b00dc6d1d7c762mr2020807ybd.11.1709228192148; Thu, 29
 Feb 2024 09:36:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227121920.1905095-1-usama.anjum@collabora.com>
 <CABdmKX39M6e7o_Ossyy_Yg-CYQd-7piT6DmJk8ffEU9pPpP-8Q@mail.gmail.com> <5843852d-7353-40ec-b36d-7d2502fc6a83@collabora.com>
In-Reply-To: <5843852d-7353-40ec-b36d-7d2502fc6a83@collabora.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 29 Feb 2024 09:36:20 -0800
Message-ID: <CABdmKX2m1C9A09V=JZyoBXHaQ_5yW2p7Z58U1Fs_izO3Oxe_aA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selftests/dmabuf-heap: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:03=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 2/28/24 11:51 PM, T.J. Mercier wrote:
> > On Tue, Feb 27, 2024 at 4:21=E2=80=AFAM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >
> > ..
> >
> >> +static int numer_of_heaps(void)
> >> +{
> >> +       DIR *d =3D opendir(DEVPATH);
> >> +       struct dirent *dir;
> >> +       int heaps =3D 0;
> >> +
> >> +       while ((dir =3D readdir(d))) {
> >> +               if (!strncmp(dir->d_name, ".", 2))
> >> +                       continue;
> >> +               if (!strncmp(dir->d_name, "..", 3))
> >> +                       continue;
> >> +               heaps++;
> >> +       }
> >> +
> >> +       return heaps;
> >>  }
> >>
> >>  int main(void)
> >>  {
> >> -       DIR *d;
> >>         struct dirent *dir;
> >> -       int ret =3D -1;
> >> +       DIR *d;
> >> +
> >> +       ksft_print_header();
> >>
> >>         d =3D opendir(DEVPATH);
> >>         if (!d) {
> >> -               printf("No %s directory?\n", DEVPATH);
> >> -               return -1;
> >> +               ksft_print_msg("No %s directory?\n", DEVPATH);
> >> +               return KSFT_SKIP;
> >>         }
> >>
> >> -       while ((dir =3D readdir(d)) !=3D NULL) {
> >> +       ksft_set_plan(9 * numer_of_heaps());
> >
> > Shouldn't this be 5 (one for each test_alloc_* below) instead of 9?
> This number 9 doesn't represent number of functions. It represents the
> number of test-cases. One function may have multiple of these. (Hence thi=
s
> number is equal to the number of ksft_test_results_*() functions calls).

Ah yes, thanks.

