Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9D8810884
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378366AbjLMDCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjLMDCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:02:05 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E123DAB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 19:02:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVTydhakzmGohF7cUp9c7KDlMdThUsR+nUbpNPLItEvRlSQV1ilZKWOsdfDrpMi3SHhlKcXQUVHFzXMXFNzBftxGPEABRK/h7lPuXOX2J3N4MaGhnsTDz+A8M7xB5uIQ+HSGpwzd13EjjlzKcu3fLGJLEmnaEaX55h7eGXX3d7Zq66M9OB+wDeEiK815TAKAStkDrqbWQBGj9yvvH4GDjdslmlmzElI34NFQG9AO+G29EKAUh1vFc8C6Rpo7Ugb8PXoSSW1Y/RbytVkKq8xKLJIKlLN52IB57Bb3CnFNCwpM3icOjGtLOD2Xtzf/s+g+QIbllGG0eppgvm/wdw36tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5zil6xKw/XQCb1vlmlZZnzQ2j9Bb5ru/N04Rp9+aJI=;
 b=Xv8Sbh3vpUnWPMov1bmqJ5Qmf6nFva3ctmED4GfZlneEWJ9BAmSnP9zmzE4SN1fgddAYtxzCt2ttgGTEca/bab+HJ+tqdQc+znQpXDfGNIlVVQWTqZZTS+LY8ozCko0F6eacXRAEjWelawC53koPpn0sWn1s+BwT6DT5Zp8gx0GC98ZUPVPF6RLGWFRH4EH4MyVmNVeDsh5vDMsRtXKcEG/a1PulwnIolQme8Ra6s4m2EdBmaUl8B4eHzvXrS9Snccs7PdvoDUs/C3s7yFKT1WRRdZ31VlJ57Vx4ANuwrB42qhpp1GRIMkw3B32cThG7UArNMYugx9UqxgF3cAyiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5zil6xKw/XQCb1vlmlZZnzQ2j9Bb5ru/N04Rp9+aJI=;
 b=PwvFxHlkgC3f4JYmfWCUL12r5sXZ5eRic9Yhr1HQK0YjTRdzEsmlQLL7MTWSGPJSqfFF1S2qsfSpKDEP1vlGMOTvjZLv8oVRqlUgWGDkEHCvHarDPfEMiH9929nMoSRObj4wZ+RbP/Zj5HCOAYWy3gdEhhFHwuYtpyB9otAGfds=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 03:02:09 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 03:02:08 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v3 1/3] xen/pci: Add xen_reset_device_state
 function
Thread-Topic: [RFC KERNEL PATCH v3 1/3] xen/pci: Add xen_reset_device_state
 function
Thread-Index: AQHaK4QkzYDl8jqmzUObr+uXAc87xbClTeCAgAG/wAA=
Date:   Wed, 13 Dec 2023 03:02:08 +0000
Message-ID: <BL1PR12MB5849151AA2D1F461EFF12E17E78DA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
 <20231210161519.1550860-2-Jiqian.Chen@amd.com> <ZXgVGWLZEnLt0Pqn@macbook>
