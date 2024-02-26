Return-Path: <linux-kernel+bounces-81023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A529866F26
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F871C24CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7180A1292FA;
	Mon, 26 Feb 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=innosonix-de.20230601.gappssmtp.com header.i=@innosonix-de.20230601.gappssmtp.com header.b="zwAHLVPG"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB61292E3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938915; cv=none; b=nR3pPDDcfefl/JmItkqOIOIrwS61ADnEa92mUU23qAJWIRdOfd+ZlC3ovZ+3vW5gMyFo0zwQrDYpkYrgHOu7gSmazP2CTa5Krc12gIWljjino9wBMc8gZTVz+3qfxrMkptRMC3G8WABsGSAEKlvGNTPp7aTvs0ZRB/2ES/qcdPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938915; c=relaxed/simple;
	bh=mRwbDpb0ij8Xw2/ZTB1QFqO3lhOKWpdvaWOhLI8/l0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j3Mv2hx009OPLQK1s9sCgWvRtjqcZY2ZVr5RBoEYPop6Z5GGtK1Ni5ecmW9x9OYAbKkJCfI/jVWmLwbhW57o4QXHK1Ds4wqTgVGpL+Ttu9I7Rbmtiu1FPXtNEGvzZ7z9/VPo6nKxEntVfi8yEuhe/G0NtWQYuT84F2z+c8EXfzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=innosonix.de; spf=pass smtp.mailfrom=innosonix.de; dkim=pass (2048-bit key) header.d=innosonix-de.20230601.gappssmtp.com header.i=@innosonix-de.20230601.gappssmtp.com header.b=zwAHLVPG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=innosonix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innosonix.de
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-565c4d0fa48so196789a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innosonix-de.20230601.gappssmtp.com; s=20230601; t=1708938911; x=1709543711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4bvmsbUVP8t3z5aGFyV9accu6q6ga6KJpKlOm2I6Dc=;
        b=zwAHLVPG8Q7ZoZL+1y2y8w1fsv4cQrM74SkZYYACrxGOmo42eqcdNCRa0fvOL1Qgzg
         Ul4FJ7hTO8CEabPVfChNNvujnag940JY1Ggra2Wh/FG0YLcIcLxTZQuHAwBlWHlieGgG
         2dzdswMDFNPYZPZqp/c45a3cFspfO+wvU8lbFv1toq9fAfnX0HOzlHhBd1HQJcRzO4M0
         4lRs5/G78i1U3h0+rk6/oIOGE4UIdL8dGs8p2wHxbLcgEQ3O5rA/XwToWk8sJ68k719S
         wHYN8vQ4RpBHipgaorGL910aujhsrA6yQkf5le4HeNUYkmDiRiyY2lXzJq7KLWTscT8G
         dFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938911; x=1709543711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4bvmsbUVP8t3z5aGFyV9accu6q6ga6KJpKlOm2I6Dc=;
        b=HrXXJuyP50smIrh99utUIvw0DQ82//LH3zTiinG5QweFCdK9qMObzu7xP0ynaPmw9P
         iK+uQQ5J1jgCVVnF6AoFGpDpd/k1Cnee2sdoFPnt/iyVqYH+Qm5hvrhfGWinym4SVoDF
         ubis/AvW6j6H9QNpjJDydlaUynMbyrtEbFsctP6ekfRHBUpQ5aS/+a0Ge7yj3olnPNSL
         GSzW+2/5cYH2LIi0F6/JkPWBQUcoiWfcXIYnN97HMdqBEtEgbJJvd83jXLxrlvlRj2bq
         ggLLcVlAoNCYLZB33oa98uScFxieEvv3YZ2d/QxuhFA0s8N9XMD1JvwkkCRar8/wgj9v
         T/yg==
X-Forwarded-Encrypted: i=1; AJvYcCV9iqaocYOKWsaMJJeRD8Oeh/AnxrIkDzMTuWHAvUsBMb+AC75Fzu2ndJ0gqgXWkjT3R6Jngzs+Vf+lor+FsQdktO9zVBYbgHFNLIVb
X-Gm-Message-State: AOJu0YxAvl87dQWMhOaSdSyidiqBB5KB0dQSV8uXOrxOu4cxbFtI2joE
	YImjdZIr87IbNielKrt2tXDQCQ2rmTKNj4RP/L6gDNquSHY2Pdov3Qjuq0dO8EL7JF8fI8IWdlh
	C8qTDyipIcdLLWqDgfnE77dJU2crC1LxpDifOyPVyko950I0AX86+ieA=
X-Google-Smtp-Source: AGHT+IEVD0IlFEawq4IEerLcFn9x9qaXN2oGPFLx3sq15fad5AHZ5PISUKCrY+x8u4PlD14Jrb2VnA==
X-Received: by 2002:a50:9549:0:b0:565:4b6e:7f71 with SMTP id v9-20020a509549000000b005654b6e7f71mr4830055eda.3.1708938910570;
        Mon, 26 Feb 2024 01:15:10 -0800 (PST)
Received: from localhost.localdomain (p549da391.dip0.t-ipconnect.de. [84.157.163.145])
        by smtp.gmail.com with ESMTPSA id bm17-20020a0564020b1100b00564c7454bf3sm2163206edb.8.2024.02.26.01.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:15:10 -0800 (PST)
From: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>
To: 
Cc: Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: dsa: mv88e6xxx: fix marvell 6320/21 switch probing
Date: Mon, 26 Feb 2024 10:13:23 +0100
Message-Id: <20240226091325.53986-1-steffen@innosonix.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As of commit de5c9bf40c45 ("net: phylink: require supported_interfaces to
be filled")
Marvell 88e6320/21 switches fail to be probed:

..
mv88e6085 30be0000.ethernet-1:00: phylink: error: empty supported_interface=
s
error creating PHYLINK: -22
..

The problem stems from the use of mv88e6185_phylink_get_caps() to get
the device capabilities. Create a new dedicated phylink_get_caps for the
6320 and 6321 to properly support their set of capabilities.

Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be fill=
ed")
Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/c=
hip.c
index 9caecb4dfbfa..32b927b7c221 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -649,6 +649,19 @@ static void mv88e6352_phylink_get_caps(struct mv88e6xx=
x_chip *chip, int port,
 	}
 }
=20
+static void mv88e632x_phylink_get_caps(struct mv88e6xxx_chip *chip, int po=
rt,
+				       struct phylink_config *config)
+{
+	unsigned long *supported =3D config->supported_interfaces;
+	int err, cmode;
+
+	/* Translate the default cmode */
+	mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
+
+	config->mac_capabilities =3D MAC_SYM_PAUSE | MAC_10 | MAC_100 |
+				   MAC_1000FD;
+}
+
 static void mv88e6341_phylink_get_caps(struct mv88e6xxx_chip *chip, int po=
rt,
 				       struct phylink_config *config)
 {
@@ -5042,7 +5055,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops =3D {
 	.gpio_ops =3D &mv88e6352_gpio_ops,
 	.avb_ops =3D &mv88e6352_avb_ops,
 	.ptp_ops =3D &mv88e6352_ptp_ops,
-	.phylink_get_caps =3D mv88e6185_phylink_get_caps,
+	.phylink_get_caps =3D mv88e632x_phylink_get_caps,
 };
=20
 static const struct mv88e6xxx_ops mv88e6321_ops =3D {
@@ -5088,7 +5101,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops =3D {
 	.gpio_ops =3D &mv88e6352_gpio_ops,
 	.avb_ops =3D &mv88e6352_avb_ops,
 	.ptp_ops =3D &mv88e6352_ptp_ops,
-	.phylink_get_caps =3D mv88e6185_phylink_get_caps,
+	.phylink_get_caps =3D mv88e632x_phylink_get_caps,
 };
=20
 static const struct mv88e6xxx_ops mv88e6341_ops =3D {
--=20
2.34.1


--=20


*innosonix GmbH*
Hauptstr. 35
96482 Ahorn
central: +49 9561 7459980
www.innosonix.de <http://www.innosonix.de>

innosonix GmbH
Gesch=C3=A4ftsf=C3=BChrer:=20
Markus B=C3=A4tz, Steffen B=C3=A4tz
USt.-IdNr / VAT-Nr.: DE266020313
EORI-Nr.:=20
DE240121536680271
HRB 5192 Coburg
WEEE-Reg.-Nr. DE88021242

--=20


