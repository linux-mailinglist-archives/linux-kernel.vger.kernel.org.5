Return-Path: <linux-kernel+bounces-27734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA382F50C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5D51C22DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31791D54A;
	Tue, 16 Jan 2024 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVQsqe17"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827971D533
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432209; cv=none; b=VbeUaK7OrJsSun7/K9XLgDzhcr92zIE78+p6/JOhxXJLtN7mUwjlqXCH9Oq6SVxQoy6pO6NPYIP5PKQC3I37AVwCPaf+EI0s9R3XGLxqlTgbBbfp8YlhLkQrOGEZ7jpQEVWIFZn9LUfXPNneQwnrAxssI0byQyD74WwLk9czZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432209; c=relaxed/simple;
	bh=rALMQ6XXG9dziiepCqWCR21j+a94URXQ8uh5FX0SSLg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=CRdS8qhPviV9SJE55oefM9k1P8jlKMsIPIuBAYFPlH5N+ApcvKOmdzJ1b8Xhz6cuwFbYHZF/iiOj6PbpYUesg9s0mvdZIg1tNdxCQH8pgZlC0Kxf5O2Cj3EBq6lSpqqqgw2e7Cd3tJZTVghroDGfZ/9Gs2XLsLov4R6VS1JLN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVQsqe17; arc=none smtp.client-ip=209.85.215.173
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso8032706a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705432208; x=1706037008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VKjWaZrVRn8CuoQYZouG8IgnSq7lMknhIStXH4ydpI=;
        b=oVQsqe17SkkxV5N3uy9/c32dY16pCphpLKHxAClrYC3pjjYhBqTyJbYwnlupc1Sa2S
         g3xMHuX3nj6bNZYLyhxXT6LdWNcBi1V9HRMBW+6ojJVNNpPMJNQKwgpQaQy7hxIfIbrZ
         cSN6Bx6042YJeXaUn9GOiPzH1cPcznpFTV7Vot3fwwgZ4A6bo1xL2odX3RD0J/fcD9br
         Y1howSkiXoGYKAGQ2jJ+n4NTEte861XhLCzyb1TJxBLHUcAphwgbzKZ9oZHsgbfpfYbB
         YeK/Ryu1xqor+2ZDqinWr92+U5hzXxVec37eAZBczMKQQOfQ3iPIGwxy6PsT2mvEHzqQ
         /HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705432208; x=1706037008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VKjWaZrVRn8CuoQYZouG8IgnSq7lMknhIStXH4ydpI=;
        b=AtzoRKJ9/2HknRYhMuKe26s6jeR7mDaz/8iJyPGajzH2V+e2TY3ybcDlFccEVN7WTn
         b8hIP0JYkYn+hEWIs/1daJTTs4T2ChShTTQs840ORKFP6AmVbJoPse4YPaVqmlM1WbGs
         2JiFN6r8YqH7Ltx/rfheOMkF4n+NCg0uMTZIzNRUrNEm6B4o6rn0ILwWiyZg4J3uQHjH
         9UB8ts4aV1k65moaMsEOhuNR9RtQ6wVmbuOLY0faFTvCoxtWNslJ1CKzWdvACwWmgAuT
         jzM0SgxCqx48MkPyOCfMpHPKz0jOAEdv8y1ajAiyRTxGYEcCxtRpz8Nmqnl7+HLImdSL
         xhfw==
X-Gm-Message-State: AOJu0YyQczwXwR51XNy19UtUx3XMlzK3t3Lag751ir3wMrar02duzkcJ
	F80agsCbTnyyL+1GzzlNL8jb4WHrvUm624DRE0CiWQ/W+xvbpg==
X-Google-Smtp-Source: AGHT+IHrIsM7g2wUFvRv13G9yYY8kYsRAIXMkE/xYYkt6tYTPdI5u+rE+aU63z1jH/mOoUM1mfu4KkzcNwSSOJSi4nc=
X-Received: by 2002:a17:90a:1c90:b0:28e:2784:9827 with SMTP id
 t16-20020a17090a1c9000b0028e27849827mr3223147pjt.17.1705432207870; Tue, 16
 Jan 2024 11:10:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-17-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-17-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 13:09:56 -0600
Message-ID: <CAPLW+4kndXo9Ab2PL3fts9pJNhhitX3Sr=V2b8mS4cArov4Tog@mail.gmail.com>
Subject: Re: [PATCH 16/18] tty: serial: samsung: shrink the clock selection to
 8 clocks
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:25=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> <linux/serial_s3c.h> provides a clock selection pool of maximum 4 clocks.

