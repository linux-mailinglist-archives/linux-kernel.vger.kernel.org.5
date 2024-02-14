Return-Path: <linux-kernel+bounces-65362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0A854BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C8B221CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401505B02B;
	Wed, 14 Feb 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TMMJM2Yj"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1654FB5;
	Wed, 14 Feb 2024 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922164; cv=fail; b=t1z9zwd6oYw/oDFbQJUcNFagUpxLh/dl3XjZnWHJyICPkkuNIV/e9pSdlpeqpJVD4G6Bbmz+AvIVGsFP7ZFyiXDwIoZhQMIJnw1e196XhJGU/Z/hRpcY1l0p2RT70EUyHK/qrM3ivicoypseciYPgq8kqsKu0YfU2g8xZQk6E7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922164; c=relaxed/simple;
	bh=yfKVQADllwzYaKCz4BTkyuoqUOb549QpbSqu0PuPXUI=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T4ULmkwW9Jc6pT2Ay3WpUVpZ02jNd5Gc4YyH0E9BsBoRQ4J5HhGDHk7UudEauwIhXE4LbxIWjwzOZEpy90kq983e8r56tPJQ3q/xZAnxyvjEb5hr+Y3hOHflviGT9NlTjQru2g2YcF+iHbK8BOylCacHeyQZ1RUXFD/3jxVIfoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TMMJM2Yj; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYlPv3UKGhrGiFAR571C5IK3h4wjsFbaj4/3vaRVry4VVtHUy8Ngz++dNRG/7ibtF9AiZeVk1BVNIMUxUdMg1naBpg2ioop9QWKuVGtGLF1byLdtYaUokm8OEs5M5syV68kbHTR8mTJMwzAgFhqlEIyUY35k22WIfwDIXBeFv9cEjqUwoP+JxV0/uOwncQu0ZYzoIam4QQz3smuBZDN11b9kS651sgyCkv38Altipop8A+X0lUUHw6vz5FGOZUB62qwwpRuYTlAQhtK4HSBGgavbsZKNVkQR0N6BFtQ6y8QwOWdliQxRUg26IQ7JahnK+iptF02dNvMtoBtiwlHg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poqa9Jf5nLxA+a8pOVBdv76tECvvhuXqcOZxhr027q4=;
 b=mIEW9+Bxpjj7e7oLgZHR/GY9DkxMyxGcMzhHmaCHdMO/Kgg9ofEq4IVRwMRReeFhxSfzRWMaAxuxraL22XkJNdC5+jy559WmrPHTjgyVFbnLcEMhIsryShG81YxIZdH1ygssXUooYhT+DENcnBa288v6bNix4cgTvnLsPo7ySbv+oeRN4WGHZjrySMVszvq07oLP5fCuFlfbk1HOoDuZdSf8aY+9KEtlqvH1OZyNdpCy1OCoeX91WCE4Jy7/WSiGXG8H2WoKW6n7rbNPEgWG2Q0vZhea+oA1sxqOlfCe9vnuYk163HkfEjBH2FvHI/qdVW9DaqiW0se2rEWNeHHAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poqa9Jf5nLxA+a8pOVBdv76tECvvhuXqcOZxhr027q4=;
 b=TMMJM2Yjpfn1m/JtTj5Z4JURjVsSmESs8R4wHWwlK4oDKgX8EE4fHE8s1K4xmSxUh/FdA8Cejh9bOIfyCP3VVv1pEhiTkvoa3vCp98SJkUxK4hWeRVjHb779lhAHWSkNR4zPW/DsWQTiZLPKHYi5fVOLxtRNR00+V6NjeXMyQfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 14:49:20 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 14:49:20 +0000
