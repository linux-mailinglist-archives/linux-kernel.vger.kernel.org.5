Return-Path: <linux-kernel+bounces-52390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DC8849774
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B930128B9C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE7014AB8;
	Mon,  5 Feb 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1sWI1W2"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8812E71
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128024; cv=none; b=UoHTeY6d+ivysQzVjtFk4IJxqBQ4Zis6VD5bFzaC7SX0Thlc6LwGKqRrXbH9D3hen/kyR6TlqmzZ0mvVCFrNhPMclY7kOie8rdY+QKok4vHbg2vUQJ4HM/jYKqYwP4P8ejHm0rNjoMM0aG5ateS2YSJz1EFvXRS0pAeTWP3zRCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128024; c=relaxed/simple;
	bh=OecLVGD5ja8HicFcQxVrUqmNQBtW+hO67C8FQtCGoZw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kk6i9I/LdTS2Ken8Z1axsxaalL2NrnR4JU/Ec9c/I9K5RHTsUoR2oA20DmS0GQhlefJRujMHuJU6aTES+0b9bXWn/Of+xmcRbE3J8koZyMmPcT0Y24tzwpflK3OeE3iuCXTH/sMdACJDbzx5Le76fhFSMCSVN3NTW5NxYRIoQyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1sWI1W2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a349ed467d9so493593266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707128021; x=1707732821; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OecLVGD5ja8HicFcQxVrUqmNQBtW+hO67C8FQtCGoZw=;
        b=m1sWI1W2MlhVpUjA1jFDqFeVDHA+xXRdCL23wWE+47KxC8/9ejsevax6WUr3qA0sPH
         J85GGuyYHnoBinldPUdGch2i5QUz7ur2UMRE2cm1aeBvQecoTIflIVSJUMawncgo8zUZ
         /flpjGJadLPGNsqBN07JV39sZF5n7WjIoaatvxNyxPHbMYaR7H91MM0PfNSJC6n25irA
         x7UJsoMYrTcK+lM22vgPg2QFAiPeDrLS1FtuNGhQHX65FctdyDGWf/24gsYuqRuzPLMh
         BuqFa2zvtCECuomUe74jGKxU9Cxs8LnpYIT3fohGCO0xYk1pkXmV7a41MM8B6H7uHlVI
         oPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128021; x=1707732821;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OecLVGD5ja8HicFcQxVrUqmNQBtW+hO67C8FQtCGoZw=;
        b=pEStwJMClOTmydUlv18f9+G39CGkRRA/sXT27U8VJBy5SyAkVbKk6MXwxWzfaVoH+W
         KJr3xrN+SGo7ZT7DfDW7Lb7jYYaISXH55q0uVEPPhKrJ37U4askivvgSAQOgJ8oAm7BS
         Zipxb52Rmh7bkwpbSMRqWUKosPP5/xW9ae8CgC0Yk7yif4OGb/z82O5Hm8cqTTPd/Mp9
         ox52WgZ5ELvBZMxqlnOV++yiXoyoVs2K/2ucjPnBlr8SwtjPckcuecTgkdDV56m+2rxt
         /J+YRkStCLnctt+9s8gr3ie1ndU0wBcenX+v3VjqgiXldaHjbSR0kEgtuvLZVboS4y90
         LxSQ==
X-Gm-Message-State: AOJu0YyvETFPCCJeP1hEqjTNhVkMnQywkDs3blRqIfSIrEvrPNkHzv3t
	aCRDLhtAJCXvxcywvzkFkqpAilobvGpUQW3qInuoP21jYZnmNCve
X-Google-Smtp-Source: AGHT+IEiyyR2IkRTjDjPZI9O1feqj32tWK+GltO3ktk6Nsi3uyRen8G/TvxDHVZLNzubWVFcK1sAXg==
X-Received: by 2002:a17:906:3ecc:b0:a36:c466:52ea with SMTP id d12-20020a1709063ecc00b00a36c46652eamr6548445ejj.75.1707128021008;
        Mon, 05 Feb 2024 02:13:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUJchxeK2wNpDLIfLzOraX+X0zJCPooESwfS1tf5mb83px7N5S5oPW/ydJpl7Y3JD2T7qMLDWVLtgFmQQ5kX072cO5Ibd7eOfbKmWy4Ox919GsKLMhP33tDHrETL/Oa21mWYX8omG2A0JPSem3//70WUm+6mwCwlWAjC3/GUN4MDesaZKEimy1dAdhf3srQ2nsSbogt4K4IfuVaojfyOG693gXvaWp3YXtiSfHJdKX89X9yl+CNTiXLQwkYCMb5WVhvZ2Kq4HuXzu7SR6/QrlIVrJDvOSNLjC7HNblJSbVqPaqUGzWQIPNc5EiA+5qi3XqctKnYw6hhJZAgjmHXr0qryJW1+/xIiIkJWFrK9J6NCST2N8iiKK0OK0S18jdLXs/OIDaSZg==
Received: from giga-mm-1.home ([2a02:1210:8690:9300:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id fj10-20020a1709069c8a00b00a36a94ecf9dsm4214482ejc.175.2024.02.05.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:13:40 -0800 (PST)
Message-ID: <c93bf062dca07191bd76330eac6580355ab65a57.camel@gmail.com>
Subject: Re: [PATCH v7 01/39] ARM: ep93xx: Add terminator to
 gpiod_lookup_table
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
  Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Russell King
 <linux@armlinux.org.uk>, "Wu, Aaron" <Aaron.Wu@analog.com>, Olof Johansson
 <olof@lixom.net>, Lee Jones <lee@kernel.org>, Ralf Baechle
 <ralf@linux-mips.org>,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Date: Mon, 05 Feb 2024 11:13:40 +0100
In-Reply-To: <86ae775b-b3ab-45db-9541-95fcc0e17b5e@app.fastmail.com>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
	 <20240118-ep93xx-v7-1-d953846ae771@maquefel.me>
	 <CACRpkdYDmx9qrkCo5mad_w1e0MKNYrVirg=qi+R4Q907SLdRwg@mail.gmail.com>
	 <f00582bf4d19b539cc1427706ee9a07fd3992bc3.camel@gmail.com>
	 <86ae775b-b3ab-45db-9541-95fcc0e17b5e@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks Arnd,

On Mon, 2024-02-05 at 10:02 +0000, Arnd Bergmann wrote:
> I'm travelling at the moment, but can take it when I get back.
>=20
> If you want to be sure it doesn't get lost, please send the
> patch (with the Acks) to soc@kernel.org=C2=A0and it will end up
> in patchwork.

I'll do it!

--=20
Alexander Sverdlin.


