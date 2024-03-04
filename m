Return-Path: <linux-kernel+bounces-91369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E452B871030
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14AE01C20F73
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926867BAF3;
	Mon,  4 Mar 2024 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c2pnQr7O"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC023482DA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592090; cv=fail; b=ObzO8PFP+3IrAtiCg5MZHLag1ympvb99cT1/v1puqsT9x+Bnk6OuhoQS19Fng5whhCMWi7CJzqI5Mm4GQQ2VLzMUDLushbvGw6RoGTidsY0gvZ2nq6WO+otATq28Z5AqD7+kwpPYmYtNugKjbMKSuEYZ1X125BRnIGRxHRj2Pxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592090; c=relaxed/simple;
	bh=wTzT+33c6vuNYH/oojYXPzIazp5r67sDaWFeHFTtzVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CElxdiE2obw59c3vXmAuODTLOyWhrzFvWt6HuGbQSCrcxn+MGZnuP8jffuCi8vSgJLEPnJvdWhTtS98fHqi1xY8yJ1KnD/ykiA9v9Qb8Rle5BhaNZyYRCPQUxSo7X8GQswtDq2snP0OTvJVMoAGy/CoYl67SLa5JtPy6O2l98Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c2pnQr7O; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4hV8+9SNc/ZoS2iFgSVMlCvVSxtdHR5LJddcFZzITTmlNgziluHqwbrg/ND3hiTof/x5ZH9ZOToQtuPmspocD1Uutnddz6xFjRvps2VgTn+DEUnHXpbNXndjgSNq3KKeeo0bR+3glmzX5WRwP1PGHkqqDlsL6YSishWfOgKCPcwEYdMo5mjA40cHu2yMmFkJo3F9M1LfCDPrgJQM9/SgFItkCNdOkzuViQ/T7yDkDwtuJ/YW8/Ibq4hLIZxXiJXVKYy/FLfp+XTPumXUKHPp37iblBB3C4IkzFJxxKeoETQpWRciSGN8AU2lXxbalAy/JpMKsHyyHfeBSg3erNCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4M6cSoIlicdY7CPdMSNEfWgLc05x4PdS1m/TBKb3wo=;
 b=oAFjbNdM7NaXTuLTx+L0XMaeXoLZBytZXsd7HrjnKrmE/3dY3qQqaQFUNkMZAGk8muLAD5RvsupW3NfzPUiIH07UsMioJoK900c5s1I3R1F7gwM/O+qZIfL8Ii3RbYU1dwq1BffQtV2mhGVgrh+lESPoRbHcUPX/ND9ylcn50jSrPiCZsA+dbO/s6t3heOclozsiEo2XCySb0ZiYnzSi8R06Rqmazq6my/9sJBE9x/E1C2Vv1v+T+tzwFFkPAQpk/ZgzQYX5BxlrPLt5G5uDIuJRIFq3Q8Gt4XCad3qlvQNaRSQwQNWea0ANNHxVlOveJAK1AiXty+qpcYylnq/Zew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4M6cSoIlicdY7CPdMSNEfWgLc05x4PdS1m/TBKb3wo=;
 b=c2pnQr7OGW76ps3nBRoKzv9ECs7M/9oS9+AlXj2j2O++oH/ZzkAgxSLLU4gr/g+SRPUP9nREt5KC0Z4v6+YmK8BCTvqHUC5bCgujbb9ylNeG6Wj8htL9u9wSdWseFnjMOiMbgjYAe3QbwHfxVGYcrofLZydtNmCenHdpFx4I+zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 22:41:26 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 22:41:26 +0000
