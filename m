Return-Path: <linux-kernel+bounces-126160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F98932F9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB7E283C08
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A177914BF83;
	Sun, 31 Mar 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJKucHwX"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F4146D49;
	Sun, 31 Mar 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902416; cv=fail; b=mXIXhmqF+ydKRwgeRwBQg+J2xnUh3bhEw3LXKyEwa11craGrtx4WB8J4STK8i+e+ueh1lr6WdD+22MUF2GtEwGu042X2vdtDNwCL+SyaksCsQjyotTeLc4qKmlb4Fl/Dlxnt+MH/yA/JAL8GF5yxykxEn2mIum28jqliRXQVUfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902416; c=relaxed/simple;
	bh=myMa4vxxN2qSNrL8oT/Pe3twCK8VnEjbuITq42k8jGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HrviBSWMMS2jo4sAIqCd7Sn59PYfCR0vbrIMndlK1viL6NDdrOwpWACBbc2F/Qr6V1PaIUE63WsN4TzHT1WCzCg8JRGJUB8WXxGrCgn/KYabACt4vQ3yh0cqbbV+3DJFfftn2sfFVu8HGBsxVVERYZUWjNfaO7bn0XNURspQNPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=fail smtp.mailfrom=linaro.org; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJKucHwX reason="signature verification failed"; arc=none smtp.client-ip=209.85.221.54; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linaro.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C9A65208A2;
	Sun, 31 Mar 2024 18:26:51 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uFK5hE7TnPRo; Sun, 31 Mar 2024 18:26:50 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1CF5120185;
	Sun, 31 Mar 2024 18:26:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1CF5120185
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 1079C800051;
	Sun, 31 Mar 2024 18:26:50 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:49 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:51 +0000
X-sender: <netdev+bounces-83532-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAJKNAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAbAAAAo4oAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 13128
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83532-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 693482025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJKucHwX"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833031; cv=none; b=aLktRl1KDgxoJmfO2sgo6KOMHyelT2+eO+LTIB5KLdPEpUAi16ylMHNfCi2YLhHTDLmFBUZCx11fTj3Vk/NmaOxn4Yy+nBBD9iP0ozNUsSzymdik8r+lHy993Yck2vxgQUIZBvhQ4v0x3pKhx1xYE+3r7YqXLOZ9w0XyKRTVwAU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833031; c=relaxed/simple;
	bh=5cyk0mZPWqkezr+FTKCeHWipPZpAG9tXQ3TzxjeoxaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H8Xowd4NXVFFVNAkqLaY2Qkgugi9JeD7GNxA0JehFyxlt63guA1ZGjj/alCZ281ENY1ca+ZfgoWia2/BycIciBgnt8GubRPzSvPNaxFhon7h0IA69pdd/qLPwrwYs2JN40+yJiI6jckGb2np7rCTawPdx3X/m8xbJAjkw38PgGw=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJKucHwX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833027; x=1712437827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLkpmExOlKMcwACsZsH7M7SlZKO9kCP3VlHAwHc/QRU=;
        b=HJKucHwXrs4b+FQTF6hdlAYPCdImzzrwtKGc8WsGB3iqZORS5FZiTchupghwbi6xhW
         nH2y5k70ij9tBg3at2AB7dFP725wvz3R6/IlSOX9rnO6kffq33CUA9Ah0e7w4OACxwJF
         t+zxZmzHsxz6iW91jVortuqf1UbzccU6ZkTS+PJsVnU6DjYPP4bFXbE/XEPYhfmC7bQD
         8Oe45c6tRKF9FfsKAL0h1ZdVFfjXPGX+yOCEcOXsW25gVCO7OVqGdAs1HZF066/XdbCx
         DAw5j6aDvhV096NR6iMdpR8R8vnFO1pm+fVLUTKX+pDE9Sog0XM3gmovmBpUd9Re+QcM
         x8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833027; x=1712437827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLkpmExOlKMcwACsZsH7M7SlZKO9kCP3VlHAwHc/QRU=;
        b=MfvuAXquBv6NrEmma1V4rinXIuoB0uwf/arhSCOlhuu8R7ZU/Fr6kfq5bFj64QPx/8
         NZcy+pI4T7C5nfBvvbolfDHuvhMi6zvnx2ZNhlA/GHure2VRYXAiwAgxMyMdxqHUaz8P
         Px9gk24PUUS1hbMOyym2T5Y3NgNwdgBaAmgq9MS9AmaB54Beqq3Au9bMHL1siLmj+tst
         jxGf49OgfrvZgq5mEcUWJfYAwtCINNT0Tgq1F1SnnUkC2t0NC4lihD9SwJ/gS/Ez2Jq7
         YFXErDuKQnTjYW3fsMWIbFt5a5VoO9fBxdi9NDD0hp42XjfA0qOAGxxrh0so8D+SifqF
         Q4Yw==
