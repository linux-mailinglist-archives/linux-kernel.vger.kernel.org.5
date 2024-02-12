Return-Path: <linux-kernel+bounces-61939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63278518AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148451C21CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A25A3D0BD;
	Mon, 12 Feb 2024 16:09:48 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330343D0AD;
	Mon, 12 Feb 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754188; cv=none; b=f47BFw/MLXaPCmG21yGiB3DGMVLwnpaa8o2rgn8KRWvi96CYRK3RgXhTZPjopsXWpzHOHbil0WVaSyAfXexK53YD/UyQPFZYScunxTNu4pWgxUtbPtuyGGzr+vW9Gt3DW9xECbTNAHma4ktUuEGsdvj6myHPn49Gs62c04Uhmp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754188; c=relaxed/simple;
	bh=WSZs8xa+WI8054UfUvFjQl73JxvCck5P/K79KrcpSM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2CoGYntxu/FT/MfHddMDSaDChZXAh9wb22XzJ0XmZC3w4g+AXm2S4xgXYgDLj3wiDieQUg4c5ljQ2yuwv1w4LAEk/oGA/PbFEQBLQ9h2esV/jGR9BVkaTVVs77CCAzxoXXbPbYxX9H8AGUHDk8e2t/Uu05sDmSDnjUi7GBPicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59a24bf7cadso1131234eaf.0;
        Mon, 12 Feb 2024 08:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707754185; x=1708358985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5e0qLsgbAC04Ea+lUsuUQR8n5Q6fLgOHYw/TRDHBms=;
        b=UdcRlQbDLVoG2q9YvV7/CTVliZR4GO7YSQ3OCPMoBWFnHyqqAz+BHyZEOb72JmA4qJ
         4AYgRLwzMVaFrzndlfpYJtAP5wSt9VjGjxwjGtbxvnYZgujb7H+FpWFVowijTUyHi2FL
         0kP/ov5OojXp1fEtbsg4aCOP7sq0e7vAVPl1c2Lsi1fvQNpciY/0uEQ5iAS0tipxTFo+
         Kf94K623m6xqPya3PI1wlIeOyhvI2sOWQIElTju0k2TNRRTqYxnsei+wm7xClmuXouXK
         t9UfJQ772zKkQ/+5faSLVdKPPFBHZIfzMerEub/0OHoZYvp7YvSmoxtda3R0JgW3rsg6
         xQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2ruGcvPgRtfZKuaNysmeE/8MPhPa4RzXZz+Kwbx7bqhwXiur2HuTbTUeTCG1cODPsWrW0uMoVLm6KGYMRV7tq+n2NMF8/fhC+fZ10A+e4Pt06Jp3g7BiKD/jR/jlEFTNFwZh1Q88=
X-Gm-Message-State: AOJu0Ywytprldsk4YtVqItSGAIkPH4SUvF1G0vOFKFFTGdNRBP2m1Eg5
	bWVTPGO0zCV3OEcIn5pJKoYjYgQD7e5TTqhx8AImustcxysLgi9n9pRGs3PFDLs7my0M9qw5ZaV
	jTqruHP58d2r+Cc1M9x1rgthYVrg=
X-Google-Smtp-Source: AGHT+IFiKd1X5QT/b8mqARYA+9uqMmrsDSU9HFZBpkHGxmWDJQUSetX+LEKcJj8u2LCCtG8xB5vxv4lGuf7M2mVTgOo=
X-Received: by 2002:a05:6820:1f8e:b0:59c:eb7b:c04e with SMTP id
 eq14-20020a0568201f8e00b0059ceb7bc04emr5091034oob.1.1707754185267; Mon, 12
 Feb 2024 08:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219031444.91752-1-bo.ye@mediatek.com> <e23ebdd8-7fbe-435b-a850-0ef18a51b020@collabora.com>
In-Reply-To: <e23ebdd8-7fbe-435b-a850-0ef18a51b020@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 17:09:34 +0100
Message-ID: <CAJZ5v0h=OKnY85EF9Mg1irsSbnea+P9oAQAdQURqjn+6_5s2PQ@mail.gmail.com>
Subject: Re: [PATCH v2] fix overflow in idle exit_latency
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bo Ye <bo.ye@mediatek.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	yongdong.zhang@mediatek.com, C Cheng <C.Cheng@mediatek.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:56=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 19/12/23 04:14, Bo Ye ha scritto:
> > From: C Cheng <C.Cheng@mediatek.com>
> >
> > In detail:
> >
> > In C language, when you perform a multiplication operation, if
> > both operands are of int type, the multiplication operation is
> > performed on the int type, and then the result is converted to
> > the target type. This means that if the product of int type
> > multiplication exceeds the range that int type can represent,
> >   an overflow will occur even if you store the result in a
> > variable of int64_t type.
> >
> > For a multiplication of two int values, it is better to use
> > mul_u32_u32() rather than s->exit_latency_ns =3D s->exit_latency *
> > NSEC_PER_USEC to avoid potential overflow happenning.
> >
> > Signed-off-by: C Cheng <C.Cheng@mediatek.com>
> > Signed-off-by: Bo Ye <bo.ye@mediatek.com>
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Applied as 6.9 material under a different subject (cpuidle: Avoid
potential overflow in integer multiplication), thanks!