Message-ID: <1e40efa3-3d16-4fc6-8686-2bcb254c7c5e@amd.com>
Date: Mon, 4 Mar 2024 16:41:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] x86: Confine early 1:1 mapped startup code
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 Kevin Loughlin <kevinloughlin@google.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
References: <20240227151907.387873-11-ardb+git@google.com>
 <8b412f69-a08a-51cb-8223-ed1933031d5e@amd.com>
 <CAMj1kXFgUNDusUzVKh=2Mn802+x+0iop7O-aEZH0iuQtdOAFcw@mail.gmail.com>
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
In-Reply-To: <CAMj1kXFgUNDusUzVKh=2Mn802+x+0iop7O-aEZH0iuQtdOAFcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::12) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa427e0-4079-47f4-1a5a-08dc3c9c39f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EYzRwUgIJ0HsImOeJhEIsxLh4PZNpg5+icwjPRVXP/O06QbCM4ScqsDdooDN8RZmvoIsJGIknWxI9vxp6Tz7obPF2wTVRzYzb7zmVDY6+GM1hCnxSGJ7gDQevsrLPbDI/Z82ierpN10Dy7sv8KbFKTEeiC4mHEMkz5xPeSzYSVh6obqfgFoXXpee0/b53jtqCDmfB1Np0vtP4r0XoLz94PdQl2fFDWjLQPtKpWgbTPC82elN3mYjAcjaEw9aHKabJK+hVvOdrrOLQSQuuaFRMH62LrtOC2Vz4tM8+oDScsN5Bt2hg72JNsveyz1rU19d6ahJshon79bNhCxAjqVdzD1bDDsJWFxP7FsMOflDMjzQ6odeL98PU/ME3iSWqxGOpt3M9qr1kCjfn1JcXHT6QYkkgHmRW7VDU4f2wVYmbDFbb5NcCqoUya0PM8jUGeKeVmPJ3tBH4Z2kYJRl+Ef4QFT5oC6NEyTi5ObVQrzJvODV39u0nFEAaBqVDLzU8C2sIzbeDNX+oosaLlkccaukPY/61aD/QcIj1teU+Yupt58bAOEDsefgi9PBi9blitctd9wuP2DPI3b893g7RIIHf/G2TIqvJt44aFzX3+1FE24=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWhqQVRJdDJBTnA1aEhUamNvUmFrOUxlemtXVitKUG92cnF4a04xWS94cTlp?=
 =?utf-8?B?QkEwR2JKR2FqMEtsN0s4YlAveWQxa0lsWTJkT1N3RHN2Y1dNYzJwbzRxbTdo?=
 =?utf-8?B?R25zSWhHbzExZmNKTlB6QTNPMTBiNTN4dDZJVkE4Vnh3RUNrUkZlc0lSbnlU?=
 =?utf-8?B?KzAvR01pWmJjS0dtNUhiZkdleVJQQjFVb2F3aGlTL3IzZUxXbjd3TFBSV0Q4?=
 =?utf-8?B?OG1vN2Y3L1ZBcjk5SGRzSVRaaUVDWEZxQjdLTFF4ZzF1UVBNakRPYkhRRXd3?=
 =?utf-8?B?VlNUQUQ5dS9sUTd5S3NId2ZwYW0xSm9LcDREWWJPR2RkVUMzMjNVV3d3MlZx?=
 =?utf-8?B?R1pmaThFNEt5UElaYmNRcUd3T1RQODdjeDZ6ZnBjN2k2eXpadzhKOFRRMVBy?=
 =?utf-8?B?NTA4UTNOSVBmQ2Y4VHRFMHlzYTdCMlFxeEJSVXRub3N3VG9wZEpHcVVmOXJv?=
 =?utf-8?B?aVZOcE9NK2NST0kvZSs3Q1o3Y055amFUSlJTekFLREhkRWJwWHN2NWR2VzRJ?=
 =?utf-8?B?Njd0VlQ0RkdzYU16YnZRVGtLa0xVSlJncm1BY0JtRHduWnR6QVplZHVkUDhR?=
 =?utf-8?B?b3V6RnZaOXhwQ1NKamsvbnNDOE51T3RQUFdDZDVRa05oY2V2bUsrS0lZdGwz?=
 =?utf-8?B?cktIcGZzUmFPcTNEQ2hXZlNwUFFISW0wczc1SXdxVGxGdWdUMytKK2VCQTND?=
 =?utf-8?B?aWdMMWlsaHBPSy9XeXk2cE5rU0l6SG1EV2Y1UVdzcTdLYXl6cDAyQWF4V0NU?=
 =?utf-8?B?Mk45eHBibit4bnNJNE5TQnBGMkFWZXhCR0JyTXNpcGFYTG9UY2IvRVdmZmpk?=
 =?utf-8?B?WDdHdFZnL0hpdisxdlVFUnFQVFYrazR0eFoxcG9XUlhYR3dHaVovK1lYTUd4?=
 =?utf-8?B?SS84KzRQZ1VEUnVndDdqaSt6TUc4MjdVd1RQYXFyc2J3YldpMzI3NzcrclA3?=
 =?utf-8?B?VjZEZ05tLy9iRUF2U09qUzRjU1pDK29XaGEvSTJvUGNyblhSQW82dGJ6b0J4?=
 =?utf-8?B?S28rL0ZoTEovb1ZHQXNvRkNoM3dKbm90ckZYMmF5NFlDVkQzMVI1eEdoT3o2?=
 =?utf-8?B?NENMaDhrclJXTkc0WVBHTjFpUG1wdEdxMEROck05bVRNQ1dzZFY0TklkSW5D?=
 =?utf-8?B?WmxwUkRkVmNEU1VJRXFVZkx1VHJlWUpEb3hhd2xIaHd5VVFncnZ2SmptcU1q?=
 =?utf-8?B?d0Q4Tkd5SkZ3NHF5dllxZ0RsL2M5WVJyNGs1OFJtY3ZGSDNIcDBFeTlQVnJH?=
 =?utf-8?B?NVBHazRJVmxhd2pwcjliV3RLdTczWkJuZ2JwMUprWlJ1YTR1Q3NsYzlhRFVK?=
 =?utf-8?B?ajA4Z2djRUJ4UWN2bkZqY2tEUml2Ylh0L3J5VktxdkZQRGpCRXJONTJFY1Zv?=
 =?utf-8?B?VWd5M1VPOEQzRkEveFhPWklPZjQxOElsSmJkUmdPUWh6c2FiR2JZaGh0RDdY?=
 =?utf-8?B?bHZZT29vWDRlcitKd0VkcytCSU9BMTlVNkh6M2plWEtKWW9TdWZkSDdsWmc5?=
 =?utf-8?B?N2IwTm1vdmVud2RkM3pKRk9xamV6VjZhUnhYQ252YXF3WTlCZ1p5eU0zZk1i?=
 =?utf-8?B?SU9rYkNtUnZqSU95bjlCbkNYNWRyYkxtSWkyS3VzVlozSWd6dHRvVzZVbDBL?=
 =?utf-8?B?V2N1czBUbG1wUnV4T2JrY0lRTWhLT1Buc2VOTGFyOUR2blhHYmlEQUs5T2s0?=
 =?utf-8?B?V3o3L3BuQzdKb1orK25XVitwZ2N4ZXJEN2JXKzRVUEFBUVc2K1R3d09rRGc1?=
 =?utf-8?B?eUEwVUFEY3pOaHQrNENnQ1F2ZVdZblRmcUJqazkzTDEycjVBVE0yM01oRGpL?=
 =?utf-8?B?V0h3OXFWejhoZmQ0aDlSelNEYUtUR0p5eVBiZ3l0OU95dy9PNHduWHpUem01?=
 =?utf-8?B?WWdhUkl3aVVqMm9WTGZOeGdrRW05TnFwVHZ1bXFnUTNaSW1rQUFMdk0wVnRy?=
 =?utf-8?B?c0o4MXVWcW51SDM1SWRqN24xaTVhdk5pQnVsY2Y3eE01S3ZlZUJ5WlpVcm9R?=
 =?utf-8?B?QngwenNYd3NiaGJXcWZYQTBZcExhbm5KUU03VWVRUE9EK096RUNXOHN1dkYr?=
 =?utf-8?B?b2h3cmtIcW1xYXVjcXJCRytJTTUrbUQzeEV2bjN5UUxka0xRbTFaUS9aaUNN?=
 =?utf-8?Q?6ofiI0EFo4vQ/FPP/RWwS0gt+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa427e0-4079-47f4-1a5a-08dc3c9c39f0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 22:41:26.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBhlrfe0F6tJcynO/ca+9NAzkwvryZQUIIPuOht41A5auRYN22CQvtXGLfKl81oj+Zm2iexsN6U/VCzjwC5KDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050

