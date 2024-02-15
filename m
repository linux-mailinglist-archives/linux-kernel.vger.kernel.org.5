Return-Path: <linux-kernel+bounces-66214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA161855892
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE5F1C268B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59311362;
	Thu, 15 Feb 2024 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b="accLHJkK"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2137.outbound.protection.outlook.com [40.107.8.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB60EC7;
	Thu, 15 Feb 2024 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959204; cv=fail; b=YXYlW5dwmpaOGqsAwyDUjFCnwCEaasdqPDZlNG8L/F9vmw+YiJ9i0+TMB+TzWz48wt6VDIkI9uRY68cSEg15nEFnGzQ9uqi+KHW/shgk04Ia62xPyyHKjvQlYhtpMVwQCZZQKNALvLmm9zlY8tzNwOP3ZQ1QHGnvxMV4q4L3xbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959204; c=relaxed/simple;
	bh=Uzz634dKhPE5IycGJuN2bsG6Io7kk29DqUEu7DC6c3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHSmeH1ng2Cw21WPgA1I6EU+Iorwo6tpdZo7tRiei1OS3nQ21Dk5j3SNgsqV+AZ7HpP65/4TwFCJOyTYTqY6c/ELhAvQEqp4SaXejA7xZ5EzNb0q/vescaVhExUNTRmEyRr7yUWN0siRk38bFVsZRsJ5f4ChYEUlo0nTn7NJw7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au; spf=pass smtp.mailfrom=dektech.com.au; dkim=pass (2048-bit key) header.d=dektech.com.au header.i=@dektech.com.au header.b=accLHJkK; arc=fail smtp.client-ip=40.107.8.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dektech.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dektech.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyDhp4W8/iTjdU0/FdqvoFN4XBMUuumppHu4qcCmUQS89V+K8cbnfRXGjyPqSZLBn2wzsHOuzAURIwMPxGOEFx0cGSt3E4n/HXupZ+Upa4aX6XfDo9BFW1XVUds1P5cuc2Y2MNnd0PP0n42jzgs5viEAVmVftAnXClm/KaFFr0KD8aKSahx1F5eAQeZbZXAHV05dwRlu7fm2BwYFNyOkTRz5kQiNvGxxEFrm8t7X4ncNATcIJm/6rS+jvebVaNONOvThfmdcEVNekk7FVuMg4QqJYA9cf4gV07yWcbxKnJATWY0cCyyKFiBfmymJ3Tejlz9YJ61ImCOR/LRQchtYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu5Ik4vAHHPq+rEBGySEW7pelDfJSopjMYMpmEBhgl8=;
 b=aGGAovaPKtjJAOqm7jsRfGGrwjeR9XoIOU0bCv13W4J8WHi5eE7FLUawVXXD2ZRr1dSJ8bp6VHRZb9uJ3vwkgmFrrtgnQMErEOHwEXkYw8v16EcK8ew+RdS5y5gclHOsuQJDTjn05KvveijN0eN8HoW5UM/nCa7FjirXQuMyUB4SNrbR//y2h2n/SBeUsbOlEzqoNj1Ro2scpAz5U20r0RWT+lG+1kwttSwY4X/OOaQlBFGMV6gS3uDkvSr996W8N9Syaj/l4KJRAu1lKbZL4ONld9rVzc8GbbEN4BF/RdXvxOI7QKH8KqvKbgehwTrdWWEPLZ+9woTtdsjmPdKedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu5Ik4vAHHPq+rEBGySEW7pelDfJSopjMYMpmEBhgl8=;
 b=accLHJkKjqXPvtswkPLtGmuere/6W1LdmGsaOf0w/bgVmczN6X5nsK3qfRGT1Hj+BLHdCB0zfDpguDo/yPG2stY3nNoDT9Z0yqZd9sC8YOglklkxzdc+FjbhlzPqDbbfczaNyJBsVtv6TSU7oekU292lZT7luY16jN9gRcBEOlWLUyOKqOBFfXLVy3Mdva2BYVtHNOFsbcnBcpZuArDTZbBBwk0CZ35sfVF0UKugmCjeNyTwHO1doBk+ehzPsfvJu8cplz9nd5gGa2L5uCnfetPv2u/xOWY5VNAiBQW+ZMqtLKA5T+sV48i3uqnFMKklE9Xq8p/d3yAhSNxmX2xujg==
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com (2603:10a6:20b:4ce::15)
 by AM8PR05MB7954.eurprd05.prod.outlook.com (2603:10a6:20b:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 01:06:37 +0000
Received: from AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::209f:43fa:8733:2ca1]) by AS4PR05MB9647.eurprd05.prod.outlook.com
 ([fe80::209f:43fa:8733:2ca1%3]) with mapi id 15.20.7270.033; Thu, 15 Feb 2024
 01:06:36 +0000
