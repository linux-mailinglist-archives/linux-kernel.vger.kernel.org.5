Return-Path: <linux-kernel+bounces-33870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1CB8370FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84ECEB33E31
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60045B21D;
	Mon, 22 Jan 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="On2MBdA4"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC823CF4A;
	Mon, 22 Jan 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945868; cv=fail; b=KW0uszHSnfNyQgCNKqf2pao+sbWUJ0VExDka6iVN/rTxFjGDnK9d9W3ivYF7hCoRoiZ7O5C+6XduiZyufizuNF6u3v+2Vu+5sZ3LUCt+Ax6/lpLLA2lrDB0m3KsWjWR4+9SXtNrqA11UlMaIGiOBWAyxJxbzxmzgxBaFfrLp+0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945868; c=relaxed/simple;
	bh=DwsYRO/g2M8Z7iDRD2TuA8AK08+8V7fBlInSidmFawQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WjVjfQP50Ie0BO/5GM5/+tFCn7hjw5K5UV0RDlMwE4LJ7kyw59WwcqbFrgx0ARk+rlSTuweOjUXkPFfyQ5yyKHAmwX2fI9966d61/Ln8k7t4wyA06HTPkIZio1z/+maI+M7acn7c2hzexEQwJK2ze6C2iKk3IhuII6Am6LJoIDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=On2MBdA4; arc=fail smtp.client-ip=40.107.15.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmDno1fKubZquRvR7EN6kIv0FwBcc/GnJ5TuKcAdONKfLJmhdm44wsr3/wh5487ypz56Yc/+Keqmxg+vfOiu7/THTSzEBH28Nls53NFSGqnrBT8gdJv2V4i6PsMe4u8OyZvLBzDkadCtRyTRbX3jU6mJGR59BFgn7Uov+DLMkcaExK7pZBL4y//uK4zCEyaWHSfQtsZF8w8E9VvnkLkSCRtIHFhBrG5+MQUGPAMoOqyeno7awst0MEBTbxs2BE6azlN2vph6s5w9oXpA5IjFBYCR/MTDm4ZHOkxyovQWf3Sm7QFU4lW7uj0izUBCrAn+j3NAakhPNF8rXX3SmIug1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVwcPyhFOJQGFurX/hObDbanc20JMI7T1kMjCKnBHT8=;
 b=SRlbJsmUhLHG3g+vUz9HfbzVYxXCC9ffgJqF+/U/ZVYBf5U0rh16McIWr1k6CsOZWAgqs0lEfhEAaPx/qvzWux0yICd9rHKkDpUjAmLThZdhamvbXipWrmgJwBpFE0HTkrfXdFaAtFQbdImQsRabw9V8++82Q1ROlEwXzBgkWNku4U4OR215ps6EacTW58U2j5p9f7hiH1v5QkuAZeDSHWGJl4r9YpN09nN7yX0xAN6jn8m5/3jPmYQg/U0QMqTVz9NqiWJ1W3yTR6LloddYv1L5mfi1KlyVH2kq4E+CDQbjRoR3KekWaf1xLOmSQ6GYalSRcUlBbZ4EuOsORo9uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVwcPyhFOJQGFurX/hObDbanc20JMI7T1kMjCKnBHT8=;
 b=On2MBdA4GuFI03AfVusLXRjaYU+Uq7DaAWDNzCKArgQ8cmly3KcC3Dt7O0yoAlL+9x+5u9qntx8kLsVQP4CzEw1k9POUblyspB8DZ8pASG7kjq0HAzT+Rd7pQJjXFBGhE6iLWDTZfbs37cT6XJ/PoXhlgoh9yVfjKTBLNujzvIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 17:51:01 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f2fa:645a:969:6743]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f2fa:645a:969:6743%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 17:51:01 +0000
Message-ID: <87801f3e-b7ce-46ba-9856-1321635a11b5@nxp.com>
Date: Mon, 22 Jan 2024 19:50:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] remoteproc: imx_rproc: Convert to
 dev_pm_domain_attach|detach_list()
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Nikunj Kela <nkela@quicinc.com>,
 Prasad Sodagudi <psodagud@quicinc.com>, Stephan Gerhold
 <stephan@gerhold.net>, Ben Horgan <Ben.Horgan@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, linux-media@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>
