Return-Path: <linux-kernel+bounces-98948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35C987817C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5033EB23880
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8793FE35;
	Mon, 11 Mar 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYy4ESWZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653E3FB2E;
	Mon, 11 Mar 2024 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710166649; cv=fail; b=X6cpehle4P2BpGrG6vUaF6Gvnn/ezgVPYljBPlcoQimveVj62xJAlLCDqF/SONQqP53pBfMKEsaCB+uX8rOJcpsXCPJAhlwHZ9pCfBx86f0AaDBBIwo4RCsgRwZeJEpI7YovXaEFGWyKePHMg2OAjROlVgo9z9daJDaTh2Ok1vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710166649; c=relaxed/simple;
	bh=PR5aA3TGQzSKZfg8QT2Go5+/eP4dRLDBN/E45P5Ck7g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGx/VoRvfooXvhobFbJCtEq6O5P4pmbyjm+6H0UCa0Bf2nQP0N7Tl+JqoWNnjCtB4jQoNNTFUqz676MzxTrZ5u+SqZs3kHpAEXvE+vktO5CLQ6jGZBoF4zWqGFNeG2ay4DbG1KCvZqdE+ZQNf8jUKK/vLrjzh71LwHaeqBrnS48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYy4ESWZ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710166647; x=1741702647;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PR5aA3TGQzSKZfg8QT2Go5+/eP4dRLDBN/E45P5Ck7g=;
  b=lYy4ESWZxd6jdzwi2Qc7U9ePVwz8IgDfHdnityhGCBh0TA8MQ60EaIkm
   b+4bHtHtjxGSr+agHpNHakd0qvM+MuU/cU+VxmQVpNVfxYpQv3qKwFT5n
   e8gElB7Y6FETuEBz+iyeC0/kXJkwif3v/mlfZmSDqfE3609U3ivGuGboW
   NhcovdPE1AebrxNc4DIRNRG5PaYxfkjswuVDV08yBw/D2XJPaiKvyblvp
   j0u/xAHR0b6oiSbGd6JSw2z73om/+FObmljFlrE8QPhC0P4LVldCDRpuY
   wHLZzEbBmsgw48lp6BZ/677+LVJUAx0xd00Zfb8CgospBzIYu6DgJrYX7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15561158"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15561158"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="42101865"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 07:17:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 07:17:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 07:17:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 07:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/fWIq6LDMGYRbu22P9NlTkuIiFurgIqb3W2Uj4t+N7UCu6D95UlsGq8/9xOWH0PxG4AZE9b3x/1+ktW7SfM96wqaZHJh+ubsO6IiuEts1F8OktE7vqQOAB+DNAqNfH+PgynE28yQ7TwmIfqjdsYZ4Zkqp93jn0Hcwdphg2eckOvpeLFwX4j3jc65qELIAOeftjHjX0EH9wVQ8j3SQa5/03nPj+0d+vriAfAYT6nNoUz8Dx0ucZmxswipzOUnufSrOwdozOVrr6vqsrvu165uPuMf7WqffI+HfzNxmrDDzdvfWJGSIOvJtUB9QDUEfhJczWXeZYfJoqW0dRVnInWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vERb4ExLECwaIJ0ARO70+SMd21Q3SU2kbQwjX2+1l8=;
 b=lk5n0iIkpU8sAhVFlOb2+epBU1jnqR8ShXaf7RzZKWTcct0X3QCgDzgiqxoapm+Znf6d5x1ZDv9Kc7oAo8qB4JhXoJzOEG8SwC2BZXqXaApHis5wKh/3FoFplNW66gZz+uN0k9DUxP2uCwlv/glx5HVb10RBQ2dnc6tgdbFTe7DAYRrPpENyjCEsWXF+WvKzd6bp0tY0eOuWSbRl3XuKBih87cAvbDr7pPyfF4ZNvanLQEUk5JFRqV/U4j8gFg38oFChHBvy5jIvaqE9smcICKQK0ZGC7SW/YTfmdjPoxZSuMR8yvUFGPKR+Nbvl2RPnZ9WtYB9Ia4welgqr6B90iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ1PR11MB6156.namprd11.prod.outlook.com (2603:10b6:a03:45d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Mon, 11 Mar
 2024 14:17:22 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7386.015; Mon, 11 Mar 2024
 14:17:22 +0000
Message-ID: <43b0b4ad-69ac-450f-8b39-ae264355622e@intel.com>
Date: Mon, 11 Mar 2024 15:17:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] ptp: Move from simple ida to xarray
Content-Language: en-US
To: Kory Maincent <kory.maincent@bootlin.com>, Jakub Kicinski
	<kuba@kernel.org>, Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <thomas.petazzoni@bootlin.com>, Richard Cochran <richardcochran@gmail.com>
