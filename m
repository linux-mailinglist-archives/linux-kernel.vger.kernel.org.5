Return-Path: <linux-kernel+bounces-85418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48D486B5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770F328ACA7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ED43FBB4;
	Wed, 28 Feb 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2UrDI/8X"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CBD208B2;
	Wed, 28 Feb 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140333; cv=fail; b=KWNG7UanWsHjduZnDJDcATrmbqYIb0AUUMcpLXchLXXsNXDhHAm+r4VM9gBqNXXYrQ7VxC/MmtwmQ3NrYowXJcotVyQul0k2KiIzJicFs91jL+r3WQl6vcAUgTTBYF6EGsidJk9k1Zs8Vid3FoAwXlKGLlvtve0RmKzBrC5gGTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140333; c=relaxed/simple;
	bh=LainTj522Ws8ZDCMHv5qPLvBbqer0OHcJrfcVGbNnaE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q9WTa9/dYEbR8UuMNiUWI4YDsxfAluOw7QaoOy2j//G203jxVPyNebjvWAau8T8naXgQ0o7aRKsGeCdoqHNgh+55DUhB5SA/DTrYaiQZki4uqQf+/RfZLLRTxcjrIqyst57/EGCiRxMyK2Sz8AtOeE5Fe4w1ezV5svy62i7ny5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2UrDI/8X; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb7EWBbGnereSi4YKC/5E8kWhMtgElnm2kIac2qbY6eUn6HCtb6WlriLTHtXwHy7WjE9UJSpOMuicPjyuUQKn+BQLMHrV7/u64azTWuLLGy11+1MOxG39yxR9L7u4ug+rbQRhXPob3/YHzJX/XV+w0MFWuSSX20bfF1Htfok5ZWDFPvkl/mLGELnXEBrcKbUShSGmW4kVbQpMAzz1qN82jLnJ4TUneWSu9jyV5k9o/dSSJh7oAUspjoOBy/XAeg2l4wmuOxBiNgZJYSZNtjrVKDKbN8p0CQFWr3AttAd8XhfhzfqhfVPOMDobDNtkiEddwQskaj3uGfrbxA4g4TzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWmwHc3GYwiwRYy64mb/b4ST6+fgvOdLhejAUL9q89c=;
 b=gTdQtZ1qMFpHYB8UXQ+mb4u9m+KI63tQeTUN/17Kq2A12vpkh9s5fNJhxtt8sazWV/8RP/P2BnVj7Uy4J0uLG+wjhLrqV5j0QWWMhOV/lTjHDIxoda92KTW8mSfIlGVormiryEw/XsQujGSlUk42GTCQVc37qMlfZ+WciF03++h0PRtdPPzPO3HmzIbTPXStXN1oPST6pcPkBO/7Z91E9owa+r7HocyK3bvqA0eb1KsymlzlTb0jfBcud7dA4sfEKLX8E94XwV5MwcSOkdCpGoMvGtgI/xOTrOPjZKxX18CbiSVjh5NgvlM5sXpPsG24RINd2KWiZNY7jiVVSumbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWmwHc3GYwiwRYy64mb/b4ST6+fgvOdLhejAUL9q89c=;
 b=2UrDI/8XFrBajnW7W2HZ7qtkMtHiwj7Z0ydUYXWFqoHF1P+T+LPBNikyd9EkEMAeBv+3iMPZ7wqwzIrHlmSpCiZK9JDzBrHw6JZlpjAtJaIFQhKdFiN4tv/+vCxq//KTn9LT+Bor+z0xvn4u24MEF56ldDq8HxMO5TBdnLXIfQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 17:12:09 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::14ab:832a:11af:bfec]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::14ab:832a:11af:bfec%4]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 17:12:09 +0000
Message-ID: <693569eb-55d2-4e6b-b03b-f48ad2a51be1@amd.com>
Date: Wed, 28 Feb 2024 11:12:05 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v11 4/4] remoteproc: zynqmp: parse TCM from device tree
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240219174437.3722620-1-tanmay.shah@amd.com>
 <20240219174437.3722620-10-tanmay.shah@amd.com> <Zd9oKWz073OJxKwp@p14s>
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <Zd9oKWz073OJxKwp@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32)
 To BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM4PR12MB5390:EE_
