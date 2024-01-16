Return-Path: <linux-kernel+bounces-27676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC3082F3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3101C2392E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453AD1CFB5;
	Tue, 16 Jan 2024 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRp7oB14"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4301CF83
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429093; cv=none; b=i3ZavVtPBPAL8SDNDHyVLk2NN4LOwJroNBFYAVQ10be9roAnjjU4KZssWg4Fr4S5Wp4/WtO1O76hQ36OLI8ttRRxTAdg39LskQ0E6I1xBJyats8pOmCyYy2XurzRtwLVWPQ7Vo1CLVUlb8/nfeZ5wEhwA0ReUAh5jVkUVhk3Xm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429093; c=relaxed/simple;
	bh=gKTkgQrZ49Y9ypGVnL4BuMEuKgsHCL1mmdyBQRQ7TyM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=jMyC+Y9g/ldXYqhXpwLGjGcCyNWS6FgN1M+PYbKMa2Owdf7d8TxpUltR4pXrJd30bG0mRjfB/O7L3JDa9H2FdY2rqVKHCtYyBuoXVSMvD5KliqRrXHka3eYZHv0Vwds76SFw5sWXXo2sThy2RaY2UMDSiQZJ8ftxm+HNmuPpboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zRp7oB14; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso3608624a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705429091; x=1706033891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJooin9XTx4g3x3a9c7SBIxC9eNa2n9cCWHm63C9sSo=;
        b=zRp7oB147QO+I2o3hq79h6wka3bcgMLkOSALgvFUpwnMywOFBP5kJPBEUC8PhpRXtA
         KXiHqlvjR7vwXpd1xUvrsuJDsrw15v9nREGTbhv8LueGrYT7oam/uGLX5WimynX/F64h
         1szairMFRms95dn9HP0UvQqPBZ7T3h6iMevoUt0AQUrM0D1JI240LeEGd+x6Ekqxrmdt
         8SUYJWtYGNoSKs/YiLkTSsgDtBIplMQDJXA5217B7dHjfu5pMolmNVxPSJ/6YJFZkdSM
         2wPCuBXEI+ekkwEbd9gxv9SA9eWdlzdeByBVwDjdmaET7tzcN0uCts/YS3hR3kydEWKH
         lyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429091; x=1706033891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJooin9XTx4g3x3a9c7SBIxC9eNa2n9cCWHm63C9sSo=;
        b=fdDjbOlk3poc9rHG3i4fOOWQWrgwcYLvMSx+xDgRbJGM6Sm7wcr3sB0zfaEbLVHtet
         Czh+tCpGfqpdPDtWePQzGIo7jK6i+Y8QwJ3VdTDIViVONB5Zk/fFJt9YOQWpj4+PvN8x
         2yhHI9i9kVgi6kFEmgnoVd3mMkaowQQIhewV11iUKPTJvnhpSkHjx53hzF+nk8RGPuiD
         FaPk3WMDZHTDGcabXEEod/Z9gwVuCVQreik2kfMB0YqecAh4MCeOBgwphttkRgD6q0Rp
         dGF+ob8AdOTwXHthqQemM3WJe9ra4Nq3puUPC1NwQ7UCkPuZ6NTbOsg3Hc8A3N/4A2Gs
         e7dQ==
X-Gm-Message-State: AOJu0Yy2D5ro+MbvnSnVijEoYary36Z8ZMz2nkrU7XaoZBcqrvRhZiDA
	wQmt8tsTBJpnB/cJ2sh4j+04Uutz+VAUUf0nmeZiETFG4yIRtw==
X-Google-Smtp-Source: AGHT+IGSVRpaZ7py0aGDcXqUGB1wR1pdRNGkrbP520E/PLnsPPWJZ6RT2l0QCqMxgJNKCi+AWA26QY6IY55+lhtrXOA=
X-Received: by 2002:a17:90a:6586:b0:28c:4a6:2190 with SMTP id
 k6-20020a17090a658600b0028c04a62190mr4488921pjj.10.1705429091652; Tue, 16 Jan
 2024 10:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-9-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-9-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:18:00 -0600
Message-ID: <CAPLW+4=yQYQvMKuMX68_kmCtV8C_EUD2a1UHQBCpg4x186FtaA@mail.gmail.com>
Subject: Re: [PATCH 08/18] tty: serial: samsung: move open brace '{' on the
 next line
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
> Move open brace '{' following function definition on the next line.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 11ae3a1dcdc3..b9d1ef67468c 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1740,7 +1740,8 @@ static struct uart_driver s3c24xx_uart_drv =3D {
>
>  static struct s3c24xx_uart_port s3c24xx_serial_ports[UART_NR];
>
> -static void s3c24xx_serial_init_port_default(int index) {
> +static void s3c24xx_serial_init_port_default(int index)
> +{
>         struct uart_port *port =3D &s3c24xx_serial_ports[index].port;
>
>         spin_lock_init(&port->lock);
> --
> 2.43.0.472.g3155946c3a-goog
>
>

