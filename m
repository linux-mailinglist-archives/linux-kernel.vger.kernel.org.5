Return-Path: <linux-kernel+bounces-139446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 376198A037A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5DDB214DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2B2C8DE;
	Wed, 10 Apr 2024 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EnJRBk4U"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2111.outbound.protection.outlook.com [40.107.243.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E697F;
	Wed, 10 Apr 2024 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788601; cv=fail; b=uidu+QJGU+o+EB2Jk+y2kqsOMeJK7+hFsndKtRaAvDDrUn8uV2EsVu7tMRHftFDXuyFwRuEX0kQgp5TaJ1ULfoF0Mvbtb36tD7H0bv3n6Zv/6oDtzxG11OKwLopkPOIl8C/I8NODM/h3kLGSZg3ud7VbUyIQWynV/j70isUz36Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788601; c=relaxed/simple;
	bh=woI38Oi0k0ttynhADHUHXrN00MCA4kWrOfTmbSQYyjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aoGJQl03jHFXlo5GlUvD39gqd8yGh2xhlyYYU9sqa2eKgLC59mqCcO/FVNCZVdUJ9ii9g6bAi0hNvnSJQf2Orpl9TMgIHWxkn1ZyCk4h8psw98GXnUNvaJzge5ZtnsJtp0DgDisuJpvU5djQC2owxBDhiA9roVUCoPmjkEJxrok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EnJRBk4U; arc=fail smtp.client-ip=40.107.243.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6BE2grVVI+RqKD2QEeQiihWCyA/sSQYfyMyME+bHNFtzDWOJM8z1gh7rjv/+UtszYnXIdyAXS8KB6FTUAIqttM2LgweoIm9GlRW7LqYhcRwlUlAj54Jyblp7amEkmlCOCPka4+BsZSvROboB2uRa5lAl/c5AnnrsAoryd/wDcY4r6TJk7IDIkZjarntUp8LE/qi4CLqZnqiEyS7Tn0Uwir8bnYT4iqgUYODehxT2xMB5tVlGTRSdIPOwdZsee4k1Zdy/xr5u1CHrseLpzKPyM4nAXZI+ElTjnb3gj65OOdknF+BGoamOHn6bTjC4cKl2dzhi3Legk0rUoff5XvbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUmk7plIvOVm2Lg1X0fwcfcfpaYifFXG8mckv1Hkjms=;
 b=U4A9zY1uToEMqAXsitawW9wxKG20MLS7nvkEW9wOpEoxsnjGlYbdd/jxH1Tp4jzMjLPfEm/elc7ZM7aJRI8SDiOZzZCSIvGKCGaOWQbyY7P24WONFhZ9xMNq66+8rsH58XaYYP4mj2qYlMDAUvcs6ThDkh2Bj6LL6iW3YrTdXkaaI3tx0SrjhNKhDPPddhuSbuZWB71ssOnjaZGq7KX7/VTPKAzpIGxvN7EBDdAyrc8Hz/6pNLesJjiC7770C//bxo8MYxS0GP+lGaUSU56mG54IQkl+deevsXeRViKyOCiHhSaFy/qIdmgL02PM8Zt3h2p95u5+9fnH0ozUCd1hGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUmk7plIvOVm2Lg1X0fwcfcfpaYifFXG8mckv1Hkjms=;
 b=EnJRBk4UoysqlpCX0rexF98IiYXu3uMkDs4/WhxkUfPCr1rRBC+a/XC2OzRD/+JasgaAOo5Qu4d4NmmIEGwcdwGTxCswsJ6Oi6y2Tno2LwZ3aUS00kkcgQwPSk5U2I5aA2RdBQx1RloQ2xh875AmszrNrLZ+u09YYImgBNWERHI=
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 22:36:34 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 22:36:34 +0000
Message-ID: <0f62cb47-23bd-41bd-a713-ac9f37a1ec7b@amd.com>
Date: Wed, 10 Apr 2024 17:36:30 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v14 4/4] remoteproc: zynqmp: parse TCM from device tree
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, michal.simek@amd.com, ben.levinsky@amd.com,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240408205313.3552165-1-tanmay.shah@amd.com>
 <20240408205313.3552165-5-tanmay.shah@amd.com> <ZhbFfA7toAkUATfg@p14s>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZhbFfA7toAkUATfg@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:806:125::13) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS0PR12MB7558:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vm2BcBkE+/RMBaBfg4qeQ2hAsIOxIhcOlxLWCPm973q28lB11BshvxaolC0gdeWEM9bWuR7fJIOIejuxpWdsYQpOf6vM47k/zjt7u++x4jxGxBkXwx5ZilEow34XPaU0jYblHM3qDUZsxE+RB1XFQmia+YNWBOTBobHuGJPyPyb6qhGd8ggNG1gR9UH5AkrOKCnKJm8zEew1dv8qWr3DTgfbP6AC72jXAjkaN85rUHOl20uIcASWBstOPNrxJk0OtqLZUvZG5Qob4l+CmXubhB63a6xK7aenTjjM7ZBIXVMCW3gWmnL6Z8BLX9dIHLY8Iwllyc1kcd3T3yjGS8VeCM7AwXaT92Cggn+e0Vu5/tYuU/TprDHmUSnWzTeowUtpp7xgw5ubNd9jmYYTgV7aAwJOr2G+3znKoneqtqCNYErtqg28k2XkbFiMdYJo6QtOvU61jqK+d+zH1c5ySsNTPYfT/k1xZWoxZzwxh5wX2XcK2u+/Nesx2SPJjmR/L7NDTfyITyNoqNzRkHqm4UcvEbM8smxOm1BLMavB/zc6RWKaY0IPwc9CaYiQSJWdB2udOVwjTy8FZlsKQLInGauk+4By+mbhMN7YAkuBXsJiKtGovnEudwMLjrQh9bUOaGEAaSld0akdiyN9Uitp6+KSQkY0jSGi5onNe6uuuVm58k0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDhRRUEvd2F6d2s3UzRYWnl4dFZDNnR4TER6V210NkZtMk04T2ZhMS9jSFJu?=
 =?utf-8?B?RGlrQkd4OXdsYjhrUEVUdEhwZjNaeEtoVjRFa0Njd3duTExLM01Ra0Z3QWoy?=
 =?utf-8?B?OWh5SW5yOHA4RW1PZjhFMXBmWVNhWGQvUXBUWWROU3NYWG1WMlRqZlVSeXV6?=
 =?utf-8?B?ZTNwbkwrOUZveXVHVG0ycG90WjIwcFdoSTRBRktlVWI0cUNjRHhwY29ScjFk?=
 =?utf-8?B?SmtHWHZydG15ZHZDVkt4a1YzM1B6UXdzOS82MzR2cVFPelZ6WjZ4NkVOZmFv?=
 =?utf-8?B?bjJ1aXhma2ZBYURPYVZHWjA4NHM1dGNnMVZmNzY5dWNDSGtaMUdiazFBZkNh?=
 =?utf-8?B?WlhLa0xNRUxNNEhlVUUwTEVqQ3JJd0RUZk0vOUJ3Y1Jsb0FreFFMNlFmR1dp?=
 =?utf-8?B?Q013M0FTM3BTcnRHRk1oeDVDVnJBY0tJdmR6NUViODdJYUYrTUJ6TlJGV3FP?=
 =?utf-8?B?b0J3b21HYkQwUUJKUEVZc3VIWWdKL09LSFRSVXFldDRURDNNa0pFeHY5bjJJ?=
 =?utf-8?B?K0s3YjZ5R3g3OTVmSHJHcW9WSnltMDlCVGR4UDQ4a0JxKzd6dFRMZ3lSY3du?=
 =?utf-8?B?aGpVMzJYQjdpMENDNzJXeUFkK3Y5OU1ueldTdDhuZURiYmJXMjVrbUtFUzYr?=
 =?utf-8?B?RHhWUThnZVlHSm9LYlpuMkFFOTVQbFRZeEdIclNNdEUycFFrQm4vc0hnSFhZ?=
 =?utf-8?B?bEtwbXN4MXJyR0FhT3dTVTdwSEtlZWNQbUw4TXBUN3VBcDJSc21PUTVmdEdY?=
 =?utf-8?B?K1I0d2p0N0RiMk41Ym1icXpvMWRvcm8ySGZNeEt6M2Rvbm5kNUt0OVhqbVJQ?=
 =?utf-8?B?R1RHWWg3SFFkaitId1ZhTXhtNDdNYS82eHk2cWtBVEYvU0F5T2VUY1R5VThh?=
 =?utf-8?B?b05xS1NOV1RVSTlzemc2LzJWUDdxMm9jYnB3RGNaRkpOaEcxL2pFV1A1Y0Nq?=
 =?utf-8?B?YmltOWJSeTg3dDNQYW16SkVER0lCTDdzc0F4WEN2STYvTkUxU1N6M0lDWDFC?=
 =?utf-8?B?a01YbGJTOGZKNU15cDhZb2ZpQ04wMU5xd2JySEd3cklSMlMveGlvb3d4NTBY?=
 =?utf-8?B?UUVQb2NrV1Q3TlhmYkNLL2h6aG9qaGVFbExmN29xQUMwMGpLYWlkVUdVSVBO?=
 =?utf-8?B?ODRMNkpudzViYnVLczZJeGVUVDNzYUlZNEo4M3FVdGgwTDZMb3BzUUhTK2lW?=
 =?utf-8?B?UUJKbFcwRFJCMGR2L1crU1dPa2JhQkhPUjRMYktmVzBCVUZ0citYTjhRdDVo?=
 =?utf-8?B?U05DS1g3d2dNb2VuMmQ3MzdrOStFN2tUMlAzNVROa1R6TnNSbkFnOGhEdnNN?=
 =?utf-8?B?QmlGN2FwY0c3R3QxSUNGYlZXYXEyUEE4OFBBOW9vQUJwODYwNHdScW5lVUVi?=
 =?utf-8?B?eDF0b2JlOEZ1MWpQQWdDMXoreUVzUkwyNWZld1plZndzcTNmTVFtTEM5dnB1?=
 =?utf-8?B?UmJjVG5zaTBoVUg2SXZ3ZWVWbDg3bDhSM0hpQzBGTUxFVTdXU0phUUtuM1Yr?=
 =?utf-8?B?Z0NxZERPaHdnQlozNkpRVFZXK3lVQ2F6YnlxSkF2cEFCdmhjRUV2MjhnNTVC?=
 =?utf-8?B?bHpCUlBIN1N5cExuV3BCU2hLMmdSVTVxTmxtaXlNOHgvdy9yR3NLOUJZdWhn?=
 =?utf-8?B?Q043R1pYUnRKVk55S3JMUnNPQVU4MGZSb1FhV1o3cEwybFJhdWRQdFV2M2M4?=
 =?utf-8?B?OGJvd2V5MnRIRjdNNEhKcC9OcGNDT3NBd3ZIV2hNUVAyQkxMNVRCaGltNnFV?=
 =?utf-8?B?NEdtSEZJUTg3OVRJRzRFWXV4Q0c5ZEVKVGNhNDAxc2lGc2w1OUhZd3pyNUhF?=
 =?utf-8?B?MEZadFJxeE14NDRBSUJEdGtJR21vU1pPTTk2VVo0Q2Y1ZkdiN3JNaVU2a2kx?=
 =?utf-8?B?NC8xYS9pRUt5ck5WZUdQWFEvVU1WN29LTy9vOXZPZWtWU01NaDNFd3dxYmwx?=
 =?utf-8?B?eW1ZK3YvUm81Qk96VFlZMjdjYVA1azl3ei9iM016Y3ZzUlZvb0E3WFBrZkNh?=
 =?utf-8?B?blFpdEEwMG4rWEhLVTVLYW1DcytlZndwcW5xbmRsWmgxaW5HdXhSVXFlVWQ4?=
 =?utf-8?B?RlNndTRqUFJaWTErOGxsRHA4bnA4UWNXb0tEdi91c2VqdEhxWjZHREZ3N0I0?=
 =?utf-8?Q?O8LDwn1yfEKyCdk6JmYew/Anx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a98690d-1e10-4521-b691-08dc59aeacd2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 22:36:33.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /O7lBz5dWQxaheOR+mbKy+EmtLyDGs+b+nfUcPKGbB78OtwM6GBGn8oAohNMGa5t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558