From: Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To: Shigeru Yoshida <syoshida@redhat.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "ying.xue@windriver.com" <ying.xue@windriver.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] tipc: Cleanup tipc_nl_bearer_add() error paths
Thread-Topic: [PATCH net-next] tipc: Cleanup tipc_nl_bearer_add() error paths
Thread-Index: AQHaXoJYuooXGYlzkUWhIpDu7rfqUrEKmPMg
Date: Thu, 15 Feb 2024 01:06:36 +0000
Message-ID:
 <AS4PR05MB96474C1DE6EF37FE501AD72D884D2@AS4PR05MB9647.eurprd05.prod.outlook.com>
References: <20240213134058.386123-1-syoshida@redhat.com>
In-Reply-To: <20240213134058.386123-1-syoshida@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR05MB9647:EE_|AM8PR05MB7954:EE_
x-ms-office365-filtering-correlation-id: adb702e1-6085-4ab4-1cbc-08dc2dc25be7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eW9KoIwxU8ZZSf1kb8zksljrMDtggC2jD6JUuzPf1nLxQjNTlLPLVmTFNa/Zz6C7wIkTWcVcDdD0HMwR75CUvN7dzx/9aRyD0qQrqhqycXUBOaMtIe5vvZ8MoX6ZDtQsImtfvB5SDwy0U2qBA6dTzyqPp9NbPK46LoYJLmUEdEA75nJhR6UOYn39aMRGTEAlMt52U6lFhDKxE6r8RHv16M923ToSJ4yOY7K74avxH44wQUJBnZ5qMlv0AClKGsk6mYMAxrFhMxOEhwlpAlSUSdgYonrAtQontK0XT6xowFaRNRHV55IcDVmgVe/PuMVF37KJgpLJL6UCnYbvW1IbGsIB1xOvHI48lOSnwHyiJ7IeCq3EsoYNnzBFeHVIYUG3ECwqG8w3knzs0gId9eonQgbFVGX8KOzE/Qeq686WLMp3006WYyIVts50WA0ZRzHfj8U51e1O4CwS3ju8S3QYHNlT5XUaXNeNzT8BeAdR6YHpV0n3zGrVSNYVvuU4v7V9k+8fqbd5D6cAga2BdkfxFuDQARi2klTARYXSB6JVaDhMGbIEmzyZx2ZpOu/32AocMVvd3vwAu9V/kLMXXEnk+KBxXrvusbkzzsqiQVrakL7xa3aWT1hAuCLRCvDz2Vy/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR05MB9647.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39840400004)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(33656002)(86362001)(55016003)(2906002)(7416002)(76116006)(66476007)(66446008)(64756008)(71200400001)(5660300002)(52536014)(66556008)(4326008)(8676002)(38100700002)(83380400001)(66946007)(122000001)(8936002)(38070700009)(478600001)(6506007)(110136005)(316002)(54906003)(26005)(7696005)(9686003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?thuv+Ffw4UkcaWI8Pfy496+Cb1IZ/S2TsjEHF+ZQoZ55nAqBWmOJH9AIBPa6?=
 =?us-ascii?Q?Vgox4vY9T2iYNMgYorntbsTLbOI027aDT9sSsH88sQb93OYzGEtf8zVcxOGi?=
 =?us-ascii?Q?aMyaxUwLEhHRP9MPb3DzzPFq/Duk4+zWMGlmMfGuv7Qx16FGfSkjM+rv37mO?=
 =?us-ascii?Q?oKNS4Od1vznh2oz0NSZKrKNMf5CfVYVtQfcHn4t8pD3sy94BB06ZM428PCAF?=
 =?us-ascii?Q?efEDzwmMVOBPg1j/CpirrZGHtkW18h4yjxfjhDh5wSboQg0D0kdDBeBOB4zV?=
 =?us-ascii?Q?Z5jhIwhKNh/O80X3d7Cmzqs7Pv2DfIbDKXQk4z3hFmxTZq3q62Jcl8H5my4B?=
 =?us-ascii?Q?N63me4EC/9MiZUWwQyS2lDmA0eQXXlZfS4eHk472Nt7WIGP3xprPQfO66Wad?=
 =?us-ascii?Q?6AX2OYVne6RJtomEhLaMpEulwskLsfst0CCPJi5itYY4G9TlOLCNxECv7DGk?=
 =?us-ascii?Q?ECIHk75mZ51rgvq8Ig5qRDkOTMzVtSr0Sk4nmVzIwrIPo4EBjhoodtxjTYn3?=
 =?us-ascii?Q?049xGWzjUfPwCGWrw/9GCt50ctm4A+tkf0NTAkU8bMXdoy2m1N+gcWHR4pKh?=
 =?us-ascii?Q?rGfdPMwNsAFUbyePGkmvh/AZM0BAl8uf/yJGQfAG3aIccuArkSToR/DZbI2C?=
 =?us-ascii?Q?M7PePocnqLsKmBPNGo91kRZYC6Je6/lT0qxSaxIr9sL2216D13AdI+ufZMWG?=
 =?us-ascii?Q?g4d5s8gJlygfqBXwMCLybvxKlWBKFTpRU65qcPcfULmbPer9DSkqoEsLapz0?=
 =?us-ascii?Q?mmCFLl1xbGUnIYpXsEZ31lLEPCZflPQ1fq7opHzqYGDDcCmGvMK+7QT41GB3?=
 =?us-ascii?Q?y6U3dMFpkyF12aAeCbSNB4bpysCYfdghrM+4q0eTuWJDWV3J611eh+e3cJiw?=
 =?us-ascii?Q?tzOLfor2drsDqpY+3fMWgl6y8GrbDzGLeSYVNG9OyKfNJfeK4JVP4PMzOEpx?=
 =?us-ascii?Q?96DZGjoWjaK8kKamvNVpeyK0d7f5xg0BU+GJt8p3inly5GsvlgPrw9bIflzw?=
 =?us-ascii?Q?Q0F7NMsAEB4MQrqAOrsHojWpoJXACdxKNaujt7t0cq4UIgdnIW3TKOhr5xEa?=
 =?us-ascii?Q?2U/lL82p4blhHFI5f8X1/v2+ULqdlZLcwuvb0lfz7245B5pXxFkROEr5Zmrx?=
 =?us-ascii?Q?CMV7VX1KC99C9m6BNii0PLLPg9AjeFJphjn7MNGsUu6J8AZ9jWAAk0oKRXrG?=
 =?us-ascii?Q?vw/8g+n0cfNM6fsEnlDg8ccRNd8zNJ60etFnEqqfTappukSlYeyBHarR8fx9?=
 =?us-ascii?Q?rQ0fv/JOmGB0ldQB+yripdX0fwpuaWLeS4wNk42tWWzg6APHHUc/V24XbH51?=
 =?us-ascii?Q?ff5hTVzt5WtMdNpq7MFrKyTHPR1mcY/Xl9r0jIeDkt+emu7yiXI15neZAS2+?=
 =?us-ascii?Q?PWKMBFkTpokdyPlEufcXnVVRQqkD6OSOca0wEmCGWZx2cIPioV7U/DT2IokW?=
 =?us-ascii?Q?x78shiM2STczCFvvThlYI2a1h8wlMPJ7pxfS6B/azpbnqTwxCh+Kr5GBZcdd?=
 =?us-ascii?Q?aMMefwVjGJD0Vl+r5QxmJPb+/qCrmA2gAOZVp5+E1Cftj2Be7HGHOxnjLDgp?=
 =?us-ascii?Q?VWgqHvDAlBYePF002Ay3J+Hx6qePU+lG3yZ/Rost?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: adb702e1-6085-4ab4-1cbc-08dc2dc25be7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 01:06:36.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgTTKbPcNxhfP8+k1BGvjF6kfvCSFTJgL2fbFRfzyxpbpja9nmPCsM5PftQJqfigRpCAq1qvj7fHCoY6HcbevhR8vCXDZJb0vAdj5BFUyCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7954

> net/tipc/bearer.c | 15 ++++++---------
> 1 file changed, 6 insertions(+), 9 deletions(-)
>
>diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c index 878415c43527..5a5=
26ebafeb4 100644
>--- a/net/tipc/bearer.c
>+++ b/net/tipc/bearer.c
>@@ -1079,30 +1079,27 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct=
 genl_info *info)
> 	rtnl_lock();
> 	b =3D tipc_bearer_find(net, name);
> 	if (!b) {
>-		rtnl_unlock();
> 		NL_SET_ERR_MSG(info->extack, "Bearer not found");
>-		return -EINVAL;
>+		err =3D -EINVAL;
>+		goto out;
> 	}
>
> #ifdef CONFIG_TIPC_MEDIA_UDP
> 	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
> 		if (b->media->type_id !=3D TIPC_MEDIA_TYPE_UDP) {
>-			rtnl_unlock();
> 			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
>-			return -EINVAL;
>+			err =3D -EINVAL;
>+			goto out;
> 		}
>
> 		err =3D tipc_udp_nl_bearer_add(b,
> 					     attrs[TIPC_NLA_BEARER_UDP_OPTS]);
>-		if (err) {
>-			rtnl_unlock();
>-			return err;
>-		}
> 	}
> #endif
>+out:
> 	rtnl_unlock();
>
>-	return 0;
>+	return err;
> }
>
> int __tipc_nl_bearer_set(struct sk_buff *skb, struct genl_info *info)
>--
>2.43.0
>
Reviewed-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>

