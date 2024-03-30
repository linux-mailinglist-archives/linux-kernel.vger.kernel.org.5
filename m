Return-Path: <linux-kernel+bounces-126161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEFC8932FA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90A4B20AC6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBB614AD1C;
	Sun, 31 Mar 2024 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmT1BZSV"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD014AD0A;
	Sun, 31 Mar 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902416; cv=fail; b=GMZY+xC02MOOvzIzMn61VM9zv7ZcmxzBQLK0VSS8E1X48su2e5lsXGOPs+HFnTZunYlM40RiYCmQUs7TdYKXpRYeXQnOjnW54gTisXTedE/2TJclU0Bwjon5GDb8uxuqowF3VTaZhHztSWXA/UNAeMiY6PFjSnay82Y4MQD6cWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902416; c=relaxed/simple;
	bh=ZZZnb7dInNpwWQ9hWUHItIK63SiBjdDJhdLhzO+1p74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ll1l4Vjcmxzx+Vormqh3KdIBZMDHHL89qj0mP8Ibl4Mxm5hUPTY47K8Q3GS/AUXHIDl0TO46ev/4FpSeBDmqG0+39aCJ8qvSHMLi8hPHCBBfNRoTQRSJD6oNg1yPEqkuQC9jqbfdHRggdyuRrgQyfzXq1uQfz8qVt6QFjOkuljE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=fail smtp.mailfrom=linaro.org; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmT1BZSV reason="signature verification failed"; arc=none smtp.client-ip=209.85.221.44; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linaro.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 8704B208B4;
	Sun, 31 Mar 2024 18:26:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5IHBPkVwOMkl; Sun, 31 Mar 2024 18:26:50 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 93EC5208AC;
	Sun, 31 Mar 2024 18:26:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 93EC5208AC
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 8632B800056;
	Sun, 31 Mar 2024 18:26:50 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:50 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:51 +0000
X-sender: <netdev+bounces-83533-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAQKNAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAcAAAAo4oAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13267
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83533-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4679320520
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833031; cv=none; b=WrQhQxRo6DfULhTj6TsCGB6LofQfoBuxDCt2D/TtQew1L1J8171bWygFIKyOoQr7jolBlWGKRWWQL6Mm1ZSXEpIyNFS9d8CikM9Ato82v4bA52dusuXprGdxVA3QyM9KyQrsK9krR8oRQ18Etl+x9HAcK2/rNyWlmgujRB9Pkcw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833031; c=relaxed/simple;
	bh=lpW/z88igPmtu+dPk6Bg5/M6be2ELRWCA4fiw4xQTvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HS1sar1YmDqu1EiUhLsWX/F2qG+ZSKSVVh+BSA+y2eCEt8wgmoH6EJ9zOexB4dWkyFhGQqTnvcW2fbygrJDhDG875bRm2eppfhSCtuoKGGjO06HGP0lMNqNrLmjauiG/vzXcvf4flhuFdNGGG2951cca1G1K2F1rrX2aoNYOPro=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmT1BZSV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833028; x=1712437828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=lmT1BZSVVSPKWGgHfiytoJ+Ofrl4SkHaGZqmtLrRr9Xtp6NWN1fSkkfDwoAbSdPKGU
         7iICPbSYSWkoUys1nOax8ZNlxpQfq4PQJQ4TymEVCw3PkJzQTsCq7v7Undarn/f2KJj9
         ZG4QV60NcMb/lSCxXyT6TtbE/T3KI3GB/GjHWCbpmLOwf1Xb6WgjMLkLJ88lBAMR3Vur
         CTO1dryBej7ge6pn6C0Ijq3VRNqgK7SDTIyRth+3AeL0ZiRSUM93anFDVLadFESufJPL
         bPQQDMAzZMQiOF9PaZz+2bEIT1afJiAv9xX20LWUpM+NNBMnbp5GWBAf9our8hpGlmtU
         k/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833028; x=1712437828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=Z3V/da6Xz3DRp1xb2kWJvS4XMbNXnBs3jNIiApzfHCED05rvbFlBzMG46PmYth9sgO
         +SvEIZGIjOMJ4yHJTqFIvf9K4xFIfssfD8Fq5Ib8PzmyN8ahKgBdVbDKrM8Gzi9Ujp8H
         Yj55CnL6Uc/WHdSnI2bDfW28ZKFHjMFpJH+aanyiUtxtzf9OkFvm9Sm6GbQNlJccCz9+
         Pe7IczzArNBu+gADF538Ynxg9IWJQIvizj/AsaOSVma2Hgr+nB4CKFQXS25GD9flxh/U
         xN474rnGNVBCjAfhQoLXjz5PHQrmKoLdmYYD0OrxhiGUPy3FVvYv4fz/go1DY9HuJsaF
         DBAA==
