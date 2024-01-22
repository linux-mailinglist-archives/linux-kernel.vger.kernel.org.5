Return-Path: <linux-kernel+bounces-34287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE97883779C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1382877CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F3D4BAA5;
	Mon, 22 Jan 2024 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="rPr0D+A8"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E54BA94;
	Mon, 22 Jan 2024 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965305; cv=fail; b=oA/Md3Ig8eopDXNGwdFpafMKdsn7iE6WlkzV0RX99aAuO3otRelXBRSIZsiVL9PI2wqWQveanVLOsuKw9yA0Mt3ED1hPziRNOJO8VndQUAik6XlShswEh/g0T67+RB9JOaNHUzLH5VnhZoZYbvZPIjpFAZsKnkGE7p1gKt5DsS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965305; c=relaxed/simple;
	bh=O1nJxvaJsR+DHxQGziwnGWfX+IPaN+kWzvRyUBOXtQA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SPqttqpng3kn7HjhsjUDgDSahQB4AgIbP4nieBSurmJY3nguBIE9Ii4Gr7vqAmGPHszD81i0hgRwLlyX8CLSVQb6DM3cpuP8c4DHK8JQhr6dGWujLVq1yrcA8Ik5Bu8qbwzUrljuwxWhLHicuJ7hDcVMq453PucJz9zHmV+mvAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=rPr0D+A8; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr52xz+7Oynk2Lxq8bLzwvTsGARueNhZ6khpsUy2MPqrb9p4l+EV2ongHB5dHKpIBwS4zPTvV+OxpwJRcEDaShN2jDCK44dW3KAdWG+5qq0PxLtehJXCZIYRnrGkAHKyi6SC+UEgUFXMDO+sVAoaFDLGnnRluubJudpnwaEu+1lBmhBdmjEH9LxBA3Zcg9WiqLrQlRX20AyuE4OmmbvMDzg/TavFPVxRAN6aQbmwqG5mm4rV/sVPBqxq9tw63nItDXKvKb9N9nzPqnvJNQ8ba6jwmU7Jt38sTK/yzOei+lTt7kLyL6g0QqTQEteMxkWAmCiX8GSK/DUo0W2ldvkXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1nJxvaJsR+DHxQGziwnGWfX+IPaN+kWzvRyUBOXtQA=;
 b=J5NSQg//U+j0m3TX1XWPltDPvriew4SK15ZefPMJqC/MJVWSGhg0ozunio+lMLgtReAzBK2qzKrBeeeQlNwSlmRJfluXDd43SpG1bw8Ph45WWSFse3kMvJ3/5BaWpvNvz54j2YbRkRLJS7KWBWE2aWKURUYTKb+By+qfz8T+RZ1wl1b9Sr/KQGQ/USJpyJTUuDF5kY9H0pBvQ0ZOKzajwt64Gja61H/OgNq4HN4ZtuqfNQqMMynAs1D78WgYNqMoMcSO8mAEJT8dHP2jraU7rAW8eCexjEfKW5ZxNxZ+gufJpKwqk2aZWC4jJuWg1kr6syNCyfUh5EFHiGTt206EzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1nJxvaJsR+DHxQGziwnGWfX+IPaN+kWzvRyUBOXtQA=;
 b=rPr0D+A83Ubmho05iCK/Hc1rdVsW/1LetDC0Z0yNtKDWfuPDrJFTBbDp9rEaIOwQE9BpU/vkBuM/hIanaLxP/79yZoJTFXAOJxlsDqOlHS/sHoPmAsxyjv088sCpnr9OW58RHqlWEzwnSudJJcUN1dkXUAvr+4ywCmx8WuYDVGZ3h1dINPtNpDporDmfTefflXi9kZjMVQoEPnkwKtFDwuEWHqJVbg+ZgVdOtyUZsH5JRql3hXEMcxrBCKE4jW3uK1cBcgANCoojbD/z0eowE1kgC2WCafjyV6EN6YAHt/RsdGMN8D+o3KnbZwJkEtW/2POSZZAY4rrI1jMlChRgbQ==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by PH0PR10MB4424.namprd10.prod.outlook.com (2603:10b6:510:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 23:15:00 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::4d76:4230:708c:9eea]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::4d76:4230:708c:9eea%7]) with mapi id 15.20.7202.033; Mon, 22 Jan 2024
 23:15:00 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "david@redhat.com" <david@redhat.com>, "mhocko@suse.com"
	<mhocko@suse.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "mgorman@techsingularity.net"
	<mgorman@techsingularity.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "quic_pkondeti@quicinc.com"
	<quic_pkondeti@quicinc.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"quic_charante@quicinc.com" <quic_charante@quicinc.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"quic_cgoldswo@quicinc.com" <quic_cgoldswo@quicinc.com>
