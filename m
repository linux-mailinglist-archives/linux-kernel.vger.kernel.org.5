Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FABF80E434
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 07:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjLLGQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 01:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLGQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 01:16:40 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5FAC2;
        Mon, 11 Dec 2023 22:16:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHvRJWyE7m56yy8vFbUbYNMzzdBiep2uhxsaD5uOMQJ4s0kL3O2As7QO5dz/81Ik5VJi66z6cQP8TQFQZyeC37epSXQF+lwAY+2YMslxS3ppbwxuXP2QVG4YT5GQBZQubmQtOgef+UBamiQCrjxsMI6UFHGnc2+itbkfLDNzYa1YLBvLZfPZsdp8E+dW+IezU6YlhmAgBIEq2JV8AHgm5KbNytOP7bxnAqVZYnVWrFZ9dWKfA/8HgL7NpBnRkZSvEFYBal4T76FqRqx89Y/+0Zvc1wL5PvM1uIWR5Pf+sAKcmOulyoeYLoSLB68gCPd+6fJVRCFNf03qf9i8F1YCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZt1aJ83eeXdCgeLCnEjAObZER9RlQELiCpJT8sGL1c=;
 b=h9VCMkObJxxITsgl9YX78jKMVXkc7TeAGs9JdeqHkM81UR5pVLQ7pKUiDMYb/626bCozLgER2yTORxVZbcsigmWgncIJgfER+7ewo/idvz1s80hQT0Ysy6VyV+qdn8TbvkuRbpDAGsUaXCSC+2qCvJaDXyRbI6FCytg5VtFmbTJct+JBnOYZI5i7N4tFKAhzweORQdwYra88XNRYhT0K86rybfon/fdG1pFXHFifL8akysTn/mglLSkYDHGSz9dlp0WX5WAUKJcWzum5Tic5JQzJeIugO/TvvKhJUfqd+0Dqz7oJ66N9Eba5qpC80Pm3Lw6IyPzGLpCgf5PlCaiFjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZt1aJ83eeXdCgeLCnEjAObZER9RlQELiCpJT8sGL1c=;
 b=yGcn+tXOAUTzOz4AsvnH7REhE+CEd+7KUGJlGasZIYzsfw6S2t4JmVN/GjWQOc8HsUm5B1t36fWM2ruxZ+2rTUIsdB0NliX+ywBHjqTfLZcvAvRoZdGp2tex16YddOah6D2nHnTlUpSC83xayJZcCF1jDojVfUPOfBksm/7REsM=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 06:16:43 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 06:16:43 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Stabellini, Stefano" <stefano.stabellini@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Thread-Topic: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Thread-Index: AQHaHsGdlNZnjmvNCkucW725DqxYz7CSRC+AgADLdgCAALwOgIAAX9AAgAE42ICAA5dDgIAAxsiAgAC4TACAABRoAIABzBGAgAf5bQCAATuOgA==
Date:   Tue, 12 Dec 2023 06:16:43 +0000
Message-ID: <BL1PR12MB584997DDE6839F2340022976E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop>
 <ZWiyBP4Lzz5lXraP@macbook>
 <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
 <ZWmgJNidFsfkDp7q@macbook>
 <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop>
 <ZW2ptexPQXrWBiOS@macbook>
 <alpine.DEB.2.22.394.2312041413000.110490@ubuntu-linux-20-04-desktop>
 <ZW7rDjjC0gxEI1cq@macbook> <15275706-5c31-4e29-aa29-9f5e90526219@suse.com>
 <BL1PR12MB5849C871B0B9577D1E0BF576E784A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXculMdLgwGaRC7i@macbook>
