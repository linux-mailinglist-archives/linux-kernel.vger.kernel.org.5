Return-Path: <linux-kernel+bounces-145272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6758A51B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45744289B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA781AD7;
	Mon, 15 Apr 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY/xEU9Y"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8608063C;
	Mon, 15 Apr 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187949; cv=none; b=l+lyvXBSyIa+x9FF0y1it1aXHQsaaixLeXHilVvZNZQ9Erz3jyOBeN7IbH1GRkylSu6nB3wc//B0IGWgbmahiSnS+7V9XEUoOoParNdrI0f4GFhnHGOTxcdWyBrqyxyq7U8fFCK1YQ67YdQ9W2srHzbwW9e71FtkLH2k1xwtf9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187949; c=relaxed/simple;
	bh=lY9dhM6iK8H+xRTcxtbZNqjoO3E0/X10GLrYjtfX2BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBeFUmiB5mUKBkF4Dak/rwabJhCcXBChif6rH9nWeKPNiPP6J5+GtDiRT/xyqV7i6zkaHv62lfrzsAXb92/vtCD4kJP/ybqo94bGfDd2+UjMEHMfNAEGOGk2silrC1EZtzAHVpOfz5RQvJtoYEzUP3TA6lPOWHibCmi88sUi4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY/xEU9Y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46a7208eedso457622666b.0;
        Mon, 15 Apr 2024 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713187943; x=1713792743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY9dhM6iK8H+xRTcxtbZNqjoO3E0/X10GLrYjtfX2BM=;
        b=PY/xEU9YdR31luxBgHMkxKtZtAEIaAIlw7e51YwKSf4rH30O3iZJQFMCEbQ9xT5/rc
         SXl3oCVS41LsBRR7wpFXmQh6zznxfJ4lAgzQWbwe+nvv0piAQj7lbMrSVi7gQeyaV72B
         mFU/u+iQKbg82Pa6PnvM6+dhJx58HAS2Eg8ccA/s0/LJr+tvjhHKXeRL4MAnyuQ969nZ
         zM5DRfA5tETmqMnGQU7A7MY2EwksJnKt0A1pYNCZYYuorH20ryQBTxRFt6d/6jx8oZwh
         CQmsxQp5C8rFXPBTWrMeUVWWZznhqslI6erqNSK2sIa2wkV1r8PJ6UwhjHOBfHLWYPk1
         gZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187943; x=1713792743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY9dhM6iK8H+xRTcxtbZNqjoO3E0/X10GLrYjtfX2BM=;
        b=OP9c5KJzk4qClCY2GAJVNxjyxpTYCO6DFoK408X9+Bkaw7d4LmF+ikZ18uliMDUC8f
         MZuOa8EKan/SuSihbyJUCMUfW60IJNJh0nZCIav3I268Rpbv8rfu0FbE8dVqZ9MzCaVw
         udRzqKKC4jpj5e4yXEqLTQ64k/BiL7fQI6uA3TsnDxPDLeeMwvWzZrhiBhWchURjLdFV
         DwK0q3UQkcPlK46Xwuwk/q9FIIjihGDI/1MdkBqwTUH3TqUdowILiUU9VSXzKm1dPfl0
         DXtxdkUcBv5t8ilRKskaOJRXTJolLX+Pxbz0CSj9ClxH1xGgeBycDT9gZDdp33yOPDiD
         s86w==
X-Forwarded-Encrypted: i=1; AJvYcCU/LgmKnlCjjwpRU55L63uijLtlTQi0xXyNw9HB98ykesNcxVeDmI+2tFuFHBMeua+BmbUTOOPuB99rf3j2LLTBJHlzuef8PBuZn7q03fp22eY8LLZTiHJaGZwxhay3RSuhXORzjM230nOgg/UPJZBY62agddac+yLi0hOnmP55VSnzxA==
X-Gm-Message-State: AOJu0YxsaN2srAxH8SoGnkQvnP9l8E/bCi2GhaTAZH9ccP85Rbcfc4xj
	WGGY6PetHWDX6JRZd2rX8ebXt9CIdLp0EThFatsGmNOe5FYUqBx0ck3W9HjsAXftj9r7Lm0mNEf
	j0xD2JKfCMIQSxBLQwY3yqsAAPETuCXzAJ2g=
X-Google-Smtp-Source: AGHT+IFZf9fDssR5nh9Eyau52SHgMzD+ltgsF4y4hSg/CkOl09E9yGPHol2zU8xld7bTfC7pSYrTliB5VDjZb064UEk=
X-Received: by 2002:a17:907:208f:b0:a52:6b12:3078 with SMTP id
 pv15-20020a170907208f00b00a526b123078mr1637121ejb.55.1713187942584; Mon, 15
 Apr 2024 06:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413151152.165682-1-alisa.roman@analog.com>
 <20240413151152.165682-6-alisa.roman@analog.com> <CAMknhBFzUeW5+rs_GgCZCiit=eW04VHyCnt-__jXLnO3Z29ksA@mail.gmail.com>
In-Reply-To: <CAMknhBFzUeW5+rs_GgCZCiit=eW04VHyCnt-__jXLnO3Z29ksA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Apr 2024 16:31:45 +0300
Message-ID: <CAHp75Vd3Fh7PgRXF6J2_-TJof3E5=Q5t6qJbDkutJ=5_f-0zPQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] iio: adc: ad7192: Add AD7194 support
To: David Lechner <dlechner@baylibre.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, michael.hennerich@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alexandru.tachici@analog.com, lars@metafoo.de, 
	jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com, 
	okan.sahin@analog.com, fr0st61te@gmail.com, alisa.roman@analog.com, 
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com, liambeguin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 11:05=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
> On Sat, Apr 13, 2024 at 10:13=E2=80=AFAM Alisa-Dariana Roman
> <alisadariana@gmail.com> wrote:

..

> > +static int ad7192_parse_channels(struct iio_dev *indio_dev)
>
> Better name might be ad7194_parse_channels() or
> ad7192_parse_ad7194_channels() since this is specific to the ad7194
> chip.

Quite unlikely we have the same chip to be supported by somewhere
else, so I would just name it simpler, i.e.

ad7194_parse_channels()

--=20
With Best Regards,
Andy Shevchenko

