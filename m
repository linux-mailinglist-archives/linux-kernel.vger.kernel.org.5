Return-Path: <linux-kernel+bounces-140341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE738A130D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBC11C21886
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB1213DBB6;
	Thu, 11 Apr 2024 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zg3C2RYn"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98B145B08;
	Thu, 11 Apr 2024 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835179; cv=fail; b=ZFhJlIb+getP46j3hxaLzB6NSHCb5O3yjUDzdd/h/2fNfWUvsnmcfTIzwUQy14/jJBveqSfT2yucLZO6NYtrmLwCojXYEh04HMZNyX8AaMZS+z2AW8XzWBXXMzz9fCpiMsen8OLKzzlQzggxMBdWOJGvxPjhgE/KUxceNH5yEz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835179; c=relaxed/simple;
	bh=+QA2SnO6XGf+smgWyd0C0csuSC7XyvQyG48PFnPKXuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ohAly54Kcr2PllO0UeDuPA2onRzfQj6foCk1FSyrTigViXFJ6eXQpdlvfJlwOawc/sGhliVmE5GUhKKK3CI40t+zDl5Y+vUVvfeEBV+H0yQ316Iyc4CUrZptGSfd3T7/ppuPMfObH+uWoQcj+G8IX5xsvAKVCdUkzBME1KdObg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zg3C2RYn; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8T3iPAoQCfHv941zL5WpSnJfC8g3evVVOW3qhoXg5inj18D9ufX2Bf634pnl7cb6fJN4IiFIIIO6m6Y1KDIfX5qftlyhz3L8diWpUXil4pvfAsQMfyuJ30qP3FG3Ap+M/Ewv6P1H0V38Er77Adg6gX3jc17ChkzzCOqCqevhbk8IAnVQkgctDooi6lUcR6Fzznmp9oo/pVjBLIxktSWz/1hDMHFOSXAivf1Ju7FF4oxYTDAPMsHyM8OKIhN507UZhDCwmcVXXZfjZm9P6Bii3q8kEqzXmzPZ+6PlhLB3rG4YgAS2JxgEW4S9euZVBHbWrB9YGVafa3IpPIXC3mxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCAMdfRx/8kUYegzk9aC4ZrDPaD747VxmAbbM9h/NJY=;
 b=AgvphQ/1e4NAGAuRbnYikSIQDc+2rou3lwPJS58ubHLAU+qjD6f8JQVCeHPHsbUq5kwuVfKafYpCOK+67ZnI06ZnSrXmC5ION3ne1PIWuHtpWxo85eDW9V5yCrFhaFTB2ZYnvYUXcyFlgSS941G89YYyorhws8jOx3sbDo67fNZu/ZlX7fF4F7qgmdQsqEJkGSUTMX57ml3mnTl8hRgz4d+48T56edKbmOwgep+DtL8/Huw9JVV7NXLNPAbtOWsMl3UdenL0Lx5CEHcFPVsLBQvNYQC4nLD5wUmQuaKIWQq2Sn0led02VPad5JC2rbtMdMtw71Gye7S6w/Xrb4Sb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCAMdfRx/8kUYegzk9aC4ZrDPaD747VxmAbbM9h/NJY=;
 b=zg3C2RYnUKtl9seiEZqFg1ZHEwxdUhhE6U8234k85Y0hJTeXRaD70Tyo7cM4vw7ihv0zo1POw3akpqCCSGLuGyAXXm6iJFJr2ivvo3Yk1q0ltDpvXnK8XgyAdLg9eAYTd8o9QKekFUeTu3yOyC0C9+u9IKi2kHYUOKIMwRThEis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) by
 DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 11 Apr 2024 11:32:55 +0000
