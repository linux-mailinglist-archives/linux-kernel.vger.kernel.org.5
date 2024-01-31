Return-Path: <linux-kernel+bounces-46711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458FD84430C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE90B1F287CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56EF128397;
	Wed, 31 Jan 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="APL4fpXG"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851484A45;
	Wed, 31 Jan 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714954; cv=fail; b=ZtLUlnkrNLhH3FWFvbTV8TxsZLr/rH5mpJ8MHeOEzpjn3KDncEqiJhy5k0mIRiZ1cgygznd+1GYV6TGQMuy7Tz7Dtro6zM6ORu90fOmHChEBGruQ9tYkSriKZylRJj3IxL5USIBaSo5qh5UwA9w41u6fNgsEWrROCkx4nmQz3Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714954; c=relaxed/simple;
	bh=d9vSjGlFcKZxbBczpdI/JvTWA0SaLAo8X3u2tq5mNg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WKQZBvERIOR28lBA0xZV2fEUzJW6/M7HF+si6RoLbIrKNhn94hAmwsyl8ENVrXFsy0xR3d7CR8TgWAzgFqoCze/YTQHGWMQj6D7Mc95fEsYR5A9l4SnO6KAaXCv81Qw4zDh6hBij+Djuymi2x+ZIZQeAX5hhLv6JSeoiv2Bj9tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=APL4fpXG; arc=fail smtp.client-ip=40.107.6.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM7YX51AErSrKcY8GjTHMV4KzZQqIpsJb2/nDDeTgm/Ho807FdiTqQPLBqJjxeW+yb0uZ2KrSgubrXlDDE92buIzlrdEcDJSDAbslc06f0f6ZdqeNIlA/m7lSn6e4U9Z84RFb2bgIbgW89+i01d5rEiygtyb8nt0l/1uDMOBnQX+Rmv+bRNCGlgaA0WCg5X3SXGB0IRdyElJ+hw3mXc7FJ3M0CkIEEUrzye0slKPSbeEAwOsw2Zl51UPNnXJYr2LmQ4UStXqJYWbFJfT/WrCVvR40RZe3cRNiEWPmjJ+Jh5GanO2vMA64wQeOeCnuMx8v/pxA8Zo5HIFrF8fP0bJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cb0nbjgH5r166gXz2Jvl5NA/jLw2yEUQfuxbOZz1pk=;
 b=OikaTWTxlxRYizMs6K0blNjUpUDBs+WLoxRaUP/lgrYJxNUAhnL5OV4jsBWlmGtbKrRMukPcyiXTWRTnmEuGm6T/CznjrFxxvP/v2oknd/OlxiM1ZZdhF+P++//9Z1M+rYArWTVyddrvnuIxFwdFQuk0T8ZZBb4weIQ4X9ku+I9KK7Lq5YoIxjHHXO5FwUuywKqe+bgTEBXgw4Que1JUQ+xi4K+dFCNqDZLVSAqjb1djx+VVoGH61vMXtQC44T1KyFW3Gf3WQVIR4yfnqQiq9F16rK2JlWOTbZhIfaIiy4W8DJ/h1sfoiKxWQoE2uEWYIaZ92giYHcg/MAVNc3i5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cb0nbjgH5r166gXz2Jvl5NA/jLw2yEUQfuxbOZz1pk=;
 b=APL4fpXG56WJFi0mJUKlUaqVcHbXn8pOF+OqJQ6KJf0nTfOqyquBr7GQ5IAp/G7nBjB35F0oXmME/nxOj5yG0zK6qqfSX8mqP8zQAazANDr2hE7G9XbdnRSUGoz5hgU+e1S/DV/0PhWjBhtq5Dw+Ly9ke/FBg+p6tcR5F0iCWkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7657.eurprd04.prod.outlook.com (2603:10a6:10:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 15:29:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:29:09 +0000
Date: Wed, 31 Jan 2024 10:29:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: will@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, linux-imx@nxp.com,
	mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 3/6] perf: imx_perf: add support for i.MX95 platform
