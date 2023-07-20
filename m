Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E55B75A3CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGTBMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTBMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:12:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901491FCD;
        Wed, 19 Jul 2023 18:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/b3+41Htp5xGgcCQ4f0jD6aL/x6g82/IuW7JClv1sKyqj7yoSXVqTXtl90GGqEvZt05tv4h2gU0zMFmsSsLVQXlF9RpNiAUcmGaF9BJ8WOYEyIy3i90x1jw33Yz+Yx00h2WSJIqLymBBbTsi6YTvVePZZgEQrdPZZIVM0vT2oQJOk3qw4AYJS0X12H9pYxBGydrdazMw/Yf/3KgbZwqOw7yySe7rBw1jtOyafObNVRuMzn1wwkT6BVCJvDy2TWaGeN11FcUzqY+HBlvK5fTDdQLzugD8YXs1HD0wjhdqhDL6UIAiDeHWeD5ie1BMerYVni1zSIa6WAZjAbU8XrN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI1K1plZd137spBGw1nibVL3GDD25yhtT2kOM4OrfnI=;
 b=kfJ+71D2Qd9gYorS3EHwPUjaXujh7H1g9qjUEVBAv8W71fEZEwfMTWAVuwBtPnYwmdobPh7P7te7AbcP0uSH+m3KcqzSbevdQLc7JSQk7vwrDRTrQr6k5pg+CtEXO0mLMMWSrhFQsjjWV+I1LJ6YYemVLpwtgeOZ0btZdutLhYy0uZUKu779mJPUoOL/t1+Uh5Veo31FOHNzUnAAkhZx7tD4NfJXULNKnM9wvgFdx7VWTYm/nISH8hClPrm5fqxG+7/03peAIFC1tnB3MGrF5BA8381+6xdjpmOPT2oNqSvMUmQLeVsjdda4MraqQEh81ARvH/OYDnDH9PkHnQnw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI1K1plZd137spBGw1nibVL3GDD25yhtT2kOM4OrfnI=;
 b=OkvG4pUcsioez/8kqfJ29L8mEQRoWelTLo5t9/zxsW4htcQ3gxqHXk/ZherDysxgGh5aGUMFSK/pEmr4YTojvhMq5CCB952ygVBUoieYMAJrnkj8HaZ19EH9wEtUFDvpCDjI/tZdcim+ejIUORFmP3Hk3vVNHbuypgbRs3X+nWE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 01:12:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 01:12:34 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: RE: [PATCH 1/2] clk: imx: pllv4: Fix SPLL2 MULT range
