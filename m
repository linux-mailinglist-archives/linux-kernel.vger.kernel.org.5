Return-Path: <linux-kernel+bounces-109500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D87881A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0481F22D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61E8615A;
	Wed, 20 Mar 2024 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fFS19o0B"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700F21E87E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978497; cv=fail; b=hPAXjTCERnDi0e2DHWu/lAYn83JHYZX0xGg71Mg3Uv4Hq+N6y6YBg+gMHj2tfuRNDABxQl0OFFm87fgtuESBWTWYK8LpfJ18gyssC8G7q8BfIaxYIm/+wClcZSKh59QhQPsf4+ZZ13BJcrCe4N4wFTbM3YPgTM+hTikikbdGaG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978497; c=relaxed/simple;
	bh=An07knpuQhLWo9jorD1VzzyBvlIGyHSFnZMeCzYY5D4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ilMBgYAQVeGTEyV//VeSPwNLTwS74kaCMqTdVuF3g/5Nilc2IAYT1CPtn5vfSm+zNLfLg4Gt489sRzQjFeg5o9SJapcbB8EgD+IZr025/LyMsDhaEFPRC7p/nIgoDH53Fm6yHuV6201g+JJo5MzIdqz6b3O2GkkJl31FiwCo1oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fFS19o0B; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1ZejXvhzOgnEcY6aZmY0a+FEqd1nKZcsAbpBillBp3toJ4RiOd1NsZ8sQChcYB7oeOFe4CLa49xk2nvIR0ZZcker8FfFQ86HNXasbt1e7yGi0TsKw+rf7nnPHdJ+vZCl3wa54jhUEnqibHNkqubOW4aTHzzVCmYJebexqVu6o6rMmaVJJO9VPs5iFtlagASca6pQwv//X3wMnTGyt4575bsizA0JAg2PQIwuKlTEFws1mkZCyc4SHOyy5EbWgk7edUn83UJg9sx/6JNpGKQOiMFHgKUlRQSiNf9ckM5l0yASFN3150U3P2uYLn81BjYhX0Kg5dLbcBAiqZDA1Elmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmE023jZ6AQ2mJQKqyPCeqo8iSfWM987p7XlzstWo+M=;
 b=c7yBE7Z1AgQj+zs8f831ylNHZczcLoGOW0khqCW/ddSdZwjZVfygrfTQmwDtA2kZOTFma66RGuPIX09cdVJzy9Cc4LoK6JL7Iv9LRvwbuJIDx0mjfeIRnCzbPeaCr+RleW0z/v0kumK9ifyda/hPCGAgl4LAwhuE01g8UCurri41AeOI1jh/RiJB77fvxT5aF9S49U2kFuhYvtfGRnmq70z7cT2K2fh6SBdtwABHtts3N80tOWofxgvysoXvwXgWHjIgURgFwmcki2bb4pZbg+0OI7wEZDKIbmgAaks51hJ67nmzlItMFDsLMUqxdTXo0By/LZn+qV6NTdFl9fHSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmE023jZ6AQ2mJQKqyPCeqo8iSfWM987p7XlzstWo+M=;
 b=fFS19o0BO21+YwBIN6kH7GUyj7PrEwBBpxsAWdWoS7iQKhUcSQZuOju5yypQre8a68deIr4E6tFTPL9nWDTFLWrsEmaidarLGKucfl7fDwCQMiAd3CAKqjiMrK9cMxz6NjvuMKJlcIzfIVQ9yYy1op3QdHE0iJH9n6GHzu44THU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Wed, 20 Mar
 2024 23:48:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Wed, 20 Mar 2024
 23:48:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: arm_scmi: perf: print domain name in error path
Thread-Topic: [PATCH] firmware: arm_scmi: perf: print domain name in error
 path
Thread-Index: AQHaepj/UtQxFk7FJUGAZ3VErje6VrFAf8AAgADMPBA=
Date: Wed, 20 Mar 2024 23:48:12 +0000
Message-ID:
 <DU0PR04MB9417FF940DD107DA4159E9F388332@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240320074213.1615888-1-peng.fan@oss.nxp.com>
 <ZfrJnEpzfQ-AsU9q@bogus>
