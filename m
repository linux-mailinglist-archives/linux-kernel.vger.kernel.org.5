Return-Path: <linux-kernel+bounces-43122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764CF840BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05C8B211B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E324415698B;
	Mon, 29 Jan 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VPoU6nX4"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8694C15699F;
	Mon, 29 Jan 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546024; cv=fail; b=s6T1aVBISQ9epBXbxC9S5CNoZxMQ4UhQ6Dlj06aTIvb4xe5wLtoiZ7iLaaqzsaLCAkb+c0pep+7S4Ku97Zim/sGLVObgsQE358zJxDT+AreNs3z+kxixBuCY7PE0R3p7wjlMSf4FCCp+NfmmHNK/NS7pyXdTO39m9cs3CM0LZ7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546024; c=relaxed/simple;
	bh=UQaKBX5GuTDa9YSqjoSSN71O2jy61mNRusAjQ/ilSVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UWGzDYnguUOuNOqnkiHWpuGXr4tE5puzx91vMKL5MLa9HkNZbxAjxsVT43Mdt03mbsbpwV9Ffz0ybzx8oj1Hyobkjumz9/TKuGqnkFQ+5XaevZKqho653/ds8fGRDEazfjzdR/0bAKFsixZrRtKIbvrs8gUXGhfwcdFJEkuoK78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VPoU6nX4; arc=fail smtp.client-ip=40.107.14.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hnqcv+F3BsNYj+gKlF26d6TCwdvcG1ECL+iv09R2l2Wc1vk42GiJvf3i2xEEr1HPhljj/Cmyzs7dRSIN7yGmr2xdDHG3EEm9fwdWqir5kibBMcaDjZ8PXYnizkm2M2oDkuZeSYiYYZi7GKQwmam2FOmtN4dZwirMeVu+BMv97tqSllyTFCt3pD7VfD3tfHPS4h6c1bZmWmYOMBUc0PgP/dw8oU0t2rOuLGmdIGiaL++uPaw52sV3SX9RXS+A8aTzyQdiq8SgtgiZGn114SvdgpiKqlvP647P5ySugqkEawYE0OF5YMKXfBYJJR4exJ2c8Vg5ChBI3oWPjQ6yZR3PIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIcMPvJ9AM1GdOp+Bfek3DRQN08uvSOaSspaFNR6tyc=;
 b=IZYgBxVZcmHIcQrLSddyPv+YID9KzdFZAcS9OWwcGWN220nucBPWov8fgfuB3flBy1TnyxbGT2k9C3NWiuezqfTwkJaAjpdjM/E8r9YdXyh+fbZ79Tq2zBdh/a1UTrl5mKAoMfdRAxKn5dHYsOV4SZCRGLIMZHq0O1Qf0MMCjWiZ78cGiRGr7OOdIU9wJEZ/16Wzbl14fU2+Z0kErzRH2sxbRr5B0PV0ywG2GD0Ci00hfxLLzUp5mIPT7heDPXWergS6TShOPS1WsffJ5Wysou/3X9ULGd/l59IqQixd6NjMcCRUJQ99klNw45dJpUOCzNZuZ08JbmGEMPHLOfvjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIcMPvJ9AM1GdOp+Bfek3DRQN08uvSOaSspaFNR6tyc=;
 b=VPoU6nX4uV8eWHiM6VzdGKiieSFKjTIh2mB4Hff88TSODUu+Y1k7164oT/izQGymWVrJSlS2FR0MCIFgsahipbkie85TusUv1RRGhTB4efU6c4HkMApuQUFnqCZfCXRz7JJGml7wi6nwhs9Bu1ZNqo/LNZs6jcZqzfwPPpcvEdY=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9768.eurprd04.prod.outlook.com (2603:10a6:102:381::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 16:33:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:33:39 +0000
From: Frank Li <frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>
CC: dl-linux-imx <linux-imx@nxp.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH v3 3/4] perf: imx_perf: limit counter ID from user space
 and optimize counter usage
Thread-Topic: [PATCH v3 3/4] perf: imx_perf: limit counter ID from user space
 and optimize counter usage
Thread-Index: AQHaUpsYS1yWJv+JdUiWhRRn2LDPHLDw+3Wg
Date: Mon, 29 Jan 2024 16:33:39 +0000
Message-ID:
 <PAXPR04MB9642D08437D60164E91E73D6887E2@PAXPR04MB9642.eurprd04.prod.outlook.com>
References: <20240129101433.2429536-1-xu.yang_2@nxp.com>
 <20240129101433.2429536-3-xu.yang_2@nxp.com>