Then maybe it makes sense to turn those two field into 4-bit bit
fields? More importantly, what particular problem does this patch
solve, is this optimization really needed, and why? I'm not saying
it's not needed, just that commit message might've been more verbose
about this.

> Update the driver to consider a pool selection of maximum 8 clocks. The
> final scope is to reduce the memory footprint of
> ``struct s3c24xx_uart_info``.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 436739cf9225..5df2bcebf9fb 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -81,11 +81,11 @@ struct s3c24xx_uart_info {
>         unsigned long           tx_fifomask;
>         unsigned long           tx_fifoshift;
>         unsigned long           tx_fifofull;
> -       unsigned int            def_clk_sel;
> -       unsigned long           num_clks;
>         unsigned long           clksel_mask;
>         unsigned long           clksel_shift;
>         unsigned long           ucon_mask;
> +       u8                      def_clk_sel;
> +       u8                      num_clks;
>         u8                      iotype;
>
>         /* uart port features */
> @@ -1339,7 +1339,7 @@ static void s3c24xx_serial_pm(struct uart_port *por=
t, unsigned int level,
>
>  #define MAX_CLK_NAME_LENGTH 15
>
> -static inline int s3c24xx_serial_getsource(struct uart_port *port)
> +static inline u8 s3c24xx_serial_getsource(struct uart_port *port)
>  {
>         const struct s3c24xx_uart_info *info =3D s3c24xx_port_to_info(por=
t);
>         u32 ucon;
> @@ -1352,8 +1352,7 @@ static inline int s3c24xx_serial_getsource(struct u=
art_port *port)
>         return ucon >> info->clksel_shift;
>  }
>
> -static void s3c24xx_serial_setsource(struct uart_port *port,
> -                       unsigned int clk_sel)
> +static void s3c24xx_serial_setsource(struct uart_port *port, u8 clk_sel)
>  {
>         const struct s3c24xx_uart_info *info =3D s3c24xx_port_to_info(por=
t);
>         u32 ucon;
> @@ -1372,14 +1371,15 @@ static void s3c24xx_serial_setsource(struct uart_=
port *port,
>
>  static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourp=
ort,
>                         unsigned int req_baud, struct clk **best_clk,
> -                       unsigned int *clk_num)
> +                       u8 *clk_num)
>  {
>         const struct s3c24xx_uart_info *info =3D ourport->info;
>         struct clk *clk;
>         unsigned long rate;
> -       unsigned int cnt, baud, quot, best_quot =3D 0;
> +       unsigned int baud, quot, best_quot =3D 0;
>         char clkname[MAX_CLK_NAME_LENGTH];
>         int calc_deviation, deviation =3D (1 << 30) - 1;
> +       u8 cnt;
>
>         for (cnt =3D 0; cnt < info->num_clks; cnt++) {
>                 /* Keep selected clock if provided */
> @@ -1472,9 +1472,10 @@ static void s3c24xx_serial_set_termios(struct uart=
_port *port,
>         struct s3c24xx_uart_port *ourport =3D to_ourport(port);
>         struct clk *clk =3D ERR_PTR(-EINVAL);
>         unsigned long flags;
> -       unsigned int baud, quot, clk_sel =3D 0;
> +       unsigned int baud, quot;
>         unsigned int udivslot =3D 0;
>         u32 ulcon, umcon;
> +       u8 clk_sel =3D 0;
>
>         /*
>          * We don't support modem control lines.
> @@ -1775,10 +1776,9 @@ static int s3c24xx_serial_enable_baudclk(struct s3=
c24xx_uart_port *ourport)
>         struct device *dev =3D ourport->port.dev;
>         const struct s3c24xx_uart_info *info =3D ourport->info;
>         char clk_name[MAX_CLK_NAME_LENGTH];
> -       unsigned int clk_sel;
>         struct clk *clk;
> -       int clk_num;
>         int ret;
> +       u8 clk_sel, clk_num;
>
>         clk_sel =3D ourport->cfg->clk_sel ? : info->def_clk_sel;
>         for (clk_num =3D 0; clk_num < info->num_clks; clk_num++) {
> @@ -2286,9 +2286,9 @@ s3c24xx_serial_get_options(struct uart_port *port, =
int *baud,
>  {
>         struct clk *clk;
>         unsigned long rate;
> -       unsigned int clk_sel;
>         u32 ulcon, ucon, ubrdiv;
>         char clk_name[MAX_CLK_NAME_LENGTH];
> +       u8 clk_sel;
>
>         ulcon  =3D rd_regl(port, S3C2410_ULCON);
>         ucon   =3D rd_regl(port, S3C2410_UCON);
> --
> 2.43.0.472.g3155946c3a-goog
>
>

