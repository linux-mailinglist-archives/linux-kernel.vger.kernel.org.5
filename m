Return-Path: <linux-kernel+bounces-119243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FFB88C610
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C26305DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED5F58220;
	Tue, 26 Mar 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KamWJecl"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2107.outbound.protection.outlook.com [40.107.20.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847513C8E1;
	Tue, 26 Mar 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465063; cv=fail; b=dUmnILeN0FwHHEc5DAA3UW+X+uFyEdGgCVB/u8yuOIKsa20TtHYfeOU/Um8OFDRBWHpZa58kRn+fveSCdeL0GiS56/mKrjgFIqUy73T7ViK1tbEbub7Q7ioJlkE/fKrbsDk+gVfMFcZTJDQFzSqyg8gGrsOWYYvzgLFz42pkUYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465063; c=relaxed/simple;
	bh=Bfssr6J/hAXbRv0h1AOijBDgyd2d+OZkEpxg13F2oZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OWJDA4hG//PcMwCCBu+IISw2PC0Fp5JCMy91vNp6SuB7mfcgFLaB/Vy4Q3QC5q9V5moVtvB/H6WWZYumjskgC7fExCbEoemwNI8DfGgHJqZ2BTbB3Rz/sLSKl5uan6XzZuvSMmVKmm+Y6KgtWXAVh8x2nFRv0JzaX7Zf3b4kGgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KamWJecl; arc=fail smtp.client-ip=40.107.20.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwxhMg63xqL6wsBVAm5q01IA3dcliU4Q6hoWQEoqMJoKDYRM5tsFfJ4g2U0PVrrnChoCGLtT14bMZ3HzsHqPuPW5EntGYmTRZtNznExK/pYHLAOm3pDGCMDMR0snBdcAQbrUMHSgaUM3TZMohzK+9jpuhNpi6oEGEYSwIrSrlqao3u0ZySRabRHf6G9kz3S/U8ifUb8e5k+sGh1SDskiCjTXQfusbyHox//GX6EJ+Pc4nSaRYR5x57z9ogqGXvRuP/uZ+i7Tk8Ud5zjShSRpaU6+zFDu+5Onsub4DaQ6cnE38k05xtxruL/ed7BiVzf249pfJJuOVkZNx14F7rmxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGgJ1DXvPKmaoqwqFjznkwpDF2CYaTF/JlUo7/BsslU=;
 b=UphLWJxbrFuwPjNXvsRhtalbVPfm/P1g2PJg4PT4sM/hLwWuDFm5G97x/DZHz64nga8urbtHA1qjxXyPwGnC2ZSZudCIMuckWv1eRPSEXWMuXOHlsYlos5WZLhYNpmHjKtiyvR/M+JNUvP1bvX+Qkp0EoqZrbkSwWb2XX0X/owbykbOm3zjhJlSRiZFPJiDg+zvrWXGnbov2gcbgggNwcFJVGhVRgrIX2XUjwMykWYOcLWZMEuV7ZVicrtCxE0Sq0fiEuDKG7BqWRHOeFOpO+GZyIv/z0cEihUdUlIQelppcvzUodEjRMKM7IjocGxbmEhQYxkaoKy3RX3uqo618wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGgJ1DXvPKmaoqwqFjznkwpDF2CYaTF/JlUo7/BsslU=;
 b=KamWJeclDGYQgn1by9w0uetHjmQH60Ruv21Go6u5Xo8ENlJzaEzWEY+PSa8Gyue7or5bkAIIfWimekNDmoMnkFiCVND/+8Sl5ZTh62zS63+MtnRqwiIZ/Q3RXINFkLVKXZs670powHp209l23G+VYfOSuIWrRPGuKIVblnyqwV4=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9691.eurprd04.prod.outlook.com (2603:10a6:20b:4f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 14:57:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 14:57:38 +0000
Date: Tue, 26 Mar 2024 10:57:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: will@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, mike.leach@linaro.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v8 8/8] perf vendor events arm64:: Add i.MX93 DDR
 Performance Monitor metrics