X-Forwarded-Encrypted: i=1; AJvYcCUOTrI+i6c4KpEmf2l6yQ2FBhPUFcqZKLVGzCKLZrjWBIbfBuFG2Pn9O2Q1s4+aZAxdvd0qmTRY2CJwUU9hbjJtoC4QlhNe
X-Gm-Message-State: AOJu0YyipnUvvoL4YBTQ3jANCs6RsHGG8mK0cx4Ss72Fj2Lhl6zkk2OV
	zQQain5LobUn1FL24TAHzy3J+rz3cROArg3/5CIXmctNs/UQ1R4czd/2Q27h+3o=
X-Google-Smtp-Source: AGHT+IG/PwnuOG9GW/J71lWsyeYoc0pzt0O0RZTv5vm8EGRV8pODCFgM8sdpdU3qeNoyycuNuSNCcw==
X-Received: by 2002:a05:6000:4009:b0:33d:6fd8:90d3 with SMTP id cp9-20020a056000400900b0033d6fd890d3mr5016445wrb.4.1711833028607;
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [net-next PATCH 2/2] net: dsa: sja1105: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:23 +0100
Message-Id: <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja11=
05/sja1105_main.c
index 6646f7fb0f90..fc262348a134 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3456,7 +3456,6 @@ MODULE_DEVICE_TABLE(spi, sja1105_spi_ids);
 static struct spi_driver sja1105_driver =3D {
 	.driver =3D {
 		.name  =3D "sja1105",
-		.owner =3D THIS_MODULE,
 		.of_match_table =3D of_match_ptr(sja1105_dt_ids),
 	},
 	.id_table =3D sja1105_spi_ids,
--=20
2.34.1


X-sender: <netdev+bounces-83533-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAJKNAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAeAAAAo4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13285
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 22:10:50 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 22:10:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 664D320883
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:10:50 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=3D-5.051 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001,
	SPF_PASS=3D-0.001] autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nmavyplIyy-Z for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 22:10:50 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83533-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A1F9520520
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A1F9520520
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E83283300
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F164E1D5;
	Sat, 30 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@linaro.org he=
ader.b=3D"lmT1BZSV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221=
44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA82AF13
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D209.85.221.44
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711833031; cv=3Dnone; b=3DWrQhQxRo6DfULhTj6TsCGB6LofQfoBuxDCt2D/TtQew=
1L1J8171bWygFIKyOoQr7jolBlWGKRWWQL6Mm1ZSXEpIyNFS9d8CikM9Ato82v4bA52dusuXprG=
dxVA3QyM9KyQrsK9krR8oRQ18Etl+x9HAcK2/rNyWlmgujRB9Pkcw=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711833031; c=3Drelaxed/simple;
	bh=3DlpW/z88igPmtu+dPk6Bg5/M6be2ELRWCA4fiw4xQTvk=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=3DHS1sar1YmDqu1EiUhLsWX/F2qG+ZSKSVVh+BSA+y2eCEt8wgmoH6EJ9=
zOexB4dWkyFhGQqTnvcW2fbygrJDhDG875bRm2eppfhSCtuoKGGjO06HGP0lMNqNrLmjauiG/vz=
Xcvf4flhuFdNGGG2951cca1G1K2F1rrX2aoNYOPro=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dlinaro.org; spf=3Dpass smtp.mailfrom=3Dl=
inaro.org; dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@lin=
aro.org header.b=3DlmT1BZSV; arc=3Dnone smtp.client-ip=3D209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dlinaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dlinaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33edbc5932b=
so2153952f8f.3
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 14:10:29 -0700 (PDT)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dlinaro.org; s=3Dgoogle; t=3D1711833028; x=3D1712437828; darn=3D=
vger.kernel.org;
        h=3Dcontent-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dz97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=3D;
        b=3DlmT1BZSVVSPKWGgHfiytoJ+Ofrl4SkHaGZqmtLrRr9Xtp6NWN1fSkkfDwoAbSdP=
