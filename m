Return-Path: <linux-kernel+bounces-74696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F7885D7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D6BB22D61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D83535BB;
	Wed, 21 Feb 2024 12:29:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD344E1A8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518558; cv=none; b=ID0YV8Ueu/jFnKFF3Xt/wbAVOuRso0euQP1eAE3FTzdNeC0noFUFVwAsrasxbwsJzshpfVtvRKr6eUc56IiL0OU806pz6uCdtzBCc5BNvSKGm6JYCzJWiMco3F54KFpKY4Jj2zNdUtru9T2t+wQKFii6V96Ae6/xWYXv3qlwF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518558; c=relaxed/simple;
	bh=i7x1ydrz3cbt7Ni3188JEFCNDYRhNl0E4xbcGnSvR7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s6QFaNUta5ZCaH9LD+qWegK5vaVwjsiPSzXrUlqhO9jqLChy+1NSL5/XXlvtdU3yG2bFhbmb5jo0jJCqBbk7vYXO5rrqDTrk/hwgH8xje5/9U7abD5pR9HXIiUdQcVzDEaIVnu925gZPWNQ3IH5Ga+Izv+vmeIt+OeGsIxLfWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rclib-0001Wa-FI; Wed, 21 Feb 2024 13:28:57 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rclia-0022Lk-Do; Wed, 21 Feb 2024 13:28:56 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rclia-0007Qt-1B;
	Wed, 21 Feb 2024 13:28:56 +0100
Message-ID: <ca0c0955df301b28d26ead4da27f48296fef640a.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] watchdog: sp805_wdt: deassert the reset if
 available
From: Philipp Zabel <p.zabel@pengutronix.de>
To: forbidden405@outlook.com, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Viresh Kumar <vireshk@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Date: Wed, 21 Feb 2024 13:28:56 +0100
In-Reply-To: <20240221-hisi-wdt-v3-1-9642613dc2e6@outlook.com>
References: <20240221-hisi-wdt-v3-0-9642613dc2e6@outlook.com>
	 <20240221-hisi-wdt-v3-1-9642613dc2e6@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2024-02-21 at 19:56 +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> According to the datasheet, the core has an WDOGRESn input signal that
> needs to be deasserted before being operational. Implement it in the
> driver.
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