In-Reply-To: <20240129101433.2429536-3-xu.yang_2@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9642:EE_|PAWPR04MB9768:EE_
x-ms-office365-filtering-correlation-id: b9a8f2d6-0a70-454d-7438-08dc20e80c5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zN+FPPKJJQ2hJetJ/i+FWDuBj07HQk5RqPtS0bfo3Z7rsQQlcFjpdPZSjMXVUqaHjNa8zU5dfyYTLGFZqtZkr2DeeSSqnNs5rSrlQUqfRWIfSjDhgBxW9AJ3S3wqkPnjZK3crGv227VtGJttkxDg5I6tnILbSrRX8tvCLCD/1PDUTGHSURHZFnVFghAHZygoZow6DcYPrIE9rB3TBnXo+hnStiKCAEvaXhnyYcMjofC0PcVCF9tOmxdiL7A6ocX0RmI0wnN+9RAjqEoFzXtFZ3yRO7B/VuxcC+C3ngOymNpFOIyxje9DT/Fc3J0XKv8ryz1gGYymZkmGIbTHu8+r4fBuj96iTJ1K1PSArjVDKs5YBdycoEePc1zix1SqJ70vqj7M/rAPdjgGNzi8BbYZVqicL1aSK77q1kiYaE57DlZyI/kot/4n527neCnFvaoIWtYH04AbvG4v9OHFAfBYnmKs/Q1etj/alT5EgnhlYfXOYqJZjuDpX2Mm6qjt7MxPelPLRqBgxSanTybnIwmAk27nduVGqSjfOu3q1auWK0XbytxquIpRy372KVfr8SKY8Owd0gQuN/8IWZuz4SaGETNZ3fgtqUxoxrNyFDtcJGYVIzxPcW380MEffIagtWnex9sfO5LsdIK2zFNZ691dtw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(53546011)(26005)(83380400001)(7696005)(6506007)(55236004)(9686003)(38100700002)(122000001)(66946007)(5660300002)(4326008)(8936002)(8676002)(52536014)(41300700001)(44832011)(54906003)(71200400001)(66446008)(478600001)(316002)(7416002)(110136005)(64756008)(76116006)(2906002)(66476007)(66556008)(921011)(86362001)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8+xQQug/B54IStOBuNJGokWcYXN+lPLiLd3Z7SlN65QwBhPRLPelsE2j31Ym?=
 =?us-ascii?Q?RyXeji6nMpeyczoQ2V5+EgSpaQVD85tXOIJ/pRHpsU6OiwEmuUxuXj/1Qurl?=
 =?us-ascii?Q?X7sOcfT02Qrbh4TU3pvgOxqwbLObK9vKqhjBg5TvcqH6xk2aOyBXYCOtf55s?=
 =?us-ascii?Q?3UgMvcBq53EQkzjWFVP0kKyPblCe2+45Z/6wGqFQw5CTQju6/2yY6R/P5o5h?=
 =?us-ascii?Q?FItqIwoIQJbzPD2+yLzxW8DPZvreEy+AgJniIFwfb/ctmReYLxQmpF2WKvBc?=
 =?us-ascii?Q?ywMLWpKANauZJlMu5PFAWVbZ87xq/RbpiM866qqWv/1MJhwi10iWPobsbaoS?=
 =?us-ascii?Q?vnMBbCN4OyHpBIEU3xS4TfcMM/kECxHj/J9fCoe7ua9mQ7MpCZu7/KyWar0t?=
 =?us-ascii?Q?4EJ9N2BmpOUs5P+ZCPsoQvMxL9hc3qBVcD9MJ8ddHv2UTsr/reEgGFkkcTI4?=
 =?us-ascii?Q?IQsHOhyigJKz64f4hceWbGZUNTNkoIfjVcl5WiqLjCsJCyNr1Vrmx6IYwKOr?=
 =?us-ascii?Q?UABaJ4OICb36CxyBTd9a+szOiFjI27WyKZRjsRFLM5zCV3YW8MMtUITOl1kU?=
 =?us-ascii?Q?K82V51tur6+hy+aL58D4masfOg+7mR/UphwFhBzS+2S6EQ5o+0cGJiSNSBv1?=
 =?us-ascii?Q?Fcd3QtJTX9mGVFZnYTHBA/LOQNYnLO1uektUQ7oJloqllZGAgd3cXNAyS156?=
 =?us-ascii?Q?uWxbhjbG/rMf4UEbAPYxZLMGOjic9sDlym2/QSUOaA7vk0kBp5zt6JVrI/ww?=
 =?us-ascii?Q?At2l965yQnytXeoWPX99sEGotx9xalpCRWn/jFa7YcRRTPr4dRBaHGLx7lt+?=
 =?us-ascii?Q?79SpEf/LL6l2ZPPJqmhrV7FpAIibkNv7Ec2jRT6yJv00UTGQAymyWoRnMMMf?=
 =?us-ascii?Q?249pYouuH7MB4mU6Qi46nsZ9jgZU1RKDGopWQfmQt6Fl7N4FJYsfE1hQqcu0?=
 =?us-ascii?Q?QRzN1P1rNECugmJxEoPQguTTm4x/RnAKzAV/Zho/kATQRtI+WKkAiA301Qsy?=
 =?us-ascii?Q?sol1blgVROx7jUTd+wu9DZhXOND6VEBx9tjw9WMxwPEgHgAUfY0xn/9Uqtvy?=
 =?us-ascii?Q?gNTw8difwgyIKPB0DQHn5HGiiSq1hdTWpwbSoB68XOpOR+uqWr4KJvC+Kjg/?=
 =?us-ascii?Q?ZwK5mf/WRTFhZlsWxvCAcGlY9YDx5lCeFqF3186tcd4Ul1wKDYRlmYbbxXio?=
 =?us-ascii?Q?ehjPbpJRYaO7c9jM/OomMizjdE0ZLwKs8gUo5M4fnPDrBkuJzNfcVUKTsjhO?=
 =?us-ascii?Q?TqGc1jNh6LWcCjZ3+d0YrZ9KlBS4sLo2Cu3kQGtYWv7STGyZrjPMqGK2CTfn?=
 =?us-ascii?Q?NgBjsj8F3UPMT2rNHXwJf+iyxfTC2xkm0n5UfBNksAyS0cVtoEFmvy13RCR1?=
 =?us-ascii?Q?XFQ4FydoH+n1JDao+v4EjEaAhgPw8J3wpWMRWquEjzi8SXshLCr9B3qFy5zG?=
 =?us-ascii?Q?1f/njjUj+OqtTWsNlD/p3cma7wM0h8ZNXxFsRkXC1S8EuCVv6xsVj/YlT+B7?=
 =?us-ascii?Q?ydAMDTylaDqZ9GAavY2Wt+8g55uDd06qBCKUN2B1xZ/4LmqYkjtrDgnLBiky?=
 =?us-ascii?Q?AHA4RjaYS0bWRQdk2F8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a8f2d6-0a70-454d-7438-08dc20e80c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 16:33:39.1753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/hM7UVSJzDYU4bnkW/tJhsfjUHYMA1T8NEXb9RWs9HLOKvXakq6aPa9mHf5gJU65hYeC7fa0xo02tBCdpJdVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9768