KGU
         7iICPbSYSWkoUys1nOax8ZNlxpQfq4PQJQ4TymEVCw3PkJzQTsCq7v7Undarn/f2KJ=
j9
         ZG4QV60NcMb/lSCxXyT6TtbE/T3KI3GB/GjHWCbpmLOwf1Xb6WgjMLkLJ88lBAMR3V=
ur
         CTO1dryBej7ge6pn6C0Ijq3VRNqgK7SDTIyRth+3AeL0ZiRSUM93anFDVLadFESufJ=
PL
         bPQQDMAzZMQiOF9PaZz+2bEIT1afJiAv9xX20LWUpM+NNBMnbp5GWBAf9our8hpGlm=
tU
         k/IQ=3D=3D
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1711833028; x=3D1712437828;
        h=3Dcontent-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Dz97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=3D;
        b=3DZ3V/da6Xz3DRp1xb2kWJvS4XMbNXnBs3jNIiApzfHCED05rvbFlBzMG46PmYth9=
sgO
         +SvEIZGIjOMJ4yHJTqFIvf9K4xFIfssfD8Fq5Ib8PzmyN8ahKgBdVbDKrM8Gzi9Ujp=
8H
         Yj55CnL6Uc/WHdSnI2bDfW28ZKFHjMFpJH+aanyiUtxtzf9OkFvm9Sm6GbQNlJccCz=
9+
         Pe7IczzArNBu+gADF538Ynxg9IWJQIvizj/AsaOSVma2Hgr+nB4CKFQXS25GD9flxh=
/U
         xN474rnGNVBCjAfhQoLXjz5PHQrmKoLdmYYD0OrxhiGUPy3FVvYv4fz/go1DY9HuJs=
aF
         DBAA=3D=3D
X-Forwarded-Encrypted: i=3D1; AJvYcCUOTrI+i6c4KpEmf2l6yQ2FBhPUFcqZKLVGzCKLZ=
rjWBIbfBuFG2Pn9O2Q1s4+aZAxdvd0qmTRY2CJwUU9hbjJtoC4QlhNe
X-Gm-Message-State: AOJu0YyipnUvvoL4YBTQ3jANCs6RsHGG8mK0cx4Ss72Fj2Lhl6zkk2O=
V
	zQQain5LobUn1FL24TAHzy3J+rz3cROArg3/5CIXmctNs/UQ1R4czd/2Q27h+3o=3D
X-Google-Smtp-Source: AGHT+IG/PwnuOG9GW/J71lWsyeYoc0pzt0O0RZTv5vm8EGRV8pODC=
FgM8sdpdU3qeNoyycuNuSNCcw=3D=3D
X-Received: by 2002:a05:6000:4009:b0:33d:6fd8:90d3 with SMTP id cp9-20020a0=
56000400900b0033d6fd890d3mr5016445wrb.4.1711833028607;
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a056000036c00b00341ce80e=
a66sm7288097wrf.82.2024.03.30.14.10.27
        (version=3DTLS1_3 cipher=3DTLS_AES_256_GCM_SHA384 bits=3D256/256);
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [net-next PATCH 2/2] net: dsa: sja1105: drop driver owner assignme=
nt
Date: Sat, 30 Mar 2024 22:10:23 +0100
Message-Id: <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: netdev+bounces-83533-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 21:10:50.4834
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: db0e16b5-1689-4885-1590-08dc=
50fde099
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.410|SMR=3D0.341(SMRDE=3D0.035|SMRC=3D0.30=
6(SMRCL=3D0.102|X-SMRCR=3D0.306))|CAT=3D0.067(CATOS=3D0.012
 (CATSM=3D0.012(CATSM-Malware
 Agent=3D0.011))|CATRESL=3D0.038(CATRESLP2R=3D0.017)|CATORES=3D0.015
 (CATRS=3D0.015(CATRS-Index Routing Agent=3D0.014)));2024-03-30T21:10:50.87=
7Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9293
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.024|SMR=3D0.024(SMRPI=3D0.022(SMRPI-FrontendProxyAgent=3D0.022))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAYACAAAPAAADH4sIAAAAAAAEAJVSTU/b=
QBCd9WdiYjhUvV
 S0GnEKSuzExIR+UdFCpCKoeoD2ajnxOmwJNrK3pdD2B/VfdtYxASGQ
 aGRlZt+8eTM7O3+t3bzgKDIsz0VU8KkoJS+ipBA/eNFex3hW8Di5xJ
 LLEuUJRz+/yHjRxTLHOcl1kpyXmOUSM84TlLnvOq5zJKYZT7w8Tb3x
 5Ws8KK4uyyuZp3iQX83yi/JU4NvTa9A/vQZ3ZiKLi9zPi+k71/E8z3
 XqOmUv47KXlHGv/BYHQX/z2kZnscj8Cf7GABU9wFTMOE5O4mzKky6d
 Ez7jUuRZ21tXrSUiTdHzpkJi3Huk+PiRRNcRWcJ/4nAYDtOtdNxPX/
 V9P51sDDcG4cs4GIQY9PvDMKwu9+j6rtPpdP6jiZ0d9Abh5rC7hZ3K
 DpGgT5/3vhyOor3R1/3dUXT8/sPhqE3PTo9Zp6sdEEm5/obGWMpYig
 mZ4vtEVtsxL74g18dt/EXs+uffBy6CWXzGkWJrtcRal6Zwl1TtF5GO
 P+4fRfOOu/do5SldVk5OIhmP6bW3cQGcy6K96FFW97kl8OeW74tkkX
 5nBKozWqYNfxD6gVoa1wEwwNRA1xk8AaMBTQuaNjQI1ME0waaQVR+N
 imlbDFyw6aiB0QSnCUtNBi+U41gKb1E6Rekjx2bQqtIZMxgAY5b6B4
 0QmzXnfgNWjEqQ/PtzQXs4pJtgtWC5xVwLwILWw0z7wRCzTCBT9ca0
 Gx9MS43FpntRFV31DCu1QsOqcJqbAwY5FFpW4FMLnhtqhqsmiTNYIh
 F4pqmoapVATdXVK0FjnqXmD6uENxTeuKnCnHlLGtAIdOX/A9OF8Pbb
 BAAAAQr6ATw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi
 0xNiI/Pg0KPEVtYWlsU2V0Pg0KICA8VmVyc2lvbj4xNS4wLjAuMDwv
 VmVyc2lvbj4NCiAgPEVtYWlscz4NCiAgICA8RW1haWwgU3RhcnRJbm
 RleD0iMTIzIiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAgIDxF
 bWFpbFN0cmluZz5rcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcm
 c8L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haWw+DQogIDwvRW1haWxz
 Pg0KPC9FbWFpbFNldD4BDNIEPD94bWwgdmVyc2lvbj0iMS4wIiBlbm
 NvZGluZz0idXRmLTE2Ij8+DQo8Q29udGFjdFNldD4NCiAgPFZlcnNp
 b24+MTUuMC4wLjA8L1ZlcnNpb24+DQogIDxDb250YWN0cz4NCiAgIC
 A8Q29udGFjdCBTdGFydEluZGV4PSIxMDIiIFBvc2l0aW9uPSJTaWdu
 YXR1cmUiPg0KICAgICAgPFBlcnNvbiBTdGFydEluZGV4PSIxMDIiIF
 Bvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAgICA8UGVyc29uU3Ry
 aW5nPktyenlzenRvZiBLb3psb3dza2k8L1BlcnNvblN0cmluZz4NCi
 AgICAgIDwvUGVyc29uPg0KICAgICAgPEVtYWlscz4NCiAgICAgICAg
 PEVtYWlsIFN0YXJ0SW5kZXg9IjEyMyIgUG9zaXRpb249IlNpZ25hdH
 VyZSI+DQogICAgICAgICAgPEVtYWlsU3RyaW5nPmtyenlzenRvZi5r
 b3psb3dza2lAbGluYXJvLm9yZzwvRW1haWxTdHJpbmc+DQogICAgIC
 AgIDwvRW1haWw+DQogICAgICA8L0VtYWlscz4NCiAgICAgIDxDb250
 YWN0U3RyaW5nPktyenlzenRvZiBLb3psb3dza2kgJmx0O2tyenlzen
 RvZi5rb3psb3dza2lAbGluYXJvLm9yZzwvQ29udGFjdFN0cmluZz4N
 CiAgICA8L0NvbnRhY3Q+DQogIDwvQ29udGFjdHM+DQo8L0NvbnRhY3
 RTZXQ+AQ7OAVJldHJpZXZlck9wZXJhdG9yLDEwLDA7UmV0cmlldmVy
 T3BlcmF0b3IsMTEsMTtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTAsMD
 tQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTEsMDtQb3N0V29yZEJyZWFr
 ZXJEaWFnbm9zdGljT3BlcmF0b3IsMTAsMDtQb3N0V29yZEJyZWFrZX
 JEaWFnbm9zdGljT3BlcmF0b3IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQ cm9kdWNlciwyMCw3
