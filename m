Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88177D4761
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjJXGWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjJXGVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:21:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C78810C8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAXKcdPGLQt8/PfaG0io1wk4GcLkt5bnmfbZvLP/Srdtu3y05Eww2GEBeUepDgQMvSK0FmnR1+LDKnKe6g8D1gP9/iEh5XI6MyDpOPBuVR+XdbMBsJoQ0LZ/m4wUKgZGn20tR3MAlj651E1uWGn6N4oL3ymfYgmJ9vKnGUnKtnYfsOgL2KWCQIjyxnkzUDWuTITrQfhMpL1uIAYu6ts+r2hkRWRtJDCtIJKnEzfy7mHHB8mfVsnIcpAkY0axiSjVPQY38B8z+2B6yIX5jQgPglhf4kaKWouezsN5qxmdzlQ3BjkZ+aX9f0RhAJdXzhk8Nsyf/Y5F4Jwaba44mFtv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n52P1/beHf8VZdPFp/x8Be3r97rP7VbZAwETzAZtzYY=;
 b=T+UfpKkHggBEYYcbY0skH0d/OhWvzxKmiNaHfvo0ax3eVCHEVgmW+DZ/siBnjFhD4UsM7lQHDOQuqEU99XEag747xQKUtmX1+EjvAu52C3qdbj35R+csMtPnqHkVcdh5Xh/ObUKjsx5/7LS1Um2+mWCPUtoM+73DnoLYL4WVVx/ozwhXN3Zh5ZwrAt+xL/h6AxZdSBujiHhtTSZ1p2Gdbyo7eseUuHmUdUkp+mE2n3IcuquXDd+php1rv/LJg/rgZkxK+Ikg92Ez0kRArirTe/FrDjTvIpGN+W0SOKLAKMYFAKRk/3wpGr1vju63rCfJkvF1jM8uOHQSxRYrvYILKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n52P1/beHf8VZdPFp/x8Be3r97rP7VbZAwETzAZtzYY=;
 b=kvGJ6J6LSWt3Oqq3ZS+Onwvf6MzVnnOsbL74bnZV3Hh6QNiCRoop06g/yUuDMns+K1W6RVRLbIS2UXLfNMg6z6PKRYp6QYrBJ+qUIIcuBkZgdD12a+S/OumlBC5NcT5w7UUnCi5tVaAvZ0QQ/QvEKVPUDYZOgBBHeeTvmohlw76x95uOyPsXQCfFf6rDSjT8yI15rniswG2AdSTRXi5B723RnJclfLTLZvdjic1HaxE/IAk9GJAjoAyKXYgXwY+9C7O+O7T5x9y9vvCe70kQJ8BZVopfC1TRLFa+yPJx/rv0UqJ77RadK5550/Q+ZcbRo6CGIvvj//HfzrLH7CytLw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Tue, 24 Oct
 2023 06:21:45 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::af95:93e7:d27a:15ee]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::af95:93e7:d27a:15ee%7]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 06:21:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v2] nvme: update firmware version after commit