Message-ID: <ZgLiV8/1Pox1zSqa@lizhi-Precision-Tower-5810>
References: <20240322063930.749126-1-xu.yang_2@nxp.com>
 <20240322063930.749126-8-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322063930.749126-8-xu.yang_2@nxp.com>
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9691:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pq0QWtjBcD541uEBJp3gbftyE6RKk9OTGa6rwNvsVo+nRRAFkKHIN49+zOcK4tLxkbY+HcQ1I5KuXM4khDJaxeUBWlDbYiOTrWTnmGT+ME5BV0s5h1jy0gfMY464ZcNMG8zfjM7MC6L8cSO2NFHKoR3OOeRWOvBYu/KGM0X3hEDQQWtun50KdH6omN9rla4/07G7ohPAKfnsVwioQMfEnpVO6JQ5GAAtVQc2ehfaHFxd3RhiTlH+13nqITM9iBlksU5tHCMA6OD+7AFcIRoBEoCnERT0M8YARST8wnXPiqxjtPE2Xz4IOFjqz/w7fM6oix3JHmMicCXu+F6dcSL45pO0wrJcBm26KqsKhKSp1VVj73rkYwDW3goqk7U0rR73Wezp4csvwvBAhHSZ/j2BrAfFZatLIWdATb/LYS0UzORvWidh9Ld0zF2ITA6+30QcfAxAnxwkWQ2BAJj3MbdrdyNkxJZoJYVGVY4JNOjwyT9tUJWUgM1L0k41MGFP1t4Z2ajtuFAMQIRzmSo6Xso/xmBF7ZQJopI/YCa6gKsVBLjSBh9JLcaaMapLSHuwbF1+Ls2QNIwMrOU8Zvop0zdrMraPTgBgOspZ5GWyeoVi191YIv5SNljCBOeSdV4tdRbnNYfzqcqyQ7HkXBKj8ugqff6RiP/XhCc1Cf+I23jzQuozVKD0EW7vlbqO7fNiRYGSzu70ezn5nkFxWhY3YAkHXw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4KKMZb0h0XlhvUNNK+WzBsu2ExGibBHONcTgzgIqeBc1nKNBhRqodG3tOSP5?=
 =?us-ascii?Q?1Y9t8ddUSvPPW95YpSKmM3kfW+/ryQ7p1R0kr/RqZM/9phyjxo3dZyS5i2iK?=
 =?us-ascii?Q?edF5iluGCh0v6rLA2zNlxuDTW5uA7qM1SAOBcsXLQuu1GTJCv4pG/n/aujjV?=
 =?us-ascii?Q?vBulUenM8i8MsWrbxE8BSDlvF7bxZSRGxsWP73jSEpGKsa2Jquk+1fUmDhQI?=
 =?us-ascii?Q?/akisx+/o8AxMyZOSu3cs+UyocB3ir7TtvvN5bYBD4SMPMXSwbibULjNJ8m9?=
 =?us-ascii?Q?v93NFKnNxZJ2RajyKdLef+vxR5Bv21NTOO6zPtE2y3bSQDGLXntGeSFpAxPE?=
 =?us-ascii?Q?sjD5jeHDwIufgzRG928UgVyouBly8oD8T2oGJMXD5GOhu9VJrv3C/Dj3om4e?=
 =?us-ascii?Q?glbAjsepy3nUdZWLdQ9EF0tCg3+28Qy+Xe2kQ/wRPuITnsAg+QLCSXvw1Y6j?=
 =?us-ascii?Q?+fi587+5R05dhzB+ZNDRWYnv/5PkRqvtUVEZu6gcmlX0x+hHGJS+P0iPgnO1?=
 =?us-ascii?Q?/WY6XxyWKlZcmbGMWPyl8cZM3oJLnN8PG45/ggGQNF1bGpXS11SFw4VWTyou?=
 =?us-ascii?Q?5WvjsxWHSlsfXm0uy9EhKyZxHW7oswvxOJnMbCFRHlZlWRqXIqSNihVwEa04?=
 =?us-ascii?Q?vUPQQMM1BS4/bBWSNrZYIfuuMrNhrhgjl5o4hfTgP+ds7j5fZhxO+4Yg3xA5?=
 =?us-ascii?Q?Md3gHkwyaDPA9QoLEze2ya3uV2fBNtiCRNg6bLEm1uQPzamQrqYCC6mP6E8Z?=
 =?us-ascii?Q?yTbqnoEIgy8DrQM0RN1GYrDgGA1uupDxtmMkkASoIz9/dipcmSC3V3vDZRQ1?=
 =?us-ascii?Q?L2RpNbIXn2/r7M9WRNRSuCFCwnNJW0LAapaOrYgqopAIFcfVAlOa+5VMeXrq?=
 =?us-ascii?Q?kcDRrpLwhf+TdXoIuZxWUSc9PwVrJSsP8L53I7VMLyoENxVVa7CcSr3F7fhk?=
 =?us-ascii?Q?iT0Om+l44a7CNKkBomn7GuxrDI4x0x8UL7/sw5oFeAgbVGowU8SlFnp5e9oV?=
 =?us-ascii?Q?Qs21kV0nU8NICQf5TkEXOizu1mPnkzoYKsZuHmxrYOz1wJ6DdnF6nzngfuwf?=
 =?us-ascii?Q?07JSVJ7YcBsaSbvqJ9g9dOREkBSLhEHCYP6gmt8Lffpsw1BOAKm/AMm5pijL?=
 =?us-ascii?Q?43c/C7so34pfjM3IIxCUoL2DUlmAREQFUQsm6DcFD0PK5paaNiuYYmdh8rLs?=
 =?us-ascii?Q?flbW4dIaZ53FXXBjrHdf3d+ixJYNoZqo93+143q9WWEfx6jrDz29ANwoAfS5?=
 =?us-ascii?Q?dfuBlk4fslhILQCwbyTzBFnozNj807T42n9SREU9bMe6ltm+9s1Skeq353nQ?=
 =?us-ascii?Q?fksyItw86jDv63BsMqPmkp7eeOFQISZblUEfT50GhpXHhLzCNuqGDsnv1AML?=
 =?us-ascii?Q?gvPrxcfOIF/X2VjC0vMvu9oY8QIXtWT2j8HyXVAR1KFxVEQyCmVMdGUXEY1c?=
 =?us-ascii?Q?ipHEU35UUksMmUop/hztRHOGVXI5w2KEKboBmbKZUeNXJT4sm51HmeQmjujM?=
 =?us-ascii?Q?2LfGzto7oO9s2xs8zr4nL/IOP3zauFDo2BJnepB8IGc6lkXOU71rtNDHh7zD?=
 =?us-ascii?Q?gtROKMfSrH7IV/onk264t8fetiWT1DoNbxAntEyu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee85c27-6a04-452d-8bc4-08dc4da513e5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:57:37.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yW4jHWw66YMfEE4Z+TKf7fTRjeLuX5fpqCGmuAStHHAFnt7AFGDzqCWNJrEHRBQvotQMqI8M5g2/laENHow81w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9691

