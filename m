Return-Path: <linux-kernel+bounces-140355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A7F8A1347
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7951F218DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E68714A0A5;
	Thu, 11 Apr 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b="TwJroPQ/"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2116.outbound.protection.outlook.com [40.107.20.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92B1482E7;
	Thu, 11 Apr 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835756; cv=fail; b=uFdT8Bp25rYUdg+E0I/W+KzNi7gkV68SIn6HGl7VGGQGdscgUGw2XAo1NkF8fJYbFv3qjAdQ+Qftqp/BRRL0qkgh/YJOuO2nB7sAbIzojpTfFcDhRcS8XdPvRyjxZfWLFEma4Jr8HPOSRce1SruPXQj9OZNsHulwgbSbN4A4s9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835756; c=relaxed/simple;
	bh=AEZZNxHy99wXn0R7Og3ZsaW3T/iAGVVx+cBtPaM/Me0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fA7Iwfig4W4YcyQfVu32pvO3ZMsrq6uRIwpyUfVP0VP3m24PVYEUURnPWejSwrCNUaMxLeuN+44ludV9z8J+CxHzlGEN1Z5hPWyO7L5Uyn9ZakAAbPt4UVMBplrne9yqe/4xBV6BWEftHZBEm2bvKJ2MUUQ7RJl8IXSAxcNa4Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au; spf=pass smtp.mailfrom=dektech.com.au; dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b=TwJroPQ/; arc=fail smtp.client-ip=40.107.20.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dektech.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8UZiYUX712klkpV4CY/cjg83mMf5BRyyLH+VE2PqfSZZxVW4ZbQoxeGr6bPICOdaNIkB7bI8uyEVUIz3FIYvtQC6yLd5LC5KgwyIU7zV4sKA2m3HKHM+CJS3l8m15vQZ8h7STkOjL8QKG1pRLufsMTHLrbcS5zYh7MdGew5gaQWDkfRhfcMWjpbmN5g2e73FjGT9dxD/bzMY9zXkKoe9KhbC+FoYgcd/+iGMp0Rzfd83syDZigLB5IMpZYrd4Iyj2z1r3+zrkRXIZVhXSHYypbNJf2rTgw5UcKwbeUKzxPyP/LJwCLOgdBS1m14B8fNxYH3+w7BMHS7VL3ekKru9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STzkkRg/1mYBYRIKPRFZNgomZ+5NnWxEGGeDAl0ZMHw=;
 b=UOg1rYGu27R4x1cGBWlJb5krb5V81k8cuCD8eNU1utw0vrwn43uIP8sTbeoZhXfs8ZAs/G3pkV3CqK2RLxzgkKr8QGwlutNBuZ+1mSSpdCN6AIsKE0dle/HDGmurIkU2CNTouar6/hjsZV2sHVa55mx9ko5nAo12wfvXVnMDSrc+JrdLfz9ozZwU0sCYKF2D20M9BCWPMz+b4MRHwvqWLrDkGN6PCCXcpvFE6mldIkje3vF89g3FGTiL6ITVML0h0oiGeTfm8d5MdxGFJBdZ3mqeFFxEiQZK4nhCG5QJBLMQfsTctHvDeymm0RmRUVmPr1OMHnG3yt5BdmTcA5Iryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STzkkRg/1mYBYRIKPRFZNgomZ+5NnWxEGGeDAl0ZMHw=;
 b=TwJroPQ/My5NYcTfqGGpBuUqj6ngoMT63gIbxcHsBwUd2+e44d3Z1cUJY6UdDxBMSX7a94QViSAtFVnbPrluH/mRCWLQEhsbUyzCIIXKvVZp9Q3HfClrm6/k7RYzi06UnFmSzrxXVx0K/n8gNwPG6PgPcWnmx3nZXlnLBtq+IE0YOQorLk6a+mnSL2LLR4a6uD4NuRmvebDCZIZZBiJ8o0F5wx4HgPemDyzNDsDXuI2GMDkVZCD24gX/FM6RAltztwQT+X9YyGrmGPu5cx7FC4Iwu6WbPU4s7whMYMKpQUk4rnab8uIVLKUG3BkrdO4VZQtUyWeerRZizliKemX7eA==
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com (2603:10a6:20b:4ce::15)
 by AM8PR05MB8034.eurprd05.prod.outlook.com (2603:10a6:20b:36b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 11:42:29 +0000
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::8e06:8f6c:4364:7266]) by AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::8e06:8f6c:4364:7266%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 11:42:29 +0000
From: Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "Colin King (gmail)" <colin.i.king@gmail.com>, Jon Maloy
	<jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] tipc: remove redundant assignment to ret, simplify
 code
