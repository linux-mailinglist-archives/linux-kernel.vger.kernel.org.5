Return-Path: <linux-kernel+bounces-157911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A44918B187F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69C6B24A42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C63FBF0;
	Thu, 25 Apr 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="Yju3SB8p"
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8291B5672
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008986; cv=none; b=l9AXM7p5/f9ph1lTV9h/MWsQdklyct6AW23hG8S3OrDlv2Bvy2mW77fnnAhvC7N4OAqlp0V79zftijLzDYJOjA1OBeqOJ9t6MtD/dujggJWSVa4r8gPEt0JT+0oxmo63+mQpVleo5mafNfzXDCEdcjpq7brEbQ8ofdEv97TZBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008986; c=relaxed/simple;
	bh=i5RAFEvP38r+a961SX0tfBJyIu32q/b7hWAnaImObT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Az4axL0nlFeslJHZayhsl0aCWzDL8PZUNwMuFrUBERDM/SfgnvTaDc+PqiLN0/ZlyAUUdMFb5oOBbyS5EGn7Jhfz0cn+wxnzGfDk6uDJ6KsSwd7Cvt3M1bLuUBltSEb5ZGA3w0ZzxJeyMNuojdfexjAivzF9Y3nl8rSS/OTWFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=Yju3SB8p; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1714008983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5RAFEvP38r+a961SX0tfBJyIu32q/b7hWAnaImObT0=;
	b=Yju3SB8p/zEPWCnxQcSVWzZ88KTzTnTX39wMLUKDqCJhrOzjAmqo4V1F+T3ImoRl/X9Lpk
	VJf0Et9Edt35eFu1j+gSgKDmqX9kT5/GzyC0nOaunbaR85lkXOh0U6ZqVg9+0dVzSLo4Pn
	nvFVgIAkRweS8U7GQbzgd9jwSOe/Lf4=
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-8wqMumzKMGyZXTQXh4PM-A-1; Wed, 24 Apr 2024 21:36:21 -0400
X-MC-Unique: 8wqMumzKMGyZXTQXh4PM-A-1
Received: from MW5PR84MB1572.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::16)
 by EA2PR84MB3376.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 01:36:17 +0000
Received: from MW5PR84MB1572.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7ca8:95d4:be3e:9ea4]) by MW5PR84MB1572.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7ca8:95d4:be3e:9ea4%5]) with mapi id 15.20.7519.020; Thu, 25 Apr 2024
 01:36:17 +0000
From: "Trexel, Ed" <ed.trexel@hp.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "jreeder@ti.com" <jreeder@ti.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "srk@ti.com"
	<srk@ti.com>
Subject: RE: [PATCH net v2] net: ethernet: ti: am65-cpts: Fix PTPv1 message
 type on TX packets
Thread-Topic: [PATCH net v2] net: ethernet: ti: am65-cpts: Fix PTPv1 message
 type on TX packets
