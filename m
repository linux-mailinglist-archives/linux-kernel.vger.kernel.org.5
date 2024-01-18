Return-Path: <linux-kernel+bounces-30285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54517831C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872F91C2118C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA832C18D;
	Thu, 18 Jan 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmgBfyTN"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF452942C;
	Thu, 18 Jan 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591855; cv=none; b=B7VeDWQ4/qNBEXuH2lAoEcJ+RREXLidUQpaGAudjNLqWt7m91GZFAsr2LgZ0MvTFJ6bhn28p4tRSlchS6e9nWJ2JgR7FnNYOm9VNXIqJmcNRMdhBYAv3eO1iq2ZK2B0+MAAa0N3WVDg96x0/KeQTZItPLQk2I4l664hseKl2BdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591855; c=relaxed/simple;
	bh=sR4Gjgkr5f7lPiJTtQ258jvkdgDh+7iqHe3YtVU7osI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=AH9ar7TlL/7+Xs2rskiYxlVRQ5O/pcxV9Ny1x/uDAQm4H1hHNP9Tp4qJW99XWTETX74x5DMZEDRwnKq2GOxoZmsDJSnMZquyD/BfB6ly6iOhE7M/bljitRitN3CC795S4QCvZXwy011wL889guvbUdAaS3O8FVeBYKDyZnTlu1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmgBfyTN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-559de6145c3so2036696a12.1;
        Thu, 18 Jan 2024 07:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705591852; x=1706196652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR4Gjgkr5f7lPiJTtQ258jvkdgDh+7iqHe3YtVU7osI=;
        b=XmgBfyTNhg8BzestlRjRm/5P9kywEB1yQtIftRj8gzFiohuv6Mb3fCCjrArry80Prz
         6oXcFQWiBA8mVd3UuV0h/0qdLdtr64XlPN083iMfNEG8Y6NDs/PTvSZSgDCRWFcCT2XU
         KvOaPC+Ep+pCoQWg0+wXu1qNg4g/7/aGDCxvwNmZTmbKudRkrwqstSFU+NGSGNkwI8Nl
         pwrBWCyrCQbcoSmSTLnNBJYMQXFm9kdhNi03ImoGCn6rXXCrVDcqyolaZPt9CxDeSdrL
         gcSYn9rgNrw/JKnoPpfPMEX+F1qm6PM+kmgOUoKr/y6tZpiUWKlw9myZIb6w8dGrcKT4
         qoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591852; x=1706196652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR4Gjgkr5f7lPiJTtQ258jvkdgDh+7iqHe3YtVU7osI=;
        b=Lkx4V2tfIvbRyeSysqVEgXXT9Z1+d4fGkAkF7i0J1/fCxbGbivtfovaUDd1LLSOGaY
         ab2ttiNEvEWfs77qDUcfGd/uUgeu26YzcjHlRo+szxQZuBO5cBjVbMTzlUQR3yLNVvr6
         zUn8zSfiQj4mKZ0KQ51ninweOLAgiCIJ4aHrgrcXlueh5V2xYWvtWcERcnVKuBEFwURs
         qdfmoumeZMWbbBLP9R6Q0On+NGKK8XvhLVVFSh6ux4fIV9Nuae3XJIG3qujWcsMJYWWz
         /KtmrPILzzFn+YnXgEfg+jBNmHZa6GP5ht4A8bHsBzvsLlTeGA2x2AE7uWkeCcBNK9Ec
         bViA==
X-Gm-Message-State: AOJu0YzLqzFIk3KJGPi8tgZumiOIXMDD4ntm1pZpz3WtCT95WUYu0RNx
	UHk3otR0VdbAQC3/OqwGR9Bm0LCEfRk5OtMEv6eq6p9rrk2l2sWmVgC3RwnS2OKVDB1akyJzUhy
	N0l0Oe2pUDqDQ2LAyexpYWiJE+us=
X-Google-Smtp-Source: AGHT+IF3+SHu0T6cDVGDTcp/GtaO4zkfkIK9JDPE9OwVQcUA6ZMTlisQ0pqI7xW+sE9ZnLJvvHg6Yb//GzmIF4eMKuI=
X-Received: by 2002:a17:906:e958:b0:a2c:f60d:576f with SMTP id
 jw24-20020a170906e95800b00a2cf60d576fmr533862ejb.50.1705591852402; Thu, 18
 Jan 2024 07:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118152213.2644269-1-hugo@hugovil.com> <20240118152213.2644269-9-hugo@hugovil.com>
In-Reply-To: <20240118152213.2644269-9-hugo@hugovil.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Jan 2024 17:30:16 +0200
Message-ID: <CAHp75Vf7j6_xPceGuDWB5Mno2eJreyyD8B4i4GyyiMyKZPiwLA@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] serial: max310x: use separate regmap name for
 each port
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	cosmin.tanislav@analog.com, shc_work@mail.ru, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	=?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 5:22=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Use a separate regmap name for each port so they can each have their own
> debugfs entry, allowing to access each port registers independently.
>
> For example, a four channels/ports device like the MAX14830 will have fou=
r
> entries in its regmap debugfs:
>
> $ find /sys/kernel/debug/regmap -type d | grep spi0.0

Just a side note for the future. The above is an example of "Useless
use of grep".
`find` has a `-name` parameter for such, using `find ...-name
'spi0.0*'` makes the grep unnecessary.

> /sys/kernel/debug/regmap/spi0.0-port0
> /sys/kernel/debug/regmap/spi0.0-port1
> /sys/kernel/debug/regmap/spi0.0-port2
> /sys/kernel/debug/regmap/spi0.0-port3

--=20
With Best Regards,
Andy Shevchenko