In-Reply-To: <ZfrJnEpzfQ-AsU9q@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB7794:EE_
x-ms-office365-filtering-correlation-id: 3aa714db-55ad-471a-9ffb-08dc49383446
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lhFCJn82W4U8KpLOSSVYuusuadls4XgAkNmsYzhv5Rn79EzaoEy+zxmYQhMjoltN30ajWvY83UU6mxuwq9BEl2mltuZXk5jVv2OYoEX0od2BrOFYnGMkrL1NldeV88Casgx8QR3Em0PUgczsQrFJnLVhwk2HFIQjKZPccTSEg8VQHNlbi8DUL76lVtWyG+YskBqJrlSOmtvza3Mp1K0xpeCpczj8Xq0BdY48GCsvPXdYdtjnC9NvXln8rRA7oBI+TIy6o+78q8epkTn/Vl91gfkCScpw2nhtuC9wk+lp26+IihEhx5ewIseuK95Pyl7YQOz0RqN86PnXBT+rMVJSo2TODO0hb7XZz8GKoQxDDRpynoYdDGTwWy+y/HWZUxRwpAUTM4aAMv0z4IfiHvS+h1mXsqkDJ6Zd6MJeaDYimSDnjqv/YEJCuvSI3nicDLQUvwSY7vfI7LAJrWnziCShyLfVzLbT75DyN+LCjxR7sIbRiMS4tTahjT8WKuLMjtxJ/fKHVtBPrBJ8OkWdptETyMhrkZLP0O8Hxs+Ipe0aK+NEIDC9MnewEGtnErfhIn7lCVU6LXjAKw7sm47VH1v7viYeQlOGeKm56IiBrxtN5FefP+IbNkD2usQx3/4ww7c1qsItNgwTfWp7VXLrn7nSbHAOJt/I5mp5CyZiQcAofHCJZEQi2vVeXOEW/k+4b8zws1w/bfzdPe5K31JnmdklEdrt9IWMmmzn3BsuR3n1LZM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9lZU+hK3bguPQj3Qgzn6JTLh/20f7PKjmmERgTFd9KWXPYBoAh3vSmmB84ER?=
 =?us-ascii?Q?1Hs4/udkMR7yiDV3QVVRBv6PyjrYgeilVJd2zWsK7/8FdAljpDUkEk4bQzTP?=
 =?us-ascii?Q?jZ6p570FyW+uW5AglSmJQsIHFCQRNRtNZMSiOq8fIx9y4HY4I7a4H46+Zb3W?=
 =?us-ascii?Q?smwOAsk/mmnOykzuFzcBTcLwdGI+rjP/1n9LdF4Etd09j8xXexUF2JkEB2sh?=
 =?us-ascii?Q?/hBaWz9HeThhFZ3zgZ1B3rV1hdS7J3Zqu2AGOMbMJO0gePmeXv5lmc3HZ8EM?=
 =?us-ascii?Q?3g9R00XdLXbCl3IDiBhq3rxVwj5y45oMBLDglFOA+Efym+lfuUaCc/TZcYo+?=
 =?us-ascii?Q?ti35DC8638KFE95yTJLHynP5qndQQQoA8RT3Oe4zAjrq92ylh1g2V8ewLFPc?=
 =?us-ascii?Q?rTBqXYzzTdByGmeJvfTr640Occo/+uXN58o5BM870GHfwEijKMMbxTDRuM7n?=
 =?us-ascii?Q?4feqe7FDmwcObIm3jZfw5tiJI4Aoz+JERjNJVhIq1aEgBUjfC7VCHpDUEH5x?=
 =?us-ascii?Q?1czZ6mYJlgHHEHZh9o51GEGmdnObOZSpUN/r6Og/JqkIIGDxrCui9cVb1oka?=
 =?us-ascii?Q?ZqyP2CJOED+FQtQ18pOPVTJuwBrEygQF2Icmsn96zOyOCYrEK04SX7h1afYd?=
 =?us-ascii?Q?/tZOhzy+qPQC2cPpPq3VFMbsH2JYHlDOdH4aywBCLQsn9bBdRS2S+SGiFcin?=
 =?us-ascii?Q?rU6edgCXBLDqtgMe7xX/O1N93VrGrxDtA2uzBAAhIAxa5brdPKnGP+mxD5yv?=
 =?us-ascii?Q?FrPWSn9B5H0s7jMBBOg6+JVd13vbXgQH9mfi8Y89Vj7E8Y+sjpI9IRPxN1I2?=
 =?us-ascii?Q?Frks0t7FMlgUG2pJM8zJcTgxjODGOMDt4s8DgymIIBteoKMYJA3IHoPRrX80?=
 =?us-ascii?Q?5aBG6NQ3SSt3guKD/1+2v/nRPs07gvWjXVZRtytFOuwzHd2A+ch6IhyqTZgk?=
 =?us-ascii?Q?vAIYDxV93u6uKHGMHZVvc2QhMZepCoN3ekFhh0ofmDvmKs4H4M/DJ+qnrdIN?=
 =?us-ascii?Q?/rq53LnfGSQyIFyZ0Q/zK/VsjxLYGgjS8rOA+EcpFYW0gtVeQTwtsMiR/sQ/?=
 =?us-ascii?Q?QPtUXaidgE4cR/4dRa8FnN3ADmFqTd7YbwRm5Avu1uX0zsBxfQqRWyU69kif?=
 =?us-ascii?Q?ITs7+zfhWBNht+JGeWsDeJM12cI/2pjzy9DUvdihPUGfVreLpIxOorX4IjpT?=
 =?us-ascii?Q?avpVwH/o0POkuQKW4UqTilYuiuRmG7oKqz3dUK+gBWE46WHPLavvZblfEsmI?=
 =?us-ascii?Q?JEL4VDdczMLdBSHeflcEgXa6nIVUJQUzsLKHCaqi5Y6jGLAYOM4ifSyLK8+j?=
 =?us-ascii?Q?HsW2/LT6ge41mSBfHLplFu1jzyF7YqXjtqyrnU0vgOYa1q1QiOtYCQ9bU+3y?=
 =?us-ascii?Q?LYbid3l6fRHLgNYvnVzTm/+7ZsXrvzIjaIy+W1rlMx76kSGmlEFW5PLpgtUH?=
 =?us-ascii?Q?1PbhcnfBJ1HD75sa5HDwjCMgIp2XjUpFVNkPN2DuHim4PWH5FuCA/mYRAvc5?=
 =?us-ascii?Q?WwRIrSBtSrVy3Az51aFc5+zdIHcUsygCTQwxiLjyu7vruFXgCZBKVY6aCZRo?=
 =?us-ascii?Q?ml5afkf32nZepG4ECb8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa714db-55ad-471a-9ffb-08dc49383446
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 23:48:12.3194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dSM9CtHyWjCsNm1910JZD/e1Wqd8AwQKlb513BZTZVWI1U4M9EksZJHjwArMd7LZeYYYqEl6KbJJpZFESeAXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794

