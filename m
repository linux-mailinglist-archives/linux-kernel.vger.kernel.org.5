Return-Path: <linux-kernel+bounces-117909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A2A88B55C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5690BC224E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B9E5810D;
	Mon, 25 Mar 2024 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sf6L+VBP"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2116.outbound.protection.outlook.com [40.107.237.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE240BEE;
	Mon, 25 Mar 2024 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397715; cv=fail; b=JmG/HtbC+thsbqewqdFNITxq5hk8tl0N0EtR1FB4uOYL9vv3flDUHunkwQvEvZuQXWkzPCU6CGneSUF8XBaHjpL5QI/Oee6F/l721bn9R9F+w32/SeRyoAJRyJBfBKEICx/OfYWNHH5BwL+6hVFXIArAPAhG/3uiaOvuDD0yFD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397715; c=relaxed/simple;
	bh=uFLF6XHZhLDQFrQx/pbl1/HFs7s9mjkSORt9ZEnlLio=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i8uEGQKZ+CbPo2KdXBJfG2MvCh4Ht2LFAZ+xCbcIWSNWcPL/N2hzV9jdnZ/m7hLByy7Nsd+kxc5EO+Baa+WQWgP5MeJ96ckNIpyqW91YxiU2lM/+bOFrnv5g1Fxje4QPwrHmUETVFhU4GWrF5lQD7I0UqNaHCGddwgVT9VKf1RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sf6L+VBP; arc=fail smtp.client-ip=40.107.237.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh4ebrR3LDYdv8jhBwOR8d/vuPJ2XFQ5ukoq09mYZxKboSVZ2IM3nhRVHRs56Jx/vojSWiNCVGxbh3TuF5RFWiQPvsurz/fI+5CNBxIMB9LtM2WulJFXYf86o9dD4vp6ORh6V5FtRksaV2BeEgMGPZbK97GQcz7SY70/6mac4Kr/SUJt84gjLW2j9JM4X42Os1omNgldLInitCsfX49cenaDjXFQlPF3ZwFasIGmx2GOq9AgDZk6uMr6OEHVMZvi9Jr11aBtsAw5lpb2AxQEplZypDgw66jczimpsD2aKwTknafJ409JGIkuXJZJwtX42sT5RU3oU7j11EGOmMZWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1wfzpTRu3zNd4OfZkCPYabANfRvzgl7nyB9D2Wt808=;
 b=fvvMFler2XApBNXzmdY7q77PdcEP+boFwb0pxNhKtPcw+3JJ1cOBRM6xv0f3H82uepU7oUc1OkRZwMB+H8qjN67XYhGbbqvB1XQMj5PQ4pkGDTIdDJVdyYmn0OfeYP3QI63m4kG/q7OF2yZetBYF9ULvHV/wpPakVsvrkghfc2PgZC0Gxq9dVQnp8D7Z34poKKKY6q6MLk0y5Kq7eR/r37zIPJ3puIjz8UxR2Pf+CbEm36frcxH+DmqX3IOWHvLR9gFhJYn8dQSkGrk7UJ8MbtQESvxl/725tvoYAb7cx/IkLTrWp7u3g+dwJ8SoIuOeuHQk62Hu9qsINpVo/kxLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1wfzpTRu3zNd4OfZkCPYabANfRvzgl7nyB9D2Wt808=;
 b=sf6L+VBPdWGe5tMONFlOLWl0bAYr2k9iUq/2uFYTbr39Ih4ZFFpX3uYKaykXr5uOQ7UzlbIa0e3RYM2/GD6t8IXEsNKl3kVL5Q8zSHNTQPUKpe8CERbQ8lrqsOFd1e2XFUG5TbO5KVDhSw9rAQRqcGV9DMvV3humxtzLR8i+o1Q=
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 20:15:09 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::815d:4ebf:44b4:6edb]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::815d:4ebf:44b4:6edb%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 20:15:09 +0000
Message-ID: <d69c2157-a0da-4d8c-8684-d42afd285191@amd.com>
Date: Mon, 25 Mar 2024 15:15:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] PCI/RCEC: Introduce pcie_walk_rcec_all()
Content-Language: en-US
To: Li Ming <ming4.li@intel.com>, dan.j.williams@intel.com, rrichter@amd.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-2-ming4.li@intel.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240313083602.239201-2-ming4.li@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:8:57::13) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB6279:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2C+HM/STkpKwxgKebzvl7hIH19usZymFRMZz5GQ1jRZgRlUrKoHRwkD14Nb7TMZTWX0obuG2IpecnF6/CXspLJfZuaZrn1usgy425CMejhKV9RR4ydMIWPvffQWIBM1Vcu9Hrcu5IQzr88dsaP/RmluDUJa8lxlucTt1j/G1J9tQ2UhVizkgB5YonXaD4DNCExxvNOBuP4XPuDiPlXG8M0KctvNvQg0ahwsrJH2zH5Qtu1U13aRzB7ShI51nvU+JaxE4qTlY1DBJnKVF5H5fyQz3FgDwHHzb5lXV57Nl9ZTIQxnj0vsVJrRmAO4kjk4QxOw1fuRgzUqhKMgM/rkF5EYej5FlNbw+CygfmVV2s7qzkUXuFePVkHx8iKEYTg0UEROkY/N0EWhYkMJkh0yLmrHTha4u4IYyL3EMpj7XkMEhgRKDFodC97MUrhDhb8/VQrFVl2Frmbu8Vet/iydyLwTvHtd6n96hbjS8L27RFvs8dJYTDe4oAp0VB2YRhbLBzRkQcsvPO6W3dgfzhZo1ah/Jh9IoHpn9fDP4SgNbhaEBOmcdfxotFinT4mxzUaZYs3QB6k7zd69MswoYfqcwo32cwBQkIWo3ucMhQG1PIY9gwmpZITIiEVqL0sk12ZevZbjYqCFfCvQijRPI+yeQDGtmVCmRvR3V3iqYTxOL3aY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnRVQ1lvcUtsck54cW5TT0xrb04zRk1kR0t4WkMrRnYraWZZaUlodEpvNkhR?=
 =?utf-8?B?MER3V0FYcVZuWWV1dFdadXQ1amczYW1SNlpLd1pNWG1ybWZpcW0wTjM3L1N5?=
 =?utf-8?B?dEtEcmtyZXVrcStkL21udUJnOFRJYkRhbU11VXFrTS9KRWJ5MXlxVThYYTQ5?=
 =?utf-8?B?bmNwVkMxTVBmM2FZZU9PVEtsczVJSWZGS0VsWmh0TWdmcWxodHFuMGFLOGdP?=
 =?utf-8?B?UjdkcFMyNXpNMG1tV0w2eUR2V0twNTdvUUtFNDEvRllETGJsUWN0KzN3Yklv?=
 =?utf-8?B?UkNvdnlBQTVUOFcxYnJoa2xUeEdVSkNHa1ZScHl2Rjg5bmtlSlN2YTFqNmdX?=
 =?utf-8?B?b3dJRS93MlppSVBUNUN4dTJsS1d1eXl0WWNwYVRLM0VBcHRwc1NFVUZWaTBD?=
 =?utf-8?B?bEh0blBWN2R6ZFZMUERKMk1DK0VTK1VxUWs3T2w0SWdtM1BQRWJYL2J0czRD?=
 =?utf-8?B?dnFuRnEwTzRuZU4yVkxPYzdlNUVPbHdlemFKeWJFQklZSGxIVFlHQlEwR2R4?=
 =?utf-8?B?V0V4ZFlDTGo4S01SWVNTQUFrT1lkOE1wUVlLTmg5VzRRRk1ReTFIZDhZS1ZQ?=
 =?utf-8?B?ZGFLRVNlc1dOeUorWFg2OVd2cWFmZjNOR0V3bWlUTkdhZkFRVVNMRkNKZWdR?=
 =?utf-8?B?UWNISENQLzhvalQ2OEpEQ2FGTDJuREdXY0pkby9LZUpvd0Mzd0RWMXJZNER6?=
 =?utf-8?B?eDQ3dDk0SmF2MFRzSDZHcGgzc2h3bEp2TkgxczVpMHNJZmo4NklrWkxibWFH?=
 =?utf-8?B?UVdHVGdrV25VUUZGN1cyd2o2WGRoczhFK05XRmRqU2NKaUY5eWpha01OaGk0?=
 =?utf-8?B?VGVNQlo4OWZCeENDK1lQQks3Smk3dEE0cWNRZTlkaStPR1Z6VW1DbVZnNXpS?=
 =?utf-8?B?RWVEaGlGZkxRWG44bXhrd3MvVGxGQ0gzc3NvR3JSb0IrWk10YjBkNTNkOHpv?=
 =?utf-8?B?OUdTV1JHUDJQTnVhNU9zQ2Jqd3dhd2tyWE41R0JkcDM0TVUxMldjcFZyb3FZ?=
 =?utf-8?B?TlFibFh0a0JGVXpuQnluMEJUclkrQ3RuV3JRaUNPU2IzYlB2dzZmcnpJQVNo?=
 =?utf-8?B?K2ZWQUQyZkpRTTJVYnB6aEpNYU9JcnFZd1NKd3dLRlJLSWdTa3B1ZWVzdmNh?=
 =?utf-8?B?MlNJLzFnVjNEUzh4aDM2SWdLWExTSWZ3MFpiaWNWNnZLK2twaFlsd3I1cGRo?=
 =?utf-8?B?c1ljNWlzRWNBTFVBa2tieXd4L3dleWd1KzNmSXlSS0ttODJBdVJXU2ROc3Z0?=
 =?utf-8?B?QklQcGxEcHNZb2VqUzNMdnVabU5RZGl4U05maXAyTjNvdWV6VnZnSEc4YWlo?=
 =?utf-8?B?ZTdyQ3pscFcvN25GeVd6QUxIM0xydW1Kd3FFUnE2NjljNDJLZUcyNTNOQlZh?=
 =?utf-8?B?YkVoeFM2dTZBQWhEZmZuVnpNQlRpYmhFTHFVcVVCNHlrVTJmQ1ozU0k0cytr?=
 =?utf-8?B?bWQyRzFnekdvSCtLVEY3TmYxbGplVXIrQW8vSnB0WkdDY0xzM1Y5V2Fadkxm?=
 =?utf-8?B?NzZtUTU5ZjB6MGNyZTNMNXVCekJJM1VGK2oxY0dSK2lDRy9zbEtEN0ZCUUJN?=
 =?utf-8?B?eldNVDFmNDhldEc2c3VlMnFCQ2REYXpSNWJIcjBoSnVCMkluMnBMenIzbCtM?=
 =?utf-8?B?UE54dzRSRFpManlqdTVYTE51ZEZmZXJlenRLRkxYM0Q3Q1I4SnFRUVY0aXBw?=
 =?utf-8?B?c01DM3Jqc1llanp5NGIxeG1ocjk1M3kyZjJjbTU5RHAyRFRlQVFCSzRDdW9y?=
 =?utf-8?B?b3oxV0x4eFl3MkpOMXpoRndtRDNKUHdWdkZOMk00ZnVhSG5YYThocHd3b0pn?=
 =?utf-8?B?ZEFCejRweE5qVGxQdUlndDVSK2dHTW82dnRMbmZaV3dYcFZzK09CUFlSWmox?=
 =?utf-8?B?WVBpM3l4QkZBOCtxdEgrY3Uxa2ZTTiswRzhUbG95NVU1M2tLeUlHUXdrTllz?=
 =?utf-8?B?VU1Jem1NWHVRaHFETjlsNjlPNTh6L25TbHJPOWIyUmxlS3BxWnhtMUxCWnMy?=
 =?utf-8?B?eXRlTlpJOEJvY3FRb2ZZbDVscDBuVnN0d3pTWHpCaFU0TTIwNXBuM0l4VCt4?=
 =?utf-8?B?cWFmT1VBaUtWaHEwcFFEUUdmajhHRzJjbGFjZThlQk1YNmltVUlIU1VmdnRu?=
 =?utf-8?Q?lVmy7wRFctxxGgPtTE8s0NS/B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb42157-8927-40eb-41b3-08dc4d084503
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 20:15:09.3857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYTbqxsxSfQp8rvmkQ206tyQ5x+apGI2izsff/TdVYL4aBYJTJcN/zZcuSXGEQEnHgb3kV7u72YNNQNXKDLqgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279

