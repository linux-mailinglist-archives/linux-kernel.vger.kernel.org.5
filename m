Return-Path: <linux-kernel+bounces-108193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA7988074B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018B3283E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EAD5A78E;
	Tue, 19 Mar 2024 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofVfAAXS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0467B33CCF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887407; cv=none; b=Bnpz8dnm9LAIpjYeBy2RPTI+VXbmRseJYjDTsu2WPBEWaC53mY46C5ryb8Ud7K+vPSYxwDwzVi8DiHICoVZ5bDB+ChWWdXRTZ6tg8I1lBgjqE/Hk+gbBaOeMjgo3rrJ+0CeEt7xHbU1MNXWZ4cxBtQ9reWUlVEvaEVQCjgdK70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887407; c=relaxed/simple;
	bh=wtbRGprG246JSinZ1zeJ0g2NwwsbkPDYzZmmC7vbRTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3fjfDW0TCXNewgd3CA+WWnxH3YLRYCS7ygN9+PP5ypsnRdeVT3h4dRBCl+ZeE9JGz/AxBoJMFIz+HanBvWpbCE1m8hovE1pWQWQjQ2V8SVXOBeNGH5u2HsoLdKqdziRNK0lO1+uoXvg7vGm88pwuLKCR3UIfn0WZlJUDu9An9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofVfAAXS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-413f8c8192eso38915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710887404; x=1711492204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8EtD8zegIhUQWzA/oDS70j+Z9o9c4kykZ4EUai9up0=;
        b=ofVfAAXSVDz8umrvv14pK2V/4/3P3kzsOjuxfKAom8Ki59bDmUAF1ZZeWjIBSUQbKQ
         OfXIJR+vPGDajLBH9qCmNiEbA/7RtRlba9C8M12whYQ7Q67DVEqA9GaoZs0lhuWOpVsn
         inK1zngi7gQ3VUaCl+YdO3Br3OP9NWCD/Hr3L3Y7i6AeaQYmq5ZHTl/gBOsxC5D8xsrA
         UjLIBbcUUEjz+IYZaereQMCv89gJ6b4wMcPFly4nwrKNvTVIH/+kesT7ruQbm4BCG0ON
         Ho93su6n6Xp9Bt+rc1w4GoRvH5It59jwEoy0Cxl4snlxWSL2R+YpWUfjti9Mx8VlOOe1
         WgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710887404; x=1711492204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8EtD8zegIhUQWzA/oDS70j+Z9o9c4kykZ4EUai9up0=;
        b=C06mW7ioBvwoKxXX60Ptscvyr9FxfOJ/dllg4GEaIAGnPsxJvAgdulv8YIW+VbTIp9
         JQPAOmabtW23my/H/3g7JQ+fkTlJKNvtdCQ9UksJpvzng47pPQwgx8bUBFVUPdCq5n5A
         kW7yfM8uz/gpLcXlckDrs+cOqbhD4AgD7zzgQHfRKjLAKo208zhjfrnVZl4+MkTVnMle
         WN2VOUetfo5mPTyZKh08p5658/vq1bP0sr3m3H/HRY+ioSAQ1bySKX2tc7bKSroteU2A
         L4LvbmVMtdv3xv5nst31BGqDTt3EdnQYJi6LP/RwQBBUT+ZOSRiIIOcmA53WL6t5Uij+
         Odng==
X-Forwarded-Encrypted: i=1; AJvYcCXKEaRQSk5nPTrJuPe2+MgscfnbbWpQoOvsVFT0TwIKn5KG4C9lVwFMZCEsijKDdO9sY7Pum4yBhJQatx91LBPI+mammbwUFa4IQodM
X-Gm-Message-State: AOJu0YwaoW0n+1ZPknmJewBqHR/857P4j5yL9NB0kLff6hpLwEXUYMYg
	hgWNklru7Yqj/L5ZkckowoOWbN6UNYRkSAUH48x6pWxx2WST4je0Q1vFkCpKntcBXuWjxkmgts+
	QjACldr1qDGJLJD7UYY19Vhm/ay3/6fTTzpI=
