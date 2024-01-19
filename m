Return-Path: <linux-kernel+bounces-30814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA74D832494
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3235E1F22E85
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84161D29E;
	Fri, 19 Jan 2024 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HLCWJZe9"
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B96FAF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645625; cv=fail; b=IQSg9rSl358PWS1SbH0W+uwzcxOpj5Ari70k88y5GQ3kpJA+eR7EtMFRdt8z2Mw4XoQ20WI3yd4fnRiZb2w96EClWJmtpZJOZVjVTbmKsnMVzYAFnaoGoEKTvDBbYgDCpdgOq1roVydSU58XF/jjwfCU4J9fNvW8js5679hnTBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645625; c=relaxed/simple;
	bh=FP7rlYHb7p8Ht1LnMTRnBENudqUROCrX1NE7/QDIB2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V6CRQT3bCox52FHhU3COBLqHetKWXW1WbyD6xdemH+OQ7k/S1/GeqZ1vgvfPtFd+GruanTYh9WbBh5drdG5C9xwlhx/C20VXuurQbmV3DBbyOvBcbIDbmSfThVXwSf077Y3TLzcwRkUPRe6frkC2aju8FNA1f3ie1XjuSlErdmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HLCWJZe9; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705645623; x=1737181623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FP7rlYHb7p8Ht1LnMTRnBENudqUROCrX1NE7/QDIB2g=;
  b=HLCWJZe9vG2VK+5xFT8TnvO02FM96f2fSpaFrZQFd8c/3Ah4zf6xgQTC
   SRQw/slaAR29gO9Qatj32iUwUTWfFi1Oryvy7O2fAsnV9DutXmqoX1maU
   NQTYuoUudOOjD2enxr1A9HwXrypcXKKz9OKhNeHfw2rLwCf+2egCoRLN7
   +LhU8dwjZyL4+KJWPj2fvcsSB6SaT/AG6eEbPan4XAiDnqd7vwPdKXVOO
   FabEvmBdEwI/g/0jljAx1qwvOeC9223Xyb6WA6GxxCffvQSKFMhQ0WKtC
   6qeJEXELQgFGu8K38E/fx5GmIVQ/vns5OSe5imtAbHp38oj9Z+CSq57/F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="108245378"