X-Forwarded-Encrypted: i=1; AJvYcCX0tviT99vDJ3Ff8bv+rE9a+gRZQ0FfTVMhbcnPDryH8daqhIcKbZ7fchphprxFEZeXQgLVxtTQf2YgjfHZ0RVv96f1dmXT
X-Gm-Message-State: AOJu0YzxgDTxtYzx7jD1TiYpFQ46Ya8k4ZlMXwARwZO84vX+50jr+HVR
	01y/gkugKlCuc9sPwW+OXIVqa5xncHlSA5XEixYhfaHDNvfNTYXPpre96RFG+Ck=
X-Google-Smtp-Source: AGHT+IERt4faZXoAKcqd32SoGypbspZ5AI2Z9HzqC72LYU0X3G22k6IsrcxS3SxIiC2LoT6Os1c6mw==
X-Received: by 2002:a5d:5222:0:b0:343:357f:6650 with SMTP id i2-20020a5d5222000000b00343357f6650mr3848599wra.45.1711833027100;
        Sat, 30 Mar 2024 14:10:27 -0700 (PDT)
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
Subject: [net-next PATCH 1/2] net: dsa: microchip: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:22 +0100
Message-Id: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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
 drivers/net/dsa/microchip/ksz_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchi=
p/ksz_spi.c
index c8166fb440ab..79ae01507a8a 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -222,7 +222,6 @@ MODULE_DEVICE_TABLE(spi, ksz_spi_ids);
 static struct spi_driver ksz_spi_driver =3D {
 	.driver =3D {
 		.name	=3D "ksz-switch",
-		.owner	=3D THIS_MODULE,
 		.of_match_table =3D ksz_dt_ids,
 	},
 	.id_table =3D ksz_spi_ids,
--=20
2.34.1


X-sender: <netdev+bounces-83532-steffen.klassert=3Dsecunet.com@vger.kernel.=
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
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAJKNAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAdAAAAo4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 13151
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 22:10:48 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 22:10:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 1C79120310
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:10:48 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D-2.751 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r8M19mIufGzM for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 22:10:47 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83532-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 174D12025D
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@linaro.org he=
ader.b=3D"HJKucHwX"
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 174D12025D
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD1B2185B
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C154D112;
	Sat, 30 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@linaro.org he=
ader.b=3D"HJKucHwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221=
54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928713BBC7
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D209.85.221.54
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711833031; cv=3Dnone; b=3DaLktRl1KDgxoJmfO2sgo6KOMHyelT2+eO+LTIB5KLdP=
EpUAi16ylMHNfCi2YLhHTDLmFBUZCx11fTj3Vk/NmaOxn4Yy+nBBD9iP0ozNUsSzymdik8r+lHy=
993Yck2vxgQUIZBvhQ4v0x3pKhx1xYE+3r7YqXLOZ9w0XyKRTVwAU=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711833031; c=3Drelaxed/simple;
	bh=3D5cyk0mZPWqkezr+FTKCeHWipPZpAG9tXQ3TzxjeoxaA=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:MIME-Version; b=3DH8Xowd4NXVFFVNAkq=
LaY2Qkgugi9JeD7GNxA0JehFyxlt63guA1ZGjj/alCZ281ENY1ca+ZfgoWia2/BycIciBgnt8Gu=
bRPzSvPNaxFhon7h0IA69pdd/qLPwrwYs2JN40+yJiI6jckGb2np7rCTawPdx3X/m8xbJAjkw38=
PgGw=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dlinaro.org; spf=3Dpass smtp.mailfrom=3Dl=
inaro.org; dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@lin=
aro.org header.b=3DHJKucHwX; arc=3Dnone smtp.client-ip=3D209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dlinaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dlinaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34005b5927e=
so2171900f8f.1
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dlinaro.org; s=3Dgoogle; t=3D1711833027; x=3D1712437827; darn=3D=
vger.kernel.org;
        h=3Dcontent-transfer-encoding:mime-version:message-id:date:subject:=
cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DkLkpmExOlKMcwACsZsH7M7SlZKO9kCP3VlHAwHc/QRU=3D;
        b=3DHJKucHwXrs4b+FQTF6hdlAYPCdImzzrwtKGc8WsGB3iqZORS5FZiTchupghwbi6=
xhW
         nH2y5k70ij9tBg3at2AB7dFP725wvz3R6/IlSOX9rnO6kffq33CUA9Ah0e7w4OACxw=
JF
         t+zxZmzHsxz6iW91jVortuqf1UbzccU6ZkTS+PJsVnU6DjYPP4bFXbE/XEPYhfmC7b=
QD
         8Oe45c6tRKF9FfsKAL0h1ZdVFfjXPGX+yOCEcOXsW25gVCO7OVqGdAs1HZF066/Xdb=
Cx
         DAw5j6aDvhV096NR6iMdpR8R8vnFO1pm+fVLUTKX+pDE9Sog0XM3gmovmBpUd9Re+Q=
cM
         x8RQ=3D=3D
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1711833027; x=3D1712437827;
        h=3Dcontent-transfer-encoding:mime-version:message-id:date:subject:=
cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DkLkpmExOlKMcwACsZsH7M7SlZKO9kCP3VlHAwHc/QRU=3D;
        b=3DMfvuAXquBv6NrEmma1V4rinXIuoB0uwf/arhSCOlhuu8R7ZU/Fr6kfq5bFj64QP=
x/8
         NZcy+pI4T7C5nfBvvbolfDHuvhMi6zvnx2ZNhlA/GHure2VRYXAiwAgxMyMdxqHUaz=
8P
         Px9gk24PUUS1hbMOyym2T5Y3NgNwdgBaAmgq9MS9AmaB54Beqq3Au9bMHL1siLmj+t=
st
         jxGf49OgfrvZgq5mEcUWJfYAwtCINNT0Tgq1F1SnnUkC2t0NC4lihD9SwJ/gS/Ez2J=
q7
         YFXErDuKQnTjYW3fsMWIbFt5a5VoO9fBxdi9NDD0hp42XjfA0qOAGxxrh0so8D+Sif=
qF
         Q4Yw=3D=3D
X-Forwarded-Encrypted: i=3D1; AJvYcCX0tviT99vDJ3Ff8bv+rE9a+gRZQ0FfTVMhbcnPD=
ryH8daqhIcKbZ7fchphprxFEZeXQgLVxtTQf2YgjfHZ0RVv96f1dmXT
X-Gm-Message-State: AOJu0YzxgDTxtYzx7jD1TiYpFQ46Ya8k4ZlMXwARwZO84vX+50jr+HV=
R
	01y/gkugKlCuc9sPwW+OXIVqa5xncHlSA5XEixYhfaHDNvfNTYXPpre96RFG+Ck=3D
X-Google-Smtp-Source: AGHT+IERt4faZXoAKcqd32SoGypbspZ5AI2Z9HzqC72LYU0X3G22k=
6IsrcxS3SxIiC2LoT6Os1c6mw=3D=3D
X-Received: by 2002:a5d:5222:0:b0:343:357f:6650 with SMTP id i2-20020a5d522=
2000000b00343357f6650mr3848599wra.45.1711833027100;
        Sat, 30 Mar 2024 14:10:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a056000036c00b00341ce80e=
a66sm7288097wrf.82.2024.03.30.14.10.25
        (version=3DTLS1_3 cipher=3DTLS_AES_256_GCM_SHA384 bits=3D256/256);
        Sat, 30 Mar 2024 14:10:26 -0700 (PDT)
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
Subject: [net-next PATCH 1/2] net: dsa: microchip: drop driver owner assign=
ment
Date: Sat, 30 Mar 2024 22:10:22 +0100
Message-Id: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: netdev+bounces-83532-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 21:10:48.2006
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: c8ce5631-ef73-48a0-e8e4-08dc=
50fddf3c
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.396|SMR=3D0.346(SMRDE=3D0.035|SMRC=3D0.31=
0(SMRCL=3D0.100|X-SMRCR=3D0.310))|CAT=3D0.048(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.011))|CATRESL=3D0.020(CATRESLP2R=3D0.001)|CATORES=3D0.015
 (CATRS=3D0.015(CATRS-Index Routing Agent=3D0.014)));2024-03-30T21:10:48.56=
3Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9163
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.006|SMR=3D0.006(SMRPI=3D0.003(SMRPI-FrontendProxyAgent=3D0.003))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAXsCAAAPAAADH4sIAAAAAAAEAI1SS2/T=
QBAeJ/Y6ceNyQF
 yoQKOeWiV2HoS0PIoKbSSqFnFo4Wo59jpZJfVW9kJpgBN/nNlN+gC1
 UnLwznzzzcw3k/nDDmTBUeRYXoio4GNRKl5EaSG+82JrG+NZweP0Ck
 uuSlQTjqG8zHnRwlLiguR7qeQl5lJhznmKSoa+53unYpzzNJBZFoyu
 XuNxMb8q50pmeCznM3lZTgW+nV6D4fQa3J+JPC5kKIvxO98LgsD3ln
 3Kds5VOy3j9rlICplMxEV7Ws4j0h0m+Au7qLldzMSMYzKJ8zFPW+Sn
 fMaVkPlWsK11pSLLMAjGQmHcXqXyaBWW74k85T8w2e0OBtmo3+/Eoz
 DceRXzTvdlZyfejbHb6Qz6fTPTap19r9lsrtp+fx+DXq/X2sGmfgZI
 wKfPh19OhtHh8OvRwTA6e//hZLhF9BYu8yKRlttvaGmlipVI6Cm+Jc
 ocwqLnDXHp7uFPYi9/4X3gTTCPzzm9e7hJNYLyUqhkstmi6f8nmnPS
 xLOPR6fRQnLrnoIyi85jKhKpeER/8J7Rlio9wx367zt2KNJ/yMuJtQ
 i6lF74oh929UX4HoANTgWqVQseg12DOoO6CzUCq+A44FKILV3bMF1m
 gQ8uuRWw6+DVYa1uwXNteEzjDUqnaNVEqaxrbMuyLQDLYvoLFSrlWv
 WFXYNHtilI9v25UHk4VHWANWC9YfkMgEHjYab7YMhiNu3BcozCyq0N
 DtNrcWku6kILoZQ1k1KFGjM4IR7YC2PdhBg8YfDMNvVNaMOBuq0THQ
 ZPK5qmNTukxBD08mGD8JrGa7ctLG+hpwI0f1XbfwED2mjCsgQAAAEK
 +gE8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz
 4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNp
 b24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9Ij
 EyMyIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgICA8RW1haWxT
 dHJpbmc+a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPC9FbW
 FpbFN0cmluZz4NCiAgICA8L0VtYWlsPg0KICA8L0VtYWlscz4NCjwv
 RW1haWxTZXQ+AQzSBDw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbm
 c9InV0Zi0xNiI/Pg0KPENvbnRhY3RTZXQ+DQogIDxWZXJzaW9uPjE1
 LjAuMC4wPC9WZXJzaW9uPg0KICA8Q29udGFjdHM+DQogICAgPENvbn
 RhY3QgU3RhcnRJbmRleD0iMTAyIiBQb3NpdGlvbj0iU2lnbmF0dXJl
 Ij4NCiAgICAgIDxQZXJzb24gU3RhcnRJbmRleD0iMTAyIiBQb3NpdG
 lvbj0iU2lnbmF0dXJlIj4NCiAgICAgICAgPFBlcnNvblN0cmluZz5L
 cnp5c3p0b2YgS296bG93c2tpPC9QZXJzb25TdHJpbmc+DQogICAgIC
 A8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgIDxFbWFp
 bCBTdGFydEluZGV4PSIxMjMiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg
 0KICAgICAgICAgIDxFbWFpbFN0cmluZz5rcnp5c3p0b2Yua296bG93
 c2tpQGxpbmFyby5vcmc8L0VtYWlsU3RyaW5nPg0KICAgICAgICA8L0
 VtYWlsPg0KICAgICAgPC9FbWFpbHM+DQogICAgICA8Q29udGFjdFN0
 cmluZz5Lcnp5c3p0b2YgS296bG93c2tpICZsdDtrcnp5c3p0b2Yua2
 96bG93c2tpQGxpbmFyby5vcmc8L0NvbnRhY3RTdHJpbmc+DQogICAg
 PC9Db250YWN0Pg0KICA8L0NvbnRhY3RzPg0KPC9Db250YWN0U2V0Pg
 EOzgFSZXRyaWV2ZXJPcGVyYXRvciwxMCwwO1JldHJpZXZlck9wZXJh
 dG9yLDExLDE7UG9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDA7UG9zdE
 RvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2VyRGlh
 Z25vc3RpY09wZXJhdG9yLDEwLDA7UG9zdFdvcmRCcmVha2VyRGlhZ2
 5vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZHVj ZXIsMjAsNw=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 1708
