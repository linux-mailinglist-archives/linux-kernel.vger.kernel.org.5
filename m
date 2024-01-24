Return-Path: <linux-kernel+bounces-37730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462883B486
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1062B284707
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC81135A46;
	Wed, 24 Jan 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K9mlkgtU"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A9135A41;
	Wed, 24 Jan 2024 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134318; cv=fail; b=DcFmLsF3jcNkRyRT7GWSIol4egEhEaiIqddcwxuiX8jHObgC/27dI2zEQZhCyG1JnoKGoGl3Y1pE7z4kyzJSKDnmg+GkKqL8XTeFQ28/cMAtNbEDnxl7ux/ZXBPZ3+39wrmF8RcSgaFNe59tKJbcCT+iiH2ww+aAIB6t8JBT2ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134318; c=relaxed/simple;
	bh=snFMG98KC0TyLNYBPSrJDnDMvVRd9aHEONdzfSxZqUQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FH5UmsU8ky4QZl1YIbtUNWEf8Jb3FXKI/+w97d1WjdBCz5F4hRIXarq+3frMz1iv4pzKEAYHFu2D5jatR9T4b53yNx/LrZbOX52t8VxM3xUBkiJkw94T7l3zYVEbXtDjdCE/dzPWFrOOWJ0DSH3++Pyit71LPMsb2Vc12+/kD5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K9mlkgtU; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgFbKipT3AAOjOllWWOGI6vSJyh/VUeY/6JVFj63oC5Bf+NifPjEIAl15IYrU+zOMSkVaUC61toZBEBDZ8cQIKMcrPKIE2EwpD1H1u85qX9rKV2kOVdU8VtdZpttZTYVTeLRXKiEWPAgRUOzmjVDQXNYK9Vr+VG5HO3NMmc6jc8bqSCDrJjLBV6LkJRbEb+cqRnv5a33YWjcN9wXjsnNw20vvr3K+sQ/ZtjExqI2lb7z31lDBJ2Vg9Iz2W6R3saWVThNwB148bIfUsyUCSOzb83LcV0/4P45KtYxvwwwuRAMMEa/IOrfcmQss7p2WqoTzxyeJIgB+d7I8MiUJcx9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmNcg3fyaLuJXWDaHIbNdOOIA6nD0MphUsn5cDnGnQE=;
 b=ANm9xGZqSjOcPgO6IZoqM49zWLPXL0CWbkgj5n9iY/4c8+UwoY3ObaswQb2uJG54gHIM6hlovdU2hhJAeUzMVM1+DkvHBuxqrzzUORye13SObGg6obdX3n71pDjMtVZhm41pYbeq3CnUQgv2RLm5qFJYqVQmQqC/334uxOGXu6SfWRFTCQrEIC7vIwIJhlmVzhwtgToCg2bF0icxkm5fRgWGHrBfpbSLnpq16yd5c+8zcF0/nGKeARciiuNChRF8YXmAC7BlW5x0UVy4Gt43Jne81JSGX2v7biwZ4uoEJdBL3W9nFAC2DZ/Hul3SzJ4uwuUh4WCu50WCkPR3xlLgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmNcg3fyaLuJXWDaHIbNdOOIA6nD0MphUsn5cDnGnQE=;
 b=K9mlkgtU7fC1F0LcrdZ5IEpJSEWrqujH+TGbHtF3DCRgbZdEQXrP1I2bXPRs0x407iKi3XQzS9BoHE4aEUA5QU+1Hl7kY3ijy51f8P/Ow/wkZqf4gJCf5++3QmpKFbzuNfa1wB+AMtaJLIsW0ItVVJJW6fnyN6GAJLC69Y4J/xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DU2PR04MB8631.eurprd04.prod.outlook.com (2603:10a6:10:2de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Wed, 24 Jan
 2024 22:11:50 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f2fa:645a:969:6743]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f2fa:645a:969:6743%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 22:11:50 +0000
Message-ID: <04ea2835-518a-4829-b70a-66043c3acf0e@nxp.com>
Date: Thu, 25 Jan 2024 00:11:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] remoteproc: imx_dsp_rproc: Use devm_rproc_alloc()
 helper
