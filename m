Return-Path: <linux-kernel+bounces-30595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F983216F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62DCCB21E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955133219A;
	Thu, 18 Jan 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+TtgSr6"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C732181
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705615924; cv=none; b=hnv3HT2bv5ZFPW0XqDfRZQ6loeFErTen/UDO69K1dUsj+TnuYIsk4g6VUpXJGMbVChOdYjkx6PtdG4pCWCuSxVE1VfnZKblju0Mc0PYIWiX7tjkvjcsqQvj3XIgIBOeGZHRZcBcOZs3FDVf1V4XtQh4b4r1UsFkDHKOMkmNJ94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705615924; c=relaxed/simple;
	bh=1UuGXWfi30fM/WW/2mh7eDVVS9PQ5Dd3MMK6ihSco6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7WZBrHs7+7j8jQKnfF3O+vJO4u3NaglfK1ZckNpviylF8UW4XYULx9igmgrjjTiqLRS0xytD8fSN1dHn5CNO+rL1n8Ej+KkLbO3E7oflwCfulvI1DTMHysiXW7+P84EgGuOah/3pPGjp2YOBr35Q5lS9Sm37S8LrT4PmYRk4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+TtgSr6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-559f5db8f58so1279a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705615921; x=1706220721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjxLFgZ8Azfw4Z6QpsBaooKVAVoHdG1lYSK2D9fQqZk=;
        b=i+TtgSr6J9eOKYmDETKgIjS4t4xi6aYBc5L2ZSbaVozqC2ZqcRQVIcr2E7jNGqfrFU
         GWrye43buUcGE54DCsOlWGE87P8kWN2sDgNrsWVPYysU2kMIFPbURN9LbV0Av0ks1SOz
         xxTtLxfm2jbExbxB79k6JvPKKfYbcnuuObPbOI8H1VE4KyVfqsglU2OaEebRRjq5/x2k
         uBMkkwwX8wNoIxULGLpLox/4eQnNq8vaDlhJ8ZM0r0WN3+wXyLSB2m1PPEtc9suU1nNq
         ULmVnVBkpAwUAzmYYbGCal9w39YTHrWT4aljX4T0wuLoNrhmKHs+9PfFGd4X72gVp2Cq
         38/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705615921; x=1706220721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjxLFgZ8Azfw4Z6QpsBaooKVAVoHdG1lYSK2D9fQqZk=;
        b=Iq4psnjcvFLMtA0fdW/EnWxmpdGNcnD+zmsP/hZghDqkzRoy02rUc08lYSFt2tgidd
         52bZSiPMrf+Rh8V5hsbX3nFJDplF8m+at6shyoQ3K3AqXDfa0DpLIbv4+i+bZvAWYnSN
         ss013GKZ7ynHi/7n6QK7vH823fKtKygBqAcJlKR9bpJIIra7HFG8E22sr8BLrml6Ljb0
         LFz0HeUpOPwgkZGSsdfFjoPEOntZDz+ndOuRH9UBixJJGwffi76sJTiFY6Zbrd73bHsT
         USBC0wuQuZ/5TicJtjDq27DZougKtBlgqIQNCFWNgt25+2JFT4rtw6m/Kw9S0jZA8vE/
         ZXzA==
X-Gm-Message-State: AOJu0YxdKcS4fy/GuZ9SlufsdSZROScoSbgYWqX6hG17nNRaq9b6Vh1C
	rOesKZLuXX4llJxLugYOsb5M/aNDvMcNiA3O0U6YamN3dwXzp5wO7oEJd7H5wdsjM/RLLKl2qyl
	woLBjBWRRZSieN1nGCGjMUH52PBJ/b2nA49o=
X-Google-Smtp-Source: AGHT+IEFBlKyuHJde4cfbgvjOtxS3tXJRq8gaH44j0Qs3sjG3le7Ee1bdnOE7mbmCjnk3ZFKvxH80DQQS1gd2KAkFGs=
X-Received: by 2002:a05:6402:b61:b0:55a:47a0:d8ad with SMTP id
 cb1-20020a0564020b6100b0055a47a0d8admr23021edb.3.1705615921453; Thu, 18 Jan
 2024 14:12:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118181459.1663313-1-pranavpp@google.com>
In-Reply-To: <20240118181459.1663313-1-pranavpp@google.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 18 Jan 2024 14:11:49 -0800
Message-ID: <CANDhNCqyugdsais9bzaL8RxTxyBgme4W2ZdfayaS8HbqBHJraw@mail.gmail.com>
Subject: Re: [PATCH] alarmtimer: Expose information about next alarm to
 userspace via sysfs
To: Pranav Prasad <pranavpp@google.com>
Cc: tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org, 
	Kelly Rossmoyer <krossmo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:15=E2=80=AFAM Pranav Prasad <pranavpp@google.com=
> wrote:
>
> The alarmtimer driver currently fails suspend attempts when there is an
> alarm pending within the next 2 seconds, since the system is expected to =
wake
> up soon anyway. The entire suspend process is initiated even though the
> system will immediately awaken. This process includes substantial work be=
fore
> the suspend fails and additional work afterwards to undo the failed suspe=
nd
> that was attempted. Therefore on battery-powered devices that initiate su=
spend
> attempts from userspace, it may be advantageous to be able to skip the en=
tire
> suspend attempt to avoid power consumption instead of unnecessarily tryin=
g and
> failing. As one data point, an analysis of a subset of Android devices sh=
owed that
> imminent alarms account for roughly 40% of all suspend failures on averag=
e leading
> to unnecessary power wastage.
>

So thanks for sending this out!

  I'm always a bit cautious when exposing stuff to userland,
particularly if it's potentially racy as you mentioned in your
description. One thought I had was might adding a similar check
earlier in the suspend path on the kernel side provide similar benefit
(without requiring userland changes)?

Basically, if I understand the problem:
echo mem > /sys/power/state
<kernel goes through suspending everything>
alarmtimer_suspend()
  if (next_alarm < TWO_SECONDS)
      return -EBUSY;
<kernel has to resume everything, and all that time was wasted>

So if instead we did:
echo mem > /sys/power/state
enter_state()
   if (alarmtimer_immenent())
      retrun -EBUSY

So the kernel would come back much faster if the suspend was going to abort=
.

I suspect you all have considered this already but wanted to
understand what issues that approach has.

thanks
-john

