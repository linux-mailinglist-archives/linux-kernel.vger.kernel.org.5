Return-Path: <linux-kernel+bounces-85830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77586BBED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E601C218EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC2F13D2FA;
	Wed, 28 Feb 2024 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGDMpXEL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DA13D2E6;
	Wed, 28 Feb 2024 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161628; cv=none; b=VHiISjWazDsiyeijwSwRYuFvHUs1Zd1aRPAyZN7Gg/OYLT3n/qsP1zbQkqXr/wJO8rrkjbGCkUoRWoY+CZO30FJtEIqTQoqQmaTWWCaw0EMtQD6lKe6wIS6JtTxv2tOfA+a8iVD7D4Uuu+xi3PO538XgGSbyDblksO0+v3ThEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161628; c=relaxed/simple;
	bh=aR4XOGShLBiKaiFwyckrNuJndPej+Cz0PLltPRgtO/0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=I2dkAQ+sqxUSMwIjMXHMGCOu56Gg+OpRd5V6MYFqO1IWq04eys70/AiPXxt7bBHEaZjzspR6AG0p3QMYDwzfeaIe0uOLFoixigPwzSazTE2wUXoHR3X77v4Is7uhdwnQdAZdqGfuK5dpPL9EtTyLnKBkgqoQmAxnbB+9FDJfaUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGDMpXEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CF8C433C7;
	Wed, 28 Feb 2024 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709161627;
	bh=aR4XOGShLBiKaiFwyckrNuJndPej+Cz0PLltPRgtO/0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SGDMpXELHbumNnj2vOipRsbXBpmiviivWs4gnnCaTcxPqWkKBayyehjUyhwqhySRN
	 9UAB8ACDCTBUxi0BAgtivVkCW/NXy+UeiEJa9v3Huivqwj/yfc6VVXqsBXPJndte+5
	 6oGKfrhX+ncpcGWdA7pLNTJvR1u9jfL8GL4C6e/j244TAOj1qZXq+66UNWYfYBGrTX
	 JLa74Ah9kl2vqRV+xNbmzlOhMEmqNVjBzseoIfYjty0wbl+a+Pa7ZGR32+PIH4dqVp
	 A6Feiw6ZcEC6ljZJGDNKpPe/m5dmj3kWwSP/2+baG4bR4qL3wIVuFTe3s4SqOtFbBa
	 WL/OOIqdqJinw==
Message-ID: <f0a90f14993aa0fddb87e658be43341b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240214073318.82573-1-duoming@zju.edu.cn>
References: <20240214073318.82573-1-duoming@zju.edu.cn>
Subject: Re: [PATCH] clk: zynq: Prevent null pointer dereference caused by kmalloc failure
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, michal.simek@amd.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Duoming Zhou <duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2024 15:07:05 -0800
User-Agent: alot/0.10

Quoting Duoming Zhou (2024-02-13 23:33:18)
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index 7bdeaff2bfd..7621c2f0046 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -427,7 +427,7 @@ static void __init zynq_clk_setup(struct device_node =
*np)
>                         SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
> =20
>         tmp =3D strlen("mio_clk_00x");
> -       clk_name =3D kmalloc(tmp, GFP_KERNEL);
> +       clk_name =3D kmalloc(tmp, GFP_KERNEL | __GFP_NOFAIL);

Just make a stack variable please. __GFP_NOFAIL is a bad code smell.

>         for (i =3D 0; i < NUM_MIO_PINS; i++) {
>                 int idx;
>

