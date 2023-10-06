Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF297BBC24
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjJFPuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjJFPur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:50:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CAF9E;
        Fri,  6 Oct 2023 08:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3XHC77AGzDE5mGwgJvKuxYxLuDuMRT0ekIv5F1IOSOlEeOejPb7fxlMYIK4YZ8Y6+RzHPq0R0SaCc2flnvsimy8/Fhm7gbOjRToRUl5QVFz8/5I3V8JAB955o2Yu4tbHjXVjaLtpTt6c47eas4flOBIBVKyhbH/hnnOBEv0Kb8HZceRn+DvsdY28bjKblKr/vcB+HAMMRgDzbuZqc7M3zsQji0kkjM5Amnjne7IKLbweuLt1HAp089zBYsm/FUOeD/TrYRh2KjYC2bp7xOquuZ93rDwVU9YAHC8ZlvLsCwKWdFjOvZ4yJof6G4wbdNK+XoyelynV6BWipnRnhVGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNnOwC3LRryu3rOCABUiQ/2C7YJLf1kTX1hFOgCDCN0=;
 b=Eu3YrrJGSKhexlXHYEdoUm5HVnVjsXZ8l1Cr2IVte7woFtYmb9nDxJefBn+4DHxAOeuZfIYO9wlAmw56dhhOQU/3PGjyNghmjwc96Br+USBg+LibYXHZc2QLQCjgDriK5MlvZfQeWaZ87SSwBxGyIURHGwVj2pydmAAEC3oQOZ+C5q5ICxxNTqvKIr5X7xWJNNPXDrbYVoaSNy/wNfOqIpQRU1sxG/WhbxdMyAZkzTgE+M9DCrj7vIV2jIDfbK7F+cdJfuq6/hGd8p9oM1mZ2XQRQhaPqMx3QH1/b+opvNMxf5lcerbdqi28fW/HjfIF1APtYT3ol6jRF62cAml9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNnOwC3LRryu3rOCABUiQ/2C7YJLf1kTX1hFOgCDCN0=;
 b=hG6CdZVQYms1tXrJWSN+i0F121UwEpcLbXIb+aYgrye/cjtFMQQ5E/ZMrqdeLI7/6cU00bTmPZAeqTKGaDL++M9svfuKeHYT3iFbLkjTUxd753U9q2FnN4EL3EhiNdBGepIhHh+yqA8z4zD3vOy2A3uLdP3AuyAZgZ6m9aeo891VPmY6eXGIQEalYAc4Emv31MwV2+rxoGBDfB8Kt4/VJu8c8HAF/k5qk513c2OJAbaaWCZDOlsrftRBNsj9hM80qmaZ40mbEK3MQ5mViES+MwyxHKrYkxqq3csjerzUixgsTAIjwHxPG9Ah8hGTwn5r/gh+sur/aOjLJFXkp+w/wQ==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31; Fri, 6 Oct
 2023 15:50:43 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::e00:7275:f848:ae4b]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::e00:7275:f848:ae4b%3]) with mapi id 15.20.6838.028; Fri, 6 Oct 2023
 15:50:42 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a warning
 message
Thread-Topic: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a warning
 message
Thread-Index: AQHZ94YFlBkdvRjGj0Cl1AIVKIdf4LA8uTSAgAAv4sA=
Date:   Fri, 6 Oct 2023 15:50:42 +0000
Message-ID: <BN9PR12MB50687C00EDAFC2B1A058E1E3D3C9A@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <bb8bc77e6ecc2287fc9110cfa08caa48eb2a0385.1696508228.git.limings@nvidia.com>
 <35467b21-941f-c829-1ad8-b4e7319dbc04@redhat.com>
