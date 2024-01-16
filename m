Return-Path: <linux-kernel+bounces-27673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDAC82F3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A16DB22E27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A4D1CD2D;
	Tue, 16 Jan 2024 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/sjITvh"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D77E1CD22
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429073; cv=none; b=uKSDriMDiTQ/EjfPvcr/cq+VpBreS3tPFSGsZ4Sk4pVJUMh7IJjzfiI+Rp0Mvyzou0dwefsC9CmOiirHAefHJbXEoVzz6ts3P3cmD5+rYWZiWMQND1EwddgPyuJcrJurP51G5GgrNAztOOWeUQTckLkGJyVTNyDaeADCAnKbbF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429073; c=relaxed/simple;
	bh=WG5lpRJP8dm+PmpXpwjviZqq8Ch1yn3VsWzLsOenLqk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ab9BZX/1ii/9LGTn6xYKcEy07HJUrGRxrCcLXFzaj5/6nA9wBng8AJkxwybsoYW3jvB8bSv3OFbmU3lx3kUskEXizOMFQpuTXzZdNH+wQA3EnRePuaEJQ71urue1HCAPjxGG8NcahYKHnbbpn1mV1vR2Rwx+ZoEgrda8YlRCGcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h/sjITvh; arc=none smtp.client-ip=209.85.215.176
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cf1f4f6c3dso3154447a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705429071; x=1706033871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU/OUwU6Tt0/mou55ffpi9+wdwXd2SREUtllUzUBlws=;
        b=h/sjITvhlGyKjioanlOyU6Hv3m0xzqHfgHPmfTa5CfSyokw2E9IfsLB0qjKeI00o6m
         t543UGUbbXKqlYW7/WgbB0IZjqzKzikwC5BefXmI1o2BCFGLM3fZhiH2Jsb9CW6TAtjv
         3PKbN7v3/GITkqSMYwC3KJyeDMH+AVRHuXY44hq8moXTWfScYwOAiulZ1Go1aU4Fu9o/
         szxX78iSBZQClf1XHLKxoC/dYaQKI+Ko8+2ep8TuhFMPn3f/FIEApWr8fdKWRtU+ED6K
         6i2ZMVJDak6j+or9vusFIOfAAKKf3Ka9H0DagVEIadr8+uWDh1BB8IWiGo00hDVdU4Nu
         zheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429071; x=1706033871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PU/OUwU6Tt0/mou55ffpi9+wdwXd2SREUtllUzUBlws=;
        b=K4O3+6qH0einb9HW2H+fdURhX6rFsNlXPIhMu9/VjxgVoj55eXMZIAJWBkZ/89hQNF
         sjRKidxK0tRKUusiuuKImux/VEWbvWADmEmtIjcdZIwLmfoH6WihSvDz0IXQ5aQniI/6
         ardRBqFBveyLmgqKXr1K1+50T3yWQs1YotYskIlitGUlCXZgT57xO0DOHTvNdmbKZinx
         XKyfwAkARE19FFbKzqVNvJjqOm9qZYysW23DB7Xtc+ziNNex24oJzmP588TQka6qxggH
         ZoZ3OyIoMc6qi7NZfyCljk3Xc/1Yjw7UaBSdvKeVPwmThv5aE6/g/7m+1Nsd9tE+D2aH
         ZLIg==
X-Gm-Message-State: AOJu0YxeO1qkBvmbXgDP11z/MGmOWINTvFE551ZuigTjViwj7jHH1Nay
	ZCpha+nKMR5GOaV2akwnFDSulS8ASkvfXXP33ZzXOY2rZ9xgcw==
X-Google-Smtp-Source: AGHT+IEp6PYSWmRrOal3JJTb3lNFkRssc4tZumGDxit/TefbAvez0riAvS1TihjA/yeGkzi4Dqwl3A3SYNQJz3Qy+K4=
X-Received: by 2002:a17:90a:f486:b0:28c:1a80:a8cf with SMTP id
 bx6-20020a17090af48600b0028c1a80a8cfmr3328299pjb.35.1705429071530; Tue, 16
 Jan 2024 10:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-8-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-8-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:17:40 -0600
Message-ID: <CAPLW+4=QykW1GMHN8QNqH-8Jop+d2z_C3nXhjXZ8VN6bOj9T6A@mail.gmail.com>
Subject: Re: [PATCH 07/18] tty: serial: samsung: remove braces on single
 statement block
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:22=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> Braces {} are not necessary for single statement blocks.
> Remove braces on single statement block.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index d5f9bec24b8e..11ae3a1dcdc3 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2062,9 +2062,8 @@ static void s3c24xx_serial_remove(struct platform_d=
evice *dev)
>  {
>         struct uart_port *port =3D s3c24xx_dev_to_port(&dev->dev);
>
> -       if (port) {
> +       if (port)
>                 uart_remove_one_port(&s3c24xx_uart_drv, port);
> -       }
>
>         uart_unregister_driver(&s3c24xx_uart_drv);
>  }
> --
> 2.43.0.472.g3155946c3a-goog
>
>

