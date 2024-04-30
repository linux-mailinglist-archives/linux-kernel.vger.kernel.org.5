Return-Path: <linux-kernel+bounces-164542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E008B7F20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F2B1C2254D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF8F190660;
	Tue, 30 Apr 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hgXBuKmY"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE6180A92
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498941; cv=fail; b=IYnnTENKcZp/BMYKRf+X2bCPgAu9wGGENXEUzHTIB84OD5EDkmrYvmz+G10pGcq/fesmpjEWb+FTjHhjU1Ovz8uE3/Wa9O2e38+vibMmjxe6YOz6Tv90jUJ81Ply/MIiejrJThYbzZwGxj/Tr5KXkvdlG2Qs7mbLGqrl7AsjzUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498941; c=relaxed/simple;
	bh=Cxj+xzuSOx5pEWVIwumHdXmpiwbn+3/H2SNYns/v80Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OU648bRDeQxhIHjQWUh06aigshk9S10tfPHFRGmdrjFvmjFfzKF99IfB5kekayQkVwZ3Uqag6HrqquAPAhNE49b6lz477z6IFufnV899hoGZVLNee1A7k+1wea36RPKSQq/SqVEDDXTmemJ1dObjjva1BD2pxpJSDZk1BRKkomY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hgXBuKmY; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7tP7fR9wJqHDmuYP2nMthN/ROy8/EG6UeplcA/9hw7LrHw5UV3RNH/uMQjvFhY1puFIPVo7KsKOfx/JOnZW8QH1QY8OBLG/OJkhvU/M1L8Kq8CqOkYHgHXA6aoA8aG6Jcutqrd4/F7Llne+WkT4X85ZuOcFQEFSBEXHPwnBUklCiiXrZMMNovTlAT7QDqX78kWgJlZZBglqMgk8H1sVeEVAZoK6k8VlUmpJx+KLw4CYxpBTtdsx7ItJkB3vK2ZOWdS8girwO9R8Y7vAfIAiE3RBiRuW4eIYuRj73MQ4CfsAy6zJwkXRHDA1sBEoxd2IVfAkB3JUow+MimZoRjdh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cxj+xzuSOx5pEWVIwumHdXmpiwbn+3/H2SNYns/v80Y=;
 b=drKssTjs2oVn64E5xywgVXnZ2gEvRaDE/Ze2AjU3Bgjg5DVn/5aXxBLDZ/1zn6e5BRrDYpuVS2JmEUc/srZyQFIr0kw+S8Vx+Etrl1FplS848Xs4QLzJZQ90a/aCySTfAC1NLdd3cTyyxqGdqbVT/neDE5G5K4T/cmTM/Qye5GJZVxihiDet9sh9nMTNLs/1mX+xq5ucQvROJoEcreBmQpo2yms4b9gFEjI/yeSaG6IZVQ9e+OvvlFLWxa1cnncWv4nrRiZk5a4l2cTMimtmwz9XFUc5t8LN732P33JtGvaSR73icYSv4O0j5ERwvlWBfg5ckoOodbowJISn9cESRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxj+xzuSOx5pEWVIwumHdXmpiwbn+3/H2SNYns/v80Y=;
 b=hgXBuKmYDj2XeR1wqRXiNZhUnpG9uMR1o3OFI52qCzLSR7XkNDDmZB/bAhkOMvi3MB+meLC8+s5d3uSLVJuOS2zQtdQPYb1d4D1Qsc9mEFXUrsaoEvQ5iZvNZClZZB786OzOY9xRGJQLdGnlXkQSovMePxkU1w3eyw5J+VRflQ3jWB/Kqi4CEoUJ8j8JUIDln+BnNWdBxwRhHza4Kgdhaj3yvVg6ZmNzAkvQ7OT6Fj+cloi9ayY6nHqe20r8aqkXQFjerDAbuwCOT1ouhB311Th7+rq/1/DUMGvCzotiY3c7I/taCAVEx+pg0aCsNHLOiPOUvmC1SuTd4gT94OX4Pg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 17:42:16 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:42:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: brookxu.cn <brookxu.cn@gmail.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de"
	<hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-fabrics: use reserved tag for reg read/write command