X-IronPort-AV: E=Sophos;i="6.05,204,1701097200"; 
   d="scan'208";a="108245378"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:25:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gofk3nNfJfmpb2H3K3Lrrn3s8Wpmx8h7utiabeKZucjeyNzZqASLPsDOhQuWfxhLyZ80qMRe1nlUim53zh5bjgKZHM23h37ybek55kP+oImRMrR2luWISCiARhtkxzCQ7+Ti6v2xOoi18mG4nJZSfNspq0gmSAW++jHhINYvjOsT21dCwwduAQJfffu7rnvwpkzDatwLeGQ1/ZrZK0/a3a21NEj7kIt7+R4fBf+OZijsuON/Wg1K/jJpiDwquxt/9cG/uxm66zszofFs07uKb4TcfoFUNwwhFFRnTitt7/hJNXBvRLNhN6SgMzerwUlsEjWobv+XVCKxlHUVuHIHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP7rlYHb7p8Ht1LnMTRnBENudqUROCrX1NE7/QDIB2g=;
 b=gcv8blblPz3Oquw2t/0movHviTdKuETylaih+C1pTrhu5TdNg8itNqh218kKGIkkZJkpNabI54JEMiblYfS/cQyQOqFXqbF0h6EZIOjE55rTTSZ/UJKNv9Ff/HXtUBYAJIvzUtCbOBMJp7kkTrknZDTDI51lPA3oUcnAZnDxqy6NEP2/nC8yBmPXNNGFoa5T6Z3E+ddflt+Z18e4L8so4Gop/4qmDD5L2UA4t/eMBE+uRWqKDC4oVufDCDBQTDGSNP1/JfJxUiAhtvbp3X+E2ckaBNEexcE4x0XWmcpIvjl1ed3dV+iz4Uk/jReYJWxpJNoG8qpbK0Q+SF3pEjCbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB8326.jpnprd01.prod.outlook.com (2603:1096:400:15b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.15; Fri, 19 Jan
 2024 06:25:45 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7228.009; Fri, 19 Jan 2024
 06:25:44 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas
 Palix <nicolas.palix@imag.fr>, "cocci@inria.fr" <cocci@inria.fr>
Subject: Re: [PATCH 01/42] coccinelle: device_attr_show.cocci: update
 description and warning message
Thread-Topic: [PATCH 01/42] coccinelle: device_attr_show.cocci: update
 description and warning message
Thread-Index: AQHaSDIil6iSQfVKJk6069otilFPcrDgCPuAgABsBwCAADtCgA==
Date: Fri, 19 Jan 2024 06:25:44 +0000
Message-ID: <53bc3ab0-57a0-4075-9055-03125259874b@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116041129.3937800-2-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401182125480.3296@hadrien>
 <5b32f57e-c44d-44a1-b2f1-4dd7be59636e@fujitsu.com>
In-Reply-To: <5b32f57e-c44d-44a1-b2f1-4dd7be59636e@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB8326:EE_
x-ms-office365-filtering-correlation-id: e23674f5-811b-4954-bafd-08dc18b777b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JPrP/xW2067Rtotw5XoFD1QwsA6YNuImTiOuVgp3dADwvQQRL/v8ZBbkS6yDGBB7lJNUQNJ8NePJklfC/UDh5dalsQzBKMW0CAZqwcxxEKiMwHYV25hO3LjdkeQ8nHfljaoo2k4SaV6sW7ZD8sdDFW78N0ZVuuKtkS9Qu2oUHXOfmPGI3sbCOO+GJFbCSwfaL8WcdBTPXG+Okhr0IwtppAw5I+1HzL3PnuQO4FpWIvAHgi5GheZjseCfQcahL69FseQNZF+I2awX3UL3xkwcGVvx3y0B6XbKQimRb4aNCQ3eUK5ud2klTAf0feDybTOg9UxPV+CgCBTg1h4FhZ0O43pTE+aulF3ubMDEzx3xBLSuCsFsOt9MaKHfXr5iwOwm3b6UyG2QGj9PJDFFMERCNVsPWC7Sx/4iBi9fFRLIbF7n0C6XmDbxjurxidlHfNhN+hXi6kK998pDQ2g7QR3IcC2r80NRZbdqKkcPgSgn4+5CNYIHFKk22OTfGy4I2j3F2jGLp/KHedzxcYSSOGf7KkkFQJTnEA5aCK1Nm7F8CzaOxPc0aELpm10jVs0rSXhclC2rOHlZIUI7kMIYzUshdZcNcaF2b0A37uO04ngN+qaybpXpdWqihQOtDUmplPNmB0w424ABBUtxoSuQKUyHjIWQgvwmeo2Pe5JP47De61PUUhzwWtoRextqvLj1VdWi/T2gAlnsWyiRt828QqozaoVbGAWaQ1DzoMVncXF0sPGtM2O0cr12oujq8GpkJLTIuoZYM1DbigaATtPeJlCoaw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(1800799012)(451199024)(1590799021)(186009)(31686004)(1580799018)(83380400001)(86362001)(31696002)(2616005)(26005)(36756003)(82960400001)(38070700009)(41300700001)(5660300002)(6512007)(15650500001)(66946007)(4326008)(122000001)(85182001)(53546011)(71200400001)(38100700002)(8936002)(91956017)(66476007)(64756008)(66556008)(54906003)(76116006)(6916009)(66446008)(316002)(8676002)(6506007)(478600001)(6486002)(966005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUgwYVFFcDRtSk95NEMwd1AzWGYwWVVFeEZuRnRJUk1hWnljcDNzcmxLcThs?=
 =?utf-8?B?NmVQVjZ1dHkrakl5YmJ6RHhEcVhqTDQ4eWNhMEZwZ1k5dWwzWVNNQldhOTg1?=
 =?utf-8?B?VjlPTnZMWWNyeDF0azdVT2w2Sk04T09iU2hmdVdHbVJqMWpyWVVZNjdiYkts?=
 =?utf-8?B?SnkzbktIYnZWQWhhdm9McW9mdld1YTNEc25IdFQzWkpRcUcvbjc0eUhkaFJF?=
 =?utf-8?B?QnllMktnODFzSWR1c1dZYWxKRkRYN2FwVXZLWjI3S2NhMzBiMVBlZHRGWVcw?=
 =?utf-8?B?aG5Cby9FRzBPVTBOWEcrbm9HeWw0ajlLZnJlWnkzNldCZHg0R0ViTGJyZFlC?=
 =?utf-8?B?OXF5OFJuMGJtM0tJa3lEM2Z4YW9mYkg2RTFleXByTkQyMWVvdXd2VzM3eVhO?=
 =?utf-8?B?b3JvV2wvN3IxbWxFZkZ1aHpnWWR4SkU0UXJzODB5UVZpckpZakVYcnh1UlZ5?=
 =?utf-8?B?ZmlqblZoeEpMWVBYUmZPVGhRR2YxR3daVURraWpRWVJFV3p1cHk0dm1LY1Vk?=
 =?utf-8?B?SDZoL3Job0pCQmFkWGMvZklVTHdvSi8wTzd4MnlENUtPc3c3S000VWVYSTBJ?=
 =?utf-8?B?aHNLZXhScVlYQXQ2ckJXTnZOamRRcWdhK1hvV2syRW4rTXhYbElmcnR5L05L?=
 =?utf-8?B?cGdnVEdhK3Q4cUx3aTdkNVlXUngzV1hrcm5WKzRZQUE0L2xOU2NlSjRlY0JW?=
 =?utf-8?B?dVRTSkRaaElLTjg5TjFkd1ZwMGJZWUZDV05zYWxuMklRRGd3MnRmUzRTWDdr?=
 =?utf-8?B?U04vZTkyTFhPRmJJb1NqNVM2eTJOb3l1b1FkSTkvMUVuZ3JXYjNzV1R2MXBk?=
 =?utf-8?B?U2I1dUNKMURhZVIxcEJJRENHY2lYZ0lCbXJ4aGlMdTVUZ2dZYWZ6NDZIa2o5?=
 =?utf-8?B?Z3lWeWdEaWxqYTRZQmtLTUpZb1dXYkx5TTlDOWFzdDlQVlhvUERVbXNKUWR0?=
 =?utf-8?B?RmNmeWdWaUhvcmJXRWZxbko0SllxbnZJZG5OYXRoN2wraDg5MGRrcVBLSm9Z?=
 =?utf-8?B?Z084QVNiSVVDMEFseHFJc09OTW5VUy9nVWUxYTYzc1ROK25VakdRKzV1eVVD?=
 =?utf-8?B?dEVJNGc2VXo3R0lCR1lNUzBQRi81TUhxZ2poNDE1TVYrcFJnaloxaDJvR2xq?=
 =?utf-8?B?WFpkNUdoanc5VWhuWVZweWUzWXcwUjRIN0FMSGJaMjcxSnFyV3hPS0MzeVJK?=
 =?utf-8?B?aWxRV3k3aGQ0ZlJiWmRLOVVjSVFwM3dYWEh1Qm1PajEwQk9OSEcxRkdUYjN2?=
 =?utf-8?B?SThFSEczL1BGTTVxNkZGT1paRXRYcVovUnhxWjRjUGRnMzhTZm1jZnY2Z2Z0?=
 =?utf-8?B?VmlzUjVkcDdITm13T1ZCUzB2dEtMV3hGdlU2bzRxYlE1c0hjL2Myelk4cFdV?=
 =?utf-8?B?YlBVeERXR01xajNsM3Z1U2VRdnd6U3FmQXhSTE05ZWUyVW4wM2VpcmpnanhP?=
 =?utf-8?B?UWFSaTg1QXFPVGNLU25tK3JwVDVzMkpIUWxDZmpLSmVDVTlZR2l2SDRPRkJ5?=
 =?utf-8?B?UkhBcU1jZmNJYzdOdHBmc3I4MU9vT3kzZXFPVzhMcFdkd3hiTWdHeHpjdGl3?=
 =?utf-8?B?dXUrdGxsQWt3aHV4bW1KQ1lRelo3VTJFTmxnb01CUXVLeE1nc1VUR0h6NnRr?=
 =?utf-8?B?VkliQ3hhSDZjT2pBaEdUdlFqUlRmUGdBQVhLemhNRmNlSEw1QnkwQjlKeFB4?=
 =?utf-8?B?YWl0aTBvT2tTbldyaXlnSHozU1NZQ0RyZjFKMG5HTDlkRjlWdTB3RmNlRDM2?=
 =?utf-8?B?UjkxK2R3VjI0Zmg5R3BCdmREcFlLTVZpM0kwNEN0clJWQmtiMTNmeXVQL3g1?=
 =?utf-8?B?TXNEOGxkdktTUCtRYnpuM1daS1RiTHY5UE9vUE1nTHN0bVhSMCtVbEhTd1po?=
 =?utf-8?B?aWdQMVJkbUhCM0lVYzFWVGh5SUtQR21DamdZOVJqWStockNIcWd5eEVDNlFw?=
 =?utf-8?B?UzhPTzVnZlBBejhsUWlBa3ZySmdweHI1TGpKWG5XZjM2dEVieGs4MHd2MnlJ?=
 =?utf-8?B?L3RkeitlamlESFFwTmdsUEk3QmdvMnVUdmdCRmxXN3ZRdGNXNktxcHBHLzBS?=
 =?utf-8?B?Z1VINW1IdUgrNGZ6S01lOWlMZm5rMTJ5VVkwT1cvT0ZBeUx5c3gxSzdLRGh6?=
 =?utf-8?B?ekI1ZFBlRmtyekE3Y1FTSG5pTi9hbDV2RDlJV1k5eW80bXpSeGpwTy8wVGxv?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0063E97F80BBD4BBC9049AD4786DAEA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ziu9ACenRO6AGqmFvMOsUe+4PEzI/t0BHuNQtisGSaM1mU7bG2JJXv5KHScgSHOtvs8uguYarjPilDyeXYBUuUaKqyJBt95RTlIC3kjTqxiitrzI85FNavfd+axea6Hwk49biGCgolhUBynk+gk5zUhmqcZCBRrmJtSjXv9kbGqit8Jw1d5G3Bzm1EDlsT/7gTwuI958WEImCLxSDhQ9ney0cNlc8KqIYAJdmxveMZ9QRy1hcxp89pB2FceYtVZQOvRGVPLRyG9I1hF6dM1/5nkZmy4xnAHTP1WzxslE2GivdqXQK2AjeXpfAbRSA4VeNibpfcSF7NVBTV1gT241/5P69BdN3rgst7w2kPNqSqK0fdIUYUSsbvP4AhafVQWfl4qGA8pIJNzwp1owAt2B82+68K/zUCsbgoPy1T+yBJFlc0Q/9n1wh6kovqsauzSQiMt3b/HE0OBtZkC4xEPnLW2kcVJrqEiaU7wvGFd8Rf43JeTie1saaF2qgHNDJrnDEF1DgOENcQ4Jg0C+5cFLPmloUG1GqB8k6eIBQmZasY8uOgnN0lTm0KBC7jsca/v9OBm+SMS7pr7mSIme5dbh20aCR32QJBtCcMgbFK9T+clHMJqBf+d2m9eVuJkrstb3
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23674f5-811b-4954-bafd-08dc18b777b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 06:25:44.5632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avbeDB/bO7GR2EarkQ6MvuV//7lLGxE52ZhBDJdIJwNCKkYwC59Fp9skg8CIR8vFSkuIoBkX8yxavEa5BE7D9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8326

SnVsaWEsDQoNCg0KSnVzdCBMZWFybmVkIGNvY2NpbmVsbGUgZnJvbSB0aGlzIHZpZGVvIGh0dHBz
Oi8vd3d3LnlvdXR1YmUuY29tL3dhdGNoP3Y9MTZ3VXhxRGYxR0ENCmFuZCBwb3N0IFYyWzFdIHRv
IGZpeCBNT0RFPXBhdGNoLCBwbGVhc2UgdGFrZSBhbm90aGVyIGxvb2suDQoNClsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwMTE5MDYyMDU3LjQwMjY4ODgtMS1saXpoaWppYW5A
ZnVqaXRzdS5jb20vVC8jdQ0KDQpUaGFua3MNClpoaWppYW4NCg0KDQoNCk9uIDE5LzAxLzIwMjQg
MTA6NTMsIExpIFpoaWppYW4gd3JvdGU6DQo+IA0KPiANCj4gT24gMTkvMDEvMjAyNCAwNDoyNiwg
SnVsaWEgTGF3YWxsIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiBUdWUsIDE2IEphbiAyMDI0LCBMaSBa
aGlqaWFuIHdyb3RlOg0KPj4NCj4+PiBVcGRhdGUgdGhlbSBhY2NvcmRpbmcgdG8gbGF0ZXN0IERv
Y3VtZW50YXRpb24vZmlsZXN5c3RlbXMvc3lzZnMucnN0Lg0KPj4+DQo+Pj4gQ0M6IEp1bGlhIExh
d2FsbCA8SnVsaWEuTGF3YWxsQGlucmlhLmZyPg0KPj4+IENDOiBOaWNvbGFzIFBhbGl4IDxuaWNv
bGFzLnBhbGl4QGltYWcuZnI+DQo+Pj4gQ0M6IGNvY2NpQGlucmlhLmZyDQo+Pj4gU2lnbmVkLW9m
Zi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4+IC0tLQ0KPj4+IMKg
IHNjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hvdy5jb2NjaSB8IDEwICsrKyst
LS0tLS0NCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNl
X2F0dHJfc2hvdy5jb2NjaSBiL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hv
dy5jb2NjaQ0KPj4+IGluZGV4IGEyOGRjMDYxNjUzYS4uYTYyMWU5NjEwNDc5IDEwMDY0NA0KPj4+
IC0tLSBhL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hvdy5jb2NjaQ0KPj4+
ICsrKyBiL3NjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0dHJfc2hvdy5jb2NjaQ0KPj4+
IEBAIC0xLDEwICsxLDggQEANCj4+PiDCoCAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vbmx5DQo+Pj4gwqAgLy8vDQo+Pj4gwqAgLy8vIEZyb20gRG9jdW1lbnRhdGlvbi9maWxl
c3lzdGVtcy9zeXNmcy5yc3Q6DQo+Pj4gLS8vL8KgIHNob3coKSBtdXN0IG5vdCB1c2Ugc25wcmlu
dGYoKSB3aGVuIGZvcm1hdHRpbmcgdGhlIHZhbHVlIHRvIGJlDQo+Pj4gLS8vL8KgIHJldHVybmVk
IHRvIHVzZXIgc3BhY2UuIElmIHlvdSBjYW4gZ3VhcmFudGVlIHRoYXQgYW4gb3ZlcmZsb3cNCj4+
PiAtLy8vwqAgd2lsbCBuZXZlciBoYXBwZW4geW91IGNhbiB1c2Ugc3ByaW50ZigpIG90aGVyd2lz
ZSB5b3UgbXVzdCB1c2UNCj4+PiAtLy8vwqAgc2NucHJpbnRmKCkuDQo+Pj4gKy8vLyBzaG93KCkg
c2hvdWxkIG9ubHkgdXNlIHN5c2ZzX2VtaXQoKSBvciBzeXNmc19lbWl0X2F0KCkgd2hlbiBmb3Jt
YXR0aW5nDQo+Pj4gKy8vLyB0aGUgdmFsdWUgdG8gYmUgcmV0dXJuZWQgdG8gdXNlciBzcGFjZS4N
Cj4+PiDCoCAvLy8NCj4+PiDCoCAvLyBDb25maWRlbmNlOiBIaWdoDQo+Pj4gwqAgLy8gQ29weXJp
Z2h0OiAoQykgMjAyMCBEZW5pcyBFZnJlbW92IElTUFJBUw0KPj4+IEBAIC00NiwxMCArNDQsMTAg
QEAgc3NpemVfdCBzaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1
dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4+PiDCoCBwIDw8IHIucDsNCj4+PiDCoCBAQA0KPj4+DQo+
Pj4gLWNvY2NpbGliLnJlcG9ydC5wcmludF9yZXBvcnQocFswXSwgIldBUk5JTkc6IHVzZSBzY25w
cmludGYgb3Igc3ByaW50ZiIpDQo+Pj4gK2NvY2NpbGliLnJlcG9ydC5wcmludF9yZXBvcnQocFsw
XSwgIldBUk5JTkc6IHBsZWFzZSB1c2Ugc3lzZnNfZW1pdCIpDQo+Pj4NCj4+PiDCoCBAc2NyaXB0
OiBweXRob24gZGVwZW5kcyBvbiBvcmdADQo+Pj4gwqAgcCA8PCByLnA7DQo+Pj4gwqAgQEANCj4+
Pg0KPj4+IC1jb2NjaWxpYi5vcmcucHJpbnRfdG9kbyhwWzBdLCAiV0FSTklORzogdXNlIHNjbnBy
aW50ZiBvciBzcHJpbnRmIikNCj4+PiArY29jY2lsaWIub3JnLnByaW50X3RvZG8ocFswXSwgIldB
Uk5JTkc6IHBsZWFzZSB1c2Ugc3lzZnNfZW1pdCIpDQo+Pg0KPj4gVGhhbmtzIGZvciB0aGUgc3Vn
Z2VzdGlvbiwgYnV0IGl0J3Mgbm90IHJlYWxseSBjb25zaXN0ZW50LCBiZWNhdXNlIHRoZQ0KPj4g
cGF0Y2ggcnVsZSBzdGlsbCBnZW5lcmF0ZXMgYSBjYWxsIHRvIHNjbnByaW50Zi7CoCBXb3VsZCBp
dCBiZSBwb3NzaWJsZSB0bw0KPj4gZml4IHRoYXQgdXA/wqAgT3Igc2hvdWxkIGl0IGJlIHJlbW92
ZWQ/DQo+IA0KPiBHb29kIGNhdGNoLCBpIG1pc3NlZCBpdCBiZWZvcmUuDQo+IA0KPiBMZXQncyBy
ZW1vdmUgaXQ/wqAgSnVzdCBzaW1wbHkgcmVwbGFjaW5nIHNjbnByaW50ZiB0byBzeXNmc19lbWl0
IGlzDQo+IG5vdCBlbm91Z2ggZm9yIHRoZSBwYXRjaCBtZXRob2QuIEJlY2F1c2Ugc25wcmludGYo
KSB2cyBzeXNmc19lbWl0KCkNCj4gdGFrZSBkaWZmZXJlbnQgYXJndW1lbnRzLg0KPiANCj4gSSdt
IG5vdCBmYW1pbGlhciB3aXRoIC5jb2NjaSwgaWYgeW91IGtub3cgaG93IHRvIHdyaXRlIHRoZSBw
YXRjaCBtZXRob2QsDQo+IHBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IA0KPiBUaGFua3MNCj4g
Wmhpamlhbg0KPiANCj4gDQo+IA0KPj4NCj4+IHRoYW5rcywNCj4+IGp1bGlh

