Return-Path: <linux-kernel+bounces-71786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC7685AA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECE11C2186F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97E46551;
	Mon, 19 Feb 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JGJKC1MZ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B233BB38;
	Mon, 19 Feb 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365312; cv=fail; b=JGXFqZiPQ1OMy9pkiwUgL0L2Ee5v3tMVSXh4aF+CZ7cgxz9rSn9hN05ccwk8ZCuK2uWiF2798FVbLzJE+IYqM7ut3o3GC+hJfs7579rTTIWGWOLHZbdYiJQu+GPPXNo8v1iewmonVbL95Hp/fCENO34nCdNKR0gVA+pChKGw52Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365312; c=relaxed/simple;
	bh=gIDu+A26VBEo/gU+GlEQxTBd3gYP84zwrlLlOn7BLdA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eIFDD2mM57APjj+j5vVPHhyl4H0oMtDu51Wg6eqTrWbxKKvPtd1hUQzoSD75RAtnMhW0WeU8pIyeJhDsC0caLlwOW8/Z0ZrlOhAYhrnbLsqFonZVftGJuzbLqUlWOl/M7CYgre3zK5dX6dsvz4IsfAeM2rpVOS6mjYJA1QZDZnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JGJKC1MZ; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dR3VO7W/rsru9Cve0D3ZygaB7j1JZY2P6OXxRq5V84btbvqtHzeJW85d9NKkBIMPFtzTenUktfxUVAwhS//Oqpep5/UQzrx4S5Ca7bBKTE9dcdziEDWrPbG2O/uNk98ajtWxCOSx4SY6s6qfjO0kM5qWWrFW4Qw1bYHqbZ7IgRTwaHyCJ5q9oilVagQUSu0YJmsSTNwLAVWyM6Y0VSNhnyj52CgZrUEbm4jv9glPmmmc1lw3CmgsYZp1SrX8jyvCalC3gU08Cuyl+wlQIYX2+U8a3wLUQbkorwoZLX2X7i3m1EnR83XqeThl0aD/b7JV1COvNFpFUTVGZCS/BVNsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+LYSbC/lpCkR7N+KXIfUywQsfXnf3Sj1B5omVzCjZ0=;
 b=Ma1RAfyZasTKaJiDQmO9nyNqZzG99UFsH4Z9bBW/4jV67e3RldJJDrm51SEyeAiDgMrII48u6Uko0tKApL1REG/KNBO/rCUAH4mPVQamxYUaI/3GVewpBCxi7Fgo2BELTiMdum9N+9GPaipKpJw4bsYouk47fVNFquhPjAnRDUUv9taFrc3uiPqt/leRTeE5DGw6PhmMoRb9QjgbFytnFZ9it3pSIUJ/zYsZDx1INAxx/7aGbYbITxHY3Nn/+SQJEwJ60Op2wBzlA85NDk1C2jaY2ZwC74rkBgEHoLZDOO/uf6kMlTF/nacjDraOTI24N4h4X2umZixJkSelHshFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+LYSbC/lpCkR7N+KXIfUywQsfXnf3Sj1B5omVzCjZ0=;
 b=JGJKC1MZoaka0c8K9vsXjITbO0escXM0EGSeTWJXAmb2dG28w4ga1aCTKxLnTneShrtGlwrT/SEj9q0SiCD3jT+M66HwuEhNOq8S0k7wfY370uSbnxBBUCqPcfuanm1PZxKZdOLiP1tjKZhaJoAlP4Jo7s7eGHhZNfGiW1pA2Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.19; Mon, 19 Feb 2024 17:55:08 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7316.016; Mon, 19 Feb 2024
 17:55:08 +0000