Subject: Re: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page
 blocks before oom
Thread-Topic: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page
 blocks before oom
Thread-Index: AQHaSjMflGKjL/PHykO7afANQUWSRrDmIBoAgABNFaaAAA0gAIAAAuwA
Date: Mon, 22 Jan 2024 23:14:59 +0000
Message-ID: <01010dd280badd149291cf4d2a4a88847113cf6d.camel@infinera.com>
References: <1700823445-27531-1-git-send-email-quic_charante@quicinc.com>
	 <3fe3b3edd33cd784071dd9b459d20a79605ec918.camel@infinera.com>
	 <2024012205-undrilled-those-2435@gregkh>
	 <PH0PR10MB461565CEE892267025BC697BF4752@PH0PR10MB4615.namprd10.prod.outlook.com>
	 <2024012210-outshoot-dragonish-fe8e@gregkh>
In-Reply-To: <2024012210-outshoot-dragonish-fe8e@gregkh>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.1 
autocrypt: addr=joakim.tjernlund@infinera.com; prefer-encrypt=mutual;
 keydata=mQENBFp0f28BCADPn4XzN2HEzkY4BZKE6/T/S4M/Qjlf01K6gmECJZi5LQgOt0jOUAdvsXVd8yKYeqCq+eWvlfrLU9OXPGoCqwj95P2YjMsttqaPBEAnf4XyBs67Snz2wHyBDONoRxGoyq2Ondy+TPicWEm0mh404h9EzKxRNxwrRyKhsjWoVeaucuybAiGbJvqQj0CLmuMCl4PUBYDmXFzt3yx0g54z8E9/8ON+z0J7yZbA0aftZAjFLv6nn0Th/2dpD8d3vWtkJw4yBjLX2KFvlzJfQqkd6RI4Cn1OP9sguXDob123dMiMk/5XbjXz+0C21QFxejxt3HGisvKes+8swplyni7KdiDtABEBAAG0MEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50amVybmx1bmRAaW5maW5lcmEuY29tPokBVAQTAQgAPhYhBFtMG/jmfqy7x0aBp4VMQ6CbDpcaBQJadH9vAhsDBQkDwmcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIVMQ6CbDpcasFAH/j64dpHpjY55tVoUg5yK8hcmxS/buKQQP9H3e2DdHeYrK0qeQ97AXiWTh63UvzvEXchiKjua6kYhUUkDObaltmwkKgPv0qb9lP6yfFBzvllriS6LrdIMCOLgtnQW2x28m5mC1hYT08jlqEXluYDoj2dTll9HGMsqn0JkhRjBsuzTXq8VyJjjnNLpzsAlTOGEQoAi7SqtDHs9PSNyOAKH5jRjATdNbPAsTKuI1veJf7Zzyc98yG0ya43Hqal1scoa+9GJZXNQPRaMVkyxKGbEEncdtnQl9e/DUMH4SUQ5vbM/+U4WvkX5Cvc+KwI6JAm1PhrAaVHSkDNAU5LqUqEbbHY=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|PH0PR10MB4424:EE_