Thread-Topic: [PATCH][next] tipc: remove redundant assignment to ret, simplify
 code
Thread-Index:
 AQHai/ET8yH2w4BKm0CIExMIZvn7kbFi08+AgAALIwCAAANvgIAAA9WQgAAITYCAAAN8sA==
Date: Thu, 11 Apr 2024 11:42:29 +0000
Message-ID:
 <AS4PR05MB964780C1F48B61844D518C6B88052@AS4PR05MB9647.eurprd05.prod.outlook.com>
References: <20240411091704.306752-1-colin.i.king@gmail.com>
 <AS4PR05MB96479D9B6F9EC765371AA8A588052@AS4PR05MB9647.eurprd05.prod.outlook.com>
 <ce0a63fc-1985-4e25-a08b-c0045ae095f4@moroto.mountain>
 <3011ca26-08d4-4b4e-847e-d68c0751f98d@gmail.com>
 <AS4PR05MB9647FC45E89AECEDC01068C388052@AS4PR05MB9647.eurprd05.prod.outlook.com>
 <a9c41116-98b6-461b-b936-37995a343a51@moroto.mountain>
In-Reply-To: <a9c41116-98b6-461b-b936-37995a343a51@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR05MB9647:EE_|AM8PR05MB8034:EE_
x-ms-office365-filtering-correlation-id: f931e0ac-8698-4188-1500-08dc5a1c77b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CgXYUxFDEVYWcyI/jQufcJ9Bjaajb1YodGs+7K9QfUZcuxA7U1gfinQBxuyy8X3c+Efz3RQNObmbyjfF/5S0v6sLm4+yn3WryWSgtO8n2AzGihoiabYQOQI0YDWqMX1/kA4gshjsfl/c1nTgy0+dDl2hxr3WtgBYustFP9dBjvvRDxSbUcRuThYRBi4cFxjrPPHE93yUiiD5JOmRo6wgInceT9k7dl1cTSxwVgsG8Nw55WwI5F9h4JZVLZyoh1v/ZThc0gIPEsg7oqrBh65afpSX8hv0PiKf17/WouCPJN8Vemr3yL5zgwG94nuacCDMTPoSDE6wYhPP/AR8cutUaZP/HV3Vebr/Baz20jcX6PTmr3seTTKMaRfmXp52r/E3Wr1zKBraXNfIHIbvwz+svakawMkGwJUebIRrsKnEPd7kWBY5rDaQdlzvDg4DGguk/1YSDnsMUWMKvtWIYXFfVgLFgLzyitEFx+N7e7g4Q6YQ0e76ISnnv4rtd+JkdxaWp7N9qFPXvzRi1dU4NMVVqKRdfPsQH0sJ3LghM3H7yVZWjsIwcJidHoKyU+HV3AsaiMWW1YM2bpW2SIM0GCswgPXmjWks+QO9xlrC5nGI9TSm1HrKTD7uoEkgzRQsOu5DMzW7fnCH2dThfZM99YhACLHcH/VMxL64uSZ89buXFJJ2K03yCi8z4BK3J2JkziBirxhzopwB57CZ9+01acqbDg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR05MB9647.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PJ/FR+K+17iQ3qxkbkLLbuZT4zOlQAkas4RFKacaEZTp2ezRNd7Jf84kFEY1?=
 =?us-ascii?Q?Z/7yzFTDHCZ4WXUZqMtAc2TLaeYb2HFjWFZ00gRN2H62G99bOAFrQpwqxfuc?=
 =?us-ascii?Q?HmHrjR9rltQqaw3Y4fFvqBn7Kuhe4z/j0YkoWVZ570ImTUj2injisUDJXyYA?=
 =?us-ascii?Q?LHSmHjPyr2Pei1NwaXk8ppwa1SYoMD/Yh9CaTN0VGHCpqfsi5bu22QiaB4w/?=
 =?us-ascii?Q?vrMMNtJ2Fdvv5P+zLADsWhwO+0MJV3+w7lI/K1MX/kwMd/KKuMFNAHoXSwHB?=
 =?us-ascii?Q?cO0oAC8W4FmEvJpQ4G1nmeFcFMvmXPg3/MAuvEIyt80pK3oQ/bLQaIAKZTzR?=
 =?us-ascii?Q?/Gt54Qdhri0+W568Hla1ZKiOqkM7Eh5EKMVyYIdKrmM7ImLc9Y54YoPMtQzh?=
 =?us-ascii?Q?RYdXP3j0ZkR8UqscsNJONdVUr0vVlJGKFuKBAwpGbpbPxhbs53JLtEkpU0Tt?=
 =?us-ascii?Q?fzfXrepZAOqTaut0P+Cwt5GMcyojsresv8vXpyuyVvx60ANm2LOOzcuiPMji?=
 =?us-ascii?Q?ay+5MhTn/2P9u6SgwCWhZ+cBUD3vidL4HCIH+Skv/l0foHkmusICdrCvpjrH?=
 =?us-ascii?Q?jJgnLAPlEqexnGigq/AlBv4DYTLHRIMjqcWfV9ZgF0NcAuP/YYUY0fHb1sgG?=
 =?us-ascii?Q?zSO3v8Q7pucaaSQGOyfyZHThKY9gjPYcyBIm2yKZLrEzyoll9xOFnCJ96br0?=
 =?us-ascii?Q?+vnSV5k8zf4w79I3yMFV+EipBACY5ByDClj4KbZoxzSbQig2vU/+nYKkBmWS?=
 =?us-ascii?Q?D5Oye18WW5OmtqHsZcyaDU4Vk552Q/CMnY7JN8Q0fIA7wS6OI5Ega/yjd1zw?=
 =?us-ascii?Q?yNqXi7AjwVdFRji8HIyoDh+WcWv5EB9/DBhmIV9B8XUbkeBGLGMHu7n8gAv9?=
 =?us-ascii?Q?6eRJZPkIlpPXgrWR78nGAZ49dwc1zRJa5GdefkwQRJCq3RMrcWBQAqq+1NC3?=
 =?us-ascii?Q?n+XtBUg+YgY9m4oNipbJ7yzPY4M584L6kwTB9+vjthiWkrW9AaE931qRLbz7?=
 =?us-ascii?Q?sK8dRf57hZw1OgJ9P92+x0utTSkkplURP555/45K9yFttZDPttB4XopGpPBo?=
 =?us-ascii?Q?vc4X7m64aiDMwgm9LdWinudbRNhtrH0AMVQxING02iQg1RlT+lbuRX8S8XdU?=
 =?us-ascii?Q?gC3CcLoF/2rjo4Nqh9+wzHsLsZJY+t1Fzp8uEwXq05PJtEZQ9udmg2WyxUxv?=
 =?us-ascii?Q?iakfVmzwgHEOWd4q9DTEqbgYtvIo4Rh95jotJgvB3s9jDl9hUuKIbiuAkkI2?=
 =?us-ascii?Q?1nAMAaor8BKe2qwzQxQNjZ20cxflFAB+3xu00cYcPsSRPsjpjW/1NyXGrQde?=
 =?us-ascii?Q?mg5oN2d/fqTSVgg2dqM1zV+aD1N3g/zYS18FdOSc3LhDHVRuiUbVlpRF6Urz?=
 =?us-ascii?Q?WaZwYIBjbQJgei2J4cgOOLlVT4zGZj8jYPg9QtD4DgqHXoj5uV3PZPuxydWP?=
 =?us-ascii?Q?G5HN9yBDA6leXDqxdjpKmBDTuZomlyHaWGZuRMPvU2h9y1ppgKWn+t1RHQn4?=
 =?us-ascii?Q?g+6GTk4UG/yMfzfSeb79agV5dA5dvy8Sa76MFzha7dSSYCOA7wZhjvoFmYhF?=
 =?us-ascii?Q?21B+f+AO+n+QIsVk2Zrcs6PdUX8k6QKcRDUhvPolq60hhByZzWuisfx5fEWr?=
 =?us-ascii?Q?CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR05MB9647.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f931e0ac-8698-4188-1500-08dc5a1c77b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 11:42:29.3338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzFs9c+tkSWqMwGAbT9UkP/ftIOuoFNVwkmadacazyQkzAMexChWl7sHnt6C630M5tBuMzlvktcd7vUvcnj5kAvjwHsZoaWCVA+7q3UDP50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB8034

