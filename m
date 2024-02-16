Return-Path: <linux-kernel+bounces-69214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F58585D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFA42898AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841BE137C24;
	Fri, 16 Feb 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="VYZ5C28E"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94649135A42;
	Fri, 16 Feb 2024 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109580; cv=fail; b=BQDqV07/6p5+DqmQBGTRFEfum9htuDCXyb8UvHArTEmkmXEIRX/ZI+EOjQwrockSBYPJrgRpd4NqFE9LCy2vcSnXRlCds6MUWbqNvBRVvfK2I7Rge+ECGc8t9fu8lL1W1ijhiz32SgD0V2ufyC0uE36FD4kT/PhpPpF4wDClutk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109580; c=relaxed/simple;
	bh=xkWg7DS9iqO6pm5VOjRltfTNm33JI0ocYZ5kUhuSN4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WwOMJPnRM2jE5qpU72yTc7ZM7Pi5r1GLJm2D9ziTU2thwxLp92JlktBl6aGln0RevjBu+cZ9w5szIjETRuKDSJqd/EPi/ztUG4b/i5EzGWhqh2jI1DRx92x1BaRqlxHa2gViBlU3eS5QNl5ZSOTblKL7YdaxbiZ0H55MJaNXORI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=VYZ5C28E; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GHv9v9014467;
	Fri, 16 Feb 2024 18:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=nBHfrgfFUaNH+IcMndXyGzX6WFPI2LncIk5zrMX4jz4=;
 b=VYZ5C28EiDOL0VQttWeTIF4dn42i1cGDDK4kBjnjRq5itmxeMvDtfqRiZdzbK8p+dKP4
 49q1I4MriwdECExWVJOMeWcDhuh1GJ3QZ/w253XeI6EVBFvnxHBJ7iOiRKaNgH2PqsYp
 G9CUiCX0aEnGRsFVP7lLmEabU0v+atl02cYZRojzvd4V0hP55+wPiN6++opCXq7P7cl/
 3+wr8y4rbeP9UXt1RaoghWiPrjNbel3PURmDSHnDw/7EXRt7z2oR0o2VAp0Li8BAR99C
 2lFpoRAkYvNk898Ux5rHx0fucVG0ZTk972vlsTa6Gfa91MPoS97aNfeC04mub/ArdZ6f lw== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3wa9gtkatf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 18:48:41 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 3EEA72767D;
	Fri, 16 Feb 2024 18:48:40 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 16 Feb 2024 06:48:16 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 16 Feb 2024 06:48:16 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 16 Feb 2024 06:48:16 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBtN48W40kyXVHcwrJNm6gEdSi2Z4kFNTPbrh723VCIJeewnCtGAEuVLJRBKBXX3mb22/mybYnJr1hPLONMnNVCZiF63FFHDEQNU1v2sYwsdH1twIWiE5J+/8GsWUaHIukaEgjmh7frM1nEpURxOdzfc2lkHAtYLLXiwyOHYbhJaw3kpAfMa9QxfvFwCeDl32+2lozPhwGPbO2RO2IQtmPwseXvYQCXRlxQM3wcpvGKFbR24Eo41UgGcX7aid+k4iINmdnyemhSGoASiQoBf10oi5DIgUgHWXghFupgzvZGiEmw9rVmLJeN8H5g4GB5yJ2YWrdLLA0iLNEDxCCiTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBHfrgfFUaNH+IcMndXyGzX6WFPI2LncIk5zrMX4jz4=;
 b=bsEZqpsNBMxWSLie8Yc9gUhbJaohkg7WzDuyRSDgoSgARE7yhxYndSDoazKbHaS+7I8nvXkgST6oUSeTLnLf8oK1jvula52PenS7LVpHPgnq2mJWniMA9uUATXayulhvtsrcu2vRjxwUUIez2tDjEvN5+Gyrs4QaJCJ2q6Q/s2othtF74/Bx2aTbL1BJSs7Gdqg8UP7qFRxyptHOqRByZ1iatV/5mrJ4ZTZVr/OKfC63NLi0uAurGiKaLoCh2CW0ZM4vouRlr64nGrJaZ1ztELsNib2PgCGWC/SuyNp4xo1l05U6bROd1ITWVGhAKRkkt7iaMGnooqVY4XVyTH6ocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1694.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 18:48:15 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9c4:2ca:bc63:f0d6]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9c4:2ca:bc63:f0d6%7]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 18:48:14 +0000
