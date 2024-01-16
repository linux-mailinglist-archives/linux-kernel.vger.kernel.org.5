Return-Path: <linux-kernel+bounces-27742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CFB82F522
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CD01C23853
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32EF1CFBC;
	Tue, 16 Jan 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+umYIXv"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC51CFAD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432461; cv=none; b=pkQr9p7iqpoui9CQOU+LiPd0cazssooZy54k0KSde0aQNnYsJI2cIcIl6DWzFXbbVYxbM2d3NYT0zpTMHTNhoJopoi6mU/N0jctRFxDB9cim9dqPSXdX8vpn/wTmV/PFYpUNtut07/Tgw3Uj6QW9QElklCZcj+JBA7mPuph0fpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432461; c=relaxed/simple;
	bh=tHHMfsJONdhC8WZ79Hn2TbqMaaYO3Ty1FU6Un8zRB9U=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=TjV6ACNFqpDpDwFE2JXYNn2jyS6LxDni/MbCBnblGgyhF0Ye+QauhLt6he5HQVik/041MCxg3hlsnBEdyuHvc3S9LC9+bVQP8MRA5CyjLJrolejxbqZEk7UXUldgVYz4fc63bv8p23Azy4yUn8Y0MtmOCNTSnp1Zf/lXEt/Eru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+umYIXv; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28bc7155755so5208560a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705432459; x=1706037259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wu2EkuxtCd7101cuYwG04c7XmYy7BgrOiun/4NaPNYc=;
        b=G+umYIXv+70+dKnaPOxlgIjfmZldYkPdE2cb6ow7I1Pupu588wjm6j8GKH48acpR/P
         c17wdayEPHGRgIKFXZRESgc14vGnMK6UpEG5mVjDbivBHAzKvRBbSXZWUnRRHNU2MlJX
         BkN8dERy3VDiKks1MbmKYhpggmJFHIW7lE57er2HfFrqg57RADR3KZa6xOlxxgtubMQc
         2wK07cXv9Xh4otDAM1WxBSG6yXjIJWtZdYReD1OF0/egfa2hAJOM4yrEukI+tA0rOlsw
         a2srUZywxfMbkEiaTnH7j+asYm2q/cDjJ0eZZWyn6rqaChxQwXrP8HpiJGkz5tbx3bpZ
         HhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705432459; x=1706037259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wu2EkuxtCd7101cuYwG04c7XmYy7BgrOiun/4NaPNYc=;
        b=Lz6ejuii9MUyy1UzLC1zToFLAAgFdm0pQRKX6T2jwhReFrTaBnESbSOOhiV+zkNk1D
         AYnL9HLuAnOq7pUUVkwdset7rvfQ4s1yzfzJ7g+hSWSbo/mjVXjb9PxRsnEwlCa1rr4e
         UOJ8jTMqqYSxAEXxjMNe2UcA3mSjmVkG/BnNM6PB6cc2p4J7ajY8YPDPkz2jVdxBj76g
         MmzXx5zVVoF9Y2vAuUJb8rQueKC3yY865SvN5K6R1cx4kIFlajKGkrAj2HmwnR8uPLvs
         MEGaEgUw/SjpXq+51RPFg5tgzLiAmpqwecSUAglkxZqYkyo0l5rMIpGHfA6yx9nOTlTO
         tFIA==
X-Gm-Message-State: AOJu0YxPmmOjh42K7HYPvhYfP5wUdeUBuWaNQ26yOLgDoD7It6+N+Xft
	QAliiVbKko67UiOFg0OnMMVV+R4Uv7wDXSe6WS9ip13j85Vtkg==
X-Google-Smtp-Source: AGHT+IH3VMyhy/DermA3tnDW8MMuf27J1wox02DOvvLMsVMpzyMtJM6CWMatLrTLAkbtcnzi4+GCFz3fiTExoM57pAw=
X-Received: by 2002:a17:90a:744c:b0:28c:6720:9ed4 with SMTP id
 o12-20020a17090a744c00b0028c67209ed4mr4470646pjk.16.1705432459291; Tue, 16
 Jan 2024 11:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-19-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-19-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 13:14:08 -0600
Message-ID: <CAPLW+4mPB+uPssLLMXsdZ6Pj4V38FJg6N93PEhcXSZ1yUwkANA@mail.gmail.com>
Subject: Re: [PATCH 18/18] tty: serial: samsung: shrink memory footprint of
 ``struct s3c24xx_uart_info``
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:26=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> Use u32 for the members of ``struct s3c24xx_uart_info`` that are used
> for register interactions. The purpose of these members becomes clearer.
>
> The greater benefit of this change is that it also reduces the memory
> footprint of the struct, allowing 64-bit architectures to use a
> single cacheline for the entire struct.
>
> struct s3c24xx_uart_info {
>         const char  *              name;                 /*     0     8 *=
/
>         enum s3c24xx_port_type     type;                 /*     8     4 *=
/
>         unsigned int               port_type;            /*    12     4 *=
/
>         unsigned int               fifosize;             /*    16     4 *=
/
>         u32                        rx_fifomask;          /*    20     4 *=
/
>         u32                        rx_fifoshift;         /*    24     4 *=
/
>         u32                        rx_fifofull;          /*    28     4 *=
/
>         u32                        tx_fifomask;          /*    32     4 *=
/
>         u32                        tx_fifoshift;         /*    36     4 *=
/
>         u32                        tx_fifofull;          /*    40     4 *=
/
>         u32                        clksel_mask;          /*    44     4 *=
/
>         u32                        clksel_shift;         /*    48     4 *=
/
>         u32                        ucon_mask;            /*    52     4 *=
/
>         u8                         def_clk_sel;          /*    56     1 *=
/
>         u8                         num_clks;             /*    57     1 *=
/
>         u8                         iotype;               /*    58     1 *=
/
>         u8                         has_divslot:1;        /*    59: 0  1 *=
/
>
>         /* size: 64, cachelines: 1, members: 17 */
>         /* padding: 4 */
>         /* bit_padding: 7 bits */
> };
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 598d9fe7a492..40dceb41acb7 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -75,15 +75,15 @@ struct s3c24xx_uart_info {
>         enum s3c24xx_port_type  type;
>         unsigned int            port_type;
>         unsigned int            fifosize;
> -       unsigned long           rx_fifomask;
> -       unsigned long           rx_fifoshift;
> -       unsigned long           rx_fifofull;
> -       unsigned long           tx_fifomask;
> -       unsigned long           tx_fifoshift;
> -       unsigned long           tx_fifofull;
> -       unsigned long           clksel_mask;
> -       unsigned long           clksel_shift;
> -       unsigned long           ucon_mask;
> +       u32                     rx_fifomask;
> +       u32                     rx_fifoshift;
> +       u32                     rx_fifofull;
> +       u32                     tx_fifomask;
> +       u32                     tx_fifoshift;
> +       u32                     tx_fifofull;
> +       u32                     clksel_mask;
> +       u32                     clksel_shift;
> +       u32                     ucon_mask;
>         u8                      def_clk_sel;
>         u8                      num_clks;
>         u8                      iotype;
> --
> 2.43.0.472.g3155946c3a-goog
>
>