Message-ID: <ZbpnPKghnJCgLbOC@lizhi-Precision-Tower-5810>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-3-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131055811.3035741-3-xu.yang_2@nxp.com>
X-ClientProxiedBy: BY5PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: c624ec1a-4c91-4118-44e0-08dc22715ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	svS4PSaYwTnOQlBMPacoKzzQ+YuCGeqMS38/GYIezi1vC86PCT0UudRMsNnR9M4UcbAgYfcXi2fv4tzUjofubPe55Y4ipLIpGAzP0CAxkJvFm5STJecpGCFwKTS5x8HrOlDwv1ijcmbk+XDpfN0rWOY6+yk7i3s8Na+pqU1l/ssVZdrzuMPwAggIO2rR+GEeFc7BYvLlQRLW/xpV6l+j8IZVf6PL8vkwZq7maeMe7Etgx68oFeppKLFQVl79u29nXOlJoPtX/hdgJRlHE+SRJidv07VY8OnNvO+tGdJa0niLVwLEknGDoVKv8EWQEZgXM0K53jG2VYQ9RGt00vFV0C+0rREYNmGWQvedZ41q54Fhs2Z+Romg5GlQluw7ycop7PgdMq+ruont93FCu67dhtNRA7gReH9ppczw9mnWNYyGACIiyxARWTLIir4ImkzhRSJDtQtMkjGX6TUV2XRepx0jH6qGehqx1FW9obsUluJis9pQLr9rWcTsdRS7FrVSkZgL1+nWzh2cg415J/XiCLb7j3Js9OgaaaOfS4XMZP5vXYR41RXjENRQBybniUzo+koCz4ZrjNX8WAWi7sblyLX13cGRzsnIW7Vzipu9kxoksJKdoKfVCkeDu79laNIe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(66946007)(4326008)(8676002)(6862004)(8936002)(2906002)(7416002)(5660300002)(86362001)(66476007)(6636002)(316002)(38350700005)(66556008)(6486002)(38100700002)(52116002)(6506007)(6512007)(9686003)(478600001)(6666004)(83380400001)(26005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x+kQU+QLul+l3AgDeQT8ak+w1GWjUaeIfHy0iN/Zuuc2mEF5q+b7416N4W8O?=
 =?us-ascii?Q?wbG252fTihlrABnwOec/vbR20Y6Qml77R3jI7rwvABgPJg5WvHV+7d1/LFiL?=
 =?us-ascii?Q?3pLYyV6NJzWmdh5Vuwk4s3SDa6BAI/kjSTP4ZDqlRatAKPtUPFMBOdOdgjew?=
 =?us-ascii?Q?lYUsmeTJrGNgGY8adl3O/urHAK6lwWiX7x2gVbGNYiUF2o95aGdiVuw3qa6d?=
 =?us-ascii?Q?1OVIwUPXn2Z6LNWrLdRSQQMrgMw1Ry8TM0+Vu9LfrOu9SSFUjje8rhXjdHI4?=
 =?us-ascii?Q?gcnOrtghOv1WQWjsiKHh4z9k3icgm/lvQAyIIneWxVNB69mjMzNnnrOCxZfQ?=
 =?us-ascii?Q?WEHz27PHh2KW/tPUGdpNA0vN8IVvftHhjU81LZzvw3QHMtaPqVENfsjUEgXx?=
 =?us-ascii?Q?PJl3hy7/4d8spezlfiSR449enfA3gF+tBW4Xgjb2W31ipHi2pzJiHtF7neln?=
 =?us-ascii?Q?E7/W2lBMXicj4AKFsT7aaKs1WOSAAy1lQeF2lMyGnDUUE6Vp68A5ZZxyQeHP?=
 =?us-ascii?Q?9Mw/EaXqKVkoY9LbG/3UDHsxhowmd7oo4scSdn6NlawY7iwF+GR9Ftl4QeZF?=
 =?us-ascii?Q?Yy6S5mjT0+cs+3Cg0AjimHJr6sE5RMMPYX3g7YBjrZYRv3OoFoX4r4biEwWh?=
 =?us-ascii?Q?S0PsBm1greMrWqWgc5PfxKB2XzI3xese+6Qu+uADcvzCWX7/sv1qEf3u2B9L?=
 =?us-ascii?Q?6cJLHNqw/K37pw83s3nrezpcIGFDcYikVqYjaXMmQzD6ExtdljxN91fAS8i4?=
 =?us-ascii?Q?0mVpU9jAv/kr7N7AQ1o/l3upfQNo4Qpwt97LdNhZmgrOyQyvzAiisEJWhUCx?=
 =?us-ascii?Q?ue6bvfnKFIMIUMHRpyKOcWs171ufENZFa4xR4ZOf+DW0/IyIo5mhZy8ZcxU7?=
 =?us-ascii?Q?2x3eC3YUMyVDv0G+yUwapadNSjpgtElsE2Y6YQNWhG/t4yZOd3jtxGVfD2sD?=
 =?us-ascii?Q?v6dqXZ4pPl2Uzp07T58cNK3c+/OWNcGEw/O5z7funSbIyUnkVo4NXRmzwet8?=
 =?us-ascii?Q?qZseQlNmJhsqYpg0Ip89OD7JK0T+7AtT/x8mUmalvnHexL1PFO17uQlU49Ds?=
 =?us-ascii?Q?Z8Nd3ehMoG15Jn/2yDaPa1qp7+qbLuN+gtXjCr6wiwcq7fvJL5QaShBg127B?=
 =?us-ascii?Q?I16rEtTKG2GXPtUKOxhXwbkgg/+iBe2P5sKTOvAF4asFHDg50b6A7BfGf2lB?=
 =?us-ascii?Q?vjRw6t+6eDm4jTnAKPaSbau3/YPzvyzkMHqEM9FUJGWGo3a2aXrJzxhTMC28?=
 =?us-ascii?Q?VYgQeAMIIz5tczUJdfmhoMQxv/8Y2ZgufgcNmhBwraVrYkMp/oVkHvx5pVsZ?=
 =?us-ascii?Q?9grUJS6ZqOO/v3O+X4Use2rO1z9u/dq7wJymybMPSwW9UxeDYL1bbqBxr0yT?=
 =?us-ascii?Q?SUIi42W2eITITANBDaE7l7n8deF4fX23UmXgRgUF/qIStDMcwpCuESv8scqP?=
 =?us-ascii?Q?iekKquXkh+rOGMNNSZxEPjJzP645ulnvywojfZkr4Eggnm5D5TXBJVSQ7m3H?=
 =?us-ascii?Q?G/k3ZLce37bSNesYfMIawg0TSU3nczfm0v7Zb1W9rFQsDZQoBzrLfOurwmeg?=
 =?us-ascii?Q?3kHsBSV63XVSDaSt/VQENu+R/eQF4n5V923D+tnW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c624ec1a-4c91-4118-44e0-08dc22715ea0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:29:09.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /c9A+rGN8ctk4MyS9J4Wk6AdxLKQvUzhH5ckPnAEdJSgmQGa99XhHHOceIoxvsm2icfabeqffH7/69n8gpBMzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657

On Wed, Jan 31, 2024 at 01:58:08PM +0800, Xu Yang wrote:
> i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
> read beat and write beat filter capabilities. This will add support for
> i.MX95 and enhance the driver to support specific filter handling for it.
> 
> Usage:
> 
> For read beat:
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3,axi_mask=ID_MASK,axi_id=ID/
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=4,axi_mask=ID_MASK,axi_id=ID/
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=ID_MASK,axi_id=ID/
> eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=0x00f,axi_id=0x00c/
> 
> For write beat:
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=ID_MASK,axi_id=ID/
> eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=0x00f,axi_id=0x00c/
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> 
> ---
> Changes in v2:
>  - put soc spefific axi filter events to drvdata according
>    to franks suggestions.
>  - adjust pmcfg axi_id and axi_mask config
> Changes in v3:
>  - no changes
> Changes in v4:
>  - only contain imx95 parts
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 86 +++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index b1a58e9e1617..85aaaef7212f 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -17,9 +17,19 @@
>  #define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
>  #define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
>  
> +#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
> +#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
> +
>  #define PMCFG2				0x04
>  #define MX93_PMCFG2_ID			GENMASK(17, 0)
>  
> +#define PMCFG3				0x08
> +#define PMCFG4				0x0C
> +#define PMCFG5				0x10
> +#define PMCFG6				0x14
> +#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
> +#define MX95_PMCFG_ID			GENMASK(25, 16)
> +
>  /* Global control register affects all counters and takes priority over local control registers */
>  #define PMGC0		0x40
>  /* Global control register bits */
> @@ -240,6 +250,18 @@ static struct attribute *imx93_ddr_perf_events_attrs[] = {
>  	NULL,
>  };
>  
> +static struct attribute *imx95_ddr_perf_events_attrs[] = {
> +	/* counter2 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, 73),
> +	/* counter3 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, 73),
> +	/* counter4 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, 73),
> +	/* counter5 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, 73),
> +	NULL,
> +};
> +
>  PMU_FORMAT_ATTR(event, "config:0-7");
>  PMU_FORMAT_ATTR(counter, "config:8-15");
>  PMU_FORMAT_ATTR(axi_id, "config1:0-17");
> @@ -271,8 +293,14 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
>  	.attrs = imx93_ddr_perf_events_attrs,
>  };
>  
> +static const struct imx_ddr_devtype_data imx95_devtype_data = {
> +	.identifier = "imx95",
> +	.attrs = imx95_ddr_perf_events_attrs,
> +};
> +
>  static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
>  	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
> +	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> @@ -410,6 +438,56 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1
>  	writel(pmcfg2, pmu->base + PMCFG2);
>  }
>  
> +static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
> +{
> +	u32 pmcfg1, pmcfg, offset = 0;
> +	int event, counter;
> +
> +	event = cfg & 0x000000FF;
> +	counter = (cfg & 0x0000FF00) >> 8;
> +
> +	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
> +
> +	if (counter == 2 && event == 73) {
> +		pmcfg1 |= MX95_PMCFG1_WR_BEAT_FILT_EN;
> +		offset = PMCFG3;
> +	} else if (counter == 2 && event != 73) {
> +		pmcfg1 &= ~MX95_PMCFG1_WR_BEAT_FILT_EN;
> +	}
> +
> +	if (counter == 3 && event == 73) {
> +		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset = PMCFG4;
> +	} else if (counter == 3 && event != 73) {
> +		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}
> +
> +	if (counter == 4 && event == 73) {
> +		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset = PMCFG5;
> +	} else if (counter == 4 && event != 73) {
> +		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}
> +
> +	if (counter == 5 && event == 73) {
> +		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset = PMCFG6;
> +	} else if (counter == 5 && event != 73) {
> +		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}
> +
> +	writel(pmcfg1, pmu->base + PMCFG1);
> +
> +	if (offset) {
> +		pmcfg = readl_relaxed(pmu->base + offset);
> +		pmcfg &= ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
> +			   FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
> +		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2) |
> +			  FIELD_PREP(MX95_PMCFG_ID, cfg1));
> +		writel(pmcfg, pmu->base + offset);
> +	}
> +}
> +
>  static void ddr_perf_event_update(struct perf_event *event)
>  {
>  	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> @@ -490,8 +568,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
>  	hwc->idx = counter;
>  	hwc->state |= PERF_HES_STOPPED;
>  
> -	/* read trans, write trans, read beat */
> -	imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +	if (is_imx93(pmu))
> +		/* read trans, write trans, read beat */
> +		imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +	else
> +		/* write beat, read beat2, read beat1, read beat */
> +		imx95_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
>  
>  	if (flags & PERF_EF_START)
>  		ddr_perf_event_start(event, flags);
> -- 
> 2.34.1
> 