Thread-Index: AQHalhdcGrDqLZJbJk++v+oR/kZMA7F4NTNg
Date: Thu, 25 Apr 2024 01:36:17 +0000
Message-ID: <MW5PR84MB157272BC110ED170C35983F790172@MW5PR84MB1572.NAMPRD84.PROD.OUTLOOK.COM>
References: <20240424071626.32558-1-r-gunasekaran@ti.com>
In-Reply-To: <20240424071626.32558-1-r-gunasekaran@ti.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1572:EE_|EA2PR84MB3376:EE_
x-ms-office365-filtering-correlation-id: 48d69516-007f-44d1-0005-08dc64c81a53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009
x-microsoft-antispam-message-info: =?us-ascii?Q?VBheZC8P8EljXODi0ajdakAL67JNeQOSorEHerOIcwL1cpbSz2bHX5Zt+b+J?=
 =?us-ascii?Q?qQgJuHaqO07mdap6TaJjvcEptnuT46qdxbqmIuZYUY9XIYEM7UG4gAFNqpvT?=
 =?us-ascii?Q?ZWtvk6iG5spLOtG0yxMXEekjEoxzDPYToTP4fZ3FXtzbKaAM1TE8NCMO+zw2?=
 =?us-ascii?Q?AJH1ayHw7MbQbU+9yimd5DXbsMkOAfZZwwMStWcSHAZBUTjPxRnYCF8wXk2Y?=
 =?us-ascii?Q?oUYdrKBRL9p3hx7b+PS8IYyDxjXUnP3cbw0kNJeHG7L4ss+6CNT2AqBZH5bM?=
 =?us-ascii?Q?urfzx9y/nnsrPAytFGPCbNeul+WLLG1oweLofkM5I6AgeaNO5YynlqFzo6Pj?=
 =?us-ascii?Q?XxDMwxQMliYLidPcPbgGhN6HpfObzrzBtKwrXAGqFp0ABJHeytNq8SeKIyht?=
 =?us-ascii?Q?7tW3UlzCZmopFbNgR1v3Wo2UZLU6Mr3jZ+Im9hY/ladHPQ9l+T4r3YN2Wdd9?=
 =?us-ascii?Q?L2Octnx5SNteICPiaYSAiyLXnOMQ91J+oH74CK/r3kgwld5acW86MFtXyRNt?=
 =?us-ascii?Q?ABIRHEWZUh63ANnVn/RUGe/swCy7u3QpkbBte7a+DTnqcoGVyTGDluwRHVf2?=
 =?us-ascii?Q?sQXS+NRAjcSn0TrucXZV3HbGMUUn6XhhJDioaygs6/YWGMzVW8DJjbfclAD4?=
 =?us-ascii?Q?sFGHxt3MReOJZ4O3z9Ia28+ARTxWAsfKIJg74zFOgkyJ7Q32ywQhnfuipaI9?=
 =?us-ascii?Q?0Gu7hQmwDvEYULU0DKkzRy5OsI43/3QugUtjvISs9yKh+RRD1mNV6oL/YX3m?=
 =?us-ascii?Q?y5o6TDlWutFmg6gDK1eGJeIivCRlZXDu6elAeRwMlq5iIBgfqkjfKABETXc9?=
 =?us-ascii?Q?e9fgfnCIkq5YaCPZWnxzrKso7I20NV00rrqgy6+QksqbqBR+qBEIz+Ig68zB?=
 =?us-ascii?Q?luRhWU3dsGT9mychMR7ewADjfTkB7v7Ja9Ug8CNU0c9UtvC0IpmFlOJDwRVa?=
 =?us-ascii?Q?8RzzflCyOUB/gQRGQSHzCm/je2VX2znzqwA9deuomXdER3sVrT7PL4IpfWCo?=
 =?us-ascii?Q?PYCJluanBB6oUzTj9LRcKZ8I3FhiLEm4uxtEfRki6NHRIU8MEUW4z1EcdzA7?=
 =?us-ascii?Q?+JASDQUFAllZaoGx1UbgVS7drfvC1w1k+h2JOPRCClQ1k5SzY/AnxnHRqA0R?=
 =?us-ascii?Q?+SPidYZOy4Lvhv5eZ/Za7l3vqMuIyM7pfwWTxdf4F9ddY8Omm7A9iHPbQCqE?=
 =?us-ascii?Q?09cmxekq4LEYi5Iu4J+2bOgPk+tQdlNhz8gfkDvFs7T81Xfezo0cP+OmUZkM?=
 =?us-ascii?Q?AYRdUw5vCZ322KYs0b8wBrRur7ie5M6SkJbN4q6+9HOohY/f2HEWJ39fnbFm?=
 =?us-ascii?Q?8BoQoCWXEQDKTM1LLlA9gGzOzI+typDaGhB8o1WP2694WQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1572.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TUT/t+CFEwrZIdCHUqCETKv+NiE4Wqml7fBkYEpyXTBl1nRpbNt2GFwqsbBU?=
 =?us-ascii?Q?WB29uK0XX9Lni1S391aQnLIWJEVPfrnDTzErpInQknSryJo4ZdgEpFk1i6dh?=
 =?us-ascii?Q?aPJg4/7XNON92Un7PMU3Ax7zdpVb8nDZhQ16xqpCidmW3xgtRcmfsQV/jaAa?=
 =?us-ascii?Q?cOp4Tc04fd5MZtvoqYCrswdREEF/KsjGOWlVLgri1+KnQm2C2P69SoMaa8Dk?=
 =?us-ascii?Q?w2j5H813CZU6CNOP+p38vWFvGN+goXiUBGD2YFehMQCH82Ab5ol2uIYUSlM4?=
 =?us-ascii?Q?ntpoe75TsCSmd09L1Ae0kWOFzoYm8ix9VwA3W1qPpWz2mLVfG5i0RnkAUZsy?=
 =?us-ascii?Q?4J0JRqnTU/2NkcS6LDklhhyVXm7IFnpLm8o7PnRmrWu3xDt7zGiuOYNaW7Wv?=
 =?us-ascii?Q?kFIuPnmHvvFi2qiZ8VLEggZJ410aqO8xh3/PEOnPB7FoL7R2O0lLmW9tXu8x?=
 =?us-ascii?Q?n7sa8wEJyyAahnHOPWnPa7GH8sMcPLafty+Y7V9toh+5bZJPXUgOK4PZXiPb?=
 =?us-ascii?Q?QhIfzFY6mBzCXCidAAfP+mvx6pvXa87q3kI5T0jmorrAklXvia53G+9nnten?=
 =?us-ascii?Q?qf5hyFVQQ5tbamWLKi1lvtEb9XL2OAcnZyHsU4GY/RmIu8RtJYKdbydZocqk?=
 =?us-ascii?Q?fO5rNA47YT3MKCgKLIgAKa8nvDF75q7/96OwHxCcIic7Yt1vAJ+3FrGjabpN?=
 =?us-ascii?Q?9/c7e7U5GsW22vyNU68J9ivgWXsT4hEsbUr/eA8eZApg1+qg0TNgVGhZ3q4H?=
 =?us-ascii?Q?EUoDO4vKt+ufgbW6myTj60wnnm8pO2UM49ao641Ss0NjpTPh7DyB60FE7yw7?=
 =?us-ascii?Q?4F65nkZ8wxw8lWUfcU1F4JaRNl6qwniiC2LE0xYsJnESSE59AeTGdFiXQjQM?=
 =?us-ascii?Q?+UpQPeh8BNHWFzzXrEcFja5goiuoRtN4H1SGoISiS1abp/S+Ox2HEIOR6cEx?=
 =?us-ascii?Q?OTQKrt1JsWRybGFI23Bc0OgDwSW7wJ613j3xFXk8X6j5ofh+oAqdwtwi/8xO?=
 =?us-ascii?Q?QlrK2qHOFn8L96qMv7N3vsI960Ts4EVPzxASRmOVW9oxjP2trT2isyebYTv6?=
 =?us-ascii?Q?DzGrkIHC6KScURP0spbKbY108uPnqyzcgae3cpW9gIiAPE4SCR9ThaTjTj7S?=
 =?us-ascii?Q?QWX9KbfLtEROOD2JWSJps1IloDC+W736EDv/AvQ8cwO1O46gL0NQlikUlBLs?=
 =?us-ascii?Q?yzDC99dNm058EEuv7PEHO/XGnAxPIbj5+SaVlYCVrv/C3/qUBNd0myrcbZ9a?=
 =?us-ascii?Q?E/SfH6jGH2tmoutziKZfsuB59S5WxOm1sfvs2g/XI+vE3EmDRPcL6CwBiO2y?=
 =?us-ascii?Q?i0XqVLemsijEsisWUFGw/YMIJu11h1kSKZHXLcz3HyldH6Yc60efhn8FYxP1?=
 =?us-ascii?Q?hR0h5cK125RuGRIdcHOXjoUHkOAvzZzRFJ+PBhwMQcrurewVefY12B12quPY?=
 =?us-ascii?Q?eP2vg6wOjnGjc8HodiBezl5jlBJjcFxGL+mmLtduMMlk1ox3Rh+PVu6obKTe?=
 =?us-ascii?Q?ZOv35PxJXVtyyn3IC+rlus1PFtbDmMQpDYYTJpVat/Pi8LXRZeV1r8vP/fkV?=
 =?us-ascii?Q?XX9XLuScjCxufCHjFTQ=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1572.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d69516-007f-44d1-0005-08dc64c81a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 01:36:17.7353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RtaIFC76cQM0i2VwW2KCOwBk+KAkZ5ygsMODgEbQMMY3qb8K4jMlPOcAmzi269WjvSx6v1QqqvzNXfOgsMRUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR84MB3376
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

