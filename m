Return-Path: <linux-kernel+bounces-145381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB608A557E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596EB283440
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA446CDBA;
	Mon, 15 Apr 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM11Mufs"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C002119;
	Mon, 15 Apr 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192426; cv=none; b=U7IDVQ3iBe0vi5GZ+1TyurtLxVVAtcACvp5TGN33pneuWlY47dNFOLUSkANIjVpInpjrEfFgWYmTGCHUw6PIWQnAZtO7G9HcRz/188K7uO76zovK2zvNCBVDrNLiPXim8gtXOAPKWIEYgWcZn7PzUAANC7VD/JoC5rxwhRO39y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192426; c=relaxed/simple;
	bh=LQnlQplIIBRFAb0IYpzcEDhNW33rDEzU1FwDYMkl/BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+qFd1LD9GGZoby5BrgQjY751z8HobfTZhFI9kupJXtMPbNDEbWE6MsufyQVR4ybIoGGzD3k73HSP/h7elIf3y3W3WJdKUnVIE9UmcqakmNsSzQ/+PWk/hkAXJfWlmsdtPeY46D+84YZ+fotYZfCYhACj4ly8pauwwtNvqI6mUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM11Mufs; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6153d85053aso25502197b3.0;
        Mon, 15 Apr 2024 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192424; x=1713797224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQnlQplIIBRFAb0IYpzcEDhNW33rDEzU1FwDYMkl/BA=;
        b=cM11MufsfW7HxQkJRpYXF7vMnpbK7pxcHv+SPiK/GHW9Os1OJWLlNAofSGUETJMALh
         aG1OeOWNiAMXGMsKWif/WnfVwT01pRSdry0w5zZfElENDa9aJ7oXeWMYXXV4Kbhez6+Z
         HTBofnQKP8hBTi/MqhlZHSKCvfkYK4HbI/CU4p/Jta+01eBtWPobUhsLltrrYTG+xcJA
         dKIP2vh3kJCrY7Qf290QO4IsxzIE19zJ8TXAgSn6HC7YSKBl2MYEmUIZ47XyVcDo/Dha
         NmG3eTYww/AexEKZHFMI4mCSNt38Ukayq89Td4QuVUEjQnoo9f/1/VEXtmbtYAGrC0kS
         lH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192424; x=1713797224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQnlQplIIBRFAb0IYpzcEDhNW33rDEzU1FwDYMkl/BA=;
        b=sER7CbeW5vb0ByF3J/Oo6BWUKlez5HeojUhOEiF7+zm2eTkIeH3YL+kYZKZfj8tjQP
         qMnu2r4emTCmLe2KeJtXhe8ndgmWS8Mwd1++0T6rOrjPxgLWm2gtR+7+XVhWWXnBuAMw
         SzGYJO4vB6TH2Sj5H+EwwHDIC1h8BupCs/S9IJ8aql+ONt9gB4XgcJ9nhaBYQoDeheMm
         kqphjgMvKrHBjBh42O/E12AmSMxb7/YhmxQiJkPJ27NEk+Sa9PrZP2Glhw5XHda9o465
         uHG1ngBEnyQU7qcx56YZsdRfYKTnMDB5xCi7cVoxIYvp3As3WQAkOF8ggGA7h9g5jEMw
         J3qw==
X-Forwarded-Encrypted: i=1; AJvYcCUBIGPcLpE/YynWyDnir7Bx7Vh+Rpm9JVqQhKfkwz9VXd1XLvFTcoDDMVJcsxvbps2sIPVk+kvo9Fdxvo3ljMHMi+biVY5/8PzQfHBO0B7Vie+WeSAGazOJ3/iFDCUlrncOQoK0KrbZXGmRH0SLMh/gTArn8dI1lqahhfylQsVY
X-Gm-Message-State: AOJu0YyRauFEIP2JaG44veU5NlFm9DID8AirDrYGjYk5elhVVBU1ax2C
	QI6bv8D054nZ8GeieZc3vW9I6xlcg0HdLq7Ju1mc30yZX1B+eFbm1ZIhlC74zxJ/mIDoJyRLhuh
	jYo/JrTX++jxpEFOU66Kakv2JUB0=
X-Google-Smtp-Source: AGHT+IEpvLnj2DUE80Kfafaw7YdWuVb0xXdSf+ODoqEdIXs15rBq/iDZit7+SzDXZI1cdRv7j77yTlC7Hco/5gX03q8=
X-Received: by 2002:a0d:f2c1:0:b0:61a:d02e:8aa with SMTP id
 b184-20020a0df2c1000000b0061ad02e08aamr2481865ywf.34.1713192424058; Mon, 15
 Apr 2024 07:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312062913.12723-1-gch981213@gmail.com> <ZhzNM_zouHPLdvBz@hovoldconsulting.com>
In-Reply-To: <ZhzNM_zouHPLdvBz@hovoldconsulting.com>
From: Chuanhong Guo <gch981213@gmail.com>
Date: Mon, 15 Apr 2024 22:46:52 +0800
Message-ID: <CAJsYDVK+Qy-w_Aa9_ns4zZutBJx1HTxm0467chHh0XkLb-4_tg@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: option: add support for Fibocom FM650/FG650
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Mon, Apr 15, 2024 at 2:46=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, Mar 12, 2024 at 02:29:12PM +0800, Chuanhong Guo wrote:
> > Fibocom FM650/FG650 are 5G modems with ECM/NCM/RNDIS/MBIM modes.

In all 4 modes, the first serial port is the AT console while the other 3
appear to be diagnostic interfaces for dumping modem logs.

> > This patch adds support to all 4 modes.
>
> Can you please say something here about what each port (in each mode) is
> used for?

Do I need to send a v2 for this?

--=20
Regards,
Chuanhong Guo