Thread-Topic: [PATCH] nvme-fabrics: use reserved tag for reg read/write
 command
Thread-Index: AQHamqS0v0NsidyZk0GUPwZHGIlgabGBFjCA
Date: Tue, 30 Apr 2024 17:42:16 +0000
Message-ID: <06b57f1e-d412-454b-a708-521427384531@nvidia.com>
References: <20240430021753.385089-1-brookxu.cn@gmail.com>
In-Reply-To: <20240430021753.385089-1-brookxu.cn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB8425:EE_
x-ms-office365-filtering-correlation-id: 8e122712-3630-4e23-66b0-08dc693ce05f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2UwMzEyNHZHdXJ3cmdCNGhkeHFuVnlQV3lDQW94YnQzYTdYVjlXWXFzZkV6?=
 =?utf-8?B?SURmRFNPVkNWdDBzak9OT0cwUnQvMktDVTZDVGVXa01CNWtnazZpYUtHZUM3?=
 =?utf-8?B?emNGd09Cc0M0M2lqS09Wd25xUVRScS9QL1BNanRwb2hGVnlsNkhzbjVRWC9p?=
 =?utf-8?B?b1ovUHlpaGo4L295cDJYWmIwVlp5azRDUk5xSmVZb2cyRzhzaFlEdmkvc2VR?=
 =?utf-8?B?QWVxSkRIVG93cWs5MXhlRmxBVFpVYzVuMEhDeWZJQUxzUUhVZnBIRzlmRGVJ?=
 =?utf-8?B?bkRoQWtNTmcwNXRscWhxYmQzZDVEaWRET3lNMldsNUhlY01TSkNCT2MzWWpn?=
 =?utf-8?B?T1hic2tXSmNaNVkzZ3FtTXhrbXoxYlgwZDRlSEVaOXVETW9BanJXN2YxSmdk?=
 =?utf-8?B?TlR6dGoyRjZBMTVuMXZHVVg5RVVYb21yRHlkSFQ4N3B0Vms3QUlnTHd3VWV4?=
 =?utf-8?B?Z0FXMlpvNFZTT1pWVUNIZE1ISXZOTDdPTTAxeDlaT3NPRzc2clhrZnB0djRG?=
 =?utf-8?B?MnlaQmdBVjNBa3hIU0JzZXVGc3FYaXdJYzBOVDRXN1lkWGhFdEZ3blJzVXRs?=
 =?utf-8?B?Wk9jNWNtcXlOT3RrZE82VWVzV2xsbkZSeERrdjJWc3p2Z1RJa0Fva3lVTmJQ?=
 =?utf-8?B?NzNqRVJGcWpvZStqSlplUk5MaTJEd0txbDV5WVBNbisrUDFGWHV2NG9YYnht?=
 =?utf-8?B?bnZzOUNoQ2dkTVBXaWwzUkJDZjN0ZFpiNWkrdDExRmE4dVdCdU80WUh2QUlT?=
 =?utf-8?B?MWNyaEZPRHZHZVBIbTdsdGZ3bGhHblRWS1JMRzBvOWpwbENqZS96ZHFNaG9u?=
 =?utf-8?B?Sk5jN3BrczFLNWo2c1Q3QnIxczdCR0VZVGFCc2x1MGRWRWo4dDVPM000Q2dv?=
 =?utf-8?B?Umd5N3dHRUhUWmE0TjdmdEhkVitOVWhvU3g1c0JjU01IYVRTaFYxRXVYaGQ0?=
 =?utf-8?B?VUJVZFprSHlHMm9NMGpPUk81OElvN0MzUC9MM0d0ZUxBTTZjQjNFd1d6UXRK?=
 =?utf-8?B?Q2xsYURoTVdFMnFTMUZ1Q0RHOEg2UXd1dlRlVytVR0RqR2FHT20wVnFFNUp5?=
 =?utf-8?B?UnF0T241RXlNbmdjbHEwSm44VVlDeDNkQTByTTY5QWMxVEMyK2JwUDN2VlpL?=
 =?utf-8?B?ZXpmM2Rrc2gvcGwvakFpM2JqaHpKSWphVDlsZXNDT2piUU9EdjRQZkJMQ1FC?=
 =?utf-8?B?cGtFMG54aEhnOWEyYU5oeUxpTjNIYjFUdEp4NjJHdTBBcU1NQ2NpSHZiVjQ0?=
 =?utf-8?B?SklCaFRFcmlDZ1NGeExOdnVheXEvZE5hKzZVSTBEVUdoUkhVZmtWWGh5Wmpt?=
 =?utf-8?B?NjdDTjdYSHJGb0d5ZkdNRWZuNllCeXNYaFFTYXVhQUZyd3JIcEZsdnM2N2ht?=
 =?utf-8?B?ckZiQmdjZHkxemt6d0ljVGxEVlJnTW95UG5BTE9XcStsUkNObUVDUnZwdW9P?=
 =?utf-8?B?OGxVRjExT2pBMVcvUlZWcnM2V3h6bHp2NWhVYlhaOE9UUmhCVGZyQmQvUFFN?=
 =?utf-8?B?YjNSUHB2Wnk4RmhZUWpKZVo5a1NuMFoxODZRU0d5YkNia29vTGtUREl2dysr?=
 =?utf-8?B?c1JEeHFjRm9FL1M5RmViMFNYaEVMQ0kxbWhEbVVlSytZd1FGR3dCTHhaYWg4?=
 =?utf-8?B?U0NKQXg3K1F4QzgwaitmOXdoV0R1bG9Na1JPSzR2YldBbEpJdkk4c3RFSGhG?=
 =?utf-8?B?cnVSSVZDTktDVWU0bDV1RlVJVzRqNE1LSXN2VjRBRTVjL0JjOG9udldwN1B2?=
 =?utf-8?B?UmRheXJSblRkWmNTOVY5QWRBZitnSmVqT01jRG95MWNkazZYNFFXUnlKMlZN?=
 =?utf-8?B?alMyNE42MGFwa05kUCs0QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDN5dExjdEpMenNqNGRBUlVjYVRUQk9VWWUrK00yNjhUcThMZVdTeTJxZVA3?=
 =?utf-8?B?Smp2dmVxd05jL093aXl4ZXpqKzRzT1Q0M2JFUjRQT1dVWTZORXFHWG16T2pu?=
 =?utf-8?B?SkhpNC9yQUVvRCtKc0tYOWdzREZXRmQ3VzY5aUpvTkNNQllGVmNsT1hOUFpZ?=
 =?utf-8?B?eWFhQmFOWWJQQnpDZkhQN1ZTbm9CcHJVeWM2aldzdTdhcW1SZmtDWHd1LzRI?=
 =?utf-8?B?NGs2bGRJcG5Kdmg3OVNqOTViSTR0K1pZWWxiODd4M2lRdjNSUEh6UHBlWVc5?=
 =?utf-8?B?UFo5ZzlRck1RalJ1T2x6SCt5RmNjSU9iTFlBRHA3VzJRV0xrdXMzcDZXQmNI?=
 =?utf-8?B?ZVhxT2c4SEtIUTR1MUFTM20zZ1VqYVovN245K1pJMm9XN0tWSjhPTUliOE1M?=
 =?utf-8?B?NVN6Vm1EZWNHQU9kdElwWUZQSmVXZk5BcFM5S0VWSlMwclJFVnJ2WU9DTmFN?=
 =?utf-8?B?WHFQZUhlZ2VhM1JQeUJ0MHBQa2pyWGdyYnNVdDJjSnMwMWI5YjgvTVpHcTZ5?=
 =?utf-8?B?Q2IvMUtSdGNjRWlkaDBTSFY2ZzkzcGhQZzF4VEtrOXhzcFZlcGc3bGp1Y1hi?=
 =?utf-8?B?ZTI1VGNoYjJzcC8vK1pHRE9BM3lJUFN6czZRYTNoWUtrU3NUZEZKazBXaGJN?=
 =?utf-8?B?a1RvTGVpVlgrdXpRbldZc3dnc3JBdFltQUk0ZWVGZDlndmFBdnZuZEs3OXFS?=
 =?utf-8?B?bGlqYWtuLytCRGVRRVowVVA1ZkROUm1ZWXNvQnFYSXRiNXYxNWlCMEl0dmpp?=
 =?utf-8?B?L2YwV3drTGsrRUpUZmE5RG1jWmZ2emtmVDdnQjhHanREUjlGZG5YSDR1dDRn?=
 =?utf-8?B?M0oyVU1WUkIxQWhqMy9rcmVNbkZDOElEdmF3WEdURW9wNnJBNDRSZ1ZsbUR0?=
 =?utf-8?B?NmZ2WEM4MXd2VWc5TXptbnYyT2M5S2RyUWlhc3ZQbzZkWndkQnVMd0l5MGFo?=
 =?utf-8?B?dmdwWnVEYnRPWStXdDljMXpEQjd1UGYrTTlzU2s1LzJJZU8xVEZjbjBnTmdy?=
 =?utf-8?B?MjdaZ3I5YlVwbitubGhvcis0cmZBWkhaNmZySTNLL0NqQXVvMWFNeEtBbklz?=
 =?utf-8?B?OVFwVXRxNU82amwxYzRYSmxYY3lIUVlBYU1xaC9zWUp5MVEyUVpxQVl0Ym04?=
 =?utf-8?B?c1UzSzVlQkhWNEhvb3JBUk1IaVppZUQrRVM3cFpKN3RhRnRiVENibUpGcExC?=
 =?utf-8?B?b3VhUW5FSks5dlJkdmFDU0lDd2RIU3VFMEZBV1VyWnRvZFpHbm1OTmFKeERv?=
 =?utf-8?B?S0NUeEhQRklJQ2ZmaGg4TjZOQmpWWHV6bXU0dlM4cjd6MjQvdklYQXFndmR6?=
 =?utf-8?B?Z00rdGNwOGJmQ2ZmVzM0cG5sYVhQbVFQcEZyR2tJeG9mVmliQ2l3WTU4VE1Q?=
 =?utf-8?B?dVhZUEZKRXl5WnFld1ZiRkxZVmtORS9rM0t4NGlxeEJYa09XeXh6ZSthMFdi?=
 =?utf-8?B?SmRPa1BOeldrUWU0Z1U0N0I2aFdRVS95bGl1RHBGY3R1UnVNYjloV1pEV3Ry?=
 =?utf-8?B?WUVTamw4d2hmcnlhQk9pZzdvZHFhQU9FUjRvck9ReHN6dnorTHA2dXY1bWVU?=
 =?utf-8?B?cFZRNUl3RkpzVUZoekYxNFIwRlZXNTViT3RBekdVUVZ3Qmh6ZzE1TEwyZmd2?=
 =?utf-8?B?NFcwT0J6MjB3anN5RWprOW5xa3ZDMkhOMXNSSEVKQTNUc0dET0xlRHlsa3g3?=
 =?utf-8?B?L3VPRFZnV1pLUldvNzhZejF1S3YyemxNZk5FZ0V6djJNVFlmdlZiS0oyUnpP?=
 =?utf-8?B?dnBGWjdxVlJ6OTI3ZkRMWFVXcjdmL1dqanFSMm5Uak1ldGdJUHdXUWx6MDhw?=
 =?utf-8?B?NWNUaDNBd2R4OFQ2dGpaNnJYTU5BZ0V5dmoyYUhQZ3NhaDhvZ1JZWnNFSWI4?=
 =?utf-8?B?ZEc4TWpuc3VkRkQxeGNBaTBLOWtOMldua0oyTVJ0bWZPSy9oeFRiVUk0TEw5?=
 =?utf-8?B?cTFtUkxiemlySlN3RjFEdFJTT05YdWxsK3lMaGJuRFg2VnNUMkxQNUVDaldx?=
 =?utf-8?B?aXhJSHFoUTJMTFFYbVNQZ0o5eXpMVkpEdCs0RzNXYUR3dVNaMXdSVTBMMysx?=
 =?utf-8?B?VGNkeEplNnE2dnNWV3E3bDRrQnNhT1I0NERpSEp6cnpOODNnUUFOMG9vVXEz?=
 =?utf-8?Q?YAQCjx+NY8Zz+fM+8JjKbMivX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC523E7C01560A41B61BF28D363D548C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e122712-3630-4e23-66b0-08dc693ce05f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 17:42:16.2591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fieyx7deFhpOpk/3Fm4QiFs71TacRQDZsOtyyNlNvTJO4ndAI1pYe7b5j6FXpGIEwxI+GGllguPRb4/pjI6/kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425