> -----Original Message-----
> From: Xu Yang <xu.yang_2@nxp.com>
> Sent: Monday, January 29, 2024 4:15 AM
> To: Frank Li <frank.li@nxp.com>; will@kernel.org; mark.rutland@arm.com;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; john.g.garry@oracle.com;
> jolsa@kernel.org; namhyung@kernel.org; irogers@google.com
> Cc: dl-linux-imx <linux-imx@nxp.com>; mike.leach@linaro.org;
> leo.yan@linaro.org; peterz@infradead.org; mingo@redhat.com;
> acme@kernel.org; alexander.shishkin@linux.intel.com;
> adrian.hunter@intel.com; Xu Yang <xu.yang_2@nxp.com>; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-perf-users@vger.kernel.org
> Subject: [PATCH v3 3/4] perf: imx_perf: limit counter ID from user space =
and
> optimize counter usage
>=20
> The user can pass any counter ID to perf app. However, current pmu driver
> doesn't judge the validity of the counter ID. This will add necessary
> check for counter ID from user space. Besides, this pmu has 10 counters
> except cycle counter which can be used to count reference events and
> counter specific evnets. This will also add supports to auto allocate
> counter if the user doesn't pass it the perf. Then, the usage of counter
> will be optimized.
>=20
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>=20
> ---
> Changes in v2:
>  - limit counter ID from user to 0-10
>  - combine dynamic and static allocation of counter
> Changes in v3:
>  - no changes
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 69
> +++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c
> b/drivers/perf/fsl_imx9_ddr_perf.c
> index fd118773508d..4bb80050920c 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -51,6 +51,7 @@
>=20
>  #define NUM_COUNTERS		11
>  #define CYCLES_COUNTER		0
> +#define CYCLES_EVENT_ID		0
>=20
>  #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
>=20
> @@ -235,6 +236,14 @@ static struct attribute *ddr_perf_events_attrs[] =3D=
 {
>  	NULL,
>  };
>=20
> +static bool ddr_perf_is_specific_event(int event)

Why call specific? Name is too general.  Such as is_fixed? Or Is_with_filte=
r?=20
Need know what specific?

