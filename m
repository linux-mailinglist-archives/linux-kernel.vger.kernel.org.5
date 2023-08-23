Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC58786058
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbjHWTJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjHWTJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:09:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5974AE7B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 12:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3u6PGNCes07SO37VaW8v+fgD1/8pYyB5NcBo3eJfvhwdVbbWxI6RwgVO8P7+zBvLX6TBULlIhS52lVEYFArdUMo6ApeLNNGTUVgO4GBaLDgxPBeyGw2sUJR5xrmJj0dKa/oPzDgHY2iN/6hSYPDR9MEN/tzwJl0WwqC2Qomb/7rqn1nVAq1Az28suy8yWbvlXQA+BVIU3Ed7zkSgtZFbRfNphCimsAsWamxdMOwPywbCgX5lQH4pfptccZK7+Wo0oGmEOT/OIFSxU23zPWbnmKUhBCrfOxY0oDQwnWiacjJXVcb2YU2IXfg7YPw+W725HptMjEilUfIGFl16mQc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huTC24RO+XN4utRJJ8fnrKra9qH8sJeFA2xVHfgLUsY=;
 b=idegWGKGlBa+84jmy73J72+Yhf243W/EymtEKd2Gud2326YNp4Br7+whhMHFigDcRlUFjgJfhNxn20NNZmO9kYeyf/aQAEoMtQKxS7oNXRvRMxSNwT8dJY0TdAAGh12YYvxxedKXngyAy0I/4GlZOhXP6UkOAzj5Pod3OmxHkVK2O2Of+fegr5ZZJIIP9r0VbuQ+FFURQVVYIuCaPNq9lgLFW+anZah5l+NCrKUq9wolHpxz/0bJr5rqZkaAHgplo8pCPE2HYgshh9qlcSJLMkhVhMt4oYbTxD1BjWonBb6cOfozihCRkf90lgYIvFScqliaksonVEFs7SleXnJO7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huTC24RO+XN4utRJJ8fnrKra9qH8sJeFA2xVHfgLUsY=;
 b=DZtzqBqod9zQOnA+Hnp0alxkqQIY+xO6RrTyOw3g1Qy66htkzZe1IAnL4bw12nBjcgC0VYHs8LNwfQjsGgIjkISiM5ok78lzQADQAuC+xTP8F5wFdUbaJR85CHSLl2N0HxofogoKovjFD483YMGiAw2Yq1iExPxoO77RYbsdKDE=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 19:09:16 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c%7]) with mapi id 15.20.6699.025; Wed, 23 Aug 2023
 19:09:16 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Alexander Kamensky <alexander.kamensky42@gmail.com>
CC:     "bhe@redhat.com" <bhe@redhat.com>,
        "piliu@redhat.com" <piliu@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>
Subject: RE: kexec reports "Cannot get kernel _text symbol address" on arm64
 platform
Thread-Topic: kexec reports "Cannot get kernel _text symbol address" on arm64
 platform
Thread-Index: AdnKK79OkD4zpG4kTFa/kOe2Uun+RAAOxmsAAHwHDeAAlUzuAAFfZ4gQACCkigAAUgkXYA==
Date:   Wed, 23 Aug 2023 19:09:16 +0000
Message-ID: <MN0PR12MB59532ABFAF131AC84F36B73FB71CA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNL14lnrHvzbpRQu@MiWiFi-R3L-srv>
 <MN0PR12MB59535434E071499DDE439B08B710A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNogKKZCp12Q92jh@MiWiFi-R3L-srv>
 <MN0PR12MB5953FFB655A208BD4FA32EE4B71EA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <CACBYKvRJL_WmZUN7BH_TjxX+TC2O1gjsudkh1GtRyB3WifjMJA@mail.gmail.com>