Hi Li,

I added comments below.

On 3/13/24 03:35, Li Ming wrote:
> PCIe RCEC core only provides pcie_walk_rcec() to walk all RCiEP devices
> associating with RCEC, but CXL subsystem needs a helper function which
> can walk all devices in RCEC associated bus range other than RCiEPs for
> below RAS error case.
> 
> CXL r3.1 section 12.2.2 mentions that the CXL.cachemem protocol errors
> detected by a CXL root port could be logged in RCEC AER Extended
> Capability. The recommendation solution from CXL r3.1 section 9.18.1.5
> is:
> 
> 	"Probe all CXL Downstream Ports and determine whether they have
> 	logged an error in the CXL.io or CXL.cachemem status registers."
> 
> The new helper function called pcie_walk_rcec_all(), CXL RAS error
> handler can use it to locate all CXL root ports or CXL devices in RCEC
> associated bus range.

The RCEC-root port relation you mention is new to me. Typically, not in 
all cases, RCH-RCD has a RCEC. And a VH mode system has a root port 
instead. The RCH RCEC and VH root port are both bound to the PCIeport 
bus driver that supports handling and logging AER. This allows the PCIe 
port bus driver to handle AER in a RCEC and root port AER using the same 
procedure and accesses to the AER capability registers. 