> +{
> +	if (event >=3D 64 && event <=3D 73)
> +		return true;
> +	else
> +		return false;
> +}
> +
>  static const struct attribute_group ddr_perf_events_attr_group =3D {
>  	.name =3D "events",
>  	.attrs =3D ddr_perf_events_attrs,
> @@ -507,6 +516,7 @@ static int ddr_perf_event_init(struct perf_event
> *event)
>  	struct ddr_pmu *pmu =3D to_ddr_pmu(event->pmu);
>  	struct hw_perf_event *hwc =3D &event->hw;
>  	struct perf_event *sibling;
> +	int event_id, counter;
>=20
>  	if (event->attr.type !=3D event->pmu->type)
>  		return -ENOENT;
> @@ -519,6 +529,18 @@ static int ddr_perf_event_init(struct perf_event
> *event)
>  		return -EOPNOTSUPP;
>  	}
>=20
> +	counter =3D (event->attr.config & 0xFF00) >> 8;
=20
Define 0xFF00?

> +	if (counter > NUM_COUNTERS) {
> +		dev_warn(pmu->dev, "Only counter 0-10 is supported!\n");
> +		return -EINVAL;
> +	}
> +
> +	event_id =3D event->attr.config & 0x00FF;

same for hardcode 0x00FF

> +	if (ddr_perf_is_specific_event(event_id) && counter =3D=3D 0) {
> +		dev_err(pmu->dev, "Need specify counter for counter
> specific events!\n");
> +		return -EINVAL;
> +	}
> +
>  	/*
>  	 * We must NOT create groups containing mixed PMUs, although
> software
>  	 * events are acceptable (for example to create a CCN group
> @@ -552,6 +574,39 @@ static void ddr_perf_event_start(struct perf_event
> *event, int flags)
>  	hwc->state =3D 0;
>  }
>=20
> +static int ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event, int
> counter)
> +{
> +	int i;
> +
> +	if (event =3D=3D CYCLES_EVENT_ID) {
> +		/*
> +		 * Always map cycle event to counter 0.
> +		 * Cycles counter is dedicated for cycle event
> +		 * can't used for the other events.
> +		 */
> +		if (pmu->events[CYCLES_COUNTER] =3D=3D NULL)
> +			return CYCLES_COUNTER;
> +	} else if (counter !=3D 0) {
> +		/*
> +		 * 1. ddr_perf_event_init() will make sure counter
> +		 *    is not 0 for counter specific events.
> +		 * 2. Allow specify counter for referene event too.
> +		 */
> +		if (pmu->events[counter] =3D=3D NULL)
> +			return counter;
> +	} else {
> +		/*
> +		 * Counter may be 0 if user doesn't specify it.
> +		 * Auto allocate counter for referene event.
> +		 */
> +		for (i =3D 1; i < NUM_COUNTERS; i++)
> +			if (pmu->events[i] =3D=3D NULL)
> +				return i;
> +	}
> +
> +	return -ENOENT;
> +}
> +
>  static int ddr_perf_event_add(struct perf_event *event, int flags)
>  {
>  	struct ddr_pmu *pmu =3D to_ddr_pmu(event->pmu);
> @@ -559,9 +614,17 @@ static int ddr_perf_event_add(struct perf_event
> *event, int flags)
>  	int cfg =3D event->attr.config;
>  	int cfg1 =3D event->attr.config1;
>  	int cfg2 =3D event->attr.config2;
> -	int counter;
> +	int event_id, counter;
>=20
> -	counter =3D (cfg & 0x0000FF00) >> 8;
> +	event_id =3D cfg & 0x00FF;
> +	counter =3D (cfg & 0xFF00) >> 8;
> +
> +	/* check if counter is available */
> +	counter =3D ddr_perf_alloc_counter(pmu, event_id, counter);
> +	if (counter < 0) {
> +		dev_dbg(pmu->dev, "There are not enough counters\n");
> +		return -EOPNOTSUPP;
> +	}
>=20
>  	pmu->events[counter] =3D event;
>  	pmu->active_events++;
> @@ -597,9 +660,11 @@ static void ddr_perf_event_del(struct perf_event
> *event, int flags)
>  {
>  	struct ddr_pmu *pmu =3D to_ddr_pmu(event->pmu);
>  	struct hw_perf_event *hwc =3D &event->hw;
> +	int counter =3D hwc->idx;
>=20
>  	ddr_perf_event_stop(event, PERF_EF_UPDATE);
>=20
> +	pmu->events[counter] =3D NULL;
>  	pmu->active_events--;
>  	hwc->idx =3D -1;
>  }
> --
> 2.34.1