T24gNC8yOS8yNCAxOToxNywgYnJvb2t4dS5jbiB3cm90ZToNCj4gRnJvbTogQ2h1bmd1YW5nIFh1
IDxjaHVuZ3VhbmcueHVAc2hvcGVlLmNvbT4NCj4NCj4gSW4gc29tZSBzY2VuYXJpb3MsIGlmIHRv
byBtYW55IGNvbW1hbmRzIGFyZSBpc3N1ZWQgYnkgbnZtZSBjb21tYW5kIGluDQo+IHRoZSBzYW1l
IHRpbWUgYnkgdXNlciB0YXNrcywgdGhpcyBtYXkgZXhoYXVzdCBhbGwgdGFncyBvZiBhZG1pbl9x
LiBJZg0KPiBhIHJlc2V0IChudm1lIHJlc2V0IG9yIElPIHRpbWVvdXQpIG9jY3VycyBiZWZvcmUg
dGhlc2UgY29tbWFuZHMgZmluaXNoLA0KPiByZWNvbm5lY3Qgcm91dGluZSBtYXkgZmFpbCB0byB1
cGRhdGUgbnZtZSByZWdzIGR1ZSB0byBpbnN1ZmZpY2llbnQgdGFncywNCj4gd2hpY2ggd2lsbCBj
YXVzZSBrZXJuZWwgaGFuZyBmb3JldmVyLiBJbiBvcmRlciB0byB3b3JrYXJvdW5kIHRoaXMgaXNz
dWUsDQo+IG1heWJlIHdlIGNhbiBsZXQgcmVnX3JlYWQzMigpL3JlZ19yZWFkNjQoKS9yZWdfd3Jp
dGUzMigpIHVzZSByZXNlcnZlZA0KPiB0YWdzLiBUaGlzIG1heWJlIHNhZmUgZm9yIG52bWY6DQo+
DQo+IDEuIEZvciB0aGUgZGlzYWJsZSBjdHJsIHBhdGgsICB3ZSB3aWxsIG5vdCBpc3N1ZSBjb25u
ZWN0IGNvbW1hbmQNCj4gMi4gRm9yIHRoZSBlbmFibGUgY3RybCAvIGZ3IGFjdGl2YXRlIHBhdGgs
IHNpbmNlIGNvbm5lY3QgYW5kIHJlZ194eCgpDQo+ICAgICBhcmUgY2FsbGVkIHNlcmlhbGx5Lg0K
Pg0KPiBTbyB0aGUgcmVzZXJ2ZWQgdGFncyBtYXkgc3RpbGwgYmUgZW5vdWdoIHdoaWxlIHJlZ194
eCgpIHVzZSByZXNlcnZlZCB0YWdzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZ3VhbmcgWHUg
PGNodW5ndWFuZy54dUBzaG9wZWUuY29tPg0KPiAtLS0NCj4NCg0KTG9va3MgZ29vZC4NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoN
Cg==

