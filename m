Return-Path: <linux-kernel+bounces-21829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CD28294EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90D71C2191C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4835B3DBB9;
	Wed, 10 Jan 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YyPJUl+d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EPd2WSZp"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB43A8DF;
	Wed, 10 Jan 2024 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40A7lC3q009796;
	Wed, 10 Jan 2024 08:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VEGbHUpMObw7fHGsQDHJwFg4KtXzuRKucLez2DtEIwA=;
 b=YyPJUl+deeT0fUvf1PubfNtVigtVXpgjkp5MPvZKvJd8I4y2z+VgkPepKv6Ea5rK5s9T
 uFbiQHNUEnkDGxVRGR/SUeO04R/uAs5CFWy4+RLZRcN51FakkYLMSO97vvIjirqMpe9h
 0/i9cEJ7qtoVubAcbxWfcHdLDjIBHtzArOkUq6qdiPuMxHpVKijWIcxlnmo3jjbXX3ix
 ledLXx9IyEqejuwcnUO5SR971i+chxJIFsYs8N+B+8bEdNYCgi/UCE8uJdrok+IJ7t8A
 w4xbh73NSLwhW8BOG1pNJllTUwUj8rtR4aZj762rO/bslYu9tzzKsYVxaGGmZYna9fIv iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhq5fg1gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 08:16:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40A7UVQw008735;
	Wed, 10 Jan 2024 08:16:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuuk89dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 08:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErboZpMVX+Umdkfir665/9hvhc1/FE8GQZVr05tm51wgPpcESaCYju7B+/raQqcV9QDp8nwr0aWXL8rRizZ6i+wP5cKHZyYQbnzKBJmjtVwQ/uDxYtWXxcjwNji0XFTKlfB6T5sFghH/11Ndgxg2B4fdRxj0CWAyFQl8JvuDG37LsPfuhdDWJjzW1u5Iy08LXorveWU7CABvmHOqfyVaBKN/RJIshfQYO551YvOBQpxU0BCnHPsiQln4sGQdgMcF57ZEc2l6NfEfkfAEvq6+RnmCDzY13re82YU1B3+qsW8HjPD/PoZdnXnSEb63rQr5FPq7njPAo68+LZkQHGBJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEGbHUpMObw7fHGsQDHJwFg4KtXzuRKucLez2DtEIwA=;
 b=nkJQ7kXkHTv6rsxxcHHpdrO7Jzj3bnFrN8hLqn1/BMQ0MPAmEdV/PIW5xaVuhNFTORlZG6pifZnjr/qOAgJOg4OS/nmWlFmwXzGl50G8gtBdcwCqHm+YNzTdDYGWTp6MW1poNeYADPjWOQv/bwUpQGknDYfNPQ/J+CBJRaHyvOEVcUmAftHwc6tdVjIRC0WEr05hIXAcFxDYp1sfM7gZ9sti3/UtpMqiDeTQyiEGFLCFJ4SeSMEDEhVYpzXQK/Ujqbr/fu3AEt6WN4A869RZ2yoqKJvhPp9usSCzQFbBexKnlMmmXml8dVWLk8IFGjpvVk/WD+IzpnU27JLX0n2MtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEGbHUpMObw7fHGsQDHJwFg4KtXzuRKucLez2DtEIwA=;
 b=EPd2WSZpPQUHt7e90HC0d2AWFcoQIeInDjpdoBxIF0vWexSyrkPex7cFY+YQN/T2hALRTSvKKA0JLrjJh2VTWOWnoxeVJScbEWFBGW59HaQ5HZXzMam8FhhjI823lFUi1ByzU26jT2nJo998xX5HvvHK0DIrkbMDjpn46fGqDzY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH0PR10MB5244.namprd10.prod.outlook.com (2603:10b6:610:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 08:16:39 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 08:16:39 +0000
Message-ID: <9e33f7dc-deee-4165-bc10-ad77f38b270a@oracle.com>
Date: Wed, 10 Jan 2024 09:16:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Documentation: gpio: add character device userspace
 API documentation
Content-Language: en-US
To: Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        andy@kernel.org, corbet@lwn.net
References: <20240109135952.77458-1-warthog618@gmail.com>
 <CAHp75Ve05bAK-ehZZ7XSci5VqR18cCb=hgnbFKXwy2QPkxo=pw@mail.gmail.com>
 <20240109234518.GA7839@rigel>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20240109234518.GA7839@rigel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::22) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CH0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 162258ae-ae4a-42b3-79bd-08dc11b47854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KoU7GzCyXIlLUhePJ4R9ZBYUe0huhfbHks0mUOFiZUcYFXAevyCkZufFZY/Q88nRW4Cfnm2vmT6nGfdBQdJQ8zi9KTL6mahPLI4DgkYktxaIScjLWIkp2UPpvmrdLRIVslqOywO6Ua74wkU5oCH05rY8FTmu0MUtxe76vd8UmlX8lnkGDBrMVUUulJX8N1F12cH+7D/fX/92kdRoN9ihud60S/fR7HF21Wdj44XAwYYfJPR7QmQVhSL5UZRVkgwBqBnHg0d48LKSsQLO3VQoGaQeb2+DeqB9mB9uEiaR018ba/YxwIpBlNIackMdHVSKEMcUMkiP1DMo+dUEw7YGb95YyxithQng5cDyk1p4eR+SiS+B6Bk/0qMvx5GS+e5DZSW8q0KADMnca2c/VN2zpFs9A3qquW8g29QYmin3zCgW1vcHNsIVfX2xZDb7zO3K42ijOtR6hM/DE3231iTyB3Vqls1d9bnsRRwcDMOO8ouI/9xGgT2HvtP7ede6ifrx+Dot+ZF8DxuR7zO5Z6mZSJB8S35mLoUeXGzNrAn+sl9wQ26kD69vzKAWKBCdUwf6H6SozrKWdLVQsG2tDPt2BfxhjGToE6jGouwDkUQ0xNqEyE8HD62vbXLOKjGUz+1Dr4Od3he9csjPHB12c+YlEw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(2616005)(26005)(6666004)(6506007)(6512007)(53546011)(478600001)(6486002)(966005)(8936002)(8676002)(36756003)(110136005)(38100700002)(4326008)(316002)(44832011)(66556008)(66476007)(66946007)(31686004)(86362001)(31696002)(5660300002)(2906002)(4744005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cGNOWEZ3ZXdWVElWeDVRTEtTa0lYRUxaWEhDZHRRRkpVb0J5THpqQUZlaU5m?=
 =?utf-8?B?bUc5ZkJkVGdWL2d5aWhaUnNWb2thbnFrRktaejdETkcwZy9HeG1QVnltVmNn?=
 =?utf-8?B?TmNkZ0ROd0JjcWkxbnF0aFVUSU9qV3V3b2VNaWJmQ2gzOVJxVGpVVzlhbzVR?=
 =?utf-8?B?ZitNVzVQV1RwOXRKTWRtSVczdjUrNzJmRlhnZUlZbWt0d1JvZU1MVk8zNWxM?=
 =?utf-8?B?M3JldUVqWGxBYUtKSk9rTzlhR0QxOTJDUi9kR2pqd0V1MTBpczNaUG1HdG9C?=
 =?utf-8?B?RmF0SkMxZFpoVjRnUDNFNUtxTGM4Nmd6L3NpZVkzTzNqWDNOclVqYzdpd2kx?=
 =?utf-8?B?K1ErSWRVL1JVR3JXL0VMYldGOWc0bVdCQmlOQjRXUTlGMWxhWXF4YTdLT2xG?=
 =?utf-8?B?OVB1Y203WTgyaVdDQ29HZnhtdEM1bHJJc1R0V3VIYWRFbEFjdlJqM2p6YW4x?=
 =?utf-8?B?dnE3OWxsNmxzTENMTzhzbWZoZEdUcGdFQ2o0UVJVN3ZleXYveWN0S0RFdnZY?=
 =?utf-8?B?WnBGejNKOUFuWXJuZklFbTA3RGtIbldYOERweG1uVVVqenNLbmJJUUR1UTBr?=
 =?utf-8?B?KzJjbDhuTEtXREV0L1BzMGRtTXNBQ0VURXZRMWQxWnBqRG1SSlNKamdDcW5C?=
 =?utf-8?B?MXc5SFM2bkd3U2tQa21NU040RkFBRWFPZXF5bGl6SFJPaHk1WVpnYlpNOGQ2?=
 =?utf-8?B?aU9GNE8rVVVXUFZLeWpIT0FyQllVVnRUQ25GamJjakFIWmNzMStnYUh0RC9o?=
 =?utf-8?B?cTUxMWh6K3d2amxac2tHWXpYbXh3eWxCbC9pY1l1Sm4vbzNOcnMzbjhZZjBu?=
 =?utf-8?B?WEVTNXBHWXJJdGJYSWw0NGJWblRRNUVMNm1HQUl6UHl2KzlwcWErVXlzUGNy?=
 =?utf-8?B?SS9NUjAxMzNKRzdFYVFLY2RrQTMvWUJxcGJkcTlLSWwrWTdwaDE0Wkt1NXFN?=
 =?utf-8?B?UFArM0VZcHo3NFN4R3BlTHdPOFFyeld3a0FWTWpOQXJTdFFHSHFBNWllODJj?=
 =?utf-8?B?R1NyWU1EeWVFaFVHWVNXa0dtQnZNQXZGTCtFVituRFJ0ejJWV1Nsd01IR2VX?=
 =?utf-8?B?cVA4MDcrcnA4bkpFMHJObm43YTVlNk5FSWFYTjNBRzI4OTJqanhVZmJFZ0Jv?=
 =?utf-8?B?c0xiaHB0c0NCVzlZb1hrZEptTmtQdFZrZmYyYlRhWlhpTE80WFcrYUlCNURz?=
 =?utf-8?B?L01yb3lnUVBYUjV1c3BOTFp3RWd2NGFKbE5nY3JUbzRFTkNVOHYyTzJXMGdq?=
 =?utf-8?B?WURER25ISjJJeGpEL3FIbk5vdUVPNWdNclJKZjRKVm84TmR4Y1c5aTJrZkRr?=
 =?utf-8?B?UUVyRURUWXp2em5iOEI0ZzFvcUN2RHdnOCswSjhhRXh3cWM5UTZtaGdKMUY2?=
 =?utf-8?B?MGk2cVRiV3grYjFXSnZ5amRLWnJ5NnBTWVhKblRMVzcxay9ibE9BUnRDTkVC?=
 =?utf-8?B?MHdueFZ1a2RCZWxJRGdlSVlsUklTZjVaMG9Oc2p6YzFudzhMM2MvUXBBUlMv?=
 =?utf-8?B?bzJuaWdtVFRPLzlkam16SXpNMkFwRU4wRnNNTEFVencyZ0M3elRQWW9jb2Yv?=
 =?utf-8?B?ViszTWpRT3V1a3hCMUlRVkNUVTBXSkxxMlpXa1JXRDhuUXhLcVBQdm5rdnlC?=
 =?utf-8?B?SldXL2N3M0NIK3pERkFMZndScWJLakgxZm9kZWZFUmxLVzlwYVg1NmVwQ1RL?=
 =?utf-8?B?cCs4Y1dNWXBLMFFsQnZPbGN2WUYvQ2prNFVuRkpURGtYMnZPT1grdWNEL0Js?=
 =?utf-8?B?N3ZOTkprc2R0YTVMeG9ZYUJmcVRRbTBCRWEvR3VPZnp2akNHUnVnN1NQaWQv?=
 =?utf-8?B?RWtYVGpwVURmbnFHTStaZVFFWThVMHkyMVhxcUNVWmFaTXEvR0haeUJjVDhM?=
 =?utf-8?B?SG0wUVZnaWk4U0pTcldJVWhCbFUxWjc2T0pCYzhlS1VhcmZmK1F6OERoRzFz?=
 =?utf-8?B?bS9pV3hUa3BDYmEzRFM2bTZCRFNRZnd0WFd2ekxLMHljeS95TVFUZ0NybXZQ?=
 =?utf-8?B?TVV5NTBiMFNueS9PSk5pTVhuRENlWUdzRjdxNjYvbS8xaG9POGlHQnFrMmtH?=
 =?utf-8?B?akYwT00vSFZkM0hNZVI4OG1SSkZXM2JIUkJOUmI0NVZ4YUdZYVJ2NlduVHJX?=
 =?utf-8?B?NHR3MEp2YkFJam93SzdIaGN3V2JFMVB6cVJXZEVLQTJLUE1IWkd5L2dYNHlJ?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dAT1JzXBOjozcOAH4vLXXCSUJyykyUVCYvQQ2bzVPb8QeahnKxXvEwx8AdPiEt2VJq2GqCxQSMI/rzRf3wALQpc2i+MbKG6YjXGXPgzDbNBxuTL3abGjjVYagXVF8XBDJm98PjPwV1hTSPAjWO/OiXQ/Ys6AMRNwTpOaYjLPclFELOZP1z/9UCEbh7BKl8LgXLo4wA4IBb8PBWXjO32t1bLn4Fqpd7vQEPneIRrr1hTrgUR625XafOLu7tglGkFnYhLKvXvOneEh75MuNXbur8LMKzEerUzM+pdkLjgfYnpE+ZaKWAweQ9JN3rEk2VMrdNZNMcQfspokdjzHQ3OqRn0Qg6/jINfme5zZjNdLTY/r0S5RDMG9bF0orN8sYS12BKOhvj9KrSPEFyigBo6trjvaK38QY+l/ZZgBNOx2Dqqq/ufXy74WkW19d99n+vUJ8wI99JwjhiPUQJGhNHoP6cFG7ss60d59l44Rh0xdj7ELpAXoKAT9qIUIbKtwY7xU05YampoPaG4HyxcXUX5b3PHKye3Ri1Tjkd1qjZ8Jacs5dkYSTig9ypomg/E7oaxEtTMVXmBDdM0EDCLgwQFNyvtGVG2bHvbxDDkHgSLLbHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162258ae-ae4a-42b3-79bd-08dc11b47854
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 08:16:39.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBQOPcdy5JAgniKo2e4Zafg1pGER/wlYgw9raHos/Suqeu00SmNTkS3n39ugEJWSV0L2ZFx8vHTymwiz9SlJXX2bUaccGd6UpuhIE8Cbs2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_02,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=893 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100066
X-Proofpoint-ORIG-GUID: jJ7V06oEqvW4HMNSMS2oDQ36VcjTxnHU
X-Proofpoint-GUID: jJ7V06oEqvW4HMNSMS2oDQ36VcjTxnHU


On 10/01/2024 00:45, Kent Gibson wrote:
> On Tue, Jan 09, 2024 at 10:00:26PM +0200, Andy Shevchenko wrote:
>> On Tue, Jan 9, 2024 at 4:00 PM Kent Gibson <warthog618@gmail.com> wrote:
>>
>> May we actually state in the documentation that sysfs is subject to
>> remove at some point?
>>
> 
> So formally define what "deprecated" means?
> Is that covered in the higher level documentation somewhere?
> If so I'm more than happy to provide a reference.

We have a few files that may be relevant here, that I'm aware of:

1) https://docs.kernel.org/admin-guide/sysfs-rules.html

documents some general assumptions that userspace can make about the
stability of sysfs and its files

2) https://docs.kernel.org/admin-guide/abi.html

This is the public-facing, somewhat machine-readable repository of what
is supposed to be the kernel's ABI/API, including "obsolete" and
"removed" interfaces.

3) Documentation/ABI/README

describes the process of deprecating an interface


Vegard

