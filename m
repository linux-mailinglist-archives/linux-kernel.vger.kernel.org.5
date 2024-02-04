Return-Path: <linux-kernel+bounces-51754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA4A848EF1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA531C20FFA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572782260C;
	Sun,  4 Feb 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b="ghs0d3QJ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2136.outbound.protection.outlook.com [40.107.22.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B96225CE;
	Sun,  4 Feb 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707060815; cv=fail; b=D7ptDk2USrjfo0qNGjuEGpRHmxr9tIqcfVyIV+MCkW1YB1TXQr1RZeFP4h0ZPmQ36GKbfu1Q5GG0mtaj/hKdD5+jgPVKl9rv+LQWHnH3LVLzKI7QiZhNPk4TkShEdmxYfGnblhsik32KFROXXc7mfohm05nmQa3u9MYUVUSml6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707060815; c=relaxed/simple;
	bh=l1X1LSGMJT19aRgn5SEgsFRVTpihyF+WbaEIJOnGvJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p51JpgMF4U2H0UYe41jo0echvh/9SWBMXCCyft6JlAy48+aq6sKFwaYkGvIFMsunwFV9wkJfb7pdDbnaLdqrGjwI7CaMTjYt1fm2vUpo2jN0caUyY7Zir1Zt3KkyTgyjf+vU6BLQ/2zuGZnE7xyFEg6K5dTeuCX/l/hlBtHIMmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au; spf=pass smtp.mailfrom=dektech.com.au; dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b=ghs0d3QJ; arc=fail smtp.client-ip=40.107.22.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dektech.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+JG3TfbQmbc+j94pMes60wS+VC2M5nelaWx5RLL3tisRZkn2f0yG8vmfdLsgkZCMThpHaDNESJhBiAF/oWL2E1nYC6iTmHvT+ibAflYklV6zTm5BQxJFhLDW+YjTVKooNloCzi80/Eq7MeI9mGV+JgrIziEaf+Zn5zrVDRo6zFfH9gbXBHxXl7NULBzCJwjMK4kJZkhE5gbttteplNb0mghmSAF2u6W1KpWDOEcp/s8U1VDM0RTKe/sjATNqhcVMawevfNy7mOlVjGYVWlIIwTs6zzc1s4d0OQhXM/kGuYr8cyoBPlz95zY8EQ+bAInDyqkbwLqySs5noOMOC8dMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs8AbcN8Y999L6IWKFpdodDtjRgEw5YWrAjcYveurhA=;
 b=ETCXpNpeFizo4+cqj0aCGYgyE7rKlODvnIG8XHim2cQOca5s+dleT6UcA7wTpevvWQVIzbWSd5AP9c8Or9fosQvxMYhujEocBPlTmCwplSLDOY9yIuOW5SB+2ws8O0a2p1Or6eWXLwXz1Xtx1nwNQHDCa6vQ1Dxr0jwWttW3nYTSy/rsHz7xm344ovN6HgWTUePJZhb7Im2Q6Ua5ddmL8XTmVE+nN2C+IVmenWqkNHftkq8eKwbAt5A+zwja35Y/AiL6WXZCa/BMW5X6eVD/K9rOEeiMbad+y/KfC+IJSDFz1DrafCMEvMTBCgkCnJJ56i5P0h316BXFjrSuURILfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs8AbcN8Y999L6IWKFpdodDtjRgEw5YWrAjcYveurhA=;
 b=ghs0d3QJ9gpeh25Uu/PRXaVSAqtxmoGakXtPH9TL+q81Db8dFNLWJKM5RewNPKF3apw8BuLrPLI+Il0rTKVft2+bPomC8oMxvFBVGL9m9M78+6uTdqwQZksVi0cEzmL8IiIoW5MXlavWzIBrTS6y+xTbb+VM69CjmYbLav6aY96vB4KrualfdDlRN8CZEHaT6/9FCAs5qwrBgXBtMsXQrQSdTWxldMCYD2vcWmTnYb1kpK0CrCryGb3CPd7lvKrGERD/DZU8PUnA69hZQk0vrUzAp6IqhKtFQ749G7ucbTK5Z/ERbTIVNwnGYgxBXicmGltBNr1a4JlwLle5OBpv2g==
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com (2603:10a6:20b:4ce::15)
 by PR3PR05MB7420.eurprd05.prod.outlook.com (2603:10a6:102:86::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 15:33:23 +0000
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::209f:43fa:8733:2ca1]) by AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::209f:43fa:8733:2ca1%3]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 15:33:23 +0000
From: Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To: Shigeru Yoshida <syoshida@redhat.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "ying.xue@windriver.com" <ying.xue@windriver.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com"
	<syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com>
