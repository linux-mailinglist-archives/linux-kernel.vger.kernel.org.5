Return-Path: <linux-kernel+bounces-116444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CDC889E70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318601C35A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836912D20A;
	Mon, 25 Mar 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsD79n78"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B934E9CD;
	Mon, 25 Mar 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335067; cv=none; b=U8LT2meAU/M9oJUjAa87wMh31dT+akAC4pz4sTC71OLJJAappD48XZuWAAJU2t+sxdJE7DUgHjfjox1lWPmgmX4NYjQJMw8pmLgUWXkWXKPxaaUdVzEuem92SPRqM46cXfVI2LgiKvYpMwQzy97dva6ilT1z9S+yDS9T7zivuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335067; c=relaxed/simple;
	bh=biRFDuDFFmrGcVhDFXnntAOosUY7GJSIQ9cbUZxbPus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q01/3KzMjeF88gp4ZagzbpCib3MazW0J9ERRL92EkV91XwPVc9LDSFbeXExTKCRlBJKNHQEBceMzgHV8phze3FjbVpctqWKie7+DZHqAr1bSOC6WLgy46VuGeNrRHm+Wv1TMSWaYaOxXaYr5nPSuzvziQh3IlyqcDEXmf6CiZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsD79n78; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d687da75c4so46885011fa.0;
        Sun, 24 Mar 2024 19:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711335063; x=1711939863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LnrNtIij4Bn4X4TVnt4F69Di6fmhgYJ95GSudT4g/s=;
        b=nsD79n78jjbGfEpAslqT6wW1qIR2qibW0xv8C767n6lfnsZ/wJ5lqKEMBSTx3yV4a6
         hTCdQXhUTFPI7ibW1CHdAJJ6g7gtv2FHXy1jJPhQcNbW3EiaLPwkLyntUam5Km4jR9DJ
         4vyiEtiQU0BKHfmtob+K93RAZr/TtKEIAovkAQq+EFnlhsyFtXtNaSkRYbgfNIDq74Pj
         y6cdgtAJ0P8gOx01mj4vEF3ex5lzMAxWbUJpezdIzxxWxDI+s/ug+QEcMKUi7ELSmYT7
         Q8UapWqkOK9yrUuPEtGCidXBc/ebeCxMMDHW98b2Zpgpd5a27wzEk69QTCeNQDU6diNX
         y+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711335063; x=1711939863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LnrNtIij4Bn4X4TVnt4F69Di6fmhgYJ95GSudT4g/s=;
        b=f1gCmHZr3qp8LkvN5c23M0+meYzO8sHaeybmugmpXfE1QD+g0KZyYmybwF4JtgNPSR
         CaCdD2EyRE0BurItiyGnmtLVDeam+Zt3nha+IYqz111mFUd1aPSdjDHT4QVnTm8w825D
         JG7Y+AlCGV08PqiyOY1VGO/8aIhObagrUI/bf7ZYGDXV+OYXmpmKqUp4bykWIHicW5Lw
         G3ztostqfJ6smAGHhs9Wdm3PIC6VB5AVPVdtVNuVoF9lQyZKBPdoAgy61TninMcBz/ij
         qsgE0zuGec44iLF/8z9H67Cr6ROzVDMkVRZCMkPkI4Q9b9OyQ+nbRsMxdSL53YSXStP9
         XHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpMe6MYuctjDt9zes1j0uHMbYScasyLD90IeV6LXNgpPC9Ygmfc6wJMkW9MBugjGRl4w9TrbZksW3q6FMTkyAKvMmqju4XWEMxXKHICMSuJ9kZJW1xLNMKXQJicpnsNtdwwRla
X-Gm-Message-State: AOJu0YyFStb2nWeMtzPBYkFDA8y1g2UbHDMD0j4Kj0hFRTTkJ8xKoCPM
	7+6XxV/ZASf4u1PzJBMxra8LI8AMxz0dDDndfBhRe6cHhDoLOqor9+L4AiIzZqQPucSe5EQNzC8
	fsIlMFI+7xOo8sZ7E8O1h2EYsoQ0=
X-Google-Smtp-Source: AGHT+IEYeZivJLuYi6qTfbH9A+Steuz/SE2j9nSLFBiNGYXsF6GgH/e2x2XA5N89cjg8RRWrfD/hcIY0fJ++j665Jvw=
X-Received: by 2002:a05:6512:3d22:b0:515:ab5c:4a2f with SMTP id
 d34-20020a0565123d2200b00515ab5c4a2fmr1675869lfv.26.1711335063232; Sun, 24
 Mar 2024 19:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-4-4d9813ce938e@gmail.com> <d064b1be-1004-487b-9944-b62d91b671c9@lunn.ch>
 <CAJq09z54+049aPL2LzAqAFigrvpchPhv_YQ6yJ5C9b9J7mngLQ@mail.gmail.com> <f76754f9-4141-4d48-81e8-f43aa2dfa90c@lunn.ch>
In-Reply-To: <f76754f9-4141-4d48-81e8-f43aa2dfa90c@lunn.ch>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 24 Mar 2024 23:50:51 -0300
Message-ID: <CAJq09z6ZYpwYiqo-XvLG1=_JZeCM2APmHqBjhD4rBSdRP3ERYA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net: dsa: realtek: add LED drivers for rtl8366rb
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > OK, I'll add _group_/_GROUP_ both to the enum name and macros. Led
> > blink rate, for example, is global, used by all groups. However, it
> > will be difficult to respect the 80 columns limit passing
> > RTL8366RB_LED_GROUP_OFF to a rb8366rb_set_ledgroup_mode function with
> > only two levels of indentation. Do you have any recommendations?

Hi Andrew,

> https://www.kernel.org/doc/html/v4.10/process/coding-style.html
>
>   Now, some people will claim that having 8-character indentations
>   makes the code move too far to the right, and makes it hard to read
>   on a 80-character terminal screen. The answer to that is that if you
>   need more than 3 levels of indentation, you=E2=80=99re screwed anyway, =
and
>   should fix your program.

I need 3, not more than 3.

>   Functions should be short and sweet, and do just one thing. They
>   should fit on one or two screenfuls of text (the ISO/ANSI screen
>   size is 80x24, as we all know), and do one thing and do that well.
>
> Maybe you need to use more helper functions?

The call that violates (by 1) the limit is to
rb8366rb_set_ledgroup_mode(). With its name (a little long), the now
5-char longer macro/enum and 3 tabs, it has 81 columns when I align
the argument to the opening parenthesis.

static int rtl8366rb_setup(struct dsa_switch *ds)
{
       (...)
       if (priv->leds_disabled) {
               /* Turn everything off */
               regmap_update_bits(priv->map,
                                  RTL8366RB_INTERRUPT_CONTROL_REG,
                                  RTL8366RB_P4_RGMII_LED,
                                  0);

               for (i =3D 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
                       ret =3D rb8366rb_set_ledgroup_mode(priv, i,
                                                        RTL8366RB_LEDGROUP_=
OFF);
                       if (ret)
                               return ret;
               }
        }
}

Should I rename the rb8366rb_set_ledgroup_mode function,
RTL8366RB_LEDGROUP_OFF or is the violation here acceptable?

Can I use the double tab indentation here like it appears in
https://elixir.bootlin.com/linux/latest/source/net/8021q/vlanproc.c#L120?

Regards,

Luiz