Message-ID: <0ceb2ba5-b595-483c-8a4a-2b64352871ed@amd.com>
Date: Mon, 19 Feb 2024 11:55:05 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v11 0/4] add zynqmp TCM bindings
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240219174437.3722620-1-tanmay.shah@amd.com>
 <20240219174437.3722620-6-tanmay.shah@amd.com>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20240219174437.3722620-6-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:5:335::8) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 392dfb5e-9684-4a58-5023-08dc3173e965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nXeWZunfmC/LEhjO/D3ciiLEiA+Og7Th4BwXyIAXtsHu/ZSvlDzfVsliF8o8ySIBERAZrHtE99MptfOy9E6GMhuD1uC5Tq2aPyFWFwDsftEPxqOqdAQ0P89voaS/V0sRjLwiDig/e1C9VW6HNGjnRx1tybn+1SXcmgUrrx4HhPTfFoCuyYSot8jXhZFpcybt1+QPYvq+MU97C3lBDByEdMWzCP/4rwYFVZnFeRj67NB0CB1ki7ZmVoOXiOeJhy4J3VyAVSgQUsJWuVkKDNoRWVgTqvPy5Qlq4Tj0C7lsLAu0VWbbcMtm8lk4vAcLR6W6KfcrhSDy8RR8rO/YubsmdR55CqQrL4noCWSgXpdDgLiDOPDZsRuzKJA7CIUYR+gbKP0zDkVCcNrlgGvLM8nk4YINigMQstZs0CW8NEH9a4WLRe5EFSUk8eyzeD3xMcW/w3G3oU8WhhDS0serNdMwxfWv4sJNsiaJNEIv2z0wwbu8GNGl+Y1XBjoTzNCFNr4+UBkvzZRyFOk0CrSicc0hRusRAM9KcIU6g+F5ceSnAay/AlLlDLncVIyW6I42Ao9G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y01xZUJVUzhNa25XbTlxWkd2aHhiWXBaaktFd3BEaVZDV3FGUG5HckM4NC9w?=
 =?utf-8?B?bnBTbUVqY2F3WkJ4TTlxOVBRejFyNWJNWWxHN2hYOTUyc3ZQczBsVTRVWVRj?=
 =?utf-8?B?bGpuTGh6K3M1d1Y1YnlpRUZWbkpYeGlBUS81U2FEdkZjUE1tUTRZTjlQdlVD?=
 =?utf-8?B?aW0wRUlIM0hLK003UXFBeWJhREFaQzIwdFZ2ZEF6RWtGRE1qUGxLUzhzZUhs?=
 =?utf-8?B?T0VHMXY5SlM1RXFUT1JWc0JhU05WU201UFRZUHR4N2l3UEQraHBXcVVXMlkv?=
 =?utf-8?B?VnBoTlU3MGVpUVVUMVdjaU1jVDBEOG9nMVNkbXA4bjF5YXhyU0lzNkFCTkps?=
 =?utf-8?B?L2VMVlJrZDMyNStRSmUrTithSWxxbnFLdWNqNUlCcERuanVTdGFlYTQ5QXps?=
 =?utf-8?B?U01PTjU5RG5lZUI3TmUrOWJDSCt6d1dMNytnR3VXSUJtSkJzTk0rSUdwanJD?=
 =?utf-8?B?NnBnUDhOVVB0RWRXSXNsR3FvdTNzM2FtK2E0YjRtUS92a0gyWUhFV3Y0T1l1?=
 =?utf-8?B?ZnlvallBMWE4K0NDRjdLakdwVzMwZElFK2dlK3lKaGFGMDFsYTV1T3lNYkZS?=
 =?utf-8?B?cGdFVFlCNkNwbGozRlBsSnJJUTdkTzhscXBNNWhuVXpoYnlyaDdxUlVtYXM3?=
 =?utf-8?B?d1lyQ3dkejEwMUt5cithMnROVUlSS2Y3cEl6NkRyQ3k5aUNyTXVCTXVZaDc3?=
 =?utf-8?B?SDJiMjdWd0xFSEQyMnF0bHVOTllCUWRGMHJYTXJXMUJscWlPb3hVbUNPcGlx?=
 =?utf-8?B?d1p5SWcrZnpZOTJlcTd2OEM2L2pDb1prZXdsVVVTZDlUUmRuQW5qOXkrU2NO?=
 =?utf-8?B?SGVGQlFLakdzVVg2azBySWFnN0lsTGYrSUlVOGRKVVdVL3djMVQvREIwcTl5?=
 =?utf-8?B?MVFITlU5Z01vZzJ3Q0c5NldhdHhXa1hEbDYxQmFRQXRRN2REMW5hbnBsWklq?=
 =?utf-8?B?M3pxaUtyWE5mTDNuemVINE1pVkVGT1MrNXB5eVNrMUFFRWxQWFNJM0JvUlho?=
 =?utf-8?B?NTlYdHJjK201YXFvK0NFS29lazRKYXJXVVNqZVVmV0lzUUdDSTEvRzBVclg0?=
 =?utf-8?B?ZUMvd0RGaXV5aDQ4V2drWjNlQXIveHBoYU90WTBXc3Nwbkg1enlqb010dExZ?=
 =?utf-8?B?Q1JBOGF1QnJDYStDYXcvY2d1QzZ0NHV0ZllwSXArelcyWlV3M1BWV3U4aERi?=
 =?utf-8?B?STZleFZyblRwdG5XNXVYZDhJZ2NJR3VnTlpTWnNHNjYrOHF0ZGRKL2Q1SUg1?=
 =?utf-8?B?amI3Qkk1QTlpR244c2VkclQ1LzUrd0ZSTW1yandLYU9qemxESHQ1dGxWaVZa?=
 =?utf-8?B?dlp6N0NOUlg0UjJTQXpyZWthVXRrT0xmQVFNVUdhRVdhTzRKTzVDWWg4UEpU?=
 =?utf-8?B?VmllOUFlQXU4aitrMXdBREdHL3pldzllOVl2dlNvUmRSblVGamhBSzV2RVhF?=
 =?utf-8?B?VTdrNTFWRFY1VWRHZnBRSUI1TGZYR3dQajhtNFZRRWE0ZlgyWXZrNmw5S0tt?=
 =?utf-8?B?cHFEcTBEUGtMMnhJcjFxRjZxZW1rRERUVGlHS08zSndTNVlkNHYwclQyRnNw?=
 =?utf-8?B?ZkhZQW82MHNsMW5VSG9PUXQ4ZHVoMDhlbGUrckJ2aVJLbmRXTjhPRkhBZnNq?=
 =?utf-8?B?b2tRb2p1OUlzVDB4ZnNsSWZBMitVRVdNa015eHJNMVZqaVdhMEdXUGM1V3E0?=
 =?utf-8?B?SjB1UFYwK2RDMzFNS3BERTNGSG9TTDQzSlFoNWwycVNRVVQwdG95aW5TYVpF?=
 =?utf-8?B?a0Y1Y1NMbjBaWDBCSDZBT054ZEpTQTg3MGFHQXZYZmhCNWI2T2ZOSnFCajZo?=
 =?utf-8?B?ZG52R2dXMW1hUHpTUWxxUFBqYzVPbzI4ZnYyVzlpMEM5OVlzdHlWbWtpRW5q?=
 =?utf-8?B?RzNxYjkzOExVMW9wZ2tPNEw3QlQ0TDZORlFWMDczVUgvaEtFMi9QSGYrQjB2?=
 =?utf-8?B?YStSeWwwdm4xcVlpTUNmK3BqYTY5QlFydWw5K2w2eWpBTEFyZ1duS1pUWjFT?=
 =?utf-8?B?eVhQZ2JEbWpGWFhkTnBJZGU4OWZkMFRyWnNhWUdTMHZhSkpwVm5naXdSUldX?=
 =?utf-8?B?ODNZVk1xYlJDSVY0cXE3WmIvOGxTbmxNNnVQbEFmeUtobzl4cUNXYWtHdWZi?=
 =?utf-8?Q?QOIV30dgi98zyDYEYNPksqUXa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392dfb5e-9684-4a58-5023-08dc3173e965
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 17:55:08.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcQBRvTL2fHdiCptLvA+CRk5T9BKZftyQimIH+624qawt0K207NF/SgtMJqc8eIl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120