In-Reply-To: <35467b21-941f-c829-1ad8-b4e7319dbc04@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|SN7PR12MB6929:EE_
x-ms-office365-filtering-correlation-id: 1e68f1f3-a0c9-4fa2-c0c4-08dbc683feea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WY2Ih5GBqubAq6Z3Q67thu2yi5Z6w/K8qJAGgcBS8LGP92Fr8ks5i88ncvgke2uQOiJZzxHZd1kQ6YlZu3aGmF9fuUN9g+NJLxocv4GByJtpoB7i7Tds7S+33qvtoHn85s3EwOGyWtSyLKLvA1fYIqpIXO2J+ASY3CxhzfRW0VXOLppN4+jbdkKQ0JAIecnUfddorPVwddmvdSNAYwQPGQsLweIdrmlmCpS5A9T+o3t1t58ESPfEgj7MyCvlNSRJqeJyXp8YR6JI97bZZaglnDtZXqxBlfqwzQU6zXdBiDfJ0AEipAG4MySf9p93zrGndU/9ZEfhemjwJaTgPRKDPCL65EeV8htxgH9CrLc0WFjRvf57Gt0Bm7bijIalH3mdzqRwFeu0D+0OLSKvnPdP31vYO1VLj91i1ENr2p2NcKo1XEgH023AOYprQXmSWt0d4gIRCBY+yFil81YSKjOctW+kmQFQOFA36e5+6tG6sUZoJO006dDsVW1P81Pw7h2t5te/Lcj/GDIaQxkmYlgUFWvk2wXt49JP3UxtfGEkYTt26nUhgTOxdqVT+xv+E9DW0EY7MLZFnI9YihHEa9aqhL23scOB2jaK4etsfH1qJvm6xmRjsYYkYesKPN+1rlfc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(53546011)(7696005)(6506007)(71200400001)(478600001)(9686003)(8676002)(66446008)(66946007)(26005)(33656002)(64756008)(110136005)(5660300002)(76116006)(8936002)(52536014)(66556008)(2906002)(41300700001)(316002)(4326008)(66476007)(38100700002)(86362001)(54906003)(122000001)(15650500001)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVRFSGp2a3lvZ1Rpa1p6c1FTMndQdlBKT3Q2b1N4RC9GNXdPR0xLRjNWUDNR?=
 =?utf-8?B?dDREb2RrVDk2YituZExJOC82dHBqWVF1M3FHaXdjMVl3MEhwdlZLTGU0WUwy?=
 =?utf-8?B?V01CU3hRUGM3K3hBeE4xemVoTFBpZEVhZlc3U2lvOXJkUzU0c01HWXJ3eWdX?=
 =?utf-8?B?TnpkYWIvN1FCN0pBZjdqMlJqMzl5d2hWd3JCYU45ZE43QTVqTldLUzlBSjBV?=
 =?utf-8?B?ZUtPUmRLdUQwbjgyUDUreC9YOEJDVk5HcG1mMlhzUW1kSitxeWhRYk9PZGZM?=
 =?utf-8?B?Rk9NbnZYM1FqVEM4R0h0MzlOU25adC9QNzl3ZTBTQzd6UitBNnh4VWdabXUx?=
 =?utf-8?B?ZzZSb2FLUnh2Ti9hbkJMTXV5ZisyQStQa3RuZXNCL0JFRFNIRXN1WXl4WEFH?=
 =?utf-8?B?QVEzZmFWWWZEVEVBZmJIWUNEem5XRVA5TFRlazBHakNYb2gvZXV2eXM0aDdi?=
 =?utf-8?B?MThHY3VjOHF0aTVzRkdrYjdyS3lSYXBTR0JNYjdRZFFLdGhkeDJndFBxaXFE?=
 =?utf-8?B?WjRhb0hCczRyQ2FwV2NzVzRhVjZscFlJMzQ5RkFhSE5UQWp2NlduTkZqUHZI?=
 =?utf-8?B?ZmJwY24ySkhvNUdmZ1dTZTBoNFdCUS9CVmk4cHQxOUhnY2xBTnpCMGV0Y0Jz?=
 =?utf-8?B?KzJveXUxWG5QaXV2K3R5MGd5eVpKSWdjVzhsYjU0NDNaRzNxOVh3RWxkSzZS?=
 =?utf-8?B?RjlGbys0ZmR6N0l5ajdmSitFOWd4aDdIU3hRWlJUVFZkSjYwWXhuU29YeEIz?=
 =?utf-8?B?RlYvZG9mbjhteG9PZlpZOWpaVWtxNzRWNCtwRk15ZG1UZkZnV2YyRHM4bllh?=
 =?utf-8?B?VEJpWWt0cTFlcDdIdFNZU1BOSEtlc1Zrck9JeTRvZDBtTUFpV2FJUUZrZk41?=
 =?utf-8?B?Qkg0eFl1bGcrZGZnbmVMcXNwV2RIcEFVVXlBY2tVb3IyN2l0eW0xeld2enJw?=
 =?utf-8?B?ZFdiaytKWXcrSkg1aEdLQk1sSjBLWDkrd3lNVVFYRS8vRC85VlRSVGthRVlr?=
 =?utf-8?B?QlFqQkZvempraVJEajBhVVh4YVZtMGpuMkFCdWJOSVFBSlpJTVdHNkl0cmRT?=
 =?utf-8?B?bnNUTVVHTkw5N2tpUzdkeHVWSE55dHhvT0ZVVWk0M29sNnR3TlJVcmtZREhn?=
 =?utf-8?B?TEJIUW4yYWRXc3J1NmdvVTcxTitIWmFEVnllVHRvMFk1eERxY3hLQy90ZWxl?=
 =?utf-8?B?a1ByZ1M5TithOEc4UmMwVUhReE9aZzI2Z2hublhLclNyUzJJZkYwQWRTQmdF?=
 =?utf-8?B?cEY4MGZoWHZWMVkySWxQbWtQUUNKc3pMeUZSOTRxSm85TUcvV3lzZU5adUVq?=
 =?utf-8?B?ckp5QU1nNXBOMGpEUURtS2IxbTc3VGtNYnBZdkpNdExlQWhMNFRDakJHbHVv?=
 =?utf-8?B?ei9CUm9mWDAwaHJNbWp4UUZraHF1WTRTWU9la1l2a1pTZ3J3am5VNTN0MnBm?=
 =?utf-8?B?K2NHTDkzdmVYa3Fzc1IwUWtERVc5YnBhM2pTejRIS0lRcXlWWnVXY1huU3pP?=
 =?utf-8?B?WHAvYU1sVE1OYlB3aHkvc200SmNkODBJZk50eFJSd0NnQzA0U0ZSSUIzQTlD?=
 =?utf-8?B?UUIrWmxXSjFUdmZrbWJSUlk4anhMUDFzSEhTcHhxbzZxTFE5UjFPOXFhL3Vn?=
 =?utf-8?B?WGdwY2NhNk4rTDFGRTdNbHRGY2g3S0kxeFN5am1xTWo5c2lNME5GUzZ4M0xn?=
 =?utf-8?B?blViYXVtS1BpeTJ1cGZGcXlOWXdxR3hiSWJSRjJQS3hJeVoxOFQ5T2FQa2Ra?=
 =?utf-8?B?UjJZUHBDYndxQSszdzlwRDZhZmtZeGFYUzVsbUZYZ3Blc3AvYVF1Z2xVUSt6?=
 =?utf-8?B?QkZ0Uk1sb0lWd25LQngxbTUwcFJZSmpTcnQ2M2hOZDNCTmkwOEtlb09BZlFm?=
 =?utf-8?B?UUdiZGo1QkVYLzRheWdBOWxPQTlLOUtUbzB4cW4xTkxyR21RV2JlSEZQd0JC?=
 =?utf-8?B?UW9GdzhuSmdlSURabG03bWtRSGRTY3VpMEdWb2VWaVdLMWhBdCtuZmthYm1F?=
 =?utf-8?B?OTB5SjZsam14aU80MGQ1OUk1aWo0YTVPQ0l0VkM5YTRwaUJGREZBYXgyTHZl?=
 =?utf-8?B?Mm5yQ3BVaVF0VlNVc3hUb0V3TGl4M0NuWlFjanJGd2E5N21vankxQ1h5WHdK?=
 =?utf-8?Q?UhW4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e68f1f3-a0c9-4fa2-c0c4-08dbc683feea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 15:50:42.2391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5jtD60AFzJmGwrvvV10f8oeR4/Y1yF2rohbFckKU3q84AvEiAIQQ21IhN7BSK8K6o28kPa4O5U11XJUYxMJQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEhhbnMuDQoNCkJlbG93IGlzIHRoZSBsb2dpYzoNCg0KSVNfVlJJTkdfRFJPUCgpIGlz
