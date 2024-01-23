Return-Path: <linux-kernel+bounces-35460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB860839188
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF661C274F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476704BAA4;
	Tue, 23 Jan 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pyoynxFt"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A694878F;
	Tue, 23 Jan 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020685; cv=fail; b=WQvPO/rCSLOINBOc4fidG0WTAUu08Un711r5/1HDjp6BC6sxUu1Y4Rg4ZKp/ncEkCxyvHfp8spHIwqCOFszCIwhl5munmEAPiz/owKaDPVN3zo6KKbI90g7PtEy29j2/5//Y+tNH2IMqJxT2GS9TmoImDkqUS2w85czkSH3lssY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020685; c=relaxed/simple;
	bh=cS5+jmieCeP6tWh7Cd9tRW7End/3BixK4qvb2blMENo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LSKTDBwekoc/2uDCCiSC25afPDPIQwuLktjLKnUxhms7IJPZYDq1yfWUFwp+yJycbEanqZW+9Oktl0Jz40wME0sGYWYn9rC+ueo2zkwt+JUcD9KJD/of7AKXhMWTQQ6CNf/70LJm/TzbnK7l7j4HKBpzNVC/rKknpXX59Z1osDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pyoynxFt; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB9RfoAr7wIvyW5p1wOhgYE1mN2uUqyTq7hLu8Kx1hQ6/O6mMcqKD4qNZGBWGEuDsxWPLS8GiYUo/E9Ozwqye6AJmPerH+zoCJhhT+dzQ3ZrwJ5YdSoHY9EETuSlrg6RsstpWe+yQY7EVZOrh6YxemQ6EM/7XKrAl3XKuK8XgCrDQfVGCj1FnQ0y/4w9JJoXZGHixcHq3yc6BSl1WYec/45PnNokUkPEhlbb04sa3scCxjJgb3WnNJx6JXdm8kHIYxwwSwA7/KJj5kwXoeTVB978pFzLwtV4ix3UAst4Luhm4wW6gFlXojOzGhvmI58/QYTARncHP2JvftmISmp1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMEdRJO/elKEMw9+bpqntUyK/rF4DJ7UukGZP6aV7nU=;
 b=neiZhTVYp/Ttr6K7YhGs0ygzOsWskTJArCSB2qAvrJUZrvRCuWlf2d/mdFSz1Zt1jealX2Ks4ZVen/5NIcaON2PRWGRzrWW9r3YlP0QF94JXRuLhJvF8TqiXQSvlUM9Rr9byWcXNJOrQ239YcCjmTt8AwFFiIi3ENVtzdxivUGx+VKy+4SF70dval3spR29nD+a+bDFBMFoizOiU1ZMP+OfzPJ/4Ss7CIZMdMed8RjWGMkiUeyzEQbTwaEbQe5QIDeeWwpREhd6kR7uDn6IlXWN9cDCSOeM2rijHtzVLSpzOY4pi7MJWFGObHOiFuykq7OjNmD0GzY0zJbzkrilNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMEdRJO/elKEMw9+bpqntUyK/rF4DJ7UukGZP6aV7nU=;
 b=pyoynxFtMnz5owTp6caUsnb0Phxboc3YeksfuIck1YBffJejvtapbqygbLrYBxg0sNgEnVs7jOpyCtZWmjYACK5dQfPAOo7xocNTIMfUsFFSkGUrpUSEM7VJMlRAWc4TX5R4NgXiCoqqfXgnBH2/u1EIxVyI9KJkkxL5n1wB/Hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 14:38:01 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::9c3a:2d65:6c4b:bd87]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::9c3a:2d65:6c4b:bd87%3]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 14:38:01 +0000
Message-ID: <b7bd8769-5f97-4c9a-be80-8d1acac92b19@amd.com>
Date: Tue, 23 Jan 2024 20:07:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix memory leak in
 amd_pmf_get_pb_data()