X-MS-Office365-Filtering-Correlation-Id: 1166cb27-12fc-446b-cb55-08dc38806583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hxHmdetwi9BIkswf2V7OFEJ61jtlni/CDJXZauDVSRH44i1L61TYx3pXCK8ReEYaeeS9IXjlzvGZ9fwJcr/m3kk6LK+4ycEL4Ijq21xrJt/dXFLXGcu3L18yJzvk1SmkPZhH5FQk/dyQebxFSJK4pS5SHnVF9eAtYpNTEuqkkVCpd6Bd9f+gh4G2rBVP9zmtPPTPJ560wUxhsvOnODgd9HfCl+EhACbtc6nrNxxLrbtqNeLEE0agx1J0/mQFnB5ZN0uLbLhZVtEe8II7Hh4s8LQUgW+WSAHCQKiuqk+NyCa8Gz60cYGjAgl1I+J+BzSGZGfzhuA6kVWoqdRWJTCMzTaunW5ehTV+oYDc2Q94K+AmJGDlw9eM9yqBFLKh2LB4ODpxn2eyGaTanfNYxcysZe2FFUMzX2W/zIunZf4D4N9DA1POto11SNVNGgzxU2GffufHe+FLwb29j5ygnQFZuNPErn5dx27YxAX8H5f77B1UsyevglcS+zl5iJIwphg+RShJgt1zz9WM646rNe/WeU9AgIxR3mKQC33pryZUaEuXCCDxScAKaeAzhSlW09v1aKW5e8KkJaUVZuCb+PMeTYO6J+5Vpb2o8hldXOfzroL7/vRpc8ZnrPGJ8+QN7g7NSap+xactl8RB5kAtpi7RHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDRHVXpRc2FndzYrS3JRRjFNdHI2ekszS1JhWjZxSG45TnRIdXFqWWNOcmt4?=
 =?utf-8?B?ZTlPWTRvcVFLYVl5WWdYUk92TGNqRXZUV0xuZkZ6b045TzRwQVdUTnNhUjJ3?=
 =?utf-8?B?ZlhKZTFOc2FEVUNVV3J2NEZIOTVHaWtBb3VTZEk3WXB3bGM1ZzVoTHRLT1pn?=
 =?utf-8?B?cnpTbEE0bzRUeWZodllhWXRpWXR0Qk44V016R2tQTE1OUm5WcjNaTUJrakFP?=
 =?utf-8?B?MUJZTFplWHZkdkpNRkEvd3phQlB6M094Ym12ZGJYK3FnelVGRDRHQzJBS0Vt?=
 =?utf-8?B?RzNrMEpIUmh0TFRZMkNjbWY5dWVuQnhXejNJalZ4THM2Z3NRN0duNnZ6eHR5?=
 =?utf-8?B?RzErSVlabEdTbGllUkRLM1h4UG5rVFpsRi9PWVRrdFZncS9CeTh4RE1QcnJV?=
 =?utf-8?B?VzBTQm53c1haZUI1NHRzOXdJelBlU2dGbFRDbWdCUUJNcXp6aTkxWXczb09U?=
 =?utf-8?B?aFJobmlwdUNGOXBBU2M3cHJOZlpGSlJRV1dWQnpNUUgzSElkK2lxOVBkeFRQ?=
 =?utf-8?B?Q1c0a0V4dTB3dHc4RnZyVkxBS1VsNkJiaE0yNFlGdjl5ZlhsOHJ4UmszMXRw?=
 =?utf-8?B?ZkNyUDIrL2dBTFRKM2F1T0ltZkJKUXVJMmRjQlZ1SHdiTGhpaXFwWlh2bXhJ?=
 =?utf-8?B?Vm45MFVrWEFPdU92WlIrTTRpTjllUzlqUlBMTzV1Mm9WcWdmWnA0YnRGdWFv?=
 =?utf-8?B?NnVUSitkMEc5dUpaV2owQ3p2UWU1YzlVdy93QjlMbEFQb2p4UFJ5YnhPMmxO?=
 =?utf-8?B?TXNxaWRpNThYdXZCM2d4N3BLK1k2OWp0Rkc0WVNYWHc1YWQvek1tTTNJU3VL?=
 =?utf-8?B?d3p6bmd2bVcvdllTZUhqVFVEcUJYZmp4QjVpUEc5V204TzBwYzU5NStZR0hw?=
 =?utf-8?B?bk81K2syMW1JZW5ncURTWTNIVHRqblJ1aHk5WGlkV0o5VC9kOXBBcklJdFZy?=
 =?utf-8?B?cW92Q1hEeUdiemkvMFU1NlNOWllQNklJc01pNlJqQXJxbXdBZDdzcWVpODNJ?=
 =?utf-8?B?WnV6YTRpdGlmMXhPdzV6ckEyNlRUMUNDdlBHTnlDSm5FYjNsTEk3eGNPN3N5?=
 =?utf-8?B?UUtqTTB4VHRzcytYL0RRRy9sb21DZmlFaHpNQm41dVEvb2xteXdjbFZ3eUpV?=
 =?utf-8?B?U1c1YjlRUjMycklueTh4STRscGZGNEpSVUZOT3FnMGdPOHZVdlVQd2VINUJI?=
 =?utf-8?B?b2JlTkg2Q1M1Ym5WbTYyMXlxRmRWQXRIZ3lTMTJGZG5ITjVvNmNqUXNrVlRq?=
 =?utf-8?B?SWFMK0ttSml0b2x6N25qR05Gb3NkYmdZTVBZSkRjdVhmSEZXd3pTNlg2VURy?=
 =?utf-8?B?aEJSZEl0YzVvVXNPZlhFZDRIVnRwM1hkd1VhMlpacTlOZkxRVE5JTVRsSnVq?=
 =?utf-8?B?RTFzRDRqMUhlclVUT2xBUVp6K2lFOVphZnE2RjR0S216aU40NkZXRVdWQkFQ?=
 =?utf-8?B?L1Z5UE9GNmd1bFhndmN1ME92RytsS1dOUXdhZjNEOXV0alU5QTJNM1JQYUxs?=
 =?utf-8?B?UzFHZDZRZHdVckx4Ty9KcFZqcDJtcTIwZk9CNVFiL25PYU16Kzg0cmdWY004?=
 =?utf-8?B?d1hDL3JPOG80LzJSYXE3R3JuZC9EOWZnSHpVOG84RWJ4QVZHR3YzalA4T08z?=
 =?utf-8?B?OFR0ekhWWWxvL0FaRnpZL3ZEU1hrOTNXdmw2QVZnTXVPSlV3TTZVYUpWRDkr?=
 =?utf-8?B?OWNzMFBRdmxzNFJXWWYwek5qK2xYcGxhaWlHUnBBdkJKRVlrOUdwb1ZIVEt3?=
 =?utf-8?B?S1lLQW5BOVpxdURUOFBjN01pMCtOVUxkdXowenkwSjM3T3BwZkdkMDlXTFJs?=
 =?utf-8?B?NUJtT0NXOU5PS0Y3ZU1GRkFFbmVGd2JCZE5nU3RjRkhWSFFnMzh5OU1zVVlC?=
 =?utf-8?B?WVFDWThWdWUxQk0vSjhraFdmbEpPV0Q2bDQxWHFLUVFPTk82RWtvSzFrZFph?=
 =?utf-8?B?VE9NZXEwQnBxKzBldDRTd2VCaXl4V08vWjA0Ymd6N2dLOHc3MHBvL3ZRVnp3?=
 =?utf-8?B?U2txR1o3VjcwR2Qyanl6NXJZellFejhueXlDRDkyT0htencrWEtlQktaMWFC?=
 =?utf-8?B?aXM5V3NReUkrV1B1VGRpenVXd2tOTjVNOUc0d0lDUTRMSFRxWmpJbENCZUpO?=
 =?utf-8?Q?F4KczyxVCWuH2x3xVi6RUzwgC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1166cb27-12fc-446b-cb55-08dc38806583
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 17:12:09.1267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2Bw2QPmH/V/DYPw4Tnw5WJCOAh4b3V0+crkLtrJGCdd/gm+q4B/bD9M9bfufdwP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5390


