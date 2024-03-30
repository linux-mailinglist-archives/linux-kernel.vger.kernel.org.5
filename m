Return-Path: <linux-kernel+bounces-126207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9337C8933B3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B5B28A369
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4EA1514D9;
	Sun, 31 Mar 2024 16:39:24 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995714F9EB;
	Sun, 31 Mar 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903164; cv=fail; b=YiRsNr1avAG93GAABHZkqp5m4aYzvWqLsmWHsfpuxmu9Emcz3Lvovs4BzvkRF9zHjK1pWCsFFeI5c2riD4G/GWh2DNSU+QOrur28SsQgaBlxg20/n4nP3rqoqmZHcSC4xFuQjZGfMWTsWObbaXb5CiqYIt7u8gDr8N5vHnTW6B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903164; c=relaxed/simple;
	bh=Zx3ZY/twOun+4IBhPwjJuOWD3YYn2Pna1TduUWFMDnw=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=og5HPxiCq5qWnS9ptVcw2PlrgoLcn6skVomioQWAzqGoditsj9TQ4MZ6XWtkEqT/uWQy4Mab0sI1eB5muqI6bIw8jxwoER0dLxSrlvHpFO8O9VaUaA+abtJGbT+Cl02Ov/LXi3Qfg3X8uA1yRr0XNSP6q+Zx96MV4GIYNGCk348=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=collabora.com; spf=fail smtp.mailfrom=collabora.com; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=collabora.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 18A582083B;
	Sun, 31 Mar 2024 18:39:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MixtFexgAffW; Sun, 31 Mar 2024 18:39:20 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id CFCD120842;
	Sun, 31 Mar 2024 18:39:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com CFCD120842
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id C313D800050;
	Sun, 31 Mar 2024 18:39:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:39:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:25 +0000
X-sender: <linux-kernel+bounces-125906-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAR2YFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAF8AAADmigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 9790
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125906-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com DA1672083B
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711839703; cv=none; b=mNZeKHIJISYF0qfhDypFumDWJ4iiACaPMl+3H7nzNTE/JeJ54Z5jBjRdzjcCWap4dpt1cEI1WQQ16H3fZbI2I88Sz/ZC30NuRZooGODn31G3048hYchvp3IP+fsBvICg61nnO5N/acUnR0SumInw7nqWdylBXFYjLiWRxZC+UVQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711839703; c=relaxed/simple;
	bh=s2fZIERPWen68T7ai0Hbcm9HxnhK2N1NdJbuq3jQgm0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a7M5UJgkz9CGZA/Vr2hDTdu6L/VIyzs7xqMWxGy+1/OYz3qH3JP7iRcsz31bw1P3GsP0NhkWd8YPRfD4b/fLoXudEEF32XBqom59lnNLxNpsJ9L1FxkT0I7LkEM2g3ne/go9OnpOANJkPq4rnmJZWeSzZ6JpENdOd/BHwJo+A/U=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, =?utf-8?q?Thomas_Wei=C3=9Fschuh?=
	<linux@weissschuh.net>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Hans de Goede
	<hdegoede@redhat.com>
In-Reply-To: <20240329-power-supply-simplify-v1-1-416f1002739f@weissschuh.net>
References: <20240329-power-supply-simplify-v1-1-416f1002739f@weissschuh.net>
Subject: Re: [PATCH] power: supply: core: simplify charge_behaviour
 formatting
Message-ID: <171183969971.480547.16599196216072730255.b4-ty@collabora.com>
Date: Sun, 31 Mar 2024 00:01:39 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: b4 0.13.0
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10


On Fri, 29 Mar 2024 09:18:29 +0100, Thomas Wei=C3=9Fschuh wrote:
> The function power_supply_show_charge_behaviour() is not needed and can
> be removed completely.
> Removing the function also saves a spurious read of the property from
> the driver on each call.
>=20
> The convulted logic was a leftover from an earlier patch revision.
> Some restructuring made this cleanup possible.
>=20
> [...]

Applied, thanks!

[1/1] power: supply: core: simplify charge_behaviour formatting
      commit: 91b623cda43e449a49177ba99b6723f551a4bfbe

Best regards,
--=20
Sebastian Reichel <sebastian.reichel@collabora.com>



