Return-Path: <linux-kernel+bounces-79888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A498627EE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8391F217AB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620204D5A2;
	Sat, 24 Feb 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="W7ynp6m2"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5536D12B82
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708812851; cv=none; b=KePkqdxPkbhefhZ8Hs3YUDAvsv2D/xHvlwhQuNy/G+3eX6DB1o5vwjhMC9n8W034X14XYpE92BpIlKJhipOpeLI6uHAva0pwfGvMPSgbnTSghKSkYdjLpuHXiVK+iwItMXVKW8zAClyLyktqmdbPjRGDjOVHyAWHD3oMsyHMk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708812851; c=relaxed/simple;
	bh=H7b5l4k9/6SZt3QJyEiuOu7Wd2+/s736lfq1d5HMfLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dn715RT0M/ISJkJlwU8fOS7QhBnDhGmL6iDQNg5bd2vhT0ZtnRsnZL4vr++Ue2eeQUo3v/LcpHC7/A9Hw7k7bXfFwYMzK2j551Uh9tZhQWtAnLH0egM5x15asrFx+2AFbAsQb4FHUJ0lk3XMS1UCm6qfRBTAmBxKgZzYABrP7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=W7ynp6m2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d746ce7d13so18020795ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 14:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708812849; x=1709417649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKKftM11Q8FUPYjtMVMlWVKIv3n23lTpjxtRvPGFQBY=;
        b=W7ynp6m2hW+ZQS1+Lc4aA/HbbCzZ7qH9xxsArNwc4w8ed2BRfa1j3NSkFusS8DafSO
         r5Vb6PDym/+IsIZ8325q8G6vcTXCnYCDKbcKWGsme2jlBisX/JZ+zJ+hOyKgh5vQOYHE
         WamnbT+CHaVblmzy5Pbhd89x687UZ//PWJVKnJhuf3wLU6E6eBHp/zsD2X47nysEXk8T
         wGzgfjtRos6i9rMSAwjj7PTVG2VfZCACW3qgbrzZjoWDCxBKD0nNGXXef9ACXmTefiLa
         gXgjkJiJQZG1LLY5BE7IQxWrUXeSX9WQ5vutXbd4woA3Jji/4aBKzM8jqUZ8/vsiQFyE
         DuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708812849; x=1709417649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKKftM11Q8FUPYjtMVMlWVKIv3n23lTpjxtRvPGFQBY=;
        b=IyvJ2FyzfzwO2+F4hTtuoFfrLfnscnlUpMpT3rriTza6Dn3aKt6g0khMDlZN8G0roK
         Oeo9OyLYpsjwl3tbBhiQreKV1a8C045DFwbsSta3gzEMeWTzQJJjJSAYcbNTUtyjkEdj
         1fkdKGKvri4TQtSu023JPNx7rtpLHV1g3v/TyKVwnCsvi7iI1Pl7Uo6QVcDaNNq60rEk
         F6cXLrpahyf+WTouhdOm60KG6eCiuOUicCYZ1RCxcZfpULON8UFv4m8SvNG2XBHV/3x8
         X88kBNDPgXOyueLTbQi++DAht2u+Wfh4WZQwvBfOpAmif1UL/9n6AiXxILVNYhrp4eek
         3dnw==
X-Forwarded-Encrypted: i=1; AJvYcCWwU/OfuOEDo1PhIEhQBOoWECNgFpe81y1XDbv4XrRTHAsnpgXM1O8JEtnbjwoIcz0NzdCBTVDvXCai9ZQQ8zUrf1N710z2H7L9DcfU
X-Gm-Message-State: AOJu0Yw73WTXB3KEgpZzwjTO5u2ZQKrfRgdCbG4U/w1kqXmpy+kdWC2L
	5wtQifY+2hdefCvbJo26l/TOtcpl4HvarARaW3qKGgeNsMCVMd57kbHrH/TTwia3oCfoNco+E+R
	h+tvlFHkHZ2E2vbEQiS1aJgQyHc0=
X-Google-Smtp-Source: AGHT+IEvm2XnjVvxcMKZldLM/QJ0hxIyCRdFdTmLuEgheCKTUmseUf1M9RKdujtLxbSu3kjdskuGi0vxj0PVFvmJWLY=
X-Received: by 2002:a17:903:2291:b0:1dc:6754:52ce with SMTP id
 b17-20020a170903229100b001dc675452cemr4501493plh.60.1708812849554; Sat, 24
 Feb 2024 14:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224213529.2601333-1-martin.blumenstingl@googlemail.com> <eb54b791-05d7-4eee-825d-373cc78df689@linaro.org>
In-Reply-To: <eb54b791-05d7-4eee-825d-373cc78df689@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 24 Feb 2024 23:13:58 +0100
Message-ID: <CAFBinCB6+=PThAUz+BdfeD+DqCpscw3pSwrK2pue+J07vhPh_A@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource/drivers/arm_global_timer: Simplify
 prescaler register access
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, patrice.chotard@foss.st.com, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 10:55=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
[...]
> > @@ -301,7 +298,7 @@ static int gt_clk_rate_change_cb(struct notifier_bl=
ock *nb,
> >               psv--;
> >
> >               /* prescaler within legal range? */
> > -             if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
> > +             if (psv < 0 || !FIELD_FIT(GT_CONTROL_PRESCALER_MASK, psv)=
)
> >                       return NOTIFY_BAD;
>
> Won't FIELD_FIT cover psv < 0 also ?
Hmm, I wanted to reply that it doesn't because internally FIELD_FIT()
uses a cast:
((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask)
My original thought was that the cast would clear the sign bit when in
fact (I think) it will not - it will result in the signed number and
BIT(31) set.
So I think you're right, FIELD_FIT() does cover it.

However, there's something else odd with this code:
We're dividing two frequencies (using DIV_ROUND_CLOSEST) which are two
unsigned values. So the result of the division can never be negative:
  psv =3D DIV_ROUND_CLOSEST(ndata->new_rate, gt_target_rate);
However, we're additionally decrementing psv by one:
  psv--;
So in reality it can only ever be negative if the result of the
division was zero (for example if new_rate is smaller than
gt_target_rate).
However, in that case we would have crashed - with a division by zero
- in the statement right in the middle of the two mentioned above:
  if (abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)

So I think we need another patch (it's best to order that before this
one): make psv an unsigned int and error out before trying to divide
by zero.
If you have any objections: let me know, otherwise I'll prepare a
patch tomorrow.


Best regards,
Martin

