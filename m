Return-Path: <linux-kernel+bounces-135861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4602789CC28
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD391C22120
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA208144D39;
	Mon,  8 Apr 2024 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9pnsVpg"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4361420D8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603013; cv=none; b=VsW4mD++tfUsGnQeKmWtPIeX8qEpArQr9c9Bf7oudHBeBQpwxIIOPw2DJNsHJaOrh2UCmioWwBrtk7jdYHOPCZmEIZUYjCz71t9ftiQeNw+LTOAKYnDtx2vAJguI8lSlH2rZc8QsB73Wr3eMr6nt6c1Z+xLG24EcaiV7+9xSVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603013; c=relaxed/simple;
	bh=0HC5mYPHz5gVrurl6w8jOAjdNy8i7VxysBO3RpMEL/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3Pn1p/ZrCbgO+OuMgWnnnzwyk+GZ69snassvg2kaoNoaZtAOCs1U0dLIIZPWOlingfLC3srjO5ffPfoMd8aT1S857KUxJRQ0r7xhe2ITp+Bhk4m8Nmn7El9E5aRxZwJcXA6eNyWZsGehQQG1kKXwN1ylvKFrfJ+U9utsSQb4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a9pnsVpg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41641a889ccso12835e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 12:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712603010; x=1713207810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HC5mYPHz5gVrurl6w8jOAjdNy8i7VxysBO3RpMEL/s=;
        b=a9pnsVpgg8Mk2yMnmZVUEnrdl4DdUCNE3o7lfskWNlCNK6+7zLoNisztIHiUhXTrM7
         ITVh5QMijQaIYHLsKPcbdc1+cRL1BjhLts/NhlxUOw3Mw3kfHvfu2dOzDp6tsFnj9oO/
         p/ZeFrb8CHHNk/QkHuWF6jjWxOAWLykgPVM2nveaxAnYhXv1zVIvZ648YZ9SpsgjOGb6
         s3gRWYJkuvL4ld3Z4r5UFf1jwl8dyglGl1WmkcCZdNwA7ukDXYMnpJGNvTl4AL7xwwfc
         MgSovzJ9GttpdG06K/I0HET6lBGyl0zfbsb4mrSahENloM+3GDdqMI9WXc9kJ0TzGmNo
         CcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712603010; x=1713207810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HC5mYPHz5gVrurl6w8jOAjdNy8i7VxysBO3RpMEL/s=;
        b=vstvKpeNscQMlGMySVWeCfbhgaXVwi+x8LgfWeTPO8AqGzNjv2C5Y+lD8Ic+szE4zt
         EhWMWsEiJize0bUb40emYLh06RMkP1tOfy03ibs2LThHKVEUlgqHGeR2TzIYWoD9RhBi
         zekDRyJR+g/1xO+U/TMTyYa8ON8MdXI690USyQqS0JHVcEUBKHmZQm5CieERQdMjry2/
         tXmbQsA4VXJ5kbUG8L5a1So4aHyyKSNFSTG0jTf7gFfikNSEQ2uueNAInYiXguLJMYcg
         dtDDU35OW4yaZ6muzVyWTlh4ea+yBwpgMB0pOKkn9Ujw93KgAPMPH0wzy2/Bo3D/43iZ
         YNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn61lz0dJ4jh6cBxGEw+XgoPbpGeXzLvaK0TPyWlA/08a7VdoBmzLKXYg8/3mgnZ3vPdFh+Kno9buVDo9uQmlfeWRQEqZA0bntjFJk
X-Gm-Message-State: AOJu0Yxjzhr+TNQYy3PA+bjGUkhZSobeTXK8Jvh5mzIYRWVIb2NmO+d/
	yjLp0PhCfH4cZnQBECm/v4ZN0tWLqmL7SenjuCpo5RDuNRFppvLaK9fv6evBf1Hf4ltc2HrFWkr
	KFfGgKe/9pxHqkgHAiM8twJx40dsiApqCam0=
X-Google-Smtp-Source: AGHT+IHjsReJwNnZwcwrj3ergbDNsoJTfOha25CxepNLW75WyxCSLMT2cP9EuT5lY9Lza3LOIM0cQDaEt8uc2pT6tK0=
X-Received: by 2002:a05:600c:4f8a:b0:416:6d90:38fe with SMTP id
 n10-20020a05600c4f8a00b004166d9038femr22455wmq.4.1712603009646; Mon, 08 Apr
 2024 12:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220710164026.541466-1-r.stratiienko@gmail.com>
 <CANDhNCpAhtgdwpSUTJ2jo2J5L6rHzQHVB9q+kkZ3ouTt12b-uw@mail.gmail.com> <CAGphcdnK8Hx-YsA-HukRKbvC-HpnLktCtq8qFicQUL-8ZHC+1w@mail.gmail.com>
In-Reply-To: <CAGphcdnK8Hx-YsA-HukRKbvC-HpnLktCtq8qFicQUL-8ZHC+1w@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 8 Apr 2024 12:03:18 -0700
Message-ID: <CANDhNCpN-MGXswfFV=mbMJBbHh919iTv9BMYFsk7bMgbZa1gVQ@mail.gmail.com>
Subject: Re: [RFC] thermal/core: Disable uevent messages for cooling devices
To: Roman Stratiienko <r.stratiienko@gmail.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	amitk@kernel.org, rui.zhang@intel.com, linux-kernel@vger.kernel.org, 
	megi@xff.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:59=E2=80=AFAM Roman Stratiienko
<r.stratiienko@gmail.com> wrote:
>
> I haven't worked on it since I posted it initially. But it looks like
> there's an alternative patch already upstreamed and backported into
> stable:
>
> https://lore.kernel.org/linux-kernel/CAJZ5v0hHTuEXmQA=3D0D90eR_KUsOsfcxYb=
TS=3DzQYDTXuY6o_K_Q@mail.gmail.com/T/

Ah! Many thanks for the link! I'll check in with folks to better
understand if there is a functionality gap between what you submitted
and what landed upstream.

Thanks again!
-john

