Return-Path: <linux-kernel+bounces-108971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BCE8812AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A96A285A87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE67741C93;
	Wed, 20 Mar 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NrzWSpPT"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960B40843
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942604; cv=fail; b=PBSGCtlUHgcLoRFf0EqwvvJc0yVMoMawePRQWxw8hA6A24aHjQHqJYM6aN4W4xEK1uPq9VZjKib5G4eUm3gvh6CXU2nO0WXG+ZWpnuLbEJHyp6HoNYmWgKd/7O+g+9Ko4yepailGT0+iU7Y7boAjE9krdnKHk0Dwguy71Y1VM1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942604; c=relaxed/simple;
	bh=DgMcceKfX7jqige1X164H6Goe3idxS2coloKdnmi7gY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t9WBUW5CavwIR73Gvv0IqoFj4MkazhMXY+G4ghGS17okVr/qY+smln2FzPUqfRJlsYMKKbWe+CtctKIBZXO3p29KVbjZ7BUUcp4N9nPmn6tLmVt/cBMdjpkWel/I3FhHDhh1jcAzwsOtB0ipnaF3btaXw5iPqLxN8Ao7vChfgW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NrzWSpPT; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq0rolaqngrn+Z6/zxXQyseoK74f7IOCDeLb81sXQTI8qCT552xd9IbwMdLd345a3t93aMNMbOWHV4tw2o3TKmz4tFwatdhtF0MukV8HSldGKEA0seqYTYzDJ1BNhWIxCkUSUkEOUCxWkFUvoQLxZqZTfAOI1Ck6OL8qu/trtndWHC0CaHJsQ5hOOD8z+3ymYhd3u2IKpOW1iAP8DX+wXu2KgxPPSZjyps6z3tv5jwglRNqfA3vVpTsWDYfskLpVBWrs1ZNIlCX2fJ2yaD5Olau/bafdB3JB3CW8vo4B4+RLfhYw7819Aomav5L2/oftYK90i6VnA6s+u0BNBfE8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg97Td6TSXXpWEF0U8JY+TilSgl6Qm/08QwE2v1xeug=;
 b=eNUoUtROaP/ryqRL5Dowgn4n9UBg3coP8b3urjitNV68BmdYUujZl5ZJhW9dbni355MCHyXv81YapiXCS3KRVmsj8n7yTSdpzO60S4Th4AGmXR8H7JYcThWzLoecXaOdY64eY1WGTUR7PxENiZAe+OQvDVf8lrqMBYbrHeeEe449amvmhVfvf5sUujyEK14k8aROa4q9BfRrfVFIVnqWp2sygac5BIMFI544/rlybFTJhB7daG0PS+/RaThRQ5ixDLnZoV+Byo7zPbeSYEc0LRZfebPKLRhFkS4qmOTq3wY529UvcwNLzWbA2L01idVwFoWQdfcdjMIFcs8jgLgkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg97Td6TSXXpWEF0U8JY+TilSgl6Qm/08QwE2v1xeug=;
 b=NrzWSpPTDaltKL7TRLdugPv40lvsRwxNtJ5p62a/X6IvCs93ti1ydVXtgc6uO7cRQld60pb6KXW5tPklXXdwVnN1nfVExdnssq8z0MVeU3c0SWCcV2zDdIOWXYeO7BNgpV5mkgGRVE64KaCaMEDpNY1moMHcYC1FITv/pnCXfQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 13:49:59 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%5]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 13:49:59 +0000
Message-ID: <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
Date: Wed, 20 Mar 2024 08:49:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
To: "Huang, Kai" <kai.huang@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
 bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com,
 ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com,
 nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
