Return-Path: <linux-kernel+bounces-27678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B9E82F400
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA5B1C21104
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B11CFA9;
	Tue, 16 Jan 2024 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+Uiei5A"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE41CF9B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429121; cv=none; b=lRJLrtZqreY3WQhbBtCB5fF5g8TExQ8IezxCm8UldaDpo4U8OWvzUVwo5Dg40EsqdSRJ3sunGhO7hOpv/357WiZdNqDxC8HjsYc9vM+GuGwBjfGCS0iqCqPHkBOFxGofEihRcRN97z0w23DlFzuLoUN+n4A9A3jErI+9Mq63EtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429121; c=relaxed/simple;
	bh=9LCtHhuBxXswmvcVt20Vs3SsXEZWkZxwdcjfucQiMgM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Gy9feh5863fCPQbGvG1XoUOre2JkpTfjdCFT33dyxt0Kfvd3M4GyA8v/p7kz9e53flzcY0CyWSPNanEMljTASl6H80RvvkJ/Vm+7Cr+3G6ygN3Phed3/OpTF8uD3PH9H4OWhG52qD5ZppR3kQ8yoyvdAr5FGxiiRHIBqmFdVjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+Uiei5A; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d5f252411aso4636735ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705429120; x=1706033920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAhjgUfJByTS52hcNwXo1XRbsYtHCOeab0hYvWz4vCc=;
        b=j+Uiei5AD7qe8SFinb1i4uze6GeheuG7zuf1OLs05nuw4HbkxEanAuGSeNW+UYNIXf
         imjh+cyTGasUMp/4Kh6f7Xcucv60vTSur4Udb0aDMD6o/RyhDLKuB0BmZDtQwSnoezXW
         Qjclz/uKPHLjpciLOKI1t8G7voBF4mnylvp3s8sjfGzWbYcil1eASXJkizO6J/lela/H
         o8JiXXdDntj8gF1omf1hgblKIL9MPYKH/RC2cICOXRf6RKT8J4JKXzNep4806HgwLW7v
         cbNvlq5dtuhPFh0eLwYio2XsHgsDXKcq03udKkKIo6odkWETCZXrNLfFTW3zY+qy+NVc
         QO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429120; x=1706033920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAhjgUfJByTS52hcNwXo1XRbsYtHCOeab0hYvWz4vCc=;
        b=RSEIDqGzRE/W7K6IWoJKwGdzroyqc2FU71H9hyAy/awf39N3raqEyqLs6tQimPpXKt
         UqHtvHrhOlD83WfgiFHlcmlUi2UuEenJkZmj0OSx/yiguxyz+aOP8J4rYlaKNYpNzQX+
         XMlEjVIIpetKXtB+NSdQxCuamjYjX3f+eCvuIqJQ1R1JHnn6F07GOb4ccMTe/9iLAu9h
         HOSSJ5sJZsi8quBB+905IP2cNpYtdys4KOYZeciF47wxJtv9LfJoIhJuMfda8+ND1Eqa
         zIaLYZzT3OM+/ie04P8yy/HmozpBy4bGs09zptDcc5fv78RtfozxQ/T6vMGFENYewv2d
         EWSQ==
X-Gm-Message-State: AOJu0YxVPp3CBM9QHoYUTotFq/TAjjED+4b+o7B/jIt0cW6kNojpC+lj
	rIxZkjSvVHKwfbgzJFNMxDflSUmCUAj2pgZu4mvfdmkaHd3bXw==
X-Google-Smtp-Source: AGHT+IEfexzqZKM1MUiibGWNM+CK1iYq5GFuz8TAA9Jxp0kMBk0KePbVvTge5xjyIEdLfYcwiesHqxPs1kRT46+thsI=
X-Received: by 2002:a17:902:f68f:b0:1d4:2f1c:825a with SMTP id
 l15-20020a170902f68f00b001d42f1c825amr5323807plg.102.1705429119955; Tue, 16
 Jan 2024 10:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-10-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-10-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:18:28 -0600
Message-ID: <CAPLW+4nJALwC=ri-jgOWktkd74xJoGyYPeGvf1sY_tjYX_40wg@mail.gmail.com>
Subject: Re: [PATCH 09/18] tty: serial: samsung: drop superfluous comment
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
> The comment brings no benefit as we can already see from the method's
> name, ``s3c24xx_serial_pm``, that it deals with power management.
> Drop the superfluous comment.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index b9d1ef67468c..90c49197efc7 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1296,8 +1296,6 @@ static int apple_s5l_serial_startup(struct uart_por=
t *port)
>         return ret;
>  }
>
> -/* power power management control */
> -
>  static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level=
,
>                               unsigned int old)
>  {
> --
> 2.43.0.472.g3155946c3a-goog
>
>

