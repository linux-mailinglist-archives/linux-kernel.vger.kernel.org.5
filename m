Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525BB7DB57A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjJ3Ivn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjJ3Ivk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:51:40 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011001.outbound.protection.outlook.com [40.93.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA5B6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnjABiBsT1aH9C2Wh563W2BEamlSrskocPc4QFckz2dRmn+jYcBIpVnhPw7Iwc0Gppna+h6xkxC4IGVCInOj93Y5mAqC9+RPYW/W5lp45ehr/qYGDPe/lTfo0IQgblcinCGzQZm64l3Tb1z/1NVTWCYt3MDnvH8zEo9cRE01wq5hlz13lKc+zR0dO7JxRmHhCNwbtWStnUle7KhJR9l89G6gV8iJm+bKe7mrkVtxihfQGK9jnSKgUkkwV6ltSP6Yebn6Z3BseTT0I2D711kNKmGef2qLIo9E/xr3BlZ2+E/r1sGUfflXe5AhuL2dh/Ptd3Yv5gyY6e9qMMhA/tqN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUjGvtIgBOLzhLMkPxfQ/+PU5LSX9cG9BOqp/IcQEBQ=;
 b=HohOAa2o28/b7ch29MBIoD1RihtSlhLCaD612I41Vtin/FelmIZR/WhDAxEC8klrRvWudVe9Vs5dMLcKcvu3HI5529ZKHNSE2//tGZKFKYFHhVsaA3zI0MshldfXVNDcvT2XYmvO8nuil6TI9smRwyPBYLkGes1l25BPuK+8PKdZNZQLd1e/eEYyFlf9MSXoe802+bn4WhHsxgV2WNSiuFNfplsjotZ9hM7iYMI/CXkQCEJwQyixcFgf+aMiF+a9kUNK4UBtnnFniHJbHqswZOpp8s+R3QGiY5t1ESMi/dRa8XomLW8M2s9R5VGOA3m6OVHx8pzwAe/yNi+8eDQ1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUjGvtIgBOLzhLMkPxfQ/+PU5LSX9cG9BOqp/IcQEBQ=;
 b=Yj8es5mJRqwO+pgEzjOQJO6k/WsBKJbRDTWZhAyc60VTpRvtSg9zGT0sd5gpWCBP5bQABQC5PbG6TlxT5TOr6kLHGhMSqEmWs4QdlU9nx3YuMByWuXqKOhDtAHEIeuRiBZdu9Go5IK4z+PF6J2km9NtKKe0iA+dl0phgN58ODxM=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SA3PR05MB10322.namprd05.prod.outlook.com (2603:10b6:806:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Mon, 30 Oct
 2023 08:51:35 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::b668:aef3:606e:923f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::b668:aef3:606e:923f%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 08:51:35 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Byungchul Park <byungchul@sk.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 3/3] mm, migrc: Add a sysctl knob to enable/disable MIGRC
 mechanism
Thread-Topic: [v3 3/3] mm, migrc: Add a sysctl knob to enable/disable MIGRC
 mechanism
Thread-Index: AQHaCwJU6mkgYNVDiEGUaMKS2dpxHLBiBoEA
Date:   Mon, 30 Oct 2023 08:51:35 +0000
Message-ID: <17CADC36-25C6-44EB-8084-6E3D9D64B3D3@vmware.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-4-byungchul@sk.com>
In-Reply-To: <20231030072540.38631-4-byungchul@sk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SA3PR05MB10322:EE_
x-ms-office365-filtering-correlation-id: cb338bc3-a8b9-4aa3-d453-08dbd9256c55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 87hJjydbrvOmZhuFdBmffY+T707fQjLgmPn6M0JRUhHpK9ddj/ElsTvgT0HfcVKZ84uCrv9NapEevLwRL2INudLXoNHlbsEwvgbgGTYoC065oVQcki04x9aEbOEIQ2Hy16qX1mnW4PMFPycUcdX0zpIEYYBw3nnHu+0yCLgjE5rdtyJ5cAo1xO0ryUj3dlnf3FAoPhbxfMSN9w4CeejittwbupqmOoWowSWDo/oYf3vNjgae8dRw89/gHNBdjbPVni+k2wx6JEImLR5JTeuZWI4Mp3C4Foq3fa+A9OyGv8anEXN2BQkLE69SfCxtZYE64LUucjjFaFstcf1qjlrZCSbc39Fnd6iEp1bKvBRJ2Xzg623TcCBHI8nBOCkmVGTr5ybFwCH536EXYd9/+ZM4qjNmHj00g42QOVN4frLACkmYq+L2JqBx3NbJ1U2g9MWUYwGBx+MEHYb6xdiXkNZmeqfSp35fZmUb02z116zBM5bybwxP13c/1rd0+ZS5hiHaUMcbSWQE2z2trowE01fKVPw0nMIla1waSrN9FS6bU1alZ0lNbr/MnyaStwGX+XvChmMmfI/AEY9E975cz6DcWWc7RvkmvEZqjbjL6j0UcAKtE5nO1dxdjEdYC6GoCu+TVf0eXEI372A0EhJERTNrVM50Uz4awxw6vYH98PrNpUxzn1cAzYLBwkxwa0vI/FGgKm+3CbLxc9NUe57C/8c0fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(7416002)(5660300002)(4744005)(122000001)(86362001)(2906002)(33656002)(36756003)(38070700009)(38100700002)(2616005)(26005)(478600001)(8676002)(6916009)(8936002)(6512007)(66556008)(64756008)(41300700001)(4326008)(76116006)(71200400001)(66946007)(66476007)(91956017)(6486002)(6506007)(54906003)(66446008)(316002)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTdNam9Gc3pHNmF4WTl0U0hyRDVVcGlNak5vczIzV0VJWmZKaVFJWSsyWHNF?=
 =?utf-8?B?aGJEY1ByL0s2anVEZzBScmQyWWNGSzI2dlhoU2ZkNjY3dkhnSlA4NW9rMGVT?=
 =?utf-8?B?WmpNb21PNk44ekFXVnR4WDFycE5DRWhkc0NHVFB5RWh5Qk4vNml6WEQ2Kzgr?=
 =?utf-8?B?c28wZmZjMXJKNjNWVkxaa0ZKaUc3V1BYMTk1dmNsUUJPeGR3OUIzTlovU1pt?=
 =?utf-8?B?ZEpNMEpieGhmZUo2ODFlTHdybTcwWnNpaHdPeW9XVjVtMnh6eDBBZmVGWmRp?=
 =?utf-8?B?aGJpRzRvUERpclZZRnpiTmk5N3VIdEJkYVUxY2RYRlFhM0VZZGQ4eis2NzBu?=
 =?utf-8?B?UTdZQ05BOFhtMitBM3RHNm40dmMwZktDUlY0dk5FaDgzdFJpdm1WTisyQ2FH?=
 =?utf-8?B?ZFptSlFUdFovcEZMdXBaNHpPdkE3R3o2S3dqRVlTWnM4QkY3UjY0MS9qS01i?=
 =?utf-8?B?RDZRRUlZdkJ5c0VoZWw1eWtLeWwvRWNkQ2hwbzg5cjFUeW1vY2ZIMmV6VXds?=
 =?utf-8?B?MXVIdjdGR1E3VGVTZHQ5YWdvejcvSXgvRkVTVm9OL3E3cWZQbmNXQ3BXRER5?=
 =?utf-8?B?cVZ3Y3E0QUdCVU1PV2ZXZjJwZkJiZUhEQjYvUmNMRUJlK1VoanNXTVN5Rk9v?=
 =?utf-8?B?R2NESXoxVlNUeTdIU3VZakxWaklNWHR6blZUTWd0VTE1dUd6MlhxcExiODhM?=
 =?utf-8?B?ZngvUUtERE9SLzB2OVA1RjVyUW5YcWFGcUJVYlpDdTM0MEpybkJmNllVclNI?=
 =?utf-8?B?emJrbnlwbkJKOEFXbFdWQUFJemJ4VXJiRU5XUkZBSzJpa2ZvbTRlN20xYUdE?=
 =?utf-8?B?RVpteWdvb2trT2JJZkdNVlJhK0wxQ2JBRVpuNkpJSGVST1R1T3V6NnU5YkdW?=
 =?utf-8?B?cTNDdDVpV1JjU28rRjFGMVdaTkV6RUIreVVqNUZnS2NPa3RyUkZYOWFpcEVp?=
 =?utf-8?B?L2FsRGt6SkVYWG5HekZTSFVIWnJHREtRUWN5RXo1RzkxY2JzZ3JKcStDWmxI?=
 =?utf-8?B?ajVZTExKVVZ6ZnRHN3gyblJJY0lkMHdsQXExdjhXMWh3bm1BT2xGdEt1SzN1?=
 =?utf-8?B?VnBFRFNScVlsSHUwb2QxbTM2UUZXU2Q1dGNFVGFacC9JTDBXeElpbmxGRnhh?=
 =?utf-8?B?S09tVzZTRmM3bFp5a0tpRnFjKzFkd0toa3hOWVlBZmN0aW5aWDRQOHFySjRP?=
 =?utf-8?B?VXcxL0FJWlA0NmxyendGeTA2c1d2QnR5eUxBdW9lTWhWQnJiZDFsaWRkZW82?=
 =?utf-8?B?U1BaUEJQZm1qZ1VSN1N5VTdnMFBFc2xzZWxBd0RKMElmaGJxelRFOFBBYWsw?=
 =?utf-8?B?NVIxZkhaUEVNSXp1SDRVNTJGQ2FqcElmMDEvYTlYNi9tQ0IrSURmSS9lWkt3?=
 =?utf-8?B?WEZma1VIQ1JGMmRFUlFJY0d5MGNSL1pYN2UvN3cwOWtPcXg1TGYwSFo1RkxC?=
 =?utf-8?B?T1JDdVdtM1Z1NzNiNks0Q2lZcHg1emhMSjBKLzJsV0FxS1pjOXJTb3VKMCs2?=
 =?utf-8?B?bG84YnZ4Y0E1VkhwU0xiVmpoeDVuOGcraHR4dmJrZm5mRFZudUhOZ2lSWlFK?=
 =?utf-8?B?UXEyYjNMeE8yaEhrVmZaVXlsWEdybzYxLzBVdVl6aVVTZFZqcDlnZk15ekRI?=
 =?utf-8?B?UjZQWElKTURra1pNNG1BdE1pZ1o0aThKTVgzd2p2Vk8yeDBZcmcxM1Nob0pH?=
 =?utf-8?B?a3Fmdzhud1Z4Uk03dFZPaHh0cmlTc2gxQjFaWkNRcXV6d3hIMXNSeG5kMzNB?=
 =?utf-8?B?TUhBdEtqekJsMHFqUS9GaTF6UU10WDVIbmVWWW8wMm1TR0lmSEU5V0hsZTFU?=
 =?utf-8?B?ZFBjWGM0a3RBblZlZHg5a05zeVB6WFRHWkJITEJaSWNYTVlVTk9uclNIL1ZW?=
 =?utf-8?B?aHpQK0lDdFlyd3dTYVljSTV3b242eDU0MktCMlR4WTBlYVFhbzJSSy9ZK1V4?=
 =?utf-8?B?S1ZxVnNOaWFneUw1aDdDQjEzODNib2grZjd3Ykp5T2k0bTBKeUNCeXp3bHVp?=
 =?utf-8?B?RUZFaThpWUR0aFZFcTFIYUdZSWFmUDd5RnpjUzg2cC9NVFZMQ1pESTUvNENK?=
 =?utf-8?B?S0VjekhITGZoZ1B6L1l2WWd1SWVhZ29IMkJyRnAwQnhSVWZDSVFDdW9uSVlS?=
 =?utf-8?Q?xrx1fiKU8gDFzIkJxntSsFWkI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <061BA3DEC0FFAD43BE26F2606CB90D41@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb338bc3-a8b9-4aa3-d453-08dbd9256c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 08:51:35.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMuD8mPWvQUNIj/p6WVpG0N2C0/VRWRo1yl9O4z6lEKOvNNd6GOp2fdxy0LUP/S1NuCZ9ifHXmJcEmtSN/xFJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR05MB10322
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE9jdCAzMCwgMjAyMywgYXQgOToyNSBBTSwgQnl1bmdjaHVsIFBhcmsgPGJ5dW5nY2h1
bEBzay5jb20+IHdyb3RlOg0KPiANCj4gQWRkIGEgc3lzY3RsIGtub2IsICcvcHJvYy9zeXMvdm0v
bWlncmNfZW5hYmxlJyB0byBzd2l0Y2ggb24vb2ZmIG1pZ3JjLg0KDQpQbGVhc2UgZXhwbGFpbiBo
b3cgdXNlcnMgYXJlIGV4cGVjdGVkIHRvIHVzZSB0aGlzIGtub2IuDQoNCkkgc3VzcGVjdCB0aGF0
IHRoZSBrbm9iIGFuZCB0aGUgY29uZmlnIG9wdGlvbiBhcmUgbm90IHVzZWZ1bC4gWW91IHByb2Jh
Ymx5DQp1c2VkIHRoZW0gZm9yIHlvdXIgZXZhbHVhdGlvbiBvciBhcyBhIOKAnGNoaWNrZW4tYml0
4oCdLCBidXQgdGhleSBhcmUgbm90DQp1c2VmdWwgYW55bW9yZS4NCg0K
