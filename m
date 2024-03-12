Return-Path: <linux-kernel+bounces-100291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B2B87951E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC6B1C21DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC87A155;
	Tue, 12 Mar 2024 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DiHd1uRy"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809087A146
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250184; cv=fail; b=jpULCM4pbJMB4JG3Jwilu5+ob7oS/BDoAtI7h/B0zRrTyGJEb2OZQXPmqlNlgJXkNttjC6dIQI/e7Fsx8q2ODsUQrcM4M4xJITfvGz7b3Y/Kl8l4q5gFZ1IZqjaOydD+izji/w4HWsk088QBNLKU57+bhI6w2Fv6LpamH1L/rYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250184; c=relaxed/simple;
	bh=SRqvVddTCseaUeG2AaLSj36ghQmSB/OnZJ9oVdYTzY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vf3Hlp13XYeUYcZw0ZDHFyldx6Rv1CleAeQlw3a3EG5YXccEZbMEEPwqZZJ5oilQ/lhataFRtmYfE7h9bPqc8hNYOGlXpKzTUf8FKUCykx8xHWMVi0XVXwplaxh1By5UO/csHZms1x1IWgQ2nahoz7ifDx5xMWWoW3092gOLvf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DiHd1uRy; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rcu9LyHbUFa1o2h4DMBw7LXaN87+pRgCJ6IhnbQhGNZd1PMTgdvN63KY4tJGHc7lll2FfSAT9HxnKeCXBPp2EDRf/nk80M8F856mMH/Mr8TSbAYEnP9MlPeWl/1bkEZ4UAy5R9tEzTagHBTwx9crBL1ofZBFHZpeeCnAhavBwLvedPqEUwXXammuPi+QxA/0HByCdsTlETz5GGIR1KMQYiv6qmCDr/yZ5DDo7HSD/48pf0rRWx2tvY2yGMUBjC9fSGXhIbDver+EsM/LwyNUtxCVPa/6hWxb3g8q0ZnPCuvfzCwhiPp+6u0P1Pqii1Y72eHWKyFi4Nophw/8BBSEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ldQCxPfXfO9fTLDOLAySbRT6i9L2zXyCQDfzm26nP4=;
 b=LhwbOSXcsbBc7D1GXAzoo48sbN5Ls6W1TbbLBUaxrHcHfAasWwt7DfrxmSU6a+vzrsbY91RAu5WLk7QF0F7fR1R4Xb149VA3a6aYfowh4dKVPuSpBgGokR/KddreESfUuiGDuKcTQ9+MaIkmq88s6ex+Oc5jy7CfVy1gBFmZQPX6RilTxyr3hQ4Zbry4tOwhz2otUlygpid1gYRv9MIhaTtKVBrOofCyep7i7tH4utC8QQZT8Bcm9nzjBb2NI1Bhi6ssOgtAPnGMpnoF1sIDxiseUqco73dQNFp8XdLHXnknSOU5K39upND8TGc5pgnxtSwYD8qwSemLslKmFd49QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ldQCxPfXfO9fTLDOLAySbRT6i9L2zXyCQDfzm26nP4=;
 b=DiHd1uRyaQ5TFcVOhuG9+Ajrp5eks5Iti2qY7SVj+yr8exZUhlaE2Y98J3banVrscBLCE4cSKJOwC/5/Ks96IJUutizouWdpXBkmBbpBJ8QcWvDyoLxaVh1YXVce6FVsVOJJkPoVZNGTaMEwjYM0/2wN4mgOIUqjriRhdtxsnCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 13:29:37 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 13:29:37 +0000
Message-ID: <02ac2f5d-6e56-46ef-b5fd-7c1503600f1d@amd.com>
Date: Tue, 12 Mar 2024 08:29:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] x86/sev: Extend the config-fs attestation
 support for an SVSM