Content-Language: en-US
To: Cong Liu <liucong2@kylinos.cn>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240123011147.6843-1-liucong2@kylinos.cn>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20240123011147.6843-1-liucong2@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::10) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a474caa-b82b-4dc3-f482-08dc1c20e635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eeveVI7xAAHarwR6AR3RWC5+DuiZxb7RZAYu/iuR7efLNeOKvNX56QAS4VgPYzAwtTMbSTQLQT9Q9vrY96SZUV1E49gpVHcib1+/PIoa2lsI3F+PbApwEfPL2uotQ/nipHHa/AAG9KRsL26u2YxFs08/RHCx15WKY9GDFQY2L9zTM7iib29VnvQEcZogmXnY83K9QAtP5isEIvU6kdbcUkUhU+CLKbAwAp1sU+evuWyW7cfuc0Re1oJuSwF/pVrq+C4dQyr3C7UO75lGBzp3Bs40pMOp4gr74nje6Rb/iM+Mxodv2fc7Vto0fmlozNsWP7ITe4KvHoB4FuxVD84vlsrYXxapE5j3J/3RahpCL0Er9BIZAoZPoijUk772WkrS95JvPk4zyibj7Lmk2jxiTRRwIALhXHx/lYgsQ7usXtFPxryB20i6ZRZdHeczgj6xfNmJmfyM1YjmGcqP8n0a29Opnl5dsxb7QTL3d82n74QvGsYMtSG5ynJqbWaYzrDw8ys1i4LuVYbSzPc7rZwIZxQII3qtet77AG5MSM6X9Q1UHR40omxtlSsF4+gwmrkJDs48KiLqn9tf6XmIWp3LsWoLTBlM1PDRaeKRjIPK4L19fMLAUFkMlta1N3Fut6yXk8U+M7JHeRGAO/sPBVw9dg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(31686004)(26005)(4326008)(8936002)(8676002)(110136005)(5660300002)(66946007)(66556008)(66476007)(316002)(31696002)(86362001)(38100700002)(478600001)(6486002)(2906002)(6512007)(2616005)(6506007)(53546011)(41300700001)(36756003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHdSQ3pHejBielNhc1FKaEdCY29RdGZVYW80Q2ZmNVdUeVZoOGg4MTlVSS9P?=
 =?utf-8?B?RXUxOUd6QnU3R1NYVlc1TW5wY0oxQ3lIaWg4Vlo3UHpmODMyV3prYk5WeXBS?=
 =?utf-8?B?bVl3dHFXQ3FtYi9qVStSbWJ3L21TZmdBSzVFek92MmUwVnFRckg1OWVjUjNh?=
 =?utf-8?B?ZkhzcjJTdWpuRTE3SHNZVkU3VmRDT0NnaStlWGR4OTAvanVkOHpveGVaRm41?=
 =?utf-8?B?RUxweUpZYXdUNm0yNWNJbjQwWFlMUVpkWEFrUkU2NS9VVm56UnVKZ1pBM3pz?=
 =?utf-8?B?czdMdDZZQkNTa2tHTkppa0RFYWhqSzFaaFRqd3hyZ012YW54Ni9nMUNqOEhp?=
 =?utf-8?B?N2ZRU1FCUTJ5dTVTWFFwbDlLR3J3VStWNXVXbURZb1Z1UFdEZzJOdTZEOHBM?=
 =?utf-8?B?VEw1RVB6MWloRndEK0daYlpqTlpCSHJuM2g3M2JtNWFuSkpuOHRPVnU1NjZD?=
 =?utf-8?B?VnJWRzA4bS9GaTZzcTJjZTE1d3YxTUtYcEtqMk5GUTlKYTQ4L0t2Tnd2WTRU?=
 =?utf-8?B?cXhsVCtIVSs2cXB6eVh0Q2FnSEJWWHpoRXZqRm1mY0NSWUJra0hYd0VCd25y?=
 =?utf-8?B?UUJYRzJDeW10czFMbkZFSDQ0RDJtdUhFRkowSWpqTTc2WE83U3d3WHFSZ3l6?=
 =?utf-8?B?V2NkK0kzbDY4ditkY05CaTg1Y3lhWkRzdE52dVdQbWIxbVIxcVZ6ZGwxMndB?=
 =?utf-8?B?amxCSnVKTmtVeGw4cWZZelJKb09VaGduVEE5V3gzQ1ZWZDNYNmk5MGJWNGU1?=
 =?utf-8?B?U0tkeUlIaGhuY2tjNDdLeGdMYkRLenhIeWR0eHYrcDdGYzVYbWViaFp5RGo4?=
 =?utf-8?B?a1N4ZkxVdmplbnBvU2lGNmhjbDdSSXR4dHk1L1NnTnAvdXFSZGpvaE9qTE11?=
 =?utf-8?B?ODd0aUZtS21YcVgyVzRsYmloYXZyWU5xeHhDOWE0WmUvUTY4dlVLcWVtaTMz?=
 =?utf-8?B?MEpjTGRvRERoYmtwNkFHNGZIdkppVHp1K3pJYWNHdittY21TekxhdVJnY29D?=
 =?utf-8?B?MTlQenI2UVBVams4UHV5VmNMWHhSTVI2T0hJSFlHb3JCOEh6STYwNTJvYmdG?=
 =?utf-8?B?b3JsNnA1VzNQYXk0ZFJ0SjQ0VzVQZWtiZENUdUs1TFlBQllkTXZGLzB3T1VQ?=
 =?utf-8?B?NWZzTWhGdld6YWg5RTV3RitoUy9QemR6QkNJS3c5MitxYnpOUEh4aXhjci9W?=
 =?utf-8?B?RjNIVjUvbDZtMUVQOGJKWWFFV3M3K1NXb1dkRTZNYWJIcDFoNlFiV2x6Q21v?=
 =?utf-8?B?OStmYkNSNytCUlhwM3dkSFJkSlg1NHQvOGVoRlgzaDl0M08zcldvL1E3UWRF?=
 =?utf-8?B?TVhoME9NUm5ZVWFYZ0d5VXkyUDgwdk16UkpxLzBybXJCUjNEVElLNHAyYUg1?=
 =?utf-8?B?cjQ5TGNqeGhhRXRrdVkrbXNwejlEY1lyOGJsTjNQTFhUb1dMVEVTMkZ0WjdU?=
 =?utf-8?B?MURiVm96Sk5yMmZkSzJPbHR1QWZNSFExYmpSdXJtYnd5V1JJVWpqeTZlYWYv?=
 =?utf-8?B?UktrK0pyOFNQQ3VHTjUydzNBNTFod2NBT0tOYWZFYWZ4QmRCQTIxM0JhWWxj?=
 =?utf-8?B?Y0dHc0xMUE9jRWkxSkNQNXJ4Y2ttTzJmY1UwQlBITGZ1dGY3RnZVN2YxeU11?=
 =?utf-8?B?UkEvK0hYa0pOWXVlTmcrNHVIMjBqa0pCL1QwRGo0NnRBV1RpRktGcjRsVVhu?=
 =?utf-8?B?ZVQzYVBySStyL2J2bXh2MVJDckpqOEYvcDlqbENES20yQnlXdzJRbnlwZmZw?=
 =?utf-8?B?TTNMVVoxbnRKd3o0MjJYMlhFUndvL0ZnRXF5aC9wS1M0K0dONEMwOXVIV05w?=
 =?utf-8?B?QmpJZGJSNXpXOVE1UmZYcUtKaW5XM0w2bTRIZ0VhYUVjYjhYQ0FoMVNvNUJM?=
 =?utf-8?B?bWlMUWxGY05jMmN4Si96K2RVbDFDZzBkOGVUb09aNWFVNlV3dHU2ZXZUVThI?=
 =?utf-8?B?YzJtZ3ZGUVpYbDg3WHBadVpNbGMwMzZQdlRvUDRnc0JBMDhKckNCdXlyVHJN?=
 =?utf-8?B?cWw2WFowNUxqWk1oMTJaY1liME5WNXd4WW9jWldFMHVOUklhb1E1VW1jcExW?=
 =?utf-8?B?QmFVSGdBKzZQNmxhZXBJSkxYWWNVeCt1eTJScTVnSXpRcm10WWNOZXNiOTBt?=
 =?utf-8?Q?R15M61AK++Q8pXO4gMwQB/VKK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a474caa-b82b-4dc3-f482-08dc1c20e635
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:38:00.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFbdfY7KStR0xMtNyto8/QZ6PcUjJltMF+DOISIB2/y9O6aI30iBX/54+uXR8jPjRHM4pVr9kWAL8HCZUM3MUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385

Hi,

On 1/23/2024 06:41, Cong Liu wrote:
> amd_pmf_get_pb_data() will allocate memory for the policy buffer,
> but does not free it if copy_from_user() fails. This leads to a memory
> leak.

Thank you for the fix and looks good to me (just a valid Fixes tag is
missing.)

Fixes: 10817f28e533 ("platform/x86/amd/pmf: Add capability to sideload
of policy binary")
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thanks,
Shyam

> 
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---
>  drivers/platform/x86/amd/pmf/tee-if.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index 502ce93d5cdd..f8c0177afb0d 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -298,8 +298,10 @@ static ssize_t amd_pmf_get_pb_data(struct file *filp, const char __user *buf,
>  	if (!new_policy_buf)
>  		return -ENOMEM;
>  
> -	if (copy_from_user(new_policy_buf, buf, length))
> +	if (copy_from_user(new_policy_buf, buf, length)) {
> +		kfree(new_policy_buf);
>  		return -EFAULT;
> +	}
>  
>  	kfree(dev->policy_buf);
>  	dev->policy_buf = new_policy_buf;

