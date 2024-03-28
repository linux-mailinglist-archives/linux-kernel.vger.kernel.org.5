Return-Path: <linux-kernel+bounces-122917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92FB88FF68
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D041C29309
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F205474B;
	Thu, 28 Mar 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r53d+Dai"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C457EF13
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629859; cv=none; b=EaoqyFb++XKpkrBLgab3uufe7e/Y/op0Y5TukkHlQSQ+lBVt3l8HVAW94zlpQsUCW3ynTupH90tApsKaKu/XglvkDA1aVwLaSGitS/mGZBxE/pB58WCpsFWUFsrVMibkt2C60OqCbIBzg2yLJ0qEXAfHCsEGyQy85YdN3eROeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629859; c=relaxed/simple;
	bh=ycgLz/YdtZpr9sFj/Nde0qo6Qn0gBay7Aklp/DytJ8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VS3OzBWv9grIC88WJDdx7Hc7c+pl3Wgj7ha3z7dDrPc1W/mIO2l7FkyYMLiNMSkzAZ7mxqkCLfKPxa1W3+Gv+QxkAvV23K9ES4875Uw+/VzbPkajht9C8rj/pZwY/vIcI8Xwi+BJLRJ08+Rs11Ztp2LZ5vUmexwsw5VkzguQ5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r53d+Dai; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4141156f245so6459115e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711629856; x=1712234656; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ycgLz/YdtZpr9sFj/Nde0qo6Qn0gBay7Aklp/DytJ8Q=;
        b=r53d+DaiQBMLUojPhnMceneCXCd4ksEZ39YVnZsD4YUVTl2aKJiYCFXyf0iuQnIm4g
         3wE7YN8AtIsiIbb1qqPlSYdrY2nUpZPq9z0Eo5mhnFQV5lcn114I2Az91/7BFoXGgbfh
         RC2+ypZnQEDrT5ReTYkKUKsdF92DQAe0UzVnGdh3ieJkSjyilIGAOckpI0258xKAhOag
         Mi2LRKRD9BUiY4L86trO65lnRHtVfv+ihhxpR1lhyGMk06T6e+K/pJ3AmWndWSYJCx0a
         4tQCfhJhVsDsJxINzX06W96AJ3HVX/TVCjKmYQOw/WE8/ZiaS/NJm2XXcnG28+5DGqFW
         fIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629856; x=1712234656;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycgLz/YdtZpr9sFj/Nde0qo6Qn0gBay7Aklp/DytJ8Q=;
        b=bzpeCc08DwdPfdHGFPiLbFkPdnGv4FX2EbRVZrukpVAJqQWkh/l+B9hXxGfud+qqMo
         VW0nQEhXwfu6M0fXnIkvjFIKpoBD0CHq2Nelrj8nTkb3Pz8/T0SrrsDWIlr1TUfuTn4V
         gsO11OH6YwjOPMKi/uBO2FNWja9frhHbFh0FVHSlt73I1OteC/npdSk7jLTNsRShJNUb
         BHNPpx4SkANKS5LOa//UULO9MtzrHKhCOrzU6BQUljYPMwkZGgAzt7LTPlYguFP9dt15
         osLyHXNy525Xhgfia0BkJrgSumJKfp+4gyStTXo5QSZTP70CkljlGKbfbSYTJEOhYIRf
         27tA==
X-Forwarded-Encrypted: i=1; AJvYcCXOW45UUPu+sXW1liJELu+yp+sN36ih9iwqPFGNFQ2c+quLv3fLTyZvMuQTkxoR4svjMr8OFieZ2a2bqUU10fcDW4DO8Nrf23HGWs7o
X-Gm-Message-State: AOJu0YwNRJDz8xSmyqw7WnhffmrYUrLrsPIbU40MtItniQMyaW/Z1hlq
	WKUoLzTygKeWVJ+EYsimDxbNzoytsN7ox84ZiRY+U6gglofW5ejyYdxNHF72D0k=
X-Google-Smtp-Source: AGHT+IHi7Wy4Zr8z26J8O+tGD7IbPNJPd6xA7LXKo9Cp0xgyHhMz0p8MNXQ/AtST8ruBPRMycXkMxw==
X-Received: by 2002:a05:600c:5250:b0:414:d8f:4399 with SMTP id fc16-20020a05600c525000b004140d8f4399mr2353378wmb.18.1711629856206;
        Thu, 28 Mar 2024 05:44:16 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05600c1e2200b004149315600fsm5392316wmb.7.2024.03.28.05.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:44:15 -0700 (PDT)
Message-ID: <2125e654f89ee8c709a48c8e46956ef7645b9d2d.camel@linaro.org>
Subject: Re: [PATCH v3 1/3] clk: samsung: introduce nMUX for MUX clks that
 can reparented
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, peter.griffin@linaro.org, 
	krzysztof.kozlowski@linaro.org
Cc: alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 willmcvicker@google.com, kernel-team@android.com, s.nawrocki@samsung.com, 
 cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 semen.protsenko@linaro.org, linux-clk@vger.kernel.org,
 jaewon02.kim@samsung.com
Date: Thu, 28 Mar 2024 12:44:14 +0000
In-Reply-To: <20240328123440.1387823-2-tudor.ambarus@linaro.org>
References: <20240328123440.1387823-1-tudor.ambarus@linaro.org>
	 <20240328123440.1387823-2-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 12:34 +0000, Tudor Ambarus wrote:
> All samsung MUX clocks that are defined with MUX() set the
> CLK_SET_RATE_NO_REPARENT flag in __MUX(), which prevents MUXes to be
> reparented during clk_set_rate().
>=20
> Introduce nMUX() for MUX clocks that can be reparented on clock rate
> change. "nMUX" comes from "n-to-1 selector", hopefully emphasising that
> the selector can change on clock rate changes. Ideally MUX/MUX_F()
> should change to not have the CLK_SET_RATE_NO_REPARENT flag set by
> default, and all their users to be updated to add the flag back
> (like in the case of DIV and GATE). But this is a very intrusive change
> and because for now only GS101 allows MUX reparenting on clock rate
> change, stick with nMUX().
>=20
> One user of nMUX() will be GS101. GS101 defines MUX clocks that
> are dedicated for each instance of an IP (see MUX USI). The reparenting
> of these MUX clocks will not affect other instances of the same IP or
> different IPs altogether.
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