>On Thu, Apr 11, 2024 at 11:04:15AM +0000, Tung Quang Nguyen wrote:
>> >Subject: Re: [PATCH][next] tipc: remove redundant assignment to ret,
>> >simplify code
>> >
>> >On 11/04/2024 11:31, Dan Carpenter wrote:
>> >> On Thu, Apr 11, 2024 at 10:04:10AM +0000, Tung Quang Nguyen wrote:
>> >>>>
>> >>> I suggest that err variable should be completely removed. Could
>> >>> you please also do the same thing for this code ?
>> >>> "
>> >>> ...
>> >>> err =3D skb_handler(skb, cb, tsk);
>> >>> if (err) {
>> >>
>> >> If we write the code as:
>> >>
>> >> 	if (some_function(parameters)) {
>> >>
>> >> then at first that looks like a boolean.  People probably think the
>> >> function returns true/false.  But if we leave it as-is:
>> >>
>> >> 	err =3D some_function(parameters);
>> >> 	if (err) {
>> >>
>> >> Then that looks like error handling.
>> >>
>> >> So it's better and more readable to leave it as-is.
>> >>
>> >> regards,
>> >> dan carpenter
>> >
>> >I concur with Dan's comments.
>> >
>> >Colin
>> I have a different view.
>> It does not make sense to me to use stack variable 'err' just for
>> checking return code of the functions (__tipc_nl_add_sk/
>> __tipc_add_sock_diag) that we know always return true on error.
>>
>
>I think you are trying to mirco optimize the code at the expense of readab=
ility.  It is unnecessary. =20
I do not see any issue with readability when doing so.

>The compiler is smart enough to
>generate the same code either way.  I have just tested this on my system a=
nd it is true.
>
Yeah, I do not deny that. The obvious thing I can see is using err is a red=
undant thing.

>$ md5sum net/tipc/socket.o.*
>f5ebea97eeb9736c5b8097158c2b12e5  net/tipc/socket.o.without_var
>f5ebea97eeb9736c5b8097158c2b12e5  net/tipc/socket.o.with_var $
>
>When you're doing these tests, you need to ensure that the line numbers do=
 change so I have commented out the old lines instead of
>deleting them.
>
>regards,
>dan carpenter
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index 7e4135db5816..879=
a8a9786b0 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -3560,24 +3560,21 @@ int tipc_nl_sk_walk(struct sk_buff *skb, struct ne=
tlink_callback *cb,  {
> 	struct rhashtable_iter *iter =3D (void *)cb->args[4];
> 	struct tipc_sock *tsk;
>-	int err;
>+//	int err;
>
> 	rhashtable_walk_start(iter);
> 	while ((tsk =3D rhashtable_walk_next(iter)) !=3D NULL) {
> 		if (IS_ERR(tsk)) {
>-			err =3D PTR_ERR(tsk);
>-			if (err =3D=3D -EAGAIN) {
>-				err =3D 0;
>+			if (PTR_ERR(tsk) =3D=3D -EAGAIN)
> 				continue;
>-			}
> 			break;
> 		}
>
> 		sock_hold(&tsk->sk);
> 		rhashtable_walk_stop(iter);
> 		lock_sock(&tsk->sk);
>-		err =3D skb_handler(skb, cb, tsk);
>-		if (err) {
>+//		err =3D skb_handler(skb, cb, tsk);
>+		if (skb_handler(skb, cb, tsk)) {
> 			release_sock(&tsk->sk);
> 			sock_put(&tsk->sk);
> 			goto out;
>