x-ms-office365-filtering-correlation-id: c3138913-c6a8-4b33-f00d-08dc1b9ff4c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 f/sNmaHw7MD3t7WFMCc8KpuK90yL6xuBbeG/6ww+T3AmdDCtET51Y+lvaRWZdAOeK2KFMJriApIYi0ncF0vZT/GqM2KF13no1nE9O2KWVTwKnrwAZJhxwBRxQM7fI9G+KutrtxCwZeS1JinkvU+MjoZUrL5aSULyUlWctNceCO3Coj55qUO1MLLBS6tzvUpXKSMedHv40hRGs57O6c9jjZk8YuBXAtxmSrb5jIm2GPI/OvM9Q/TgeUF10NKYgpJtT6+bA+4AlYf+i2P/GpaD9gx4CybcHOPE/w7SXne7Yc3mwnHkKgxWj1RarK5CrBRqrxW7WfibWgyln5+5Vt0NbioaMLK9WsczN5tnUTKdJlDNlHtOB+DaExf4sYbri3GLUiRzx+OrSCes64v4Qc2ExBPNA5KAhFpwSXXa2H4la1AHUQBJWktj72YiOGpQufKDXT8yFUTORW7ZsXqlTkrxguV++fS50HHDL04hFmY1tgKgPTQgeukVBE8HWP03BRc7Scw6HYwkkQdC+6Nbr7nZtn1lYeVKpmtxuqbDjrdpkmndOrsY9dsGXZOAeys9H1t10VOIiO8lZBxOTWYXwRn/bXf8gHaTlfuLt7a4mkagjYg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(36756003)(478600001)(38070700009)(45080400002)(2616005)(6506007)(71200400001)(83380400001)(38100700002)(6512007)(6916009)(122000001)(86362001)(54906003)(6486002)(76116006)(66476007)(966005)(66446008)(91956017)(66556008)(66946007)(5660300002)(316002)(64756008)(8676002)(2906002)(7416002)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlJHK1dpL3JtdWVjWXpMcEd3cVB2NldZeW9rRXEvMkIzNlAyTXpHRmZKWFNU?=
 =?utf-8?B?UE50eVZXbytqa1NJWXFuU3lnUUJDTit6NnJNdkphYjFDUCttKzZmNkpKOVNo?=
 =?utf-8?B?NGVHTVc4M2VLSVJBVE1RbDl1OXpqOFBQZERKcjAzY0tGQUJkR28wbGxWQ1pM?=
 =?utf-8?B?MFJRcXczcHA3TkNhK0YxT0J1ZFd2eFM5VWVqUnJsRUFMbUp3RkpIdnRGZW11?=
 =?utf-8?B?SUcrUkt0OHBrd3BQWjdwdm9uSlNJUGZIMDFrdUxlVHhZSVArUEdleHFqZUMr?=
 =?utf-8?B?ZytBMW82ZWVzN2srcEdIMHorajdNYmlSNDQ4aVh0ZDBGOUVPaUJNTGtqMnpO?=
 =?utf-8?B?YWozMlVNM0RhbStmNFhsZFZReXc0aHBQQ3IyS250ZmtZSzNOQkNmT3NLdFZs?=
 =?utf-8?B?a1FMOGRJcW5YVXZYamV5TGoyUk0wR3daY0ViYm9kYlRXTGtwUzhnQUhCY1l4?=
 =?utf-8?B?S09ZdDl1QmZFMGlLRThyVXlzQXVtYnZnN1RXOWZPcU0reTZnYzFUbmRDTTlY?=
 =?utf-8?B?alFoNWV6SnVFK0pDVFA5eHh5cHhMbWRaeVdxQjdTb0R5QXJyWWl3WE90ZG9s?=
 =?utf-8?B?Y3FuckNvSCtUeGpDQkNFckJxRW80NjZIN3MvT0JjNzVCakxOTTZTem9oblg0?=
 =?utf-8?B?MVFidHkrVTFDV2lCVjJDNkNGREdsOFNPTHhtWGtJTnQrRk1TUUp0aUNyWVlR?=
 =?utf-8?B?dENaWkMvR1Rkb2xkTFZJYlgxTmVzeC9KcUlRZzF6c0lXODBEd1dYWXBTUjJX?=
 =?utf-8?B?RG15OWJoNU1IZXcyTXJWS2JiUWJRMTNGeGpPbmQ1Q1FMdlJwMUlGRVJwcmd1?=
 =?utf-8?B?cEw3OXRoU2Qwck9nT0dwd0p5RUdWSUtzR0EycmxwdlVnaERVZEJVUmNqZS9Z?=
 =?utf-8?B?TzlFZmRRTUgwZ0tRRHQ5V214YWQ1L2R6MFdjckN4SUZQelJnWGhJdkdqdyti?=
 =?utf-8?B?bzM0b1Z0b203NksrV3dCNmFyaEhtODA0b1RFc1VnY3dkWVdFZTM0MzlWNWtq?=
 =?utf-8?B?RXVjcWx0aklQenpDd3FyTGlsY0Uvb3J0NmlZckRPcG1rRG9qVk9qYVNXeWpQ?=
 =?utf-8?B?S0dPZFNpNjArRUhyUGIrczY4Z0daUXFuWkp1ZzVDdllsaHR3RTU1NmREQkZD?=
 =?utf-8?B?WDdjeFlpUWJxMm1XejBQN2RkWHBiUVAxQjdpN2pWT0ZYWXlpYTYzNkJnNU9j?=
 =?utf-8?B?TDNpS0xjNlhFeVdTQmQ2K3BnN1ozOGkzSm1BUUNleUJjaTh2c05FY3F0MDFo?=
 =?utf-8?B?Sk5JOVdyemJtNWp3SjEvNTE4OFB6ZHdScTVvWkF1YUk1YTc2a3BOcWVGNExa?=
 =?utf-8?B?TEJ3Wlg3M2V2WmtYZVFXOUhXd1BGUE5sVHk5RHAwdWFWVUhVWVlyRVBRa3VF?=
 =?utf-8?B?OTk1OU5CV0RUMmoxR29YS3ZsRUF2N3NtT3hHei9aSUhvMU9JWE45TUxQSlVt?=
 =?utf-8?B?VVZTcGU4Z010amd1YUJPRlg1R0VqdStLaGpBa3RjWnVsT09OTjQ3eThJSzhI?=
 =?utf-8?B?T09rM0lkVE44bXpqbnhmeFIzeGViTTJnUDdFMTBONTF2dlhQcHphTC9BdXhG?=
 =?utf-8?B?SEhjdFJYLzBmQk9ESmtENTBmY1RnSWhSdkUzeDBHUitwbms0Y1cyaThrM1dN?=
 =?utf-8?B?bW40ZUtJTVdwdEZjL3c0a0xTOXlnb2NPZVloa3FScTF5Si83WnpMUlZTdEhF?=
 =?utf-8?B?VjgzZ3pURm53dG1pUk83R1JtdzR0eU1Wdmk2Mk91Z1c4Y3ZKc3cyNXg1aUY4?=
 =?utf-8?B?NkliOVNsRk9QQlNudU4raEZwMkc3VSthempmYlBFcnNZdkl5cy8zbXdKNG9F?=
 =?utf-8?B?TFVlN3VTYWl2V2JyaFpndG1SUVM2RTdQVjJINjNQNmoyeXNKMkVjUEtBRUZv?=
 =?utf-8?B?MExKL2tKZkszOENvR1RkNkVjYnNYazNyL1NyY2t3dHhjVTdaUkkxbXF6MGMv?=
 =?utf-8?B?S0hMbnFyWG1TWHp6MzZ0RXZROGRtNi81RDkyOEM4YTFJYmVUc3BoQnNGSU9R?=
 =?utf-8?B?OUtaZzdyc3gxUE5LUEswYk9CdzJGb0FMUUpDUnQrZ3pXRmNNY3NNWDlOejNV?=
 =?utf-8?B?TzQ4NzFPWUNmemordjA3OGVNWTlzS3gvQWpzb2dkbGQwWHpPaDB6N3YwcStZ?=
 =?utf-8?B?c0c1aC9aVFN3TXNUREJmblFjL3ZKYU5UL2hWb0RaSEhPYXBKTDBMVTkxOTB3?=
 =?utf-8?Q?MS98jHEM59wgdYiNfGqBC4HeHESSMp2+NWOrrjHxYNLW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <739E0788299D1749A7CF54FB6C192B84@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3138913-c6a8-4b33-f00d-08dc1b9ff4c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 23:14:59.9334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3nU/YvarndbZcRGKu8ZV5bEdcd8PNmP8PbtReCaAmGoSxKYz2pmf+9Zfw9pjFNbNufJNxgMfRpBUFzF6hNvlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4424