> Subject: Re: [PATCH] firmware: arm_scmi: perf: print domain name in error
> path
>=20
> On Wed, Mar 20, 2024 at 03:42:13PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > It would be easier to locate the problem if domain name is printed out.
> > And including a coding style update.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/arm_scmi/perf.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/perf.c
> > b/drivers/firmware/arm_scmi/perf.c
> > index 345fff167b52..e98ca6d15b0c 100644
> > --- a/drivers/firmware/arm_scmi/perf.c
> > +++ b/drivers/firmware/arm_scmi/perf.c
> > @@ -79,7 +79,7 @@ struct scmi_msg_resp_perf_domain_attributes {
> >  	__le32 rate_limit_us;
> >  	__le32 sustained_freq_khz;
> >  	__le32 sustained_perf_level;
> > -	    u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> > +	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
>=20
> Spurious change ?

I just think this is a coding style cleanup, I could drop it in v2.

>=20
> >  };
> >
> >  struct scmi_msg_perf_describe_levels { @@ -387,8 +387,8 @@
> > process_response_opp(struct device *dev, struct perf_dom_info *dom,
> >
> >  	ret =3D xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
> >  	if (ret)
> > -		dev_warn(dev, "Failed to add opps_by_lvl at %d - ret:%d\n",
> > -			 opp->perf, ret);
> > +		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s-
> ret:%d\n",
> > +			 opp->perf, dom->info.name, ret);
> >  }
> >
> >  static inline void
> > @@ -405,8 +405,8 @@ process_response_opp_v4(struct device *dev,
> struct
> > perf_dom_info *dom,
> >
> >  	ret =3D xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
> >  	if (ret)
> > -		dev_warn(dev, "Failed to add opps_by_lvl at %d - ret:%d\n",
> > -			 opp->perf, ret);
> > +		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s -
> ret:%d\n",
> > +			 opp->perf, dom->info.name, ret);
> >
>=20
> Are you really hitting these issues ?=20

Yes. two levels had same freq on i.MX95, but we fixed.

Or is it just code
> observation/improvements ?
>=20
> It looks good otherwise. You can also add the below change when you respi=
n.

ok, will include in v2.

Thanks,
Peng.
>=20
> --
> Regards,
> Sudeep
>=20
> diff --git i/drivers/firmware/arm_scmi/perf.c
> w/drivers/firmware/arm_scmi/perf.c
> index 211e8e0aef2c..ef1c27a65552 100644
> --- i/drivers/firmware/arm_scmi/perf.c
> +++ w/drivers/firmware/arm_scmi/perf.c
> @@ -830,7 +830,8 @@ static int scmi_dvfs_device_opps_add(const struct
> scmi_protocol_handle *ph,
>=20
>                 ret =3D dev_pm_opp_add_dynamic(dev, &data);
>                 if (ret) {
> -                       dev_warn(dev, "failed to add opp %luHz\n", freq);
> +                       dev_warn(dev, "[%d][%s]: Failed to add OPP[%d] %l=
u\n",
> +                                domain, dom->info.name, idx, freq);
>                         dev_pm_opp_remove_all_dynamic(dev);
>                         return ret;
>                 }