Content-Language: en-US
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <a6d236e247c4a0258e5e28c7378350389997cc59.1709922929.git.thomas.lendacky@amd.com>
 <93f36ae1-35b3-4852-8b36-3277f250408e@intel.com>
 <805b863c-1631-477d-9faf-f7569a8d80e4@amd.com>
 <fa7cee6f-954b-4acf-a438-17ae3d1e781a@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 xsFNBFaNZYkBEADxg5OW/ajpUG7zgnUQPsMqWPjeAxtu4YH3lCUjWWcbUgc2qDGAijsLTFv1
 kEbaJdblwYs28z3chM7QkfCGMSM29JWR1fSwPH18WyAA84YtxfPD8bfb1Exwo0CRw1RLRScn
 6aJhsZJFLKyVeaPO1eequEsFQurRhLyAfgaH9iazmOVZZmxsGiNRJkQv4YnM2rZYi+4vWnxN
 1ebHf4S1puN0xzQsULhG3rUyV2uIsqBFtlxZ8/r9MwOJ2mvyTXHzHdJBViOalZAUo7VFt3Fb
 aNkR5OR65eTL0ViQiRgFfPDBgkFCSlaxZvc7qSOcrhol160bK87qn0SbYLfplwiXZY/b/+ez
 0zBtIt+uhZJ38HnOLWdda/8kuLX3qhGL5aNz1AeqcE5TW4D8v9ndYeAXFhQI7kbOhr0ruUpA
 udREH98EmVJsADuq0RBcIEkojnme4wVDoFt1EG93YOnqMuif76YGEl3iv9tYcESEeLNruDN6
 LDbE8blkR3151tdg8IkgREJ+dK+q0p9UsGfdd+H7pni6Jjcxz8mjKCx6wAuzvArA0Ciq+Scg
 hfIgoiYQegZjh2vF2lCUzWWatXJoy7IzeAB5LDl/E9vz72cVD8CwQZoEx4PCsHslVpW6A/6U
 NRAz6ShU77jkoYoI4hoGC7qZcwy84mmJqRygFnb8dOjHI1KxqQARAQABzSZUb20gTGVuZGFj
 a3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPsLBmQQTAQoAQwIbIwcLCQgHAwIBBhUIAgkK
 CwQWAgMBAh4BAheAAhkBFiEE3Vil58OMFCw3iBv13v+a5E8wTVMFAmWDAegFCRKq1F8ACgkQ
 3v+a5E8wTVOG3xAAlLuT7f6oj+Wud8dbYCeZhEX6OLfyXpZgvFoxDu62OLGxwVGX3j5SMk0w
 IXiJRjde3pW+Rf1QWi/rbHoaIjbjmSGXvwGw3Gikj/FWb02cqTIOxSdqf7fYJGVzl2dfsAuj
 aW1Aqt61VhuKEoHzIj8hAanlwg2PW+MpB2iQ9F8Z6UShjx1PZ1rVsDAZ6JdJiG1G/UBJGHmV
 kS1G70ZqrqhA/HZ+nHgDoUXNqtZEBc9cZA9OGNWGuP9ao9b+bkyBqnn5Nj+n4jizT0gNMwVQ
 h5ZYwW/T6MjA9cchOEWXxYlcsaBstW7H7RZCjz4vlH4HgGRRIpmgz29Ezg78ffBj2q+eBe01
 7AuNwla7igb0mk2GdwbygunAH1lGA6CTPBlvt4JMBrtretK1a4guruUL9EiFV2xt6ls7/YXP
 3/LJl9iPk8eP44RlNHudPS9sp7BiqdrzkrG1CCMBE67mf1QWaRFTUDPiIIhrazpmEtEjFLqP
 r0P7OC7mH/yWQHvBc1S8n+WoiPjM/HPKRQ4qGX1T2IKW6VJ/f+cccDTzjsrIXTUdW5OSKvCG
 6p1EFFxSHqxTuk3CQ8TSzs0ShaSZnqO1LBU7bMMB1blHy9msrzx7QCLTw6zBfP+TpPANmfVJ
 mHJcT3FRPk+9MrnvCMYmlJ95/5EIuA1nlqezimrwCdc5Y5qGBbbOwU0EVo1liQEQAL7ybY01
 hvEg6pOh2G1Q+/ZWmyii8xhQ0sPjvEXWb5MWvIh7RxD9V5Zv144EtbIABtR0Tws7xDObe7bb
 r9nlSxZPur+JDsFmtywgkd778G0nDt3i7szqzcQPOcR03U7XPDTBJXDpNwVV+L8xvx5gsr2I
 bhiBQd9iX8kap5k3I6wfBSZm1ZgWGQb2mbiuqODPzfzNdKr/MCtxWEsWOAf/ClFcyr+c/Eh2
 +gXgC5Keh2ZIb/xO+1CrTC3Sg9l9Hs5DG3CplCbVKWmaL1y7mdCiSt2b/dXE0K1nJR9ZyRGO
 lfwZw1aFPHT+Ay5p6rZGzadvu7ypBoTwp62R1o456js7CyIg81O61ojiDXLUGxZN/BEYNDC9
 n9q1PyfMrD42LtvOP6ZRtBeSPEH5G/5pIt4FVit0Y4wTrpG7mjBM06kHd6V+pflB8GRxTq5M
 7mzLFjILUl9/BJjzYBzesspbeoT/G7e5JqbiLWXFYOeg6XJ/iOCMLdd9RL46JXYJsBZnjZD8
 Rn6KVO7pqs5J9K/nJDVyCdf8JnYD5Rq6OOmgP/zDnbSUSOZWrHQWQ8v3Ef665jpoXNq+Zyob
 pfbeihuWfBhprWUk0P/m+cnR2qeE4yXYl4qCcWAkRyGRu2zgIwXAOXCHTqy9TW10LGq1+04+
 LmJHwpAABSLtr7Jgh4erWXi9mFoRABEBAAHCwXwEGAEKACYCGwwWIQTdWKXnw4wULDeIG/Xe
 /5rkTzBNUwUCZYMCBQUJEqrUfAAKCRDe/5rkTzBNU7pAD/9MUrEGaaiZkyPSs/5Ax6PNmolD
 h0+Q8Sl4Hwve42Kjky2GYXTjxW8vP9pxtk+OAN5wrbktZb3HE61TyyniPQ5V37jto8mgdslC
 zZsMMm2WIm9hvNEvTk/GW+hEvKmgUS5J6z+R5mXOeP/vX8IJNpiWsc7X1NlJghFq3A6Qas49
 CT81ua7/EujW17odx5XPXyTfpPs+/dq/3eR3tJ06DNxnQfh7FdyveWWpxb/S2IhWRTI+eGVD
 ah54YVJcD6lUdyYB/D4Byu4HVrDtvVGUS1diRUOtDP2dBJybc7sZWaIXotfkUkZDzIM2m95K
 oczeBoBdOQtoHTJsFRqOfC9x4S+zd0hXklViBNQb97ZXoHtOyrGSiUCNXTHmG+4Rs7Oo0Dh1
 UUlukWFxh5vFKSjr4uVuYk7mcx80rAheB9sz7zRWyBfTqCinTrgqG6HndNa0oTcqNI9mDjJr
 NdQdtvYxECabwtPaShqnRIE7HhQPu8Xr9adirnDw1Wruafmyxnn5W3rhJy06etmP0pzL6frN
 y46PmDPicLjX/srgemvLtHoeVRplL9ATAkmQ7yxXc6wBSwf1BYs9gAiwXbU1vMod0AXXRBym
 0qhojoaSdRP5XTShfvOYdDozraaKx5Wx8X+oZvvjbbHhHGPL2seq97fp3nZ9h8TIQXRhO+aY
 vFkWitqCJg==
