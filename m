Return-Path: <linux-kernel+bounces-36684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90083A4FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F421F22EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248E17BC6;
	Wed, 24 Jan 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Yc91Hgio"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2717BCA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087763; cv=none; b=Jl8ynnwdKBKU4hLjEW92HDVKXs6Z6k/lxhXWmsybB9SgIKtImGzR/F9ithr1GyiFaOSkCwN1q1ZRWr5bYVGmi5LD12B5ffrZgOx6bbOjo+tuyWg63xb7p4/iJuf2OhX4W06JIeHEhJjnXlBjZupbS7cvVc1qEeNIQ9FtBssNiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087763; c=relaxed/simple;
	bh=QG5WlILsmM0gId87Rj/yfX0PouwUTYLt7B6wB7wQEMo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=VpBLdEb/patbIRvvwjWae3F7y4ctgvLb0Kosj56d47OVtqaLca+wFUeQ+nTIfWiQUvIMZCqAdSHEiAwDXdcjsF1KgoVOBFON67OMqg+rkTHd0ULhwsYwq4wMsGETPb2pKkUHDtkDhM++7NhqbbCFU2kl1o7Cj5jAJEqIFUkZ3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Yc91Hgio; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337d32cd9c1so4590591f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706087758; x=1706692558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbeFWfMqBmXODESAwukrIPoFDrHKEc0uZI5I1dvJGsU=;
        b=Yc91HgiodveUPWMfGG/vG/otKv7SjGYrbZrcQe7T+ndw4Ld5vvp1Ui0us0A/IUzO57
         Xrs2YaKgHjO5kN1r9K/yyp2+0y2W34GPxxUPJxm/RW1Kna7kZqYlYKJMLhOEuh/SZKCN
         iIX2c/Xg+1YS9Dx+ZxzBAzyvZwuzT4250awb8nZV8VliPXEAVAoebyHzThJ+DMQ6bYKz
         T+CR9suj4RYo9GPI7Ug4I2L+UM3r/ahN+ehRCQdSZTxBJtia0OqSB8gTWybxLE8ZLtRy
         NPTrEATbLqmw55QGWDqJDVhPEFQ7oiySRVv9CTJwonmgCr1P8jaSM++JpLfwTYoA6TWj
         EfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706087758; x=1706692558;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZbeFWfMqBmXODESAwukrIPoFDrHKEc0uZI5I1dvJGsU=;
        b=Tq6qESEDk8wQIRQNHFjfOWhzAGmtfQoyUcQX5i2jVDglOhvYQ34dBMMkGAJGBBzXXS
         3cpvozx9ipRJIR0kgHaUwml3Fak1ihhSJb8IcKsjZYfDLvdPG6OSnAjuhIxENL5RZZJh
         iU3LLQLNA3HfkEW7etQnNomk1YA9BNF+eTMvI5jO+B2Pf3r5bn+/00/2JlM3X2fjMwOv
         zq6vnyaN01CQ9pefOiSwAQ1QuSGrIkqS4qnxxtY/a/o3ufUdsIsNB9ARqvYVxFDumVXX
         JotbN9m2pjwe9Hi6a2CshvmKdznNRwqjR+sbvB4MxV0OIp96Uj9MLNxMehAoq+PMT5Qo
         +xpg==
X-Gm-Message-State: AOJu0YzeO2jqyuk0Rj4d0riOZ8qCL8HPQPFtQHrlaZESAAw0PR9Jrq1D
	cY0OtC3sxYnrYl+pOjK3JqPeF7hJzJ+IaZ9K65pRDPo5rmruOhQsZqgqaqVWn4E=
X-Google-Smtp-Source: AGHT+IEJA4fLxUIPUgV1CoOiF3Njgm57gU/G+2p6y1b7sd2MIpW1H3YSpsDs25CgqLP01So5oXJUjw==
X-Received: by 2002:a5d:554c:0:b0:337:c527:ad54 with SMTP id g12-20020a5d554c000000b00337c527ad54mr337926wrw.77.1706087758478;
        Wed, 24 Jan 2024 01:15:58 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:d8b6:17b6:386f:c67b])
        by smtp.gmail.com with ESMTPSA id g18-20020adff3d2000000b00337f722e5ccsm13609525wrp.65.2024.01.24.01.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:15:58 -0800 (PST)
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-4-jbrunet@baylibre.com>
 <4kcbh4dezgpic2dpgdi2swtx2puqiq74w2tungmxipf4nznpn7@u4g4f3cimps4>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Thierry Reding
 <thierry.reding@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v4 3/6] pwm: meson: generalize 4 inputs clock on meson8
 pwm type
Date: Wed, 24 Jan 2024 10:11:59 +0100
In-reply-to: <4kcbh4dezgpic2dpgdi2swtx2puqiq74w2tungmxipf4nznpn7@u4g4f3cimps4>
Message-ID: <1jy1cfw0qa.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wed 24 Jan 2024 at 10:08, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutr=
onix.de> wrote:

> [[PGP Signed Part:Undecided]]
> Hello Jerome,
>
> On Fri, Dec 22, 2023 at 12:16:51PM +0100, Jerome Brunet wrote:
>> Meson8 pwm type always has 4 input clocks. Some inputs may be grounded,
>> like in the AO domain of some SoCs.
>>=20
>> Drop the parent number parameter and make this is constant.
>> This is also done to make addition of generic meson8 compatible easier.
>>=20
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/pwm/pwm-meson.c | 19 ++++++-------------
>>  1 file changed, 6 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 2971bbf3b5e7..ef50c337f444 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -60,7 +60,7 @@
>>  #define MISC_A_EN		BIT(0)
>>=20=20
>>  #define MESON_NUM_PWMS		2
>> -#define MESON_MAX_MUX_PARENTS	4
>> +#define MESON_NUM_MUX_PARENTS	4
>>=20=20
>>  static struct meson_pwm_channel_data {
>>  	u8		reg_offset;
>> @@ -98,7 +98,6 @@ struct meson_pwm_channel {
>>=20=20
>>  struct meson_pwm_data {
>>  	const char * const *parent_names;
>
> I suggest to make this
>
> 	const char *parent_names[MESON_NUM_MUX_PARENTS];

Ok.

>
> to make it more explicit that really four entries are needed here. This
> also makes is unnecessary to add the additional NULL entries to
> pwm_gxbb_ao_parent_names and the other arrays.

I would normally agree but I'd prefer to be explicit.

There are some instance where the NULL is in the middle, this can't go
away. I think it looks if some inputs are explicitly NULL while the
other are implicit.

Of course, it is just a preference. I can remove these if that is
bothering you.

>
> Best regards
> Uwe


--=20
Jerome