This is oversimplified but are you looking to handle root port AER error 
in the RCEC from the below diagram? 

RCEC <--> CXL root port (bridge) <--> Endpoint

> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/pci/pci.h       |  6 ++++++
>  drivers/pci/pcie/rcec.c | 44 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5ecbcf041179..a068f2d7dd28 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -444,6 +444,9 @@ void pcie_link_rcec(struct pci_dev *rcec);
>  void pcie_walk_rcec(struct pci_dev *rcec,
>  		    int (*cb)(struct pci_dev *, void *),
>  		    void *userdata);
> +void pcie_walk_rcec_all(struct pci_dev *rcec,
> +			int (*cb)(struct pci_dev *, void *),
> +			void *userdata);
>  #else
>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
> @@ -451,6 +454,9 @@ static inline void pcie_link_rcec(struct pci_dev *rcec) { }
>  static inline void pcie_walk_rcec(struct pci_dev *rcec,
>  				  int (*cb)(struct pci_dev *, void *),
>  				  void *userdata) { }
> +static inline void pcie_walk_rcec_all(struct pci_dev *rcec,
> +				      int (*cb)(struct pci_dev *, void *),
> +				      void *userdata) { }
>  #endif
>  
>  #ifdef CONFIG_PCI_ATS
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index d0bcd141ac9c..189de280660c 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -65,6 +65,15 @@ static int walk_rcec_helper(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> +static int walk_rcec_all_helper(struct pci_dev *dev, void *data)
> +{
> +	struct walk_rcec_data *rcec_data = data;
> +
> +	rcec_data->user_callback(dev, rcec_data->user_data);
> +
> +	return 0;
> +}
> +
>  static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
>  		      void *userdata)
>  {
> @@ -83,7 +92,7 @@ static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
>  	nextbusn = rcec->rcec_ea->nextbusn;
>  	lastbusn = rcec->rcec_ea->lastbusn;
>  
> -	/* All RCiEP devices are on the same bus as the RCEC */
> +	/* All devices are on the same bus as the RCEC */

RCiEPs are not guaranteed to be on same bus as RCEC. Details for associated 
next and last busses:

"This register does not indicate association between an Event Collector and 
any Function on the same Bus Number as the Event Collector itself, however 
it is permitted for the Association Bus Range to include the Bus Number of 
the Root Complex Event Collector."[1]

[1] PCI Spec 6.0 - RCEC Associated Bus Numbers Register 9Ofset 08h)