References: <20240311135949.1180157-1-kory.maincent@bootlin.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240311135949.1180157-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0377.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ1PR11MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: a85e017b-5e6f-477d-65d0-08dc41d5f7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbivDJ1KLuOkMtN9yKTEGyVHDMw3Mc92BN038qsMWggm7xh7QUiYuckGTpL44AaJLVVgkKSFxoDawKsYu5KkxoNcZGHBhRH8/IzJ8HSySlGX/+myl7DxQiVkCAsrHmcHiKtTCslfjHnYXjU34Lxpk+uOek1FfdZyBZeB3sa9HZQVw6zun7ng9B8r5uzuY9lPdZP3z8tQIrK/KWRWu1Hq0kPB4nq8dpjvk0aCML11ILikasxGKrsb1/Jx208UryKmMApIPlxUnOpc9XBZtdtILkS3vCHOgrnOBPTRkVaZ6dBD2topOnrwZokCWsuSrpRiG8LCw2LnmyYrBnqcHDNuSDeq5kRMCYkCOYyKfhZ3SrYOW8ya/JUvNWJuudJ5qvMX2xDh/i+Zc4rPqPDEfA/mgokFAq9ZblZtiUKJmHZzdxhFtrfNp72dsQkj0GXkXB0AaY2AaUrglo+iup9AdUaZcG1J6+ZTPpyCWRc1F6Yl3D5r/RP9N6DoyDi/oAnAJ0T+2NlrJwr0fIOADVKhx6Iow5XMysSgQzZI1O9V9bl63UckOcp9hAoIqC3nzDHw5zTKHzXLESCpHWpddXtJw2IsNTZwil+FBDSsCPucGMCNKNXzNyu+tBRVwwBJv7D/ZtD8hYDzeajcCEwpWRJIpGsoZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDFNZkxTUkRkUFRwc0R1QXYzclRxdm1WSzdTcHFVTUtpTEFMME5zSEJLWGpw?=
 =?utf-8?B?S1dac3VXSGpNVGNESjZ1a1V5Z293NVVBdU42SldhNGw5NVFTYXhIb3UvQWg0?=
 =?utf-8?B?ankrQVZWdEdIQkl1V0RPcEhjTjVtclVEZUlqYmpKSnpVQzRQcXVQd2tmN0to?=
 =?utf-8?B?cUZUKzFBZVJjVldMZmlwMVlGT29EVmJTSTJQZytDTlNrL3VsbnBESUozQnRq?=
 =?utf-8?B?K2hibGVOUittUm03eXFjc0JKNlRRM0NaRmh5ZTF2bDlvMitNdE5Gc1o3Nm5E?=
 =?utf-8?B?N0QvQThGZTJzRlp4aXBXdTQyVVNhamRrVnJ5K3QzbDJ1V0ZpMG5EWE1GOFZ3?=
 =?utf-8?B?YXpISCt4Wmp6UUtjbkpsalVWVEdGUnIzcDE4UVgwOERFWTViREVxVVVadHlz?=
 =?utf-8?B?SEd5N1ltWVh5eGU1M0V0cERobTVPUDY5QitVNnBubTBPYThjZlUzSStHeHov?=
 =?utf-8?B?NEZ1N240QnBjSXBpTlhITE5Ka05oT3dhOEszc09RTlBubVdPOXRmUGl3bzRz?=
 =?utf-8?B?RXpVajFGbXV0WXpWaXFTczZxWWxCUkVkVFkxQlloN2R3Ni9HQkI1YW93SnNT?=
 =?utf-8?B?Nml1bWFTYzl2Mkx0aFIyb0psQVFiTERYb2dYWjdCanFLbDBCT25GcmgrVk13?=
 =?utf-8?B?a0NRcjkvNStUalIrTnE3eXM2dDQrSDk2T05pWGZMRjlTdE5XOVVFQWlkSnpl?=
 =?utf-8?B?UUNhRFJCL1duQkJ0MTJPUHE3VXBsSm1XbVB4T25oL2hHM0xkKzZQNGludkVY?=
 =?utf-8?B?RkNNdTdlQ1VYTGtiOXNCNGR4ZlZKK0pQcmZnODVMNDFoQXhiWVlESEZDTDhn?=
 =?utf-8?B?LzV3azNHUDZWTTNiL3RVaHFPbkl0TUdkNTVvWTJjdjI5Mnd5SGc1bW41aGdo?=
 =?utf-8?B?ZDNMMGVNOUJ6bEppZm1YaU43K0c5RXlhRTZRd09JaUZKL1h0a3dvblcrRmZm?=
 =?utf-8?B?UXB6VVB0Z3VYM09BZk1lbVB0dVZudnMxRHVQdGdOblh0WFpIM2pqMXp5bVdO?=
 =?utf-8?B?eE1FYjN2T05lVGtxcnhVTmlEN1Zzc0lDZ1ZaS2s2SVdnSEdVcVorMW50ZHFh?=
 =?utf-8?B?V3NWL1pSNVEvbHJCZlREME52djJrcnpKU2lMZVM4RDFydXBzWGVDWkVEUFlx?=
 =?utf-8?B?eFBrZFJhdUk0K0pFU2ZQNVRzVm44Zk5Na1dBck5ZR1hqQS9DYXZPdDRHb05B?=
 =?utf-8?B?d0hnUlFibXFkREtLUUc2aVE1bmRPS2ZSQnlLejc3UmtnZC9RdkpkUkpZazFK?=
 =?utf-8?B?ZFRuVUJLb3p1dTYvM0pVbTV3TzIzZytuNzZINlgyWVNUSnpzMnJHTkl0SDhu?=
 =?utf-8?B?RHJ6M0xoUllYQ3MvUVpZSGxyRTJIdVVkNjZrZUJhLzFWOXY1cHp4ODNkUTEr?=
 =?utf-8?B?cVBrbkRXS1VTZkFuL3JpVm5Galh3eEV2K1d4UnUwbnYxK3EvVWtldzZFVnhk?=
 =?utf-8?B?Wno2UndTNVB3bUR4Z0lXYzJWbHdWQWJHVzlXTlh3QlVlNG1WZDQ1b3VQMmIw?=
 =?utf-8?B?T0NXSUdvb0ttN0lUL1VEd1NJUzIrNWJ4cFQ5TE1SLzJuNFl3UUFUTW82WFVK?=
 =?utf-8?B?MVRGQmhDRTliWDhtMFN3OVNyeHdpanhyOWRVczg3a1l0S1RBSWpOSUdLQThk?=
 =?utf-8?B?WVd4ZXlzeXBFS2l4WVV2eUxzbXhyZThqQjB4dWNlS0E3cTkvcWU0QkI5N1ox?=
 =?utf-8?B?YjZRanFDN0Q0cm90bzA0a2M0d1BUZVVLb0dZWkhnQ2FwSmRXcXF1amFYMUJs?=
 =?utf-8?B?TlpuZXJjNUZFb2FWb0YxNHRyOXl0Q0lPNEEwNitRemhNYmJUbmtLMFR1Wi93?=
 =?utf-8?B?akxZWnlEeVhSbUtXUE9hZ291SUovb0tEbEhnN3lIRnF6dWd2dlVsMWFJa1ZK?=
 =?utf-8?B?QkpoNTRzcTZhQnJqTUJ5ZmVkRUgwNW1rU0hyRDhPeWJhOVpYL1kyUVFKUEpi?=
 =?utf-8?B?TUNkRXpUWDVqZ0kxZFE0THNDU1k5M09ZM05NMDNOVzRWMFJuZFNsUUdyNWJ5?=
 =?utf-8?B?bk9IM3J4RW5zaC8zWnFQRmd2VkljZ2dHZW82UHdibE5oWEcrQkJnbW5WZkVq?=
 =?utf-8?B?eXZncTFCTnJvZXdEUURZU0tCK2lwcmFzV0J5N1hGdnBTbnJUVVpDL2F0dWNw?=
 =?utf-8?B?dXBPUDc0QTVwbkhVR3JydGRxUWN1KzNCRFExZ1B2QU9WeHBYS003S0xIMmhO?=
 =?utf-8?Q?Cd2dRE/X5afFSPOAE/uD7KM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a85e017b-5e6f-477d-65d0-08dc41d5f7db
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:17:22.2663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKxwzVJiz4VNx3Rxm2krhRM6eZZSr/jSZMuXvSlbGPsBZznYIlWcoCMMc6VtPeAI/YOtXrgx1JD16g2E/QlZeOTB/gmy1eS+W6D5NJEKfGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6156
X-OriginatorOrg: intel.com