References: <20240105160103.183092-1-ulf.hansson@linaro.org>
 <20240105160103.183092-4-ulf.hansson@linaro.org>
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20240105160103.183092-4-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::8) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|VI1PR04MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: f1761e12-b04d-4cc6-5e08-08dc1b72b22a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	upPxQyPpERs4Zp5ZMBzAW4EPs5WvOhqPjipOEyQSOKule7Cyt2yGZQ+jR9fdON4/LRMONVdZSmCYWN0LwQIiCH5M4y8uPPu3xPgjl2Oqi0TIp4JSkv0JS3/ocBDf4C/3kQ+YifqW7h5KFK8h4SQhbVUbzvltCLdXiqgZAgpJwYXjTM3ONdNHJYGcZBBsgqJpQ8Rg/sZGR8OhdZOWgQHj9IrsvXRESwLgNInoD2n03k4hNbtnhp4E1Bphg9vbxxIAck4Qtjbp7XFh58v9irrmza50RcnAVeHPGUZqOw3Qui/YU4qAdiPAm4zMC9lK8qL6rgevsgu+HauMMtmSDRhuRac22I7RJXLf5aJDWumzTQ+QpGSmQTS0+kFZBKVkjl2BbZ8we1I9sKjrq8/csc7FtghFyrrJaCGysXGRE0Nw+Anicufeu6ydIldCc6KEo2rcdkk9q2InMay0eWPgFmFE4yrDJc1QohpqlmOBz15xBCoyki7fqtCLJ6sCfgptHTEqmuRjehEdVpuuSHRqlTRD4njIGjSE2rbtx8WHXG299LpDz8NNBGkp+/2UbQZZi9XQPfwSA2wyClvywDOydzD2x0pY1SH5aX3KxICq5vYiHaWPVjn1mOvROtTT7z9MNXmf1x6sDVtEGkGbp1jVB0jGAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2616005)(6512007)(6506007)(53546011)(26005)(38100700002)(31696002)(86362001)(36756003)(41300700001)(2906002)(44832011)(8936002)(4326008)(6486002)(83380400001)(5660300002)(7416002)(8676002)(478600001)(316002)(54906003)(110136005)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU1WU3VHOG0ycXFkVmpKVDU2ZThpczlwRktVay9hM2dIV0dkNXVuTmdJOE1o?=
 =?utf-8?B?RDdiSFFjVjg4UUdIVDVGbGtRTzZDWUFqdnkwUndkNEZhWFlPaVVQUHNaN2tu?=
 =?utf-8?B?TWYvNkRJU1k1L2pRRVNYaWJabGNYWVRqYU1PQm9JYzJKbVkxRlRWYmhCTjJE?=
 =?utf-8?B?QXlnM0FKSkd0QVl2NmUwZmNxN2RWdmw1RzZFWC8yYms1WkhzcnM1K24yUENS?=
 =?utf-8?B?NXMrTnl4Q0xnbklLNXZqYnQvejNvZVUzb1dxVER1WGRITDFNMEpsZlNVamJV?=
 =?utf-8?B?Yy90enJPMTFTSHA3RUZ6cVNHWWk5MG9UWG9WOFdUOVZHUzJvK3kxNGk2dWVQ?=
 =?utf-8?B?YkExWWZtRDU5MElGRmVTcTNBUG05Q3hRVExxYTBUS2lzb1lnWVlaclVJTzFV?=
 =?utf-8?B?bGdtNkEwbURhUUJMemFMbGhKeEVMczh5eE5GNkoreWtNdzVVVGo3Y0JMRElj?=
 =?utf-8?B?TGRFSUFMT0srL0txUjRqOFUwVnFTN2RkU09TTDFpMDFmRS9QanhVQmpsY2ll?=
 =?utf-8?B?aUdGb3VEaXdOZE9KN2FRZkY2YWttbWprTjE0WEgzSWVGZ0RzTHZ2U0w4WE1B?=
 =?utf-8?B?eWJ2ZGhDT1N3cEUwU0dYbkR2bFhxbmFNdHFlcmJWL3hzRXNHSXBRa28rQXcz?=
 =?utf-8?B?OUlUVUV1R0ZNdVcreDZxN3FrNnh0cTJiakY4dkVMOHY5cVR5Nm0zUlNHR2Qv?=
 =?utf-8?B?Z01TVCtUTlV3STBDQWVXckxCbXpiR1BSOUVINEFuMjlCSFVmSVp4eFg0cm1K?=
 =?utf-8?B?a2R1Umo4aTVzVEZ2MDZGd0FDVXBXY3k2bzFlU1QvKzNIaTgzUm5YSTUrMzlR?=
 =?utf-8?B?S2VIaVp4bVgrL1Y0ekd6NE5KR0R5eCtlcHR2c2lsUThrWHhsWXEzUHBkZHFq?=
 =?utf-8?B?VDRkaTJkUTVSa3JwbVBXVVZxc0dxbnhhc1NtN01QRENJSnBpQUd2V3VocXVq?=
 =?utf-8?B?WHFTL2xrQWxTVFZFTDhHbmRCYWF6clhHYW9GeEkxelczR0ZSL1RvZ0ozUmgy?=
 =?utf-8?B?MDNJQnFYaS8yK2VCU0JFNyt1Sll1dkpKcmRDK1dXRXA4QVBLOVZlQlltZzBU?=
 =?utf-8?B?ck5ZbVVSS1R3SEdiNTQwWXBHL3pwNUhZbWdiTE5VaEhtSmtYM0NyTk1jTGtw?=
 =?utf-8?B?UGdRWXA5UC9vdU8yUUFJN0xkSTRTZWRlbEhRTzJmNERHM3BXREZOWlRFOHhX?=
 =?utf-8?B?QmI0WEphdnpoeEtYbklIU280UVM2OCtubmpkNFV0cnY4ektpK3BCRmZnd2Yv?=
 =?utf-8?B?MmlhdzllTmpneUk0S3FMRXAyMXhjSUw4L1cvbXpzWCtKb3ZmbFc3cE5hbnVT?=
 =?utf-8?B?anFydHlWaGpoU1lSMjk5N1FISlkvUE5Ua2RLUUx0b1l6Y1F4bTRFTlYvdm5G?=
 =?utf-8?B?Um00cTVVb3F0Y05Fc2pXY1ovcDVtKzhVcVV1WGRvdmtSMjRFbE8rOHBYY0Vq?=
 =?utf-8?B?Vnh4dmFLOUZzM1BqQmZEYW52L0hqVjNvbU8zNnlyTVFSWXdLbFpkNm42RUFE?=
 =?utf-8?B?ejB4N1hLbnVnOXVoY1ZseGlPWXAzT09sS0kwSUVEbFZIZktUL2o2MWxST2du?=
 =?utf-8?B?OG5iY0tleElIREZHVVYvVmlNZTBmc0lJMEV5K0NBejFKQm9jQ3ljc05nYVJr?=
 =?utf-8?B?VVNrWDR1WXdmV015QytlVENhRzVWdURKRWE2Mi9YcE1SZHdkM0VveUI0bEpN?=
 =?utf-8?B?VzBqMHRTQkFBay9lekRhWGgzMEJOektEQjZZbVpaYklPd3VoU2hLK1FKdnR5?=
 =?utf-8?B?dWVKNVdINURkMHFXOTVrN3UxblVtUHVlclVReENjbUk1VCtENFliTTR5SlRU?=
 =?utf-8?B?SFJ6L3ZkOEpvcG4zclFnSFRaQi93N3Z5YjJFYWpkRjFRZ3RwVC8xRUsyTzlp?=
 =?utf-8?B?bXliYVhzS3VuNi9JTXpxbjFvRWJEcWF6Ri9FbXljNE92RkZtTVdSalpQLzgy?=
 =?utf-8?B?V1hyZXV3Q0ZYMFk2NklZZEFwa3pkd2lBeGFZSmQzY203WmJUU0ZFUmNGNnNh?=
 =?utf-8?B?dGNUOVJucHFpdjRESmhDTlpyM3Fra2RQbDVOcGMrMW5rUFlzZlQ2ZE5vcUIx?=
 =?utf-8?B?Y0NTZUNFNXFPMmdZbkQ2dDNsNzFMWEVwY1ZCbnp6VWhTWk4xRzhnbjA4OHkx?=
 =?utf-8?B?ZHVIeEp1YU9LRlBMT1h4VGFoVFhvaXAxTEtLTVZkaHVCWWl4TlNmYWovWTZx?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1761e12-b04d-4cc6-5e08-08dc1b72b22a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 17:51:01.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JKMfc8YX5X9iEL8BulbZJQjghIU+OqWQhNJ9fw6Pg4/gDf2yOfhTl7FtCpgBIxqAwLIQ2Y998PTtqF5m0DkRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197