On 3/4/24 13:13, Ard Biesheuvel wrote:
> On Mon, 4 Mar 2024 at 18:07, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 2/27/24 09:19, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> This is resend #2 of v5 [0] with some touchups applied.
>>>
>>> Changes since v6:
>>> - Drop flawed patch to move some SME/SEV related calls out of the early
>>>     boot path to avoid the potential need for backporting patches #6/#7
>>>     to kernels where SEV support may not be crucial. This problem will be
>>>     dealt with if/when it arises while doing those backports.
>>>
>>> Changes since v5:
>>> - drop patches that have been merged
>>> - rebase onto latest tip/x86/boot
>>> - fix comment regarding CR4.PGE wrt flushing of global TLB entries
>>> - avoid adding startup code to .noinstr.text as it triggers objtool
>>>     warnings
>>>
>>> [0] https://lore.kernel.org/all/20240221113506.2565718-18-ardb+git@google.com/
>>>
>>> Cc: Kevin Loughlin <kevinloughlin@google.com>
>>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>>> Cc: Dionna Glaze <dionnaglaze@google.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Brian Gerst <brgerst@gmail.com>
>>
>> For the series, tested bare metal boots with mem_encrypt=on /
>> mem_encrypt=off and boots of SVM, SEV, SEV-ES and SEV-SNP guests.
>>
>> Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
>>
> 
> Thanks a lot! I take it this was a kernel built with GCC?

Yes, it was a GCC build, so I went back and rebuilt with Clang-14 and 
everything was fine there, too.

Thanks,
Tom