X-MS-Exchange-Forest-IndexAgent: 1 1713
X-MS-Exchange-Forest-EmailMessageHash: 5EEA00A4
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja11=
05/sja1105_main.c
index 6646f7fb0f90..fc262348a134 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3456,7 +3456,6 @@ MODULE_DEVICE_TABLE(spi, sja1105_spi_ids);
 static struct spi_driver sja1105_driver =3D {
 	.driver =3D {
 		.name  =3D "sja1105",
-		.owner =3D THIS_MODULE,
 		.of_match_table =3D of_match_ptr(sja1105_dt_ids),
 	},
 	.id_table =3D sja1105_spi_ids,
--=20
2.34.1


X-sender: <linux-kernel+bounces-125887-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAQKNAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAgAAAAo4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13304
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 22:11:04 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 22:11:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 15EDD20883
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:11:04 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=3D-5.051 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001,
	SPF_PASS=3D-0.001] autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQlJW_h2trGg for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 22:11:03 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125887-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 53C5820520
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 53C5820520
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BCA2832BC
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 21:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C353379;
	Sat, 30 Mar 2024 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@linaro.org he=
ader.b=3D"lmT1BZSV"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221=
52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1C1DFC6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D209.85.221.52
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711833031; cv=3Dnone; b=3DB54a9I9KLm7YZF44WhNh/VUVKOFwt5wPPd4l6u6tmbG=
IqRbelrSguCLOhuu6SUJOJ5u6ne4hh7GYtNl9laZhpupbJrHNnNDdtDjFCkS0hsVM46JCZbAfv5=
YdzjMjVm39aNWlDgET1vCKJyH7lf9M8rgg6eWPSKmAb38oD4K9TP4=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711833031; c=3Drelaxed/simple;
	bh=3DlpW/z88igPmtu+dPk6Bg5/M6be2ELRWCA4fiw4xQTvk=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=3DHS1sar1YmDqu1EiUhLsWX/F2qG+ZSKSVVh+BSA+y2eCEt8wgmoH6EJ9=
zOexB4dWkyFhGQqTnvcW2fbygrJDhDG875bRm2eppfhSCtuoKGGjO06HGP0lMNqNrLmjauiG/vz=
Xcvf4flhuFdNGGG2951cca1G1K2F1rrX2aoNYOPro=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dlinaro.org; spf=3Dpass smtp.mailfrom=3Dl=
inaro.org; dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@lin=
aro.org header.b=3DlmT1BZSV; arc=3Dnone smtp.client-ip=3D209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dlinaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dlinaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-341e3682c78=
so1744688f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 14:10:29 -0700=
 (PDT)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dlinaro.org; s=3Dgoogle; t=3D1711833028; x=3D1712437828; darn=3D=
vger.kernel.org;
        h=3Dcontent-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dz97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=3D;
        b=3DlmT1BZSVVSPKWGgHfiytoJ+Ofrl4SkHaGZqmtLrRr9Xtp6NWN1fSkkfDwoAbSdP=
KGU
         7iICPbSYSWkoUys1nOax8ZNlxpQfq4PQJQ4TymEVCw3PkJzQTsCq7v7Undarn/f2KJ=
j9
         ZG4QV60NcMb/lSCxXyT6TtbE/T3KI3GB/GjHWCbpmLOwf1Xb6WgjMLkLJ88lBAMR3V=
ur
         CTO1dryBej7ge6pn6C0Ijq3VRNqgK7SDTIyRth+3AeL0ZiRSUM93anFDVLadFESufJ=
PL
         bPQQDMAzZMQiOF9PaZz+2bEIT1afJiAv9xX20LWUpM+NNBMnbp5GWBAf9our8hpGlm=
tU
         k/IQ=3D=3D
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1711833028; x=3D1712437828;
        h=3Dcontent-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Dz97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=3D;
        b=3DLN6EukO7x/miFXgVzeYBWPBHF5MKaL0/k2usNgFo64rZ+FRZIQg4gENQFEslrLZ=
