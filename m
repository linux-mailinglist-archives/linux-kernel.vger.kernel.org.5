Return-Path: <linux-kernel+bounces-84586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073DD86A8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8458928521C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFB52375A;
	Wed, 28 Feb 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="WfIIBTMF"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2099.outbound.protection.outlook.com [40.107.223.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B022F02;
	Wed, 28 Feb 2024 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709103981; cv=fail; b=e3H3REj7nmYAMz9rvHLRTM99RVfVtrpuPDBLoQQaRrzIX/FXHem5NbsmOk3HMf48N5U/t9fCja0H67a+elP1usZSGqsq2zylS5ksnaDbbqA90I2r91+lK+nJo9dA/VoyoFM4ykYU08kZuYT0fUMP+Ou4jY1hwFXIaBz+BBe7n58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709103981; c=relaxed/simple;
	bh=q25NZdwFehDvSESAQyQ6tXqTewFalNCqxk4gxNqU4x4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HSuxDyrpc66wyB0cQb+Gz7PNRFltKzcrY8NeMdGECELUXqZxEbOi1X3Cm0mlj99cwZ7BTebCmyaAPy7Du6YSsM8JaIhwuESc9ZrG1MjNsrP5OdnMGtzMXaWY0ctYDq5tmkpJ/D1yvqcVpg22cnfN0oAeIxnXRutKmyNSgRPllK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=WfIIBTMF reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.223.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaobyCju+UZBbcpmF1u6n3eCv0NFzjgyK+eXo+BIw4SG/yt7P28R0VbCd8HcobE9bZkq0tw6lIKcMbOw8NSAGrOZMiqC/EJ4tFRsP77RhCoydCnG/++cN/Z72i+w0sxdlVgLhNamD/lqfarBrdQHul3CF/RUxllc+PRcgbOr4soe4W14n9PGR4cPjO0i7dbMAlCV1uDeUjDyaIJjijUPe6q4LJqTB7TZSbK6p+DC+lRYSMwEdJr36Iwi2kjlHNcpZHZuoWR/CdZnrb/+e1pvrGOKU2Yij3k21q7A3qwoFqOm609uTrlo71AOUVD/i2Nl+d+krImju5MvYO3aiyYCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX1FTTvSjBp7tOUhsGm6enJqO9eWRsXMF6xUiOw/kiY=;
 b=AFq82p/lKIN8C8SoLNus2p0Ag4AgfA76EGJ7noq3EFef/DPPI39UcuS7tG+T6YVS0uKSs0LnIZ8HptchG2aFkRQq6+XcSJa1/R4dHO/a5bbuaVH2qTlk1Cu7QB4rxdvFmRl1ETtqvAQYAEwN6D0hKVXgepv6OQP8CzRS0HfbrpqkwgZW+Ex9iyXC+GY+iK08HLdkjotUgKoSCHxMtU65KCIt0TfFNmtDEEDHWhsRaBcjbyhMzBLJNaSvUFTqTFTeNAaKGhcRy2+wfSNcE5m8avEznS417PGbC+octijoMCyXj7LOcY/9i6w22VRO14rU5L+lCaoRY2dcXY9rQEzqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX1FTTvSjBp7tOUhsGm6enJqO9eWRsXMF6xUiOw/kiY=;
 b=WfIIBTMFXwP+FBGVmlk0hzXBt3qpS85K7StuTACJuEqRtTjUA0m6r4LBBcdIIyGZjMbhYguqMuC4+v1ixqUf/YC8YWREw5UmxubbakEt9WbsCQRsmyIGDWG/B0tPpj5tOd3keeSESgML7Voolef8bH4eCbrT/M7f7oUmy9U+9e4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 DM4PR01MB7881.prod.exchangelabs.com (2603:10b6:8:6c::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Wed, 28 Feb 2024 07:06:15 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7316.018; Wed, 28 Feb 2024 07:06:15 +0000
Message-ID: <018b5652-8006-471d-94d0-d230e4aeef6d@amperemail.onmicrosoft.com>
Date: Wed, 28 Feb 2024 15:05:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: skbuff: set FLAG_SKB_NO_MERGE for
 skbuff_fclone_cache
To: Eric Dumazet <edumazet@google.com>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: kuba@kernel.org, patches@amperecomputing.com, davem@davemloft.net,
 horms@kernel.org, ast@kernel.org, dhowells@redhat.com,
 linyunsheng@huawei.com, aleksander.lobakin@intel.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 cl@os.amperecomputing.com
References: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <20240227062833.7404-1-shijie@os.amperecomputing.com>
 <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:610:cc::35) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|DM4PR01MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf61393-cea0-4101-d9d4-08dc382bc0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PCLTUSS7rvIc/e6bFRog8En1hh+aK9p31Nzt6mG2XwcUmi2TO+j/3EKTAYESRh/sHDGIBRiJbkPaLj94V3NBG9kbJXJd2A9IjkamMVzrSROxGv53BeDYrhGizEMYROO3LEg7rUkBZ19J2pWDU8JdP+olOmdW50dr4OXSuLiEyqbe9quJKHOPR3eBwubwLd0uADS6lTKZlqXjrNAF+jwmFYXkSLzJoch3G61AP37HkD8HTwdyVd3IHQyOrik58trNn3ZFVib8+3+WaAYVxQzknHNCkjD6uFrsC975G/yy27Qoali5JsxsP8YvM9y7EoN/rmWKHLePxbqWruQCfXW5I/j+Y4u9jejfBkgYLSV1TSPoMFCSAunihEFoCwLzFpAIvfzAs7Ym5VUgJiB6cNbo9bn9lhCsvwG8uIm/GyK+FBVFQ9UZji9Si/f50EQb47WCYcBtj4YdHd6czoyrYOV4RIkHjBPZNeEwuZ7lmbVdWd3oM6ONi0l5IUB4UXZatR7kB5atuBzGYMPaYYqN9frdYpqPH4N/GFvtB0FAnhKcRsJMJANhh3UABrZK7G+uhItwBnxyMuPMZ2PWECSJ541Xs2xvhhhCQ8Pd7mgrEcCCr3tFOS17A9LSVEozqWZtPZrK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THVzMHAyL1IxUlhaYldmbUFyRlNyY1dKaWdUUlFkWk5TRHo3T0xpREpUbTY4?=
 =?utf-8?B?dWFFdDZFZkxNRnc4V0VkMGlYajFuRmFGZkw0UXl6VHZNbDhCWmhkb3BqaWZw?=
 =?utf-8?B?NjZpdXZWN1pjTlREMUZ6ZTI0UmdlV2VSWWtEa3ArM1ZLSm9YckJoejFBY21O?=
 =?utf-8?B?eGVJQXlKdUpWRllrSnprM2wxYmRmajMzUkNQTzNNUGlNaVNRdDFMSy9MR2Vk?=
 =?utf-8?B?aC9kVFA5UktZcHdlU3pEL2IzSlBodk5BRVFveEZJVTJVWnFOdWsxcUxCdmVj?=
 =?utf-8?B?S081ZCtadUIvQTBTUmRybko4Q3RTWXRyVlZKa1VGbTR1dUpPeEk2SkpZYW93?=
 =?utf-8?B?WHpZS3FlSG4zL2hLVk5pWlgxMW9nWWRUWVBqbm1ZQVllQ3BSUU5YL2JMbzFm?=
 =?utf-8?B?S1h6dEY2N2xkSmJuTjVmUWYrTTZLYmVud1VSZU03aHJZeUkvdi9FOXR1bU8w?=
 =?utf-8?B?ZlNselVvbUpDQXI2cG1VVERBN0ZQWktFdHp0UXkwRktaazAvV25menJzKzBY?=
 =?utf-8?B?SXVFVGV5Y0FDQW14cnZ6WDF4OEdULzFFWWl5cVdHY2pPZzFuWUNpdWEzTjdK?=
 =?utf-8?B?K2J5WmVBRU5VQTlBWTE1MDN4Ymo4c09obHFEYjcrOG83cGlMaDZTOWJsSXho?=
 =?utf-8?B?NFBBWTFQVEhiRHFBRUhkdGRmWXF2Sk1BREZENDYzaDk2ZGZ6UU5rQlBpME1s?=
 =?utf-8?B?QTJiQ1FXalE0SS90Qmo0TC9uZCtvaVM1WTlpdlFJaGRoQ0NGLy9MV1g4bkFj?=
 =?utf-8?B?d1JycVIrK2tGL2wzYURaRXgxMnFqRTR5ekU5MDVvd3I2VzV5SGpTNVJ6c3FO?=
 =?utf-8?B?bHZwZTk3eVExcm05WSs0MGNyU3lKZWZIeEVaQURLejBiU294WXR2N2g0bUpE?=
 =?utf-8?B?amxxbTVOaS9oRCtubUIwM2RRcGgyRERVWXEvUm9RUVM1SlEwSU82eTdvREVw?=
 =?utf-8?B?dS83UHl6eFVmZHZDWGZHdGNEcUYyZCtmRXo2VnlHUjRiM1FCclBvMWIrY1ZS?=
 =?utf-8?B?L0NZL1EyUCs0YUJMVTEwZ21RWDh3cDlIbkQ2UGRCc2Y4QzN0YU1HK1piS1Bt?=
 =?utf-8?B?M0pNVVUrQi9RR3JPQmR3ZjBqdlU1L09KeEQ5ejNrQ2x0UnNyb1lqcER4UVRm?=
 =?utf-8?B?ZDFBNTh0N1lKbXh1MjhnOFk4MXRiY1gwclhPYUNsbjYvSU93VDMxZWYxcDhn?=
 =?utf-8?B?QVFPN3k5aW16WmM4ZU5PdUZKb3U2cjFGdlpuVldHbko5NmxpQ2lCVWVYZXFV?=
 =?utf-8?B?OXdEU3gxWkp4Z2EvWUtsOEdRRjVQNmc2NmhPSWlxMllvRnNrejcyOThOcDI2?=
 =?utf-8?B?Z1hoNDZDMkxxT0Q4TTRJK280THVPaFFrMlRsaC9TVEd1Vk9CY0o5cFFRNkxC?=
 =?utf-8?B?V29VU1BvWTV0ZjZHNytVbzdqdWQ1TEtNeGlHcWgxeG9MS3Eva0dsU0ZyOGEy?=
 =?utf-8?B?SDZpYVZ3UWlyWHJPNk9mcFJLdFhQRVBJSnkxVEN5a1pVK2p0YjV2QlFMMExO?=
 =?utf-8?B?TWZhTzlyZHVKUGFPa2QrVmdMVGtSdjdaLzlFSlk1ejZYSE9aRFp5Uzh3WmFy?=
 =?utf-8?B?Y21uRldUTXdDbWthMExCYzZ6VFd1UzVNM2M3L1h0OWlKcm93UmtnRU5zeStF?=
 =?utf-8?B?WWx2cEgyV0lXMjUzZHVIRVJGZE1EQnBrSU83MkM4NDJ5dFFybld3ZW5XRllB?=
 =?utf-8?B?M0dIOHpQTCtzSHJZM0xyVlJlOEZ0N3dRakVMWENYMGltRHlsT3hXV0RVczJv?=
 =?utf-8?B?VmxOZzhGUEFjQnZBRHBqemN2azh4MHNRaEFkUFpJMG1ka3hNNHE3bkpnNENs?=
 =?utf-8?B?S1FNMHlUZFMxcXJ3TjFnWCs4cHorM1htNm8zczY5T2RKeVE4OXlNZjhEeWE2?=
 =?utf-8?B?WUd0ZnJGL1FLYUJqYXhpK0pqMm9LZlFRRVJTVldDUjR0Zm9Fbm1QQlhhQ0hv?=
 =?utf-8?B?dHkxbS9NWmhBR1lzL0JQNE9uNlJoRGJXV0dHc0RWY2ExdkV4Q1lNYi9JUGQ3?=
 =?utf-8?B?WFkyL2dsdlF0SktXVWRKK3JyRytCVVJBUGtiaFd2STBqMmRwb2Y3U3pHQ1RO?=
 =?utf-8?B?dk5uZTl0Y1liN3NLTTBsWTFIc1hFOW16eUJxR3I4VGtqL2tkTk9MK0VyQy93?=
 =?utf-8?B?TkV1NUpScTI0a212WTVPcWVBOFZaeDJxTXQxbWQrODM2Q210aUVnZmN6V1FO?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf61393-cea0-4101-d9d4-08dc382bc0b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 07:06:14.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wntD44Vhfg+VzBcfFhrkA8y7YWFqSCv0XCV7NRQcPU0getJV7DUXWX9RWVKl4rOyEx4n3YtO/VavKGYxbl7RZahhQNJJOtZ8wcUHqjiynQ5IwFJRW6pXYGfN8IXr090w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7881


在 2024/2/27 20:55, Eric Dumazet 写道:
> On Tue, Feb 27, 2024 at 7:29 AM Huang Shijie
> <shijie@os.amperecomputing.com> wrote:
>> Since we do not set FLAG_SKB_NO_MERGE for skbuff_fclone_cache,
>> the current skbuff_fclone_cache maybe not really allocated, it maybe
>> used an exist old kmem_cache. In NUMA, the fclone allocated by
>> alloc_skb_fclone() maybe in remote node.
> Why is this happening in the first place ? Whab about skb->head ?

I tested the fclone firstly. I did not test others yet.

I did not check the skb->head yet.

But I ever checked the pfrag's page, it is okay.


>
> Jesper patch [1] motivation was not about NUMA., but about
> fragmentation and bulk allocations/freeing.
>
> TCP fclones are not bulk allocated/freed, so I do not understand what
> your patch is doing.
> You need to give more details, and experimental results.

1.) My NUMA machine:

       node 0 (CPU 0 ~ CPU79):

                      CPU 0 ~  CPU 39 are used as memcached's server

                     CPU 40 ~  CPU 79 are used as memcached's client

       node 1 (CPU 80 ~ CPU160):

                      CPU 80 ~  CPU 119 are used as memcached's server

                     CPU 120 ~  CPU 179 are used as memcached's client

    the kernel is linux-next 20240227


  2.) My private patches:

       patch 1 is for slub:

       ---
  mm/slub.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index 5d838ebfa35e..d2ab1e36fd6b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5691,6 +5691,7 @@ __kmem_cache_alias(const char *name, unsigned int 
size, unsigned int align,

         s = find_mergeable(size, align, flags, name, ctor);
         if (s) {
+               printk("[%s] origin:%s, shared :%s\n", __func__, name, 
s->name);
                 if (sysfs_slab_alias(s, name))
                         return NULL;

---------

   This patch is used the check which is the sharing kmem_cache for 
"skbuff_fclone_cache".

   I cannot find the "skbuff_fclone_cache" in /proc/slabinfo.

   From my test, the "pool_workqueue" is the real working kmem_cache.

   The "skbuff_fclone_cache" is just a pointer to "pool_workqueue" 
(pwq_cache).


   The following private patch is used to record the fclone allocation:

  ---
  net/ipv4/tcp.c | 19 +++++++++++++++++++
  1 file changed, 19 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c82dc42f57c6..6f31ddcfc017 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -864,6 +864,24 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t 
*ppos,
  }
  EXPORT_SYMBOL(tcp_splice_read);

+unsigned long right_num, wrong_num;
+static void check_fclone(struct sk_buff *skb)
+{
+       int n = numa_mem_id(); /* current node */
+       int node2 = page_to_nid(virt_to_page((unsigned long) skb));
+
+       if (n != node2) {
+               wrong_num++;
+               if ((wrong_num % 1000) == 999)
+                       printk(KERN_DEBUG "[%s] current:%d, get from 
:%d, (%ld, %ld, %ld)\n",
+                               __func__, n, node2, wrong_num, 
right_num, wrong_num * 100 / (wrong_num + right_num));
+       } else {
+               right_num++;
+               if ((right_num % 1000000) == 9999)
+                       printk("[%s] we received :%ld, %ld\n", __func__, 
right_num, wrong_num);
+       }
+}
+
  struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
                                      bool force_schedule)
  {
@@ -884,6 +902,7 @@ struct sk_buff *tcp_stream_alloc_skb(struct sock 
*sk, gfp_t gfp,
                         skb_reserve(skb, MAX_TCP_HEADER);
                         skb->ip_summed = CHECKSUM_PARTIAL;
INIT_LIST_HEAD(&skb->tcp_tsorted_anchor);
+                       check_fclone(skb);
                         return skb;
                 }
                 __kfree_skb(skb);
--

   Without this v2 patch, I can get the result after the memcached test:

[ 1027.317645] [check_fclone] current:0, get from :1, (7112999, 9076711, 43)
[ 1027.317653] [check_fclone] current:0, get from :1, (7112999, 9076707, 43)
[ 1027.804110] [check_fclone] we received :10009999, 7113326

It means nearly 43% fclone is allocated in the remote node.


  With this v2 patch,  I can find the "skbuff_fclone_cache" in 
/proc/slabinfo.

The test result shows below:

[  503.357293] [check_fclone] we received :8009999, 0
[  503.357293] [check_fclone] we received :8009999, 0
[  503.357305] [check_fclone] we received :8009999, 0

After v2 patch, I cannot see the wrong fclone in remote node.


>
> Using SLAB_NO_MERGE does not help, I am still seeing wrong allocations
> on a dual socket
> host with plenty of available memory.
> (either sk_buff or skb->head being allocated on the other node).

Do you mean you still can see the wrong fclone after using SLAB_NO_MERGE?

If so, I guess there is bug in the slub.


> fclones might be allocated from a cpu running on node A, and freed
> from a cpu running on node B.
> Maybe SLUB is not properly handling this case ?

Maybe.



> SLAB_NO_MERGE will avoid merging fclone with kmalloc-512, it does not
> really help.
>
> I think we need help from mm/slub experts, instead of trying to 'fix'
> networking stacks.

@Christopher

Any idea about this?

Thanks

Huang Shijie

> Perhaps we could augment trace_kmem_cache_alloc() to record/print the nodes
> of the allocated chunk (we already have the cpu number giving us the
> local node).
> That would give us more confidence on any fixes.
>
> BTW SLUB is gone, time to remove FLAG_SKB_NO_MERGE and simply use SLAB_NO_MERGE
>
> [1]
> commit 0a0643164da4a1976455aa12f0a96d08ee290752
> Author: Jesper Dangaard Brouer <hawk@kernel.org>
> Date:   Tue Aug 15 17:17:36 2023 +0200
>
>      net: use SLAB_NO_MERGE for kmem_cache skbuff_head_cache
>
>
>
>> So set FLAG_SKB_NO_MERGE for skbuff_fclone_cache to fix it.
>>
>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---
>> v1 --> v2:
>>         set FLAG_SKB_NO_MERGE for skbuff_fclone_cache in initialization.
>>
>> v1: https://lkml.org/lkml/2024/2/20/121
>> ---
>>   net/core/skbuff.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 1f918e602bc4..5e3e130fb57a 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -5013,7 +5013,8 @@ void __init skb_init(void)
>>          skbuff_fclone_cache = kmem_cache_create("skbuff_fclone_cache",
>>                                                  sizeof(struct sk_buff_fclones),
>>                                                  0,
>> -                                               SLAB_HWCACHE_ALIGN|SLAB_PANIC,
>> +                                               SLAB_HWCACHE_ALIGN|SLAB_PANIC|
>> +                                               FLAG_SKB_NO_MERGE,
>>                                                  NULL);
>>          /* usercopy should only access first SKB_SMALL_HEAD_HEADROOM bytes.
>>           * struct skb_shared_info is located at the end of skb->head,
>> --
>> 2.40.1
>>

