Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B03E776293
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjHIOeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjHIOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:33:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E412109
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0W4UGODSzYXZp0hxhGETXwD/UywuRjKsx6zBAi/Puwmzy5IOiHbGg/NJa+iioPHta60Wsfz/MuWtxJeyvToK5ey7Kvm7nB3pGgGw//0/znrKfr2jH5yQV3YqyEmNpBq+O6+h3f+ANrBrgANJY4FN4M3QWB3L0BcMnY5CLLqCXANPmibYvEV/megYVdQQT+hz9SjLh/ctwzNoykqm5APRUfqaw48SpBxY80sfbA395xy8hZLCV1ZVkBAo2SLX1bcD1ygEmPwqPihL1mW+kC5NGDajGIcOx72S9T03ArHAS49c7awH3+JzgAv+LkBwMESu3fu/+99BEkpN82oi4hTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSiRIaaEYGsMAdihbxlsSkmQci1fCrHJcond9+hWQEA=;
 b=iozi0pJNnMWdIurrkX1LABXewaNJRLS2ooFa8BUq16PvbZ6B2jMUEBRVBaiwISeX0WfI3wu8j5Osp+dzyIJB32cvBkVq41/WTb763Di9tQxRMhA0zY0w5eOGZWqg6yKqCTimvXqlxzGf8AneeSa0nQpfdwlH5Nd2uxZmQrMcKr/rkJ/G2hnslclakycwo01XbHfv/YQyRNJ8h5ojqq/TVqvrvlbd89J23T45tCi+aVFLq7FN4LnLgV97hWDtMvyLgaXFfa++i8R+kbUIvasmBRqWM0d++OM4/CAmE2lFbMt2HXx2oOelGuqhIplz5PDzTVUiFoJI18vybbI7ltT43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSiRIaaEYGsMAdihbxlsSkmQci1fCrHJcond9+hWQEA=;
 b=jPFFeRFeO2VxMRHVhjFAShdmDoAHa123yiK0mr93qXdIZ7TXjlr6FVtO6Go/4Y1F2JO+iZ4vX+OeY12Az4PPCjq0VpE0ZO3jFUTQOThpmRqkr0iWIP4Mo5IQGLkcdAq6rxSuKxszC8zvIAti3MZ6romKBEDzEaBZX7fFd8IjZlv63Pg2DOaR/cEtT3XLv4kDGXipSeeY+1UgBGHCoWGBnjRkQq7GYQs/xlMpCpxgND5j/gmXI7JcQSK5k698aZKeHMWivTifhBWLacmK55QxlNFQPm8CSRV5+8TSXaFMo98HdjDer/wJEk1ftEci6ze7AcxpnPwum4gA4tQHwhJ3VQ==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Wed, 9 Aug
 2023 14:33:55 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::5fa6:31e7:e6fb:3beb]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::5fa6:31e7:e6fb:3beb%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 14:33:55 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] mlxbf-bootctl: Support the large icmc write/read
Thread-Topic: [PATCH v1 1/2] mlxbf-bootctl: Support the large icmc write/read
Thread-Index: AQHZysv09z4A7zId/U6wjr0G28SOTa/iBDJA
Date:   Wed, 9 Aug 2023 14:33:55 +0000
Message-ID: <BN9PR12MB5381D4AB689C24165F3EE3A3AF12A@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20230809141513.9058-1-asmaa@nvidia.com>
 <20230809141513.9058-2-asmaa@nvidia.com>
