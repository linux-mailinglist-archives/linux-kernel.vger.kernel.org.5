Return-Path: <linux-kernel+bounces-69201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E118585A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D62A2877AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2F6135A50;
	Fri, 16 Feb 2024 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZlxN9LA"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460DE1353EB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109155; cv=none; b=Y+9q2yL7/LyYvwfAg/r0iHf31JD3USJnP918gLdlxWq4qH93h8MSBhdEbP0SgnYm4NFSEvWk3eOXVSWRT05Via/EdjTtK2G/hTxOWRgBlpPMx21WBiFS9mLkY9ZNZUn9QS7hztEGDJqJZqEmih9sP5BUCNlbnkCc1rCqrWXpaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109155; c=relaxed/simple;
	bh=xL5njaKZTLPLQp18TE8okk0OD0L3Unq9XV1SmRPOGWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICqLl6puv5km8XXqtKs7XGzGgdQtfiNIQlJACl16lG6HFYLJejrN81CQFasOR0cEK61FhGEwU4Mn96lGhW7RZ0PzibhdcaXLtphwFEczUPOZrS7I7u2kq69C0lS6tILKtrYcCOt8wYiFeOFQoGxFY8hmgEkNd0cmFihIF/X558I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZlxN9LA; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-363c3f7dc20so5825ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708109153; x=1708713953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLDTPlS4ViQ1CSZl9D6URfWqsRaq0fnTo/1FRytbftA=;
        b=yZlxN9LAVy0DOQE8c9TGurn/q0IFkt64vtFB8UpE9sqn+I65BhICr1wI0IUrpRh+6l
         kzhOOrlX2zVrHMlLLRv0M3slb9IhW+GAcdrgBpWgdtGLXzNOSql15JqmqcujDl0O2Vg/
         cLLqCVRgpplqN3EXCa4uqsyQRf8c906LWTEodeMbuNYe3OJK6faSXI8tNyC06wbCR6QK
         MgHXo0yE85CMTDocEE0Z2nlZgY6/2erDGFKWT+BLuG2eWHWZ1cvGQ8NpzyJWDwuQW8+N
         JpaHs/M0dNPhu3Ft0+UdrlE4n7ja3Rg3+/yU1KJJILCu47HmbL9THfA4xudOPgkMOOsu
         5xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109153; x=1708713953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLDTPlS4ViQ1CSZl9D6URfWqsRaq0fnTo/1FRytbftA=;
        b=u5JLA32NMS8qij6sqC+kjJGmq9sCaEvd1i+Dt5IHaBBj5kcKeZhc0dPLENtNoDrhHN
         4oO1KRGajzt8/Wh1umR14Su7l5Y+A6/ldIKmRLjCTB+Q/i9nkCtDJMkyHwz7Uax9RknQ
         6txkPNTfZ//K3nMg1dzuCnweoFF39a2OOQ/i1bMpkfmul95mr+a6VZXajfEX6+1S7PbF
         EEGxb2Qu6eTqTMTxK2EkI2vVbyDkXHRGoOO3qxdpqDFL2ZMFEiMMZQHU+SdRBcaTdF/V
         oRLehAWgKuf2smpwf/0IsO9XVACzl3ZkMc1bW6nvSQ/RlWVn0X9o1wY8oCo3HJmofFEl
         Ehkg==
X-Forwarded-Encrypted: i=1; AJvYcCV/D2EEfJNF8pVSuSCwZapQ4H+2G49SLQO6Md075u+vI5OGdenUgUVahUfKdIY1UH+B/Go4JTPHouoMifCghQmlOme189G8gSSRRZ1o
X-Gm-Message-State: AOJu0YzU03SbK4Uy2L7pCtAcX05yU02SqA/1XDfAFesJkMQR1E8GQgBm
	C/CeHgylLQ7vcVKbU4G7aihpLRd5Je8j0N+HZnU+BAjvbAxxZkgd7L+zyb4bT6mGQl7KY8Seu6c
	ncwSYobisYx0Z65h2afw+kS2OY8IJsbaJw79d
X-Google-Smtp-Source: AGHT+IFu/Tl10B4BCgdhkVBwE/NPQCGO31aX0SPuQ2bAZb33WxC1H+Rj8Z3BWlqowPH14vGrzjQappquaWk/lBx21jU=
X-Received: by 2002:a05:6e02:304a:b0:363:bad1:b8d6 with SMTP id
 be10-20020a056e02304a00b00363bad1b8d6mr21553ilb.1.1708109153177; Fri, 16 Feb
 2024 10:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216094154.3263843-1-leitao@debian.org> <20240216092905.4e2d3c7c@hermes.local>
 <0e0ba573-1ae0-4a4b-8286-fdbc8dbe7639@gmail.com>
In-Reply-To: <0e0ba573-1ae0-4a4b-8286-fdbc8dbe7639@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 19:45:37 +0100
Message-ID: <CANn89i+5F7d4i7Ds4V6TtkzzAjQjNQ8xOeoYqZr8tY6tWWmMEg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: sysfs: Do not create sysfs for non BQL device
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Breno Leitao <leitao@debian.org>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, horms@kernel.org, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 7:41=E2=80=AFPM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> On 2/16/24 09:29, Stephen Hemminger wrote:
> > On Fri, 16 Feb 2024 01:41:52 -0800
> > Breno Leitao <leitao@debian.org> wrote:
> >
> >> +static bool netdev_uses_bql(const struct net_device *dev)
> >> +{
> >> +    if (dev->features & NETIF_F_LLTX ||
> >> +        dev->priv_flags & IFF_NO_QUEUE)
> >> +            return false;
> >> +
> >> +    return IS_ENABLED(CONFIG_BQL);
> >> +}
> >
> > Various compilers will warn about missing parens in that expression.
> > It is valid but mixing & and || can be bug trap.
> >
> >       if ((dev->features & NETIF_F_LLTX) || (dev->priv_flags & IFF_NO_Q=
UEUE))
> >               return false;
> >
> > Not all drivers will be using bql, it requires driver to have that code=
.
> > So really it means driver could be using BQL.
> > Not sure if there is a way to find out if driver has the required BQL b=
its.
>
> There is not a feature flag to be keying off if that is what you are
> after, you would need to audit the drivers and see whether they make
> calls to netdev_tx_sent_queue(), netdev_tx_reset_queue(),
> netdev_tx_completed_queue().
>
> I suppose you might be able to programmatically extract that information
> by looking at whether a given driver object file has a reference to
> dql_{reset,avail,completed} or do that at the source level, whichever is
> easier.

Note that the suggested patch does not change current functionality.

Traditionally, we had sysfs entries fpr BQL for all netdev, regardless of t=
hem
using BQL or not.

The patch seems to be a good first step.

If anyone wants to refine it further, this is great, but I suspect
very few users will benefit from
having less sysfs entries for real/physical devices....