X-Google-Smtp-Source: AGHT+IFnGQzm4jMjcrzDlbzN56akGGgkj3uAyRKTIsnW0UhcIBF+MbiMv0KxT6M+rBMt9Ny+pOt1FU4BU9vpN+72B78=
X-Received: by 2002:a05:600c:3051:b0:414:1ee:f399 with SMTP id
 n17-20020a05600c305100b0041401eef399mr89401wmh.2.1710887404353; Tue, 19 Mar
 2024 15:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com> <20240319130547.4195-3-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20240319130547.4195-3-lakshmi.sowjanya.d@intel.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 19 Mar 2024 15:29:51 -0700
Message-ID: <CANDhNCpP6Nd_iYtdgW+RyH1g7c-eyHR+j-LV4gv8rKWu9QkzhQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] timekeeping: Add function to convert realtime to
 base clock
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, giometti@enneenne.com, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, x86@kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	andriy.shevchenko@linux.intel.com, eddie.dong@intel.com, 
	christopher.s.hall@intel.com, jesse.brandeburg@intel.com, davem@davemloft.net, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, mcoquelin.stm32@gmail.com, 
	perex@perex.cz, linux-sound@vger.kernel.org, anthony.l.nguyen@intel.com, 
	peter.hilber@opensynergy.com, pandith.n@intel.com, 
	mallikarjunappa.sangannavar@intel.com, subramanian.mohan@intel.com, 
	basavaraj.goudar@intel.com, thejesh.reddy.t.r@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 6:06=E2=80=AFAM <lakshmi.sowjanya.d@intel.com> wrot=
e:
>
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>
> PPS(Pulse Per Second) generates signals in realtime, but Timed IO
> hardware understands time in base clock reference. Add an interface,
> ktime_real_to_base_clock() to convert realtime to base clock.
>
> Convert the base clock to the system clock using convert_base_to_cs() in
> get_device_system_crosststamp().
>
> Add the helper function timekeeping_clocksource_has_base(), to check
> whether the current clocksource has the same base clock. This will be
> used by Timed IO device to check if the base clock is X86_ART(Always
> Running Timer).
>
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
> Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> ---
>  include/linux/timekeeping.h |   6 +++
>  kernel/time/timekeeping.c   | 105 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 109 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> index 7e50cbd97f86..1b2a4a37bf93 100644
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -275,12 +275,18 @@ struct system_device_crosststamp {
>   *             timekeeping code to verify comparability of two cycle val=
ues.
>   *             The default ID, CSID_GENERIC, does not identify a specifi=
c
>   *             clocksource.
> + * @nsecs:     @cycles is in nanoseconds.
>   */
>  struct system_counterval_t {
>         u64                     cycles;
>         enum clocksource_ids    cs_id;
> +       bool                    nsecs;

Apologies, this is a bit of an annoying bikeshed request, but maybe
use_nsecs here?
There are plenty of places where nsecs fields hold actual nanoseconds,
so what you have might be easy to misread in the future.

Also, at least in this series, I'm not sure I see where this nsecs
value gets set? Maybe something to split out and add in a separate
patch, where its use is more clear?

> +bool timekeeping_clocksource_has_base(enum clocksource_ids id)
> +{
> +       unsigned int seq;
> +       bool ret;
> +
> +       do {
> +               seq =3D read_seqcount_begin(&tk_core.seq);
> +               ret =3D tk_core.timekeeper.tkr_mono.clock->base ?
> +               tk_core.timekeeper.tkr_mono.clock->base->id =3D=3D id : f=
alse;

Again, bikeshed nit: I know folks like ternaries for conciseness, but
once you've crossed a single line, I'd often prefer to read an if
statement.

thanks
-john