Message-ID: <34f22a20-8716-4ee4-82f9-b6dd42029a47@amd.com>
Date: Wed, 14 Feb 2024 09:49:18 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214105106.GEZcybGu7TkvKzutol@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214105106.GEZcybGu7TkvKzutol@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:408:f4::27) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: ef46a9b7-d00e-416f-2215-08dc2d6c205e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H7ip2PswFkGNhG/Bv4JOTpLNCpIti+0ccT+BDj8yquOiNom1rVFRHlEkG/kvzJHmaZMeyyKQG8wC7+u3tg9x2kbIgiEIoFd2KU+xyC1bhpDfHdR0jRg0PpLRrhwIkjzQcXxRq0eqjKi6ID8PHwmSsErfA4HG5ttCFrvrtAGjthRKrzhHJJC8gnQpt1Hm7D9bwo8o4dWco3tI9siaN22RFkJd62igoY2l0riJ7WHaKlv6VWaFEQ4suMogOOt+GJlnhYBGl+Nn0XkiVAxDw32lO4CL5HAFmg5sMK2OzHD663m2i14g3AS8MFtaqR0LJNcVmR4VuNG4epafiVTazJzn8vLg0K2nAeGp2wms4Qb+ZCjBQNtSBw2blzGG7L6aAagMlKwJqSnXhPkB8ToY6wPwgzzG2hStZrJxJiIu5ULn8+7JqHeBoEg6qZHnlwrB47i3bF3505objC4Y6Fcr4HO9+34qORmFS9JAYkLue0OKlrs46NRznaq9pgLaJ+gOPoJrHCDL67DQ5phtvMGx/+LIus1KOf+nQI23hGY1Xr4cKp9QSngq0N8c0EzHevmxYs4w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(5660300002)(4744005)(2616005)(6506007)(53546011)(36756003)(6512007)(6486002)(478600001)(38100700002)(26005)(8676002)(4326008)(86362001)(8936002)(44832011)(31696002)(316002)(6916009)(66476007)(66556008)(66946007)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEd6MlFtT29WK3FYaUJwTVFpR05qQXJwZDNyNkMrbnplbU9taEJ5cVlJY3dD?=
 =?utf-8?B?aUozSDhFUGJVcldNdVhDWU5rVVg4OFBwOVFLT3lDQUtBcFQ2YW1OU3pGanJJ?=
 =?utf-8?B?bCt3ZmplSE1ZTDJWOU9lb1Z4TkZsanpsRWZHY2hPREZsWTMxVDdtaW1SQlU5?=
 =?utf-8?B?anpDWUluckdGeXhEcElHUmg1eVFWbGpCc3hQZ3pheXF4VXJZVzMyUVlwY1RO?=
 =?utf-8?B?ZGl5MHdKbVg2bHNTYThqQVZ4TC90TUloNmdKQUExMlJjOWR6OHJXcXhXYkpU?=
 =?utf-8?B?Q0p2dEVpREdRZmRqL2Z4R29iQUlMWnBjUm5udzB5SzdJT3Y2aFRhRFpmc0FY?=
 =?utf-8?B?UHZNNnpGT1kwSHh5Q0pibXhLSTViRGEzaGNHK01tWkVWanltM0RNOEthR24r?=
 =?utf-8?B?L3RBZytXRms3aFRjSXRRRmJSQTJtWHRBRDBTbFJVcThaVWo0S0pvZVU5Nlpm?=
 =?utf-8?B?ZG13MFNJd3hoOHhRdjdRcjlqSkd6YmM5L1plakFnWWRpQldlY083ODh1cEVN?=
 =?utf-8?B?amNaVXNPZGpWbHNrVE8zR3hnMy85WWJGcm5rSjdCN0RYOUNsdDdLYWkyWkxW?=
 =?utf-8?B?eEtDd2V3TmRnZ2daTkxXNkJrU1p0Y0dTSVVCSlA1bEpEcTB0dW1VZE1DbXNL?=
 =?utf-8?B?T0k2L3VFVG1TRVN5UVhFL2hUZmt0Y1lkbFZaWDVaMG9LU2RIeC9YczRUa2F1?=
 =?utf-8?B?K2YxTlFvenlPREhjblV3ckY5NzVJQ3VuVHk5Tk9HcVUwSk1pQVhlOXREVnZI?=
 =?utf-8?B?MURQWVZDZUdMdmVaS0VRWWlMaWdQVDVhbVd6dlc3YlhpWHduSjJKdWlhaFY3?=
 =?utf-8?B?OUxyODVZcVRtZ3hLUE51RWZ2cmpjQkxzZmJhM0ZzdkJNVnIrYWFqQnlBRlNL?=
 =?utf-8?B?M2FnMEJPYTZ4QnJQRm01RkhmYW42TjN1Wks4Z2hySElUM09UaU1VNHlneTN0?=
 =?utf-8?B?ZzYrdXNUVWVzaFU2bTByeGFZNWtFY3dFSU5aVm5Pc29CaHNhNXZUYUZGTUNu?=
 =?utf-8?B?a0JWUHRhd0REbGVuQlVxZmtqc3hZTnozL2pON0JNNkpUbk0zYjIvQWtyVTMw?=
 =?utf-8?B?dVlhQ1ZKWitsV0xKclluVHFQbGF5WVNVTTF0OEtBN2dKc1kxY1NEOHBKNjJQ?=
 =?utf-8?B?MDhwR1lsRjlFTHAwT0RWenFDNEpKMlpvaTNPS1FCejRrczROMnBvUml0cGI3?=
 =?utf-8?B?MzdGM1BWV082R0JTZVkzUE1KVEZqWjVPTlpDWU1BSzR3WFVVVWo0YVgzYU9I?=
 =?utf-8?B?eGlpei9wS0t0ZlZ2cXpzdFVVYjhFRm5Yank5c2pmbjYvRmltdzI3YkdpSWti?=
 =?utf-8?B?Mm5vWnBOSGMvU0ZOK0ZnUC8zRCtzbnpDODVtdFI1cHhQb1RmMVh1bm5KdXVO?=
 =?utf-8?B?alE2ZlNhbjNYODVsNVRCVjhSY2NYbHhuWW1KTmpRRU0xOGxqR2hDeXlLekVh?=
 =?utf-8?B?YmNxUkMyQmhXZWlzYUtmU012TzBjaVZ1N3VVZ1BqbUpDVzBpbHJQQitFUUpp?=
 =?utf-8?B?anBWbjhBWlZqQm5kcnRydG5hNHFNN1BiT1g4c3gzem5BMGxuTUJULzBVaUxF?=
 =?utf-8?B?TzdqYUxKYjdYTmVpeFl1QjZIdlVvYmtHNzhHd2xnSXBCdkt1cHBBWFdWTnhK?=
 =?utf-8?B?THdBS3BFbUJYZC9qcE1FVXB5ZGNKU1ZMbUZXV2tpclZYcXFjc1dtd0tUVHEv?=
 =?utf-8?B?Y29tSS9RTzlpU0RDaFBZZzZOck03MFdobFQ2K2liRWc1ZWVITmx5TldhelAz?=
 =?utf-8?B?L3lzOU5SNUFvM0xvK2VNT1dhcVRoanVHUm5KcnJmVzNtRVZMcExrSWhyTmRZ?=
 =?utf-8?B?dE9aZDlmUTYyYzBROVA5NXNLUVZkazBYZzZUKzlHTG9OK2NBWEZOb3hveFRQ?=
 =?utf-8?B?OVRLdWRVQlZrTWRjK0NneW1vUlRMUXJnUkp0UGI0MGhXcENKNHdNazhKZUlG?=
 =?utf-8?B?NkVBTkV4L05oMXhpUkY2VVpGMHQ1STlvQ0w0d3FWdU52RnJCNlJxTUZaM0pZ?=
 =?utf-8?B?RjA2K1pkdkNiMmJkT2xjWDB2QzZoSlo5dmZrM0IyWE5vS25sT25RU1R2UEg2?=
 =?utf-8?B?bFl5dG1ZS211OFF5cDZFQjhnZ2lqU3FMaTdjbld0NFJYMSs1S0J3TFFtNzRI?=
 =?utf-8?Q?EMTI1znHWOtpktEqvEP6sHhh1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef46a9b7-d00e-416f-2215-08dc2d6c205e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:49:20.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCsReAaC/215FDEwCi2UaNPPfVURaA5D41uRcbH1hgpZP4P4J6zGZcpQ0rH0mi//4LWYQVg458EGWaHSHSIVdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633

On 2/14/2024 5:51 AM, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
>> +static inline struct cper_sec_fru_mem_poison *get_fmp(struct fru_rec *rec)
>> +{
>> +	return &rec->fmp;
>> +}
> 
> Let's get rid of those silly helpers, diff for this one below.
> 
> The logic is, you pass around struct fru_rec *rec and inside the
> functions you deref what you need.
>

Okay, agreed.

Thanks,
Yazen