Hello,

By mistake same set of patches were sent twice in same git send-email command.

Anyone can be reviewed. Please let me know if I need to take any action to fix it.

Thanks.

On 2/19/24 11:44 AM, Tanmay Shah wrote:
> Tightly-Coupled Memories(TCMs) are low-latency memory that provides
> predictable instruction execution and predictable data load/store
> timing. Each Cortex-R5F processor contains exclusive two 64 KB memory
> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
> In lockstep mode, both 128KB memory is accessible to the cluster.
>
> As per ZynqMP Ultrascale+ Technical Reference Manual UG1085, following
> is address space of TCM memory. The bindings in this patch series
> introduces properties to accommodate following address space with
> address translation between Linux and Cortex-R5 views.
>
> |     |     |     |
> | --- | --- | --- |
> |      *Mode*        |   *R5 View* | *Linux view* |  Notes               |
> | *Split Mode*       | *start addr*| *start addr* |                      |
> | R5_0 ATCM (64 KB)  | 0x0000_0000 | 0xFFE0_0000  |                      |
> | R5_0 BTCM (64 KB)  | 0x0002_0000 | 0xFFE2_0000  |                      |
> | R5_1 ATCM (64 KB)  | 0x0000_0000 | 0xFFE9_0000  | alias of 0xFFE1_0000 |
> | R5_1 BTCM (64 KB)  | 0x0002_0000 | 0xFFEB_0000  | alias of 0xFFE3_0000 |
> |  ___               |     ___     |    ___       |                      |
> | *Lockstep Mode*    |             |              |                      |
> | R5_0 ATCM (128 KB) | 0x0000_0000 | 0xFFE0_0000  |                      |
> | R5_0 BTCM (128 KB) | 0x0002_0000 | 0xFFE2_0000  |                      |
>
> References:
> UG1085 TCM address space:
> https://docs.xilinx.com/r/en-US/ug1085-zynq-ultrascale-trm/Tightly-Coupled-Memory-Address-Map
>
> Changes in v11:
>   - Fix yamllint warning and reduce indentation as needed
>   - Remove redundant initialization of the variable
>   - Return correct error code if memory allocation failed
>
> Changs in v10:
>   - Add new patch (1/4) to series that changes hardcode TCM addresses in
>     lockstep mode and removes separate handling of TCM in lockstep and
>     split mode
>   - modify number of "reg", "reg-names" and "power-domains" entries
>     based on cluster mode
>   - Add extra optional atcm and btcm in "reg" property for lockstep mode
>   - Add "reg-names" for extra optional atcm and btcm for lockstep mode
>   - Drop previous Ack as bindings has new change
>   - Add individual tcm regions via "reg" and "reg-names" for lockstep mode
>   - Add each tcm's power-domains in lockstep mode
>   - Drop previous Ack as new change in dts patchset
>   - Remove redundant changes in driver to handle TCM in lockstep mode
>
> Changes in v9:
>   - Fix rproc lockstep dts
>   - Introduce new API to request and release core1 TCM power-domains in
>     lockstep mode. This will be used during prepare -> add_tcm_banks
>     callback to enable TCM in lockstep mode.
>   - Parse TCM from device-tree in lockstep mode and split mode in
>     uniform way.
>   - Fix TCM representation in device-tree in lockstep mode.
>   - Fix comments as suggested
>
> Changes in v8:
>   - Remove use of pm_domains framework
>   - Remove checking of pm_domain_id validation to power on/off tcm
>   - Remove spurious change
>   - parse power-domains property from device-tree and use EEMI calls
>     to power on/off TCM instead of using pm domains framework
>
> Changes in v7:
>   - %s/pm_dev1/pm_dev_core0/r
>   - %s/pm_dev_link1/pm_dev_core0_link/r
>   - %s/pm_dev2/pm_dev_core1/r
>   - %s/pm_dev_link2/pm_dev_core1_link/r
>   - remove pm_domain_id check to move next patch
>   - add comment about how 1st entry in pm domain list is used
>   - fix loop when jump to fail_add_pm_domains loop
>   - move checking of pm_domain_id from previous patch
>   - fix mem_bank_data memory allocation
>
> Changes in v6:
>   - Introduce new node entry for r5f cluster split mode dts and
>     keep it disabled by default.
>   - Keep remoteproc lockstep mode enabled by default to maintian
>     back compatibility.
>   - Enable split mode only for zcu102 board to demo split mode use
>   - Remove spurious change
>   - Handle errors in add_pm_domains function
>   - Remove redundant code to handle errors from remove_pm_domains
>   - Missing . at the end of the commit message
>   - remove redundant initialization of variables
>   - remove fail_tcm label and relevant code to free memory
>     acquired using devm_* API. As this will be freed when device free it
>   - add extra check to see if "reg" property is supported or not
>
> Changes in v5:
>   - maintain Rob's Ack on bindings patch as no changes in bindings
>   - split previous patch into multiple patches
>   - Use pm domain framework to turn on/off TCM
>   - Add support of parsing TCM information from device-tree
>   - maintain backward compatibility with previous bindings without
>     TCM information available in device-tree
>
> This patch series continues previous effort to upstream ZynqMP
> TCM bindings:
> Previous v4 version link:
> https://lore.kernel.org/all/20230829181900.2561194-1-tanmay.shah@amd.com/
>
> Previous v3 version link:
> https://lore.kernel.org/all/1689964908-22371-1-git-send-email-radhey.shyam.pandey@amd.com/
> Radhey Shyam Pandey (1):
>   dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
>
>
>
> Radhey Shyam Pandey (1):
>   dt-bindings: remoteproc: add Tightly Coupled Memory (TCM) bindings
>
> Tanmay Shah (3):
>   remoteproc: zynqmp: fix lockstep mode memory region
>   dts: zynqmp: add properties for TCM in remoteproc
>   remoteproc: zynqmp: parse TCM from device tree
>
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 192 +++++++++++--
>  .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |   8 +
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  65 ++++-
>  drivers/remoteproc/xlnx_r5_remoteproc.c       | 257 ++++++++----------
>  4 files changed, 357 insertions(+), 165 deletions(-)
>
>
> base-commit: 929654e8f1add50b01d5a56171a31c311b0a739a