IE9OTFkgc2V0IHRvIFRSVUUgZm9yIFJ4LCB3aGljaCBpcyBkb25lIGluIHR3byBwbGFjZXM6DQpM
aW5lIDY5NjogICpkZXNjID0gJnZyaW5nLT5kcm9wX2Rlc2M7DQpMaW5lIDc0MjogZGVzYyA9ICZ2
cmluZy0+ZHJvcF9kZXNjOw0KDQpTbyBsaW5lIDYzNCBiZWxvdyB3aWxsIG5ldmVyIGhhcHBlbiB3
aGVuIElTX1ZSSU5HX0RST1AoKSBpcyBUUlVFIGR1ZSB0aGUgY2hlY2tpbmcgb2YgbGluZSA2MzMu
DQo2MzMgICAgICAgICBpZiAoIWlzX3J4KQ0KIDYzNCAgICAgICAgICAgICAgICAgd3JpdGVxKGRh
dGEsIGZpZm8tPnR4LmRhdGEpOw0KDQpQbGVhc2UgY29ycmVjdCBtZSBpZiBpdCdzIG15IG1pc3Vu
ZGVyc3RhbmRpbmcuDQoNClRoYW5rcywNCkxpbWluZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+DQo+IFNl
bnQ6IEZyaWRheSwgT2N0b2JlciA2LCAyMDIzIDg6NTQgQU0NCj4gVG86IExpbWluZyBTdW4gPGxp
bWluZ3NAbnZpZGlhLmNvbT47IFZhZGltIFBhc3Rlcm5haw0KPiA8dmFkaW1wQG52aWRpYS5jb20+
OyBEYXZpZCBUaG9tcHNvbiA8ZGF2dGhvbXBzb25AbnZpZGlhLmNvbT47IE1hcmsNCj4gR3Jvc3Mg
PG1hcmtncm9zc0BrZXJuZWwub3JnPjsgRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5h
cm8ub3JnPg0KPiBDYzogcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzFdIHBs
YXRmb3JtL21lbGxhbm94OiBtbHhiZi10bWZpZm86IEZpeCBhIHdhcm5pbmcNCj4gbWVzc2FnZQ0K
PiANCj4gSGkgTGltaW5nLA0KPiANCj4gT24gMTAvNS8yMyAxNDoxOCwgTGltaW5nIFN1biB3cm90
ZToNCj4gPiBUaGlzIGNvbW1pdCBmaXhlcyB0aGUgc21hdGNoIHN0YXRpYyBjaGVja2VyIHdhcm5p
bmcgaW4NCj4gPiBtbHhiZl90bWZpZm9fcnh0eF93b3JkKCkgd2hpY2ggY29tcGxhaW5zIGRhdGEg
bm90IGluaXRpYWxpemVkIGF0DQo+ID4gbGluZSA2MzQgd2hlbiBJU19WUklOR19EUk9QKCkgaXMg
VFJVRS4gVGhpcyBpcyBub3QgYSByZWFsIGJ1ZyBzaW5jZQ0KPiA+IGxpbmUgNjM0IGlzIGZvciBU
eCB3aGlsZSBJU19WUklOR19EUk9QKCkgaXMgb25seSBzZXQgZm9yIFJ4LiBTbyB0aGVyZQ0KPiA+
IGlzIG5vIGNhc2UgdGhhdCBsaW5lIDYzNCBpcyBleGVjdXRlZCB3aGVuIElTX1ZSSU5HX0RST1Ao
KSBpcyBUUlVFLg0KPiA+DQo+ID4gVGhpcyBjb21taXQgaW5pdGlhbGl6ZXMgdGhlIGxvY2FsIGRh
dGEgdmFyaWFibGUgdG8gYXZvaWQgdW5uZWNlc3NhcnkNCj4gPiBjb25mdXNpb24gdG8gdGhvc2Ug
c3RhdGljIGFuYWx5emluZyB0b29scy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpbWluZyBT
dW4gPGxpbWluZ3NAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wbGF0Zm9ybS9t
ZWxsYW5veC9tbHhiZi10bWZpZm8uYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
bGF0Zm9ybS9tZWxsYW5veC9tbHhiZi10bWZpZm8uYw0KPiBiL2RyaXZlcnMvcGxhdGZvcm0vbWVs
bGFub3gvbWx4YmYtdG1maWZvLmMNCj4gPiBpbmRleCBmMzY5NmE1NGEyYmQuLmNjYzRiNTFkMzM3
OSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLXRtZmlm
by5jDQo+ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi10bWZpZm8uYw0K
PiA+IEBAIC01OTUsOCArNTk1LDggQEAgc3RhdGljIHZvaWQgbWx4YmZfdG1maWZvX3J4dHhfd29y
ZChzdHJ1Y3QNCj4gbWx4YmZfdG1maWZvX3ZyaW5nICp2cmluZywNCj4gPiAgew0KPiA+ICAJc3Ry
dWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSB2cmluZy0+dnEtPnZkZXY7DQo+ID4gIAlzdHJ1Y3Qg
bWx4YmZfdG1maWZvICpmaWZvID0gdnJpbmctPmZpZm87DQo+ID4gKwl1NjQgZGF0YSA9IDA7DQo+
ID4gIAl2b2lkICphZGRyOw0KPiA+IC0JdTY0IGRhdGE7DQo+ID4NCj4gPiAgCS8qIEdldCB0aGUg
YnVmZmVyIGFkZHJlc3Mgb2YgdGhpcyBkZXNjLiAqLw0KPiA+ICAJYWRkciA9IHBoeXNfdG9fdmly
dCh2aXJ0aW82NF90b19jcHUodmRldiwgZGVzYy0+YWRkcikpOw0KPiANCj4gDQo+IFRoaXMgd2ls
bCBmaXggdGhlIHdhcm5pbmcgYnV0IG5vdCB0aGUgaXNzdWUgYXQgaGFuZC4gQXMgRGFuIHBvaW50
ZWQNCj4gb3V0IGluIGhpcyBvcmlnaW5hbCBidWcgcmVwb3J0LCB0aGUgaXNzdWUgaXMgdGhhdCBh
ZnRlcjoNCj4gDQo+IDc4MDM0Y2JlY2U3OSAoInBsYXRmb3JtL21lbGxhbm94OiBtbHhiZi10bWZp
Zm86IERyb3AgdGhlIFJ4IHBhY2tldCBpZiBubw0KPiBkZXNjcmlwdG9ycyIpDQo+IA0KPiBXZSBu
b3cgaGF2ZSB0aGlzIElTX1ZSSU5HX0RST1AoKSBjaGVjayBpbiB0aGUgcGF0aCwgd2hpY2ggZGVz
cGl0ZQ0KPiB0aGUgc3ViamVjdCB3cml0ZXEoZGF0YSwgZmlmby0+dHguZGF0YSk7aXMgY3VycmVu
dGx5IGJlaW5nIGFwcGxpZWQgdG8gYm90aCByeCBhbmQNCj4gdHggdnJpbmctcw0KPiBhbmQgd2hl
biB0aGlzIHJldHVybnMgdHJ1ZSB0aGUgbWVtY3B5IGZyb20gdGhlIHJpbmcgdG8gJmRhdGENCj4g
d2lsbCBub3QgaGFwcGVuLCBidXQgdGhlIGNvZGUgd2lsbCBzdGlsbCBkbzoNCj4gDQo+IHdyaXRl
cShkYXRhLCBmaWZvLT50eC5kYXRhKTsNCj4gDQo+IFNvIHlvdSBtYXkgaGF2ZSBzaWxlbmNlZCB0
aGUgd2FybmluZyBub3csIGJ1dCB5b3Ugd2lsbCBzdGlsbCB3cml0ZQ0KPiBkYXRhIG5vdCBjb21p
bmcgZnJvbSB0aGUgdnJpbmcgdG8gdHJhbnNtaXQuIFRoZSBvbmx5IGRpZmZlcmVuY2UNCj4gaXMg
eW91IGFyZSBub3cgZ3VhcmFudGVlZCB0byB3cml0ZSBhbGwgemVyb2VzLg0KPiANCj4gTm90ZSBh
bm90aGVyIG9sZGVyIGlzc3VlIGlzIHRoYXQgaWYgeW91IGhpdCB0aGUgbm90IGVub3VnaCBzcGFj
ZQ0KPiBwYXRoOg0KPiANCj4gICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAgICAvKiBM
ZWZ0b3ZlciBieXRlcy4gKi8NCj4gICAgICAgICAgICAgICAgIGlmICghSVNfVlJJTkdfRFJPUCh2
cmluZykpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGlzX3J4KQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG1lbWNweShhZGRyICsgdnJpbmctPmN1cl9sZW4sICZk
YXRhLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsZW4gLSB2cmlu
Zy0+Y3VyX2xlbik7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBtZW1jcHkoJmRhdGEsIGFkZHIgKyB2cmluZy0+Y3VyX2xl
biwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGVuIC0gdnJpbmct
PmN1cl9sZW4pOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgdnJpbmct
PmN1cl9sZW4gPSBsZW47DQo+ICAgICAgICAgfQ0KPiANCj4gVGhlbiBldmVuIGlmIElTX1ZSSU5H
X0RST1AoKSByZXR1cm5zIHRydWUgeW91IGFyZSBvbmx5IGluaXRpYWxpemluZyBzb21lIGJ5dGVz
DQo+IG9mIHRoZSA4IGJ5dGVzIGRhdGEgdmFyaWFibGUgYW5kIHRoZSBvdGhlciBieXRlcyB3aWxs
IHN0YXkgYXQgd2hhdGV2ZXIgcmFuZG9tDQo+IHZhbHVlIHRoZXkgaGFkIGJlZm9yZSBhbmQgeW91
IGVuZCB1cCB3cml0aW5nIHRoaXMgcmFuZG9tIGJ5dGVzIHdoZW4gZG9pbmc6DQo+IA0KPiB3cml0
ZXEoZGF0YSwgZmlmby0+dHguZGF0YSk7DQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gSGFucw0KPiAN
Cj4gDQo+IA0KDQo=