In-Reply-To: <fa7cee6f-954b-4acf-a438-17ae3d1e781a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::23) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 827f883a-370e-4f1e-72f7-08dc429876c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kgohZQMvEyuzgEyDCTY0/9sQINXOtY5iEx8Zg+Y1sBs6Dp3I3W42GGyk6I279Pq6Dlk5G6Oy9iytC5m21e6weluhLU6q2WiGao1sNX4pCMlKb83s53to1oD7UuvgFfGpoHuLkuiqCk+VQqa0/kCq6C+YKcH4koqQuQ2ydoJvxB3Z3AMUpK8n12kfK3+hSybVG0a7ODwcigk7yZzibPCVoyuK2oCo0Unq0/WwTfqZMZ0Iu1tOfyWszSsXsaxNMlykWR6MpvOzhyEWV5AC4GWJblnUVG6PcPzy8ZSzH4R6zQa0gujjQQCCMqrtltCYXzLLtUC3BO16hUU3dwOPgq6nGmgh02wFuP/26KAM3I8PZj3EmkdmNaf/FMM7B2jYSg9he5lrQXCautb4Gv3Zfl58lOs359cnyk8pLbPjOXtOFwaGrGxN977nc60w0zdZSFUgP8oIiSSrKHcZDVPkj9Erakp9qbx3b9T+IbK/C/6opxQPiMRMtjx1Wagf88apXLC00f+Vi3B78HR9tWoYVVptB/2VsBfHoQfd0ifBctc2Z8dYFueJCSbPN6PLQXtinA1oFzOo8uPkvg49wCuHBiVLW2K6gSJTf23e5LPTnlBadfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTB4eHNBc3hCZEZ5VGg5QmhvRzNtRmppaENydlIzSC9xQXd0MlkvTDNTREFl?=
 =?utf-8?B?ZU1vRmErUHZyeUkyR0llYTlXNjNjcWdkTDgxS0ZIclRPdCtrMXoxZ05GNi9t?=
 =?utf-8?B?Sk00NWRpeTRnZXJmZW5nMUx6ekhLYkg1eWpwdXlOSEJkZXY1TU00R3F3Vi96?=
 =?utf-8?B?M3lFQ0swVEdOUmptWXlZQ3orakVzand1bndVZkNPSmhyeFU0RlNod2xFY3FH?=
 =?utf-8?B?ZEdBdFlnWnBvYmF0ZExpNnJueDRsMTBMMmVhYjdoWFZtNW1hOTFrZjBjSjV1?=
 =?utf-8?B?M2ttNDBuMHBxdnVYU2c3VUlNOUE0NXAxamdoOWRwZFhSOTlyWitGYUF2dUN6?=
 =?utf-8?B?Y1JZZDNKdUtRS2RCUGhFakc1ZitncVhWZmxxd0pIN2s5dStEZTVTSjF2MjlL?=
 =?utf-8?B?enBxbStCd2NUaUxKRXpTZ3g4Z0N1T0thZnVtUVFIUWNXMEwwdm9ITFJRemRa?=
 =?utf-8?B?OE9STllUR3FoZndqOWxwWkFPcDh0bmVYTHM2THhEa3ZmMEFxMFhabWRpS3Qv?=
 =?utf-8?B?WWp5bFZVWjQ2YzIrVm5HUk5BaWRPc1RPK3lYZVpzMEROMC9PbXBMR3ViMFdv?=
 =?utf-8?B?R2hBR2I3S25CazlrZDBXL1ppVUhZOTlNNWgrdjdjWXcwTWZVY0U4b1VTSVQ2?=
 =?utf-8?B?WG0wQmd5Qnh5VjdMMkxBSG1CcDRPcFp5aE5tN2RCZjlzNlFZZ3oydEo5YUI2?=
 =?utf-8?B?TzFFVnRwZXJSRDJrTmtYOUhoWGpGcENpQ3dXdkVaSklXQy9QWHY3MGRUL25p?=
 =?utf-8?B?QktVbmo2NHl2b2VaTkM0RkZzdGY5SDdydzI2UXFMZnF0M0YrNGpZbE5Cb0dV?=
 =?utf-8?B?RTVSUVh2UkdQb0JlOUpudmtQQ3hlc2pESkg1dVdxdkR4Z0dLTlZLU1hob01v?=
 =?utf-8?B?dE13NzBPQXBGMUFlZDdhWXNCTk9TTGdwY3ZKMVAvTUNjNGc4VGJMemV2eFJ1?=
 =?utf-8?B?VkRxQkdNdjNJNTdjbDcxbXZ5S3V1WVMyUkRMSFJDL0txZEMyYWlEU0JyY21r?=
 =?utf-8?B?bWErS2YvMzNwcnhxVCtTajducmpkT3FlZVJodGVISG0vd1RUa3pXb3FYTkpM?=
 =?utf-8?B?KzE5S2tDekRqQnZTNVNZbU82M2R6OXlZV2IxUjFjajBjYk42TWF0OFdvVXVk?=
 =?utf-8?B?RnFGUWhjTUNNN0Z3K0dQRlB3dDdTZmZrZnY0cWhoOTEzNmRFcU9tOFhHTGFh?=
 =?utf-8?B?dktiemRsKzgrRkFaYTNFRzN6V1dTd0F2THpCeHFwNGdnWk0zckdkSW1IcVQ2?=
 =?utf-8?B?T2lWSzh3MFNDclFFUHp1RVZGU0h2bkFCRHZmUURRc1J5YWRoazlJQTNVSmN5?=
 =?utf-8?B?MUpKRm5xU3lQdmIzenhmb0NmV1hJd0E2akZJWTE3TTZsenpValRpRGxFeUhq?=
 =?utf-8?B?TW4reTlXbFducnk1d25QekdrQ01TTEpOTlJ2SVRzT2hLT1Q0M1JJYlp6aHRh?=
 =?utf-8?B?R0JOd3ExSXR5RVB5cDIxQTNvMFZZdUVUS2V0QnkzNTJTcTRCK3JGR2dYd0NP?=
 =?utf-8?B?cjF1OXNJSXNCYjlJM0piWmF2Z0YwRW9GeDRPeCt2dUE2MGl3bEN4V3NaNEVJ?=
 =?utf-8?B?MDFUM3RtVU1MSXIxbXRKczZpSCtKWS9sTjdnbzVObmhHaHYvWXpQS2VJYWw2?=
 =?utf-8?B?YU9aNVVkVE5ONkYrSDBNKy9wUTlrK2R0YW4wWWEzbUcwRmZwdGNqbHNWQUlZ?=
 =?utf-8?B?dDlqOTg3ZzErZVlKVVhYczdjUTM4MHQrZFgzSW5oVG44R1ZpSW1wTG5XRWhk?=
 =?utf-8?B?V2ZBSW1OK1Npd2JrOS93YVpTRHllV1FKWUlWRGU4ZCt4L1Q1anEzVGJ3UjZy?=
 =?utf-8?B?ZmkzcUpCazJHT2x5T1UrUnJXMkl4bmkrajNXNzdSZFY3cXdNbEM2UTVYY1RD?=
 =?utf-8?B?YXl4MnpXYnVtb0pSTExkcEpvVGYyVzQ4dGRVNzlNRjN0UmZwaGNna2hYcWJl?=
 =?utf-8?B?Z3lLVXlIRnZJTVFhdmhGREkyL0MxMDA4NjRNZmdGVmx0YlFNZDR0VFdEZDBn?=
 =?utf-8?B?VkJSWnovUUVtbFI0amMranZiY1F5V2w0NnBXK3dUcUlnUzJOalhuWHhId3pq?=
 =?utf-8?B?VUtrUjZMN0prRVFORE5pdlV2Qy90cVNtak9NUGhDcndIdThEdllqbEpsZjBJ?=
 =?utf-8?Q?2NfSijEy+LlphedwnNtR9l1zq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827f883a-370e-4f1e-72f7-08dc429876c6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 13:29:37.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT2xD/cklfH8J7/ak0yNpN7LOtB0sn61sGoEhlDHARYzIuPZ837GB9C25+gqjnVslH1d3eCUK8BjdS8/zhlAEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065