Content-Language: en-US
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
In-Reply-To: <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0178.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::26) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 97efe9e1-122a-49f3-d641-08dc48e4a270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5TbzDR5p9oqMdwyZC4+kz3MRcEvgr46t4gKi5wtt6W+Kiwyl7mns/Yaqu/mULEAkUc/03d+QRY5JpTNeh5TrfGl+2MhpHao3QDOebTQLSOL/t2w8/f+VD4JhI6J6BaaHKX0uqKHvjqh6/8aF1fzLtDUxrSzsiebMYbByy3yMR0f1yVNfRbZ/5qkE3p2tV5B8RhoHlT2AWZ5QjmBUw6k4HDzT9IoInqeT7FO2WZ3ZYVSVpdRZMbeJlcn1VXiDcJtHS6IkzckegiqMqbRhYyvWGo9j/dw1I0JQd8fAY0lq5MI/kZIC4kSsPq30YBq9uPXOjnfWIdZfDhplPjghwpC+V/wlMEHL7q8UScIwiznZSQjU0G9hYyE6qPQPqLR4TcFfaL9k8WA0jBepBG6ZIKCYt5bi3s0bdzSSigoGLmp4W84pQZHY95U8MVBR46i2e8TzcTeDPddxtrKf2jw/VXZxEhOMnJiJF98wOpHdjSAnEg4MfSnSjgGuAj0FskAQp47W74mc0Eylm5NhWSx0voRMd+3n8MIJg7g6Xxd0AL7YNvGHMMedRRivYnIh7rCtTjSJLRD7wCDgXMhc6hwxDyWb8NgALGTzhNIVpA6/GGAqw0opntKGgvMhP6uy4h4zXEUIjzkK+SMEavt68Lxd4EGhI5vz6I85RvbL4fltncPso3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTdZK2xVRW9zdCtYL1ZQZU9mR241QkkwYXNtNjNFaXg0dHhGUUh4MW5TaUVH?=
 =?utf-8?B?QlV0V1V3T0NGUEtJZ09oYkVxaDdSdEhmcmF3c3ZVSWV4d3ZFcXltaFhZZnMv?=
 =?utf-8?B?bTZiZzM4cXBPWjNKU2tGYzJROGZaQWFpOE5KQnlwenpIRkE2OVBmVm9Jcytr?=
 =?utf-8?B?UnB0cjI0Y2NkYkVQcUdyczc2cmp5MGhyWmJwbHJUU0hUWG56VnBwZEM1eWc0?=
 =?utf-8?B?eGswVHFNcDJac1BRTUtldzB5TTI1YThab2oyZGVQQ2dsc2VpNGVaZ0tiQURt?=
 =?utf-8?B?QW5vN094QzVlMFdBRjBHbE9Samc1SWI3MEJXMnpLQVV1b05MQ080ajJFRitD?=
 =?utf-8?B?enpLZ25WczNoWjY5Y1pvMVVBQWJDUnQ3cnhIWUcxR245c2FIWkpkNFZmM0xl?=
 =?utf-8?B?QUlkbndGcGN5R3pncW1yWXZxbVlXR3pIV2o4WXBPUnhrOVVjVmUyTjZhQ0tL?=
 =?utf-8?B?aVFkUlpIVTJVN1crVGs1SjRoSTZ4OXhsSm5sTjI4eDkraEtDbTgzNkdRZWJk?=
 =?utf-8?B?TTYzUGdQaU9WcFVWQUxIUVhLei9CeWo3MnVoUHFZbmpIZjBRRCtueEx0TmRu?=
 =?utf-8?B?K1BxNGxub3ZySy9FSDk4QWQzOGZMbHF5Um5JWmRWbjRrc0I0NHpzOTltbk41?=
 =?utf-8?B?SGJ6M2ZLUDhsMW1YMitCa2Q1RGhxc255MTg0V1NORzNLTjlMSkVxYlVQeEN0?=
 =?utf-8?B?ZXE4ZXdySUFFRTNZNG1Pc1YvOVhKQ2hSaDExd2gzaFNpeTRCN3dOOEhZMUhB?=
 =?utf-8?B?S3VKZlFpZG1CZFdENE9NQUhXZmVoRXQ5VzBiTVFiSDdFcDJDS2ZUek9ZV0Iv?=
 =?utf-8?B?eU1VQ0pvNzVsKzI2b2pzNjJkcjUrOEl6NG9rYWtrR0F6UmpQOTdBL3I4YlYw?=
 =?utf-8?B?RnQ3cVBxcVhaVThLVUtYeEJZVE44N3BmY0FnT0tUR3RCNVRpRjR5MEo0MkFE?=
 =?utf-8?B?UUJvR3NURGJsYzMveFhPZm1yQnBNQldIUzhuQnZtaFpSc1hYVEdzK3ltS0RE?=
 =?utf-8?B?Qk9NRWFsVm9nWUI5bVlhNlQ4YVFrcVRKYW5HRitqRVluRmQ0MkNtS0hxaDUy?=
 =?utf-8?B?ZEdQQWhUTjBvNW5WVnlCckFhZ1BBbDFyaHNvVEd4MFhTWXd1RktnWlg3clVy?=
 =?utf-8?B?eW9wYm9UOCtsRDQvcEtMZUUzN0w3emJ0SGhzR3VqbjJlYnprbzhUUjZJWThQ?=
 =?utf-8?B?S0NlbE1McW8rVDNsN29sSzVBSk9NSE8rcUNUZ2RSMFFNeXdqdElaaTdYUWxv?=
 =?utf-8?B?aVRzNHlCcGg4YklCTFo3SGJOcXZwdElyd1BUWUF5YlNNQzlnZGRRNERlekMx?=
 =?utf-8?B?eDRaV0RBa3VnUDhma2FtOVRNdTkyL3ZrdmxoNXdGaFM4QlRBakRMSTFJbytp?=
 =?utf-8?B?d3RxaUZ5dDNUczl6TlYrK05vQ0RPWThvdjROT0VjTTFtemQ2eFlPdFIzQzdu?=
 =?utf-8?B?OWJMTExZaysyNnlObmZ3Qlk0UDFmdVI0a0pNSEF4YWxZbTZ4bE91dDVQSkFT?=
 =?utf-8?B?ZFJrSUJES2ZQRTkvRy9Wa3BnbjlhcnpmOWU0MlgrQkIwTlJZYlVXNkVjcGtj?=
 =?utf-8?B?U3RlNEhYSmRhbjlBZ2xCRjJEKzZhQzJra3pkc0YzQTJKV3g2MzI4Yk9zc0VK?=
 =?utf-8?B?ZnVjNVliSGQvOUViRTB5dnRDZHNWZ0dSOXJHL2Q1TURIVkVUemVVejhIajVS?=
 =?utf-8?B?UGtmV0gyMFdSamhJWW9YT0E3UGd6NVRRelFVMDMzTkpCSXZ1eHFzb0RGYU5i?=
 =?utf-8?B?Ym0vVnpCYW5NdnJzMW1pQnJQcno3ektFZ3diekZqRVNwWitIR0tjZmZCYTRC?=
 =?utf-8?B?Q21yaHJid1d5eVZBeGxBSExxcW41NHFjNDhLN3UrdXpvUTVNWFhEanpMSTdW?=
 =?utf-8?B?eXd6bm5RNE1vWkRtMXhZMmtTekF0TE9hazMxSDB0S0p0NnhkbXgydlRUOWlt?=
 =?utf-8?B?YXNSMDg5NzFlMFppMXZWajY4c0hOckk1b3ZSNVIzWDRrYXRaTzBZS3NGNTNo?=
 =?utf-8?B?NFc5SVJGazFqU0ZpR0ZWMGpubXRmdVUyV0drSW9NTTg1VjYxZEEzakhMbGU2?=
 =?utf-8?B?ZjAyRzVFck9SS3ByNVU5OFhBNjdTZTUrRHVKaDI2SjNCd3dzTW9MM3JEcCsw?=
 =?utf-8?Q?qP+F3WycvwltF+JJ7dl9MHG+X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97efe9e1-122a-49f3-d641-08dc48e4a270
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 13:49:59.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jkrVhmnnVcprrahz5bMrJwgKsELO6+UBWJbfGBTnoUHHiOL729VErM7/XwX0TeBum5uIGNbrs9mphrnpa3p6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722

