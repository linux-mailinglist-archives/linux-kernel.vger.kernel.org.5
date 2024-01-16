Return-Path: <linux-kernel+bounces-27686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D917D82F41B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750D41F2369A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513A1CD3C;
	Tue, 16 Jan 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQ6sLM2u"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713801CD25
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429299; cv=none; b=Dh2OGJF2rEk+EuZWrx7ArNwUS2DDTL+E5PihJDK1HDlCE7tmOjRaAQlkpg0L1oMk4GZDKGbt36yCV7RAnVS3NFzvjttHri5E0B6XNu/QCRRR4g+VdwSpUTF0GBotDUNcUEX425HtkeqK+tDPjD5qrmlW0O4rquD6pMDjHQJNEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429299; c=relaxed/simple;
	bh=iGtilefM/gHGUZFo8PnOopvTKNySbPwZh2/Qz7KBUmA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=dD/DI3OPTci8Z+e2cN4wXA5arLQbfMxdSOWAPEdaKdLLFhxB1ChFqLhDloal3hcqt+i46Aa5MWE0Y4C/zBaajsG+V0q/Zt1VtsepsaBWXZn8pkDJbNJrwElMqwiSortpWBZPFtohp8VD4o0RS06LBpyMcL0m7/3RUiHxCMy5eII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TQ6sLM2u; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28cc07d8876so5688181a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705429297; x=1706034097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJipabZ4zYazV9lmvPELaW28mg+mGYQPV3OWXJ3l8Lg=;
        b=TQ6sLM2uV/PtTURW4b5q+1sq0c8VHyX0LyJC/8bqwJmaO7dbxAYGctcl0Hu+Lp6AHq
         rgL/WQeVkGbL7MHjCYPb8jsQXGlckhtMXRQMH7UffadiN1essyf/AMnissPDyJvK+X7J
         tklzASBDvFEOLgNbfit72lUKYpftxmKjI6QkyivkLvtQ9n2b57+W4cBWSuHBfP9wfBXI
         86c1fTgJua8pPh2dBSwNsJ245NvIUs4OTUyKAZyxyV1S6v5FHnxYrGdSLErYOJ+Yq+2T
         zTDXeiszorLzW18N6o8JeR4OTu9/IxjtbCAGydwz/cJB6qJVrVC+cuKaV0XdeqUBemxm
         s2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429297; x=1706034097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJipabZ4zYazV9lmvPELaW28mg+mGYQPV3OWXJ3l8Lg=;
        b=TLtoxCrw+Prmjgjmj0aKAHtX3gj4rXpSTivxvMwRsE45hp09URgTiCB0UT8vncz/NY
         Ek7aJWNKXtMbYGLRhnsfm69+sFFu09sp4IsLK1jLoSlm6sqHBXH1JHNxeWo9t+U+cc9B
         YeHY/xUmvrhxWt7hYzSH/tPz2SGYAlN+pKiIJi7hjaaoy8U7b1CObgufW/3tzNtaSluM
         I+JESeruZOgaQcztXSahQSNloD68a6hFIMq07+V/BWUPQ4TVoO020+6JuksHlFY/bE+O
         6+E6A7lAmOJSH/pakr87BnenodF71+81RDZMzy8DYSwqVYw/zXrXUwEedmNe019dShxw
         3ODg==
X-Gm-Message-State: AOJu0YyqiqdfVWJlnXOMmAqVfc3i8JiVjn27fZo59G2+vE/W1touLfck
	gqCYdNlr6qaRFP7bWQtaprIDyQO7uL2Q0vuGoDvtUexkUqWB6Q==
X-Google-Smtp-Source: AGHT+IGD45n2Kmp+42UAAvN1CntcTMHyFOTUd0Yzi86RjPsn4J8yQSUWK55vtqIj7sCnDXiqs0FpmeClEfHPtw8H6Y4=
X-Received: by 2002:a17:90a:d193:b0:28e:79ea:924d with SMTP id
 fu19-20020a17090ad19300b0028e79ea924dmr948652pjb.92.1705429296877; Tue, 16
 Jan 2024 10:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-11-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-11-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:21:25 -0600
Message-ID: <CAPLW+4=YYdUSaaLcsdEyPswC4s6onxuSh24vSfw4xys=sPZG_Q@mail.gmail.com>
Subject: Re: [PATCH 10/18] tty: serial: samsung: make max_count unsigned int
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:23=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> ``max_count`` negative values are not used. Since ``port->fifosize``
> is an unsigned int, make ``max_count`` the same.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 90c49197efc7..dbbe6b8e3ceb 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -760,8 +760,8 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *=
dev_id)
>  static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourpo=
rt)
>  {
>         struct uart_port *port =3D &ourport->port;
> +       unsigned int max_count =3D port->fifosize;

What if port->fifosize is 0? Then this code below:

    while (max_count-- > 0) {

would cause int overflow, if max_count is unsigned?

>         unsigned int fifocnt =3D 0;
> -       int max_count =3D port->fifosize;
>         u32 ufcon, ufstat, uerstat;
>         u8 ch, flag;
>
> --
> 2.43.0.472.g3155946c3a-goog
>
>

