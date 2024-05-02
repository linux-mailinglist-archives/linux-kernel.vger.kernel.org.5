Return-Path: <linux-kernel+bounces-165891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C17418B9301
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F6D1F22655
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A90125C0;
	Thu,  2 May 2024 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvFJNj9S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99483611E;
	Thu,  2 May 2024 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714611777; cv=none; b=IFrP/nd7gK381DVdI3ZWBneniwJD91HrFm2e0Ia3UHNOPNakl5l7XkOCelKpZGsn0bTXVmlXLY/NchjZQaWl8vPq9r4tlGFWgGIyKpS6cyw3SK7TiZEkIGfWJ7RoJM1bVvoAm6l8wS4dxsSPIGISKt/XPIujNICegygSmFlatJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714611777; c=relaxed/simple;
	bh=Z4wEUkoqXJ4qv2ctmI0odJVCiqdNUxzglaJ5SXR0EzM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=VBlKWCA7N/Sm1AOaIuFYz0HNNdoG81O46uo6burzTFqWokCeBuGsu20EwfRAmnC8zxwG7pgDcl2DIlpakZJbwi2xZFbBPjqURVAP7nibC5PV+eS1qmXIm239aCyVi+oMe3VcuLSPON7TTwMmIQFDnZelBpCwNMFcEHe26TplNwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvFJNj9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7BCC072AA;
	Thu,  2 May 2024 01:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714611777;
	bh=Z4wEUkoqXJ4qv2ctmI0odJVCiqdNUxzglaJ5SXR0EzM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=RvFJNj9Sxn9CGMekWBsimpAU2Ijs+j4atwYU/KYA6eFxPTZZGpAEyDHra4CgUm3w5
	 2doUiDbNvJQby6m/8wRR0VWELx/7svv5X8fjcuSQPL6JnE0HjFU1qoSyix055o1flj
	 HaOzMacdriwBivnHCir4QH8ifKiP1U85sQoGWh04S97sLq0NzeCJydSnUtfhc7SS0I
	 bxbjumGmXJGjwI3y618Ecttl54ikcqlAnkXETAI5+LsAnWLCEAw3UrMODPioHnGz+f
	 cDjJN8J/CjmZsU63UcN3aM50xcPR6V6v81uIOGoDaxDQPR1KFe0P/q8zKnDpQG2l+A
	 T+OXL1cTx/n0g==
Message-ID: <560549ed7db5da2f2727dc053a5d196d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e15b8a1165a5437ab1fa868ccd0b629c.sboyd@kernel.org>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk> <e15b8a1165a5437ab1fa868ccd0b629c.sboyd@kernel.org>
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev entries
From: Stephen Boyd <sboyd@kernel.org>
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Date: Wed, 01 May 2024 18:02:54 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-05-01 17:59:16)
> Quoting Russell King (Oracle) (2024-03-15 04:47:55)
> > Report an error when an attempt to register a clkdev entry results in a
> > truncated string so the problem can be easily spotted.
> >=20
> > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
>=20
> Applied to clk-next
>=20

And backed out because I get a compilation failure

drivers/clk/clkdev.c: In function 'vclkdev_alloc':
drivers/clk/clkdev.c:182:17: error: function 'vclkdev_alloc' might be a can=
didate for 'gnu_printf' format attribute [-Werror=3Dsuggest-attribute=3Dfor=
mat]
  182 |                 res =3D vsnprintf(cla->dev_id, sizeof(cla->dev_id),=
 dev_fmt, ap);
      |                 ^~~
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:244: drivers/clk/clkdev.o] Error 1
make[4]: *** [scripts/Makefile.build:485: drivers/clk] Error 2

