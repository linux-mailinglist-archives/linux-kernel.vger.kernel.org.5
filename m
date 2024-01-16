Return-Path: <linux-kernel+bounces-27671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B3F82F3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAF1B22296
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E1D1CFA9;
	Tue, 16 Jan 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvE9pEf7"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBBA1CF8C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428910; cv=none; b=kQRQQhOH0vIS+dVzvJ5wuveJ4PTxAMY7pScxSBAcwOCY4xNZ440ovLPk9Kx4v4XgNRZkL1Cg6jvogHMrUa2v/qJ3WACKHwimhEPOku5rvy/c7g7kpmGg3a8q154mJq2Zqwj7vtFyVG8rIVKZ19jZXOdD2ZY2hbZGTq8gDgsHiaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428910; c=relaxed/simple;
	bh=qrALAj93hJfKc1MNN3ipAEuXZ051sG7zKIrmiPYZzmY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ndAqJ4uql1tCqOkC2M52pJJbllAAP45qGPeAUeXB3BR/A9yXKF1MJdSsHtcG0/8WX1ZSvDWDSdtFdO4cjhH3ZXeuiSjKMeKXNaDFD+saXmx/MOMSTNx04ctqvlVR84bpD2xEu7ZCMNpHZAKcZlbqHnXNmL8TaMen0/GaLMmOdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vvE9pEf7; arc=none smtp.client-ip=209.85.166.54
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bf2c826a5aso180465839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705428908; x=1706033708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDg8fja1Z3zcpDVo0w4GZwyvSycEiXSrGE+rl8PhHKA=;
        b=vvE9pEf7c+tbiFqMk68CZmhdc+jxTEhxukr4AdN4VvLKeIWN0w+1uSP65J6Y1uMWcu
         /e2UOvxilFiD0wHVlUVxxUVUA5rrNRIt4yGmf8Waaq+DRrrIlFh3oEosY/z5c+HPnl33
         emtBd/4CxAZQ2EcKKPUhw+WJ5RtJKeGfvfUZ/MD99zkTkkeGqjZVrtzEK50ZZZvO5riz
         J4rWSng2TEhPys2OvWBoc+nDH/Qn9BhD+AhmYJStcc6ngX/doZI0kcsW58mL2Sn5oMxq
         0E0sb89x2w4Zil3k6SpjN1qYWP9J7xHa7w/npsrASMcjfzP3eXLD26jmgN+HuZKfOD7H
         qNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428908; x=1706033708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDg8fja1Z3zcpDVo0w4GZwyvSycEiXSrGE+rl8PhHKA=;
        b=W9XINJ7Jb1iI8WzN2q9dZLU8GZDnMKVifhTT6ENYzxh2Bxs1KoVMsIru8Vi8HrkH7W
         udhmNI9R9DTg2VKbGeAC8PoKNkTLBHpLt9Mkz9fJlyKUCUUKV+CNIbIaujE+Q43BZjdG
         UrbXnCFw2P9vHOAnK23lF5yEIXu29I/Z5ebYmtdpKE9LnybMfmOH6R+rLI+RbKGSl+Qv
         IjUALSHq529I12HnDYXD+U2j1zb2xGLS/xVZx5w7ksMlY2PMBBJ6rXyYuSnTRgTNnrKr
         oH9VSY5CeGkB9Op0knEsVZ7Mj6DjmOnZTezU2/EbyafulcqbcW+vOKSsOZ7xHGh1hbhr
         TPnw==
X-Gm-Message-State: AOJu0YzJd6BfD0UoxwIQqBm0694/aei+YhIu+8qTqyQh6wRpSP8D5UCY
	UizaPClmOT2MZkm4p3R0w5oPIUxsGV4brMO39BDSdaMpP3uYbw==
X-Google-Smtp-Source: AGHT+IG0LK1z8tU2o/mWho/C5jYSHAhoJkweD4wO73l7I1Bd/alKTbKfG2JOMLumvq544rCNYAx0SdWQtO9DT9QDD5Y=
X-Received: by 2002:a5d:9c42:0:b0:7ba:9123:6711 with SMTP id
 2-20020a5d9c42000000b007ba91236711mr8335903iof.15.1705428908670; Tue, 16 Jan
 2024 10:15:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-6-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-6-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:14:57 -0600
Message-ID: <CAPLW+4k27cizP7KHhFoZ96=riF+ZnhqBbRo6X4SULvVetSEQeg@mail.gmail.com>
Subject: Re: [PATCH 05/18] tty: serial: samsung: explicitly include <linux/types.h>
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
> samsung_tty.c uses u32 and relies on <linux/console.h> to include
> <linux/types.h>. Explicitly include <linux/types.h>. We shall aim to
> have the driver self contained.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index f37d6724bfe5..b8b71a0109ea 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -41,6 +41,7 @@
>  #include <linux/sysrq.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> +#include <linux/types.h>
>
>  #include <asm/irq.h>
>
> --
> 2.43.0.472.g3155946c3a-goog
>
>