From: Ravi Gunasekaran <r-gunasekaran@ti.com>=20
Sent: Wednesday, April 24, 2024 1:16 AM
To: s-vadapalli@ti.com; rogerq@kernel.org; r-gunasekaran@ti.com
Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redha=
t.com; richardcochran@gmail.com; jreeder@ti.com; netdev@vger.kernel.org; li=
nux-kernel@vger.kernel.org; srk@ti.com; Trexel, Ed <ed.trexel@hp.com>
Subject: [PATCH net v2] net: ethernet: ti: am65-cpts: Fix PTPv1 message typ=
e on TX packets

CAUTION: External Email=20
From: Jason Reeder <mailto:jreeder@ti.com>

The CPTS, by design, captures the messageType (Sync, Delay_Req, etc.)
field from the second nibble of the PTP header which is defined in the
PTPv2 (1588-2008) specification. In the PTPv1 (1588-2002) specification
the first two bytes of the PTP header are defined as the versionType
which is always 0x0001. This means that any PTPv1 packets that are
tagged for TX timestamping by the CPTS will have their messageType set
to 0x0 which corresponds to a Sync message type. This causes issues
when a PTPv1 stack is expecting a Delay_Req (messageType: 0x1)
timestamp that never appears.

Fix this by checking if the ptp_class of the timestamped TX packet is
PTP_CLASS_V1 and then matching the PTP sequence ID to the stored
sequence ID in the skb->cb data structure. If the sequence IDs match
and the packet is of type PTPv1 then there is a chance that the
messageType has been incorrectly stored by the CPTS so overwrite the
messageType stored by the CPTS with the messageType from the skb->cb
data structure. This allows the PTPv1 stack to receive TX timestamps
for Delay_Req packets which are necessary to lock onto a PTP Leader.

