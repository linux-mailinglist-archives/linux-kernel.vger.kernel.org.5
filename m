Return-Path: <linux-kernel+bounces-56783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A927884CF19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FB31F222FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176C87E775;
	Wed,  7 Feb 2024 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOkQYHM6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66204811EB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323959; cv=none; b=Eya9lGRLjmNEX0DGaV54dKpY78JMrmARHPiSt0mZe/gv4B4VkiFbgUNUUzOsArQ7QyPz9J0Yz1/mzPaR+ICgpShuf1tiUIyN/NFB4KvE4Ny24CvWDzVgoOIlCW1rIpCuXxdrxGRRIp/LYeXNM7lCpt7sjHfurBjqEFKd8HtZuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323959; c=relaxed/simple;
	bh=VClLQfkmwNHlgWpWvEFolbCHf6+5KVH8rjR03BidlJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVzt+udQU0SvrSzVNG8GVLgetqfz0w7IoQHIHPNNnPTn0QCBCk605Ndmfa7syg2zZ1IWOkrNQrTwrb1GqefhdSohbvXAnbab7+RWRayoArXdppXXGs3wj4KxjVSCGWuMnRrschn2JpfziBmmG2axQFqRGuwQTm8HadFb99da81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dOkQYHM6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso8265e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707323955; x=1707928755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VClLQfkmwNHlgWpWvEFolbCHf6+5KVH8rjR03BidlJw=;
        b=dOkQYHM6yWvVqSdfm0kpojoGFK4ojGQxCju/JDTrg63lbA3l/n1fJZV3pF/G/qptdQ
         2a0RtJHU4zuQu03Pl84YLUgweRB8RBKh34kg361P1jrF56Fjb1o5uwja2Ob/n/pIOd8g
         CQRmKw8dFW32lbX4fkUYhwd792q3njyT597Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323955; x=1707928755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VClLQfkmwNHlgWpWvEFolbCHf6+5KVH8rjR03BidlJw=;
        b=cR9oUxJ2gZy5a9zGR+baQ0r9InGME2wL6Ilj5unGBbxf/D8oxmKGzhsWtiNQDlJdJt
         lbYgrThHGpsBwDAcNfWsiuY+e+0+jkjG+Q/FmfVa1T4wAvvXMPi4zxlxpL6LoFxPSALz
         2iDAByewBZVzruoAqkNizmTqCkYiQwhLkR1FCsVc6CG1Fh57W+/ykeYZW+R4TFGtbswm
         GYCdCk9tuhbUKkKj7Qx/XDVcDQ0TEoKq1CkHp6NZlPZboK9zhRdy9aJHf8pyeNiO08SU
         t0OQd5tGvOiUP83/p7DxmCKiK1ZCNRKaLY3XEW67X4qsY75/mhr++5WW1yVs7SLXVoe3
         LNmw==
X-Gm-Message-State: AOJu0YxE9UKc24qy3vYBjxCdrzGnJIrUFLc+j7CvFZS5+vJTGYFveHxj
	NhifoU+xWoprbhb3YZh5M8tIX+1swTcp23q4R/G6v1E2wHRTRcHm+CMWcs83f8sHbQYMKz49+te
	jEtxt4hZ50GUocc3opbjuijtB1NnkBaWV3LvF
X-Google-Smtp-Source: AGHT+IFHgq21oXoCxOiWIBFBqj4JaHe2YOSpxCURnMqhZTe1YstQ+GevJDe+Y6FxdER8sqwVvicQlyOyYmsylrqnVlU=
X-Received: by 2002:a19:e056:0:b0:511:6922:18ee with SMTP id
 g22-20020a19e056000000b00511692218eemr12432lfj.9.1707323954929; Wed, 07 Feb
 2024 08:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102075243.1.Idb37ff8043a29f607beab6440c32b9ae52525825@changeid>
 <ZcKs589qYxviC1J4@google.com>
In-Reply-To: <ZcKs589qYxviC1J4@google.com>
From: Jonathan Denose <jdenose@chromium.org>
Date: Wed, 7 Feb 2024 10:39:03 -0600
Message-ID: <CALNJtpV0KsOusPQeGv8bQ3jKy2sUj+k=mPHc172f+vMaTDYPfg@mail.gmail.com>
Subject: Re: [PATCH] Input: psmouse - add resync_on_resume dmi check
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, jefferymiller@google.com, 
	Jonathan Denose <jdenose@google.com>, Raul Rangel <rrangel@chromium.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thanks for your reply.

On Tue, Feb 6, 2024 at 4:04=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Jonathan,
>
> On Thu, Nov 02, 2023 at 07:52:47AM -0500, Jonathan Denose wrote:
> > Some elantech touchpads consistently fail after resuming from
> > suspend at sanity_check in elantech_packet_check_v4. This means
> > the touchpad is completely unusable after suspend resume.
> >
> > With different permutations of i8042 nomux, nopnp, reset, and noloop
> > kernel options enabled, and with crc_enabled the touchpad fails in
> > the same way.
> >
> > Resyncing the touchpad after receiving the
> > PACKET_UNKNOWN/PSMOUSE_BAD_DATA return code allows the touchpad to
> > function correctly on resume. The touchpad fails to reconnect with
> > the serio reconnect no matter how many times it retries, so this
> > change skips over that retry sequence and goes directly to resync.
>
> Why can't we do this in elantech_reconnect()? I am sure we can make it
> simpler and more robust than what the generic handler is trying to do
> with polling and everything.
>
> Thanks.
>
> --
> Dmitry

I am fine with anything that would be simpler and more robust, though
I'm not sure how to implement what you are describing.

Are you suggesting that in this PSMOUSE_BAD_DATA case, instead of
using psmouse_set_state and psmouse_queue_work to call
psmouse->reconnect (which calls elantech_reconnect)?

Jonathan

