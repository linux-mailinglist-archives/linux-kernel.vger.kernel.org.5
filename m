Return-Path: <linux-kernel+bounces-84262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9456886A44D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2967928AC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6676A4405;
	Wed, 28 Feb 2024 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQEwLO0a"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176E210D;
	Wed, 28 Feb 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079024; cv=none; b=ofSDZVG98PpVdzLtRiyewNbMGBvJEqSC6pNE9zJWr45LzHkUdAQyMSH3F3oTDkm83W1iPPLDf/4LgINwGF2BJO5LH/VQ63KFH5VdNTXGYdnwuAHlMhhhMVRdF4Kzypeo69NX1H+Bdg2AeRqHmfk5WJJ+YtVZk6M2RGqCHRnOhQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079024; c=relaxed/simple;
	bh=vC8mwnT09idBziDtRBLEFES+hUh7Klq/2GI8cfJmNc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDFSI0hF2LJgQUu1d5mlBcY4u0oaxaRwYxe02bTvs+lqUfMsFhTeX2mp5UF+Vhi/av1oBXtxbqjQx/GGSzVe8nRXtOujahGXzQg08giJMViiUVoZB7Em7o27FTDz49ZhxdSUyuX6yBLStKCstsyaB4fuxTFHL/jfeDzFs7+zets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQEwLO0a; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a43fc42e697so3583266b.1;
        Tue, 27 Feb 2024 16:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709079021; x=1709683821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC8mwnT09idBziDtRBLEFES+hUh7Klq/2GI8cfJmNc8=;
        b=BQEwLO0awnRQMTnbRFlU97Z9BHubmSIfX+Io2pXZezR+n8jx7WeMq92Chyb72ckY+D
         I2cuzvm8hcw5xIxdmrF1a8wPKHgnXSPENoZInUpH5d8ZmEglSsxxMse1QNX5loiPV+ZD
         v2nP2F9a6LmdXcAXWEFImtiF7ISkmyshB+sXwcFIYFDwkyR96m8I2yT1apopFuLUU2Nf
         1BeNTxlo5tY7arJohOW3ON3hYG4kmlOmcFcP5+32DYi9r4fIcbsZUcH937zRAelD/fMS
         xImzeV3doy4/+gcyeCF0PFu7zOZzqxOCfKFf1dJNu1hi3DBYOAXsqrNAOemBdk9WbJc0
         XoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709079021; x=1709683821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vC8mwnT09idBziDtRBLEFES+hUh7Klq/2GI8cfJmNc8=;
        b=emdZYc6UuP0M6JDNIKtKqmV8uZcZWGSYYfWCJRSpHQuve3STx64iadyYlpBBSTuSZ3
         /6OXxYYq4+G/NKtMv4f7JKYoBu+YlZsVsGKSsuJ2xut5XndW2l+Lj6J/ai0RCRHXeyZj
         tv+iyFrex2b5PSyUexEgwNlsytwjaJMAAdqzKt01K9fmy0igK4z9SiUJ737TCoYsIoOD
         /t6SZBA6t4y636yK1GT4vwxUISkGHd6sDm11AdBQ5mVttBIU5nTrcnYXSwP3m5/SaKxy
         zkMg8puJ7JCVO0FQe89pPp8X7aXJGYMWQ7O3FSGqTquDQhQoZbVfRNHZlltLtH6TRN7b
         Sk5A==
X-Forwarded-Encrypted: i=1; AJvYcCWFkaY5S7BmFGn0nt5vNkLD2syaFnepXc03Eg3ZrACkXBLJ+ba4j4ndkMqM9H5BTg3XOezw7vMcUo/52v59V5UG4YvoYps/++6wPUV8iViErxqt/SdHPTAPlVBu90nuqCDS1z7koBEvQ0flWw+7oscBcNFYTLpJUfb9gn8HIBsYIZW2kFM=
X-Gm-Message-State: AOJu0YwMBcoF4uOAzpzXf6bQAQ6VgAnT51WEU0gwnWaxHaFuvfiskvam
	HGhnPD95cQMfay2fqYDE3eWZFwLDa9JqU4AtjFJP7MDQ9D92b1f6kVKfIPu8rF3SvjpmL8Q5ukQ
	XdOvPFsoQqlA/Omo2aI5jni/eYcg=
X-Google-Smtp-Source: AGHT+IGZVfpkm2DfaATxYbW8sDqLo8UC0/8E2KdJmuFtszeZYC4T0I7y8hVv1MitHOhz6CX/UlDN9ItKNp7imqphW1c=
X-Received: by 2002:a17:907:118e:b0:a41:38a3:2a2c with SMTP id
 uz14-20020a170907118e00b00a4138a32a2cmr7858643ejb.12.1709079021161; Tue, 27
 Feb 2024 16:10:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz> <20240227212244.262710-5-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240227212244.262710-5-chris.packham@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2024 02:09:45 +0200
Message-ID: <CAHp75VfGfwxh_VVa8N_rYb-MK9AsufqtLRXvquuJwBGnEqh+gw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: marvell: Indicate USB activity on x530
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, geert@linux-m68k.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	ojeda@kernel.org, tzimmermann@suse.de, javierm@redhat.com, robin@protonic.nl, 
	lee@kernel.org, pavel@ucw.cz, devicetree@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:22=E2=80=AFPM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Use the dot on the 7 segment LED block to indicate USB access on the
> x530.

Not sure if it's a good idea. I have some plans for the compressed
format, i.e. use DP for dots (or compatible pieces) so we may print up
to double characters with that (e.g., '6.4.5.3.' as a single string on
a 4-digit display).

That said, I would like to defer this for a while.

--=20
With Best Regards,
Andy Shevchenko