From: "Elliott, Robert (Servers)" <elliott@hpe.com>
To: Stefan Berger <stefanb@linux.ibm.com>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saulo.alessandre@tse.jus.br" <saulo.alessandre@tse.jus.br>
Subject: RE: [PATCH v2 06/14] crypto: ecc - Add NIST P521 curve parameters
Thread-Topic: [PATCH v2 06/14] crypto: ecc - Add NIST P521 curve parameters
Thread-Index: AQHaYGT5n3XQ+RCgI0uVCceBNs3BVrENS+AQ
Date: Fri, 16 Feb 2024 18:48:14 +0000
Message-ID: <MW5PR84MB184295E25332F1516BE10BA5AB4C2@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
 <20240215231414.3857320-7-stefanb@linux.ibm.com>
In-Reply-To: <20240215231414.3857320-7-stefanb@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1694:EE_
x-ms-office365-filtering-correlation-id: 3e1705c7-b962-4533-ef87-08dc2f1fd535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BudxKRWElGVFDy3B08DJubzZsCGgD4BB7wPrFcR7QtoCT3VB30jZxU8Mz1DOlkeXOfj1C0Qut3l/LdYVmKvWMLz+jVBq8tu3TTVwqlPiNtTNt6cFoFVDtlx8hiueeoCnFmB1nJCdFtHK+RYj232Tun2bxO4rfXbgDD5VMnSViJtO/UipzMl4G811qPKUGkWLgXWtAfIi+HPBtDalsX05+KjZRE/zcQX5hKgm9fH4+FnHxn9GTEIzHPfhnmRxBU649hU40mSmtkV1WG7IVQfFV0DpujR6bg6V8K+wPbuptXxcVf2cgJj2oRn28MCgYjUHdu9KLG9cCLcQGfdtuXXZmXw7RtAvslynEeoHPCzKdveLlQCe4ov5nx9rZx7EAHbaTfWIFGEzYSRJFkPYScZi1fYNWvLMeDhH2zUPHNQs9rZkk89MtYyBpYr0WcLQUUn5W6LVpj+Jrs4bndHCfKmkjTbUM4byDzafAHi59sSwDjzFsXj9w2tULHcHZlNqkVIUuULnLjmWYyhilHNB3y7CPqzoOUmUc73zWJ8ZhJ1hga/UglemWnI0EHweh+KHy7BDhP6DpNMV6R3WI1GSP2fefpsgfRxLIE5zRZSU7UCUBff9fC/MOLoo/+MjzrB8KqRj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(478600001)(41300700001)(53546011)(55016003)(2906002)(66476007)(8676002)(5660300002)(4744005)(76116006)(66446008)(8936002)(66556008)(66946007)(52536014)(4326008)(64756008)(71200400001)(6506007)(38070700009)(110136005)(54906003)(9686003)(316002)(26005)(7696005)(83380400001)(38100700002)(86362001)(82960400001)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+SPCNRYl47bOrjB7nN9XVoS8G+7v2wIHbXz7u/oQ6KBP0XNtV9QT7qoj7qg0?=
 =?us-ascii?Q?/e91o+JgQlXpB/CYF0K2/UdlXNcwROhwB2hw1XvsNThsjycesg+vbh2pMlOU?=
 =?us-ascii?Q?lQWwZyI4jEYgMj87ceAJ61ilfIRc+TotPfLgPkRrbLxAx+OF/WYMoOkoLpz0?=
 =?us-ascii?Q?4h0YS1Xsa8VqLtSx+bAeJspAc67GGNVvVbQSLlNhMJwD+v+Cw9BjwkFEuTiq?=
 =?us-ascii?Q?zuXvsK74H6JIWm9DKkkSp5FaM26eQE4wpc/CfQx31QMjjFVAtZINSvbS9Mi6?=
 =?us-ascii?Q?u68wyUnjrTVCk9f3vP9amRDDT1i997LTgPwAiHuDH6UItQEanEF3WypH6zkt?=
 =?us-ascii?Q?cSwkuMrRk7J7NGNaDo/isyrNtCDSZB2IAAUYUq3GHOnJphfeiYrVXoHInjKF?=
 =?us-ascii?Q?pYntbxMPeXvJSyVkCYyIjH0J6ChkeBAzTdThsN8dLcLKt+IzKSI+P4EFcDZw?=
 =?us-ascii?Q?LS5XQUa5hGMGGk1t1sgaezDcKWq743VQfk5QFlTY2LeDHVvlDewHWWICV0Ue?=
 =?us-ascii?Q?qmIQRkUswmQ++6oBWKuK23tFschLk26GpUk+lqLTlRbNCcJoFs4Ffv3K0Vtz?=
 =?us-ascii?Q?TEfgfTa0YmgQ6/NhZw8R/KlrP/Y3N/ZMqjnzwKGe4052WDf4mnTPAPTAc/Lg?=
 =?us-ascii?Q?QOqaG2jg5fZ8i/sRbU+RouCSh8fSV5rl0swUIcoHWi71vccVfnz8ayXqiEN9?=
 =?us-ascii?Q?8UefSOSSZo/dxFkKbZZ0V38K4z3E3jF3+coSxsZoVeIHG+otsEJZ+5/YTEro?=
 =?us-ascii?Q?xGi/Yan6udloHiOKAzpqQ06lpXqeK2PP77i6ybnYahQLvFUQHGIwXKrxOW88?=
 =?us-ascii?Q?IF1dShhWeQIlcrgbHn1Q95bPf9edEpNS8YqjHoYKbmRqq4/7xLmMIo6+XzBo?=
 =?us-ascii?Q?6JZ+OlrmrFt01sCQGdC/639VrbDiSdftU2LwAHbzfiQZzkOaRwdPmEDeoPkb?=
 =?us-ascii?Q?71BqMsDv8ZqKnBjVjtjV9BIJnaaJt8+bp18liZ/kNC1Vz6BNs/TCzy6fR8PP?=
 =?us-ascii?Q?onjz4Jfv7MQ3YxlYc7NXoxxf/5JvvESYgZ6XRYIOnAqpKoydJ9YCh3DIC1KH?=
 =?us-ascii?Q?GZi0ShC+KTyo6z99Dj1jgER/TsdK4lC5kuf59XYP44WDw5iNs6G/oBZs2tYD?=
 =?us-ascii?Q?vm8S9TVgnOzTxEY2J4iqxujqZt0Bj5OmejoOmOaNtNgi33WWuQaTriZYQEAM?=
 =?us-ascii?Q?JMLvPwXBJAM4qoIdbQc9MlNOnbR5G5tL3PbPIuY3vpCKZaupROQbXJZrmnZO?=
 =?us-ascii?Q?qXPB17o+/0InRhE+6F0meQS3Y81WfORbNAhM1V7HmWhqxDqo+k+LHjb30Jv7?=
 =?us-ascii?Q?lXRcoE3u/oMu7fM4QxB8VW1Q6K8XgBSI44USx5TD6vx4m7+4n3eMCIpmgBty?=
 =?us-ascii?Q?l3JnhjNTnARsQdG2fZE4GayAns/QWlyQs/KdsfbbEeiDGQ6/wjN71HJVOivo?=
 =?us-ascii?Q?GdTv3SYYNVWpkdepenno9adT2kHO4cbSKjP1Dv6J5bOgC/xcMFw9fyJr4uoF?=
 =?us-ascii?Q?+YfNLBSb63tB+ZSUEABuvuJoFS4fiLBe252o4PgTXw9P/gFO58/P9TmIGaFJ?=
 =?us-ascii?Q?9ONFWnm22BtkcUUrkJQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1705c7-b962-4533-ef87-08dc2f1fd535
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 18:48:14.7237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/ADXa4WJXEciXrDHH749VNdNQ0B3HJhhLkuXdwWkQfOZBqLFh3YQKy3cnB5YhNa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1694
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: DX6onMJ87whUhqlwVZheLn-eeL-juJxw
X-Proofpoint-GUID: DX6onMJ87whUhqlwVZheLn-eeL-juJxw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_18,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160147

> -----Original Message-----
> From: Stefan Berger <stefanb@linux.ibm.com>
> Sent: Thursday, February 15, 2024 5:14 PM
> Subject: [PATCH v2 06/14] crypto: ecc - Add NIST P521 curve parameters
>=20
> Add the parameters for the NIST P521 curve and define a new curve ID
> for it. Make the curve available in ecc_get_curve.
>=20
..
> diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
..
> +static struct ecc_curve nist_p521 =3D {
> +	.name =3D "nist_521",

Are the name fields in the ecc_curve structures used anywhere or
exposed to userspace?

It'd be nice if the strings for the nist_p192, nist_p256, and nist_p384=20
structures and this new nist_p521 structure included "p" before
the number, better matching all the code and the NIST FIPS 186-4 names:
    .name =3D "nist_p192"
    .name =3D "nist_p256"
    .name =3D "nist_p384"
    .name =3D "nist_p521"



