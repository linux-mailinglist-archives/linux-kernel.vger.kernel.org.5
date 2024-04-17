Return-Path: <linux-kernel+bounces-148776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BEF8A873E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17205281EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E711146D5E;
	Wed, 17 Apr 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QmsS7PRC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93335145FE2;
	Wed, 17 Apr 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367028; cv=none; b=FktkuUXekggLSf8z5ytcUcyVNyjq9NN2RRTde0Q75rwaK57TIqEggiOk/VLzwQ5rgg1fss1Zqk3JFlD6l9yz9JaknT1WwpkZFjjW0IDSC9KaQgQWWBUzsCq5McEqeRFGhwblCV1E/Wuea7QEBYKbsjNKQCxKd9KN+kS75T7+LWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367028; c=relaxed/simple;
	bh=teut1DYBOYWg8AoeYC+wFsfdDLeBlXB5z7ySSfu6V/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hci9XT01jctLsMaSuYFAwa0cVi9D8N913tZaYQQuFvzQXrvhVxRhM0VrxdOBpkVHwMLr7Ot0r/AYabQdzPoc3Or38JiSWuaGwsE2cpqivyz7Ifbc9EOq59qsivLkZt3xWsLZNtAdeQYc/KQE5+FMPalNEMeekY5w25/squqUYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QmsS7PRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B587CC3277B;
	Wed, 17 Apr 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QmsS7PRC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713367025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6rWIydXQ3obAzttn6yuLd0ycVZDhW7TEPt9XQInSh0=;
	b=QmsS7PRC4pLNRA38GRtTYtk8nk40LLZSro9BOxZMHAM1b8oDQ6AuGqmuefQNrMcKjpb30K
	ypYvvHpUeAHwUkdlDLfLqIMDAr4nmBWZEQ0KEWiCgKnGcWJeUAQaYO54Tl6+KQHa9jhum9
	hnh6rmNk/9t+hPZP9aOrru0Zn2qMCjo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 213131b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Apr 2024 15:17:04 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso5841704276.1;
        Wed, 17 Apr 2024 08:17:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEoR29xUAwveg4OfJhbZzBAsmG1E6D+l1bavmA2RtgCgtzd7BpGfC5zTG798pC3KHMlDQHlQBkcdzhed7cce4seqsu1drbCjoE9P1Ia/uvUPGlpp/yYv15zP+hbHzmttbXmQAK8x1qtZM9/BmPRjPJpfmy7CnEjBxWPcCKw3JvwUZNl1szjg==
X-Gm-Message-State: AOJu0YxxM7W2K2MWiYLv35yh5kgcEHnCURX3ErMosxyTbuAFp07th48W
	bx0am0ITyab974kO034R8cUoXH0NL37lQTnrxtNr8D2Ngbh5rGVt/Iu38St6j9V+bQgPNjSuQ3m
	XlKt2ctkyLVyVSSDssRq2oYOC3Hs=
X-Google-Smtp-Source: AGHT+IFsEHtOUrP31nZg1MbSoRLCCZy+ynxhAbcJV95tKqd4/0GQaHoCMFzVUrRsDOXX0SjdoQi7K9NqN0QwYA0wHBo=
X-Received: by 2002:a5b:2c5:0:b0:dcc:383b:e48d with SMTP id
 h5-20020a5b02c5000000b00dcc383be48dmr16225464ybp.26.1713367022146; Wed, 17
 Apr 2024 08:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417104046.27253-1-bchalios@amazon.es> <20240417104046.27253-6-bchalios@amazon.es>
In-Reply-To: <20240417104046.27253-6-bchalios@amazon.es>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 17 Apr 2024 17:16:50 +0200
X-Gmail-Original-Message-ID: <CAHmME9qHY_1JGDMyvEGB7XDu2DKaYQcPE3UfSfb4aVZkgC8Q=g@mail.gmail.com>
Message-ID: <CAHmME9qHY_1JGDMyvEGB7XDu2DKaYQcPE3UfSfb4aVZkgC8Q=g@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] virt: vmgenid: add support for devicetree bindings
To: sudanl@amazon.com, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: tytso@mit.edu, olivia@selenic.com, herbert@gondor.apana.org.au, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, graf@amazon.de, xmarcalx@amazon.co.uk, 
	dwmw@amazon.co.uk, Alexander Graf <graf@amazon.com>, Babis Chalios <bchalios@amazon.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudan & especially Krzysztof,

On Wed, Apr 17, 2024 at 12:43=E2=80=AFPM Babis Chalios <bchalios@amazon.es>=
 wrote:
>  struct vmgenid_state {
>         u8 *next_id;
>         u8 this_id[VMGENID_SIZE];
> +       int irq;

This is only ever used inside of one function. Why not just keep it on
the stack?

>  };
>
>  static void vmgenid_notify(struct device *device)
> @@ -43,6 +45,14 @@ vmgenid_acpi_handler(acpi_handle __always_unused handl=
e,
>         vmgenid_notify(dev);
>  }
>
> +static irqreturn_t
> +vmgenid_of_irq_handler(int __always_unused irq, void *dev)
> +{
> +       vmgenid_notify(dev);
> +
> +       return IRQ_HANDLED;
> +}

Is there a reason the of code isn't conditional on CONFIG_OF? I'm not
super familiar with these drivers, but this seems like it would be a
thing to do, and then we could do `depends on OF || ACPI` in the
Kconfig.

After the whole Babis authorship debacle, I'm just fixing various
things up in my own tree and I'll send out a v+1. But Krzysztof, I
would really appreciate your review of this before I apply it to
random-next.

Jason

