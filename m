Return-Path: <linux-kernel+bounces-131316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A9C898623
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB9F2870E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B33883A18;
	Thu,  4 Apr 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhKZZE8L"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B6839F8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230824; cv=none; b=TY6bd8RejMQO/qCKm82bKoCmCrqWbTDY2gmLPn/D+B8rVZg57K+PIAfvwt5mOrLQA9w//4alnsoUXfFIDLvxQZvXqlw3Emrx57E2E5FbPnyB3Ce/EqdlzObCXfQV+zBlcf17q+LhYntQ0ep8o50q1t00Bh8QGQryFD1Xb7IPNlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230824; c=relaxed/simple;
	bh=WvmD+zW80mCHMaqxRf0H4QSSZ96J4F1GjnqGYV5LYDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jk8xqj4fcQcnY3OLm89QrJaoZzOj9+yRM5R6NDRRS6ay0HJ3jPVW1FKNkQUpES65RfEwx2jSzBOwrS24u5pk7+4uxzcnE7liWzN/w27hUAgUdpkinASY7LTC/sULgDdKOHgk8f/IK5GBEFGVw2NsEc3GY4VwWVQyGGTnAZzUjEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vhKZZE8L; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6152088aa81so9680467b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712230822; x=1712835622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvmD+zW80mCHMaqxRf0H4QSSZ96J4F1GjnqGYV5LYDM=;
        b=vhKZZE8LCUpC7TmGcpPZtmobq3VonzCnzr00GKruaz8H8rS+3A7Vgtxpelw0ex6SnY
         TRnihWCzbzGP/SGsbz+/BEcH8h+M7zD8T0YL+sNKPS/fXGq2zR6oi00VOqvCWEYmtGh1
         zI/lMDshyoJvrv5JfRYqICI2nVaiMr2LVmakqKrd2Ysu2xLh8b2U5tPM0+cgJllv2/I2
         Gw7K3+xuHU+Xnsp2OPAxmQKxHpMLt06ZxZYnrhpBiBTOGzNn+32Sl4GuhO3pyGoDIELV
         OdohM861Jgk/3c3kz+vkBCE1EvY0SoQJNo0VqW9VOyqjIWU1lwFg5lbvZhJwTNPE+wkq
         Dqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230822; x=1712835622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvmD+zW80mCHMaqxRf0H4QSSZ96J4F1GjnqGYV5LYDM=;
        b=ev9Sz/HJZXE63hf5HllTk00qQyzZh/zTXrhP4PGc8Q5xntV5ktLFOhh7eTInV1ATzC
         vyROrssiquApT/Z+vPZZlEeoeg9EumFFjaarQ/zGkkewJhuR+4sx0lqrAQ3dD0fnmbLB
         XKrelfcdKiuTSiY4YPxsLCkpCWnvSA1azsluIp8Upi7BhOVbusuDRNPrEVru72kHz8Hj
         SkgaGg5x/xE79vvo2jEISSy9iD6jhA5hkhdz2vAapTTZYt9hkBZWxiA1C3TuRHFosjGu
         XWc0SPnn0Ix/8BpHLsLBSqTTusFDPb0ovXgoHrZb3hT5BwqVjxmPZvQJh1RuH/4AfWAX
         lDWg==
X-Forwarded-Encrypted: i=1; AJvYcCVCVJa5Vm+ANDUIpZwhF1GStMsuLqVhODJ098MOUgofzpD6MdfXvwpX6aco8I5T5zEjwZIsqOE/RpdEcSlY342or6xR7qoXhQtihrc/
X-Gm-Message-State: AOJu0YyeCRx9sChI6y5+kvRtYKQElnYAGLnQTPxmclb17FjAvzLMkoHR
	qC7Ja3jOMHg001fmK+GSkJ2SnQOak5Ridixdai/lgBKUmxNx9t5fFSh9dPH1crxmQjWVrcm0VmD
	qaf06kDdsUyWJE9lFll3KcD7NlLcSwQo0OYx6dvQjiHHXCWBE
X-Google-Smtp-Source: AGHT+IGd7buOnq4d3z5iEEVkv54BdiBPBzE/CfnnmwzmaRZinGTBmvb2QLdzwpSE7CR42SbuiExNTwe5Lviz1MibIB4=
X-Received: by 2002:a25:8206:0:b0:dcd:a9ad:7d67 with SMTP id
 q6-20020a258206000000b00dcda9ad7d67mr2503123ybk.8.1712230822049; Thu, 04 Apr
 2024 04:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330210954.100842-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240330210954.100842-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 13:40:11 +0200
Message-ID: <CACRpkdZGMibZe1xeEBDGBZKtpw2iDhBnm4W2+Ef+KMMDG5BaCg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: sun9i-a80-r: drop driver owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 10:09=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij

