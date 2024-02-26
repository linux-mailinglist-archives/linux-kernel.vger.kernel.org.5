Return-Path: <linux-kernel+bounces-80405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068E5866823
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596F0B21208
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CFEFBE8;
	Mon, 26 Feb 2024 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="tUuqVXKn"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4EEEB5;
	Mon, 26 Feb 2024 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914299; cv=fail; b=m6jpylnwx/NyplIeqcQRweB5ba1MPvU56ePyEwRmkYdy1g6p+GihFitmmSviJZPUQ7B75IgwgfBDZDmmRKvE3pUCA+DYzCio2ZUXz8sntGNDvUFmBx0Qt+vengJ2HqsXaBT/OdQEYfImwJYUOftvOl+3OBQis66+9+P5mnsVk/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914299; c=relaxed/simple;
	bh=RQGJTp3q/ZnOcc6gPKZAuikIuPmdQPWVDg4ag7dJ0uc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p8N3UeVy4A885vJ1N72cxOMwCeWuAB/L16MqLxsMZGnY0LYAm7ZPXMoyO6//ABnBiE3ZC2BrGoLFc5NY66/9gl44i3SVCj0h4uFTVGkXS7gr405ec5HNNQutP9AQlv/aLvWLkFw23kbWPOvhvfqz+bBDS+DcZB6/HGC2YT3vpfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=tUuqVXKn; arc=fail smtp.client-ip=40.107.215.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8xB12N3TTPBNbRp0j2hh1Kl4GhPy34ugKN8kkQaylX7ieW/iztYBic/vmOFcK1aTg/KGK/uEAUFctcVPmm/+Ii+PDKe6LPraQn9GNJImIw2fku4aaphI7ucMh3bPQAe4xi0o07wMhC1G61k9/av+6mEraKMS7Wt9NbGnGGFeVuuGVD9mhCjFzj+X902/GxAqfWBX0lMaTd8KilA7aZPT3Vy+o2XUUTagyTqIjaLEdGlnWsq7dY2hAEcsqTxAY65WJblLJkG04wsPgS+27H0ZCUSacMIYb6D2LQAdtQlwf7CitmF4V9Qa91xckhieaj/j9v1ShFBE8n0c5J93Vj9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgcZ7yehYF9wQxmG0pQM3P+OzlWDfXOj/uAp//Ck7m8=;
 b=XvsQsekp3pOT8RG10qMatcXpP6eIB/kDbvp3PmQJdShYKXsQ2nSim/TWIHHjegQolvsxAFL1RvbGqo/yLRxD3Iw23rswrnKnxVPPEVV6WtpxMwb7fKFc9WCs/0dNHlKGfdo3yyW+/pPHI+CWkJ5JyGkA6JEW69CbO7N3Ll3Sqh3ZpimkEL6o29zSZwwYsfGQGkA4sPdxsGCWhF1Is9ErcmawGBiGlzbINwvKmZx0OFGmHT0Cel/T9bMPH9vxpwJYqKsazsLYZQLAztWBidyPvArpeZNyNbQcPyzRJaC+RdWgnSBFK+xJWQNyJbW3AdhgWSZ0+SvuMUGeKwUKqYkyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qnap.com; dmarc=pass action=none header.from=qnap.com;
 dkim=pass header.d=qnap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgcZ7yehYF9wQxmG0pQM3P+OzlWDfXOj/uAp//Ck7m8=;
 b=tUuqVXKnqiUppUfnZ/MrAOarGNeAiuBHfeVTYMlmf9MonlnkH32XojwByh/Nl6HQaqjN7pV0B0sRliJWliGKEfRgkpM5ILrcZKNK2jpBwYyYIST80fg6q8oWgERd/NJyakML2PI1z6gVMcuqNCFnR/TRJZb/KdEDM9+FgZytASCfUGxWrYRMbovAvvka4uuwzyvUdhdG2T6/5sqrFHwmsVgk/RNpWUoJ3ssv6fj138zvHMUvgh3nPOWXtKWPsb6b7cXC6RAFEUtWZdZ5BreoJy5f/bXDFh9yJocf6bovUXJq8pPyEVRlpucu+jqkGnwkdtdwl8kIkbatD59hB2uocw==
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com (2603:1096:4:14d::9) by
 TY0PR04MB5863.apcprd04.prod.outlook.com (2603:1096:400:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 02:24:52 +0000
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::d7ad:6be5:d8bf:6f92]) by SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::d7ad:6be5:d8bf:6f92%4]) with mapi id 15.20.7316.031; Mon, 26 Feb 2024
 02:24:52 +0000
From: =?iso-2022-jp?B?Sm9uZXMgU3l1ZSAbJEJpLVhnPSEbKEI=?= <jonessyue@qnap.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "j.vosburgh@gmail.com" <j.vosburgh@gmail.com>, "andy@greyhouse.net"
	<andy@greyhouse.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3] bonding: 802.3ad replace MAC_ADDRESS_EQUAL with
  __agg_has_partner