In-Reply-To: <20230809141513.9058-2-asmaa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|SJ1PR12MB6170:EE_
x-ms-office365-filtering-correlation-id: 9e83fe9e-425f-4d31-18fd-08db98e5a90f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TbdOYa71IUPAgnI62gTWMmZ0WK3ruAmmUryHh1Jpw9C17Qyevdfn90FfBYt1EOmvb+24TWR6TqwRLUjvuyzpOj6PgX1MxzGpNKYbNSBV6yg/E0rKfSpP4mEeHPrTXMT98hQbbgt5qOC4mCQIhT7CGAcc3E43O2nAa5yMJ/QIK0Bqs8FkU99uu0cBqwzf4U7P4n90Yq2fiDBvEz6hs3gIqwNIZl6pGa0p57HP8PwKwOqZJe5RK69e48ybymwDWYgdRhHQhnukAOsycgQt8OEdGf5B5GzE4QIRQBjGuRjdjmsfQ1S6rn7fjOzn1XNr5s7mH6xpzInKG73Wun4MJ5Zd8EvIt89LzRW1lz4a4KSodI/PoUF6dPL5wUOhhrozP5fwy+BU6IRooUt6yhX3NcWmAn+knrH7s8kyTF/yV5omP77e16cKt47pGnBJfK5nyETZYHhc7+GeN3Y1Rk5OlXkIKvdED96iSvp1g5zcZn5xsasQjJJLLQqc0bUlR33VCFG5biyVTaYLM+c30SCLDv8y5XrkULIWa0VispiSpGAkpq9jhUZUl3M8eTz0CB6Jt7Xc3bBf8YkM4mYJpF3mSyG/o27EymgsL3wuIeGyaKd6eDgeWq8WrrwOi6Opz8xv8F9p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(1800799006)(186006)(451199021)(55016003)(38100700002)(316002)(66946007)(76116006)(64756008)(66476007)(66556008)(122000001)(66446008)(9686003)(7696005)(38070700005)(83380400001)(53546011)(26005)(71200400001)(6506007)(86362001)(2906002)(33656002)(478600001)(110136005)(8936002)(8676002)(41300700001)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eERrTDlrSGp3TmdzbUV6c2RXdG1OUWJVMXMxUStYNDl0NFlaUHl2ekdLMjlP?=
 =?utf-8?B?c2dxSVRLV1FkNnhsUHJCRm4vZi8wMlhUVUFRNFlFS1RGVE5Hci9RVS8zdFB0?=
 =?utf-8?B?V1BTTTIwTktqWHhvN240MEhHamNIWE5mdEZXeVN1RjNmc1JZbnkwYkxXNTM2?=
 =?utf-8?B?MnVMckJmOWpPcUk4T002eXhod3V6N1doNmJKcVdCYUFBU0dsME9yR3ZjL0h6?=
 =?utf-8?B?WVpueVZJdkp1QTJFeDM5cTdvdzdBU05XQjh4V2VNZFBzdTBmR1grc1R2cVE1?=
 =?utf-8?B?OTU5bDh4RzBENWhMQkEwRzRaVmk1dFFSS05HUTJqRTlacEZ2aC9Ic0IzbXA1?=
 =?utf-8?B?SVhOdnNBa3ZMbC9hQTltRzVsZk5lS01ZNVVwSGVxYktxeWFZcVZyZEk5VlJy?=
 =?utf-8?B?MklKQmEvcDdFckhmWTZrUm5zQXZ5T1ZPUlNtb0V4b0FkR3pweTlZV0FES0ts?=
 =?utf-8?B?aXJybEUyMzB6bE5sdE9mZE8wOVVCQmlZZUtMNjRsYldWLzZwcVcrd1NvREdy?=
 =?utf-8?B?NjE3QXN2L3kzWlhMLzFFTUxndi9oelVnYk9NRzlhZmpHRk5DUHM2NUFIUmlG?=
 =?utf-8?B?cURobEU2cHE3T25FNTVCbGE5WUx1YWxkdWcxTi9kd3M0c2Y2VlJQUVJaaGJU?=
 =?utf-8?B?ZWhwa0JDQndreHFrSnplQlJueEd1bFlOMG84YkZVOGlwU3c5cTArc3krcnFv?=
 =?utf-8?B?aC9YWFpxWStFNnB3TGFNOGNhZHRMbHYvZW9mUnFtUEpodzRWQWdGbktSVUZ0?=
 =?utf-8?B?NVQ0RjZGQUREWTFyMGlGVzZSSysxZW9mSlR0dG1PQ0lRN1RuMzd4L0FCb0Ja?=
 =?utf-8?B?VXlUbkFya3RBRjJpMFdxeTBGU0YxNTlMajQ1T1ZFNit2VmpNN05JeXFGRlpr?=
 =?utf-8?B?Sm80eXpBSE0yV2RPZGNOZVlIZjY3cW9iaUZsVkZkcXFKZjhWZHJYcEFQSUVV?=
 =?utf-8?B?WTFjMkNES0FXOW5tMkFZOTN2V1pDMVZHSXUvdWJ0SVJ1aUpZMUhrNHM3Z3ly?=
 =?utf-8?B?UlFlc25IUnlVb0pmT0ZxSm10ZC80M3NxUUpoa1pjR2gxODgxUlhtMm5qYVJP?=
 =?utf-8?B?UHkvWFFqVmo0ZkYwUXB1TWtLUDREMC9lSERoR3FLOVZMNFlrTFBtdkRPMVNl?=
 =?utf-8?B?WDYwSnpySnVtNFY5Z05ZdjJkQStFQmdFVU9vS3A0NFNHU0c0c3V4YTZ2a2lI?=
 =?utf-8?B?V1NNczhFMksyWVAvdm1HVHoza0I4YjN3Z011d2xoWjZ4MlRkRjJQeHpDR0E1?=
 =?utf-8?B?Yzc1alp4eDZvSXl1MEo0Y21mNnNGblFsUEFCTFBqSWl3c3RzYXAwbDgrR29l?=
 =?utf-8?B?QWlEOHV1aU9zRUR0MHhkN2hYTktNbFJsektEMDdUOVpCWnk5aVFxSVY0bU9W?=
 =?utf-8?B?ZVVuOTRKbEwwQ2hLOEFyR3Znb2ZnVm84NVNTa0R1a3FPeFo3UGZVb2Qxamc1?=
 =?utf-8?B?L1FUbUc5bmo3MnRiSjFpdUJCeE1wK1g1YmdOOXR1V1cyV0JTcFlQdVErNS95?=
 =?utf-8?B?NEJjeWFsQzFnQ2dHeVJhUDRadTdLQ0xmMUdHQktmRWFtcnh0MlZuejdROVdE?=
 =?utf-8?B?dVlSTUJWNG1jSk9PL2V1ZmRkY1h4aTdDNFpPWWUzWlNOVDN4VStnZTRhTEIz?=
 =?utf-8?B?VTAyeEdnK0ZqdUJVbHZEUHA4SkpGeTlOYzZ3aG8wUGs2UmovbWFYUHVJbmFO?=
 =?utf-8?B?NzhwQ2o2RlNDcmo2N2t6VUJQNVJCd1ZrUmhRVXBhU1BiOCtZT3p1UFRMRWRE?=
 =?utf-8?B?NS96SG0wbDFRS2hmOWRuSTVYbDB4UGxLSkIzcWtsc3dwZGdoVGo1U1JZYzhK?=
 =?utf-8?B?NnZtMGVjL3ZiTEdpNjhyNSs1UndBNXJCcHdGb2RvVnlMSG54VU03bHF1bk1D?=
 =?utf-8?B?TFRHOUxZNmk0cXpiRHo0TTlLbXRkeXlSTzFLcXJuRlErRnR1WmJKaTdyZG9X?=
 =?utf-8?B?elpkUDYydUEvQnYrdXQ1N0ZwVGdIKzRmMDZFRk5RbkdIUXlscmlLYW1zcWVS?=
 =?utf-8?B?NCtvYUgzVEdPUTRMeHU4MzlNN2lyV0luQVBTcEJ1ZTlVWmdyUmF1NitjcHFo?=
 =?utf-8?B?UzFrNi9RaUVhMHBIWVpZbkFpY1ZkRDRiNDhDQlVzcm5qOEZ3aUdjdXBuKzhZ?=
 =?utf-8?Q?C5DI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e83fe9e-425f-4d31-18fd-08db98e5a90f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 14:33:55.3871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzCRIiq+Twv9VBIG0acAZBQtkjQc7a8Qih79j/tcPwkHKU1QI4Be3I95TBZxCb8sZcfuJosVtZL41ZpTGLXOOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXNtYWEgTW5lYmhpIDxh