In-Reply-To: <ZXgVGWLZEnLt0Pqn@macbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB7663.namprd12.prod.outlook.com
 (15.20.7113.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|BL1PR12MB5850:EE_
x-ms-office365-filtering-correlation-id: e9e78ff7-f4dd-4aec-015e-08dbfb87e552
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lHfmfCdqEU8DuTIuBwRUkxHd8ljK6IDSX4AUSyTPn7I1LxgHpikfhh8DG/91cwFlZcTiZrc6HXML32OKgoie0FDuQLxCbNym2YPNekbAu3l2YiW9egFRgLEJQKnPKWMfCeHxgtddzUiH52r5aB4tMgj4daWHgkDUmkbvBA+ng5jpcyjVwUampE/aEaOUu3PIDrJdyRJFQ1jhKUs2W7cKWo7PhoDe7RGNz9ho2THtUr84qO1Z3dW0UWLPP4acLxnTYwJQe7a6APqMOMUqp2zDvysWhVc4U4cpFVKXzwCKT0XiEU63aFxBSHlLa6O7mkp3e4LE6ITEH+Mflq6ZXpzF/XlVFhxUD6bi21qVxCGMVLI9BqGMh21ZkVyFkq2SsaW3W7HhhWsOdFoXfi4FXIgEZqf+AG3B7qAK7h0lvg/FJGKrbpPEYfI6EsaO56uf1Mub8b7iOiXZUt5Ysr4G63N3fl8RV48aTBvqiSvmHeW01Bwn6fFrj7CapKWJE/bx4Phh+LYTtfbjmSMiLMqgFdpPts/YNZSZuyKESC8LdstqLdWo6lI0PMfn6VzhHLIy/yPcGfpxIEOzW80txpX4M2GOUlqCHpkdI14BJ3jc5H6RB5xcICBa6/bgJFbGrdJ6vGik
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(52536014)(9686003)(53546011)(6506007)(5660300002)(26005)(33656002)(38070700009)(64756008)(6916009)(76116006)(66446008)(54906003)(66946007)(66476007)(66556008)(2906002)(83380400001)(478600001)(41300700001)(7696005)(55016003)(8936002)(8676002)(4326008)(122000001)(71200400001)(316002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDhCVW1yNXovTDc0ZU03UGYra0tSQUVPWGQrVkkrdjhPajBYNjlaWUJodTAv?=
 =?utf-8?B?cUUwMEthOWkvaWQ5b0NYampTZkNTSTg1VzdtblpqSG5ndVZEZDFubm5yMktJ?=
 =?utf-8?B?SS9KK3l5cVFHUllNUC8wblVnWk1PWEFFbi9VQWRMNmxnSTFiaERKTjg0N1FE?=
 =?utf-8?B?OHJ5ZXV0ZUpqd3psay91NUJYNStmaUlFV3hrMFNVdU5oTERnSnpySHFxNGNr?=
 =?utf-8?B?aHhYL2pFM0lucHNGcTRLaStvQlVRdVRMSGo0dkg5RFBBd0lrRlFaYzY4TmE4?=
 =?utf-8?B?NmhUckdFVTBQODdqb2FiVGFRcGxJT1JLRlRoSkJkZk4vNThzeHlGWjlaWWxP?=
 =?utf-8?B?Z1poYmhPWVFBNEdKUjhGM0EybU5xWVQwaEpXY3hESFRRRFlMNmJGU2oveUtX?=
 =?utf-8?B?UjFzOWNRMUszZ2dUdWlsRFpzRWMyd2dydy9DcXkrOTluTlIyTVkzVmJyTlhR?=
 =?utf-8?B?d3pLdEFkdVVvbFlvQVRNV0ZOaU9zZ0Z6S2RBQ0xxd3VaUlh1dE9qdENVR0Fp?=
 =?utf-8?B?dXpnUWFBcDdINGE1cE92ZWZuQVd3SnRtcWNGODJ5NVduR2dlL0NEalgvR3Ez?=
 =?utf-8?B?ODFadVZ6RmZmeUxlK1FoUW51eHdPay9YQlFuODZHTlhSamVtTUVqYjNpemU1?=
 =?utf-8?B?VGlvcGlqZEtRam9IU3hZN3JOR0ZGbTZsbk9zdGtpOHM2TnY4eENUazRCaStX?=
 =?utf-8?B?ZXE4MUdsU0pjdWloa0ZKemx1OVJnU09SeCtVd3JMZENaaGNnUUF5eklNTWxF?=
 =?utf-8?B?S1E0R1AzZmZmL0J5YzVmUDNVaU9VbVphdXZtOHJvTFVHa2N2T3E0NWI5Y3Jv?=
 =?utf-8?B?MDhnYVZGZU10bWk0NFlnOTRqdWRSaTcvblBVTWg2KzJVRE1pUW5rdm9SSERO?=
 =?utf-8?B?VVZ6NFNNZ1dPZ1gvODdzM3ltSVViRlp6K0J5TWprR09UWkl4aGsyRWdMeTFM?=
 =?utf-8?B?ZzBsL2pta29uZEdWQmI2QXdhczZ5S1NyQWNXZGNuVlpUcGJXTlBmOTR0WEMv?=
 =?utf-8?B?VnFjU2NzUjJlYVArYzdENkYxNFBLVXdTODBCWXV2dXN6dithSTJDWTRBT0RL?=
 =?utf-8?B?R3pFdHBlK01sUEIrTzlLbHVOcmJOV2ZjRDlLQ3pYNjM1eXJQVzBkbWJ2bXk1?=
 =?utf-8?B?b1ZRVHVMZUowM09vK0Z2SndwLzl1OUY2ZzJLVk96d0EyaU1mVm1QTWt5ajJ0?=
 =?utf-8?B?cE1RMVErenRKSzgyd21SL0syTFEzaVQ4Vm9JZWwzSktOY3J2NDdpcCtpa24x?=
 =?utf-8?B?ZEdNODFmM2thTWpsd3JtZjRJMjd1V2FmQkxra28xeFRkUjlxNTZrd0pzaUpy?=
 =?utf-8?B?Q0l5alRXTG8zQXNRTW5KejQyVDdEOW0zWDFpUld5VEs4ZkZVNE8rNVVYV0w3?=
 =?utf-8?B?M2lqUllacEdOakQvdUdmeXY3ZnBBUFhvRm9EQVZxVXh1K01GSWRSdlZuaWdC?=
 =?utf-8?B?UkUzd1FERGVkNVYwTDNKSUtRd3V3SkxLY1ZrT0RUSEkyeEN1NnBDRnNzOEN1?=
 =?utf-8?B?dVR2eUlUSjJZYzkxTk5lZDZ6U0M0dU04ZU1ITmlSM20xQWU1dWJKS2JYL1pa?=
 =?utf-8?B?ZDEzeDhTV3N4NVkvcmdzYlJSQ0RlV1ZBWHkvSUU1dzV3YXU2VXlaN0dDaDBX?=
 =?utf-8?B?YjFiemxwQlVXb1pmNUwxUi9pZmJIM25uYmpmeHlBRFVlVzNOLzNhdzFlNWRu?=
 =?utf-8?B?WXdOSzlROGlpV2V2U28vSXN2K1JiRjJ0eUpqeDdYdnVDSGNSZnFrYUNwazFE?=
 =?utf-8?B?d3dkZmRpc3hELzRvYUUzRTEwNHZNRU5wVHltUnVOUmJ2RzVsSHJTbFhxbENy?=
 =?utf-8?B?ckdsT045WkUxSFZ4NG11Vkk5NHFHSCt3b29yTzRhZW1kV0pWYVZ4ODVqMHp0?=
 =?utf-8?B?bjd2NmR5RjdpOFl1ZTlhSDJRR3FlU1Rtd3kwQ0IwaFMwbkx1T05EcjRIRWlW?=
 =?utf-8?B?aXM1Z1FiUWpFZjlQc01jcTk2SHIvT3pWR2toQmJGYUFlSEM0aCthMmFrOFFp?=
 =?utf-8?B?cVhFRVVWK3BaeUZkVTVYR3VyU2tXRG01WVl6STRXQ2pjK1RtTzI3K3crcndL?=
 =?utf-8?B?WDFEN2NRanE3ZUZISHc4bFhSSkdDN2Y0NWwzd3lHVW5RaCtYK1pvWGhBVzNL?=
 =?utf-8?Q?ys2U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9401DBBBFF149F4981634C8E051B5B5F@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e78ff7-f4dd-4aec-015e-08dbfb87e552
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 03:02:08.9155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Na9Ger++rlLCj1xKomm7FVmLhMvR6oXCzIYTXIFRjfxwo25SIG6iUkdzldnkzvRSXvM9NLlwnUEBIa7NHdwJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMy8xMi8xMiAxNjowOCwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4gT24gTW9uLCBE
ZWMgMTEsIDIwMjMgYXQgMTI6MTU6MTdBTSArMDgwMCwgSmlxaWFuIENoZW4gd3JvdGU6DQo+PiBX
aGVuIGRldmljZSBvbiBkb20wIHNpZGUgaGFzIGJlZW4gcmVzZXQsIHRoZSB2cGNpIG9uIFhlbiBz
aWRlDQo+PiB3b24ndCBnZXQgbm90aWZpY2F0aW9uLCBzbyB0aGF0IHRoZSBjYWNoZWQgc3RhdGUg
aW4gdnBjaSBpcw0KPj4gYWxsIG91dCBvZiBkYXRlIHdpdGggdGhlIHJlYWwgZGV2aWNlIHN0YXRl
Lg0KPj4gVG8gc29sdmUgdGhhdCBwcm9ibGVtLCBhZGQgYSBuZXcgZnVuY3Rpb24gdG8gY2xlYXIg
YWxsIHZwY2kNCj4+IGRldmljZSBzdGF0ZSB3aGVuIGRldmljZSBpcyByZXNldCBvbiBkb20wIHNp
ZGUuDQo+Pg0KPj4gQW5kIGNhbGwgdGhhdCBmdW5jdGlvbiBpbiBwY2lzdHViX2luaXRfZGV2aWNl
LiBCZWNhdXNlIHdoZW4NCj4+IHVzaW5nICJwY2ktYXNzaWduYWJsZS1hZGQiIHRvIGFzc2lnbiBh
IHBhc3N0aHJvdWdoIGRldmljZSBpbg0KPj4gWGVuLCBpdCB3aWxsIHJlc2V0IHBhc3N0aHJvdWdo
IGRldmljZSBhbmQgdGhlIHZwY2kgc3RhdGUgd2lsbA0KPj4gb3V0IG9mIGRhdGUsIGFuZCB0aGVu
IGRldmljZSB3aWxsIGZhaWwgdG8gcmVzdG9yZSBiYXIgc3RhdGUuDQo+Pg0KPj4gQ28tZGV2ZWxv
cGVkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
SmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3hl
bi9wY2kuYyAgICAgICAgICAgICAgICAgIHwgMTIgKysrKysrKysrKysrDQo+PiAgZHJpdmVycy94
ZW4veGVuLXBjaWJhY2svcGNpX3N0dWIuYyB8ICA0ICsrKysNCj4+ICBpbmNsdWRlL3hlbi9pbnRl
cmZhY2UvcGh5c2Rldi5oICAgIHwgIDggKysrKysrKysNCj4+ICBpbmNsdWRlL3hlbi9wY2kuaCAg
ICAgICAgICAgICAgICAgIHwgIDYgKysrKysrDQo+PiAgNCBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNl
cnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3BjaS5jIGIvZHJpdmVy
cy94ZW4vcGNpLmMNCj4+IGluZGV4IDcyZDRlM2YxOTNhZi4uZTliMzBiYzA5MTM5IDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy94ZW4vcGNpLmMNCj4+ICsrKyBiL2RyaXZlcnMveGVuL3BjaS5jDQo+
PiBAQCAtMTc3LDYgKzE3NywxOCBAQCBzdGF0aWMgaW50IHhlbl9yZW1vdmVfZGV2aWNlKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4+ICAJcmV0dXJuIHI7DQo+PiAgfQ0KPj4gIA0KPj4gK2ludCB4ZW5f
cmVzZXRfZGV2aWNlX3N0YXRlKGNvbnN0IHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+PiArew0KPj4g
KwlzdHJ1Y3QgcGh5c2Rldl9wY2lfZGV2aWNlIGRldmljZSA9IHsNCj4+ICsJCS5zZWcgPSBwY2lf
ZG9tYWluX25yKGRldi0+YnVzKSwNCj4+ICsJCS5idXMgPSBkZXYtPmJ1cy0+bnVtYmVyLA0KPj4g
KwkJLmRldmZuID0gZGV2LT5kZXZmbg0KPj4gKwl9Ow0KPj4gKw0KPj4gKwlyZXR1cm4gSFlQRVJW
SVNPUl9waHlzZGV2X29wKFBIWVNERVZPUF9wY2lfZGV2aWNlX3N0YXRlX3Jlc2V0LCAmZGV2aWNl
KTsNCj4+ICt9DQo+PiArRVhQT1JUX1NZTUJPTF9HUEwoeGVuX3Jlc2V0X2RldmljZV9zdGF0ZSk7
DQo+PiArDQo+PiAgc3RhdGljIGludCB4ZW5fcGNpX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9i
bG9jayAqbmIsDQo+PiAgCQkJICAgIHVuc2lnbmVkIGxvbmcgYWN0aW9uLCB2b2lkICpkYXRhKQ0K
Pj4gIHsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5j
IGIvZHJpdmVycy94ZW4veGVuLXBjaWJhY2svcGNpX3N0dWIuYw0KPj4gaW5kZXggZTM0YjYyM2U0
YjQxLi4yNGY1OTllYWVjMTQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3hlbi94ZW4tcGNpYmFj
ay9wY2lfc3R1Yi5jDQo+PiArKysgYi9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5j
DQo+PiBAQCAtNDIxLDYgKzQyMSwxMCBAQCBzdGF0aWMgaW50IHBjaXN0dWJfaW5pdF9kZXZpY2Uo
c3RydWN0IHBjaV9kZXYgKmRldikNCj4+ICAJZWxzZSB7DQo+PiAgCQlkZXZfZGJnKCZkZXYtPmRl
diwgInJlc2V0dGluZyAoRkxSLCBEMywgZXRjKSB0aGUgZGV2aWNlXG4iKTsNCj4+ICAJCV9fcGNp
X3Jlc2V0X2Z1bmN0aW9uX2xvY2tlZChkZXYpOw0KPj4gKwkJaWYgKCF4ZW5fcHZfZG9tYWluKCkp
DQo+PiArCQkJZXJyID0geGVuX3Jlc2V0X2RldmljZV9zdGF0ZShkZXYpOw0KPj4gKwkJaWYgKGVy
cikNCj4+ICsJCQlnb3RvIGNvbmZpZ19yZWxlYXNlOw0KPiANCj4gSSB0aGluayB5b3UgYXJlIG1p
c3Npbmcgb3RoZXIgaW5zdGFuY2VzIHdoZXJlDQo+IF9fcGNpX3Jlc2V0X2Z1bmN0aW9uX2xvY2tl
ZCgpIGlzIGNhbGxlZCBpbiBwY2lfc3R1Yi5jPyAgU2VlDQo+IHBjaXN0dWJfZGV2aWNlX3JlbGVh
c2UoKSBhbmQgcGNpc3R1Yl9wdXRfcGNpX2RldigpLg0KU29ycnksIEkgZGlkbid0IGNvbnNpZGVy
IHRoZSBzaXR1YXRpb24gdG8gZnJlZSBwYXNzdGhyb3VnaCBkZXZpY2UuIFlvdSBhcmUgcmlnaHQu
DQoNCj4gDQo+IE92ZXJhbGwgSSdtIG5vdCBzdXJlIHdoeSB0aGUgaHlwZXJjYWxsIHdyYXBwZXIg
bmVlZHMgdG8gbGl2ZSBpbg0KPiB4ZW4vcGNpLmMuICANCkZvciBvdGhlciBwb3NzaWJsZSBzY2Vu
YXJpb3Mgd2hlcmUgdGhpcyBmdW5jdGlvbiBtYXkgYmUgdXNlZD8NCg0KPiBJIHRoaW5rIGl0IHdv
dWxkIGJlIGJldHRlciBpZiB5b3UgY291bGQgY3JlYXRlIGEgc3RhdGljIHdyYXBwZXIgaW4gcGNp
X3N0dWIuYyB0aGF0IGRvZXMgdGhlIGNhbGwgdG8NCj4gX19wY2lfcmVzZXRfZnVuY3Rpb25fbG9j
a2VkKCkgcGx1cyBQSFlTREVWT1BfcGNpX2RldmljZV9zdGF0ZV9yZXNldC4NCj4gVGhhdCB3b3Vs
ZCBtYWtlIGl0IGxlc3MgbGlrZWx5IHRoYXQgbmV3IGNhbGxlcnMgb2YNCj4gX19wY2lfcmVzZXRf
ZnVuY3Rpb25fbG9ja2VkKCkgYXJlIGludHJvZHVjZWQgd2l0aG91dCBub3RpY2luZyB0aGUgbmVl
ZA0KPiB0byBhbHNvIGNhbGwgUEhZU0RFVk9QX3BjaV9kZXZpY2Vfc3RhdGVfcmVzZXQuDQpPaywg
SSB3aWxsIGFkZCBhIG5ldyBmdW5jdGlvbiB0byBkbyBfX3BjaV9yZXNldF9mdW5jdGlvbl9sb2Nr
ZWQgYW5kIFBIWVNERVZPUF9wY2lfZGV2aWNlX3N0YXRlX3Jlc2V0IGluIHBjaV9zdHViLmMNCg0K
PiANCj4gVGhhbmtzLCBSb2dlci4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4N
Cg==