On 2/28/24 11:06 AM, Mathieu Poirier wrote:
> On Mon, Feb 19, 2024 at 09:44:37AM -0800, Tanmay Shah wrote:
> > ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
> > is available in device-tree. Parse TCM information in driver
> > as per new bindings.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> > 
> > Changes in v11:
> >   - Remove redundant initialization of the variable
> >   - return correct error code if memory allocation failed
>
> Where is that?  I looked really hard but couldn't find it.

Hi Mathieu,

Thanks for reviews. Please find my comment below.

>
> > 
> >  drivers/remoteproc/xlnx_r5_remoteproc.c | 112 ++++++++++++++++++++++--
> >  1 file changed, 107 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > index 42b0384d34f2..d4a22caebaad 100644
> > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > @@ -74,8 +74,8 @@ struct mbox_info {
> >  };
> >  
> >  /*
> > - * Hardcoded TCM bank values. This will be removed once TCM bindings are
> > - * accepted for system-dt specifications and upstreamed in linux kernel
> > + * Hardcoded TCM bank values. This will stay in driver to maintain backward
> > + * compatibility with device-tree that does not have TCM information.
> >   */
> >  static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> >  	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> > @@ -757,6 +757,103 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> >  	return ERR_PTR(ret);
> >  }
> >  
> > +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> > +{
> > +	int i, j, tcm_bank_count, ret, tcm_pd_idx, pd_count;
> > +	struct of_phandle_args out_args;
> > +	struct zynqmp_r5_core *r5_core;
> > +	struct platform_device *cpdev;
> > +	struct mem_bank_data *tcm;
> > +	struct device_node *np;
> > +	struct resource *res;
> > +	u64 abs_addr, size;
> > +	struct device *dev;
> > +
> > +	for (i = 0; i < cluster->core_count; i++) {
> > +		r5_core = cluster->r5_cores[i];
> > +		dev = r5_core->dev;
> > +		np = r5_core->np;
> > +
> > +		pd_count = of_count_phandle_with_args(np, "power-domains",
> > +						      "#power-domain-cells");
> > +
> > +		if (pd_count <= 0) {
> > +			dev_err(dev, "invalid power-domains property, %d\n", pd_count);
> > +			return -EINVAL;
> > +		}
> > +
> > +		/* First entry in power-domains list is for r5 core, rest for TCM. */
> > +		tcm_bank_count = pd_count - 1;
> > +
> > +		if (tcm_bank_count <= 0) {
> > +			dev_err(dev, "invalid TCM count %d\n", tcm_bank_count);
> > +			return -EINVAL;
> > +		}
> > +
> > +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> > +						  sizeof(struct mem_bank_data *),
> > +						  GFP_KERNEL);
> > +		if (!r5_core->tcm_banks)
> > +			return -ENOMEM;

Hi Mathiue,

Here: in v10 it was following:

+		if (!r5_core->tcm_banks)
+			ret = -ENOMEM;

Which is not correct. Somehow I missed to return the error code instead it was just storing the error in variable.


> > +
> > +		r5_core->tcm_bank_count = tcm_bank_count;
> > +		for (j = 0, tcm_pd_idx = 1; j < tcm_bank_count; j++, tcm_pd_idx++) {
> > +			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
> > +					   GFP_KERNEL);
> > +			if (!tcm)
> > +				return -ENOMEM;
> > +
> > +			r5_core->tcm_banks[j] = tcm;
> > +
> > +			/* Get power-domains id of TCM. */
> > +			ret = of_parse_phandle_with_args(np, "power-domains",
> > +							 "#power-domain-cells",
> > +							 tcm_pd_idx, &out_args);
> > +			if (ret) {
> > +				dev_err(r5_core->dev,
> > +					"failed to get tcm %d pm domain, ret %d\n",
> > +					tcm_pd_idx, ret);
> > +				return ret;
> > +			}
> > +			tcm->pm_domain_id = out_args.args[0];
> > +			of_node_put(out_args.np);
> > +
> > +			/* Get TCM address without translation. */
> > +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> > +			if (ret) {
> > +				dev_err(dev, "failed to get reg property\n");
> > +				return ret;
> > +			}
> > +
> > +			/*
> > +			 * Remote processor can address only 32 bits
> > +			 * so convert 64-bits into 32-bits. This will discard
> > +			 * any unwanted upper 32-bits.
> > +			 */
> > +			tcm->da = (u32)abs_addr;
> > +			tcm->size = (u32)size;
> > +
> > +			cpdev = to_platform_device(dev);
> > +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> > +			if (!res) {
> > +				dev_err(dev, "failed to get tcm resource\n");
> > +				return -EINVAL;
> > +			}
> > +
> > +			tcm->addr = (u32)res->start;
> > +			tcm->bank_name = (char *)res->name;
> > +			res = devm_request_mem_region(dev, tcm->addr, tcm->size,
> > +						      tcm->bank_name);
> > +			if (!res) {
> > +				dev_err(dev, "failed to request tcm resource\n");
> > +				return -EINVAL;
> > +			}
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * zynqmp_r5_get_tcm_node()
> >   * Ideally this function should parse tcm node and store information
> > @@ -835,9 +932,14 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> >  	struct zynqmp_r5_core *r5_core;
> >  	int ret, i;
> >  
> > -	ret = zynqmp_r5_get_tcm_node(cluster);
> > -	if (ret < 0) {
> > -		dev_err(dev, "can't get tcm node, err %d\n", ret);
> > +	r5_core = cluster->r5_cores[0];
> > +	if (of_find_property(r5_core->np, "reg", NULL))
> > +		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> > +	else
> > +		ret = zynqmp_r5_get_tcm_node(cluster);
> > +
> > +	if (ret) {
> > +		dev_err(dev, "can't get tcm, err %d\n", ret);
> >  		return ret;
> >  	}
> >  
> > -- 
> > 2.25.1
> > 