c21hYUBudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDkgQXVndXN0IDIwMjMgMTc6MTUN
Cj4gVG86IG1hcmtncm9zc0BrZXJuZWwub3JnOyBWYWRpbSBQYXN0ZXJuYWsgPHZhZGltcEBudmlk
aWEuY29tPjsNCj4gaGRlZ29lZGVAcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogQXNtYWEgTW5lYmhpIDxhc21hYUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBb
UEFUQ0ggdjEgMS8yXSBtbHhiZi1ib290Y3RsOiBTdXBwb3J0IHRoZSBsYXJnZSBpY21jIHdyaXRl
L3JlYWQNCj4gDQo+IEVuYWJsZSByZWFkaW5nIGFuZCB3cml0aW5nIHRoZSBzaXplIG9mIHRoZSBt
ZW1vcnkgcmVnaW9uIGFzc29jaWF0ZWQgd2l0aCB0aGUNCj4gbGFyZ2UgSUNNIGNhcnZlb3V0Lg0K
PiBUaGUgbWF4IHNpemUgb2YgdGhlIGxhcmdlIElDTSBjYXJ2ZW91dCBpcyAxVEIsIGhhcyBhIGdy
YW51bGFyaXR5IG9mIDEyOE1CIGFuZA0KPiB3aWxsIGJlIHBhc3NlZCBhbmQgcHJpbnRlZCBpbiBo
ZXguIFRoZSBzaXplIHVuaXQgaXMgTUIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBc21hYSBNbmVi
aGkgPGFzbWFhQG52aWRpYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5v
eC9tbHhiZi1ib290Y3RsLmMgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKw0KPiBkcml2ZXJz
L3BsYXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuaCB8ICA5ICsrKysrDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bs
YXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuYw0KPiBiL2RyaXZlcnMvcGxhdGZvcm0vbWVs
bGFub3gvbWx4YmYtYm9vdGN0bC5jDQo+IGluZGV4IGZiOWY3ODE1YzZjZC4uM2VhMTEyNTBiNjgx
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwu
Yw0KPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuYw0KPiBA
QCAtNzksNiArNzksOCBAQCBzdGF0aWMgdm9pZCBfX2lvbWVtICptbHhiZl9yc2hfc2NyYXRjaF9i
dWZfZGF0YTsNCj4gc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBtbHhiZl9yc2hfbG9nX2xldmVs
W10gPSB7DQo+ICAJIklORk8iLCAiV0FSTiIsICJFUlIiLCAiQVNTRVJUIn07DQo+IA0KPiArc3Rh
dGljIERFRklORV9NVVRFWChpY21fb3BzX2xvY2spOw0KPiArDQo+ICAvKiBBUk0gU01DIGNhbGwg
d2hpY2ggaXMgYXRvbWljIGFuZCBubyBuZWVkIGZvciBsb2NrLiAqLyAgc3RhdGljIGludA0KPiBt
bHhiZl9ib290Y3RsX3NtYyh1bnNpZ25lZCBpbnQgc21jX29wLCBpbnQgc21jX2FyZykgIHsgQEAg
LTM5MSw2ICszOTMsNDQNCj4gQEAgc3RhdGljIHNzaXplX3QgcnNoX2xvZ19zdG9yZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+ICAJcmV0dXJuIGNvdW50Ow0KPiAgfQ0KPiANCj4gK3N0YXRpYyBzc2l6
ZV90IGxhcmdlX2ljbV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gKwkJCQlzdHJ1Y3QgZGV2
aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKSB7DQo+ICsJc3RydWN0IGFybV9zbWNjY19y
ZXMgcmVzOw0KPiArDQo+ICsJbXV0ZXhfbG9jaygmaWNtX29wc19sb2NrKTsNCj4gKwlhcm1fc21j
Y2Nfc21jKE1MTlhfSEFORExFX0dFVF9JQ01fSU5GTywgMCwgMCwgMCwgMCwNCj4gKwkJICAgICAg
MCwgMCwgMCwgJnJlcyk7DQo+ICsJbXV0ZXhfdW5sb2NrKCZpY21fb3BzX2xvY2spOw0KPiArCWlm
IChyZXMuYTApDQo+ICsJCXJldHVybiAtRVBFUk07DQo+ICsNCj4gKwlyZXR1cm4gc25wcmludGYo
YnVmLCBQQUdFX1NJWkUsICIweCVseCIsIHJlcy5hMSk7IH0NCj4gKw0KPiArc3RhdGljIHNzaXpl
X3QgbGFyZ2VfaWNtX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gKwkJCSAgICAgICBzdHJ1
Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gKwkJCSAgICAgICBjb25zdCBjaGFyICpidWYs
IHNpemVfdCBjb3VudCkgew0KPiArCXN0cnVjdCBhcm1fc21jY2NfcmVzIHJlczsNCj4gKwl1bnNp
Z25lZCBsb25nIGljbV9kYXRhOw0KPiArCWludCBlcnI7DQo+ICsNCj4gKwllcnIgPSBrc3RydG91
bChidWYsIDE2LCAmaWNtX2RhdGEpOw0KPiArCWlmIChlcnIpDQo+ICsJCXJldHVybiBlcnI7DQoN
Ckkgc3VnZ2VzdCB1c2luZyBkZWZpbmUgaW5zdGVhZCBvZiAxNi4NCg0KPiArDQo+ICsJaWYgKCgo
aWNtX2RhdGEgIT0gMCkgJiYgKGljbV9kYXRhIDwgMHg4MCkpIHx8DQo+ICsJICAgIChpY21fZGF0
YSA+IDB4MTAwMDAwKSB8fCAoaWNtX2RhdGEgJSAxMjgpKQ0KPiArCQlyZXR1cm4gLUVQRVJNOw0K
DQpZb3UgY2FuIHJlbW92ZSByZWR1Y2UgJygpJyBhbmQgSSBzdWdnZXN0IGZvciB0byB1c2UgZm9y
IGNvbnNpc3RlbmN5IDEyODoNCkluc3RlYWQgb2YgMTI4IGFuZCAweDgwDQoJSWYgKChpY21fZGF0
YSA+IDAgJiYgaWNtX2RhdGEgPCAxMjgpDQoNClByb2JhYmx5IGNvbnNpZGVyIHRvIHVzZSBkZWZp
bmVzIGFsc28gZm9yIHRoZSBhYm92ZSBtYWdpYy4NCg0KPiArDQo+ICsJbXV0ZXhfbG9jaygmaWNt
X29wc19sb2NrKTsNCj4gKwlhcm1fc21jY2Nfc21jKE1MTlhfSEFORExFX1NFVF9JQ01fSU5GTywg
aWNtX2RhdGEsIDAsIDAsIDAsDQo+IDAsIDAsIDAsICZyZXMpOw0KPiArCW11dGV4X3VubG9jaygm
aWNtX29wc19sb2NrKTsNCj4gKw0KPiArCXJldHVybiByZXMuYTAgPyAtRVBFUk0gOiBjb3VudDsN
Cj4gK30NCj4gKw0KPiAgc3RhdGljIERFVklDRV9BVFRSX1JXKHBvc3RfcmVzZXRfd2RvZyk7ICBz
dGF0aWMNCj4gREVWSUNFX0FUVFJfUlcocmVzZXRfYWN0aW9uKTsgIHN0YXRpYw0KPiBERVZJQ0Vf
QVRUUl9SVyhzZWNvbmRfcmVzZXRfYWN0aW9uKTsNCj4gQEAgLTM5OCw2ICs0MzgsNyBAQCBzdGF0
aWMgREVWSUNFX0FUVFJfUk8obGlmZWN5Y2xlX3N0YXRlKTsgIHN0YXRpYw0KPiBERVZJQ0VfQVRU
Ul9STyhzZWN1cmVfYm9vdF9mdXNlX3N0YXRlKTsNCj4gIHN0YXRpYyBERVZJQ0VfQVRUUl9XTyhm
d19yZXNldCk7DQo+ICBzdGF0aWMgREVWSUNFX0FUVFJfV08ocnNoX2xvZyk7DQo+ICtzdGF0aWMg
REVWSUNFX0FUVFJfUlcobGFyZ2VfaWNtKTsNCj4gDQo+ICBzdGF0aWMgc3RydWN0IGF0dHJpYnV0
ZSAqbWx4YmZfYm9vdGN0bF9hdHRyc1tdID0gew0KPiAgCSZkZXZfYXR0cl9wb3N0X3Jlc2V0X3dk
b2cuYXR0ciwNCj4gQEAgLTQwNyw2ICs0NDgsNyBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAq
bWx4YmZfYm9vdGN0bF9hdHRyc1tdID0gew0KPiAgCSZkZXZfYXR0cl9zZWN1cmVfYm9vdF9mdXNl
X3N0YXRlLmF0dHIsDQo+ICAJJmRldl9hdHRyX2Z3X3Jlc2V0LmF0dHIsDQo+ICAJJmRldl9hdHRy
X3JzaF9sb2cuYXR0ciwNCj4gKwkmZGV2X2F0dHJfbGFyZ2VfaWNtLmF0dHIsDQo+ICAJTlVMTA0K
PiAgfTsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJm
LWJvb3RjdGwuaA0KPiBiL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtYm9vdGN0bC5o
DQo+IGluZGV4IGI0ODI0M2Y2MGE1OS4uNzVkNTlhZGU5MmJlIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuaA0KPiArKysgYi9kcml2ZXJzL3Bs
YXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuaA0KPiBAQCAtODEsNiArODEsMTUgQEANCj4g
ICAqLw0KPiAgI2RlZmluZSBNTFhCRl9CT09UQ1RMX0ZXX1JFU0VUICAweDgyMDAwMDBEDQo+IA0K
PiArLyoNCj4gKyAqIFNNQyBmdW5jdGlvbiBJRHMgdG8gc2V0IGFuZCBnZXQgdGhlIGxhcmdlIElD
TSBjYXJ2ZW91dCBzaXplDQo+ICsgKiBzdG9yZWQgaW4gdGhlIGVlcHJvbS4NCj4gKyAqLw0KPiAr
I2RlZmluZSBNTE5YX0hBTkRMRV9TRVRfSUNNX0lORk8gICAgMHg4MjAwMDAxMg0KPiArI2RlZmlu
ZSBNTE5YX0hBTkRMRV9HRVRfSUNNX0lORk8gICAgMHg4MjAwMDAxMw0KPiArDQo+ICsjZGVmaW5l
IE1BWF9JQ01fQlVGRkVSX1NJWkUgMTANCj4gKw0KPiAgLyogU01DIGZ1bmN0aW9uIElEcyBmb3Ig
U2lQIFNlcnZpY2UgcXVlcmllcyAqLw0KPiAgI2RlZmluZSBNTFhCRl9CT09UQ1RMX1NJUF9TVkNf
Q0FMTF9DT1VOVAkweDgyMDBmZjAwDQo+ICAjZGVmaW5lIE1MWEJGX0JPT1RDVExfU0lQX1NWQ19V
SUQJCTB4ODIwMGZmMDENCj4gLS0NCj4gMi4zMC4xDQoNCg==
