Return-Path: <linux-kernel+bounces-152087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CC78AB8AA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CB81C20C31
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681885382;
	Sat, 20 Apr 2024 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNv48lx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8966A32;
	Sat, 20 Apr 2024 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713579009; cv=none; b=N/uGIV/KHqnhx4PAyj2K7G9fobUKgK9JMOzSsCfziEpRpCM1Ax4yGEcghVKAOuVpnrf5dQVls/iyh/swvakczDUCHu0aIzi134fDXOvHFMkk/5CMmiMFoaeJfKsjIcp6wJl2DRxx/JFF42didDy7Ku1D8H6HS2Z4k9ELMqyTqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713579009; c=relaxed/simple;
	bh=4VDaZXPPLa3wpQWtduGASy2U18qxN/rGji3cXpKwxyw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Z64aOsyc8mdIzUwHgds3ygeNqIosfkdRK+A0ao08YafSaVuMFygSePq2rBTRMPXVEEDc1MCIzTibpaxu7OtXQmrxeNZa1/d/tQyNxL+WYIPD+UIXZH2udnAvvUXce1oTT5aqk88btDApnB5KllI30o//dKBJqyYlf4b5dn4LKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNv48lx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DEDC072AA;
	Sat, 20 Apr 2024 02:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713579009;
	bh=4VDaZXPPLa3wpQWtduGASy2U18qxN/rGji3cXpKwxyw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MNv48lx0625h0X3YQvOrRKrK7l+9YoNCVh+8qD+71pbA1HijLlNtmxz1ZvFm1ff32
	 sGPKxWwA3yNa0QAL7eW2/1lkOUHCuryg1Z2Um2ZHzutLOpYWyZRM326AzoqhKPL8qe
	 CZ5bK4pVuXzbis/moxNK07yOOqnSGBBCb6bYKy5nIDJsIpXndInhg1j1jD8yHjBnBm
	 lTw7IJ3ySdLS65roA52yZIrdppreWqKBBby1hSSMQa2LyR4B673Z2wuaiVYPG87MOH
	 NatyaT4s8Eh4QOVuVBiBuYcbbt/LwiPA41bCRXPGZ/N8VLg9uQWI9YxZb7R1JHhgFQ
	 b1T1Q1wfYYiaw==
Message-ID: <4764d988a07ec3defb56f98190427a7b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240415140348.2887619-1-catalin.popescu@leica-geosystems.com>
References: <20240415140348.2887619-1-catalin.popescu@leica-geosystems.com>
Subject: Re: [PATCH] clk: rs9: fix wrong default value for clock amplitude
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de, Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>, biju.das.jz@bp.renesas.com, marek.vasut+renesas@mailbox.org, marex@denx.de, mturquette@baylibre.com
Date: Fri, 19 Apr 2024 19:10:07 -0700
User-Agent: alot/0.10

Quoting Catalin Popescu (2024-04-15 07:03:48)
> According to 9FGV0241, 9FGV0441 & 9FGV0841 datasheets, the default
> value for the clock amplitude is 0.8V, while the driver assumes 0.7V.
>=20
> Additionally, define constants for default values for both clock
> amplitude and spread spectrum and use them.
>=20
> Fixes: 892e0ddea1aa ("clk: rs9: Add Renesas 9-series PCIe clock generator=
 driver")
>=20
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---

Applied to clk-next