On 3/11/24 14:59, Kory Maincent wrote:
> Move from simple ida to xarray for storing and loading the ptp_clock
> pointer. This prepares support for future hardware timestamp selection by
> being able to link the ptp clock index to its pointer.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v2:
> - Update an err value missing.
> 
> Change in v3:
> - Refactor err management.
> ---
>   drivers/ptp/ptp_clock.c | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 

sorry for not commenting more on v2 :/

As you change (the intent of*) underlying data structure you should also 
change included header file.

*ida is an xarray wrapper by now so the change is on semantic level only

> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 3aaf1a3430c5..8eebf1373ca3 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -31,7 +31,7 @@ struct class *ptp_class;
>   
>   static dev_t ptp_devt;
>   
> -static DEFINE_IDA(ptp_clocks_map);
> +static DEFINE_XARRAY_ALLOC(ptp_clocks_map);
>   
>   /* time stamp event queue operations */
>   
> @@ -201,7 +201,7 @@ static void ptp_clock_release(struct device *dev)
>   	bitmap_free(tsevq->mask);
>   	kfree(tsevq);
>   	debugfs_remove(ptp->debugfs_root);
> -	ida_free(&ptp_clocks_map, ptp->index);
> +	xa_erase(&ptp_clocks_map, ptp->index);
>   	kfree(ptp);
>   }
>   
> @@ -241,16 +241,16 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>   		return ERR_PTR(-EINVAL);
>   
>   	/* Initialize a clock structure. */
> -	err = -ENOMEM;

you could remove 0-init of err in this commit too

>   	ptp = kzalloc(sizeof(struct ptp_clock), GFP_KERNEL);
> -	if (ptp == NULL)
> +	if (!ptp) {
> +		err = -ENOMEM;
>   		goto no_memory;
> +	}
>   

[snip]

Thanks a lot!
Only nitpicks left, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


