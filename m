Return-Path: <linux-kernel+bounces-49116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB0846605
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE9F1F2538D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C877DC130;
	Fri,  2 Feb 2024 02:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="0ZItpj1R"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2091.outbound.protection.outlook.com [40.107.21.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B77BE5A;
	Fri,  2 Feb 2024 02:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842349; cv=fail; b=B+AiJn2HssXvt459nI6m+OE3fL1Q8t6QkYb7yNlHkXwopmxYZgsW+moXqqBEeAIwT9IMDiAJZVOzHoF+FZcq8GlF4SBZlGxR6aidY23hIyTNuaM74YFZ+HcRtTGi7TZy/uJBwTOHKXsc5hwXzGM+qZzxLk7tIOKddihv/fjDVLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842349; c=relaxed/simple;
	bh=bX24hQVdsWa9j+Fn0mvqvZFFg1T4LAha7LLHwYFW9/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ONKrDvuE5kIT36ox8ykDqem6bXH1urwVpWv33fYEzJ6P7HyQHSiWrEy8z4IVYQ9iAR8O1RMGsaZS0UCKWk7E3aUtl82aGCneyV9ucS6fF08gnK1JZfKlm38LfZ906e4h/M621YMdv4geJej+wc5Ky89SqFCXHC82P7867NpdDNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=0ZItpj1R; arc=fail smtp.client-ip=40.107.21.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NltgOeAHktMe86ZfIxHk/q2A/Rc84NyH9EatsNrjPnFWM9CglZ37/KIr4xjnch7J3nFhEte7XmnrZgCVoP93mSbgt35dgNcuWpSiwDAeoAiiaWmCDBnaqzfUzwjY4nMMkGFh8M/LgVPcISWcD5oqiJ10VU3/eq/yVZPH0WemHbMdaIHRYAsxslZugLFjSrQYjxZaY70bJz/9Jo9jqySvHmvZB5h+ErIJxu6Dm7LWBSrgJoRyM9ny0t7Y5VZo6JxUCPRxNFkCtzU+A0Kk3Uv0syM+8QUIOu+ql7L1hsgYHGKPn/wLwhX1//IM2Y0vkpzukOuu7ppSIhzJItE2vkowtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDbBxhHsmUY4ysz4sD8N1pcbNaC/4fGEBeMsKeth478=;
 b=R87FoWEWmX6VyWmVfE5cVa/e8MFabtQPz8DDMfQXOQKcswDFZh4WSrEZkVLhszQ1FPNTgZpTV3V02D9+ntCEeb4Ze8GgAO3QVHfqz6+LDGSmu3pV+r5LFofUjc/b2u4h6VO3kRAlhpk0MB6UHuUYA1EG+ptqhfN897znk4JHpiXxV1DyYb89NpkCqNa8lkv4kGXUOYxm0XSWhhxfeD//xXPGllevwthxBB2x6vxC6P6sXsiPJnhtKjm4XPMR8DxXjWzwnYBVR4Zl02ONBAjRxu9PB4dIBbudfl3hhZekRsTxRk9H/dYA6Jr/7MIGnRL9JpbvaPmCAwCXtPRfQphhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDbBxhHsmUY4ysz4sD8N1pcbNaC/4fGEBeMsKeth478=;
 b=0ZItpj1R4Z8z5o2Y5XE3ryW8Q/ehhGoLh8XeP9s/KgNvjuYhbtQVw+XM3xSwMEa5Tcge8v1pNCDs37NbmKsnbT5mAGfsVh/CgfDCGg43cTaBQ12TFmPvqaUlSOPJ4gw0HRQshvQTc4SKGbDW+T8BeeX51w/0ZZRxeKFV+j8k4fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from AM6P193MB0408.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:4b::27)
 by PAXP193MB2108.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:22d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Fri, 2 Feb
 2024 02:52:24 +0000