To: Andrew Davis <afd@ti.com>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-remoteproc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240123184632.725054-1-afd@ti.com>
Content-Language: en-US
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20240123184632.725054-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::12) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|DU2PR04MB8631:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcac9d7-fbd1-48b3-7909-08dc1d2976c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v3wxjInrRxVX29UDtcOweR2LFd2QS43DXbgVH367qu6NUPAZVRIOJIx8F8arzkSOU4VYGF1e+47XtYSmjbYhDxUdofWjwmR4z18kJXtsCKzEVPH0dUO7x27mUt/JiCYFOl5hU2xV1G1P6MtOfu6CzU7qxwx/2TkdAz6LXNmkjIqDfOcC5ad0CcFGbc9cPCb1z1YhaXBONaNmuG4ZtVJjxaYQY6nEDI7CHKeTL4pTOndRKloUlozZP4ln+1eCNMS8CMN2r1K7WAze0jwoFV2RulTvbbofVmrdD3+m55CuLBGsrK3uq32Ya8ojsNhkHZ+ThcMSbVZ3sFxUBeLXTuf2iIt+iibNGO7eO/CA6hIYCG/T2ulZS5dt8F/I+fRi97ibavEKOIiSfSz2LXD4HhIOJPbcZyR/Ai+gRzMxdHcRtQqUJUl8xvZqDMwKTjS2DrbOOn9wgCj5B0kIvdUCZsihAPxwU4JGnbIpuCDh7wrUNIk6Z7DAkM8HUJtMIE48AcWBwRp6fMSNUMbuI2x9odCcz+nGQen1fJ664VnPJsRKFs+QrtDs4MFBhNTAS1BtQ4S7aSX8gZ1Ql8Tr8OasF9r0Zk0HZL1YxDUWiCmtmZoYSoDAu+ijjWpjTlvaYs3k/QNEJHvHdRU5SO4E27j0ENxhb7PSpHvr8HT/IF4pjpap3x8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(8676002)(8936002)(4326008)(44832011)(2906002)(7416002)(5660300002)(31696002)(86362001)(110136005)(66556008)(66946007)(66476007)(316002)(36756003)(6486002)(38100700002)(6506007)(53546011)(6512007)(478600001)(6666004)(83380400001)(26005)(2616005)(41300700001)(921011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L21FQXhPbzMzeVhUTXJqelBFdTk1U0RkYzdFTXVzWlBmQ1kreHdocmFNQ3JZ?=
 =?utf-8?B?dVo4YkIzaGRXaGJGZ0FGaWdlS29ORm8zOS8wNWR3Z3BMa3NqSnF3Q3h4ZHJR?=
 =?utf-8?B?WlVJN0ZqeVF6c2hqYXFDU3I0RTVQSzh5aVN0UjFkQk9NQ1ZDWTR6M2tZMmJY?=
 =?utf-8?B?bDZDTS80eW4vVTZJSEg3ZFZQVmQ0QU9FSW1pNTN6QXoxQlRJMTlWdTUwdHRJ?=
 =?utf-8?B?OEY2RzFpZ0ZmSGdGQ092QnhQcmErWWlJcHEyL3VJTUxYcHN3eUpNdENMNGlk?=
 =?utf-8?B?M3pVRE8ybkZmRDM0TkVvTkRkV0lYRG9jWWFxZGFJdGlNSVFqYytkbWh1VmpK?=
 =?utf-8?B?YWo2V1JaUERZcno3TUJwcVozd3BlamM4bGE4OGFZQjFpdG5hcWdsUTF5YUdv?=
 =?utf-8?B?ZU5MeHFVeVpDTXpLMWdQK0VaMWh5cnF4c1B5YUNpeTZhREdSRlVqc051K0xO?=
 =?utf-8?B?MzRTbmdXZzE4aDdkUnh4cmRhMURSNjhEbWNHQllWeWxFQytSUEhVSUIwK1hG?=
 =?utf-8?B?clZYaTNMdTJUNmgzWmNEclEwZGFLeWlpa3JsbEpocW11QnFYZjFzYWxTT0ZC?=
 =?utf-8?B?dDZhT1U5R2V5b1RBa0tlVHdwOTBqUkRLMkxXOGw1TGJ5K3dhR08ya3RxWXYr?=
 =?utf-8?B?eFljd1VSNVpldVhXd3VrVXM4RFhTWDd2dmdNL25MV1hkTlRkNGlpUXMvQThY?=
 =?utf-8?B?a1dYQ2NFR3lVQnBNMEhPSVFNSjdDdkhhakxONTNpTmJyY2FYZndLS3VFVmZV?=
 =?utf-8?B?TzB5a1UzdXUzdTZOdWNBN21ZSjRxbVJxR25Sei85UnUrYUM3NlFsTVY2cGRG?=
 =?utf-8?B?TnVJbEJ3dkpUWXd2RTE2VUJPemR2Y0JUYmo2ZTdCbDNTTzJ3NkFCRE5vYkNU?=
 =?utf-8?B?Tzdxbm85Vy9pb0l2R3BOSld4RXc3bWtXNytLSnRYSk83SGxNbGRXSU9PVjVZ?=
 =?utf-8?B?Q3d1UkxQZ3VDTnlZSGJRdklWR3lWT3lUZW5lak84VHd1RlpwV2ZMZFFmdHFN?=
 =?utf-8?B?YXBrUVk1ZnBCZTcvUWhWOGhobHJScGlFWVA3WHhFM21ON0JkcDIwMlp0U1dE?=
 =?utf-8?B?QWo1SmppT21QQ09zS3BJZW1EeGs5ck40cTRFV1lMcm9OY3Z2c0JLa05kRW1F?=
 =?utf-8?B?cHJRWjdNdnZxY0Z6QVNuYW5TN0pEM2o1eUpFVG9GdlVicFVGdE1LQkhBUzZJ?=
 =?utf-8?B?SERXUEU2alg5NWZKRUU3ZkJKREVhbEJPRDNQM3MrQlJ5Ni9mZ0dVU2k0RzV3?=
 =?utf-8?B?MzNsejRneVU3cWR4UDViMzVQVGw3OStadTBkcjJBbTZCQ1o4KzZWQjEyOWt0?=
 =?utf-8?B?ak5MM2RsYXh2cXZnSVZtVVVjWWpxMlpIU3dveXFlRmwyR3Y3aHQ3MS9HbWZ5?=
 =?utf-8?B?TUxTN2JYY3FycEVjWm9WOEcwM0RGQzZ6U1FtdnAzUXREU3A0WXpzcm5hSVNZ?=
 =?utf-8?B?d0hwZU45RTE2NXR0TGNheFhJaVd3Y2VJSDZReWdIRGJqazJyOStGME5jWEpQ?=
 =?utf-8?B?RXF0Vm9CbGFBei9BZE0rSjRXYXNuQXVOR1Fkb2djc3NvSm4yTEVkZkR0R1c2?=
 =?utf-8?B?ZUlIM1ZMSVJRditCNHhRM0gweEVpeFE4YWZTQlZnOFBRMmVDb3pFRnZlczlL?=
 =?utf-8?B?TGY5eW1kNmoxa0U5QlZEY29WZG1TWXd0ZktuODZCNE5oZXBGRmJPbXMzejRK?=
 =?utf-8?B?MnZNY1R3cmtGNGNDak1iaEYySTc0OGYwck5nUlExanRQdWpxQk9yVVNKQmdN?=
 =?utf-8?B?dG1seTYxQ2VvN0VGb1h2VmVNRjRsMWRQZ3J2ZmMrZmFRU2Rpem9hMEVaRkov?=
 =?utf-8?B?SHA3NFYxVkhlSXJzTmUxcEpheG5SNTNVUkVlTExLK2pLNk9pS0lQa21DcHY4?=
 =?utf-8?B?c3UwOEd0TUQ0OW43RFFsU2ljLzJ3dmdnN0EzaVZEc0RiNkdpYzBWdWh6aTRI?=
 =?utf-8?B?M1ZzcnB6dG00Z3dLUEVWWXBvaGpnazFuejczUTBEYmN3akM0TVZiMVNUeGJJ?=
 =?utf-8?B?RVVLb0RoQXdHOVRoTUIyc3JiZVN4bGlBUWJFd2h6c1JnTzlaaGtZZ25OUzdY?=
 =?utf-8?B?SzNhZFpxcXR5ZW1nY2xzRFY4eTJjeWdPOTIrUHJHVjdzUmg3czVQR1NVcXdE?=
 =?utf-8?B?NEZaWENIZ1F5QzRuSWlyUVUyM2hFMTBXSVMyenI0R3c2QzNtUGt1RForRVNj?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcac9d7-fbd1-48b3-7909-08dc1d2976c1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 22:11:50.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPYkPXfJCj91ExEzXKwP02TKIWeufd7STbZPOKZxSsBd8mhE/b4PtBNMWYMEcMQ8FQqq9HHRM0LAjD3cwFv0rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8631

On 1/23/2024 8:46 PM, Andrew Davis wrote:
> Use the device lifecycle managed allocation function. This helps prevent
> mistakes like freeing out of order in cleanup functions and forgetting to
> free on error paths.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia

> ---
>   drivers/remoteproc/imx_dsp_rproc.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index a1c62d15f16c6..56a799cb8b363 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -1104,8 +1104,8 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	rproc = rproc_alloc(dev, "imx-dsp-rproc", &imx_dsp_rproc_ops, fw_name,
> -			    sizeof(*priv));
> +	rproc = devm_rproc_alloc(dev, "imx-dsp-rproc", &imx_dsp_rproc_ops,
> +				 fw_name, sizeof(*priv));
>   	if (!rproc)
>   		return -ENOMEM;
>   
> @@ -1125,14 +1125,14 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>   	ret = imx_dsp_rproc_detect_mode(priv);
>   	if (ret) {
>   		dev_err(dev, "failed on imx_dsp_rproc_detect_mode\n");
> -		goto err_put_rproc;
> +		return ret;
>   	}
>   
>   	/* There are multiple power domains required by DSP on some platform */
>   	ret = imx_dsp_attach_pm_domains(priv);
>   	if (ret) {
>   		dev_err(dev, "failed on imx_dsp_attach_pm_domains\n");
> -		goto err_put_rproc;
> +		return ret;
>   	}
>   	/* Get clocks */
>   	ret = imx_dsp_rproc_clk_get(priv);
> @@ -1155,8 +1155,6 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>   
>   err_detach_domains:
>   	imx_dsp_detach_pm_domains(priv);
> -err_put_rproc:
> -	rproc_free(rproc);
>   
>   	return ret;
>   }
> @@ -1169,7 +1167,6 @@ static void imx_dsp_rproc_remove(struct platform_device *pdev)
>   	pm_runtime_disable(&pdev->dev);
>   	rproc_del(rproc);
>   	imx_dsp_detach_pm_domains(priv);
> -	rproc_free(rproc);
>   }
>   
>   /* pm runtime functions */

