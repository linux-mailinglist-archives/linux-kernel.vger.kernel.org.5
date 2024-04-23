Return-Path: <linux-kernel+bounces-155581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B528AF457
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823591C21FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA0713D27E;
	Tue, 23 Apr 2024 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VDN4tGw7"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB31C6A0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890254; cv=none; b=PF2i2c6PpXiDl2qubyH5meozqMTPpvmIhWf4mKOtrAp2QsUpLMsc8IfO2ByXCNnOE0Z/NIh12VoDyj5LVjI82y44pb3xK5y0YrPZQ5QcIbZBpXQ9bSiUjbVWIfTXMCWavMyjAtulK6i7PsmTjxCkvLOrjk4ymyzZtROMO937kWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890254; c=relaxed/simple;
	bh=bVqr/UHJsQYfjpIFdbjqCtbPtG1Cdn8rAp1ojwEtgqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5NpM59YjgwHNNNnmJ7n400PQ1KYRWlLegnXKTsXN74G3LRUnptIHmY7IM+63M5rUdCyh2mgSmpxjUJRBFEmg9tQAxu0AJte6od5Sc/Wbx2Gg4siSHPD3mUasW09bAiFYBLEiLWcazPOUlGGlIyVZR4j1LGWznlVTEUC33LAy9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VDN4tGw7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51b09c3a111so4131799e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713890249; x=1714495049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xlPNa3LQZABLSUUaNRkv4uhiNmomWFCxtHuSkH0weN8=;
        b=VDN4tGw7YfKGmooKf1kYsYcMQoe6WEhVySlL1pXpQOxiLrJi6tJfE+r7f9DhBikRZz
         syiGQWrRGkhaU5q/kkJpQKZMoXRxW/Uzzte6ymzq0gfK7+Om8jR4IlGrS/vLQI1fdMIU
         hBN9DYIkunPzyRkiCE7Apk9kSlEkb2wVVyZ2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713890249; x=1714495049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlPNa3LQZABLSUUaNRkv4uhiNmomWFCxtHuSkH0weN8=;
        b=PB9kRMNd/3+CP/sKtMDnfVlUJ82a1UgEbnUKtYLGqEwlPFU6vAS8NmWwHwGlwYX9A9
         lYTPJ9VPiBJprXmc1b5XH4lF7O6JoEQrgAh53dRXKNG/uAK4nCeLedEdZ3PevgfGpgfE
         8ujQfG0DK4yuhpcXsN/NtitYb0MGrIYa61cYnWfcx83Xvvrnxn6km5KhBM+QqxGDSZCE
         un0CvUZ3KO4A0swyjG2mwE35++3gif/2cWZAbMg41gUIXtELR7Bx6AmF+4Ae1VAR3F2+
         co6+Sfd5SIE0FKu+Y/ipDrN/jL1L08oczEk9s00l7OWZmn0alSqUqQsM2FhJ/Z7fLDa2
         8aUw==
X-Forwarded-Encrypted: i=1; AJvYcCUwDhsmZw9D5A64trVgS7iPdQ+1poaoh8owhxxTV1NzbvCLHgT6vBCY75m5zxQVrkKE2BcgixIxfu9mSX/XeiDYa7AzUavb3IZNM8ri
X-Gm-Message-State: AOJu0YxnzPSrOhXuiwRgORnCezf7Qv/lQStknqLjHH8evjaWTMgY6yX9
	0ByYTRxea4XMUk2nBr4EA1qKgS1z321AMXY1vR2MzBarXI4W1VWp0rTUPC8cAM0/WgvhSk9PEYk
	buEHPIw==
X-Google-Smtp-Source: AGHT+IFPKF6wUBQxjgd/k6BT+MZOtvioYA8zt3bRLYSQZ4rTnTp0WMb2+kWsa+cI+V9bNv7L5tee2w==
X-Received: by 2002:a19:550f:0:b0:51a:d1dd:281c with SMTP id n15-20020a19550f000000b0051ad1dd281cmr53051lfe.26.1713890249182;
        Tue, 23 Apr 2024 09:37:29 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id o30-20020ac25b9e000000b00513d1e9ce7esm2068728lfn.90.2024.04.23.09.37.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:37:28 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51b09c3a111so4131734e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:37:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsjIzIa/T07udph7xaZzqyyctF7NI+XltYq3o09EH+1BXaNQZJOFGO0nLqTEVFO4YAfTBC5oAtntaTSoLgBmfXYrOTNWn0Ai+wPG6O
X-Received: by 2002:a05:6512:3a93:b0:51b:14f9:3f1d with SMTP id
 q19-20020a0565123a9300b0051b14f93f1dmr64343lfu.30.1713890248006; Tue, 23 Apr
 2024 09:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
 <CAHk-=wjEZvnn51dhhLqBKUd=cuFhbYA47_OyfUOPB-0zKToL7Q@mail.gmail.com>
 <CAHk-=wjzqaqcicTtWfBtXyytJs1nqjJNved2JFsLVsVLYgVkuQ@mail.gmail.com>
 <CAHk-=wjW3PdOZ7PJ+RHUKRc8SqQhcWXCACOvmwBkKUKABHKqwg@mail.gmail.com>
 <6103a212-f84f-4dad-9d33-a18235bd970a@I-love.SAKURA.ne.jp>
 <CAHk-=wgjZ0DJgeo5Sk-Kc5vw8TXGuxXftPV79Wv221ncstk1tA@mail.gmail.com>
 <CAHk-=wg+hJ9Y8AKjp9qD7E_-pgBFdWGLiqzi1qth8LNpuST1cA@mail.gmail.com> <563ec0ed-a851-450b-aed6-986f6ea324ca@I-love.SAKURA.ne.jp>
In-Reply-To: <563ec0ed-a851-450b-aed6-986f6ea324ca@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Apr 2024 09:37:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wge_xT33zVY21rk4Le5xyPitiSFYL=qJ5NNwF-F79PJDg@mail.gmail.com>
Message-ID: <CAHk-=wge_xT33zVY21rk4Le5xyPitiSFYL=qJ5NNwF-F79PJDg@mail.gmail.com>
Subject: Re: [PATCH v2] tty: n_gsm: restrict tty devices to attach
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Starke, Daniel" <daniel.starke@siemens.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 08:26, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/04/22 1:04, Linus Torvalds wrote:
> >
> > Actually, another option would be to just return an error at 'set_ldisc()' time.
>
> This patch works for me. You can propose a formal patch.

Ok, I wrote a commit message, added your tested-by, and sent it out

    https://lore.kernel.org/all/20240423163339.59780-1-torvalds@linux-foundation.org/

let's see if anybody has better ideas, but that patch at least looks
palatable to me.

                  Linus