Thread-Topic: [PATCH 1/2] clk: imx: pllv4: Fix SPLL2 MULT range
Thread-Index: AQHZp2CbnGgVjWRZJk2vJ7TPHjeSc6/B/8Kw
Date:   Thu, 20 Jul 2023 01:12:34 +0000
Message-ID: <DU0PR04MB9417B2AE6605446A84C15609883EA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230625123340.4067536-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230625123340.4067536-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAWPR04MB9986:EE_
x-ms-office365-filtering-correlation-id: dc1df6b2-97d5-4ac4-2b70-08db88be6633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wiwggGP32akQxopXceIncsXMYev0KJ7mOKrMz7lhduJEhxGg7OR+Pa7rtZSjcWUuHMzOPA3Ma1eODFGd4RnYXvJr4htO6Z/Eqbmt9qiNl4R1PmSzsMBrIHn2YRHlbZx7ACIT1Ep6hhPNJ4pMa5e0XnQ+1CaeqM4S+Ged4fFe85hEqXRguMoZR+UXSAJ8op8bkBhmH7EzdtAmEWVtkscCWHHwodlBw/diDOQl3gQcVm/soEWTFVcRhw0Wh9uE9Xi0MciSOXoPuj9d+ArTTM7pxpSQF9WOcMZYMUxMEzv1Fg6HRjWwQBaqTT7OFr3efR0M7BxjH+A1f+AJW5+Vxf9y39rgXLP+fffzeE7UZyOWEhuNdJW2rB6fVtlfEzNRuROVUveTp/i0eoP/ea/Y7X6ZB/fnTmQSp9vHh/Up+JYb+tVpic6Uknuo933Psd73AyLtGu1T+Ekxscvho6e4OnMteLL/6GppgnfPNR6u3lqs1F+gqbY5oBrjVDwNmuFTQ1bs7Xu3pmBZtRdAbjXJK6lvCX0Eelcvix9UxrsZDFMsjJl5a3L0RbFnJhE9x70COE4+6xxJggQfCJYYE2b4agiVDl1suZcP8qGTAvdkNeKwauK8gZiYBS8AXjLzqyiMJJES
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(52536014)(66946007)(44832011)(64756008)(7696005)(9686003)(66556008)(66446008)(66476007)(2906002)(8676002)(7416002)(316002)(8936002)(122000001)(4326008)(5660300002)(6506007)(38070700005)(76116006)(55016003)(38100700002)(186003)(26005)(71200400001)(41300700001)(86362001)(478600001)(83380400001)(54906003)(33656002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dWoqTvLAK0B3C14bTOd6+vjHLn3sUvoRLAxVu8uvwYJPYfFF1BIE5C7RKBa7?=
 =?us-ascii?Q?hI2Yrh9YWAsk9exTNM/I3cjEg9CAc3T3zZB5UOETZZTwiuq4YLS1kxym5hUk?=
 =?us-ascii?Q?HGGxjPPhSdEsN07HfTIxxPBwGtW0medFqwBoGINo8BNfEzzlNL6hA+sd+426?=
 =?us-ascii?Q?tVyGXS6sVd4JehLlUEPP4JeFjMGZJSUnu8MRqihWXqJkOpwmPzIEo3hcaHpf?=
 =?us-ascii?Q?yIew98aeRhFh12TI0TfPIaGvMdzWE8Nysi/lSoZIw9e1x3r0/sfvCzobBlTq?=
 =?us-ascii?Q?ua4wJ23rFFr6wtj9IQwJaoHSz0vyJXYnZ6MQv19zgczqllmBqchQZiFmUqiD?=
 =?us-ascii?Q?Jlo9SYrbgpHnhBfREkh+gr5d33an3QPkwMI+93JfnnZ+AvnPdY8Jqan0WjC1?=
 =?us-ascii?Q?VWeu8LXEFdzmxzVeTmMnbi+LlDj0jbfjX+1B0A0gj4ipZRhTpBlalDN3OhfI?=
 =?us-ascii?Q?TCvI0zvc5aCyfr0LG4YJWh7tYGdyvu//U0zXawGsr+MKXCQNl7NBES0GDsoX?=
 =?us-ascii?Q?ORYoOyqiv+n/FULnPtNQekqxyGQo36GOYnOzUiXGPHcSBj6aUWLkSxA/pVgN?=
 =?us-ascii?Q?1cSZ5hXhFLvvzfKdUkhQTNpGNqpgQIAAvnx+Lc/pYl2/nvEjybI9NZRIc0PF?=
 =?us-ascii?Q?K8VvWt5rr5MHXwRo0nXDxvFpomJDfFG67CgTvJzyGCFIoAlouVJFjFRDmKE2?=
 =?us-ascii?Q?dN7kpnEYBfUaiTwmCteVbeJUb+XkuQab9UpVik1TMPc166cMED7e28R2/S2e?=
 =?us-ascii?Q?ovqe956FM1R8gKGN6VgQqROiYHFHUEkQD+W9GvUcA68qMTgnWT94nIqc8Re6?=
 =?us-ascii?Q?7Sd2kFb86PxCoH4mTTVXSUcsyG0EpLDUXXGnQ6iXwa5Qpun1fTkMBABsyG36?=
 =?us-ascii?Q?/AW/P8TbwSzSs6nTcw7oc9En7qnnVrmkX/kMxwTDDV2cXJAbMKe6M75WjUX9?=
 =?us-ascii?Q?tA5JCLCDJuw+rxZ3sYhff3t/q5tbHa+zUjMCfd/o6X5EtCO569ZT2LNEhf1v?=
 =?us-ascii?Q?r5T3u8ZlJgGxo/XT7rZtJe16OjNRCL/phbfm53iw1vFP4a6BeCYlCh8oy+TM?=
 =?us-ascii?Q?NCU1X2CBF8uHUZFb4/MLfh0ItfcPxcLlywbKM75cVBAd+B0gXc1jhJ7zfs2s?=
 =?us-ascii?Q?+XdVEltaIqL3hnH2uwEw0Y8P+p8d0vw+NFiZF9oCImQrkMPuZK9b20d/DIdd?=
 =?us-ascii?Q?yfUJMGyWSxP6PGTDwsn6g0qu785hfG2soku6zPX7DFoZdWhUa20qNW5enXu3?=
 =?us-ascii?Q?lOkKyKe3BHfFH3c/hXkPkwniu27UIb6lk40DO/HGFkA9SYSD1mJFiPomNSjF?=
 =?us-ascii?Q?FtAruRNJEum0tbbeCoDME2zPucdU4HRQRfbTQLjf3H7Du0g9/P+ySa+7WhPL?=
 =?us-ascii?Q?ZmiEXgAznYVV1Ng++LrE+WG60pifT08B6ihOLuTsxQnDdYbbhD9vFakVJk9D?=
 =?us-ascii?Q?v/gxrST4+S1JG9R8G8tYwgiA4eDSsFPoeReM66USDXts7GDY7VpL8HbzH2Vw?=
 =?us-ascii?Q?SR/75WwtTfYpj4GIKFsKMahHDklVn5S06/Q91XIs/2zTzW45+0/tlQpB/cYn?=
 =?us-ascii?Q?DBUOtpL77AF9107m/S8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1df6b2-97d5-4ac4-2b70-08db88be6633
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 01:12:34.2275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFveMuCwWrMr8F8PlVnjMxJLnIDyJBRfK6gr2aPT59bLnqDif6L4JgMLk9by7YvUrOGd0rKeqmC1c/xk6nantQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel, Stephen,

> Subject: [PATCH 1/2] clk: imx: pllv4: Fix SPLL2 MULT range

Would you give a look at this patchset?

Thanks,
Peng.

>=20
> From: Ye Li <ye.li@nxp.com>
>=20
> The SPLL2 on iMX8ULP is different with other frac PLLs, it can support VC=
O
> from 650Mhz to 1Ghz. According to RM, the MULT is using a range from 27
> to 54, not some fixed values. If using current PLL implementation, some
> clock rate can't be supported.
>=20
> Fix the issue by adding new type for the SPLL2 and use MULT range to
> replace MULT table
>=20
> Fixes: 5f0601c47c33 ("clk: imx: Update the pllv4 to support imx8ulp")
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-pllv4.c | 46 +++++++++++++++++++++++++++++--------
>  drivers/clk/imx/clk.h       |  1 +
>  2 files changed, 37 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c in=
dex
> 6e7e34571fc8..9b136c951762 100644
> --- a/drivers/clk/imx/clk-pllv4.c
> +++ b/drivers/clk/imx/clk-pllv4.c
> @@ -44,11 +44,15 @@ struct clk_pllv4 {
>  	u32		cfg_offset;
>  	u32		num_offset;
>  	u32		denom_offset;
> +	bool		use_mult_range;
>  };
>=20
>  /* Valid PLL MULT Table */
>  static const int pllv4_mult_table[] =3D {33, 27, 22, 20, 17, 16};
>=20
> +/* Valid PLL MULT range, (max, min) */
> +static const int pllv4_mult_range[] =3D {54, 27};
> +
>  #define to_clk_pllv4(__hw) container_of(__hw, struct clk_pllv4, hw)
>=20
>  #define LOCK_TIMEOUT_US		USEC_PER_MSEC
> @@ -94,17 +98,30 @@ static unsigned long clk_pllv4_recalc_rate(struct
> clk_hw *hw,  static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned
> long rate,
>  				 unsigned long *prate)
>  {
> +	struct clk_pllv4 *pll =3D to_clk_pllv4(hw);
>  	unsigned long parent_rate =3D *prate;
>  	unsigned long round_rate, i;
>  	u32 mfn, mfd =3D DEFAULT_MFD;
>  	bool found =3D false;
>  	u64 temp64;
> -
> -	for (i =3D 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
> -		round_rate =3D parent_rate * pllv4_mult_table[i];
> -		if (rate >=3D round_rate) {
> +	u32 mult;
> +
> +	if (pll->use_mult_range) {
> +		temp64 =3D (u64)rate;
> +		do_div(temp64, parent_rate);
> +		mult =3D temp64;
> +		if (mult >=3D pllv4_mult_range[1] &&
> +		    mult <=3D pllv4_mult_range[0]) {
> +			round_rate =3D parent_rate * mult;
>  			found =3D true;
> -			break;
> +		}
> +	} else {
> +		for (i =3D 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
> +			round_rate =3D parent_rate * pllv4_mult_table[i];
> +			if (rate >=3D round_rate) {
> +				found =3D true;
> +				break;
> +			}
>  		}
>  	}
>=20
> @@ -138,14 +155,20 @@ static long clk_pllv4_round_rate(struct clk_hw
> *hw, unsigned long rate,
>  	return round_rate + (u32)temp64;
>  }
>=20
> -static bool clk_pllv4_is_valid_mult(unsigned int mult)
> +static bool clk_pllv4_is_valid_mult(struct clk_pllv4 *pll, unsigned int
> +mult)
>  {
>  	int i;
>=20
>  	/* check if mult is in valid MULT table */
> -	for (i =3D 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
> -		if (pllv4_mult_table[i] =3D=3D mult)
> +	if (pll->use_mult_range) {
> +		if (mult >=3D pllv4_mult_range[1] &&
> +		    mult <=3D pllv4_mult_range[0])
>  			return true;
> +	} else {
> +		for (i =3D 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
> +			if (pllv4_mult_table[i] =3D=3D mult)
> +				return true;
> +		}
>  	}
>=20
>  	return false;
> @@ -160,7 +183,7 @@ static int clk_pllv4_set_rate(struct clk_hw *hw,
> unsigned long rate,
>=20
>  	mult =3D rate / parent_rate;
>=20
> -	if (!clk_pllv4_is_valid_mult(mult))
> +	if (!clk_pllv4_is_valid_mult(pll, mult))
>  		return -EINVAL;
>=20
>  	if (parent_rate <=3D MAX_MFD)
> @@ -227,10 +250,13 @@ struct clk_hw *imx_clk_hw_pllv4(enum
> imx_pllv4_type type, const char *name,
>=20
>  	pll->base =3D base;
>=20
> -	if (type =3D=3D IMX_PLLV4_IMX8ULP) {
> +	if (type =3D=3D IMX_PLLV4_IMX8ULP ||
> +	    type =3D=3D IMX_PLLV4_IMX8ULP_1GHZ) {
>  		pll->cfg_offset =3D IMX8ULP_PLL_CFG_OFFSET;
>  		pll->num_offset =3D IMX8ULP_PLL_NUM_OFFSET;
>  		pll->denom_offset =3D IMX8ULP_PLL_DENOM_OFFSET;
> +		if (type =3D=3D IMX_PLLV4_IMX8ULP_1GHZ)
> +			pll->use_mult_range =3D true;
>  	} else {
>  		pll->cfg_offset =3D PLL_CFG_OFFSET;
>  		pll->num_offset =3D PLL_NUM_OFFSET;
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> af19d9f6aed0..adb7ad649a0d 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -45,6 +45,7 @@ enum imx_pll14xx_type {  enum imx_pllv4_type {
>  	IMX_PLLV4_IMX7ULP,
>  	IMX_PLLV4_IMX8ULP,
> +	IMX_PLLV4_IMX8ULP_1GHZ,
>  };
>=20
>  enum imx_pfdv2_type {
> --
> 2.37.1