On 3/12/24 00:57, Kuppuswamy Sathyanarayanan wrote:
> 
> On 3/11/24 9:16 AM, Tom Lendacky wrote:
>> On 3/10/24 00:06, Kuppuswamy, Sathyanarayanan wrote:
>>>
>>> On 3/8/24 10:35 AM, Tom Lendacky wrote:
>>>> When an SVSM is present, the guest can also request attestation reports
>>>> from the SVSM. These SVSM attestation reports can be used to attest the
>>>> SVSM and any services running within the SVSM.
>>>>
>>>> Extend the config-fs attestation support to allow for an SVSM attestation
>>>> report. This involves creating four (4) new config-fs attributes:
>>>>
>>>>     - 'svsm' (input)
>>>>       This attribute is used to determine whether the attestation request
>>>>       should be sent to the SVSM or to the SEV firmware.
>>>>
>>>>     - 'service_guid' (input)
>>>>       Used for requesting the attestation of a single service within the
>>>>       SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
>>>>       be used to request the attestation report. A non-null GUID implies
>>>>       that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
>>>>
>>>>     - 'service_manifest_version' (input)
>>>>       Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>>>>       represents a specific service manifest version be used for the
>>>>       attestation report.
>>>>
>>>>     - 'manifestblob' (output)
>>>>       Used to return the service manifest associated with the attestation
>>>>       report.
>>>>
>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>>> ---
>>>>    Documentation/ABI/testing/configfs-tsm  |  59 ++++++++++
>>>>    arch/x86/include/asm/sev.h              |  31 ++++-
>>>>    arch/x86/kernel/sev.c                   |  50 ++++++++
>>>>    drivers/virt/coco/sev-guest/sev-guest.c | 147 ++++++++++++++++++++++++
>>>>    drivers/virt/coco/tsm.c                 |  95 ++++++++++++++-
>>>>    include/linux/tsm.h                     |  11 ++
>>>>    6 files changed, 390 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
>>>> index dd24202b5ba5..a4663610bf7c 100644
>>>> --- a/Documentation/ABI/testing/configfs-tsm
>>>> +++ b/Documentation/ABI/testing/configfs-tsm
>>