Subject: RE: [PATCH net] tipc: Check the bearer type before calling
 tipc_udp_nl_bearer_add()
Thread-Topic: [PATCH net] tipc: Check the bearer type before calling
 tipc_udp_nl_bearer_add()
Thread-Index: AQHaVFsHrUFOvi8Y2kmtLPKN7DXgErD6VdXQ
Date: Sun, 4 Feb 2024 15:33:23 +0000
Message-ID:
 <AS4PR05MB96479C038FC4E27E85435FE888402@AS4PR05MB9647.eurprd05.prod.outlook.com>
References: <20240131152310.4089541-1-syoshida@redhat.com>
In-Reply-To: <20240131152310.4089541-1-syoshida@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR05MB9647:EE_|PR3PR05MB7420:EE_
x-ms-office365-filtering-correlation-id: 9308d6ee-10f1-4754-187f-08dc25969f97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KA1PjR0gnVsRmeMocQmfgnmmZBoBwR5iGxIaZZEst5vdTq9H2IZFeQq7tDBdy78MKNltEG+fi8UuznRdbW8W3LJSmksSeqQxNbeWsLwSReurMk1aNTIgUQdHvs3ukmieyfwSM/2CvY+Q0WjHLc3wAT3jBl5buHj3P54CfN4yFpAgAo9zMcyHZ0PX9cWfannx3AvRaRO9KhhMIy0y5PkIAvhziZmXPzhGB42AvARNMIlKoWDp2pMLTyp7ozcBf1X3c3qcOIMXmBSStmMJK5jdC+HF1oDKqyL+rP/orR+aYq5/wNUOm4XjcQmInBBCLvMAmAvWs3vrZ4VcLoX6cJWVmbnnzq19Gm2qh8lE5A7v2pZ/f5yRVpsm8fpBns6hPGcsORbCGwtZ8gb0xX+47Z9z3sr1AHPm/cWmRPiRbc0PjSHN8PsKSMKDLax1YnODKlqy+mk+YYb1fusg7IBJIxnCp9HwTw4bUvP5v7UXELwwhPJ32+ajgn6a/nyqwR5Q8cJzt2kSPgCoxSO/Nmtb4ol/swGHimp65TnS5hUjRuSdZUbWsOtozccQzXrFPNwX0VIyJwIiBmE0mzoR0EuLuPr/Ys9jmidr61NegHVuPk2z9TTAdJCJJC0zjcHvv+C0Xqdp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR05MB9647.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(396003)(136003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(83380400001)(41300700001)(38100700002)(5660300002)(110136005)(8936002)(54906003)(64756008)(8676002)(2906002)(66476007)(66946007)(316002)(7416002)(4326008)(7696005)(4744005)(66446008)(52536014)(122000001)(76116006)(66556008)(71200400001)(6506007)(86362001)(478600001)(9686003)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?a7ezP/kZWy537z059fg3LvESqZIV29yVdEdFlT3or9yYTMIi2BZvGVf7fnLe?=
 =?us-ascii?Q?dANACefQw6Ftl9oZmXXe5RdIk8qnMIWsWnW6mW9WrbDpDwlSHmMtnKUM8xrv?=
 =?us-ascii?Q?KYadYgNkenYjSedyRa+5fpVuGW1hRJO78X573iTdLgRaU/NgsPJthTow014P?=
 =?us-ascii?Q?xCFLwdXNv0E/nG29pUAgwETLLpt/m7XDdzjwOBshGQCgwVQDZNl0W27Ul4pY?=
 =?us-ascii?Q?tBgaG4CCt/nTeaAIJEgtySRuuxCmSssvMGsHiPSc0HfTpTkHL9UxymJEDS40?=
 =?us-ascii?Q?ce+MrHSuxOsQ/Z153NysqtCnJWYAXIwsEOUnUSpGawjyZUPpV5OLcwaSf82r?=
 =?us-ascii?Q?7g/TomVR5VLQG8YUlnplueW1WtkQaYXS0UkMQjis7N0dmbzpLaUgRWgS2WUa?=
 =?us-ascii?Q?7HK37sXATIvMCRGCa5kouHxXT2xTBoK+JecLZEdyYhZMux5ithTZQXHij2cD?=
 =?us-ascii?Q?wB9ZooUEtsrHPRSXk4iWPdloaTJaOIw15RFzskhqXPptIpaYWVfNMpxhCfxr?=
 =?us-ascii?Q?Ic3789rkh6FvBOd/+d13cmxQikHNLElwulHRCTztz30qD2cds7T3QYFPnXV1?=
 =?us-ascii?Q?M/SA/wwBEQHM8TUGFtYenwXqW7J9TjfMSOkY/QR5EJxl9lU+J79VeWQLhywW?=
 =?us-ascii?Q?Is8vLbt/OIEi5KjZLBMJw+pI8EDWOtd6HeAGS2TYinkPxOLL8bC5aecM2pGf?=
 =?us-ascii?Q?r8vGM56bIEAgkInsb3k7X5yinsTPayItckQYA1W+td/yYDP2svID0rvmytFW?=
 =?us-ascii?Q?s0HIpSX8aT1BE3uPVCG5I5ztlLnV8zmXF2lO+YOjPB0bya4h3gVeEMyq1/z/?=
 =?us-ascii?Q?CmmjGKj9/6aBSGT3cZXYbxd1h6yk/MNgrnK/DneNypImuCQwBvVAWhYlaMrh?=
 =?us-ascii?Q?eHgAwUzrkDVpDAIM2y5vsxKld3T2Rjtv3m6bavatl390/k817j+PKCc5Nagl?=
 =?us-ascii?Q?19AaZjtQrpr9Ta+SLrLe/6CV3C9ZV5HEeOOYEsAa5qPg9UAe24nxHGyBWQ93?=
 =?us-ascii?Q?bX5mkjs01Vmi2JULFYph74A6KBCoPmpl9gH8HFCOsh0qnJVvbdyTEpCNc4Fr?=
 =?us-ascii?Q?No+ranGubBlFnmejXJad4QKxGG/NgNSCvpjEGkDzj990SmdNa2H1yCkLxW0x?=
 =?us-ascii?Q?sX9UZ3D5qW/saguJBlcI6/7T9XNIriMnXgUdNAj9JbEBbe+plv/7Msr/9S7B?=
 =?us-ascii?Q?GA5sPV4NwOvc0VmcYl94+uY08Meluzts3pBSPwdu1YN9vuJCzzwtoqCSeQd/?=
 =?us-ascii?Q?7LqB5U9+9ZzkGPLCSg0d/I6FdGWkqhc+SA8KAxSVdTOK4geJ0/gIF4/K7qfW?=
 =?us-ascii?Q?K5FXaRHz01TPDLZ3C61yOhYeTIKd/BBaBpvH7O7HWkdW+Zhzezdk5ZIDlkY7?=
 =?us-ascii?Q?4ciQFZ86qbT00y0bwEwoVNSffdpeReOIFm9F6FBXxbm5ZgBOPtt2ZM4deJcj?=
 =?us-ascii?Q?Bw6dyqVCUDfdxicDZ2CFNwWud2xh5h8vTiC8RY14kOwIMigi34qfDhRdWGJl?=
 =?us-ascii?Q?v9VAczQYRL7V8hRV4h32+sPtEBnjvJfRDo8xI3Gevb1PPUqn1otHiDhbu/C7?=
 =?us-ascii?Q?H2YYpT88TBV+s6I0Xv+KLNuXSCXJfV7ZllIdUybv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9308d6ee-10f1-4754-187f-08dc25969f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 15:33:23.2010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yO1Kh8RIEMxnZMfh6wGm9D59m7Hvx4PA3Zlwk4jg7W/wWc1obztDh6hTdZawF/wg7ClvuCe1PDualSDkWm58s7E1QYOYbyy+U8lLkZol7RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR05MB7420

> net/tipc/bearer.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c index 2cde375477e3..878=
415c43527 100644
>--- a/net/tipc/bearer.c
>+++ b/net/tipc/bearer.c
>@@ -1086,6 +1086,12 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct =
genl_info *info)
>
> #ifdef CONFIG_TIPC_MEDIA_UDP
> 	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
>+		if (b->media->type_id !=3D TIPC_MEDIA_TYPE_UDP) {
>+			rtnl_unlock();
>+			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
>+			return -EINVAL;
>+		}
>+
> 		err =3D tipc_udp_nl_bearer_add(b,
> 					     attrs[TIPC_NLA_BEARER_UDP_OPTS]);
> 		if (err) {
>--
>2.41.0
>
Reviewed-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>

