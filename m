Return-Path: <linux-kernel+bounces-59534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA36C84F885
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE201C23614
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCBC74E24;
	Fri,  9 Feb 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="os9hner1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD24745C8;
	Fri,  9 Feb 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492511; cv=fail; b=Qb+877COCYCiBrBXT1lN5DtSNaXsyiIaLh4W/4iNbenElNTDlfcTuE3XuBDNuNDdmAy+6GgKZMGwtEaar6kI3tB4UgkgdXWhipcE5pJprUwCUcqUO0zte0p4hxYrzeAyk6s6tkwkidHF6UT8XvknD8ZHRnvvaYiJi980rKYa0w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492511; c=relaxed/simple;
	bh=2Yn4ojU38M0iAxT7VUFa3uijZ5XAiEJJTHbEJHVs9uY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jf1IpmQkzyAnh4ECnqMwFqHS+y/l18u8r2ucDIfya4k9eCZDvdoQk7hFOlhYos1f9xj3EEahVFv0UdD/nGu1vvUrPWaejpOTV6IRRtrO3f0MrwJvRq54p2hczeULnoWAkP+cKCm6RQZKxQlUf3k1KIkbpfBEG5ZAR0KXF/tKIQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=os9hner1; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCjVU5uAy+DIcJizpK6HIrDyAvnp/QsiY17jQaktWP8+ts95du3XnnP9k1R9o+BR1ZUkwOY98jRic3gOH32vWv8JijaTowDHsJ9ooZSpLUPQsl+uq1ZGabV8xXPaFBo959ZGBkZuOgRd3X0JmomHfjvAvqUPBpMmmOwH7fAtBuHl/mslC+o7dKwKq1Pmq+cMX78T1juDy/adltddKX/ruvkFcKVI98U5yXFH74CpZh254wIDcmQDexljA4JEh++pURF5NNJC8P5zXoOOl6bTTpjPsvAnAbdcmxKpnRNNrx0aQKgN6YSvDiTnMBkWmpZyhKLgR9ex2cPHgZPJYZyBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV2bEVWqhW946UuFPHEtccow4rTchShQbTPWDy4505M=;
 b=gIUEAzjb3nol1Jkpha7qJcQRmYZITFqECxf9bnaxhtT+dc6DUwlsCSEgGZ2cYlOHHrtypvM24hdnL2dMklgI8GfrwJDfITukFGVIcjOhwqrzSFa+HsvnMi8x2PZ9Dky83dVUiKYRjzEx5IlqSm116HoedvmyuIQi+HJDlq6BFaC3UMUZKEsSG4I79v7qzHpOcermLVVr8QO+LTC5VHmrR4D1/C9r2Jwcr/4KqO+FqbRoAfnKFy8UtIooSDItn+u1y/j4AX3qWiyuXDf0RvdCY4Y1o4rpLCyhiFdXv7PmR6h76j1e/weEzvdx2IDV8Ed5OM/foz9h0879Xk3TEq7/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZV2bEVWqhW946UuFPHEtccow4rTchShQbTPWDy4505M=;
 b=os9hner1Z7Wa+/h5Z0XQnNL9B7xqkKDRZvW6UfmwYThinHUaoNrgQLhDd5GRq9jcGy+6NyZMvjwDNBdYs7EuYh5vbmjPM5909VQ/Eb4FC4KBweNWmSw9r3EI9BGAnu4u5RLLylP07OnGSJWR7LIzFgTBsvfN4TDLbVVgDQ/O2lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 15:28:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 15:28:27 +0000
Message-ID: <fa80f524-eff6-4513-a03a-3fb111289d86@amd.com>
Date: Fri, 9 Feb 2024 09:28:25 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v15-RFC 2/8] x86/resctrl: Move all monitoring functions to
 RDT_RESOURCE_L3_MON