Thread-Topic: [PATCH net-next v3] bonding: 802.3ad replace MAC_ADDRESS_EQUAL
 with  __agg_has_partner
Thread-Index: AQHaaFbWkhUe2N25ukCQQErH1cvW8A==
Date: Mon, 26 Feb 2024 02:24:52 +0000
Message-ID:
 <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qnap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5097:EE_|TY0PR04MB5863:EE_
x-ms-office365-filtering-correlation-id: b18f80f6-5ec2-462d-0116-08dc36721d1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 a+Vbj4LbILJVswpYzDj6rQdSBdBIXYzD3UVNKfvYP3UuswVcbK7m0ftYcuCYoWHjX64WI38vZ4gm6HcAO26Q/ec7NOLNNcEyQMHHEG9M3T1KtAfMEW9qmlBgtdvZJWii9yh+8B9ElGacQjfRqwqCA10dtsfgzIAjci9L6XqGsDINLGPeRcMzatkxVVFTumorhKewqEpTvSb9xIfNRLcVQYfZ3oHzFuCBTETc+BhlCLPiEhTi0EkgRzzdjFb6ZFiHfZt01QCO6ThbhuUnrTxm9n3yKZFncQtk2bB/kNBADnQsleR6IYs5csbyI/hmKbbEmDmsMgWqZyp1nezDAMCrZG+uZEHniPLLPXRIxPF9qYLxWnEEf3e5rhdmEpYhwpH60bd6Rxn+akF+qM5/hum5OSro3hKn7k3sOMmxNDwGxSmZI7BW7mYHLsfHhxlCo61HXdU4x0NAFwmgQn/mC5tdSQ3PJ7gZFI3E0FXp1jw+C3eJbb0dSm5BbpbZX9lzySN2ByVW8Opc9NEmVG14ZGxC5u7/cn9fNRvM9+njjb3OX2KrLjFNM8wHZ18NoK+8CSTZngh8DuwImfdUMGMVUzMBj498cJkBWUxqF2zzpN5jrceJ2WCkiIEI4qYf9dPI62zgP3FTyCpM70gQ9SajsYdQwO9q2TCDx5EjhIGFM464jgzek4xyddNHUVEdeZG3aCBYwIjqVi8TFubyddmtv/8/Sg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5097.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?RGNsdlJWSi9jc29DbDAxSWlVSDIyaWZScEF0ejFFWEswWi9naGlqTzlM?=
 =?iso-2022-jp?B?NzhmOEY0NlhDSml6U2Fzc3ZteWRoNnBVdEdWRHpLMy9FZnR3RWROL085?=
 =?iso-2022-jp?B?YXBDWGFzZCtoUDkxTG9ES0xjeUNwSzhxL3BEZkc1MEF2bXpvVVBPZm9T?=
 =?iso-2022-jp?B?eFBBcXU1TGNsMzNTaWRtQ0FWamRLUnNocCtxcStNc2NPWWdsd0luYVBZ?=
 =?iso-2022-jp?B?ZVhVWnRRR2hNL1d4NFAzWXh0U3g1QmF0WmdHTFdYampuQW00dXpwR2px?=
 =?iso-2022-jp?B?c3RYRVJLMXNWNlJjK0dIOGJDUmI5VWorRHRIS01IandmM1Zvc3lwZDNm?=
 =?iso-2022-jp?B?V3dmWnV0dTRIWFoybzllTk9laURXd1F0TGsxY0FNblZzRVMzZzFUTVo0?=
 =?iso-2022-jp?B?THFGSUIyWDI2MmxPQ3RuVTIwRUtZMkNHbFYwNDBIQ003K1VXQUdhZGpE?=
 =?iso-2022-jp?B?RmR5N0thUGt2UFJOSEVpN2V6QitSUWlYZmZ5aTVzTHBFWjMybmdEYUtT?=
 =?iso-2022-jp?B?Y2VGeHVWRzl1SWlZZTNyMUFsZ0dXcm9lUjZEd3p6MHRadVJQSktYRHhL?=
 =?iso-2022-jp?B?cFAvV3YyeFcxdURzUWtmVW5LQUhqbnorL2N3SFRmR2JIM0xJOTdVNkpv?=
 =?iso-2022-jp?B?NkRGeDBBeDRaY1FGQktjZUdMSzJxQXpPNkdtakp4SGNXaS9PaU95dU5w?=
 =?iso-2022-jp?B?Ulh5RXJFK0Q1T3lCM250RHlmdGw5Ylk2dVFhSHczS2k3NEhVd2gvRnZw?=
 =?iso-2022-jp?B?Q0Z0cGJ0cFlZOFcxNGVuSWpoWUJzWGZkMnRXZkZrc3hhZW8ycCt2SzIv?=
 =?iso-2022-jp?B?MU9nNXpzQjFZVjlSVkh3bDkyMjdVeWpBWUVHbE5NckFPNUJOTGtDVytm?=
 =?iso-2022-jp?B?a0JzcGdySXV3eWdEZWxQUGZWWkRPektUTWlJZGhsckN1N0NZT1JVM2VS?=
 =?iso-2022-jp?B?ZEtydVEvYU9SSmdPK1EyenU2VmpERDh6dFZvZlRxajFDT2pManBEQVdP?=
 =?iso-2022-jp?B?MzNpSWpheWQrM0pua0ZvWTN0dVZpQStaWlpxcFk4VThRMUxkWEdpaE04?=
 =?iso-2022-jp?B?SkRXU0UvcXBHczlCU05ZTERySFJ0NlJ3NkJmeVlqSmIwRWs0S2ptSWx4?=
 =?iso-2022-jp?B?NUhKYlZ4R0xSdFlzRVduYkVrcW9TYkdjUFR5enB0SWt0bzhwSDE2Q0lY?=
 =?iso-2022-jp?B?OWpDZjNTVWE1QUpoSlRXTFdNZVE0VlJoa1p0YVZNZnFGSmpiRmQrLy9k?=
 =?iso-2022-jp?B?RlBtQ3FTMTBlRk4rUXNTYlpNUlYzSlBLSjNqcndhc3ZCM25ITFVXcmky?=
 =?iso-2022-jp?B?UzhzOHFxeCtiUHRqVCtJSFdOeGFGditUS1J0U0Y1VnpHWXhacVkvMmJI?=
 =?iso-2022-jp?B?QVdJMkJEcHZJL0dRTjlkNGp6VlZLYVFiUElMMDcrSFk4UThLeVhKRk9i?=
 =?iso-2022-jp?B?R3luZVhMMW12M0czVGtvYURhL1F2SlpXYjhZd3ZnaHU4MWY5OXlYY0hI?=
 =?iso-2022-jp?B?MFlMUllLd0ZTRWs5RGpKU0hUZWFRS2szLzZtVlYxemIrU3cxcldnQzlh?=
 =?iso-2022-jp?B?YjZNY2QySE1FaGNYYkx0SzNjNnZLR0Z2Rkl5RnpZb3IxTU1HUXdzVjJE?=
 =?iso-2022-jp?B?M29vTnVtZ09hd2R3aElhRHdQckJxaTlQNXhKRjg3YkdMcll5OG9DcGZi?=
 =?iso-2022-jp?B?ODJkRUhpSk9RK0xMbm9qWjNGSXZQc2R6MnBmSXJ1RTQ2OTFyUHgvdVFr?=
 =?iso-2022-jp?B?Q3NVYWFVV2tYRFF0SVhBWW9jaWVBQTFEWDU3dlAvNTY0NXA1cDhFNkZG?=
 =?iso-2022-jp?B?ZG5mNS93cHJ2eTF6aklLZ2lta2k3czlFZzkyamVrTnVtNStFRGpNSytt?=
 =?iso-2022-jp?B?VnNsREhLTnRzU0tBcGZZQUx2NTRqc21LTlBMdER6RCt4d0NBa01mUnRq?=
 =?iso-2022-jp?B?b00zbEdYMUFDUzh1dC9Hd0FFUUpsK05QZUlqU1JaTFNNRWRkdTJhL0hy?=
 =?iso-2022-jp?B?T1V2YVFpVXRoNTgvR0R2bHZ6cWtpU0FibTRzSUx0VmpSeGpLR25PVkdK?=
 =?iso-2022-jp?B?QjVxMkFLbUNJNUNNcW10L01FcXFTcERGT1lNNkE5dkxoM1U3TVV6bUpu?=
 =?iso-2022-jp?B?QXU1Y3k1QjZyc1g2dERjZUhmUTNsQzRsZlovSEgyYkNNUkR1T0RXQkpk?=
 =?iso-2022-jp?B?SWpvbExVcXdNQlN4NEVkVnhKam9kZlZ3NkNXS0liaGxiaFBFSnRNV2Rp?=
 =?iso-2022-jp?B?ZjV0NWZibmVSMVNSTkI3OHRjNlJLUkxacz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5097.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18f80f6-5ec2-462d-0116-08dc36721d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 02:24:52.1705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNjodppTAmHdDI4DooNCoh1o3DpLImrIEYNYBP/RYsstadMsxSAQ/fwQhpg6S8atYEyGX2VJaiXI4StQXlaIlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5863