X-MS-Exchange-Forest-EmailMessageHash: 7EC61AD4
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/microchip/ksz_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchi=
p/ksz_spi.c
index c8166fb440ab..79ae01507a8a 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -222,7 +222,6 @@ MODULE_DEVICE_TABLE(spi, ksz_spi_ids);
 static struct spi_driver ksz_spi_driver =3D {
 	.driver =3D {
 		.name	=3D "ksz-switch",
-		.owner	=3D THIS_MODULE,
 		.of_match_table =3D ksz_dt_ids,
 	},
 	.id_table =3D ksz_spi_ids,
--=20
2.34.1


X-sender: <linux-kernel+bounces-125886-steffen.klassert=3Dsecunet.com@vger.=
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
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAfAAAAo4oAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13025
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 22:10:55 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 22:10:55 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E3E2F20883
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:10:55 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=3D-5.051 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001,
	SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 65CcFXf9v-xp for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 22:10:52 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125886-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7D3BC20520
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7D3BC20520
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 22:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2F4283164
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 21:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A654F217;
	Sat, 30 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@linaro.org he=
ader.b=3D"HJKucHwX"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221=
46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B743AC2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D209.85.221.46
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711833030; cv=3Dnone; b=3DHSYfbbPiBriA634D7zWw7Az62UHIxwgrzOr92FleERE=
ijYJzqgSwNXXfKLoIEt22sjk4MMlWxM/IUApikV6zdGiA1b0yXdKw4tVpvJIb1/1J2C/w72F9MZ=
UMBglOcnulxFg+8DpKoJ7JmkIdsu+s+75fWFUFn0k2U795qg05K5g=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711833030; c=3Drelaxed/simple;
	bh=3D5cyk0mZPWqkezr+FTKCeHWipPZpAG9tXQ3TzxjeoxaA=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:MIME-Version; b=3DIYYPb1xsYyaV62Vjt=
iXKfXkGJrtnZeVt1snctQhe0OMvPdD4qc3LAwmDDo12CBfqFTUDzacD6iXJ+en3D/Nnls+eJGD9=
6FEkNmTGuVfcM+buCC+psxFTaemghE8jUyY9VrjyCrKJxIW2gmdley1wAF1qCa9FBfCPamKwh+D=
AbpE=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dlinaro.org; spf=3Dpass smtp.mailfrom=3Dl=
inaro.org; dkim=3Dpass (2048-bit key) header.d=3Dlinaro.org header.i=3D@lin=
aro.org header.b=3DHJKucHwX; arc=3Dnone smtp.client-ip=3D209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dlinaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dlinaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-341e3682c78=
so1744678f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 14:10:28 -0700=
 (PDT)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dlinaro.org; s=3Dgoogle; t=3D1711833027; x=3D1712437827; darn=3D=
vger.kernel.org;
        h=3Dcontent-transfer-encoding:mime-version:message-id:date:subject:=
cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DkLkpmExOlKMcwACsZsH7M7SlZKO9kCP3VlHAwHc/QRU=3D;
        b=3DHJKucHwXrs4b+FQTF6hdlAYPCdImzzrwtKGc8WsGB3iqZORS5FZiTchupghwbi6=
xhW
         nH2y5k70ij9tBg3at2AB7dFP725wvz3R6/IlSOX9rnO6kffq33CUA9Ah0e7w4OACxw=
JF
         t+zxZmzHsxz6iW91jVortuqf1UbzccU6ZkTS+PJsVnU6DjYPP4bFXbE/XEPYhfmC7b=
QD
         8Oe45c6tRKF9FfsKAL0h1ZdVFfjXPGX+yOCEcOXsW25gVCO7OVqGdAs1HZF066/Xdb=
Cx
         DAw5j6aDvhV096NR6iMdpR8R8vnFO1pm+fVLUTKX+pDE9Sog0XM3gmovmBpUd9Re+Q=
cM
         x8RQ=3D=3D
X-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net; s=3D20230601; t=3D1711833027; x=3D1712437827;
        h=3Dcontent-transfer-encoding:mime-version:message-id:date:subject:=
cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DkLkpmExOlKMcwACsZsH7M7SlZKO9kCP3VlHAwHc/QRU=3D;
        b=3DVm6ITICkiVahKfH1QSt4yQ5f4gR4W0O82XlosGKwn07lf7MJGM1Xmn8FM9EvySY=
Nwz
         sCT8zByZhMl097GjF3XUdfWqAsr8hxP0wlgjqHv+1dIKWkzKKe6pdtcY0v3+eISwsR=
a+
         7twiwttkzjnLxMg16+ldjVpioZwZYFH21PrsReST4Y0+EMWC20dpQG9jxKoCbk3T90=
dV
         zeXlarpGMWCurX6TEiO1pELsYEHaJGrZqu44z1PsOKvT5NPf7Mx2RQAuBkWPdJZU83=
KL
         sKapnz6LTuWimIsP6H0dMO4K58jw2GIFmz/ZQJVxl16cQ2oN9nogc4kJHnHrL9lC1d=
Qt
         MDjA=3D=3D
X-Forwarded-Encrypted: i=3D1; AJvYcCVw9R4SjrF43Hc2WtNtA+9dFKuunLw3U6a75HLUN=
RrW/jwCMJpmci2wjXhm63Q92XufljLJgyW9iZc2gERNxfQirVC96WfuQe7qvPMQ
X-Gm-Message-State: AOJu0YzOAYpslcxgrwlBeMNlVwFhSOCh1bk1Y06osomp/Yr7f7VdNxx=
J
	xTBGTTJjPBiZ9KgH79cp4INf2V2W+ahW0XP/RrhIXNc+d5ZAx8nI7IiD7xKWsg8=3D
X-Google-Smtp-Source: AGHT+IERt4faZXoAKcqd32SoGypbspZ5AI2Z9HzqC72LYU0X3G22k=
6IsrcxS3SxIiC2LoT6Os1c6mw=3D=3D
X-Received: by 2002:a5d:5222:0:b0:343:357f:6650 with SMTP id i2-20020a5d522=
2000000b00343357f6650mr3848599wra.45.1711833027100;
        Sat, 30 Mar 2024 14:10:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a056000036c00b00341ce80e=
a66sm7288097wrf.82.2024.03.30.14.10.25
        (version=3DTLS1_3 cipher=3DTLS_AES_256_GCM_SHA384 bits=3D256/256);
        Sat, 30 Mar 2024 14:10:26 -0700 (PDT)
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
Subject: [net-next PATCH 1/2] net: dsa: microchip: drop driver owner assign=
ment
Date: Sat, 30 Mar 2024 22:10:22 +0100
Message-Id: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: linux-kernel+bounces-125886-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 21:10:55.9808
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 8bb881f1-4212-4ae7-10e3-08dc=
50fde3e0
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.392|SMR=3D0.342(SMRDE=3D0.035|SMRC=3D0.30=
6(SMRCL=3D0.101|X-SMRCR=3D0.306))|CAT=3D0.050(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.011))|CATRESL=3D0.021(CATRESLP2R=3D0.018)|CATORES=3D0.015
 (CATRS=3D0.015(CATRS-Index Routing Agent=3D0.014)));2024-03-30T21:10:56.36=
1Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9039
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.008|SMR=3D0.007(SMRPI=3D0.004(SMRPI-FrontendProxyAgent=3D0.004))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAXsCAAAPAAADH4sIAAAAAAAEAI1SS2/T=
QBAeJ/Y6ceNyQF
 yoQKOeWiV2HoS0PIoKbSSqFnFo4Wo59jpZJfVW9kJpgBN/nNlN+gC1
 UnLwznzzzcw3k/nDDmTBUeRYXoio4GNRKl5EaSG+82JrG+NZweP0Ck
 uuSlQTjqG8zHnRwlLiguR7qeQl5lJhznmKSoa+53unYpzzNJBZFoyu
 XuNxMb8q50pmeCznM3lZTgW+nV6D4fQa3J+JPC5kKIvxO98LgsD3ln
 3Kds5VOy3j9rlICplMxEV7Ws4j0h0m+Au7qLldzMSMYzKJ8zFPW+Sn
 fMaVkPlWsK11pSLLMAjGQmHcXqXyaBWW74k85T8w2e0OBtmo3+/Eoz
 DceRXzTvdlZyfejbHb6Qz6fTPTap19r9lsrtp+fx+DXq/X2sGmfgZI
 wKfPh19OhtHh8OvRwTA6e//hZLhF9BYu8yKRlttvaGmlipVI6Cm+Jc
 ocwqLnDXHp7uFPYi9/4X3gTTCPzzm9e7hJNYLyUqhkstmi6f8nmnPS
 xLOPR6fRQnLrnoIyi85jKhKpeER/8J7Rlio9wx367zt2KNJ/yMuJtQ
 i6lF74oh929UX4HoANTgWqVQseg12DOoO6CzUCq+A44FKILV3bMF1m
 gQ8uuRWw6+DVYa1uwXNteEzjDUqnaNVEqaxrbMuyLQDLYvoLFSrlWv
 WFXYNHtilI9v25UHk4VHWANWC9YfkMgEHjYab7YMhiNu3BcozCyq0N
 DtNrcWku6kILoZQ1k1KFGjM4IR7YC2PdhBg8YfDMNvVNaMOBuq0THQ
 ZPK5qmNTukxBD08mGD8JrGa7ctLG+hpwI0f1XbfwED2mjCsgQAAAEK
 +gE8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz
 4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNp
 b24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9Ij
 EyMyIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgICA8RW1haWxT
 dHJpbmc+a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPC9FbW
 FpbFN0cmluZz4NCiAgICA8L0VtYWlsPg0KICA8L0VtYWlscz4NCjwv
 RW1haWxTZXQ+AQzSBDw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbm
 c9InV0Zi0xNiI/Pg0KPENvbnRhY3RTZXQ+DQogIDxWZXJzaW9uPjE1
 LjAuMC4wPC9WZXJzaW9uPg0KICA8Q29udGFjdHM+DQogICAgPENvbn
 RhY3QgU3RhcnRJbmRleD0iMTAyIiBQb3NpdGlvbj0iU2lnbmF0dXJl
 Ij4NCiAgICAgIDxQZXJzb24gU3RhcnRJbmRleD0iMTAyIiBQb3NpdG
 lvbj0iU2lnbmF0dXJlIj4NCiAgICAgICAgPFBlcnNvblN0cmluZz5L
 cnp5c3p0b2YgS296bG93c2tpPC9QZXJzb25TdHJpbmc+DQogICAgIC
 A8L1BlcnNvbj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgIDxFbWFp
 bCBTdGFydEluZGV4PSIxMjMiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg
 0KICAgICAgICAgIDxFbWFpbFN0cmluZz5rcnp5c3p0b2Yua296bG93
 c2tpQGxpbmFyby5vcmc8L0VtYWlsU3RyaW5nPg0KICAgICAgICA8L0
 VtYWlsPg0KICAgICAgPC9FbWFpbHM+DQogICAgICA8Q29udGFjdFN0
 cmluZz5Lcnp5c3p0b2YgS296bG93c2tpICZsdDtrcnp5c3p0b2Yua2
 96bG93c2tpQGxpbmFyby5vcmc8L0NvbnRhY3RTdHJpbmc+DQogICAg
 PC9Db250YWN0Pg0KICA8L0NvbnRhY3RzPg0KPC9Db250YWN0U2V0Pg
 EOzgFSZXRyaWV2ZXJPcGVyYXRvciwxMCwxO1JldHJpZXZlck9wZXJh
 dG9yLDExLDE7UG9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDA7UG9zdE
 RvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2VyRGlh
 Z25vc3RpY09wZXJhdG9yLDEwLDA7UG9zdFdvcmRCcmVha2VyRGlhZ2
 5vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZHVj ZXIsMjAsNg=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 1708
X-MS-Exchange-Forest-EmailMessageHash: 7EC61AD4
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/microchip/ksz_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchi=
p/ksz_spi.c
index c8166fb440ab..79ae01507a8a 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -222,7 +222,6 @@ MODULE_DEVICE_TABLE(spi, ksz_spi_ids);
 static struct spi_driver ksz_spi_driver =3D {
 	.driver =3D {
 		.name	=3D "ksz-switch",
-		.owner	=3D THIS_MODULE,
 		.of_match_table =3D ksz_dt_ids,
 	},
 	.id_table =3D ksz_spi_ids,
--=20
2.34.1