Received: from AM6P193MB0408.EURP193.PROD.OUTLOOK.COM
 ([fe80::87d7:22fe:81fd:2bdd]) by AM6P193MB0408.EURP193.PROD.OUTLOOK.COM
 ([fe80::87d7:22fe:81fd:2bdd%5]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 02:52:23 +0000
Message-ID: <f04f1131-d83a-470d-b7fd-4a14f54fa899@kunbus.com>
Date: Fri, 2 Feb 2024 03:52:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: make locality handling resilient
Content-Language: en-US
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jarkko Sakkinen <jarkko@kernel.org>,
 Sasha Levin <sashal@kernel.org>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Kanth Ghatraju <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240115011546.21193-1-dpsmith@apertussolutions.com>
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <20240115011546.21193-1-dpsmith@apertussolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To AM6P193MB0408.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:4b::27)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6P193MB0408:EE_|PAXP193MB2108:EE_
X-MS-Office365-Filtering-Correlation-Id: c212fc41-2e88-4c84-537c-08dc2399fb35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZtscIoxPO/Gtfg0qZtPMI1XwwxSFP6QL05BQVRf0R8q3dwZBvlINk3x562ePN4nQ3AVLB2KaJxHxHi4Yx5l3y6eMGEQno5RVDGEX3OGc1QdP9CiKy4vbqv2+c2JwMaoChXzvE7cyVZZXXwcIK4ROfo/j/0XpY+0p6f+xwIlN5VmPwPQWZKd7sBxNqraU7/gBgGCoPOk7X6n7QImEK/Y+O57aya6cAf2QYUmOcprilKTJVck4ctvwDFLZkX9LA5UwSCXTfaYQ+LowLfale3YHAx6Jm5q5KQCtCC+cA2NUnCiDtLjdZY+ZIdWMcOJdXNB2A+zoMAozXooDSBx3ENDWDhXalDxikAmw8UcXhzckmjQ2IejnF62aF3MlFBcKvCFXP7kBl9LC3aCL1LWbRxhwRdpodvD1V/m15/l9q5k8PWhIYpaCOGbFiDZkBWcZDRTzsZbBp7moqRUw4E8MB42mQe4QzcjlJsc1ntWqQWMptgWs1Amz9PmnzIPHOs31zYivQcG3+jIkSZMMpaMR+CJLnxUo+E/+BEdDd7K6OTK9kks0tRebNICd+CIJs4ieky4MnfE/3M8uf/i+EaUG9Fu+Eb4C1MDdc9sVOkDQ9oYOzqQg+4ry6H2hL/7jy/f1/ZODWYZAMRlcvPxXfWFtHIcHeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6P193MB0408.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39840400004)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2616005)(31686004)(41300700001)(316002)(83380400001)(66556008)(6506007)(52116002)(66476007)(36756003)(478600001)(6486002)(53546011)(54906003)(38100700002)(6512007)(66946007)(110136005)(8936002)(5660300002)(86362001)(2906002)(8676002)(4326008)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3NLY0xaUlozbFBwcU84c2RLNWliaFhseUlYS3ppUmkyV3MzbmFFdytrTzRV?=
 =?utf-8?B?YkZLOUhIY1ZXSlBYTlVZVW96Q2FvbTRaY3B5K2Zqbk9TaXpaelJmRjlkQXN3?=
 =?utf-8?B?bVNaZ0Y5bHhHTG4ySnJsVnhIZUFFRUtONzQ2Z1pMUExkbjhxYmt2WmZtbDR1?=
 =?utf-8?B?MVFZU2JjL1kvQThGMlhsaGNqNS9Fc2FCb0JEaGxTbHAwMnFNcUVSQTFRU1B3?=
 =?utf-8?B?MVZRci82ZnJGWnZWK0VRc29vcGsxdytaSEVsbk5iRDBOYzVUV0R1cFhRZkdN?=
 =?utf-8?B?UUQ5WmlYWnhPdUp6azhyRjFCd05wWTAxRUhsR3VQcGl2R2JxczZOS3NTaXpt?=
 =?utf-8?B?SVF5MWQ1Qkt3V3hHU1JBNUdOb1Q1MkJrS0QzVE9jaEd4VkZSUG1qWmdTa1BX?=
 =?utf-8?B?eGhCeC9VS3o0U01rL3hOZUVpZUtmZmhweURGUFh0dEtaUGJHaUoyNU4zQTJ5?=
 =?utf-8?B?L1Uxd2lNbFFxNllLcjlOcmMyT1ZOK1BwOW4xWXZ4QkJnZ1BQdFMxeWJCZXZs?=
 =?utf-8?B?cnJFWUdGSGdqeE5XUG1oSzdhdEt6emdUTWFzL3A1UytpQUFRZUNvVWVnWlFZ?=
 =?utf-8?B?RDBJQVlENWE4WFVYK0JXK3ZZcWhQTldLNnI4SzdwN1VjU29EbW9wcWh1d1JM?=
 =?utf-8?B?alpFZ0s4dVpRZzJTNnFzMDF0VGFsV1RnNmY2ZWxGeXFWVGl5Q21wLzBQaURx?=
 =?utf-8?B?S3BCSDdRWCsrSVVoZFBJZUErM2daaEVyWnQwZzhXZDhhTHhRbnMwdGVhTGtx?=
 =?utf-8?B?Yi81aGRpMHhFTWZ1QTB4cVZXR0JlaDNiWVlHMkhEUjNURDhoTFZXbTQzR2s5?=
 =?utf-8?B?d0l6MWRESE1GWExZK2JqN1h1OG1XL3JmUFZYaWp3L0JwSHA1RVpOVXIxd0Ux?=
 =?utf-8?B?dHdYUDhscjViaUhXYnRSUU5oQVFtMWQzQUdod3F4VStuMzVlQ040SEEybURD?=
 =?utf-8?B?WFdPb25aWldCZ05JRjVZdVpNMWp6VDFhOWxUSFEvTkk5OEo2YlhNRHBzVVhX?=
 =?utf-8?B?YWlYN1pDZ1VscUhTSVdwajgzRHIrVEZwWmdKNFNVdGRtd0lTcE9adkpzQUk2?=
 =?utf-8?B?REFqb0kvUDZZUzh6SjdGVlhVY1h4bzJ4QllRUDUrN0ZGcm5zSnArNEtVMkpk?=
 =?utf-8?B?anFHRVM3R0xBYXViWW5yVmFHVlB5aEFzQzlQRE5SclJaZFZaOUVQbjZJV29u?=
 =?utf-8?B?TFN6OUJtVXdBTEkzN1RjTHNURTg4aFVzV1EraXhiL1dRY0ZCTjRLQWIvV053?=
 =?utf-8?B?b1A4Yy9OVDJjcXFKN0dibmRQZXE3c01xQVR0amRQM1JRWWlqU05CY1ZpVGgv?=
 =?utf-8?B?SmE5Q1BwU2xadDFXOGpDb09zTThoWVhJV2ZlcUVXcmtsc2xrd1RJaFNoWURj?=
 =?utf-8?B?L2Q1THRoeDYwdW40QmdvRUU1QVcvYkxhRndTYWRVN0t5WWpBaHRZUEErRXVG?=
 =?utf-8?B?SkZKaVVPWWZlTXcybUp0UWc1eGloSHloZkQ1SnFHY0orQy9hUGZNeVZWcnNp?=
 =?utf-8?B?OWVubXNMUXJ5RlpBbURCTEtLR0xyYS81Wk5LRjFjUTdvL3hRdFR3ZHlaMXVs?=
 =?utf-8?B?TTMvTTBUWmpHVGdqbUJpNU1Hamc1ODZxL2ZIUmZEV0pQSFlwcDl2L1VXT0Zv?=
 =?utf-8?B?V0VEVzNNSUZKVjVGNFE5UUdxUkc1RGtpTDRzbkR2UU9nNFdseDNlczNjUzNQ?=
 =?utf-8?B?K0VYR2Yxb05VUHVnYXZzTytlMmRkUGZBanJDbGFGc1R5bGNmSjZ0NVgwd3NJ?=
 =?utf-8?B?K2VjSmRHa2p0MjUvR3RLU3RQR002NlI3d2dpUDVGcS9TblVBcTFoTTREVFJn?=
 =?utf-8?B?UFl4S2d6a2hYcGxxMWtXTllqRVJTUWVmUlA2WXhkZ0sxckFPUnVJU0Nkajgz?=
 =?utf-8?B?c1FBZkgrU3h1bDUrK2NrY0JaU2FjbE1KSnYveEFCei9hVUEvcGk5a3BxdS9s?=
 =?utf-8?B?WGQ2cDNRWkdOcmZhbTVJcEIyc1B5S3JLV3lYdDdXb05NN2hMZWlPRFd4L0wx?=
 =?utf-8?B?dFI1clQ1RVMvcDVkcm5zanBvNVEvVG0xdGF4WkJYU3d4Zy9qRk1odmFKSSs0?=
 =?utf-8?B?UUpNeEdEMTFnK1dNdFdLNzU4TE1WczExTFE1dzkwb3FHa1FmR3VZUEhrRjdJ?=
 =?utf-8?B?Z1g5RlpNNnJXK2JEeHZmWUVMS2F1Vm9QQndUeWNBQzhpYUtTVmFVdXFWeWNX?=
 =?utf-8?Q?a9l0xkRupkE9aY2EPYCIhDldn2JSThT4Kop7qeHrnRxd?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c212fc41-2e88-4c84-537c-08dc2399fb35