On Fri, Mar 22, 2024 at 02:39:30PM +0800, Xu Yang wrote:
> Add JSON metrics for i.MX93 DDR Performance Monitor.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> 
> ---
> Changes in v7:
>  - new patch
> Changes in v8:
>  - no changes
> ---
>  .../arch/arm64/freescale/imx93/sys/ddrc.json  |  9 +++++++
>  .../arm64/freescale/imx93/sys/metrics.json    | 26 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
> new file mode 100644
> index 000000000000..eeeae4d49fce
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
> @@ -0,0 +1,9 @@
> +[
> +   {
> +           "BriefDescription": "ddr cycles event",
> +           "EventCode": "0x00",
> +           "EventName": "imx93_ddr.cycles",
> +           "Unit": "imx9_ddr",
> +           "Compat": "imx93"
> +   }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
> new file mode 100644
> index 000000000000..4d2454ca1259
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
> @@ -0,0 +1,26 @@
> +[
> +   {
> +	    "BriefDescription": "bandwidth usage for lpddr4x evk board",
> +	    "MetricName": "imx93_bandwidth_usage.lpddr4x",
> +	    "MetricExpr": "(((( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8 ) + (( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32 )) / duration_time) / (3733 * 1000000 * 2)",
> +	    "ScaleUnit": "1e2%",
> +	    "Unit": "imx9_ddr",
> +	    "Compat": "imx93"
> +   },
> +   {
> +	    "BriefDescription": "bytes all masters read from ddr",
> +	    "MetricName": "imx93_ddr_read.all",
> +	    "MetricExpr": "( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8",
> +	    "ScaleUnit": "9.765625e-4KB",
> +	    "Unit": "imx9_ddr",
> +	    "Compat": "imx93"
> +   },
> +   {
> +	    "BriefDescription": "bytes all masters write to ddr",
> +	    "MetricName": "imx93_ddr_write.all",
> +	    "MetricExpr": "( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32",
> +	    "ScaleUnit": "9.765625e-4KB",
> +	    "Unit": "imx9_ddr",
> +	    "Compat": "imx93"
> +   }
> +]
> -- 
> 2.34.1
> 