U3B
         ZslJ2cup96D8c8UluDpZPJzJV64/fKhb9YpCEaDC3X0ZH74RD+lXJ/OTlqxbvDyz6c=
Lc
         eVCqMvicLLr6WTcAxQQGsEBmAoX5nLlQHRzC0GluGPRf+qoCr4GUhpoh+39dGWc6vY=
Q8
         eRyNe5ifDeY4F/om3TpVDUuUWNYJc47Ttyb8oPqbePV5uPMtx59Mu8AIUHvGuv6J6S=
CL
         gl9SaszuWA1emQeHafmY4MZdh4AIx4mlRFljqScFOYNODFEtkrS8a+qtq4xcY0O97H=
ez
         2iUw=3D=3D
X-Forwarded-Encrypted: i=3D1; AJvYcCXeykk8WUuo+zuaSq0RZqJlkKLk1Y8uoPTtm5QI2=
78pmyQIKEBoiY2SRzd908hejYalPQRYHj33KLaZKdmOYUlKk9t1FFnsTockcry/
X-Gm-Message-State: AOJu0Yy9THjSYK62Bav46nhST3lX5lfWLL8OIAJIbAf6W6cj047LIyz=
C
	MLYQYXly+7uMuSNBatu187U8OsQvhNyalLY3RdW8EvhJr88VU2JCCHKEH2BSKfQ=3D
X-Google-Smtp-Source: AGHT+IG/PwnuOG9GW/J71lWsyeYoc0pzt0O0RZTv5vm8EGRV8pODC=
FgM8sdpdU3qeNoyycuNuSNCcw=3D=3D
X-Received: by 2002:a05:6000:4009:b0:33d:6fd8:90d3 with SMTP id cp9-20020a0=
56000400900b0033d6fd890d3mr5016445wrb.4.1711833028607;
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a056000036c00b00341ce80e=
a66sm7288097wrf.82.2024.03.30.14.10.27
        (version=3DTLS1_3 cipher=3DTLS_AES_256_GCM_SHA384 bits=3D256/256);
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [net-next PATCH 2/2] net: dsa: sja1105: drop driver owner assignme=
nt
Date: Sat, 30 Mar 2024 22:10:23 +0100
Message-Id: <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: linux-kernel+bounces-125887-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 21:11:04.1354
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 91acc90a-aaf7-41d3-3699-08dc=
50fde8bc
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.397|SMR=3D0.347(SMRDE=3D0.036|SMRC=3D0.31=
1(SMRCL=3D0.103|X-SMRCR=3D0.311))|CAT=3D0.048(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.010))|CATRESL=3D0.020(CATRESLP2R=3D0.001)|CATORES=3D0.015
 (CATRS=3D0.015(CATRS-Index Routing Agent=3D0.014)));2024-03-30T21:11:04.51=
8Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9314
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.006|SMR=3D0.006(SMRPI=3D0.005(SMRPI-FrontendProxyAgent=3D0.005))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAYACAAAPAAADH4sIAAAAAAAEAJVSTU/b=
QBCd9WdiYjhUvV
 S0GnEKSuzExIR+UdFCpCKoeoD2ajnxOmwJNrK3pdD2B/VfdtYxASGQ
 aGRlZt+8eTM7O3+t3bzgKDIsz0VU8KkoJS+ipBA/eNFex3hW8Di5xJ
 LLEuUJRz+/yHjRxTLHOcl1kpyXmOUSM84TlLnvOq5zJKYZT7w8Tb3x
 5Ws8KK4uyyuZp3iQX83yi/JU4NvTa9A/vQZ3ZiKLi9zPi+k71/E8z3
 XqOmUv47KXlHGv/BYHQX/z2kZnscj8Cf7GABU9wFTMOE5O4mzKky6d
 Ez7jUuRZ21tXrSUiTdHzpkJi3Huk+PiRRNcRWcJ/4nAYDtOtdNxPX/
 V9P51sDDcG4cs4GIQY9PvDMKwu9+j6rtPpdP6jiZ0d9Abh5rC7hZ3K
 DpGgT5/3vhyOor3R1/3dUXT8/sPhqE3PTo9Zp6sdEEm5/obGWMpYig
 mZ4vtEVtsxL74g18dt/EXs+uffBy6CWXzGkWJrtcRal6Zwl1TtF5GO
 P+4fRfOOu/do5SldVk5OIhmP6bW3cQGcy6K96FFW97kl8OeW74tkkX
 5nBKozWqYNfxD6gVoa1wEwwNRA1xk8AaMBTQuaNjQI1ME0waaQVR+N
 imlbDFyw6aiB0QSnCUtNBi+U41gKb1E6Rekjx2bQqtIZMxgAY5b6B4
 0QmzXnfgNWjEqQ/PtzQXs4pJtgtWC5xVwLwILWw0z7wRCzTCBT9ca0
 Gx9MS43FpntRFV31DCu1QsOqcJqbAwY5FFpW4FMLnhtqhqsmiTNYIh
 F4pqmoapVATdXVK0FjnqXmD6uENxTeuKnCnHlLGtAIdOX/A9OF8Pbb
 BAAAAQr6ATw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi
 0xNiI/Pg0KPEVtYWlsU2V0Pg0KICA8VmVyc2lvbj4xNS4wLjAuMDwv
 VmVyc2lvbj4NCiAgPEVtYWlscz4NCiAgICA8RW1haWwgU3RhcnRJbm
 RleD0iMTIzIiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAgIDxF
 bWFpbFN0cmluZz5rcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcm
 c8L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haWw+DQogIDwvRW1haWxz
 Pg0KPC9FbWFpbFNldD4BDNIEPD94bWwgdmVyc2lvbj0iMS4wIiBlbm
 NvZGluZz0idXRmLTE2Ij8+DQo8Q29udGFjdFNldD4NCiAgPFZlcnNp
 b24+MTUuMC4wLjA8L1ZlcnNpb24+DQogIDxDb250YWN0cz4NCiAgIC
 A8Q29udGFjdCBTdGFydEluZGV4PSIxMDIiIFBvc2l0aW9uPSJTaWdu
 YXR1cmUiPg0KICAgICAgPFBlcnNvbiBTdGFydEluZGV4PSIxMDIiIF
 Bvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAgICA8UGVyc29uU3Ry
 aW5nPktyenlzenRvZiBLb3psb3dza2k8L1BlcnNvblN0cmluZz4NCi
 AgICAgIDwvUGVyc29uPg0KICAgICAgPEVtYWlscz4NCiAgICAgICAg
 PEVtYWlsIFN0YXJ0SW5kZXg9IjEyMyIgUG9zaXRpb249IlNpZ25hdH
 VyZSI+DQogICAgICAgICAgPEVtYWlsU3RyaW5nPmtyenlzenRvZi5r
 b3psb3dza2lAbGluYXJvLm9yZzwvRW1haWxTdHJpbmc+DQogICAgIC
 AgIDwvRW1haWw+DQogICAgICA8L0VtYWlscz4NCiAgICAgIDxDb250
 YWN0U3RyaW5nPktyenlzenRvZiBLb3psb3dza2kgJmx0O2tyenlzen
 RvZi5rb3psb3dza2lAbGluYXJvLm9yZzwvQ29udGFjdFN0cmluZz4N
 CiAgICA8L0NvbnRhY3Q+DQogIDwvQ29udGFjdHM+DQo8L0NvbnRhY3
 RTZXQ+AQ7OAVJldHJpZXZlck9wZXJhdG9yLDEwLDA7UmV0cmlldmVy
 T3BlcmF0b3IsMTEsMTtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTAsMD
 tQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTEsMDtQb3N0V29yZEJyZWFr
 ZXJEaWFnbm9zdGljT3BlcmF0b3IsMTAsMDtQb3N0V29yZEJyZWFrZX
 JEaWFnbm9zdGljT3BlcmF0b3IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQ cm9kdWNlciwyMCw2
X-MS-Exchange-Forest-IndexAgent: 1 1713
X-MS-Exchange-Forest-EmailMessageHash: 5EEA00A4
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja11=
05/sja1105_main.c
index 6646f7fb0f90..fc262348a134 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3456,7 +3456,6 @@ MODULE_DEVICE_TABLE(spi, sja1105_spi_ids);
 static struct spi_driver sja1105_driver =3D {
 	.driver =3D {
 		.name  =3D "sja1105",
-		.owner =3D THIS_MODULE,
 		.of_match_table =3D of_match_ptr(sja1105_dt_ids),
 	},
 	.id_table =3D sja1105_spi_ids,
--=20
2.34.1




