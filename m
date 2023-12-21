Return-Path: <linux-kernel+bounces-8524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A681B904
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BD0B27769
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903CD65181;
	Thu, 21 Dec 2023 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aGaXjg0k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YhVN8n2E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378CA634FA;
	Thu, 21 Dec 2023 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLDODMl009053;
	Thu, 21 Dec 2023 13:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=L6Hj8sFTXTGt/bYScuebyERwji8OPZM+gwncYR/oZ0w=;
 b=aGaXjg0kxD7uL9aDqLmdnUehe9HMs8mkOLxaRqtNKtJF1bF3zZeSI5j+Q7xze3ACj0m6
 S5eHZ652EIN0a/7ijw8n/j0xkel56io+1xgGE4A96fd6AGt95PCCiaxEqoLKsK4/DDH1
 kLlBC0VRRGc8Ooiu+Gj0Lp7CHADkhTv/dxdffhwemAAVFFYXZGTA2l3XahS/ccGHRrcI
 14Onz8cQnmA0Y+ojG0p87aTqZ2AY4i3OLOotEdoSMLWH3dSM47HiJXcCkblIx4Rncv5A
 dEATi/YuFFTXC5WK8VvXgxGCRCGgw5guLEcxYDqmNJLiWgdILgQQEjl/d4hcqq89IfRU eA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13xdk18a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 13:48:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLC9cRv030846;
	Thu, 21 Dec 2023 13:48:18 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bgyrjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 13:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmC3XWNpPr6Lg7Z02m8WSKahMVDGCLGh3feJ49X4ceQUtNqqNpeHkN2As1ua43oEe7EMpbOuMN4TT5cGFdByuS5aI/xYwjzeUHxzImOnD2x6UR09oCtC16LpYK1OxO4uQrkTsHo/IVfqjOILovJG/fUemdc9/MTcHK20/Oy/VeX+l/CPo3yj2H7vt4KINlFbqEm5RQF+aaV8a9RKLNW2AJ9Z+jTt/AM2loINv6V45xT61p3M4717qkVOacVJ/Gzf8Qi5F+FfDcq1GkTfpsI/Blc9VlfairHnv4/d76OKSDtoH2Ykd7jfQ1vTu1ZEz/ID7CJCAiF9gBDSuQQMXw++oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6Hj8sFTXTGt/bYScuebyERwji8OPZM+gwncYR/oZ0w=;
 b=IzIhW8pqyGAQn2lrbWPU14un+RFr8wkdCQYIQDUuHZn2R4fKwTLOonD9cPk/8zRX/Aj6nPJ1c1r06H7tfGRfdtMMQX0ozF9IzxKjHlwa76wNfYPejqDCMCWvVly9a8BDaUigrCSKQy6tanRLC4gaLjapjjvM6N9UopsqGt+jY9nwJs8irW76jYv4NW8Dl84McmNJ09sPilBB5fvqL9hg9+b/imHbL8TOCTwW4ai/ZdDieeMzjEUOho5tofC8kpHHNO8mCeynpQq6d4Ane6AfLvw10BuznLP+XFKAeAjVwhMwb+zpOcBe8HTRMZG8+NrkzroqhxRPlfAz9j8Kii3PiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6Hj8sFTXTGt/bYScuebyERwji8OPZM+gwncYR/oZ0w=;
 b=YhVN8n2EmIoQfqrIaDv7tzlXnWWXSdeww/MnDGZN88x+YFVhf021yLxxmxJqFBMVL6XZi7cQtnCLTZd2CNvpl52ap5QuSjWdRWHeZawsGwfw8SimdNkFsMuqoMFiVTB5LuxKRBgngPD9JIJmaa4nLXmoDbh9S143FhKNO+WgzqI=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA1PR10MB7333.namprd10.prod.outlook.com (2603:10b6:208:3fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 13:48:15 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 13:48:15 +0000
Message-ID: <93e1b9fa-c447-4f7d-9dc7-825ebe9e1cde@oracle.com>
Date: Thu, 21 Dec 2023 14:48:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/kernel-doc: restore warning for Excess
 struct/union
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        linux-doc@vger.kernel.org
References: <20231214070200.24405-1-rdunlap@infradead.org>
 <875y0zqvjr.fsf@meer.lwn.net>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 xsFNBE4DTU8BEADTtNncvO6rZdvTSILZHHhUnJr9Vd7N/MSx8U9z0UkAtrcgP6HPsVdsvHeU
 C6IW7L629z7CSffCXNeF8xBYnGFhCh9L9fyX/nZ2gVw/0cVDCVMwVgeXo3m8AR1iSFYvO9vC
 Rcd1fN2y+vGsJaD4JoxhKBygUtPWqUKks88NYvqyIMKgIVNQ964Qh7M+qDGY+e/BaId1OK2Z
 92jfTNE7EaIhJfHX8hW1yJKXWS54qBMqBstgLHPx8rv8AmRunsehso5nKxjtlYa/Zw5J1Uyw
 tSl+e3g/8bmCj+9+7Gj2swFlmZQwBVpVVrAR38jjEnjbKe9dQZ7c8mHHSFDflcAJlqRB2RT1
 2JA3iX/XZ0AmcOvrk62S7B4I00+kOiY6fAERPptrA19n452Non7PD5VTe2iKsOIARIkf7LvD
 q2bjzB3r41A8twtB7DUEH8Db5tbiztwy2TGLD9ga+aJJwGdy9kR5kRORNLWvqMM6Bfe9+qbw
 cJ1NXTM1RFsgCgq7U6BMEXZNcsSg9Hbs6fqDPbbZXXxn7iA4TmOhyAqgY5KCa0wm68GxMhyG
 5Q5dWfwX42/U/Zx5foyiORvEFxDBWNWc6iP1h+w8wDiiEO/UM7eH06bxRaxoMEYmcYNeEjk6
 U6qnvjUiK8A35zDOoK67t9QD35aWlNBNQ2becGk9i8fuNJKqNQARAQABzShWZWdhcmQgTm9z
 c3VtIDx2ZWdhcmQubm9zc3VtQG9yYWNsZS5jb20+wsF4BBMBAgAiBQJX+8E+AhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRALzvTY/pi6WOTDD/46kJZT/yJsYVT44e+MWvWXnzi9
 G7Tcqo1yNS5guN0d49B8ei9VvRzYpRsziaj1nAQJ8bgGJeXjNsMLMOZgx4b5OTsn8t2zIm2h
 midgIE8b3nS73uNs+9E1ktJPnHClGtTECEIIwQibpdCPYCS3lpmoAagezfcnkOqtTdgSvBg9
 FxrxKpAclgoQFTKpUoI121tvYBHmaW9K5mBM3Ty16t7IPghnndgxab+liUUZQY0TZqDG8PPW
 SuRpiVJ9buszWQvm1MUJB/MNtj1rWHivsc1Xu559PYShvJiqJF1+NCNVUx3hfXEm3evTZ9Fm
 TQJBNaeROqCToGJHjdbOdtxeSdMhaiExuSnxghqcWN+76JNXAQLlVvYhHjQwzr4me4Efo1AN
 jinz1STmmeeAMYBfHPmBNjbyNMmYBH4ETbK9XKmtkLlEPuwTXu++7zKECgsgJJJ+kvAM1OOP
 VSOKCFouq1NiuJTDwIXQf/zc1ZB8ILoY/WljE+TO/ZNmRCZl8uj03FTUzLYhR7iWdyfG5gJ/
 UfNDs/LBk596rEAtlwn0qlFUmj01B1MVeevV8JJ711S1jiRrPCXg90P3wmUUQzO0apfk1Np6
 jZVlvsnbdK/1QZaYo1kdDPEVG+TQKOgdj4wbLMBV0rh82SYM1nc6YinoXWS3EuEfRLYTf8ad
 hbkmGzrwcc7BTQROA01PARAA5+ySdsvX2RzUF6aBwtohoGYV6m2P77wn4u9uNDMD9vfcqZxj
 y9QBMKGVADLY/zoL3TJx8CYS71YNz2AsFysTdfJjNgruZW7+j2ODTrHVTNWNSpMt5yRVW426
 vN12gYjqK95c5uKNWGreP9W99T7Tj8yJe2CcoXYb6kO8hGvAHFlSYpJe+Plph5oD9llnYWpO
 XOzzuICFi4jfm0I0lvneQGd2aPK47JGHWewHn1Xk9/IwZW2InPYZat0kLlSDdiQmy/1Kv1UL
 PfzSjc9lkZqUJEXunpE0Mdp8LqowlL3rmgdoi1u4MNXurqWwPTXf1MSH537exgjqMp6tddfw
 cLAIcReIrKnN9g1+rdHfAUiHJYhEVbJACQSy9a4Z+CzUgb4RcwOQznGuzDXxnuTSuwMRxvyz
 XpDvuZazsAqB4e4p/m+42hAjE5lKBfE/p/WWewNzRRxRKvscoLcWCLg1qZ6N1pNJAh7BQdDK
 pvLaUv6zQkrlsvK2bicGXqzPVhjwX+rTghSuG3Sbsn2XdzABROgHd7ImsqzV6QQGw7eIlTD2
 MT2b9gf0f76TaTgi0kZlLpQiAGVgjNhU2Aq3xIqOFTuiGnIQN0LV9/g6KqklzOGMBYf80Pgs
 kiObHTTzSvPIT+JcdIjPcKj2+HCbgbhmrYLtGJW8Bqp/I8w2aj2nVBa7l7UAEQEAAcLBXwQY
 AQIACQUCTgNNTwIbDAAKCRALzvTY/pi6WEWzD/4rWDeWc3P0DfOv23vWgx1qboMuFLxetair
 Utae7i60PQFIVj44xG997aMjohdxxzO9oBCTxUekn31aXzTBpUbRhStq78d1hQA5Rk7nJRS6
 Nl6UtIcuLTE6Zznrq3QdQHtqwQCm1OM2F5w0ezOxbhHgt9WTrjJHact4AsN/8Aa2jmxJYrup
 aKmHqPxCVwxrrSTnx8ljisPaZWdzLQF5qmgmAqIRvX57xAuCu8O15XyZ054u73dIEYb2MBBl
 aUYwDv/4So2e2MEUymx7BF8rKDJ1LvwxKYT+X1gSdeiSambCzuEZ3SQWsVv3gn5TTCn3fHDt
 KTUL3zejji3s2V/gBXoHX7NnTNx6ZDP7It259tvWXKlUDd+spxUCF4i5fbkoQ9A0PNCwe01i
 N71y5pRS0WlFS06cvPs9lZbkAj4lDFgnOVQwmg6Smqi8gjD8rjP0GWKY24tDqd6sptX5cTDH
 pcH+LjiY61m43d8Rx+tqiUGJNUfXE/sEB+nkpL1PFWzdI1XZp4tlG6R7T9VLLf01SfeA2wgo
 9BLDRko6MK5UxPwoYDHpYiyzzAdO24dlfTphNxNcDfspLCgOW1IQ3kGoTghU7CwDtV44x4rA
 jtz7znL1XTlXp6YJQ/FWWIJfsyFvr01kTmv+/QpnAG5/iLJ+0upU1blkWmVwaEo82BU6MrS2 8A==
In-Reply-To: <875y0zqvjr.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0161.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::29) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|IA1PR10MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: cb95266c-3c15-410b-c9ff-08dc022b7b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZFilwU7AmGjEePFvuwJ9NPcA9Q6n/H1bFKbXPoz84d+X2MniM7fs6HH0WG+RwfE/y3oTDiLRIHfA5AvEfhMVucN01tcroWTIdOSgxkoIVFu8MOcTDsT1hrauxtvIMRa0pun5/aOWPhO2IIlt95Qcp7LicDpBosyFAqOe9dGFEN7+Gpm7Rtaz/CzuRRfMFMn/FqgYjj6g9hIpfxzRf5wYwsbfwH/1IubjXTgEUahNh1jOR0fR7zsj8WO1pvkNqS3cPh8AkHWLxqHNF6QVYa1GGzebjcFagOmNc9vlq4Hj2xH4CNVxjW61GwJbBnXj7U275EhRa1aT48h5L+BEme6fp5aTiKisNcW+tj4O6QyDBnruZ6bhelLiTkIG7+2hRRU2T/RgX/GOEa2HvhtkN/UGa4d8tqh+VUE/c6yBIOeDb9vxhFiKymHK/C36UfNOWALeLQThZjEIfU48uqbUbJy10w0ofF7QLtypzACeJcgV14pTndsQAcC6dzddI22gXnND7+pR6CgpOqDD66n8PiFaCd7j7xuAoR3YleooWz0ARtE6yZpJbuNVrdkXeSR/S1rEo9ZD1fbWyAJvz/CbYr7yUAnuhzrgWH3pm6Ehva4mv+DYj3N0i0lihSa71BQ1KgtDzMcAmpYqGIUQ07KLNlPqz7y5R71lLNkOWB4XJ9zrhumYQ8NCswYrg5nUEIHT4TEz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(478600001)(110136005)(316002)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6512007)(6506007)(53546011)(26005)(2616005)(41300700001)(2906002)(4744005)(4326008)(5660300002)(44832011)(86362001)(31696002)(31686004)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czZEQmdmM3laTkxTeExDZ0JneGxWQXRzelRvT1g3NlRSNUZHTEZNTVJoV2pQ?=
 =?utf-8?B?YVZEV2pFb1NEUWN5aURmeUxIY25GMEtEb2N4TWZONzMvWU9Sc3VDcVFaSmpD?=
 =?utf-8?B?QzF6UVV0QmhjQzA4QmpHdEttOGFVemdJNE9ROFIzaGhJazd1SGNFZW45MVNj?=
 =?utf-8?B?c0FscXQwMXNVNFNTNnZqMGM2WG9vWjJub2NhQkdvLzY4c1N0L1haMW1TT2VB?=
 =?utf-8?B?N0dsaURZYWVYejVQMllQK3VPVXVZNXdFYkxjZmd2YndTMTQvcEI2NURUcU8r?=
 =?utf-8?B?VXFhcGFDMGNIMFJGRy9qbU0zRnNHekQ4OENZQ0FIMzAzSzNQM3ZkYks4WDdk?=
 =?utf-8?B?TnFkTmxOVXBaY3VFRnUvTXIwNVowS241SkFMVjZBRDY2VnVNcjhqNGVNMU9h?=
 =?utf-8?B?WjhBd2ppQWJZSzFQa240b3U0Q2JIMzhWa0VwbmxXY0NJdWZCajk0Wmp6ZWd3?=
 =?utf-8?B?SFBjWVMrcUw1enBmUmMvMStRTVR3SDFLQldQMUJPbll3N1czVmp3alo0MHhk?=
 =?utf-8?B?blAvdENEYXNuTTA2MjlGaVlLZU1XQ0s3M29HdlFtN2xNYWxuckdxOGZoaUxV?=
 =?utf-8?B?WmJMSWtWV0xMU3dHUUE1RnNsekFhcDZLUFpqS0hpaStZRHRTcGV5b3hUd3JC?=
 =?utf-8?B?UXJwWE5WWGFrWThpcTFpZm5mOThEL3dIK2NQNzFIVlJXZHpkQ2cybFFLQnVH?=
 =?utf-8?B?cGQzcU92UmpLakxHY1NGQ096ZXBpODZGbm9IL3NzcHpBZ01ld1JEZVAzNEZu?=
 =?utf-8?B?aGdBS0xhRkxVanoyTUhCWHdWQnBFWm5lQmYzZkFOYVlyUTNCWGJ5MGZoWFdW?=
 =?utf-8?B?ZzhwMzdJRVpidGlRU1ZUbE1aNnFNSmlFSmhkL0FvQ3M0Z21iZnlrcGE2ZDZQ?=
 =?utf-8?B?TytLKzRnSTFzM3lnQmk5ekEvZGxCdzRaL0ZwYzhQMjJSMCtCdTJZOFlJQWt1?=
 =?utf-8?B?blNqWWNjblpwQkxsbWU1QU1KL0R5WU9tK1FCYU1jV1BLU3RXeGkrV2tGcG5m?=
 =?utf-8?B?dmd0N21iUkkza0FwczAwNmViK2Z0K2RGWFRGOERjWk9lejNxeU9zMFBpeGVx?=
 =?utf-8?B?eDFKaEZRaTRzdU9ZRW00ZTNqVkNNbGNXRzNhSm5CNGJMSnBvdmhCQmhTM0VP?=
 =?utf-8?B?TzZMWXlnTWh2aUpvSXUzeXJKQ0dtOUlLZXd4TWVDZEVXNitmSjMwNElOeDEr?=
 =?utf-8?B?SG0xVGpBbkNTTEhxWmtBOU90K2ZjaVA2T2dzUW84c3l1OStIc2tiWWw2TWdk?=
 =?utf-8?B?a0dXUXZRYmtkSk05SnVLbGJNTE1TdDhIKzVMTGgyQVJOQ0hXNC9JOGVDOWtY?=
 =?utf-8?B?SHRDUFI5dCtHMFpRbmZyZWNURFFLTjFET3ZtK2pTYTliKzhvOFlQRTl5U0xu?=
 =?utf-8?B?OU1uNFNLcDNhb2pPajRsZm5jaTFFYXM4QzlDR0kydUVtNTcwS2xWR0dVY1ZW?=
 =?utf-8?B?bWZnb2s1dmZUMCt3V2VieHUwYUIyY0ZLWkkzNTVsdWJLTWxiTGRTMkw0SzhY?=
 =?utf-8?B?dXMzNi9Ock9Zb3puenJOc3p2a0MremNtaEZXNE8wYnowYm5qRVNZeDVvVDMy?=
 =?utf-8?B?dm5KSUYxa1FjL1FEOWdVRDRUN2s1b1lERTR0OHRHT1BZR2g5T2dkU0N0Zjlj?=
 =?utf-8?B?NlROcjh1QkdDOXIvSjBHRjE4NEp1akh5b1NWd0lrcWxrQWlEbUtzQXY1d2do?=
 =?utf-8?B?YTZCTk42cHpvdU54VzZJSXRZdzVucFNKNjZjWjVqK3ZmNEwxRXg0aEw5S05D?=
 =?utf-8?B?MXhvOXVPc2NYSCs4VmRSRlE3QmNvYUNxR0swSDE2cWdhYXh3QWlLaTBOOVdo?=
 =?utf-8?B?aTBZQkc1WUFVaXVPN2NhWFRRTjVhVUl5QmwyTUl1ZS9NT2pIdjNIWjBnRzgz?=
 =?utf-8?B?SUYyOVFlRjczdGdlNDd3YzRMRGU5VWtWcG5Ua3hCb01kSWQyYXpMSmlEZHRM?=
 =?utf-8?B?Ni9QSzRRSUlJTmtmd1h5WGlTNmZGTm1QY1hJR3I3anZZcUpRRzJhbEFXMlM1?=
 =?utf-8?B?b3ptQ3pYZUd4djBHWlRicFdpVG5lWjJmSUpjdUxDOEZtVTA2KzRvNm9TU2Nv?=
 =?utf-8?B?dVJBaHJUNE9PSG5objl6dWlZSThYVkVudUJ1eE5zcEU0UG91blJFUlJYRzln?=
 =?utf-8?B?UWhEbndSV0cyVldDdlZ3VXVMQVlYQW5VNDZKdDBubVBMdjR6U0RFS0FFR3dp?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ct7JEGW3fg3QQEoxPdoSkPuMLAZrswAZ79hotQjCdcK8aootUu1aAm5iqPFlkavUrMffxLMhMoX56CKfBHaoA6nU19kDSATj0u1GAingmnoBSQ+RFftDfyNNEoeogMev68Z3Vc5VAQqZKbmlQrLF3tHpbeaWbi4tf9pIOOYsWhiZsFl/A3FTd2B7XpnX2CilcTEP6FN1draBghf+D7YUYiMteJduCw2MFC5ESleUshphD7E1QUw3WrsE9M+gzIGq7CzZCJ1gAbzdofh5M4GOc2vIqssTWXTakJfGSxvqiI06bYVaOZcWaWL07ehhsi5RzSzYY+dNV0Wn+uTPnehuC+3GhzMp6gYMls0hlipil8liMy7VnnyKi2uWjYo+rfcggfvzLyiF5vGLK2GBe9odyhKUyC6EX6MQzI0qNPvpR1GpUS9FlqK8kJWqJM0AObznDOWUqzVXFPw2ehZ3pmR+h1rV+oVkg8FDH4jObqyRu3nOX4cKAemyDSHEpYFvMvGCD8bEk7wCxTYdjKGKp8rzOz8DSX1r0s8+0v5FEyPgX19hXhyS2345KUzQ0i/2hn16eePcMkWFHg/gsMt30E+d6VIN1XnfcbSUMC5Psn6f2Gs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb95266c-3c15-410b-c9ff-08dc022b7b17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 13:48:15.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhPWnXEkLyNwLO0JzbZ84zC71CywbwsaGc2tEB0pQ/ufovWY5pQisqQ9N0jIvndxuBThG4msF/ikZpRw+f13WYORNFzoIK73GtLP9cZ+uk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_07,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=983
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210104
X-Proofpoint-GUID: eb10xg83fdTURoxJnWTS96-CxvRReyRF
X-Proofpoint-ORIG-GUID: eb10xg83fdTURoxJnWTS96-CxvRReyRF


On 15/12/2023 17:28, Jonathan Corbet wrote:
> *sigh*
> 
> This adds nearly 600 new warnings.  Anybody gonna help fix them?

I think in the vast majority of the cases the fix will be to just remove
the offending line from the kerneldoc, so it's not particularly
difficult, mostly just overhead from the patch preparation/submission
process.

I'd be happy to take a stab at it -- I think we could even script most
of it. Respond here, I guess, if anybody else wants to do some so we can
split it up.

On a related note, it might be useful to have some kind of "status page"
somewhere on the web for the docs where you can see a list of unresolved
documentation warnings in mainline/docs-next/next without having to do a
local build first (as a way to solicit contributions).


Vegard