In-Reply-To: <CACBYKvRJL_WmZUN7BH_TjxX+TC2O1gjsudkh1GtRyB3WifjMJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|LV8PR12MB9135:EE_
x-ms-office365-filtering-correlation-id: dffc520f-4b58-4d2b-a0bc-08dba40c71f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aNceqyjktYQ1GfXHbjG0oRhRFBJnPiYsyxBdk0GvVsIiTD5nX+I2wKtLJzoA1DrBNoeDHXXwUw8AJrL7nG1yChlPFJ2leX0RYUshMSK/tsnyNKOVCIfL4hGc6BqrU/rgaJZ+dErd4cqzSKyrmPof0mzMx/XdZjck5wEci3OW6KN/sgT/d/g23U3GnqF+GTGITebbLSNMbjMWPObzX7/WW2YcUkXTT0DOFg/0lVTWLuPDvwv7pRmPmKPvxdWjARveK9f6FN4kcf0WfZglnH10DtHzrKtAu+07khe/tt31vTTqfSEW11/weeeboF7YMI3WOsBMfJjv8SAUbGxkUfGAl6q9NQuWS/GcHPBrBeLXEUpsvp9jTV5ve+69gmvtZ0k57JyclZNh/QyXHZZMGw4Q9x+Ne96psm8OMZrbFxtatBbYvvr4eYWdj+hRukklTKnE8H45qQz4sNH3Ef0rPJAiMpCV+sWvSqUUrCiIhDV3YaYZTYX5mAUrQPfI08C1aNv8zIDFGVEG0/DJ6uDtMEViJRy4COeBK5a+F5jb9tlkj68S7JS97PI4Rh65lwjtxQrCyOSzD6gZwBnbhk9sww/NaVAd0pxaLC/ugx3BgC+909A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(186009)(1800799009)(451199024)(7696005)(6506007)(71200400001)(53546011)(9686003)(83380400001)(38070700005)(122000001)(33656002)(86362001)(38100700002)(55016003)(2906002)(316002)(66946007)(66446008)(66556008)(6916009)(76116006)(54906003)(64756008)(4744005)(41300700001)(66476007)(5660300002)(8676002)(52536014)(4326008)(8936002)(478600001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b09McXFRa016dCtUMzdhMVhlSlRzUUlBdkt0RndxQXg2QVV4OFh4UkpRMk55?=
 =?utf-8?B?d3VHSnBpT2J0YndLRml1NXJlSlFrdmgrdjBMS1JCWmVKT25Vem10czFIRGxU?=
 =?utf-8?B?ZGZPM1YxMlp4alA4NXFKakZkbmN6VEhaNHBPcDFOcVdOWnJjOXMzVkF6K2xV?=
 =?utf-8?B?ZWZ0UXg1TkE3elFjTkxUK1FOVS9VLzFxYzJZTFgwZmpVRmdMSTdJOVZyN25q?=
 =?utf-8?B?LzJhZWdTb1F3RHF1cHMyR3RnMEZmU1BZemhISDhPV21wMjB0eDVhcnJ5TVRw?=
 =?utf-8?B?NEtTbUJUNThsbGpjSEQ5bi9TMndReVR1bGthWW1PVjVTVmFKaXJvMGdOaWtK?=
 =?utf-8?B?cXFpUEZ1dUxOUWIyY2d6cTEvbi91VEsyRkg3OHpuNmVMYUN0Q3p6T2VzVnhq?=
 =?utf-8?B?NlB0K25yUWVFWEFRU3lSUForbTh0d1dzTkN6T3g0VEsydW1ldGhEMEFNaExL?=
 =?utf-8?B?YVpmSWVsTGpCUkQrYjM0UzhtNzk4UlcxdlltbzZ6eTdNUXBDOW92U3dCRndI?=
 =?utf-8?B?MWpITHZIb2tIK1J5TElPSFcxL1NqeEg4bW1rdGV4UXNlUW01SlVaalFPaGg1?=
 =?utf-8?B?aU50TXJDUFRrYnV2ckxxN2NJeVhWSGVnN3h0aUF0OWV0VE5RbXFCM1I0TVY3?=
 =?utf-8?B?V3VvSXRzQmdWNDA5U0NBRE1RZHA0cHRmYXE0QzErK3ZKeWg0SjBxd3ljVzR5?=
 =?utf-8?B?My9DRjRzZGEyQzNZY1FzcGJ4bXE3QTdtQktodmJJa09Gd004c2lOUFJyY2FY?=
 =?utf-8?B?VGtBU1kzS2txY1lLSS9QZTlzeVRhbDQvZVZWVkhnTlp3RzMzdzljQjFrcG55?=
 =?utf-8?B?czkzR0dCYlFUNUpLcXFxb2VKd0hhQUpWMHNvc0lNemNUc0taSklEYkw2Y2xJ?=
 =?utf-8?B?UEVLTll3aTQ4aDYvZ2dUR2dTWUExeWVEcXRMdzZaNTRKK25kMjVrcTE0aW1Q?=
 =?utf-8?B?R25uREFsM0F6dmE4bUFyWUlkSitLT3Fnc0ZnMktaNURXWHF5RUVRS3BrMERZ?=
 =?utf-8?B?bWMwbStqRHZIb2dGN3BldXZxQWN6dWUvd2FxQk9BQm5yTHdVbE5pZjhRb2Nj?=
 =?utf-8?B?cGhtZUc1WmVDdXEycFd4S2c3TTh2clA0LzlsSjkvdy9maWp1YjdaZkFUbFky?=
 =?utf-8?B?QkNqZ1dWSVY2NkR0LzgyaFlBR3p3amVGek5xck84OEJxZ1FsMjNOUjVFMW1W?=
 =?utf-8?B?R1p0TnVockdPZlJFaU5zRmpoRFNMUjk3NTYyN2FkelQ0QWMxZFZ0Y09QOXgw?=
 =?utf-8?B?MjkxUjZ6amRjZEh5ZVhncnJwdEdEZlY1WXEydEk1QkcwQ2dOcEhvUERKWkFR?=
 =?utf-8?B?QnpHNDVYZ0VUQmc2UlVVSW5xM0MyRDFrRU9lVW1xTnhMTnhXaEMzVWYyMERI?=
 =?utf-8?B?anhkSXhyd2V0RWVrVDdBc05NRU9rOGVOby9kR1NGakM2bXlTd1hobGx6YzRu?=
 =?utf-8?B?N2M2b1VxaVpzQzgyc3pJT2I2OXNjVmU2L0xseXpKMTFWVFZQd25CTTZHMWli?=
 =?utf-8?B?UnJ0RE9VQ04wdXVVUEh0RkZibnRvanN5MVpLazZKeGhBdHpVNGY4c3B2TkMr?=
 =?utf-8?B?cUVQdEorUWRETVdrNWNiWGxYTWtBSENTelBpS1ZsMXdzMXJadU94ZjJJanpM?=
 =?utf-8?B?K1VEb2xsa1FNUktTdlhtdnNsZHZyYzdvM1JQckMxVUN5QzFtWU1xamJQVlhX?=
 =?utf-8?B?S1R6bmZxdi9sV0l0SnQyTmxpakxhc2syZnhONDE4UDNrcy9OYW1SUWxSUGF0?=
 =?utf-8?B?ZDVqVUlYcWN1aWRhdkJ6dzA1YXNRbytpa1FDWGZiN29PYkRxcnVaSGxTbzdU?=
 =?utf-8?B?SE1BUjZDd0xDQ1A5Y3ExQTJVdmdCbzhxbXRVaER0dlVVODlqcTRDVjd1RE1l?=
 =?utf-8?B?RUJSdUdmZ0oxcndaVkhCWHNsekp4eWFmeVBxZ1RmemJKSm9sQmhHWTI2am1Y?=
 =?utf-8?B?UitOUUpOeFVPV3ROcDFSWXEvc0l0NXRJYWJkSjJ6RnFJUFNYdlp4OG5XS2Z5?=
 =?utf-8?B?ZlhaTkN3M2tXUTQ5Z1RqTkhPMVI0eGhvR3EyNWY5bDhwY0hVdHlUNXR6c1pH?=
 =?utf-8?B?S0E5aUxQQWtBaHVuYnNDWktnNlN1Sms2ekJIaVhxMmIrUTMxcXpPUmJyeCsz?=
 =?utf-8?B?aWpDRHNIQlBXT0lpYzYzQktZd3BIbWlGdmh4cno2MVVxSkRQLzRTaDgyMG1s?=
 =?utf-8?Q?etlM+pPb+whkRce89HN471w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffc520f-4b58-4d2b-a0bc-08dba40c71f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 19:09:16.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApKtqKpuab47zx2ya5uA0KEiTx6pubG6Q+DuqHBhMHLx01K2zxp4n89+/g9U9oRm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgS2FtZW5za3kg
PGFsZXhhbmRlci5rYW1lbnNreTQyQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0
IDIyLCAyMDIzIDk6MjQgQU0NCj4gVG86IFBhbmRleSwgUmFkaGV5IFNoeWFtIDxyYWRoZXkuc2h5
YW0ucGFuZGV5QGFtZC5jb20+DQo+IENjOiBiaGVAcmVkaGF0LmNvbTsgcGlsaXVAcmVkaGF0LmNv
bTsga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IFNhcmFuZ2ksIEFuaXJ1ZGhhIDxhbmlydWRoYS5zYXJhbmdpQGFtZC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBrZXhlYyByZXBvcnRzICJDYW5ub3QgZ2V0IGtlcm5lbCBfdGV4dCBzeW1ib2wg
YWRkcmVzcyIgb24NCj4gYXJtNjQgcGxhdGZvcm0NCj4gDQo+IEhpIEFsbCwNCj4gDQo+IFNvcnJ5
IGZvciB0aGUgdG9wIHBvc3QsIGJ1dCBJIGJlbGlldmUgdGhhdCBJIG1pZ2h0IGhhdmUgcG9zdGVk
IGEgZml4IGZvciB0aGlzDQo+IGlzc3VlIGEgY291cGxlIGRheXMgYWdvLg0KPiANCj4gUGxlYXNl
IGNoZWNrIGFuZCBzZWUgaWYgaXQgaGVscHMNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva2V4
ZWMvMjAyMzA4MTkxOTExMTkuOTc1Mjk5LTEtDQo+IGFsZXhhbmRlci5rYW1lbnNreTQyQGdtYWls
LmNvbS9ULyN1DQo+IA0KPiBFeHBsYW5hdGlvbiBmb3IgdGhlIGlzc3VlIEkgb2JzZXJ2ZWQgd2l0
aCBhIHNpbWlsYXIgc2Vjb25kYXJ5IGtlcm5lbA0KPiB0cmFjZWJhY2sgb24gYXJtNjQgaXMgaW4g
dGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpJIGZldGNoZWQgbGF0ZXN0IGtleGVjIHNvdXJjZXMgKDc3
N2NhNDUzY2E2OWU0NmY3Mzc2YjA3YmE2NzI3YmQyNjFlYzk3ZWYpDQphbmQgYXBwbGllZCBhYm92
ZSBwYXRjaCwgYSBiaXQgaW1wcm92ZWQgYnV0IHN0aWxsIHZtY29yZSBzaXplIGlzIGh1Z2UuDQoN
Ci8gIyBscyAtbHJ0aCAvcHJvYy92bWNvcmUgDQotci0tLS0tLS0tICAgIDEgcm9vdCAgICAgcm9v
dCAgICAgICAxNS41RyBBdWcgMjMgMTg6NTUgL3Byb2Mvdm1jb3JlDQoNClRoYW5rcywNClJhZGhl
eQ0K