T24gTW9uLCAyMDI0LTAxLTIyIGF0IDE1OjA0IC0wODAwLCBHcmVnIEtIIHdyb3RlOg0KPiBBOiBo
dHRwOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL1RvcF9wb3N0DQo+IFE6IFdlcmUgZG8gSSBmaW5k
IGluZm8gYWJvdXQgdGhpcyB0aGluZyBjYWxsZWQgdG9wLXBvc3Rpbmc/DQo+IEE6IEJlY2F1c2Ug
aXQgbWVzc2VzIHVwIHRoZSBvcmRlciBpbiB3aGljaCBwZW9wbGUgbm9ybWFsbHkgcmVhZCB0ZXh0
Lg0KPiBROiBXaHkgaXMgdG9wLXBvc3Rpbmcgc3VjaCBhIGJhZCB0aGluZz8NCj4gQTogVG9wLXBv
c3RpbmcuDQo+IFE6IFdoYXQgaXMgdGhlIG1vc3QgYW5ub3lpbmcgdGhpbmcgaW4gZS1tYWlsPw0K
Pg0KPiBBOiBOby4NCj4gUTogU2hvdWxkIEkgaW5jbHVkZSBxdW90YXRpb25zIGFmdGVyIG15IHJl
cGx5Pw0KDQpoYWhhLCBzZXJ2ZXMgbWUgcmlnaHQgOikgKG5vdGUgdG8gc2VsZiwgZG8gbm90IHVz
ZSB3ZWJtYWlsIGZvciBMaW51eCBzdHVmZiAuLi4pDQo+DQo+IGh0dHA6Ly9kYXJpbmdmaXJlYmFs
bC5uZXQvMjAwNy8wNy9vbl90b3ANCj4NCj4gT24gTW9uLCBKYW4gMjIsIDIwMjQgYXQgMTA6NDk6
MzJQTSArMDAwMCwgSm9ha2ltIFRqZXJubHVuZCB3cm90ZToNCj4gPiBTZWVtcyBsaWtlIEkgcGFz
dGVkIHRoZSB3cm9uZyBjb21taXQoc29ycnkpLCBzaG91bGQgYmU6IGFjM2YzYjBhNTU1MTgwNTZi
YzgwZWQzMmE0MTkzMWM5OWUxZjdkODENCj4gPiBJIG9ubHkgc2VlIHRoYXQgb25lIGluIG1hc3Rl
ci4NCj4NCj4gQW5kIHdoYXQga2VybmVscyBoYXZlIHlvdSB0ZXN0ZWQgdGhpcyBvbj8gIEhvdyBm
YXIgYmFjayBzaG91bGQgaXQgZ28/DQoNCkkgYW0gdGVzdGluZyBpdCBub3cgaW4gbGF0ZXN0IDUu
MTUueCBidXQgdGhlIGp1cnkgaXMgc3RpbGwgb3V0LiBObw0KT09NIHNpbmNlIGEgZmV3IGRheXMg
YnV0IHRoZSBlcnJvciBkb2VzIG5vdCBoYXBwZW4gb2Z0ZW4uDQoNCj4NCj4gRm9yIG1tIHBhdGNo
ZXMgbGlrZSB0aGlzLCB0aGF0IGFyZSBub3QgZXhwbGljaXRseSB0YWdnZWQgYnkgdGhlDQo+IG1h
aW50YWluZXJzIHRvIGJlIGluY2x1ZGVkIGluIHRoZSBzdGFibGUgdHJlZSwgd2UgbmVlZCB0aGVp
ciBhY2sgdG8gYmUNCj4gYWJsZSB0byBhcHBseSB0aGVtIGJhc2VkIG9uIHRoZWlyIHJlcXVlc3Rz
LiAgU28gY2FuIHlvdSBnZXQgdGhhdCBmb3INCj4gdGhpcyBjaGFuZ2UgYW5kIHByb3ZpZGUgdGVz
dGVkIHBhdGNoZXMsIHdlIHdpbGwgYmUgZ2xhZCB0byBxdWV1ZSB0aGVtDQo+IHVwLg0KDQpJIGFz
a2VkIHRoZSBhdXRob3IgYW5kIGhlIGFja25vd2xlZGdlZCBpdCBjb3VsZCBiZSBiYWNrcG9ydGVk
LiBDaGFyYW4sIHBsZWFzZSBjaGltIGluLg0KDQogSm9ja2UNCg0KPg0KPiB0aGFua3MsDQo+DQo+
IGdyZWcgay1oDQoNCg==