Received: from DM8PR12MB5398.namprd12.prod.outlook.com
 ([fe80::23:4a6b:82d1:a8d]) by DM8PR12MB5398.namprd12.prod.outlook.com
 ([fe80::23:4a6b:82d1:a8d%4]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 11:32:49 +0000
Message-ID: <9abe0c09-efa5-4ff4-b423-469a2dd34ef8@amd.com>
Date: Thu, 11 Apr 2024 12:32:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] flow_offload: fix flow_offload_has_one_action()
 kdoc
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240410114718.15145-1-ast@fiberby.net>
Content-Language: en-US
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
In-Reply-To: <20240410114718.15145-1-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::10) To DM8PR12MB5398.namprd12.prod.outlook.com
 (2603:10b6:8:3f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5398:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f0a9e5-2599-451f-aa8b-08dc5a1b1d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iGQ9c5Bne/aBpuqrk+2R3edyCOTNSqVl//TCukOhNw/fvZ57KunloVQRr8CQIGsTuZJjwWu9y41Ql1vy8wNdboni4XaYylxWeEVyFU4cSbTcdekI5UU5fwu84yrMoCRVJvFUpaSUQtT4O2uTHvOXpXUg+9lat46+eBn/10tnIe5DYFMhB1wlR3LAm3IgCwmJ6aVMuvwOCC1QEQ8zREYkfM3NtEQD8nyQOZ8hsm0jfAnY05gHcSeTgaTG0f4D5jTtVS5UPayUngVJkoeGt/ba8Wm7f5pJyz1WANgVoOiUn9oyQaQJfLEC5mZoh87eN5HO80HDphKP8GeWNDhWNtlP+v6GdvBK8jjveFBfwe2txaw3MLjZPUhUZwaRIhbyKd30CyYAVQaKXTMjSftdVcnk7MxX5tHoqQLs/6I4LakDzjcphgNlVznJacM9oqtX+fVpFUXX55dELh525ZvQ6MPLmYAkg9NFs/uDxC41T8NuVAT70ICB4zE6ZeyEduqju7SEcpqK0C7p4IaZMbveyozMnSM2ZudWN6doEipmBcnoHJcf1h76Z9682sRICMqzOPnnya4yDLLIQeoyl9gIvcGe7hFaEWSTUpRLaoKuUMQpf//WQ7xUUmt1cbv2vaAAd9ULTyw3JlgQUkfUuCFClDF0FQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5398.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFJ6eUFJWlk3aWwyQU1VRlVTNGViMWNOTldaUjAvN2g5REhUYVlicWVJZ3Y5?=
 =?utf-8?B?RGQ3NEVndUtLV0xySkxWOUtuclFOY2hvWWp2bHpRRk04cW9qUkpQQkJOM2tC?=
 =?utf-8?B?ODU3T1F6YWg4eG02YjRJNWJ2UURReXEySzhqVEpJdEE1OERhVHZNSk81Qnhj?=
 =?utf-8?B?LytVRExiQWdiL0M0cENtMVZpOTVQT2djeDIxL2V4U1EycGdvdDNLd2VnMWNL?=
 =?utf-8?B?dmg0NE9iRktEbGFBb3ppcXlSc2NDMjdCcDEvK0JHMVB1MXQ0UWxmd3NtZjla?=
 =?utf-8?B?YUR5cVdDZEpkRndwa0lEQXhaMHBxQ3hMSmNlak9WRDNOcndxSDhIdXJ0RjFG?=
 =?utf-8?B?OFU2UDVuSmtMa29TSGhrVUVEMUNhWGFZRGVmR3hUYk5DUFFCUi92MlRTR0px?=
 =?utf-8?B?TWkvaEFyTFBnSUFkSzVYQTJhWW1lZUMrbjVEb2Z5S2RQTFhkQitCRHVCL3dS?=
 =?utf-8?B?eHFja25sSVFTZVJMdFV3ZElWbTBGRXNvTUxJTnZKWi9ISEszMkVhRVZ5ZEdY?=
 =?utf-8?B?dHpORGp5dHhJeTBGT09vamRGZFd4a0dlUG1oVEJpTE9HQ3BOUG5zSDdTS1Bl?=
 =?utf-8?B?S21FQnlycXNVbEMwYmxxbkZ0RWxtTjY4TFJldllwNmIrNXBCUktuelZiSDFz?=
 =?utf-8?B?UUw3VXhPSzIvMzBtV1hpd2hFQnlHdndMQmpiUnMzM2dlTHVQaFRrbWhHZ21G?=
 =?utf-8?B?NU9YK1pQbmdJcWM2NVpsY2hLZFVYUmhxc3d3MTMzVlhJYlA0RmVzWVpDWmps?=
 =?utf-8?B?ejBLMVpEMzJRL3NFUzVMdXZKNmVvQm5KblB2K1VDWjdTQWhTMFIyeW9wZU5y?=
 =?utf-8?B?K1Y5cW5LOC9TY3FLdzBpQUg2end2eHBIZTJqV2s3WUxkY3E0Zm1NVFNIdVB0?=
 =?utf-8?B?SU1FczFkV0Y0YWszSExpblhOaHhtZXRoTSsvelh1M2VlWFFJbWxucjNHZGw0?=
 =?utf-8?B?cjNTSTZSVGF0TEVzU2wvZ0xJbnRQeVZOc09vUFZabitmdyt0Sk1YTTBFbGcw?=
 =?utf-8?B?c1hGdmVrMEhDY1B2ZFlmZ3c2Ry9jbFVZSW93RnlkR1Q0aDYwYmlGZlJrS1hv?=
 =?utf-8?B?TER2N0MzbS85UXdOcVdab2trQy9WTXgwRi84WVV2aHZ3d21yaVlYVktnTjBV?=
 =?utf-8?B?OFhpcXJCSWU5NnZ4dGR0RWxpTktmRDdTRDhxTURBekEvTGZvUzFCQ1dnUmxC?=
 =?utf-8?B?OW1DMXVKTnVldDhpSVJxMU1aMjRMQ2xOZlhJMFlGVTFUNUt5Rm5WaTdRcUdV?=
 =?utf-8?B?UjczdTE1TDdqYWZHR0phUytYV0Voem1QcGw3L0RGS25maGpXNDRpNHVJUHo5?=
 =?utf-8?B?YmRqQ0E4OWM0dVBMMHJMMlZzM01pa2JEeGV3SG14bjAzSzF1dngwT3REa0lv?=
 =?utf-8?B?enRlYzFLNXhrZ1JlWnU0c1UzRVcvbUpjR3JDY0JtNDhWaStoS0NKK01MdFR2?=
 =?utf-8?B?ZmxQWFZzejZNNXZIOVBxNXR5MjVVY3RpQk12eVN1aXpINmczMGE5YmwreFg4?=
 =?utf-8?B?RGQwMGxoeXJueFBRY29WWnFGYnN2S3M4RnpVT296cWh4K2lBR2VScy9YL0Ja?=
 =?utf-8?B?U2RwS1RZb0lPVzdFTndGcWNLT2h6L1RtS3JMUFZkS0IyelByU3BONDhMSWJX?=
 =?utf-8?B?YzJZQlZnbVRTQ0R0Y25ISDl2YzlxNjBQYXpDQlgvaEkyOGJXNUpJaWZNTUNZ?=
 =?utf-8?B?aTVOR1phTlBKclFrUHNoR3FqbUhRSk1QTXl5N0t3cTBaUDVVUG9iNElLdHp3?=
 =?utf-8?B?QzA5RDVtaGppYWtyYU14TUljWHVLN1drQmJZY2JwR0xyVjJtKzYrQ3cxSHdJ?=
 =?utf-8?B?QWFqUU9zRjVYd0pEeVNkZVNPMHZ4NGQ1a2grVTRUK1NEUWxEdW5XQUtrdUNM?=
 =?utf-8?B?V0I1eUdSVFE1Y25GU0xoQ2NRZ1F3Zi9qc28zOWs1QjVWd2wvcmF0RGlzQURN?=
 =?utf-8?B?b3NuOUlsdVExc3cydWRxdjVwYithdmY0SnR1SUhQVkd3R25uSG5rTWZpNUVn?=
 =?utf-8?B?Q3pJd1VWMmRRUG9YY1lvRjg5MUtWYVdzdzVBck9OOEpvaWVOUEhkcC9sK3dn?=
 =?utf-8?B?Ynd4bjFYZmo2S21BUkcycHFEZ2hmRVUyMVlWQkFESHVzWnRqUE9ITjdESlFn?=
 =?utf-8?Q?6LAv264M8Zzv+I0DsLEr5+gif?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f0a9e5-2599-451f-aa8b-08dc5a1b1d92
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5398.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:32:48.8733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gh+mjFiLjLoERJjepHEzqr54sJmns3MjM2uf/5Fn6uT5dey9v+fe0BqjnXLaOyBN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464

[Removed my old email address from CC]

This LGTM, thank you.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>

On 10/04/2024 12:47, Asbjørn Sloth Tønnesen wrote:
> include/net/flow_offload.h:351: warning:
>   No description found for return value of 'flow_offload_has_one_action'
> 
> Fixes: ab79af32b0a5 ("mlxsw: use intermediate representation for matchall offload")
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  include/net/flow_offload.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
> index 314087a5e1818..7726b4a97050e 100644
> --- a/include/net/flow_offload.h
> +++ b/include/net/flow_offload.h
> @@ -345,7 +345,7 @@ static inline bool flow_action_has_entries(const struct flow_action *action)
>   * flow_offload_has_one_action() - check if exactly one action is present
>   * @action: tc filter flow offload action
>   *
> - * Returns true if exactly one action is present.
> + * Return: true if exactly one action is present.
>   */
>  static inline bool flow_offload_has_one_action(const struct flow_action *action)
>  {