X-MS-Exchange-CrossTenant-AuthSource: AM6P193MB0408.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 02:52:23.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l48vyIk6Sscw5t9/rtiINw8qzoW1O1b5mFZJRe0O51/rb4fXGL6QKgnfUiAxdUFzi3vPKqnf20MozSjHLbmA/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2108

Hi,

On 15.01.24 02:15, Daniel P. Smith wrote:

> Commit 933bfc5ad213 introduced the use of a locality counter to control when
> locality request was actually sent to the TPM. This locality counter created a
> hard enforcement that the TPM had no active locality at the time of the driver
> initialization. The reality is that this may not always be the case coupled
> with the fact that the commit indiscriminately decremented the counter created
> the condition for integer underflow of the counter. The underflow was triggered
> by the first pair of request/relinquish calls made in tpm_tis_init_core and all
> subsequent calls to request/relinquished calls would have the counter flipping
> between the underflow value and 0. The result is that it appeared all calls to
> request/relinquish were successful, but they were not. The end result is that
> the locality that was active when the driver loaded would always remain active,
> to include after the driver shutdown. This creates a significant issue when
> using Intel TXT and Locality 2 is active at boot. After the GETSEC[SEXIT]
> instruction is called, the PCH will close access to Locality 2 MMIO address
> space, leaving the TPM locked in Locality 2 with no means to relinquish the
> locality until system reset.
> 
> The commit seeks to address this situation through three changes. The first is
> to walk the localities during initialization and close any open localities to
> ensure the TPM is in the assumed state. Next is to put guards around the
> counter and the requested locality to ensure they remain within valid values.
> The last change is to make the request locality functions be consistent in
> their return values. The functions will either return the locality requested if
> successful or a negative error code.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Reported-by: Kanth Ghatraju <kanth.ghatraju@oracle.com>
> Fixes: 933bfc5ad213 ("tpm, tpm: Implement usage counter for locality")
> ---
>  drivers/char/tpm/tpm-chip.c     |  2 +-
>  drivers/char/tpm/tpm_tis_core.c | 20 +++++++++++++++-----
>  include/linux/tpm.h             |  2 ++
>  3 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 42b1062e33cd..e7293f85335a 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -49,7 +49,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>                 return rc;
> 
>         chip->locality = rc;
> -       return 0;
> +       return chip->locality;
>  }
> 
>  static void tpm_relinquish_locality(struct tpm_chip *chip)
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 1b350412d8a6..c8b9b0b199dc 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -180,7 +180,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> 
>         mutex_lock(&priv->locality_count_mutex);
> -       priv->locality_count--;
> +       if (priv->locality_count > 0)
> +               priv->locality_count--;
>         if (priv->locality_count == 0)
>                 __tpm_tis_relinquish_locality(priv, l);
>         mutex_unlock(&priv->locality_count_mutex);
> @@ -226,18 +227,21 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
>                         tpm_msleep(TPM_TIMEOUT);
>                 } while (time_before(jiffies, stop));
>         }
> -       return -1;
> +       return -EBUSY;

