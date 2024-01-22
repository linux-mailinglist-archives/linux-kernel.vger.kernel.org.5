Return-Path: <linux-kernel+bounces-33867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEB1836FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E101F31F91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FAD4CDFF;
	Mon, 22 Jan 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PAFfBMic"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1C4CB2C;
	Mon, 22 Jan 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945836; cv=fail; b=nHiD7Coxle9l07lZmlIN+bvd3gFPYFRfz1BLY0Mf6+8FQpoeymoRgwv9XgnHiJVCL4W3pKTvyuP1WfPdi70zd+/CVtJ43nz6WZAvm+DBSvp62pZVqreNao7L6kjF8aTEK7NjFRYLJiFusTtN5kcFn+q6L57H6ehvNZWZXY8ca74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945836; c=relaxed/simple;
	bh=lLUemhez/PzCNjfpqmJnWassPtzVGZxOH1Egw6KsevU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BdSLAdvdV9dW0aNIASg7nY7H4mRgf+73ahQe5Ik5OF79wUBXq15bFPuUV1z789Kd2vQDDUWvkC+6XDF0jT3K84QqlJgNrsPksdS7/ypOYdio8glITMoham1Pto/wll4M6ypF+/3zr7qYcTylDR2j+6sauvWni5QQ/bQjMotVmFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PAFfBMic; arc=fail smtp.client-ip=40.107.15.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg2w2Pjxx9WPU34MQO5uJvVkymYDsiVOyO7EZvfnhD6CmS8UHc8NaY1cvmMjAbpxWxq6y1yJxMxWlb0ya1STZrKQn21AZMnZnLMMtZIzyTIOcdz5GtT+p1hFOV6FJVqpzazrl4RDmgGLr6B/hpX/JKFuw/v7D/4fakGd0SsorTvzgqNF3ijd4ylab4eb6xzz0kxdRQsFl5d5psIazmtQOAKYIIw7Ff6cbCimMpiSJpJgyqj8Ww/DhnavubP+7I46WwFR3KaOI2oHQ1GllHYSyPxE0l6Ysv/Z87jbZHwJnFznmQ2V3nYk7eNlfS6p2FCckmWPfU+lA8ckh6wxZg4wRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFia4hz1VJzuIeO+bvpx2NQPF2xfX8zkj9fZB5LAm3A=;
 b=WCPTSmgf21eTXNzxrlqbmEeCJe6Qn/VGzkROwAC1xmYAu79FIpgmahSKx5lamtATNr4HG/esGWIbPfqhl5iwSO4wJeFGhgf0w598VaIq0V+r4/mcj/TwAs/a8bhn85j6FSppf/+2p4GUpx4MUYRPbUmVd+jt9v335kDiGwoVlfptg8F/WRrVJizaG+ZVRlsRmCIGKmauXM10ODRXKDtlqgORu0ki5iNraPtI2/5Fvh4JO9YguOa7VXarhhtoaO2uVXZkBaEHJ0+H93uOXVvfXq+K8exSlGC+klgqMXBDX/JHl5/BLmCWzc0bhDAXlw06Lx7MoxLfj7jSspB2aKmNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFia4hz1VJzuIeO+bvpx2NQPF2xfX8zkj9fZB5LAm3A=;
 b=PAFfBMic7jmmfGVUTAQNuX1nfF8GZSaTzVX5l9yrHnqxd95DD3rU1qtucoJm7ju7ZZipIOcS6JEwPExc+cjEW8WNKOrM4XQrUnybbBZomvzaNaCAh24Gix07n4DQrW+by0SODp8DRxtDIjl+qYJ5whze8+9RYYEaG/ZUjCwde7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 17:50:31 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f2fa:645a:969:6743]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::f2fa:645a:969:6743%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 17:50:31 +0000