On 4/10/24 11:59 AM, Mathieu Poirier wrote:
> On Mon, Apr 08, 2024 at 01:53:14PM -0700, Tanmay Shah wrote:
>> ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
>> is available in device-tree. Parse TCM information in driver
>> as per new bindings.
>> 
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>> 
>> Changes in v14:
>>   - Add Versal platform support
>>   - Add Versal-NET platform support
>>   - Maintain backward compatibility for ZynqMP platform and use hardcode
>>     TCM addresses
>>   - Configure TCM based on xlnx,tcm-mode property for Versal
>>   - Avoid TCM configuration if that property isn't available in DT 
>> 
>>  drivers/remoteproc/xlnx_r5_remoteproc.c | 173 ++++++++++++++++++------
>>  1 file changed, 132 insertions(+), 41 deletions(-)
>> 
>> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> index 0f942440b4e2..504492f930ac 100644
>> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
>> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> @@ -74,8 +74,8 @@ struct mbox_info {
>>  };
>>  
>>  /*
>> - * Hardcoded TCM bank values. This will be removed once TCM bindings are
>> - * accepted for system-dt specifications and upstreamed in linux kernel
>> + * Hardcoded TCM bank values. This will stay in driver to maintain backward
>> + * compatibility with device-tree that does not have TCM information.
>>   */
>>  static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
>>  	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
>> @@ -300,36 +300,6 @@ static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
>>  		dev_warn(dev, "failed to send message\n");
>>  }
>>  
>> -/*
>> - * zynqmp_r5_set_mode()
>> - *
>> - * set RPU cluster and TCM operation mode
>> - *
>> - * @r5_core: pointer to zynqmp_r5_core type object
>> - * @fw_reg_val: value expected by firmware to configure RPU cluster mode
>> - * @tcm_mode: value expected by fw to configure TCM mode (lockstep or split)
>> - *
>> - * Return: 0 for success and < 0 for failure
>> - */
>> -static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
>> -			      enum rpu_oper_mode fw_reg_val,
>> -			      enum rpu_tcm_comb tcm_mode)
>> -{
>> -	int ret;
>> -
>> -	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
>> -	if (ret < 0) {
>> -		dev_err(r5_core->dev, "failed to set RPU mode\n");
>> -		return ret;
>> -	}
>> -
>> -	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>> -	if (ret < 0)
>> -		dev_err(r5_core->dev, "failed to configure TCM\n");
>> -
>> -	return ret;
>> -}
>> -
>>  /*
>>   * zynqmp_r5_rproc_start()
>>   * @rproc: single R5 core's corresponding rproc instance
>> @@ -761,6 +731,103 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>>  	return ERR_PTR(ret);
>>  }
>>  
>> +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
>> +{
>> +	int i, j, tcm_bank_count, ret, tcm_pd_idx, pd_count;
>> +	struct of_phandle_args out_args;
>> +	struct zynqmp_r5_core *r5_core;
>> +	struct platform_device *cpdev;
>> +	struct mem_bank_data *tcm;
>> +	struct device_node *np;
>> +	struct resource *res;
>> +	u64 abs_addr, size;
>> +	struct device *dev;
>> +
>> +	for (i = 0; i < cluster->core_count; i++) {
>> +		r5_core = cluster->r5_cores[i];
>> +		dev = r5_core->dev;
>> +		np = r5_core->np;
>> +
>> +		pd_count = of_count_phandle_with_args(np, "power-domains",
>> +						      "#power-domain-cells");
>> +
>> +		if (pd_count <= 0) {
>> +			dev_err(dev, "invalid power-domains property, %d\n", pd_count);
>> +			return -EINVAL;
>> +		}
>> +
>> +		/* First entry in power-domains list is for r5 core, rest for TCM. */
>> +		tcm_bank_count = pd_count - 1;
>> +
>> +		if (tcm_bank_count <= 0) {
>> +			dev_err(dev, "invalid TCM count %d\n", tcm_bank_count);
>> +			return -EINVAL;
>> +		}
>> +
>> +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
>> +						  sizeof(struct mem_bank_data *),
>> +						  GFP_KERNEL);
>> +		if (!r5_core->tcm_banks)
>> +			return -ENOMEM;
>> +
>> +		r5_core->tcm_bank_count = tcm_bank_count;
>> +		for (j = 0, tcm_pd_idx = 1; j < tcm_bank_count; j++, tcm_pd_idx++) {
>> +			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
>> +					   GFP_KERNEL);
>> +			if (!tcm)
>> +				return -ENOMEM;
>> +
>> +			r5_core->tcm_banks[j] = tcm;
>> +
>> +			/* Get power-domains id of TCM. */
>> +			ret = of_parse_phandle_with_args(np, "power-domains",
>> +							 "#power-domain-cells",
>> +							 tcm_pd_idx, &out_args);
>> +			if (ret) {
>> +				dev_err(r5_core->dev,
>> +					"failed to get tcm %d pm domain, ret %d\n",
>> +					tcm_pd_idx, ret);
>> +				return ret;
>> +			}
>> +			tcm->pm_domain_id = out_args.args[0];
>> +			of_node_put(out_args.np);
>> +
>> +			/* Get TCM address without translation. */
>> +			ret = of_property_read_reg(np, j, &abs_addr, &size);
>> +			if (ret) {
>> +				dev_err(dev, "failed to get reg property\n");
>> +				return ret;
>> +			}
>> +
>> +			/*
>> +			 * Remote processor can address only 32 bits
>> +			 * so convert 64-bits into 32-bits. This will discard
>> +			 * any unwanted upper 32-bits.
>> +			 */
>> +			tcm->da = (u32)abs_addr;
>> +			tcm->size = (u32)size;
>> +
>> +			cpdev = to_platform_device(dev);
>> +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
>> +			if (!res) {
>> +				dev_err(dev, "failed to get tcm resource\n");
>> +				return -EINVAL;
>> +			}
>> +
>> +			tcm->addr = (u32)res->start;
>> +			tcm->bank_name = (char *)res->name;
>> +			res = devm_request_mem_region(dev, tcm->addr, tcm->size,
>> +						      tcm->bank_name);
>> +			if (!res) {
>> +				dev_err(dev, "failed to request tcm resource\n");
>> +				return -EINVAL;
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * zynqmp_r5_get_tcm_node()
>>   * Ideally this function should parse tcm node and store information
>> @@ -839,9 +906,16 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>>  	struct zynqmp_r5_core *r5_core;
>>  	int ret, i;
>>  
>> -	ret = zynqmp_r5_get_tcm_node(cluster);
>> -	if (ret < 0) {
>> -		dev_err(dev, "can't get tcm node, err %d\n", ret);
>> +	r5_core = cluster->r5_cores[0];
>> +
>> +	/* Maintain backward compatibility for zynqmp by using hardcode TCM address. */
>> +	if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
> 
> The previous patch moved the definition of the R5FSS to the new bindings but
> this is forcing to use the old bindings - did I something?

Hi Mathieu,

We need to maintain backward compatibility for zynqmp device. So, using old bindings
for zynqmp. For new devices (Versal and Versal-NET) new bindings are enforced in driver.
It's not recommended to map two programming sequences to same device. So for
"xlnx,zynqmp-r5fss" device old bindings are used.

Device tree is matching with new bindings. But that's hardware description. I believe,
driver can still choose to use hardcode addresses to maintain backward compatibility.

The end result will be same.

Thanks,
Tanmay

> 
>> +		ret = zynqmp_r5_get_tcm_node(cluster);
>> +	else
>> +		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
>> +
>> +	if (ret) {
>> +		dev_err(dev, "can't get tcm, err %d\n", ret);
>>  		return ret;
>>  	}
>>  
>> @@ -856,12 +930,18 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>>  			return ret;
>>  		}
>>  
>> -		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
>> -		if (ret) {
>> -			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
>> -				cluster->mode, ret);
>> +		ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
>> +		if (ret < 0) {
>> +			dev_err(r5_core->dev, "failed to set RPU mode\n");
>>  			return ret;
>>  		}
>> +
>> +		if (device_is_compatible(dev, "xlnx,zynqmp-r5fss") ||
>> +		    of_find_property(dev_of_node(dev), "xlnx,tcm-mode", NULL)) {
>> +			ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>> +			if (ret < 0)
>> +				dev_err(r5_core->dev, "failed to configure TCM\n");
>> +		}
>>  	}
>>  
>>  	return 0;
>> @@ -906,16 +986,25 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>>  	 * fail driver probe if either of that is not set in dts.
>>  	 */
>>  	if (cluster_mode == LOCKSTEP_MODE) {
>> -		tcm_mode = PM_RPU_TCM_COMB;
>>  		fw_reg_val = PM_RPU_MODE_LOCKSTEP;
>>  	} else if (cluster_mode == SPLIT_MODE) {
>> -		tcm_mode = PM_RPU_TCM_SPLIT;
>>  		fw_reg_val = PM_RPU_MODE_SPLIT;
>>  	} else {
>>  		dev_err(dev, "driver does not support cluster mode %d\n", cluster_mode);
>>  		return -EINVAL;
>>  	}
>>  
>> +	if (device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
>> +		if (cluster_mode == LOCKSTEP_MODE)
>> +			tcm_mode = PM_RPU_TCM_COMB;
>> +		else
>> +			tcm_mode = PM_RPU_TCM_SPLIT;
>> +	} else if (of_find_property(dev_node, "xlnx,tcm-mode", NULL)) {
>> +		ret = of_property_read_u32(dev_node, "xlnx,tcm-mode", (u32 *)&tcm_mode);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>  	/*
>>  	 * Number of cores is decided by number of child nodes of
>>  	 * r5f subsystem node in dts. If Split mode is used in dts
>> @@ -1100,6 +1189,8 @@ static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
>>  /* Match table for OF platform binding */
>>  static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
>>  	{ .compatible = "xlnx,zynqmp-r5fss", },
>> +	{ .compatible = "xlnx,versal-r5fss", },
>> +	{ .compatible = "xlnx,versal-net-r52fss", },
>>  	{ /* end of list */ },
>>  };
>>  MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
>> -- 
>> 2.25.1
>> 


