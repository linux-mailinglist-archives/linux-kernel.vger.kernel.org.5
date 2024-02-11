Return-Path: <linux-kernel+bounces-60870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA35850A63
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C6A281C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ECE5C602;
	Sun, 11 Feb 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2SEjAIH"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD833F1;
	Sun, 11 Feb 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707670734; cv=none; b=I2PqAeQ+QNI8sL6ib4iunFmgZrTkV7hqIFGKw+dLwIq1uEalv5t3kNqhXDa8+dZ7sh95dhFvIyJRlcSuF6T21FJ83RWj+jd9Y5wLKqE5fsTy5K34hjKWVhuT/k5tKk7T6JiSK4iRMGqmun0EOJ6oXtoRH3RfUERMW9VmUxMofd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707670734; c=relaxed/simple;
	bh=YXwX3qIj9IXEein8cZqNNXLpJGP3xPTFPjqAclsRIlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j82ClW4b7FmYfjlyzQsvakR+aHtinYWNheUnMaierRQdrcaWXQSNCenMJHHDAOhp58506p2ReDmomBydf44tyN4Qh2xedO0T8W0vJ4ybimTTxbJ00OBa0bYB6wjJfuADxIe2f4CpPQENtPn1moQUIka87yUwzi7lMC+4I6DFG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2SEjAIH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2a17f3217aso314386566b.2;
        Sun, 11 Feb 2024 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707670731; x=1708275531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXwX3qIj9IXEein8cZqNNXLpJGP3xPTFPjqAclsRIlY=;
        b=M2SEjAIHNnoDqbIGq5pPua9qcQRUoFOqA9cLC302ktnOKVXVNSF9s+kfnEbG0FQjQc
         vsYtHMNIRr+n+HQ5XZvoi1bZnya9tc+aufhnjUy04LziFGsRzs368LCHkmimT/PwHHx1
         CPo/uRCSxADj4ZGgWRw8AHH1yfMONS5YAp4HecwuAuw581EWXSFk3viqyjy+ZgSuJ7Oz
         +EzzfU/QBeW3rqJnUt9TeBU3uXFwmNTzSe6a5epyr275mwO0yKTEDgVBP/5lX9tpfGjq
         UqE/ztMUygGrj82qN14RjxBAY+5/QLTGcqNqQLdHXR87WeT+VZ9ApMhF3GHE40DDyf0w
         MTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707670731; x=1708275531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXwX3qIj9IXEein8cZqNNXLpJGP3xPTFPjqAclsRIlY=;
        b=UYAtAKM0HABltflZeJgnzhyQayIpkLbw9SVK8ZMAXjTPThpPsvzVZd68rJcfANCe5U
         vUmPRuH7v7YvzAEapk/9BshvTbKwBJi8aF51DUnvOF+UfIyIOXhpN8ZxkeVAmqEr3C7q
         zfj5X2Em3VAW1/ej9bHInDuloFbUfBs8wO0rSMvNplOdDB1YZ28pJy84UsLpqLhDwivt
         4EfhxNX3TgPUp5cW8hk26J3sQ+JKECAf5X/xNh2pj3YT4PTmjKRrwBpSDdXs8oZcSav3
         EkKAST03HicxuY/2I/bX5uFVFfDZmMl73Ez7rf4SZpzFUOpan/wWRwR7eph9AbZdidR1
         zrRA==
X-Forwarded-Encrypted: i=1; AJvYcCVypTWMxq9WgWdBidtip1syAes1guPhK6Kik33IzsWafdB3g7l/s9TuXSvhFhbIlasbuvrIWZTDQbLkTi1A05yDUrafLFXFOqijcg==
X-Gm-Message-State: AOJu0YxIDtZcsd8pYI1hGRDqVwPBIOhYhqM6r5gUb6iyYnkeZnJKpgKe
	z7zDFUErQKBy1+5HZJddebJfrIcC/MgRFYD0600ML5yWrW7aOHqxeT9gnhQ1S55ZjabTBy1wVeV
	W0My3rMxq8+LRIRVpMuiP5n8tVE0=
X-Google-Smtp-Source: AGHT+IFlAsnpP9rTRy9NAATEAF0McKA1QqY4wBmsbYgs+oj1tLcdfgXTHqlIlP3iH63MMa73jt8OWBJ0uavGR10KHpg=
X-Received: by 2002:a17:906:d8c2:b0:a3c:8875:3e46 with SMTP id
 re2-20020a170906d8c200b00a3c88753e46mr911864ejb.7.1707670731152; Sun, 11 Feb
 2024 08:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211101421.166779-1-warthog618@gmail.com>
In-Reply-To: <20240211101421.166779-1-warthog618@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 11 Feb 2024 18:58:14 +0200
Message-ID: <CAHp75VeSLvrxMOARDBHBJ5VGVR-Jv-7saxjJiN-NOPMyTwit3Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: uapi: clarify default_values being logical
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 12:14=E2=80=AFPM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> The documentation for default_values mentions high/low which can be
> confusing, particularly when the ACTIVE_LOW flag is set.
>
> Replace high/low with active/inactive to clarify that the values are
> logical not physical.
>
> Similarly, clarify the interpretation of values in struct gpiohandle_data=
.

I'm not against this particular change, but I want the entire GPIO
documentation to be aligned in the terminology aspect. Is this the
case after this patch? I.o.w. have we replaced all leftovers?

--=20
With Best Regards,
Andy Shevchenko