Message-ID: <c5d2f80b-e987-49bf-90b5-ee92bffa2f40@nxp.com>
Date: Mon, 22 Jan 2024 19:50:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] remoteproc: imx_dsp_rproc: Convert to
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
 <20240105160103.183092-3-ulf.hansson@linaro.org>
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20240105160103.183092-3-ulf.hansson@linaro.org>
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
X-MS-Office365-Filtering-Correlation-Id: 2eadeb86-e7bd-4e2a-ed6d-08dc1b72a089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EG7hmiVCX4B/+vgCiHkFvSTOE0e9D+fGV5EGZhH9nywCAqjREIFHi+qlBrfmHVFiIqnmhtprs68CZ5bA8ro5gEQ423UqsQKgRLXgVF2XVFV7E00UzgTInvTOfKp1F8J5LyVX6XHXD1xblPmRASlLdXwOQMgp744h4mAq1NDqp7iDVfO9hMw/eS87dm5idV4oABfJ1skUfJoDyRaFuR8fQtvB+ZFFbv4D6OjrSe8uLYqY4gJknYIXbob2wPwfaHI4hmQoMlOL9uEVbQshJuuEJ4MuP5RwjYuFZpcWDNTh+254+XQpMpupBuEtBe7g+DflgTs2LJD57Ja5NGwjgAHIgLLFUFj/735ZTz1h1Nvbe714NrRHsugmT46UeCfLiqbx8LRCl9PGQnbBaEcZl0BZFV4U6THKBCmpPi6S+OMvHFEscU2WmEceXROVl3esVvlsAIYPuX4LsMIhJmXIilkQvwD6jSO/jB9Zuq1+Vbjl3pMu4ZbW8KL8XrK0rJLa1v91lanYkSny9GeQEM6ylCH9kxLZzCxnuL9n8sIbPXW8Hih3ArljOQEEwndICMp6l9WmfINp0ka4Mr6V+L5FvTWHqsCV2alMVwt1ly8vF8tjEj4CERvHCX+JLPyLDZzklzou18WwN96roxZ6VR/iBoiOrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2616005)(6666004)(6512007)(6506007)(53546011)(26005)(38100700002)(31696002)(86362001)(36756003)(41300700001)(2906002)(44832011)(8936002)(4326008)(6486002)(83380400001)(5660300002)(7416002)(8676002)(478600001)(316002)(54906003)(110136005)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0Vnc3dTKzUwTjNpMXF4aGt5NDltVzhsUEtaWkpRV2JnUjJYMkt0UHJTdWZV?=
 =?utf-8?B?UUhlOFd2ZTNQSmRuZzg2VldKZWRRU2xVR25CS1JnWHJ6YXNNTmltcFdBY3Z2?=
 =?utf-8?B?czhJamhFMEJwSmNvT1R1aUltQkgwVmNWU09YUU52c2Zzdml0NWFzcDdvYjY4?=
 =?utf-8?B?R0dWZVNIWkpPdFUxMUpaeTZyd1Q2SGo3dFp2b2MvNGdHQ1dHWHRMc1crRWFm?=
 =?utf-8?B?ckZxQWhnNHkwSkxSN1VzZ2ZkbkJOREhRTVBYdGRUbll0NHl0TXdLMUpQQlZw?=
 =?utf-8?B?MWl4bWhkUUhOQ0xObTVnc0NjUEJBaXNkaXFNZGVLRFhOdXhJdndDUFVMYkJR?=
 =?utf-8?B?SlM0NjB4MUNrMHplWXNId09SbVlTdzY5QjdnOXZUZWtiY09KV0FLd3p2eEU3?=
 =?utf-8?B?b1BrN1RaMnNCcVRrU25PSEE4bHdveG52bjNBeEtDdVZob0VkT0VPcFRnWHFj?=
 =?utf-8?B?M0dlQjBmSHZSYmlmOVhBRE0rN05SUXNsRFhJWWNncTllK2RGQTVXcy9Gdm9w?=
 =?utf-8?B?aTkySzB2eS9VcHBJNjhGN1JCb2Z6UjhJQlY4WUxWSnBGWUlpQjAzRFkwVGZq?=
 =?utf-8?B?bjZnd3ZHRm5SZnJLQUg1NGZOU0VTL1hyS3VsWDBHaGFvaG9jQ1FiM1hNTFdz?=
 =?utf-8?B?MzNxbUkzVjJrNG9ScGU1M3NlK0VyUGNzYnlQQnI2UEN6UGZLRExuemJqQ3VW?=
 =?utf-8?B?ckg5bkxEV29iNGJQWlFhS0gyNHNZd25xZTJsbzgzMktDNmJsRnF5TTVCS0RT?=
 =?utf-8?B?cTEwN0V4c2dCeHpLUU9HZTZBeGl5Q29RY3VjUGJqN0VzSllWUStRem9QdGlE?=
 =?utf-8?B?K2ZSWkJBQ3E1Skk4TWZMWElJdmVVcTJraEZ0MmZPaURmK3prUU4wOEFpZkY1?=
 =?utf-8?B?bDVZMkNlckl6SnlqQm51US9raFFiK1gyWnJudmI0ckpyNlc0WWtBMFVPRTVI?=
 =?utf-8?B?SE5mNFNOVnlxT0pzM1FYRHhBbEM2VnBURU1kNmJURzJaRlJWTEl0QjZhNU50?=
 =?utf-8?B?MEdyNXR3QkRyWDNNU243dTJ4U2t1QzRZRFF3TDhuUDFBbzdJRytyVy9WZ05Q?=
 =?utf-8?B?VENEeGY5RnVXUmk0M3p1MGJYeUZrNnE3OVcxYWpLbE5WOVVlODRrSVhHTGVU?=
 =?utf-8?B?bG5xcmVWbk4xcVErcnhRd2Nvand1Mng5VXJNVklYaWNEUllibHVnNnk0T0pQ?=
 =?utf-8?B?MElNYTBGUE1ENGlRQ0s2ZlJqUWp0S1o0dVRnMjRnMmlYalg3ZnFjK0ZZSWIv?=
 =?utf-8?B?TXdoNkZTRlUwbDZjVWd4anBuV3huOW02bkVkazNMZS8vRlkvSDk5VnFZRG85?=
 =?utf-8?B?aHFUd0pJYVk0OGM3RFI3QkFlK0dpOUQ4SlFXQ0VyVkdxY3VhUktTRE9LZWxo?=
 =?utf-8?B?MC94TnIxd29LenNKRGxKdFBpelQzU3lBQ2FZWFFMbVE1d2ozNlZoVmxMaTF0?=
 =?utf-8?B?K0hDOGVDV2Q4K202bTlWU1NyUnp3enlEYWp6NmJncWFNZXI4Y1BFZlBNM0dL?=
 =?utf-8?B?Zm8rTkZONGx5V1UxTStEK284L08vMTY1UVhlYTZRVnVQVmV1M1BZenBtMyt4?=
 =?utf-8?B?VjVmNFJsYU5nck5lajJCSUpKMVhvYThPV0Ftek5aRUhCbFlZWHY1b1lZNW01?=
 =?utf-8?B?WEwvSGZ1OEZHN0xZNVlTOEZqNzF1ZE5DU05IR2JmTVlzL0ZnNGJFTjFyN3dP?=
 =?utf-8?B?ZWp2dlkrVVNuWUhoNUdjQXdHVENxamlIZUYyVTk4YlF2MzR3ckRMV2dlRlJW?=
 =?utf-8?B?N0VZc2EyaVRuWmZaTTdkVFltVUVibFRCNXJYUGFHRXJ4aHJrRlJPcHpFL2Rq?=
 =?utf-8?B?UjIvdVRsY0FzaTRJNUFGMDJXSnRrQXhQTkt5TkdJR0ErcnFYVHVsbm8xeVpv?=
 =?utf-8?B?MzU1b3RXRS9BaFgzMFhTRE9la2xGdGxQeTh3QWNMRTNoVTc4WVZFeTg1b0M4?=
 =?utf-8?B?VDJzNDJWc2JodUlCUnlqcStuZVJYWTJxQit3b1ozZjViU0YrNGhHNVV1NEMr?=
 =?utf-8?B?dXdEeHlLUHRMcStCUS9Yay9ZOWZlMHR0N3orcDcyRzhGdnlKMmRLQkluVHdG?=
 =?utf-8?B?Y1J6SHBHb0lXZTBVNXQvSyt0dVFGNnJ6Y0VBTnRCenluVjNpRWtpaWxKRHpS?=
 =?utf-8?B?RDV6N1hubTRGRnhsQWR1M1pacDdHdU91ZXRFdmg4amM4MFNxd0VKZHJ1MDNN?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eadeb86-e7bd-4e2a-ed6d-08dc1b72a089
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 17:50:31.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImgtKkiaxbtVsKQcpExcXYvK4wkpFZoP2SXICKNcwXyPcSQZ0sPlYVAE6ikp4lm1N9n+gvPZAxGHqf7ssUG2CQ==
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