Replace macro MAC_ADDRESS_EQUAL() for null_mac_addr checking with inline=0A=
function__agg_has_partner(). When MAC_ADDRESS_EQUAL() is verifiying=0A=
aggregator's partner mac addr with null_mac_addr, means that seeing if=0A=
aggregator has a valid partner or not. Using __agg_has_partner() makes it=
=0A=
more clear to understand.=0A=
=0A=
In ad_port_selection_logic(), since aggregator->partner_system and=0A=
port->partner_oper.system has been compared first as a prerequisite, it is=
=0A=
safe to replace the upcoming MAC_ADDRESS_EQUAL() for null_mac_addr checking=
=0A=
with __agg_has_partner().=0A=
=0A=
Delete null_mac_addr, which is not required anymore in bond_3ad.c, since=0A=
all references to it are gone.=0A=
=0A=
Signed-off-by: Jones Syue <jonessyue@qnap.com>=0A=
---=0A=
v3:=0A=
  - replace macro with inline function in ad_port_selection_logic()=0A=
  - delete static variable null_mac_addr in bond_3ad.c=0A=
  - re-phrase patch description with more precise text=0A=
  - re-phrase patch description in imperative mood=0A=
v2: https://lore.kernel.org/netdev/SI2PR04MB5097AA23EE6799B3E56C0762DC552@S=
I2PR04MB5097.apcprd04.prod.outlook.com/=0A=
  - add correct CC list by 'get_maintainer.pl -f .../bonding.rst'=0A=