>>>> +
>>>> +What:        /sys/kernel/config/tsm/report/$name/service_guid
>>>> +Date:        January, 2024
>>>> +KernelVersion:    v6.9
>>>> +Contact:    linux-coco@lists.linux.dev
>>>> +Description:
>>>> +        (WO) Attribute is visible if a TSM implementation provider
>>>> +        supports the concept of attestation reports for TVMs running
>>>> +        under an SVSM, like SEV-SNP. Specifying a empty or null GUID
>>>> +        (00000000-0000-0000-0000-000000) requests all active services
>>>> +        within the SVSM be part of the attestation report. Specifying
>>>> +        a non-null GUID requests an attestation report of just the
>>>> +        specified service using the manifest form specified by the
>>>> +        service_manifest_version attribute.
>>>> +        Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>>>> +        https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>>>> +
>>>
>>> I think it will be useful to the user if there is a attribute to list the service GUIDs
>>> supported. It can help prevent user using incorrect or unsupported GUIDs.
>>
>> A list of supported GUIDs can be obtained from the manifest of a all-services attestation request.
> 
> So they have to make a request twice? Once with a NULL GUID to get the
> manifest with all service list, and another to make service-specific request?
> There should be a fixed list of service GUIDs, right? Why not list them by
> default?

It's not a fixed list. It may appear that way today, but as other services 
are added, then it is impossible for a kernel to know what services are 
present in the SVSM without querying it.

> 
>>

>>
>>>
>>>> +    if (guid_len == UUID_STRING_LEN) {
>>>> +        rc = guid_parse(buf, &report->desc.service_guid);
>>>> +        if (rc)
>>>> +            return rc;
>>>> +    } else {
>>>> +        report->desc.service_guid = guid_null;
>>>
>>> I think the default value will be guid_null right, why reset it to NULL for every failed attempt?
>>
>> Default, yes. But what if it is written once, then a second time with an invalid GUID. Should the previously written GUID still be used?
>>
> 
> If the user write fails, why update the state? IMO, we can leave it at the old value. But, lets see what others think.

Sounds good.

Thanks,
Tom

> 
>> Thanks,
>> Tom
>>
>>>