Fixes: f6bd59526ca5 ("net: ethernet: ti: introduce am654 common platform ti=
me sync driver")
Signed-off-by: Jason Reeder <mailto:jreeder@ti.com>
Signed-off-by: Ravi Gunasekaran <mailto:r-gunasekaran@ti.com>
Tested-by: Ed Trexel <ed.trexel@hp.com>
---
Changes since v1:
-----------------
* Added Fixes tag as per Paolo's suggestion
* Rebased to latest tip

v1: https://lore.kernel.org/all/20240419080547.10682-1-r-gunasekaran@ti.com

drivers/net/ethernet/ti/am65-cpts.c | 5 +++++
1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/=
am65-cpts.c
index c66618d91c28..f89716b1cfb6 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -784,6 +784,11 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cp=
ts,
struct am65_cpts_skb_cb_data *skb_cb =3D
(struct am65_cpts_skb_cb_data *)skb->cb;

+ if ((ptp_classify_raw(skb) & PTP_CLASS_V1) &&
+ ((mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK) =3D=3D
+ (skb_cb->skb_mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK)))
+ mtype_seqid =3D skb_cb->skb_mtype_seqid;
+
if (mtype_seqid =3D=3D skb_cb->skb_mtype_seqid) {
u64 ns =3D event->timestamp;


base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
--=20
2.17.1