In-Reply-To: <ZXculMdLgwGaRC7i@macbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB6556.namprd12.prod.outlook.com
 (15.20.7091.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|CH0PR12MB5369:EE_
x-ms-office365-filtering-correlation-id: 3c1938c9-9488-43b2-23f4-08dbfad9e97f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ee8WHIh7P2rLv647ruPHkF13E/Qh8/8pxZjt1hI5ubTfrRGRD6EE/y6vDydDkjAk/bUTXqdZm91nvZRDNYxGaxAAObhP6scXaXP9YpO7dEjfWN9gmctsXInS059fQd7sutVorUDKml4dkJGFKCfD7xcjRAHh3YFZRGW2/cc6YgrJ4/RCkAlA6L8BK4POXGAjJPKJi4msQMFiEEaLgUXgn50lbSgybp/CfmfueGaJfWJKB/4qBfcyE2PwBcdqqUxs2SvdwD3QPyeeTqgUW7RBGCfn75m/0XqhhDmfjI1iviyW6wAz4pVKz5tYIjVpE8JU/soi1/2OCFCBGNP8JEg1PEBK9zfvIZRlKueM6hFGLCOFqpxZKBkX3/GrQu6rU3Ok/h5OEmUkTWKHUvS60MyAabmTUcSxkE5nlKi5Rki2J5DblAG1YTs0i4gN0e5+HU6DflQ1ItQRXmJSXuQr2/Ca8TjXSuv9H5W3jk6isnl9mbXootFbKjPzt3LIFuivMV/mM1HKKXORRiD+RvtTW/O3BnLvc/mycD5TjxZmbNCFDV7E/C7Za38aFKORjRXsGW3aanCz2qnXlTeZUhixAV+1ik5/tweKaeXY9gpcVNDB6PLwe3w4J9hkxkxFGx6o6Unm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(122000001)(83380400001)(4326008)(316002)(8936002)(8676002)(7696005)(53546011)(9686003)(55016003)(26005)(71200400001)(6506007)(66446008)(66476007)(66556008)(64756008)(54906003)(76116006)(66946007)(110136005)(5660300002)(478600001)(52536014)(7416002)(2906002)(33656002)(41300700001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czhWVXpPd1dScjAyaFljMjBxOGVOQTN6LzVUZitrblFzWnZ4TGEzNUlubnNZ?=
 =?utf-8?B?WHpOZzcraEpKRXNVZllKRS9VbTVtcXJmV2tOSGNBY242aE0wN1hoQ1dPcERD?=
 =?utf-8?B?dEVmcE5FWUFIVHZtdCt3MzVNczdtdFdFUmM0YU8zZXgzUmtObGpBa3BhWUZL?=
 =?utf-8?B?TmZGNzhhY1FUZFpCd3g5Z2NEZUxGMFQ3Wktxek5LV2JCanpXeWJVWUpYa3NB?=
 =?utf-8?B?TGw2em1zaTNmZldSVHhmTHQ0YUNnWFFKV3lHbHNHR1BVdEZXVWprZUcvVm1E?=
 =?utf-8?B?WmNUVG1NZWxScktldjBUeDg4V2tzcC9RZTRBTU1ONEtFZUpJWHhkOWs0WkY2?=
 =?utf-8?B?U0JoWlMwR0JQbjJNZCtHZzNTbGI3a2Q4RCtHZ2k5Ym1yRUlGcVRoV3JsVjRB?=
 =?utf-8?B?WTVvTXl1MzdNOG1IdG5WMWZLaUk0b3RLaUxzZVp2LzFBNzhiejVQRXRldWRQ?=
 =?utf-8?B?QXlpYjVzSlNNM2lJNkswc0xzMlp6dC9QT2Q5N1JvYXZmN1p5NGtOMkQrQlFz?=
 =?utf-8?B?NmVQaUIwbEI1a1ZXTGU0LzhQQzduT2d4bDh5VzJTV2FyRGQybjFHczhLUm8r?=
 =?utf-8?B?NldQdU4zTk1xU0FxcEZFREtBRGFJRmcxN3dmcU56UnJJYWJ3NHpzYWRQTHNX?=
 =?utf-8?B?Q3htNmYzNDN0TTBCMlEydCtiR2RjYStsdXJpa05jajd3SW5XUjVicERWOGll?=
 =?utf-8?B?M1hyWFlNY2UyclJRMEtaU08raUZZOUpJdWo2M0hzY0gwS29Cc3pMMGJySEdz?=
 =?utf-8?B?a1YyeHF6dy9WM2JtZVo4TlVkUXZFQW5SeTFWN0k4TWVqbUljcFZaQ3JJcWU5?=
 =?utf-8?B?ZFg4SlhBRVVzclk0OHdoQ3hVS3RVTHB3aFV1YWxFNFJ4d3JMWEZpakZrQ1By?=
 =?utf-8?B?MmFLTFBCUUpKek4yUk9zeDFUV3N0MlJxOFQ0NGlnRDNyL3Brbll2eGNnVVB2?=
 =?utf-8?B?QTAwYWJKdDBqcGFGY0JBU2loVXVpaGRDdFpNdHc1MGtkMFNNMHpIKytVUEVN?=
 =?utf-8?B?RkY1YWFZWlBEWVR6MlpYSTB1U2ZyRTl2Snl4ZXlBUU93N1l3MCtwNzZuTTZE?=
 =?utf-8?B?aHVLL0lxSkJPQkN1Mm1Ta3dvNTlqRGZYMDFjQ0VyQ2JYbnpCa0tHcWFoWnZ6?=
 =?utf-8?B?d3dKbTE2Mmd0SmpNOUpsS3pCRm5iZ24xWDVnZjIyaDQ2V2oxZmZPZnJadHN2?=
 =?utf-8?B?Zm5QdkFwTlMxNDRUWGtDOThmbWZZUmlvMmpvdlZTUEp5azZZeG5WMHRzcmdN?=
 =?utf-8?B?S0s1YXUwUGd0Z25nVFBNQXlidzhxblhEYktnckFKQ25ieTU3a2pUK08xWWdP?=
 =?utf-8?B?Yk1MOUlabU4zWmw0dVZjcldTQzdRWkhscThheFkzclRFYTBnVXlUSmhVcGtP?=
 =?utf-8?B?N0Jxd2t0OTNoUTF3ZGZYTFYzWVVIT0RLLzFFL1pTazBBQ0pyNUJ3SmZXQ2NQ?=
 =?utf-8?B?QUNIYmkveVRORXowMDM3S3d1SUxFa0dIWVRkSVFBb2VIVE1NOE1IZ1FxMXpM?=
 =?utf-8?B?Z29oTmg5Y2JKRk9MZkx3a1RZdmc3N0NkdnlyNFNuTGEwcWpwYWROTkREbzQ2?=
 =?utf-8?B?OUExYW5UQWdDWGdPby9WMXlOT1NrMTVXQk1ZckU1dzM0djNyQXVYUnVFRmxZ?=
 =?utf-8?B?dmNvYVNYTlJoQ0FZam1uVzhqbUdiaXR6R05oVkxMbVQzb0c2ZWNIcVlQTGpM?=
 =?utf-8?B?Q2x5SkRqeUpSaFVsalA4VkJEYzMxOVhnZjVveFZLcm9ENVhpQ0NJdUQ0dFk4?=
 =?utf-8?B?a1BWc0FxVjB2c1RCbXBoVWdCNU82NjVpbzdDUkUrRnBicDBpU2Z3SHFFNDEy?=
 =?utf-8?B?SnVpSXZ5NFRDTWd3N1llVklWTzZ6c2xoWlI1TzNHelhqNk9DVjRuRnQ1a3Yx?=
 =?utf-8?B?Z29yWHJUNzJSK3hGeHI1TlZSaWhyajhqMDZBZTFBUzJwUGJBcmprSS9lTTlW?=
 =?utf-8?B?dWtTR3NHOVhSZFM4N1lCUEpqeVpWQkg4Ly9OSC82aG5TTnQzTjJsd091dmxC?=
 =?utf-8?B?TytBSmduRDRlVE1nTTFzbndJVDJQeTg0ckFFRzRXWHIrUjNSRURrbVE4ZExh?=
 =?utf-8?B?ZnNUaHUwelVSc3d2TS9WbzNBZGpHY2RBTm5mdFdobnJvS3pBRTRrZWdZYzNG?=
 =?utf-8?Q?aqho=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A45991944601454F814DEAC002231D69@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1938c9-9488-43b2-23f4-08dbfad9e97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 06:16:43.4704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2YfgWXfLS919SCZO78tzPl3F3NrNCLO9s8Q/LTHkBbuN1Qu/VgenNrPhVtvrZ0CkSK5i9c35EnUUAlFScaXGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMy8xMi8xMSAyMzo0NSwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4gT24gV2VkLCBE
ZWMgMDYsIDIwMjMgYXQgMDY6MDc6MjZBTSArMDAwMCwgQ2hlbiwgSmlxaWFuIHdyb3RlOg0KPj4N
Cj4+IFdoZW4gUFZIIGRvbTAgZW5hYmxlIGEgZGV2aWNlLCBpdCB3aWxsIGdldCB0cmlnZ2VyIGFu
ZCBwb2xhcml0eSBmcm9tIEFDUEkgKHNlZSBhY3BpX3BjaV9pcnFfZW5hYmxlKQ0KPj4gSSBoYXZl
IGEgdmVyc2lvbiBvZiBwYXRjaCB3aGljaCB0cmllZCB0aGF0IHdheSwgc2VlIGJlbG93Og0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2aC5jIGIvYXJjaC94ODYv
eGVuL2VubGlnaHRlbl9wdmguYw0KPj4gaW5kZXggYWRhMzg2OGMwMmMyLi40M2UxYmRhOWY5NDYg
MTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2aC5jDQo+PiArKysgYi9h
cmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2aC5jDQo+PiBAQCAtMSw2ICsxLDcgQEANCj4+ICAvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gICNpbmNsdWRlIDxsaW51eC9hY3Bp
Lmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L2V4cG9ydC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9w
Y2kuaD4NCj4+DQo+PiAgI2luY2x1ZGUgPHhlbi9odmMtY29uc29sZS5oPg0KPj4NCj4+IEBAIC0y
NSw2ICsyNiwxMjcgQEANCj4+ICBib29sIF9fcm9fYWZ0ZXJfaW5pdCB4ZW5fcHZoOw0KPj4gIEVY
UE9SVF9TWU1CT0xfR1BMKHhlbl9wdmgpOw0KPj4NCj4+ICt0eXBlZGVmIHN0cnVjdCBnc2lfaW5m
byB7DQo+PiArICAgICAgIGludCBnc2k7DQo+PiArICAgICAgIGludCB0cmlnZ2VyOw0KPj4gKyAg
ICAgICBpbnQgcG9sYXJpdHk7DQo+PiArICAgICAgIGludCBwaXJxOw0KPj4gK30gZ3NpX2luZm9f
dDsNCj4+ICsNCj4+ICtzdHJ1Y3QgYWNwaV9wcnRfZW50cnkgew0KPj4gKyAgICAgICBzdHJ1Y3Qg
YWNwaV9wY2lfaWQgICAgICBpZDsNCj4+ICsgICAgICAgdTggICAgICAgICAgICAgICAgICAgICAg
cGluOw0KPj4gKyAgICAgICBhY3BpX2hhbmRsZSAgICAgICAgICAgICBsaW5rOw0KPj4gKyAgICAg
ICB1MzIgICAgICAgICAgICAgICAgICAgICBpbmRleDsgICAgICAgICAgLyogR1NJLCBvciBsaW5r
IF9DUlMgaW5kZXggKi8NCj4+ICt9Ow0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgeGVuX3B2aF9nZXRf
Z3NpX2luZm8oc3RydWN0IHBjaV9kZXYgKmRldiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnc2lfaW5mb190ICpnc2lf
aW5mbykNCj4+ICt7DQo+PiArICAgICAgIGludCBnc2k7DQo+PiArICAgICAgIHU4IHBpbiA9IDA7
DQo+PiArICAgICAgIHN0cnVjdCBhY3BpX3BydF9lbnRyeSAqZW50cnk7DQo+PiArICAgICAgIGlu
dCB0cmlnZ2VyID0gQUNQSV9MRVZFTF9TRU5TSVRJVkU7DQo+PiArICAgICAgIGludCBwb2xhcml0
eSA9IGFjcGlfaXJxX21vZGVsID09IEFDUElfSVJRX01PREVMX0dJQyA/DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFDUElfQUNUSVZFX0hJR0ggOiBBQ1BJX0FDVElW
RV9MT1c7DQo+PiArDQo+PiArICAgICAgIGlmIChkZXYpDQo+PiArICAgICAgICAgICAgICAgcGlu
ID0gZGV2LT5waW47DQo+PiArICAgICAgIGlmICghcGluKSB7DQo+PiArICAgICAgICAgICAgICAg
eGVuX3Jhd19wcmludGsoIk5vIGludGVycnVwdCBwaW4gY29uZmlndXJlZFxuIik7DQo+PiArICAg
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICsgICAg
ICAgZW50cnkgPSBhY3BpX3BjaV9pcnFfbG9va3VwKGRldiwgcGluKTsNCj4+ICsgICAgICAgaWYg
KGVudHJ5KSB7DQo+PiArICAgICAgICAgICAgICAgaWYgKGVudHJ5LT5saW5rKQ0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgZ3NpID0gYWNwaV9wY2lfbGlua19hbGxvY2F0ZV9pcnEoZW50cnkt
PmxpbmssDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBlbnRyeS0+aW5kZXgsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdHJpZ2dlciwgJnBvbGFyaXR5LA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVM
TCk7DQo+PiArICAgICAgICAgICAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Z3NpID0gZW50cnktPmluZGV4Ow0KPj4gKyAgICAgICB9IGVsc2UNCj4+ICsgICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICsgICAgICAgZ3NpX2luZm8tPmdzaSA9IGdzaTsN
Cj4+ICsgICAgICAgZ3NpX2luZm8tPnRyaWdnZXIgPSB0cmlnZ2VyOw0KPj4gKyAgICAgICBnc2lf
aW5mby0+cG9sYXJpdHkgPSBwb2xhcml0eTsNCj4+ICsNCj4+ICsgICAgICAgcmV0dXJuIDA7DQo+
PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgeGVuX3B2aF9tYXBfcGlycShnc2lfaW5mb190ICpn
c2lfaW5mbykNCj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBwaHlzZGV2X21hcF9waXJxIG1hcF9p
cnE7DQo+PiArICAgICAgIGludCByZXQ7DQo+PiArDQo+PiArICAgICAgIG1hcF9pcnEuZG9taWQg
PSBET01JRF9TRUxGOw0KPj4gKyAgICAgICBtYXBfaXJxLnR5cGUgPSBNQVBfUElSUV9UWVBFX0dT
STsNCj4+ICsgICAgICAgbWFwX2lycS5pbmRleCA9IGdzaV9pbmZvLT5nc2k7DQo+PiArICAgICAg
IG1hcF9pcnEucGlycSA9IGdzaV9pbmZvLT5nc2k7DQo+PiArDQo+PiArICAgICAgIHJldCA9IEhZ
UEVSVklTT1JfcGh5c2Rldl9vcChQSFlTREVWT1BfbWFwX3BpcnEsICZtYXBfaXJxKTsNCj4+ICsg
ICAgICAgZ3NpX2luZm8tPnBpcnEgPSBtYXBfaXJxLnBpcnE7DQo+PiArDQo+PiArICAgICAgIHJl
dHVybiByZXQ7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgeGVuX3B2aF91bm1hcF9waXJx
KGdzaV9pbmZvX3QgKmdzaV9pbmZvKQ0KPj4gK3sNCj4+ICsgICAgICAgc3RydWN0IHBoeXNkZXZf
dW5tYXBfcGlycSB1bm1hcF9pcnE7DQo+PiArDQo+PiArICAgICAgIHVubWFwX2lycS5kb21pZCA9
IERPTUlEX1NFTEY7DQo+PiArICAgICAgIHVubWFwX2lycS5waXJxID0gZ3NpX2luZm8tPnBpcnE7
DQo+PiArDQo+PiArICAgICAgIHJldHVybiBIWVBFUlZJU09SX3BoeXNkZXZfb3AoUEhZU0RFVk9Q
X3VubWFwX3BpcnEsICZ1bm1hcF9pcnEpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IHhl
bl9wdmhfc2V0dXBfZ3NpKGdzaV9pbmZvX3QgKmdzaV9pbmZvKQ0KPj4gK3sNCj4+ICsgICAgICAg
c3RydWN0IHBoeXNkZXZfc2V0dXBfZ3NpIHNldHVwX2dzaTsNCj4+ICsNCj4+ICsgICAgICAgc2V0
dXBfZ3NpLmdzaSA9IGdzaV9pbmZvLT5nc2k7DQo+PiArICAgICAgIHNldHVwX2dzaS50cmlnZ2Vy
aW5nID0gKGdzaV9pbmZvLT50cmlnZ2VyID09IEFDUElfRURHRV9TRU5TSVRJVkUgPyAwIDogMSk7
DQo+PiArICAgICAgIHNldHVwX2dzaS5wb2xhcml0eSA9IChnc2lfaW5mby0+cG9sYXJpdHkgPT0g
QUNQSV9BQ1RJVkVfSElHSCA/IDAgOiAxKTsNCj4+ICsNCj4+ICsgICAgICAgcmV0dXJuIEhZUEVS
VklTT1JfcGh5c2Rldl9vcChQSFlTREVWT1Bfc2V0dXBfZ3NpLCAmc2V0dXBfZ3NpKTsNCj4+ICt9
DQo+IA0KPiBIbSwgd2h5IG5vdCBzaW1wbHkgY2FsbCBwY2liaW9zX2VuYWJsZV9kZXZpY2UoKSBm
cm9tIHBjaWJhY2s/ICBXaGF0DQpwY2liaW9zX2VuYWJsZV9kZXZpY2UgaGFkIGJlZW4gY2FsbGVk
IHdoZW4gdXNpbmcgY21kICJ4bCBwY2ktYXNzaWduYWJsZS1hZGQgc2JkZiIgZnJvbSBwY2liYWNr
LiBCdXQgaXQgZGlkbid0IGRvIG1hcF9waXJxIGFuZCBzZXR1cF9nc2kuDQpCZWNhdXNlIHBjaWJp
b3NfZW5hYmxlX2RldmljZS0+IHBjaWJpb3NfZW5hYmxlX2lycS0+IF9fYWNwaV9yZWdpc3Rlcl9n
c2koYWNwaV9yZWdpc3Rlcl9nc2lfaW9hcGljIFBWSCBzcGVjaWZpYykNCj4geW91IGFyZSBkb2lu
ZyBoZXJlIHVzaW5nIHRoZSBoeXBlcmNhbGxzIGlzIGEgYmFja2Rvb3IgaW50byB3aGF0J3MgZG9u
ZQ0KPiBhdXRvbWF0aWNhbGx5IGJ5IFhlbiBvbiBJTy1BUElDIGFjY2Vzc2VzIGJ5IGEgUFZIIGRv
bTAuDQpCdXQgdGhlIGdzaSBkaWRuJ3QgYmUgdW5tYXNrZWQsIGFuZCB2aW9hcGljX2h3ZG9tX21h
cF9nc2kgaXMgbmV2ZXIgY2FsbGVkLg0KU28sIEkgdGhpbmsgaW4gcGNpYmFjaywgaWYgd2UgY2Fu
IGRvIHdoYXQgdmlvYXBpY19od2RvbV9tYXBfZ3NpIGRvZXMuDQo+IA0KPiBJdCB3aWxsIGJlIG11
Y2ggbW9yZSBuYXR1cmFsIGZvciB0aGUgUFZIIGRvbTAgbW9kZWwgdG8gc2ltcGx5IHVzZSB0aGUN
Cj4gbmF0aXZlIHdheSB0byBjb25maWd1cmUgYW5kIHVubWFzayB0aGUgSU8tQVBJQyBwaW4sIGFu
ZCB0aGF0IHdvdWxkDQo+IGNvcnJlY3RseSBzZXR1cCB0aGUgdHJpZ2dlcmluZy9wb2xhcml0eSBh
bmQgYmluZCBpdCB0byBkb20wIHdpdGhvdXQNCj4gcmVxdWlyaW5nIHRoZSB1c2FnZSBvZiBhbnkg
aHlwZXJjYWxscy4NCkRvIHlvdSBzdGlsbCBwcmVmZXIgdGhhdCBJIGNhbGxlZCB1bm1hc2tfaXJx
IGluIHBjaXN0dWJfaW5pdF9kZXZpY2UsIGFzIHRoaXMgdjIgcGF0Y2ggZG8/DQpCdXQgVGhvbWFz
IEdsZWl4bmVyIHRoaW5rIGl0IGlzIG5vdCBzdWl0YWJsZSB0byBleHBvcnQgdW5tYXNrX2lycS4N
Cj4gDQo+IElzIHRoYXQgYW4gaXNzdWUgc2luY2UgaW4gdGhhdCBjYXNlIHRoZSBnc2kgd2lsbCBn
ZXQgbWFwcGVkIGFuZCBib3VuZA0KPiB0byBkb20wPw0KRG9tMCBkbyBtYXBfcGlycSBpcyB0byBw
YXNzIHRoZSBjaGVjayB4Y19kb21haW5faXJxX3Blcm1pc3Npb24oKS0+IHBpcnFfYWNjZXNzX3Bl
cm1pdHRlZCgpLCANCj4gDQo+IE90aGVyd2lzZSBJIHdvdWxkIHByZWZlciBpZiB0aGUgZ3NpIGlz
IGp1c3QgY29uZmlndXJlZCBmcm9tIHBjaWJhY2sNCj4gKFBIWVNERVZPUF9zZXR1cF9nc2kpIGJ1
dCBub3QgbWFwcGVkLCBhcyBhbGxvd2luZyBhIFBWSCBkb20wIHRvIG1hcA0KPiBpbnRlcnJ1cHRz
IHVzaW5nIFBIWVNERVZPUF97LHVufW1hcF9waXJxIHRvIGl0c2VsZiBpbnRyb2R1Y2VzIGEgbmV3
DQo+IGludGVyZmFjZSB0byBtYW5hZ2UgaW50ZXJydXB0cyB0aGF0IGNsYXNoZXMgd2l0aCB0aGUg
bmF0aXZlIHdheSB0aGF0IGENCj4gUFZIIGRvbTAgdXNlcy4NClRoaXMgbWV0aG9kIGRvZXMgbWFw
X3BpcnEgYW5kIHNldHVwX2dzaSBvbmx5IHdoZW4gYSBkZXZpY2UgaXMgYXNzaWduZWQgdG8gcGFz
c3Rocm91Z2gsIGl0IHdvbid0IGFmZmVjdCB0aGUgb3RoZXIgZGV2aWNlIHVzaW5nIG5hdGl2ZSB3
YXkuDQoNCj4gDQo+IFRoYW5rcywgUm9nZXIuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KSmlxaWFu
IENoZW4uDQo=