Sorry for the delay in responding, your patchset was lost in the shuffle.

Tested-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Iulia


> ---
>   drivers/remoteproc/imx_dsp_rproc.c | 82 ++++--------------------------
>   1 file changed, 9 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 8fcda9b74545..0409b7c47d5c 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -103,12 +103,10 @@ enum imx_dsp_rp_mbox_messages {
>    * @tx_ch: mailbox tx channel handle
>    * @rx_ch: mailbox rx channel handle
>    * @rxdb_ch: mailbox rx doorbell channel handle
> - * @pd_dev: power domain device
> - * @pd_dev_link: power domain device link
> + * @pd_list: power domain list
>    * @ipc_handle: System Control Unit ipc handle
>    * @rproc_work: work for processing virtio interrupts
>    * @pm_comp: completion primitive to sync for suspend response
> - * @num_domains: power domain number
>    * @flags: control flags
>    */
>   struct imx_dsp_rproc {
> @@ -121,12 +119,10 @@ struct imx_dsp_rproc {
>   	struct mbox_chan			*tx_ch;
>   	struct mbox_chan			*rx_ch;
>   	struct mbox_chan			*rxdb_ch;
> -	struct device				**pd_dev;
> -	struct device_link			**pd_dev_link;
> +	struct dev_pm_domain_list		*pd_list;
>   	struct imx_sc_ipc			*ipc_handle;
>   	struct work_struct			rproc_work;
>   	struct completion			pm_comp;
> -	int					num_domains;
>   	u32					flags;
>   };
>   
> @@ -954,74 +950,14 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
>   static int imx_dsp_attach_pm_domains(struct imx_dsp_rproc *priv)
>   {
>   	struct device *dev = priv->rproc->dev.parent;
> -	int ret, i;
> -
> -	priv->num_domains = of_count_phandle_with_args(dev->of_node,
> -						       "power-domains",
> -						       "#power-domain-cells");
> -
> -	/* If only one domain, then no need to link the device */
> -	if (priv->num_domains <= 1)
> -		return 0;
> -
> -	priv->pd_dev = devm_kmalloc_array(dev, priv->num_domains,
> -					  sizeof(*priv->pd_dev),
> -					  GFP_KERNEL);
> -	if (!priv->pd_dev)
> -		return -ENOMEM;
> -
> -	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_domains,
> -					       sizeof(*priv->pd_dev_link),
> -					       GFP_KERNEL);
> -	if (!priv->pd_dev_link)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < priv->num_domains; i++) {
> -		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
> -		if (IS_ERR(priv->pd_dev[i])) {
> -			ret = PTR_ERR(priv->pd_dev[i]);
> -			goto detach_pm;
> -		}
> -
> -		/*
> -		 * device_link_add will check priv->pd_dev[i], if it is
> -		 * NULL, then will break.
> -		 */
> -		priv->pd_dev_link[i] = device_link_add(dev,
> -						       priv->pd_dev[i],
> -						       DL_FLAG_STATELESS |
> -						       DL_FLAG_PM_RUNTIME);
> -		if (!priv->pd_dev_link[i]) {
> -			dev_pm_domain_detach(priv->pd_dev[i], false);
> -			ret = -EINVAL;
> -			goto detach_pm;
> -		}
> -	}
> -
> -	return 0;
> -
> -detach_pm:
> -	while (--i >= 0) {
> -		device_link_del(priv->pd_dev_link[i]);
> -		dev_pm_domain_detach(priv->pd_dev[i], false);
> -	}
> -
> -	return ret;
> -}
> -
> -static int imx_dsp_detach_pm_domains(struct imx_dsp_rproc *priv)
> -{
> -	int i;
> +	int ret;
>   
> -	if (priv->num_domains <= 1)
> +	/* A single PM domain is already attached. */
> +	if (dev->pm_domain)
>   		return 0;
>   
> -	for (i = 0; i < priv->num_domains; i++) {
> -		device_link_del(priv->pd_dev_link[i]);
> -		dev_pm_domain_detach(priv->pd_dev[i], false);
> -	}
> -
> -	return 0;
> +	ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
> +	return ret < 0 ? ret : 0;
>   }
>   
>   /**
> @@ -1153,7 +1089,7 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>   	return 0;
>   
>   err_detach_domains:
> -	imx_dsp_detach_pm_domains(priv);
> +	dev_pm_domain_detach_list(priv->pd_list);
>   err_put_rproc:
>   	rproc_free(rproc);
>   
> @@ -1167,7 +1103,7 @@ static void imx_dsp_rproc_remove(struct platform_device *pdev)
>   
>   	pm_runtime_disable(&pdev->dev);
>   	rproc_del(rproc);
> -	imx_dsp_detach_pm_domains(priv);
> +	dev_pm_domain_detach_list(priv->pd_list);
>   	rproc_free(rproc);
>   }
>   