>  	if (nextbusn == 0xff && lastbusn == 0x00)
>  		return;
>  
> @@ -96,7 +105,7 @@ static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
>  		if (!bus)
>  			continue;
>  
> -		/* Find RCiEP devices on the given bus ranges */
> +		/* Find devices on the given bus ranges */
>  		pci_walk_bus(bus, cb, rcec_data);
>  	}
>  }
> @@ -146,6 +155,37 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>  	walk_rcec(walk_rcec_helper, &rcec_data);
>  }
>  
> +/**
> + * pcie_walk_rcec_all - Walk all devices in RCEC's bus range.
> + * @rcec:	RCEC whose devices should be walked
> + * @cb:		Callback to be called for each device found
> + * @userdata:	Arbitrary pointer to be passed to callback
> + *
> + * It is implemented only for CXL cases.
> + * Per CXL r3.1 section 12.2.2, CXL protocol errors detected by
> + * CXL root port could be logged in an RCEC's AER Extended Capability.
> + * And per CXL r3.1 section 9.18.1.5, the recommendation is that probing
> + * all CXL root ports to determine whether they have logged an error.
> + * So provide this function for CXL to walk the given RCEC, CXL driver
> + * will figure out which CXL root ports detected errors.
> + *
> + * If @cb returns anything other than 0, break out.
> + */
> +void pcie_walk_rcec_all(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
> +			void *userdata)
> +{

Is this identical to pcie_walk_rcec()? Is this addition necessary?

Regards,
Terry

> +	struct walk_rcec_data rcec_data;
> +
> +	if (!rcec->rcec_ea)
> +		return;
> +
> +	rcec_data.rcec = rcec;
> +	rcec_data.user_callback = cb;
> +	rcec_data.user_data = userdata;
> +
> +	walk_rcec(walk_rcec_all_helper, &rcec_data);
> +}
> +
>  void pci_rcec_init(struct pci_dev *dev)
>  {
>  	struct rcec_ea *rcec_ea;

