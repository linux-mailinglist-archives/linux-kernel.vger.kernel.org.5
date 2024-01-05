Return-Path: <linux-kernel+bounces-18066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7CF825837
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F200328302B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4922097;
	Fri,  5 Jan 2024 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J6pqyERE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sMAYEqeZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C531A69;
	Fri,  5 Jan 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 405GAUHh015360;
	Fri, 5 Jan 2024 16:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TPrJg32xeLaifoC3h+EXOa81SBjzb1a30PBijdcCM6E=;
 b=J6pqyERERThKCScAoH176oxa0ptsrFNg6PRYszpdifB/GXef7HlPuE9rxZdhUmpwx3Rz
 crtS93xGVErMKmfrTtRSp0NXE9SBVay8Q4/PdSaFWXsYnR123nTRFuT4cSn4kLbXcHua
 wQal7m4Uy506Dpk12N+TJwAwFbgFdsa3QObzqVhcj99lRC68ZP0pkWyKZUasUk43+Alm
 NqjRQRdrg6KnHkehlaBQVkxniW/ULPP+sBC1iulE3eRu2sGZlOJhaPxp0jIPgWtDzRGf
 2Dd531Yt2OzA1z/oQHqboxWB6rhBX6Iosw2OnB1pUJk8vps9IhC0wtszQVckp2ITFaym 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ven25g2tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 16:33:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 405G38Zo009347;
	Fri, 5 Jan 2024 16:33:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ve12hx6a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jan 2024 16:33:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWHwve4aDxkyFm7fNBhfhkYuc+F6WVVrbn9cEk6uzZNnaqgJjzcnyPz8EoEWe0x9XaKck3q2/XBT+5854Ri62E7VdzshbpUwHB72SgOggPl1XuHzYY5JeGZph5jGAdva3VQE24aN9uEqN6PBl17CtHkbDkuuTlx5PIY/miz4VNkLXa6Y9MC5VJ7Lc4/NtgQSXrtI3cONUOPrUuEzU+DZjTqT6KO3nu/2xnK4b73qHOyBYtQo0Fn109Ad6hUdP29CYPRODfBj1YpoNt2RSUKc71fk9UN950h2yfTb1gO2YqgqV2H/93sf9yTO+qIDSsn3zIxw42dPSEQH+JRbn8t8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPrJg32xeLaifoC3h+EXOa81SBjzb1a30PBijdcCM6E=;
 b=WlGo4M2BGfPOzbr8hrLOy5XTl6BVYSFih22rye+ktI/LE/Lsd1fn90ksks4rPsk3S5/TfCktEr/7UnZW3gMGLAlvy8557MgG5Wyph2mDg2ZlX8mPeomlpK42iWgw91StKEk3KQDYa7DGjGRfVsiXmL6kYvPGVigVw9w86Z5PlCYbq8vpUgHa4iDVL2DrZAaKg6oKd2CO1DxF0oFLHhUrKgHB0O/wgedY7Ro1ZXxyQsagOwzGj9aA79R7BCypgqD3pifg+1XuDK8gqfxZ5nEfUbLsl8J0yy66nrjcPHsn5TT/eJm7T1AHQElC3/fGjf41tfTp52RKes69rpraxLSEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPrJg32xeLaifoC3h+EXOa81SBjzb1a30PBijdcCM6E=;
 b=sMAYEqeZRF37dMJTm8xrvMJMUXM+N5l1fQeBSj4KrTZTC/rk+IVwWKsAy980EKGifIo/n/7l+eXis8TQXghxMj4CQtGWgoNbUtWQWt6aqLRTinWAjGp6cKUhY8XL4aRru6qdMxGbX14a3w4HUKEInnq8DCq4TK81m18Sivb4V8Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4888.namprd10.prod.outlook.com (2603:10b6:408:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 16:33:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 16:33:08 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Liam Howlett <liam.howlett@oracle.com>
CC: Matthew Wilcox <willy@infradead.org>, Feng Tang <feng.tang@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev"
	<oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin,
 Fengwei" <fengwei.yin@intel.com>
Subject: Re: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Topic: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Index: 
 AQHZ4hUlovnTGopJRkWINRJx8jG2QrARAWsAgAVqhYCAAMJWAIAAJUUAgAANNoCAs2TmAIABXjcAgAABpgA=
Date: Fri, 5 Jan 2024 16:33:08 +0000
Message-ID: <A6AF10AB-52B9-49ED-9ACA-7D36981EFDA5@oracle.com>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
 <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
 <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com> <ZQCAYpqu+5iD0rhh@feng-clx>
 <ZQCLdzmtVcjxZWXt@casper.infradead.org>
 <D00399D9-D629-4CE3-AC32-636FD6F06C24@oracle.com>
 <20240105162704.7gulfnerq5tvmjbg@revolver>
In-Reply-To: <20240105162704.7gulfnerq5tvmjbg@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4888:EE_
x-ms-office365-filtering-correlation-id: 498e0f82-214a-4389-ff40-08dc0e0c003b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZVSEuqyVuAalJ9X5t6Ik1Ywo+4DocFaaELexin+w5TNQ7YbR1SIGWRofpiomT35DBHdOiMYmjuUjmg7jHrv9oD8Z9+kKLW6n1nPDdQuWrgofRyR0Lc4c15mR7HxliP+DEXyd5KzU2a6/vsvysxEl6nlYIHEcWtowXwqhsQ5n0WPj3Gns3L9/1+/i0sAUv6CvpATm1uCLzbOz6r+PMKBenePZAx0cNG/2iMzlKfp+odHQMZ4IVoSgTGHqT/0dfQJ4wGgGSgMLWMQCuH/A/6b9jf03dUbfLBhxIwcKYoVLzSoWpSF2H2Z3clUchr/uj2ZEY49WpMtKXOchF3SMQw74eqPFF/sr7H8YX9uCi3nleHihI1tSpVuCTZpvbnbiPmPhskxhoBU7a0z5yoOhh7rs4noE4TKIRia7hSidmpjKR6mALevx31zd8YNwGT/0S+azU8ZyT75mLfUhKsEnR+TlqnBzZ+eQtVxqo+RMLBzedJdwB6J/HW4s5UuRsunRr/51qVwQ64xDuH46DxykqR3T5hcke+s3ydGsjFNsZvaaSXjMxyAp9ON6CiXptZOaIqmUirplv7IcqQgWgzZeuaPsVnPF/+6B835TWOuEqFiSv8A1f2LZO6w5JA/YvnRl4JFurWITnc4ZV84yoibudEHbZQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(33656002)(86362001)(478600001)(53546011)(71200400001)(6512007)(41300700001)(6506007)(122000001)(2616005)(54906003)(37006003)(91956017)(5660300002)(38070700009)(2906002)(7416002)(6486002)(316002)(6636002)(36756003)(66476007)(66446008)(64756008)(76116006)(66556008)(66946007)(6862004)(4326008)(8676002)(8936002)(38100700002)(26005)(66899024)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Ui9nMzh6Q3ZPZFBVS2tBYTBub0ZTS2IvN01yd3V5NVR1MlkzcXNQbGJLNTRy?=
 =?utf-8?B?OWp2bmhLSUpETnhBNDdUdXJsQmNLbldMV3YxNkt0L1ZIMmtJYlo2dmFYQlQv?=
 =?utf-8?B?VDdkakJFcmxJbG10Um9qeHJVTk4zQ3ErV2daUEYzbWZYTVhlWFB3SG44TlpQ?=
 =?utf-8?B?U2NvVjBOVlIwMWhnRHMwenAwOFlybmsrMS8vcUpIOHFqallRMm1nTU9SMmpW?=
 =?utf-8?B?TXkydXFHOFlycnZnOUZTcys1ZVNsVWc5WXdxajUvT2RtN21NT2lhcWRoTk85?=
 =?utf-8?B?RnpkWXpuRGZEbkhIaG4rODZRRU5oWXhCcVFqRis1eGV6TzZwTHZwa0xUamcv?=
 =?utf-8?B?b1ZsTzkxc1FnZ2hJQzJZUytzczM0amZIOXI0bTBnMEdMVnEyZ0xwNythSkpR?=
 =?utf-8?B?ZldJMHJHL3hzekxIZUR4dDBqN3hjb3c0Mno2QkQySTFKRUFNYWN4bkw2T2Fr?=
 =?utf-8?B?aGVyZUtSNmJRbytlb01paG1SWnlCSXo4WXY1eXRNbVJSK1doY1BUT2N3NVph?=
 =?utf-8?B?QUNCQmNXaXhSL2dUa1RrZ0R4cGVITjhrYzJFUmVFRmZCNi81YkQ5SG9ienNO?=
 =?utf-8?B?dUVTaTMwNG1udjBib2xFNTBZUGtGQTZCc2lVSEpMbFcvYm9Cd1BzQXAzRzdW?=
 =?utf-8?B?dFVvYUx2ZnZzNUMxSmd5WDlGWVJHU3JwY09ZWjQzRFF5ZU94YzM2d3I2Vk9r?=
 =?utf-8?B?dkV1eWVhVE9xbWlVSUxpa1plOFpVeVlwTGpnclU0RzRxMk8vUzMwZFhCTSta?=
 =?utf-8?B?YU5aZTF6WnZyM05BM293NUJaMk1SbklCZTVUYVUxOWRwK2lxYzdXWlZlWlRG?=
 =?utf-8?B?ek5BejQ3aFZXZUswNGExSllYN2ZFUFF3aW1kTzFUWU9GelZIWTJsdEFUVitH?=
 =?utf-8?B?SDduemdsYjZXYjhyTUFxYjk0am1JYmJibDBmOW1GRVdxa0FLMkYzTGZwcU12?=
 =?utf-8?B?TTBSZnBXSldBN052dUNkYjdBN2ZXWTdrb1NwazIvVU9FRXFXd3ExbE1JSkxQ?=
 =?utf-8?B?dFNGZ3BuNWhQSjFQSHBCaGZ2VjA5MURibnZ0QTQ2WUliOEp3RkppUTV3ZkI0?=
 =?utf-8?B?MVZZYVh0L2taZk5Ha0hRUCtlUEtMbGFlRlJXbWRXNG9GeEFsZ0xhczRGbXQ5?=
 =?utf-8?B?cXhQbU5RUHJlclcxa01hcHo3VU5LaGdiZEFMZHp1QjZsOGdOSmdaSEJOb2ZP?=
 =?utf-8?B?c3gwNWVwczVsTWZWTHB6UE9ZRU9vSnFCcVVxZEFPeGQyWUFPd3lEaGcvaGEx?=
 =?utf-8?B?OTVPUHdqUlFpSkxObmN5eXlyUXNEcHJVOVpQTWFEK2VuMUxBdUFZNTFOV3Vx?=
 =?utf-8?B?RXFsc0Fndk1kU1dseXlWU01aQTlQUTBKN0F3UE5rSDZ1RGJmcHRlcW01MWhR?=
 =?utf-8?B?SnhQV1hyNU1RT0ZBeXFOc1VoMzlrbHhqb010c24rcm9YL1o4cyt6NWI0c2do?=
 =?utf-8?B?OGFNS2NWaXBHdSs3Mys4Q0JVUnBSTU44dEVvek4zdmZNUWt1UVRoeHFyNGhz?=
 =?utf-8?B?bGNNaWFISG1Za3FCMmgvNzJSTU01aVdhM2FsakxwbktCdHc2OURUUFd2TGhq?=
 =?utf-8?B?MHQvU0NQSkxtVXczVXpZSmZkQmJpU1VhZnk1K0RmdnRtRDlpaERON2o3UWRE?=
 =?utf-8?B?RU42cEdiNXBGL1JEYU9SUkNTRUZvT1BMR0xUMnZQZXRqMVhtdkRNRjZNYlh0?=
 =?utf-8?B?VXN1OVRkN1pkS2h3R0JFbC9mQWltem04SDBYQUR3TmRWdjIrODJNcWJmOS9Z?=
 =?utf-8?B?WWNZTXlQWXpTUms1UWRmcWRIRllFRk8wa2ZUQnZYNloxcGJnaVVOTXk3VHJR?=
 =?utf-8?B?NTczUHJyMDk2WnNvay94Y1VZc2tWSG95OG95M2pDWGc3SUNrK2o0RjVnalEz?=
 =?utf-8?B?Z2Z2d3Y1cWMvRVNHeVp4TEN3UGh6aU5Gd3g3ZG8rVVJURHJ3RTdqbWdEdFI2?=
 =?utf-8?B?aFhpdnYrWGVSMWkvTlR2MlRyc3VJaFdabWpwZDB2T0lWaS8ybWpGQmZmVEdl?=
 =?utf-8?B?VzliQ0VvNmlZYWRlQ3RLd3ZJMS9Ub2ZvWmpGOFRxSVVIbXJKV0E4NWdDcTFj?=
 =?utf-8?B?aHFIeXNROGpqQVNJTC83M2lXRnZlRVlBbk5rcHhDaWpFV0dMVE1hM3hwQml3?=
 =?utf-8?B?dHZ1elpiOE1TZWNLNndnZ3dnOEI1Z2VGdVlLUHUvZmdsa2xBVkgrOGloVktw?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <427389EB1FB4E64285C0FF43882BC26B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QPYUlL8fLWbe3Cuqe3ZsCTvKF1/9IX45BZXok0cJdyDB0mYQFRQFNBnla9gaz2W0piq1fUawPzTS8DWE4IAVAHDysTxNQ2Lby+zjoW/WaFA2Ex6B07pDEPGOWCpN7TedebtDvMBDO9p3wXlaSsJ0mdGailtKJmIy8lb30nNp6hxAX5+xR/BAD5+9vnAD/Fv7wy3E92D59AXKeuhzxbOwfW1dvnoX5R1G2xDJfQLepg0bovViOvym9M7+0Vg6lzesNxec1VktRHOAFgtvlpnRHFYylsqDmT/rmNf8Z1QOz5tES6S8g5L2s9TAVNPkcNlWNHw4qLAPUAx7Co5oxsSzbjHn4QaHhqv5gNvpCERIJxvgJm5tHJDHuoaPcvhFtdmNHPK4OCzr9f6TD2X2AlgaEJyMaml4qvVUh/Qw5C0z6vCKxPxsCRtOVpnFwErJKekWTwrvyygc4QEpiKs+pcH/HzyB8DwedgLOHeyN+u/fIGAglAN9oQnn1XM0NkW/ExdEFp27llprj1bmXerD4BrzmijtAxZUzAhcjZxcUZeNxTV3Jltf0JoG7MWBzSMruwvve5PRakO17N5lIpvY+KLhVkVL9wvRYgCwe8smrgoSp5k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498e0f82-214a-4389-ff40-08dc0e0c003b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 16:33:08.5570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQ/VQIV4kQLfbVCxBfoY/3LJoxpaNKpxE1e+yRVbo8+snUSkRFlNhfz/Vi810wK9/VHILRp2nqEkGuMEvQ3I6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401050137
X-Proofpoint-ORIG-GUID: 18eTMDjd3wEMDMJrjjZWnRO5SLc-yR8b
X-Proofpoint-GUID: 18eTMDjd3wEMDMJrjjZWnRO5SLc-yR8b

DQoNCj4gT24gSmFuIDUsIDIwMjQsIGF0IDExOjI34oCvQU0sIExpYW0gSG93bGV0dCA8bGlhbS5o
b3dsZXR0QG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gKiBDaHVjayBMZXZlciBJSUkgPGNodWNr
LmxldmVyQG9yYWNsZS5jb20+IFsyNDAxMDQgMTQ6MzNdOg0KPj4gDQo+PiANCj4+PiBPbiBTZXAg
MTIsIDIwMjMsIGF0IDEyOjAx4oCvUE0sIE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQu
b3JnPiB3cm90ZToNCj4+PiANCj4+PiBPbiBUdWUsIFNlcCAxMiwgMjAyMyBhdCAxMToxNDo0MlBN
ICswODAwLCBGZW5nIFRhbmcgd3JvdGU6DQo+Pj4+PiBXZWxsIHRoYXQncyB0aGUgcHJvYmxlbS4g
U2luY2UgSSBjYW4ndCBydW4gdGhlIHJlcHJvZHVjZXIsIHRoZXJlJ3MNCj4+Pj4+IG5vdGhpbmcg
SSBjYW4gZG8gdG8gdHJvdWJsZXNob290IHRoZSBwcm9ibGVtIG15c2VsZi4NCj4+Pj4gDQo+Pj4+
IFdlIGR1ZyBtb3JlIGludG8gdGhlIHBlcmYgYW5kIG90aGVyIHByb2ZpbGluZyBkYXRhIGZyb20g
MERheSBzZXJ2ZXINCj4+Pj4gcnVubmluZyB0aGlzIGNhc2UsIGFuZCBpdCBzZWVtcyB0aGF0IHRo
ZSBuZXcgc2ltcGxlX29mZnNldF9hZGQoKQ0KPj4+PiBjYWxsZWQgYnkgc2htZW1fbWtub2QoKSBi
cmluZ3MgZXh0cmEgY29zdCByZWxhdGVkIHdpdGggc2xhYiwNCj4+Pj4gc3BlY2lmaWNhbGx5IHRo
ZSAncmFkaXhfdHJlZV9ub2RlJywgd2hpY2ggY2F1c2UgdGhlIHJlZ3Jlc3Npb24uDQo+Pj4+IA0K
Pj4+PiBIZXJlIGlzIHNvbWUgc2xhYmluZm8gZGlmZiBmb3IgY29tbWl0IGEyZTQ1OTU1NWM1ZiBh
bmQgaXRzIHBhcmVudDoNCj4+Pj4gDQo+Pj4+IDIzYTMxZDg3NjQ1YzY1MjcgYTJlNDU5NTU1YzVm
OWRhM2U2MTliN2U0N2E2IA0KPj4+PiAtLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSANCj4+Pj4gDQo+Pj4+ICAgIDI2MzYzICAgICAgICAgICArNDAuMiUgICAgICAz
Njk1NiAgICAgICAgc2xhYmluZm8ucmFkaXhfdHJlZV9ub2RlLmFjdGl2ZV9vYmpzDQo+Pj4+ICAg
OTQxLjAwICAgICAgICAgICArNDAuNCUgICAgICAgMTMyMSAgICAgICAgc2xhYmluZm8ucmFkaXhf
dHJlZV9ub2RlLmFjdGl2ZV9zbGFicw0KPj4+PiAgICAyNjM2MyAgICAgICAgICAgKzQwLjMlICAg
ICAgMzcwMDEgICAgICAgIHNsYWJpbmZvLnJhZGl4X3RyZWVfbm9kZS5udW1fb2Jqcw0KPj4+PiAg
IDk0MS4wMCAgICAgICAgICAgKzQwLjQlICAgICAgIDEzMjEgICAgICAgIHNsYWJpbmZvLnJhZGl4
X3RyZWVfbm9kZS5udW1fc2xhYnMNCj4+PiANCj4+PiBJIGNhbid0IGZpbmQgdGhlIGJlbmNobWFy
ayBzb3VyY2UsIGJ1dCBteSBzdXNwaWNpb24gaXMgdGhhdCB0aGlzDQo+Pj4gY3JlYXRlcyBhbmQg
ZGVsZXRlcyBhIGxvdCBvZiBmaWxlcyBpbiBhIGRpcmVjdG9yeS4gIFRoZSAnc3RhYmxlDQo+Pj4g
ZGlyZWN0b3J5IG9mZnNldHMnIHNlcmllcyB1c2VzIHhhX2FsbG9jX2N5Y2xpYygpLCBzbyB3ZSds
bCBlbmQgdXANCj4+PiB3aXRoIGEgdmVyeSBzcGFyc2UgcmFkaXggdHJlZS4gIGllIGl0J2xsIGxv
b2sgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4+PiANCj4+PiAwIC0gIi4iDQo+Pj4gMSAtICIuLiIN
Cj4+PiA2IC0gImQiDQo+Pj4gMjcgLSAieSINCj4+PiA0MDAwIC0gImZ6eiINCj4+PiA2NTUzNyAt
ICJjenp6Ig0KPj4+IDY0MzI4OTc2NyAtICJienp6enp6Ig0KPj4+IA0KPj4+IChpIGRpZG4ndCB3
b3JrIG91dCB0aGUgbmFtZXMgcHJlY2lzZWx5IGhlcmUsIGJ1dCB0aGlzIGlzIGFwcHJveGltYXRl
bHkNCj4+PiB3aGF0IHlvdSdkIGdldCBpZiB5b3UgY3JlYXRlIGZpbGVzIGEteiwgYWEtenosIGFh
YS16enosIGV0YyBhbmQgZGVsZXRlDQo+Pj4gYWxtb3N0IGFsbCBvZiB0aGVtKQ0KPj4+IA0KPj4+
IFRoZSByYWRpeCB0cmVlIGRvZXMgbm90IGhhbmRsZSB0aGlzIHdlbGwuICBJdCdsbCBhbGxvY2F0
ZSBvbmUgbm9kZSBmb3I6DQo+Pj4gDQo+Pj4gZW50cmllcyAwLTYzIChjb3ZlcnMgdGhlIGZpcnN0
IDQgZW50cmllcykNCj4+PiBlbnRyaWVzIDAtNDA5NQ0KPj4+IGVudHJpZXMgMzk2OC00MDMxICh0
aGUgZmlyc3QgNSkNCj4+PiBlbnRyaWVzIDAtMjYyMTQzDQo+Pj4gZW50cmllcyA2NTUzNi02OTYz
MQ0KPj4+IGVudHJpZXMgNjU1MzYtNjU1OTkgKHRoZSBmaXJzdCA2KQ0KPj4+IGVudHJpZXMgMC0x
Njc3NzIxNQ0KPj4+IGVudHJpZXMgMC0xMDczNzQxODIzDQo+Pj4gZW50cmllcyA2Mzc1MzQyMDgt
NjU0MzExNDIzDQo+Pj4gZW50cmllcyA2NDMwMzkyMzItNjQzMzAxMzc1DQo+Pj4gZW50cmllcyA2
NDMyODkwODgtNjQzMjkzMTgzDQo+Pj4gZW50cmllcyA2NDMyODk3MjgtNjQzMjg5NzkxIChhbGwg
NykNCj4+PiANCj4+PiBUaGF0IGVuZHMgdXAgYmVpbmcgMTIgbm9kZXMgKHlvdSBnZXQgNyBub2Rl
cyBwZXIgcGFnZSkgdG8gc3RvcmUgNw0KPj4+IHBvaW50ZXJzLiAgQWRtaXR0ZWRseSB0byBnZXQg
aGVyZSwgeW91IGhhdmUgdG8gZG8gNjQzMjg5NzY1IGNyZWF0aW9ucw0KPj4+IGFuZCBuZWFybHkg
YXMgbWFueSBkZWxldGlvbnMsIHNvIGFyZSB3ZSBnb2luZyB0byBzZWUgaXQgaW4gYQ0KPj4+IG5v
bi1iZW5jaG1hcmsgc2l0dWF0aW9uPw0KPj4+IA0KPj4+IFRoZSBtYXBsZSB0cmVlIGlzIG1vcmUg
cmVzaWxpZW50IGFnYWluc3QgdGhpcyBraW5kIG9mIHNoZW5hbmlnYW4sIGJ1dA0KPj4+IHdlJ3Jl
IG5vdCB0aGVyZSBpbiB0ZXJtcyBvZiBzdXBwb3J0aW5nIHRoZSBraW5kIG9mIGFsbG9jYXRpb24g
eW91DQo+Pj4gd2FudC4gIEZvciB0aGlzIGtpbmQgb2YgYWxsb2NhdGlvbiBwYXR0ZXJuLCB5b3Un
ZCBnZXQgYWxsIDcgcG9pbnRlcnMNCj4+PiBpbiBhIHNpbmdsZSAyNTYtYnl0ZSBub2RlLg0KPj4g
DQo+PiBIZWxsbyBNYXR0aGV3LCBpdCdzIGJlZW4gYSBjb3VwbGUgb2Yga2VybmVsIHJlbGVhc2Vz
LCBzbw0KPj4gZm9sbG93aW5nIHVwLg0KPj4gDQo+PiBJcyBNYXBsZSB0cmVlIHJlYWR5IGZvciBs
aWJmcyB0byB1c2UgaXQgZm9yIG1hbmFnaW5nIGRpcmVjdG9yeQ0KPj4gb2Zmc2V0cz8NCj4gDQo+
IFRoZSBmZWF0dXJlIHlvdSBhcmUgbG9va2luZyBmb3IgaXMgZGVuc2Ugbm9kZXMuICBJdCB3aWxs
IGFsbG93IGZvcg0KPiBhIGNvbXBhY3QgdHJlZSB3aGVuIHlvdSBoYXZlIGEgbnVtYmVyIG9mIHNp
bmdsZSBpbmRleGVzIG1hcHBpbmcgdG8NCj4gZW50cmllcyAoaWRlYWwgZm9yIG1hbnkgcmFuZ2Vz
IG9mIDEpLg0KPiANCj4gSSdtIGFjdGl2ZWx5IHdvcmtpbmcgb24gZGVuc2Ugbm9kZXMsIHdoaWNo
IHdpbGwgeWllbGQgMzEgZW50cmllcyBwZXINCj4gbm9kZSB3aGVuIHRoZXkgYXJlIHNpbmdsZSBp
bmRleCBtYXBwaW5ncy4gIEknbSBob3BpbmcgdG8gaGF2ZSBpdA0KPiBjb21wbGV0ZWQgaW4gdGhl
IG5leHQgZmV3IHdlZWtzIGFuZCBzdGFydCBiZWF0aW5nIGl0IHVwIHdpdGggdGVzdHMNCj4gYmVm
b3JlIHB1c2hpbmcgaXQgb3V0Lg0KPiANCj4+IA0KPj4gU2hvdWxkIHdlIGp1c3QgZ28gZm9yIGJy
b2tlIGFuZCBjb252ZXJ0IGxpYmZzIGZyb20geGFycmF5IHRvDQo+PiBNYXBsZSB0cmVlIG5vdz8N
Cj4gDQo+IFdlIGFyZSB0cnlpbmcgdG8ga2VlcCB0aGUgQVBJIGNsb3NlIGZvciBib3RoIHRoZSB4
YXJyYXkgYW5kIHRoZSBtYXBsZQ0KPiB0cmVlLCBzbyBpZiB5b3UgZG8gdGhlIGNvbnZlcnNpb24g
dG8gb25lIHRoZW4gc3dpdGNoaW5nIHNob3VsZG4ndCBiZQ0KPiBtdWNoIHdvcmsuICBJJ2QgdHJ5
IHRoZSBtYXBsZSB0cmVlIHRvIHNlZSBpZiB0aGUgcGVyZm9ybWFuY2UgaXMNCj4gYWNjZXB0YWJs
ZSB0b2RheSAoSSBtYXkgYmUgYmlhc2VkKSwgYnV0IEkgZG9uJ3Qga25vdyBob3cgYmlnIG9mIGFu
DQo+IGVmZm9ydCB0aGlzIGNvbnZlcnNpb24gd291bGQgZW50YWlsLg0KPiANCj4gVGhlIG1hcGxl
IHRyZWUgd2lsbCBjb21wcmVzcyB0aGUgTlVMTCBpbmRleGVzIHRvIGEgc2luZ2xlIGVudHJ5IG9m
IE5VTEwuDQo+IE15IG1haW4gY29uY2VybiBpcyB0aGUgZGVuc2l0eSBvZiBpbmZvcm1hdGlvbiBh
bmQgdGhlIG51bWJlciBvZg0KPiBhbGxvY2F0aW9ucyB0aGUgdHJlZSB3aWxsIGRvIHRvIGtlZXAg
dXAgd2l0aCB0aGUgd29ya2xvYWQgLSBib3RoIHdpbGwNCj4gaW1wcm92ZSB3aXRoIHRoZSBkZW5z
ZSBub2RlcyBmZWF0dXJlLg0KPiANCj4gSWYgeW91IGNvbnZlcnQgdG8gbWFwbGUgdHJlZSwgeW91
IHdpbGwgZ2V0IHRoZSB1cGRhdGUgZm9yIGZyZWUgbGF0ZXIgYXMNCj4gdGhlIG5vZGUgdHlwZSB0
aGUgdHJlZSBjaG9vc2VzIHdpbGwgYmUgdHJhbnNwYXJlbnQgdG8gdXNlcnMuDQo+IA0KPiBJZiB5
b3UgbmVlZCB0YWdnaW5nIHRoZW4geW91IHNob3VsZCB1c2UgdGhlIHhhcnJheSBhcyBJIGhhdmVu
J3Qgc3RhcnRlZA0KPiB0aGF0IGZlYXR1cmUgeWV0IC0gYnV0IEkgZG9uJ3QgdGhpbmsgeW91IG5l
ZWQgdGhhdD8NCg0KSSBkb24ndCByZWNhbGwgdXNpbmcgeGFycmF5IHRhZ3MgZm9yIGRpcmVjdG9y
eSBvZmZzZXQgbWFwcGluZy4NCg0KDQo+IEkgYWxzbyBub3RpY2VkIHRoYXQgTWF0dGhldyBtZW50
aW9uZWQgeGFfYWxsb2NfY3ljbGljKCkgYXMgdGhlIHBvdGVudGlhbA0KPiBjYWxsIGludG8gdGhl
IHhhcnJheS4gIFRoZSBtYXBsZSB0cmVlIGNvdW50ZXJwYXJ0IGlzbid0IHVzZWQgbXVjaCB0b2Rh
eQ0KPiBhbmQgbWF5IG5lZWQgdG8gYmUgb3B0aW1pc2VkLiAgSWYgeW91IGNhbiB2ZXJpZnkgd2hh
dCB0aGlzIHRlc3QgZG9lcywgd2UNCj4gY291bGQgcHJvZHVjZSBhIHRlc3QgY2FzZSBmb3IgdGhl
IG1hcGxlIHRyZWUgdGVzdCBzdWl0ZSBhbmQgb3B0aW1pc2UgaWYNCj4gbmVjZXNzYXJ5Lg0KPiAN
Cj4gTGV0IHVzIGtub3cgaWYgeW91IGhhdmUgYW55IG90aGVyIHF1ZXN0aW9ucyBvciBuZWVkIHNv
bWUgcG9pbnRlcnMgb24gaG93DQo+IHRvIGdldCBzdGFydGVkIHdpdGggYSBjb252ZXJzaW9uLg0K
DQpTb3VuZHMgbGlrZSBjb252ZXJzaW9uIGlzIHdvcnRoIHN0YXJ0aW5nIG9uLCBhdCBsZWFzdC4g
SSdsbCB0cnkNCnRvIGNsZWFyIHNvbWUgdGltZSB0byB3b3JrIG9uIGl0Lg0KDQotLQ0KQ2h1Y2sg
TGV2ZXINCg0KDQo=