On 1/5/2024 6:01 PM, Ulf Hansson wrote:
> Let's avoid the boilerplate code to manage the multiple PM domain case, by
> converting into using dev_pm_domain_attach|detach_list().
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: <linux-remoteproc@vger.kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
> 	- None.
>
> Iuliana/Daniel I am ccing you to request help with test/review of this change.
> Note that, you will need patch 1/5 in the series too, to be able to test this.
>
> Kind regards
> Ulf Hansson

Tested-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Iulia

> ---
>   drivers/remoteproc/imx_rproc.c | 73 +++++-----------------------------
>   1 file changed, 9 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 8bb293b9f327..3161f14442bc 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -92,7 +92,6 @@ struct imx_rproc_mem {
>   
>   static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
>   static void imx_rproc_free_mbox(struct rproc *rproc);
> -static int imx_rproc_detach_pd(struct rproc *rproc);
>   
>   struct imx_rproc {
>   	struct device			*dev;
> @@ -113,10 +112,8 @@ struct imx_rproc {
>   	u32				rproc_pt;	/* partition id */
>   	u32				rsrc_id;	/* resource id */
>   	u32				entry;		/* cpu start address */
> -	int                             num_pd;
>   	u32				core_index;
> -	struct device                   **pd_dev;
> -	struct device_link              **pd_dev_link;
> +	struct dev_pm_domain_list	*pd_list;
>   };
>   
>   static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> @@ -853,7 +850,7 @@ static void imx_rproc_put_scu(struct rproc *rproc)
>   		return;
>   
>   	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
> -		imx_rproc_detach_pd(rproc);
> +		dev_pm_domain_detach_list(priv->pd_list);
>   		return;
>   	}
>   
> @@ -880,72 +877,20 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
>   static int imx_rproc_attach_pd(struct imx_rproc *priv)
>   {
>   	struct device *dev = priv->dev;
> -	int ret, i;
> -
> -	/*
> -	 * If there is only one power-domain entry, the platform driver framework
> -	 * will handle it, no need handle it in this driver.
> -	 */
> -	priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> -						  "#power-domain-cells");
> -	if (priv->num_pd <= 1)
> -		return 0;
> -
> -	priv->pd_dev = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev), GFP_KERNEL);
> -	if (!priv->pd_dev)
> -		return -ENOMEM;
> -
> -	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev_link),
> -					       GFP_KERNEL);
> -
> -	if (!priv->pd_dev_link)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < priv->num_pd; i++) {
> -		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
> -		if (IS_ERR(priv->pd_dev[i])) {
> -			ret = PTR_ERR(priv->pd_dev[i]);
> -			goto detach_pd;
> -		}
> -
> -		priv->pd_dev_link[i] = device_link_add(dev, priv->pd_dev[i], DL_FLAG_STATELESS |
> -						       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
> -		if (!priv->pd_dev_link[i]) {
> -			dev_pm_domain_detach(priv->pd_dev[i], false);
> -			ret = -EINVAL;
> -			goto detach_pd;
> -		}
> -	}
> -
> -	return 0;
> -
> -detach_pd:
> -	while (--i >= 0) {
> -		device_link_del(priv->pd_dev_link[i]);
> -		dev_pm_domain_detach(priv->pd_dev[i], false);
> -	}
> -
> -	return ret;
> -}
> -
> -static int imx_rproc_detach_pd(struct rproc *rproc)
> -{
> -	struct imx_rproc *priv = rproc->priv;
> -	int i;
> +	int ret;
> +	struct dev_pm_domain_attach_data pd_data = {
> +		.pd_flags = PD_FLAG_DEV_LINK_ON,
> +	};
>   
>   	/*
>   	 * If there is only one power-domain entry, the platform driver framework
>   	 * will handle it, no need handle it in this driver.
>   	 */
> -	if (priv->num_pd <= 1)
> +	if (dev->pm_domain)
>   		return 0;
>   
> -	for (i = 0; i < priv->num_pd; i++) {
> -		device_link_del(priv->pd_dev_link[i]);
> -		dev_pm_domain_detach(priv->pd_dev[i], false);
> -	}
> -
> -	return 0;
> +	ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> +	return ret < 0 ? ret : 0;
>   }
>   
>   static int imx_rproc_detect_mode(struct imx_rproc *priv)