Thread-Topic: [PATCH v2] nvme: update firmware version after commit
Thread-Index: AQHZ/fMPiGjdaD8To0mFg2/+5jgP7rBYiNEA
Date:   Tue, 24 Oct 2023 06:21:45 +0000
Message-ID: <9c9ee261-6d44-4193-917d-a513865e7181@nvidia.com>
References: <20231013163420.3097-1-dwagner@suse.de>
In-Reply-To: <20231013163420.3097-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB6825:EE_
x-ms-office365-filtering-correlation-id: 643d404f-1337-4396-ea10-08dbd4597efe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Pft7TuVZGJpfvjp/HDHbfV4aHCJ1qIfQv33lziTnrinVqa+MxBmG/QNleUQDAahuGeNY0SGzCTSznC+fmriz+XmcLSiLXRMcmLvuFMp9Yt14HLUTWF88R1cVCy7jbbVpxMNxbxGfhZDe4f5UpGk0mGSFfpZo61oqoJZioKOhc53J5X6JM5HnfpL/t28QRgpqFFsItuD6hJIz6sN9fCdWL6EzCnBgV88l8eCIMHmrzikapFFhPfOS2Mn/i5oG4T6OQn1+XWLyHfvmB/nq2la3JNWUv2RGZeqvqdOhU7HtHYQWXcymzjwSHyWv1Z0q4XXhu79Rha5aXV+ic8UT/VybAv+kyn5BJpLm/8bwBU6as6j+jInz/ToOaqsLdZBhn1UT8nQO2X60y7eDynZ5/3ERWN2Or7Esfw1+r1cOY0lR0ugQvdcDL42Gz8Q4jkDpfj/jmMVSGlFYoGMo8KyWoExFon9B/NR5F++roZ/SoBpyZ8bw517DwCENUmqJp05MkwSfPNhu0akI1K+/j+zgHrd32Q2VBIXaAfj6k1bfT9OTqwu5UAzv2D018abCk1PWgGEc/Y1jJWIJ17DIrNmAIfqJZukv8forqKNfwkgmITw9SFxUF/+N2DHISsdpmW5HcMsMic9i4te1qS3117X7VvWCbMFSX3CuyVVRHtf81iAAeGD3UurZYbazIjz4s6M5KHW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(66946007)(5660300002)(54906003)(64756008)(31686004)(66476007)(110136005)(66446008)(76116006)(66556008)(91956017)(316002)(122000001)(6486002)(478600001)(8676002)(4326008)(8936002)(2616005)(38070700009)(38100700002)(83380400001)(31696002)(15650500001)(86362001)(6512007)(4744005)(2906002)(36756003)(53546011)(41300700001)(71200400001)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzlCRXNVdmZHTWFkcnk4ZjFwWE90b1I2ZTRxV28wNERSakxIc3Znb1V1TXpv?=
 =?utf-8?B?Nlk1ZkkrenZiTnVyeWpFYmV3S0VMZ0lnb29hZVMzM3JNNUY4RHkwUUU5dEtH?=
 =?utf-8?B?aDB3eEZhbkJDeEVkWlorcERONThLMnh6VDZoN2IzU2VDM3gwNkVCbWRYNG1V?=
 =?utf-8?B?RzRQYWt4K0JUS2FjN3VzelIyM254alpDN041SXRVcjg5c2pyQU5CUUxPcE4w?=
 =?utf-8?B?ZHA4MWQ3UG5PaE9mMGxCbGswb25telltWm0zK05yZS9HVDFsNDRIRWlJS1hQ?=
 =?utf-8?B?S1Z4bUw2MEU2aWtnZnFOeU1CRjRYekY0UjhHamFlVjhxbURjamNIVVQ3c056?=
 =?utf-8?B?SjRWcGxMWU9KZWFraVM0T2hMVkNSczh2c2tYQjcwYzczVjRoYXkxZnJYdXVN?=
 =?utf-8?B?eWRMQVM2ZXJrbmpOR2RDZm9jd2tVSW1HR0JXMnhEcFVOcHBCbk5EV1lPL2Vs?=
 =?utf-8?B?K1JINmMvSGxPamZub0FnR2d5SW0wSTJWZUthWmEwS0hQMjRucFJuekt1NmUz?=
 =?utf-8?B?TE5vRm42eERhS3lLaWd1NjNBZ0hmaWtzclBVd1J2VzlSVXNIeFZCcDVHQUlP?=
 =?utf-8?B?V3JNVzZTRERkVlhLWWltSmhYMHpqTTZyK1ZZZUpjTWtYdkZMc1Z4bWZFSVVG?=
 =?utf-8?B?NGNRQkkxNytkaHoxZGpubVlmMFFoL1l6NVdTVHdSeUV0ZVU0YVgvcGJuMk5I?=
 =?utf-8?B?M2FMR0tkZUZWeTNIdnY0b3YrMHdPTjdpR1MySnI4VHJCbTZkaUttQmdobGJF?=
 =?utf-8?B?cTVDb0ZneDdGSDRDU3BJQnl6TUZrOEt4ZFl1V1FHUnJPa3FkZHZOZGtjQW5U?=
 =?utf-8?B?YWh6dmVaejRIbVZwOXhWaVpXc09oZ2Z2bnpPRWxTc3Uvek9UeGJZMjBNWVlv?=
 =?utf-8?B?aWFRRE5ZNFJZYnB1Ni94L082RXlEOVdnbkQrY0NPWm9OT0g2RlJSWHJ2UFBB?=
 =?utf-8?B?bTN2djJIdHJ0cmpqQVhpN1lkM3k3L1c1cG5DV084NEJBQjRhNmxKNEN0Rjhi?=
 =?utf-8?B?NzA4N2pZRksvbmd6cW9tYU4vdFFLVFJXa2g2S0oxU0VkckMyb2lKVDF2dmxK?=
 =?utf-8?B?b2pFc0t4NUJlRU9PWDYranVYSjNKaW9MY0tsQkN4UThpblRqSE1pN0FrMnMw?=
 =?utf-8?B?Y2JxN2diWTBUUmlIRUtFWk1WV2llU3U2UVhyRWlhclQ3N2s3OXNnNGkzb0pp?=
 =?utf-8?B?b21QbkpYV0p2bUJhZk9lRVg3RUVaKzNwb1hMbXN5NHVTQ2piMC9GNHJ0WExk?=
 =?utf-8?B?Z3pRbmJkZ1c2cWV0bmZjZmY5aFFYaEIzWG8xQzcwMjBEbXI4Y3p0RS93UUZI?=
 =?utf-8?B?TzMxSHYzSGsyK2NxajJ3Vzh5dWVkMDZkTVowb1Y2VFk1OFFza3l4ek8rZzEv?=
 =?utf-8?B?NGdUQWZUNmFLeW9keC9pZjE3Q0tCb1lTQzlHOWZZbUpzejN6L0NyQVpKSHJt?=
 =?utf-8?B?QjNiUldJOGpoTE9UZEtxSW4yWEUvdkt2b3pMM3VsZm0yMUZYaTVWdVdTaUd2?=
 =?utf-8?B?MzRmK3Zoc29yL2tqODVzZndiYkdjN21WK0FKOGsxdmJmL3pESldpS0gzc2RF?=
 =?utf-8?B?b2RhaTdxSFYramg2YWlkTDNocTdycEtQTGFEeXBxenJvTXFCeWtZRk1pc2Fz?=
 =?utf-8?B?OXJBWk54bHljL1RIUHFNSjZDSHdySWhOcjlFSU1haUdsbHpmanhvNVZldHdy?=
 =?utf-8?B?VjNxL1pOcHpYMERBSWFLZVJtOSsrQ3AzYTYrZDFiSVZEZXJYQWp3Tk1GMnFM?=
 =?utf-8?B?d0I5dkFHN1gvTlF3Rm9FSVdITW9FWE5Ob2VDeHZsTlk5TWxuQTBxMXorQTdN?=
 =?utf-8?B?eUFyYWJVQlQ1ZkkrUzA0Q2FZRDVTNG9BaERVbHBZTEJxditNdEdKZWUzY2c1?=
 =?utf-8?B?YkNCZFRMM3dGUVFPczc4cE96VFhNQnBydVR6RGlWcEd4ZTBISjVlQjhNajND?=
 =?utf-8?B?alRZbTJRQUhFOE5PcjNZV2lVVlBqUGd1aWNjOGg1OGxaWTZJcUNIVk5jV3Uw?=
 =?utf-8?B?Ym1ERjN3MWdSVkxENnZjeC9iQ3VaaDVkSmMxZDQwd21PbmdwaDdpM052aTYw?=
 =?utf-8?B?UzN5dDdaZjF4OUZObnFnS0psWk9uYlpKY2tPZE9wRFpuenB4QWdGUTdHekg3?=
 =?utf-8?Q?jbW55Pzb40itwmtMwnFthA+P8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EB602178DACE94799F7DC655F594673@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643d404f-1337-4396-ea10-08dbd4597efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 06:21:45.0418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xnlNJidKthXgGEWpEiJ0MN2IMSMfoUAle5wubxPrqsLpf5GESzNSv+yJRSmcI+/P+iW5ebAbF7rONg36vbHCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTMvMjMgMDk6MzQsIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IFRoZSBmaXJtd2FyZSB2
ZXJzaW9uIHN5c2ZzIGVudHJ5IG5lZWRzIHRvIGJlIHVwZGF0ZWQgYWZ0ZXIgYSBzdWNjZXNzZnVs
bHkNCj4gZmlybXdhcmUgYWN0aXZhdGlvbi4NCj4NCj4gbnZtZS1jbGkgc3RvcHBlZCBpc3N1aW5n
IGFuIElkZW50aWZ5IENvbnRyb2xsZXIgY29tbWFuZCB0byBsaXN0IHRoZQ0KPiBjdXJyZW50IGZp
cm13YXJlIGluZm9ybWF0aW9uIGFuZCByZWxpZXMgb24gc3lzZnMgc2hvd2luZyB0aGUgY3VycmVu
dA0KPiBmaXJtd2FyZSB2ZXJzaW9uLg0KPg0KPg0KDQp3aHkgZGlkIG52bWUtY2xpIHN0b3BwZWQg
dXNpbmcgaWQtY3RybCA/DQoNCi1jaw0K
