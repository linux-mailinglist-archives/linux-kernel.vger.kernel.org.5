Return-Path: <linux-kernel+bounces-46670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF6284426F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F261F28A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B4712CDAF;
	Wed, 31 Jan 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrOWstsS"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C18288F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712920; cv=none; b=Gqr2u0TyAP8LgJwmfKckbzrRtbxNiL6HGCflU5gLhdFuz0Y3aEpInxx7rpy73UNb9qGNnNmzqX6+Unl8VtRbFgNGl0mzOpM4QGvJOuWp91joxCRy2zUMQ2qlpUGUdr7+KmMmv2Ed5ufSYNM+Z5Fl5CRbErN7b73T8bgTnL1eQl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712920; c=relaxed/simple;
	bh=uvTHxh/nXl9P4aUCBRM/c+7M4xUmbtRtBKYSCX2dtWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6m6viU6jf/QLy28RYZLP+HraMQeIgS42yaO5HqwqGJ+kTgRTMCL9bmJk3zepvoezjxjqDQLHEP5cvoKn6Tq6eirwqbzHGxJCkqLNmCbKOND9SbvX9uSXzoIjsVEzKFdRWODscAx3lMDxbz85StwD+5e9SNBCliMfklL7XrXrIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QrOWstsS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-295b34cea31so1315906a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706712918; x=1707317718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvTHxh/nXl9P4aUCBRM/c+7M4xUmbtRtBKYSCX2dtWM=;
        b=QrOWstsSQrdZoKHOqZBSU3l1Q2p2Rd4jM8+Es1LMbNPGkkuWy/xiDPLhrQgN/KmTUJ
         iSXUtWT2USHtXUSyr9X87NrNiD6FRl2m680GEo+ln2E29iMmgENkzActGqXKEA4MGcs7
         Pb3ypgKLCwfCuCwu+vcGU1K8pBOe6HK+bXezI/j1+khr1WeB7ou+PiGQa8oW5Bnfzwkn
         lLmivP03w8yqRIz+8E6jAamArnvOZ5+qa1x0O29A8SZkfZwEgx8TmtgeVecBPx2gIIIc
         XrVw+hWlX/tcf7Eyy3D0WpmiHHEqK/awBId+ZZAvwD53esaBMKPp9GiDRyxEBM83RiOm
         Wzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712918; x=1707317718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvTHxh/nXl9P4aUCBRM/c+7M4xUmbtRtBKYSCX2dtWM=;
        b=qDndYiekxVh9PtB5Ty6cvHK77bChmvR4CQnRz8679/fyN8OVhw4434xzsqsUU4njSM
         vvVNsEAcJGGPoNSIv+x8QnBYoqmeZVWLp6wgEQaNbuN9Q4yfeajz6A9iut+9dhQkLVFi
         Mc30v78e1WRG8UJm6J9ykTtakidOKq38ZEamfUetBo19bDFL3ykp+gywLmpL5sCdgzPS
         lBQCLSyGhg8UlwiaQA99TcvETYOKv7C8AP91EtD72+jQJl10MQU2wVpC89+GHhQ2hPJ0
         GdEiwGAjIvzHZ4dQn4Kedx1ulan8/KkMwkwu3YIHsjooRbEcYAVtD+mSjzQzlnf9Emol
         FEIw==
X-Gm-Message-State: AOJu0YyAMRkJLV7TYEY3pg1SMxiD8D5Zq2TBM9u3L/DOcNt4OFQPd5Wu
	I/KjHiK5/5xtRdpyMwgvpkKSyDOAi3xfzkufztNXwXCZWxeRB7BirfSGnldqKjZ/bXzBAkxFNjZ
	fJ5y0xwjA0ddir0Iy4F7o9lxnwBj2ZZYHzSPWxA==
X-Google-Smtp-Source: AGHT+IEtURmFYpPr5n0qmkXA1oNesRmycvQ6OXB+xP3DOmVMhj7X6eCSiM7njnUh2JGL4NBG+Bxx5TrLUuyPqqSlRK4=
X-Received: by 2002:a17:90b:382:b0:28f:f70b:a272 with SMTP id
 ga2-20020a17090b038200b0028ff70ba272mr1970405pjb.21.1706712918181; Wed, 31
 Jan 2024 06:55:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117190545.596057-1-vincent.guittot@linaro.org> <CAK4VdL3Bg70ycz5vd4RfwNYa3KcYU8rdPX==i7znzQFw_EgTjA@mail.gmail.com>
In-Reply-To: <CAK4VdL3Bg70ycz5vd4RfwNYa3KcYU8rdPX==i7znzQFw_EgTjA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 31 Jan 2024 15:55:06 +0100
Message-ID: <CAKfTPtByDJxQEdBwYkpj1G=sgm8FOw4FS17yMbEbz=on95TP9g@mail.gmail.com>
Subject: Re: [Resend PATCH] topology: Set capacity_freq_ref in all cases
To: Erico Nunes <nunes.erico@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, ionela.voinescu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024 at 14:56, Erico Nunes <nunes.erico@gmail.com> wrote:
>
> On Wed, Jan 17, 2024 at 8:06=E2=80=AFPM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > If "capacity-dmips-mhz" is not set, raw_capacity is null and we skip th=
e
> > normalization step which includes setting per_cpu capacity_freq_ref.
> > Always register the notifier but skip the capacity normalization if
> > raw_capacity is null.
>
> I bisected an issue of cpufreq no longer working on v6.8-rc on a TI
> SK-AM62 board and it pointed me to b3edde44e5d4 ("cpufreq/schedutil:
> Use a fixed reference frequency").
> This commit does fix the issue but doesn't appear to be merged
> anywhere yet. It would be good to have this fixed before 6.8 release.

Greg has queued the patch which should show up in the next release of
the linux-next tree

>
> Tested-by: Erico Nunes <nunes.erico@gmail.com>