On 3/19/24 16:20, Huang, Kai wrote:
> 
> 
> On 20/03/2024 3:38 am, Tom Lendacky wrote:
>> On 3/19/24 06:13, Kirill A. Shutemov wrote:
>>> On Tue, Mar 19, 2024 at 01:48:45AM +0000, Kai Huang wrote:
>>>> Both SME and TDX can leave caches in incoherent state due to memory
>>>> encryption.  During kexec, the caches must be flushed before jumping to
>>>> the second kernel to avoid silent memory corruption to the second kernel.
>>>>
>>>> During kexec, the WBINVD in stop_this_cpu() flushes caches for all
>>>> remote cpus when they are being stopped.  For SME, the WBINVD in
>>>> relocate_kernel() flushes the cache for the last running cpu (which is
>>>> executing the kexec).
>>>>
>>>> Similarly, for TDX after stopping all remote cpus with cache flushed, to
>>>> support kexec, the kernel needs to flush cache for the last running cpu.
>>>>
>>>> Make the WBINVD in the relocate_kernel() unconditional to cover both SME
>>>> and TDX.
>>>
>>> Nope. It breaks TDX guest. WBINVD triggers #VE for TDX guests.
>>
>> Ditto for SEV-ES/SEV-SNP, a #VC is generated and crashes the guest.
>>
> 
> Oh I forgot these.
> 
> Hi Kirill,
> 
> Then I think patch 1 will also break TDX guest after your series to enable 
> multiple cpus for the second kernel after kexec()?
> 
> Hi Tom,
> 
> I am not aware of kexec() support status for SEV-ES/SEV-SNP guests. Does 
> patch 1 break them?

SNP guests can kexec with some patches that are currently in process 
around shared to private memory conversions. ES guests can only kexec with 
a single vCPU. There was a recent patch series to add support for multiple 
vCPUs.

Patch #1 doesn't break either ES or SNP because we still have an IDT and 
traditional kernel addressing in place, so the #VC can be handled.

Whereas patch #2 has switched to identity mapping and removed the IDT, so 
a #VC causes a triple fault.

Thanks,
Tom