v1: https://lore.kernel.org/netdev/SI2PR04MB50977DA9BB51D9C8FAF6928ADC562@S=
I2PR04MB5097.apcprd04.prod.outlook.com/=0A=
---=0A=
 drivers/net/bonding/bond_3ad.c | 14 +++-----------=0A=
 1 file changed, 3 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.=
c=0A=
index f2942e8c6c91..c6807e473ab7 100644=0A=
--- a/drivers/net/bonding/bond_3ad.c=0A=
+++ b/drivers/net/bonding/bond_3ad.c=0A=
@@ -82,10 +82,6 @@ enum ad_link_speed_type {=0A=
 #define MAC_ADDRESS_EQUAL(A, B)	\=0A=
 	ether_addr_equal_64bits((const u8 *)A, (const u8 *)B)=0A=
 =0A=
-static const u8 null_mac_addr[ETH_ALEN + 2] __long_aligned =3D {=0A=
-	0, 0, 0, 0, 0, 0=0A=
-};=0A=
-=0A=
 static const u16 ad_ticks_per_sec =3D 1000 / AD_TIMER_INTERVAL;=0A=
 static const int ad_delta_in_ticks =3D (AD_TIMER_INTERVAL * HZ) / 1000;=0A=
 =0A=
@@ -1588,7 +1584,7 @@ static void ad_port_selection_logic(struct port *port=
, bool *update_slave_arr)=0A=
 		     (aggregator->partner_system_priority =3D=3D port->partner_oper.syst=
em_priority) &&=0A=
 		     (aggregator->partner_oper_aggregator_key =3D=3D port->partner_oper.=
key)=0A=
 		    ) &&=0A=
-		    ((!MAC_ADDRESS_EQUAL(&(port->partner_oper.system), &(null_mac_addr))=
 && /* partner answers */=0A=
+		    ((__agg_has_partner(aggregator) && /* partner answers */=0A=
 		      !aggregator->is_individual)  /* but is not individual OR */=0A=
 		    )=0A=
 		   ) {=0A=
@@ -2036,9 +2032,7 @@ static void ad_enable_collecting(struct port *port)=
=0A=
  */=0A=
 static void ad_disable_distributing(struct port *port, bool *update_slave_=
arr)=0A=
 {=0A=
-	if (port->aggregator &&=0A=
-	    !MAC_ADDRESS_EQUAL(&port->aggregator->partner_system,=0A=
-			       &(null_mac_addr))) {=0A=
+	if (port->aggregator && __agg_has_partner(port->aggregator)) {=0A=
 		slave_dbg(port->slave->bond->dev, port->slave->dev,=0A=
 			  "Disabling distributing on port %d (LAG %d)\n",=0A=
 			  port->actor_port_number,=0A=
@@ -2078,9 +2072,7 @@ static void ad_enable_collecting_distributing(struct =
port *port,=0A=
 static void ad_disable_collecting_distributing(struct port *port,=0A=
 					       bool *update_slave_arr)=0A=
 {=0A=
-	if (port->aggregator &&=0A=
-	    !MAC_ADDRESS_EQUAL(&(port->aggregator->partner_system),=0A=
-			       &(null_mac_addr))) {=0A=
+	if (port->aggregator && __agg_has_partner(port->aggregator)) {=0A=
 		slave_dbg(port->slave->bond->dev, port->slave->dev,=0A=
 			  "Disabling port %d (LAG %d)\n",=0A=
 			  port->actor_port_number,=0A=
-- =0A=
2.1.4=0A=