Reply-To: babu.moger@amd.com
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
 <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Randy Dunlap <rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 patches@lists.linux.dev
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <20240130222034.37181-3-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20240130222034.37181-3-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:8:54::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c9f224-23f6-4465-1919-08dc2983c330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ySr05thTlbUOtdDae99XwAs70G1LsSSd25PsPoxCx+uyua6I07bqAPcsmyiFcXBWXNgruN7YWVty+5s+FYS/arxnZ4cWrMpg9hZRPhAy2MZVj9lVSL25W8QVQHCvG/MkupTIZIX/gmwoNewfM1ZWBLBDnFk4FSMqSI5aFEXf9ZesioznLf3/OTMrb4v0vyUDbp2FR1PZFTVW1TgMLOXfmG2v5QVmMKZO7yeh0FnVXcRdNHzvinHmVcyhVKXZMVNjzDaS8ZDbJcqOeKB/JaPxjBQwoJEP6C1Wt2pLk5lU4C8suJfSlg3eObW5RZPyJKVviShRQ3sglZ90OEmiVnFWOncffLXIWfRbyRocKbq/B0LZhPfx+8NEsUr+JOqAMqON1Wf3Z8+uVLElXege39Ao03+XOUMObF+7bEVZfaJPersforI8W3S+xbpR75f5vrvYPJLZ7MiCAhQkd9mFQXG1C2l6hYT0XMpGDq/niMy5imZMKSm6pFf0JHVOreRmOdaF7e9uEtibLctkDkvkPG5qyFK0Np+cgtVP9Toy6XMiQDFfzyTXF2yQXHWdXswlw2Yf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8936002)(3450700001)(4326008)(31686004)(8676002)(2906002)(41300700001)(7416002)(5660300002)(83380400001)(31696002)(86362001)(36756003)(2616005)(54906003)(316002)(6506007)(26005)(6512007)(66946007)(66556008)(66476007)(6486002)(478600001)(110136005)(38100700002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVB1Z0k2VGJyM3c2akVBREpjYXh1NnBMNmtqeGpNNHRiTGpWdlRmaVhtYkpL?=
 =?utf-8?B?eGhGYXVTS2dhSDE1LzdBV1cycHFDNmlNSGx0SjJRSi9rYkRBc0ZaQ0g3SFN3?=
 =?utf-8?B?UFVIQlhPRkFua2JpT0ZXQ2ZmWU12MEN1SW54UVpkd2Z5TDlCcEtVQlU1T0hE?=
 =?utf-8?B?SDhiRzEyY1g2aEtUeGszaGhUZVZqcnZGTzhjaElVMyt6Y0IxT1F6UlZYT3dz?=
 =?utf-8?B?TmVVRW1kSnRoMXR3ZFV5d2E0VDVXTjNGR2RDV2lIU0hQcm1Ra0pySWIzVlZG?=
 =?utf-8?B?K3NBZDVXbTFFQVVocW1OcUdDMWNYMHlncVd1dTY0TVlVV3Ryc2hHMjREcVNk?=
 =?utf-8?B?aVpPY3RuT3ljYW5rK2JNUWhOdy85TU9LZFBheWsrM1diTjM1SDZKdmpyVEt3?=
 =?utf-8?B?TEllNkc3WFBueVV5REJnYmQvUnJDb2U1OUZDcmg0Y0tsV0dPazBZbmluVGlk?=
 =?utf-8?B?R0czeUNQZTBOakV0a1k3QWV5WExob2pyc01TMEdma2hTbGh4QklBVVZWbkFR?=
 =?utf-8?B?czdOclVWOTVVYlM4UDJBclFpYmFPdWM5QW9JNE1tTEV4RnJEenhSakhiY2Fs?=
 =?utf-8?B?VTl5Wld3WGwxUmw3TGhNRERFZGlPUEY4WnlEeGVMVC9oazRGc1VtQWhSZy85?=
 =?utf-8?B?TlBxMFRmQURGMjk3WFM0c1pEUjd2cWxldkdNdGZiTzlkczFJUTVSOFhibzRt?=
 =?utf-8?B?Zlhpc0ZIbDc4SDRUV3kzbURldm4xa2llWEx1cnBmRjFmYW9RR0taVW1Kd245?=
 =?utf-8?B?aVBJeXdLMnJVNU52anF5OTZydTlLTVJxRE5jbVZ3TlIzb29PZkRZQVpRUUFK?=
 =?utf-8?B?MVZkc3pzNyttdXhGSFNSd0FjZzVpSkl4L1ZJcTJ6YXdKYkdKMHg1MjFYWVZ6?=
 =?utf-8?B?d1B3V2U0djVMMFp6cVhWTlBGNndkSmF2bXJzOFlXck4ybmlUMkdPNHkxNnF3?=
 =?utf-8?B?UnNmSUpKRm9YNjZQbUtuYWE3eFJyUmR5OUVZa3A2ZTJQVmtzU3JZRUhtbjlG?=
 =?utf-8?B?ajFnS1g1YWlmd3VUUm90QTdLbWoyaHhZcXhFeVVxbFBJeDUzYjJqazR2TTdn?=
 =?utf-8?B?RXpnWkgwQ3hKY1JDTU1VOVdLRHc3V3hPcEx0bkVBYlp0SEVBQ2R2Nmd2RnRt?=
 =?utf-8?B?NjBWbyt3c3VkdHJhdjJtK3dFeXg3WlE3Y1VpVVE0b21qOGtpUEs2WmsyVzlC?=
 =?utf-8?B?ZCt1b05KeHk3M1hicFF1OHYxaW8yS3dLVlFTR09tSWxuYUNWMytZRXBnWDVI?=
 =?utf-8?B?T3pTc04wNXBBQjNMZnlaazdNVkl6NGszUkg5eXpzY29wdXNhTCs2SDJ5Q2ty?=
 =?utf-8?B?amZwaFRlRFJQR1pPYzVaTFpiMjlyYXg5b2d0L1BhRUJMOW1MZ3JESzJLV2R1?=
 =?utf-8?B?ZkxudDhYTWdXNDh5bUxhUlBUNStUeERDUU14Vm04cU5KeFpKUTJ0eDhaMnhy?=
 =?utf-8?B?T2NxanRqUXAxTEEyMlJybDZGY2lrMEptSDYvUUFGaXJsVVRXTFpmcUVaZlJW?=
 =?utf-8?B?QUpxM1dJNUR6TFZJdnFOaGJXa2pranA1SWxkcWYvamdiUU00N3BkT0ZXUGZJ?=
 =?utf-8?B?OXNzRlZiZDhScUcrZ2pwVXpPMjU1OG1qUWF5Y2RZWlR1eVZsM1pGMzk5VkU1?=
 =?utf-8?B?TmpwY3dqNE9COG85a3F0Q0lMTVE0c2x6ZnNhaHN1MmtaUWlYWENHV294RUpG?=
 =?utf-8?B?a2xQRTFTZjQwNFNycG5EY3BCcnAvQXVGUEgwQ29jeU1GYkZTeWhMNHJia3R5?=
 =?utf-8?B?RjgyNVJmRjZ1WkQyTTJ1ZHRrUEQ0ZTFwM1p5a3ViaFU4QWlscFZFSURzNTdE?=
 =?utf-8?B?dEMzNGlJSU9WL0F6aFpzS0pnTTVKMHVSWFBkVTBqc0ZmR21DTFVMRVVVVC9F?=
 =?utf-8?B?STluYXFYSGh4SUwrZkh1Y3ZjK1pTS0o1eGxWWkxhcG5HZzlBZGYyWFFpa1No?=
 =?utf-8?B?QTNjUHJ0dUhMb2pibTdCM2REVVJZa2V0UWxzQ0swTnEwMjhqUzg1WEhIUi80?=
 =?utf-8?B?SzM1VEp6NnlOTExSUVYwQTRWd1kyejFCQWJBSFpBZ1QwNEtpQWEyRHdvT2s0?=
 =?utf-8?B?eGdMUmkrN0tENUxRbWtoaGhUamxQNXFQSmN0c2VDeGpkY2NUSVkzc1hXUjBF?=
 =?utf-8?Q?K2Ok=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c9f224-23f6-4465-1919-08dc2983c330
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:28:27.2891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJVox+WNdPTNkZ4sndLekELzv6WrBNYDMCMvLTudKeT1ObIFcyszOkkyju1XZx9s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

Tony,

On 1/30/24 16:20, Tony Luck wrote:
> Switch over all places that setup and use monitoring funtions to

functions?

> use the new resource structure.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++--
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 12 ++++--------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
>  3 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index c50f55d7790e..0828575c3e13 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -591,11 +591,13 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  		return;
>  	}
>  
> -	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
> +	if (r == &rdt_resources_all[RDT_RESOURCE_L3_MON].r_resctrl) {
>  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
>  			cancel_delayed_work(&d->mbm_over);
>  			mbm_setup_overflow_handler(d, 0);
>  		}
> +	}
> +	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {

RDT_RESOURCE_L3_MON?


>  		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
>  		    has_busy_rmid(r, d)) {
>  			cancel_delayed_work(&d->cqm_limbo);
> @@ -826,7 +828,7 @@ static __init bool get_rdt_alloc_resources(void)
>  
>  static __init bool get_rdt_mon_resources(void)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3_MON].r_resctrl;
>  
>  	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))
>  		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 3a6c069614eb..080cad0d7288 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -268,7 +268,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>   */
>  void __check_limbo(struct rdt_domain *d, bool force_free)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3_MON].r_resctrl;
>  	struct rmid_entry *entry;
>  	u32 crmid = 1, nrmid;
>  	bool rmid_dirty;
> @@ -333,7 +333,7 @@ int alloc_rmid(void)
>  
>  static void add_rmid_to_limbo(struct rmid_entry *entry)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3_MON].r_resctrl;
>  	struct rdt_domain *d;
>  	int cpu, err;
>  	u64 val = 0;
> @@ -623,7 +623,7 @@ void cqm_handle_limbo(struct work_struct *work)
>  
>  	mutex_lock(&rdtgroup_mutex);
>  
> -	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	r = &rdt_resources_all[RDT_RESOURCE_L3_MON].r_resctrl;
>  	d = container_of(work, struct rdt_domain, cqm_limbo.work);
>  
>  	__check_limbo(d, false);
> @@ -659,7 +659,7 @@ void mbm_handle_overflow(struct work_struct *work)
>  	if (!static_branch_likely(&rdt_mon_enable_key))
>  		goto out_unlock;
>  
> -	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	r = &rdt_resources_all[RDT_RESOURCE_L3_MON].r_resctrl;
>  	d = container_of(work, struct rdt_domain, mbm_over.work);
>  
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> @@ -736,10 +736,6 @@ static struct mon_evt mbm_local_event = {
>  
>  /*
>   * Initialize the event list for the resource.
> - *
> - * Note that MBM events are also part of RDT_RESOURCE_L3 resource
> - * because as per the SDM the total and local memory bandwidth
> - * are enumerated as part of L3 monitoring.
>   */
>  static void l3_mon_evt_init(struct rdt_resource *r)
>  {
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index aa24343f1d23..9ee3a9906781 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2644,7 +2644,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  		static_branch_enable_cpuslocked(&rdt_enable_key);
>  
>  	if (is_mbm_enabled()) {
> -		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +		r = &rdt_resources_all[RDT_RESOURCE_L3_MON].r_resctrl;
>  		list_for_each_entry(dom, &r->domains, list)
>  			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
>  	}

-- 
Thanks
Babu Moger

