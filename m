Return-Path: <linux-kernel+bounces-154395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C98ADB96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98F41F21BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F282134C6;
	Tue, 23 Apr 2024 01:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV6U0IgY"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C912125C0;
	Tue, 23 Apr 2024 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713836317; cv=none; b=VdC/THMxK6Audr0Prq3ghhpH/6rsXquUU4KZ0au6rHYz4oQWV4dEaQd+wrO2jeFtqOAxBUSl9UrQC973oFmd95gp2n5RqHJ8FeVPvuB3TETWbwG/h3XZn9IpDrwjCqVDcm4aAyLtd46Y6/VX710Qc2fclv6vuATnydqzCMGRceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713836317; c=relaxed/simple;
	bh=C7wCWBdC6TfEVr3TjcsdkpMwWzcgG7xcQ19WyXxt6JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3BO5LE795zt5HKW3/hctDK+c2lgKT34geOQ0dQwFERJpqFV73frIO2MO80eaFYhs5rQfByqeoSN+C3IbLujgOakMnMeiO8xX5WOn5NEPaWTiRnxG2/ox3pz+nAKeMZfAD1FKzbZshzoWZ+Nh9F/UC02x3WbHrHEv1lIelRZXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV6U0IgY; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa20adda1dso3307687eaf.1;
        Mon, 22 Apr 2024 18:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713836315; x=1714441115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rtki28GfeCNBbS4WQvcAXIspTIGgU1gSHxdtSjsBoQ=;
        b=KV6U0IgYxkTNCiqT9WovlNoHV92yFinLl0WZkn3DipJUfk6jw1Nlzqgh6cqg5Mixjd
         2/dyrkbpjHNcgDKilUZhu8olZigHXmHzrz4Eb3Sqs60ivm56BBRhKE+t12zzEJpnzNkb
         yNgYAO0phnGBw3yP9AShswcE8tyzlJxCH2J8dYwrpGDpdyvVwySlnaob/HikbFO0nv+X
         /yKqQ6hfNVxcVTqcJa2VInVGMJRiC6H2apLA+csanHLe2uuch8/CW7JdLvuiybJuqhQN
         SadO2aacd7yppnNKkdxiLLXIH9xAq7luGLvlCtD4dFMAS3jUMAJVJLqU1Hr75tUR6V2i
         guhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713836315; x=1714441115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rtki28GfeCNBbS4WQvcAXIspTIGgU1gSHxdtSjsBoQ=;
        b=UdI3iip5ZILLFT1DkWm0dzR5AlNVq+an5Z5Ysy63KLrKrLvNmlzY15f+ixPtoVN9Ut
         F7up3XpNXVjOWxvUp8+NyIO7A12+EhQ6libfgIrTE2FsOICoi4yBbWiaOKF0bLiWASDU
         xQU2VZ/5pf9bqOGIpMJsaF2yQbEfPKYzT3ULlk+Zmjh4binufgt3rXLGmEw0Ke8xVEwq
         Lfl/YgWVDnd4QBGG1ki2jy+RKyIgdwOhV0ZkKme5pSYjWqcuwug8Vr7yqjpsy2mXDkfp
         I/CqE23Zb1c6Xh481Kwu9DxgHuhT1CIE/MFAhg4V72tH1wwmQzROhLV7sSrjcYFFLZOF
         EwjA==
X-Forwarded-Encrypted: i=1; AJvYcCV39arVd4X70eVNQBAgiZ1ZBuOYFjy333uDYn2Z/JC1bDTTiCmiuxB+LiFrbE36JUa0zMtvXK2WVLI8eSbB48mBO8BxaQF2DoHSxmA+DfLZWgV9ljnv7x0iyetgZaPSvV2kRueXXUk=
X-Gm-Message-State: AOJu0Yx5eKnPN+2UF94uRnECMw4XG3FFa6heiDD6pbbiBuMQq7XpPute
	d+1zWUT29DlCol5SO8A+L3iLErF0bNdMPZKywH8pEXutFssnW2Wfr44gLj1Wq7zYmDwPPKlFdet
	9s1XrHUiIm6oUph6dL/taBktp2Sk=
X-Google-Smtp-Source: AGHT+IG1zcBxOQ8bycSUmKLWA3VWv8PCkHeLT1dbvOXgXVbRhgdUjlCXa+0aqQsTbjhbjt6Hejy2UbCBtX5QmIR2nMk=
X-Received: by 2002:a05:6358:9792:b0:183:fb11:adeb with SMTP id
 f18-20020a056358979200b00183fb11adebmr15644866rwb.21.1713836315176; Mon, 22
 Apr 2024 18:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <285de20a187f3e4baeb28f639b5bf55e914a3821.1713756666.git.viresh.kumar@linaro.org>
In-Reply-To: <285de20a187f3e4baeb28f639b5bf55e914a3821.1713756666.git.viresh.kumar@linaro.org>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 23 Apr 2024 11:38:24 +1000
Message-ID: <CAGRGNgWHkVkOP13jh-w1KQYeR_yeq1JgOt9a+R40F8DGYKMtkg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: sun50i: Fix build warning around snprint()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yangtao Li <tiny.windzz@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, kernel test robot <lkp@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Mon, Apr 22, 2024 at 1:31=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The Sun50i driver generates a warning with W=3D1:
>
> warning: '%d' directive output may be truncated writing between 1 and 10 =
bytes into a region of size 2 [-Wformat-truncation=3D]
>
> Fix it by allocating a big enough array to print an integer.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404191715.LDwMm2gP-lkp@i=
ntel.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This'll absolutely fix the issue here, so:

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

However:

> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun=
50i-cpufreq-nvmem.c
> index 30e5c337611c..cd50cea16a87 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -208,7 +206,7 @@ static int sun50i_cpufreq_get_efuse(void)
>  static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  {
>         int *opp_tokens;
> -       char name[MAX_NAME_LEN];
> +       char name[] =3D "speedXXXXXXXXXXX"; /* Integers can take 11 chars=
 max */

Would it make sense to just set a static length for the string here,
say 17-20 characters and add a comment explaining the number, say: /*
"speed" + 11 chars for the int */

The string constant, while it'll probably be optimised away, seems
weird and wasteful.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