Why do we want to return -EBUSY now? This does not seem to have anything to do with the
issue you are trying to solve.

>  }
> 
>  static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>  {
>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -       int ret = 0;
> +       int ret = -EIO;
> +
> +       if (l > TPM_MAX_LOCALITY)
> +               return -EINVAL;

How can it happen that l > TPM_MAX_LOCALITY?

> 
>         mutex_lock(&priv->locality_count_mutex);
>         if (priv->locality_count == 0)
>                 ret = __tpm_tis_request_locality(chip, l);
> -       if (!ret)
> +       if (ret >= 0)
>                 priv->locality_count++;
>         mutex_unlock(&priv->locality_count_mutex);
>         return ret;
> @@ -1108,7 +1112,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>         u32 intmask;
>         u32 clkrun_val;
>         u8 rid;
> -       int rc, probe;
> +       int rc, probe, locality;
>         struct tpm_chip *chip;
> 
>         chip = tpmm_chip_alloc(dev, &tpm_tis);
> @@ -1169,6 +1173,12 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>                 goto out_err;
>         }
> 
> +       /* It is not safe to assume localities are closed on startup */
> +       for (locality = 0; locality <= TPM_MAX_LOCALITY; locality++) {
> +               if (check_locality(chip, locality))
> +                       tpm_tis_relinquish_locality(chip, locality);
> +       }
> +

wait_startup() already needs a locality, so this has to be done before that function.
Furthermore you can simply use __tpm_tis_relinquish_locality() as there
is not concurrency involved at this point.
With that you can IMHO spare everything else and the complete fix can be broken down to:

		for (i = 0; i <= MAX_LOCALITY; i++)
			__tpm_tis_relinquish_locality(priv, i);


>         /* Take control of the TPM's interrupt hardware and shut it off */
>         rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>         if (rc < 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4ee9d13749ad..f2651281f02e 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -116,6 +116,8 @@ struct tpm_chip_seqops {
>         const struct seq_operations *seqops;
>  };
> 
> +#define TPM_MAX_LOCALITY               4
> +
>  struct tpm_chip {
>         struct device dev;
>         struct device devs;
> --
> 2.30.2
> 

Regards,
Lino

