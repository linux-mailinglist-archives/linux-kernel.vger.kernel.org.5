Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47A87A72CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjITGdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITGdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:33:13 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF1F9D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9BGatE4ZsUU1ZssmvSUxI5Stf6MYpNsao5vP52sco4DXKRUWA83yGnYEELRLk5SuGS/w3Ktq1p3vNo3RSynLG1ncRkzvv1kq+9dyonQ2Ear6D0s2eFUENNCMRtB7UoGN54FrISjukx+sQjlN5UpJg5vblnMmaf2qgX+5BhfOxZmmXViMWEuUe3jOokLJYlXMTVdIs+0nVCCS82EryRRE16r2jkQ1J4bnAyJzsoqKuA7fxfyF5oy2ZqxopIkuVHs4b06vK/OaBJZjxnRDuMENcvW55K+Y4Crk8BSYKA/TWyOZPkSj8MO7kDkHNe4Zkdr8tq932T3cIIiaXCIC1/gSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Nb7UeAIzRLOCnI7bJCWkCrn1IO/VYN756o7WW2PJZ8=;
 b=iFVjVcDSKPsAOuF+oCi0QYO+MS5edy0TGzKt+Ph+D5IPmre6R4mY1K4G7pwjiUe5eq2mhaSWGYYuecnxGE5dkRgV3+iCsqdh5Zrb+IBsZVGS1zfDTMIIhx0+57RM/L/kCdmNVM9rTcCPOOsYaMgzq2p4995QAng2TDko2fDY8b26e1nJXOmo065xE3EzsZkpiq0qB5shhlNQlExKZOx3R+mDKqrAycFikTrPDbijscITT19Ippmj/xIRUNWFnCfkggW7rQr76l1e3TKZ9TKd1wjGM284Em6EBUxEHQWYOSGoUC7ujcLmSYwCSUboknCLo5bsqfu7SA8+UvZU9dkmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Nb7UeAIzRLOCnI7bJCWkCrn1IO/VYN756o7WW2PJZ8=;
 b=orXceeC2pAJWHqwcNsRl9JGDn5hv1H2GBBDk1KAkcb/kse1bFU2P4GH/Li3tlfVF7OtP7O5aoxcQBtydZvVPhnJDwjSS1ia3cSlIWdI5Lciiv6uJ5mSjtYqZ+VGnLqPI/jD41eRJCBY6Sp99yBheVv+kLCBWZh0Gt4/j2NY4znk=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 06:33:03 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 06:33:02 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     "Zhu, Lingshan" <lingshan.zhu@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        Parav Pandit <parav@nvidia.com>,
        "virtio-comment@lists.oasis-open.org" 
        <virtio-comment@lists.oasis-open.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Index: AQHZ6u53lm7slkvYHEmC01qhzu9Vn7AiFHuAgAEk1ACAAI2IgA==
Date:   Wed, 20 Sep 2023 06:33:02 +0000
Message-ID: <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
In-Reply-To: <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.6792.025)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|BY5PR12MB4901:EE_
x-ms-office365-filtering-correlation-id: e15682aa-f549-4353-b5e8-08dbb9a370ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9L2cobHEyiTb1NOsqbHR9C3oMr0usdG++ElYyegdbWFNKxTsF9NBPRLk+4XJ7mt8WKpldv9exC9muQbbVfrkLqNl6L/z1NHf2Cp4aJ7nMOlXtQ7raB+b9QeFU3nUGybvaAzJnt3uWQM7v2Jvutj8TzATlW7v8EwX+A3eKmgpQWUY5AjVvRxXfw4/jAKJwrySNH22puDbyREo4zDk3bfLixiBDbcSBzLhh0ckKQitnBqEc4J+IUirI448FRPKHSz9gTB5YKiGWzxOgEFI+R6BVn2bZNJ6Ls524xsKYfQ6IFf79HXn9WCet+8sLOc/mBPRsQWuFCSspA0Icv/ZvebjEEKpNMPFiUAJQfD1fE8Y70HSC94IrtnU9qDWzigIb9okBr58SJcYdcy7jB0BLLe9mD3k29ltLrpKpIq1b6JFllUVnVjrMMBhKHwy4IXkG4yrg2FlI0Zd1W6MYKzC5LUZ/TBaBrzM46mfAMUsXWgmM3Ssc1IYRWGBCs/Kfx5UeH4L4f4Z3l+GQealSOx6Jgm1k5jwqM4FIO0hEykRUW8T24HnHYXw0DfzJHkTkSs4fW4UWUoqzMpSb1Wk1Oyoqo4SFOEFZQIdImmjt03qva8Fo84=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(1800799009)(451199024)(186009)(33656002)(41300700001)(8676002)(55016003)(52536014)(4326008)(5660300002)(83380400001)(8936002)(6506007)(7696005)(53546011)(26005)(71200400001)(9686003)(66899024)(122000001)(478600001)(2906002)(38070700005)(38100700002)(966005)(66946007)(7416002)(64756008)(66446008)(76116006)(66476007)(110136005)(54906003)(66556008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2JEUVVXTjFqYmhMaVBwbE1mZDlraGpWRHJDeTRiMXRuTzdYYUN4emxEek5C?=
 =?utf-8?B?clk4UGJodldVb09PTU0zS0xOUzNoSHZTdFJwbFo2UmZpQmVtN01ienJXbE9R?=
 =?utf-8?B?aTlFOS9QTlh5K1NQVmNmbXdTUnh3dGZvRitFZTdBbjI4Wjc5UXNZcHVGQk95?=
 =?utf-8?B?MXJmcjVtZjFNR3FueTNFbkZLWEhPeURyeWREODVheXBuWEl0RytHcms5Zmdr?=
 =?utf-8?B?Q1pPK2ptMGIycmVqQ3oxU2xHaldzT3htdlBZRWxQVTMrNXpPd0pEZjRST0VV?=
 =?utf-8?B?c0VMcHJVSWhTbUpXVHJIUkJ3YnBUVEVjMnVhaS9Fb0hISDQ4R2s1Q2pucm1F?=
 =?utf-8?B?SDF6bmFkcExTMmIxc2pZMkNYVExZMUluWmxkNVdjQUdzR01xV08ySkFtWUlj?=
 =?utf-8?B?RGJPNkl5WFByek1SMS9VYWtqU3VIcjNOR0RDMzR0bjZ0ajUvQmJJRC9PaHZO?=
 =?utf-8?B?cDYrL0xaV2FnR0pMZ25nVittOVJPQmh0SmorbkhuOGVlUVZXajB1UnVtc0l2?=
 =?utf-8?B?Q2VQclVhV1VWYmtjTzFYY1gydDkrTTNLTXg2Y0dNa0tLYzEwWHBzTDB5Vkhu?=
 =?utf-8?B?Wk1XZGNqMG1MWlVQQURzaWhrRWNVTmlQQkhDcDJzMXVlTDQyYUZMTTNEZjNl?=
 =?utf-8?B?ek81NHdBK0p1TTBaSktTZ2JCZkZmdmNoRG05S3VWa3VrcGc5M3RJSUFhMzhr?=
 =?utf-8?B?WWVwdTU5cW5DMWdnL2RVZEFGUTVOZ28rWm5SaGdPSDVkZks1MDhWNEt3Mm1Q?=
 =?utf-8?B?NnF3U0hCb1lic2l3d1RxQkpDTFo4UUNLcHBRU05SRUVocE96UVVId1o2UXBa?=
 =?utf-8?B?OEFFTDRjL2R0enlLcCtOazRycSsxckRoSHNWWFBXeXZpRjBCMTI4bXRtU2w2?=
 =?utf-8?B?dDZjOFFkVGhvendTYkhRMzZYanhDRVVkU3VBVEtkaGJXTVR0YytIRFdvdHp5?=
 =?utf-8?B?SkJhYTNuaTFGSFN1cHM4MkVkbEVrL3M2MkFoc0FicGY4TjdvMGhWbFZ5MDBw?=
 =?utf-8?B?cElyTUQ2ODRSYS8vQ0hya0NOd3pVUHFOQkxwUDVvMjI5QjUvN09aUktVTWVu?=
 =?utf-8?B?eVVjWmFSOUJDaStmTDZJd1BlN3kxc2tyc3JTQTlkbWRqbnhvV01HMTR2ZnNL?=
 =?utf-8?B?azMzUjYyajh0MFV1dThsZkNVeno4Vm04NWJVLzVxM0hnSWRGZlN1MkxtT0ho?=
 =?utf-8?B?VE16ZVA0WitRT1VsVTJ0RW51U0piejF2dzl5clRLU0l0dXF4SFl6OXlZcHVu?=
 =?utf-8?B?SVFLcTFWOHdpZk84aUQzcjExbFpMaGpUQ2RiMldISXpTd2I0TGFiZ05DcXpw?=
 =?utf-8?B?WjVvR0tiT0FYb29UOEU1MGJVMkJ5clRhUGN6VzJUZ3crTEZ2RnlrbGpRcVZT?=
 =?utf-8?B?d3lWbUFpTkVEOGFVWllmOGpGMHNaWGx3UnF6dnU1aTBqZWYyR1BJSmR4aDJ0?=
 =?utf-8?B?aGFIVWluRlZWOHRRVzIrVGoxM2VjUkhtSDh4M05aS1FaYzBiSU5pZ2c3M09l?=
 =?utf-8?B?dDA0eHl0bTdEUDE5SDNIbWhhZWVMMkpwMEtCMDk3c0YxcWxQOEFGYTQwOGU5?=
 =?utf-8?B?dWxOTGlpcWt6QjhndUZmbStDallHUHNBaUs0ZUsvSU42aEJKdEpyRWpBbnlB?=
 =?utf-8?B?YmNZVmNCSnBQV0wwTWpoT0ZZcHV2OGpJWlA3SytBUG16NjdpajVDSTNEa1h3?=
 =?utf-8?B?dWRJeVUvQWdMTGdWWFVXNEZEZEUyNlk4aXZXMWxDejJPVU5uSURQdkRITENW?=
 =?utf-8?B?SkVUNG9aZmlqdWZ5UE9MU3p5cWc5dUFFQUp6VjdwT2pCQkdNVlNyeTlieUdu?=
 =?utf-8?B?b2g0TG15Wk9wSjZrOEI4QlJXWHdORjZ3NlRkZlcyZkJaVThRWGNQcCsyWm9C?=
 =?utf-8?B?Sm1QMUpDc3oxZkpuU2JiY2pUWENOTFhTVTA0S283bHdMNE8zNGtjVGJrZ0dD?=
 =?utf-8?B?Y0NUc0l5ZUZWTEdvV3YwTVM4KzV1VmpFTWc2ZWRPZUhzTmo5d3F0dy9wNVJv?=
 =?utf-8?B?by9XOGtFWHFYbkowRHU0aE04eGJHeG5ZcnVYS1JROVVGMDRFbnZaMndGbjBw?=
 =?utf-8?B?SUdTWSttOWFiZ2MydGJ1RDdKeUY3TFhtZVN3VjRZV1BDRFpmck9NdkgreVhv?=
 =?utf-8?Q?0Ez0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <994A0E21A7BFD7479BD310CA2C8BA1AC@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15682aa-f549-4353-b5e8-08dbb9a370ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 06:33:02.4919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXHYHuQX1VzrqOBYZyxTHi54q+ZOLRujflqo2dQrNWc2xUyy47aCWDbGpbuNv2kszGVnY5bndvAMGr9p0UXFxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGluZ3NoYW4sDQoNCk9uIDIwMjMvOS8yMCAxMzo1OSwgWmh1LCBMaW5nc2hhbiB3cm90ZToN
Cj4gDQo+IA0KPiBPbiA5LzE5LzIwMjMgODozMSBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Og0KPj4gT24gVHVlLCBTZXAgMTksIDIwMjMgYXQgMDc6NDI6NDJQTSArMDgwMCwgSmlxaWFuIENo
ZW4gd3JvdGU6DQo+Pj4gV2hlbiBndWVzdCB2bSBkb2VzIFMzLCBRZW11IHdpbGwgcmVzZXQgYW5k
IGNsZWFyIHNvbWUgdGhpbmdzIG9mIHZpcnRpbw0KPj4+IGRldmljZXMsIGJ1dCBndWVzdCBjYW4n
dCBhd2FyZSB0aGF0LCBzbyB0aGF0IG1heSBjYXVzZSBzb21lIHByb2JsZW1zLg0KPj4+IEZvciBl
eGNhbXBsZSwgUWVtdSBjYWxscyB2aXJ0aW9fcmVzZXQtPnZpcnRpb19ncHVfZ2xfcmVzZXQgd2hl
biBndWVzdA0KPj4+IHJlc3VtZSwgdGhhdCBmdW5jdGlvbiB3aWxsIGRlc3Ryb3kgcmVuZGVyIHJl
c291cmNlcyBvZiB2aXJ0aW8tZ3B1LiBBcw0KPj4+IGEgcmVzdWx0LCBhZnRlciBndWVzdCByZXN1
bWUsIHRoZSBkaXNwbGF5IGNhbid0IGNvbWUgYmFjayBhbmQgd2Ugb25seQ0KPj4+IHNhdyBhIGJs
YWNrIHNjcmVlbi4gRHVlIHRvIGd1ZXN0IGNhbid0IHJlLWNyZWF0ZSBhbGwgdGhlIHJlc291cmNl
cywgc28NCj4+PiB3ZSBuZWVkIHRvIGxldCBRZW11IG5vdCB0byBkZXN0cm95IHRoZW0gd2hlbiBT
My4NCj4+Pg0KPj4+IEZvciBhYm92ZSBwdXJwb3NlLCB3ZSBuZWVkIGEgbWVjaGFuaXNtIHRoYXQg
YWxsb3dzIGd1ZXN0cyBhbmQgUUVNVSB0bw0KPj4+IG5lZ290aWF0ZSB0aGVpciByZXNldCBiZWhh
dmlvci4gU28gdGhpcyBwYXRjaCBhZGQgYSBuZXcgcGFyYW1ldGVyDQo+Pj4gbmFtZWQgZnJlZXpl
X21vZGUgdG8gc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZy4gQW5kIHdoZW4gZ3Vlc3QNCj4+
PiBzdXNwZW5kcywgaXQgY2FuIHdyaXRlIGZyZWV6ZV9tb2RlIHRvIGJlIEZSRUVaRV9TMywgYW5k
IHRoZW4gdmlydGlvDQo+Pj4gZGV2aWNlcyBjYW4gY2hhbmdlIHRoZWlyIHJlc2V0IGJlaGF2aW9y
IG9uIFFlbXUgc2lkZSBhY2NvcmRpbmcgdG8NCj4+PiBmcmVlemVfbW9kZS4gV2hhdCdzIG1vcmUs
IGZyZWV6ZV9tb2RlIGNhbiBiZSB1c2VkIGZvciBhbGwgdmlydGlvDQo+Pj4gZGV2aWNlcyB0byBh
ZmZlY3QgdGhlIGJlaGF2aW9yIG9mIFFlbXUsIG5vdCBqdXN0IHZpcnRpbyBncHUgZGV2aWNlLg0K
PiBIaSBKaXFpYW4sDQo+IA0KPiBIYXZlIHlvdSBzZWVuIHRoaXMgc2VyaWVzOiBbUEFUQ0ggMC81
XSB2aXJ0aW86IGludHJvZHVjZSBTVVNQRU5EIGJpdCBhbmQgdnEgc3RhdGUNCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzNmNGNiZjg0LTAxMGMtY2ZmYS0wYjcwLTMzYzQ0OWI1NTYxYkBp
bnRlbC5jb20vVC8NCj4gDQo+IFdlIGludHJvZHVjZWQgYSBiaXQgaW4gdGhlIGRldmljZSBzdGF0
dXMgU1VTUEVORCwgd2hlbiBWSVJUSU9fRl9TVVNQRU5EIGlzDQo+IG5lZ290aWF0ZWQsIHRoZSBk
cml2ZXIgY2FuIHNldCBTVVNQRU5EIGluIHRoZSBkZXZpY2Ugc3RhdHVzIHRvIHN1c3BlbmQgdGhl
DQo+IGRldmljZS4NCj4gDQo+IFdoZW4gU1VTUEVORCwgdGhlIGRldmljZSBzaG91bGQgcGF1c2Ug
aXRzIG9wZXJhdGlvbnMgYW5kIHByZXNlcnZlIGl0cyBjb25maWd1cmF0aW9ucw0KPiBpbiBpdHMg
Y29uZmlndXJhdGlvbiBzcGFjZS4NCj4gDQo+IFRoZSBkcml2ZXIgcmUtd3JpdGUgRFJJVkVSX09L
IHRvIGNsZWFyIFNVU1BFTkQsIHNvIHRoZSBkZXZpY2UgcmVzdW1lcyBydW5uaW5nLg0KPiANCj4g
VGhpcyBpcyBvcmlnaW5hbGx5IHRvIHNlcnZlIGxpdmUgbWlncmF0aW9uLCBidXQgSSB0aGluayBp
dCBjYW4gYWxzbyBtZWV0IHlvdXIgbmVlZHMuDQpJIG5vdGljZWQgeW91ciBzZXJpZXMsIGJ1dCBJ
IGFtIG5vdCBzdXJlIHRoZXkgYXJlIGFsc28gbWVldCBteSBuZWVkcy4NCklmIGRyaXZlciB3cml0
ZSAwIHRvIHJlc2V0IGRldmljZSwgY2FuIHRoZSBTVVNQRU5EIGJpdCBiZSBjbGVhcmVkPyAocGNp
X3BtX3Jlc3VtZS0+dmlydGlvX3BjaV9yZXN0b3JlLT52aXJ0aW9fZGV2aWNlX3Jlc3RvcmUtPnZp
cnRpb19yZXNldF9kZXZpY2UpDQpJZiBTVVNQRU5EIGlzIGNsZWFyZWQsIHRoZW4gZHVyaW5nIHRo
ZSByZXNldCBwcm9jZXNzIGluIFFlbXUsIEkgY2FuJ3QganVkZ2UgaWYgdGhlIHJlc2V0IHJlcXVl
c3QgaXMgZnJvbSBndWVzdCByZXN0b3JlIHByb2Nlc3Mgb3Igbm90LCBhbmQgdGhlbiBJIGNhbid0
IGNoYW5nZSB0aGUgcmVzZXQgYmVoYXZpb3IuDQpDYW4geW91IHNlbmQgbWUgeW91ciBwYXRjaCBs
aW5rIG9uIGtlcm5lbCBhbmQgcWVtdSBzaWRlPyBJIHdpbGwgdGFrZSBhIGRlZXAgbG9vay4NCg0K
PiANCj4gVGhhbmtzLA0KPiBaaHUgTGluZ3NoYW4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEpp
cWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4+IC0tLQ0KPj4+IMKgIHRyYW5zcG9y
dC1wY2kudGV4IHwgNyArKysrKysrDQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL3RyYW5zcG9ydC1wY2kudGV4IGIvdHJhbnNwb3J0
LXBjaS50ZXgNCj4+PiBpbmRleCBhNWM2NzE5Li4yNTQzNTM2IDEwMDY0NA0KPj4+IC0tLSBhL3Ry
YW5zcG9ydC1wY2kudGV4DQo+Pj4gKysrIGIvdHJhbnNwb3J0LXBjaS50ZXgNCj4+PiBAQCAtMzE5
LDYgKzMxOSw3IEBAIFxzdWJzdWJzZWN0aW9ue0NvbW1vbiBjb25maWd1cmF0aW9uIHN0cnVjdHVy
ZSBsYXlvdXR9XGxhYmVse3NlYzpWaXJ0aW8gVHJhbnNwb3J0DQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGxlNjQgcXVldWVfZGVzYzvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogcmVh
ZC13cml0ZSAqLw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBsZTY0IHF1ZXVlX2RyaXZlcjvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiByZWFkLXdyaXRlICovDQo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgIGxlNjQgcXVldWVfZGV2aWNlO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIHJl
YWQtd3JpdGUgKi8NCj4+PiArwqDCoMKgwqDCoMKgwqAgbGUxNiBmcmVlemVfbW9kZTvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIHJlYWQtd3JpdGUgKi8NCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgbGUxNiBxdWV1ZV9ub3RpZl9jb25maWdfZGF0YTvCoMKgIC8qIHJlYWQtb25seSBmb3Ig
ZHJpdmVyICovDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGxlMTYgcXVldWVfcmVzZXQ7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiByZWFkLXdyaXRlICovDQo+Pj4NCj4+IHdlIGNhbid0
IGFkZCBmaWVsZHMgaW4gdGhlIG1pZGRsZSBvZiB0aGUgc3RydWN0dXJlIGxpa2UgdGhpcyAtDQo+
PiBvZmZzZXQgb2YgcXVldWVfbm90aWZfY29uZmlnX2RhdGEgYW5kIHF1ZXVlX3Jlc2V0IGNoYW5n
ZXMuDQo+Pg0KPj4gwqDCoA0KPj4+IEBAIC0zOTMsNiArMzk0LDEyIEBAIFxzdWJzdWJzZWN0aW9u
e0NvbW1vbiBjb25maWd1cmF0aW9uIHN0cnVjdHVyZSBsYXlvdXR9XGxhYmVse3NlYzpWaXJ0aW8g
VHJhbnNwb3J0DQo+Pj4gwqAgXGl0ZW1bXGZpZWxke3F1ZXVlX2RldmljZX1dDQo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIFRoZSBkcml2ZXIgd3JpdGVzIHRoZSBwaHlzaWNhbCBhZGRyZXNzIG9mIERl
dmljZSBBcmVhIGhlcmUuwqAgU2VlIHNlY3Rpb24gXHJlZntzZWM6QmFzaWMgRmFjaWxpdGllcyBv
ZiBhIFZpcnRpbyBEZXZpY2UgLyBWaXJ0cXVldWVzfS4NCj4+PiDCoCArXGl0ZW1bXGZpZWxke2Zy
ZWV6ZV9tb2RlfV0NCj4+PiArwqDCoMKgwqDCoMKgwqAgVGhlIGRyaXZlciB3cml0ZXMgdGhpcyB0
byBzZXQgdGhlIGZyZWV6ZSBtb2RlIG9mIHZpcnRpbyBwY2kuDQo+Pj4gK8KgwqDCoMKgwqDCoMKg
IFZJUlRJT19QQ0lfRlJFRVpFX01PREVfVU5GUkVFWkUgLSB2aXJ0aW8tcGNpIGlzIHJ1bm5pbmc7
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIFZJUlRJT19QQ0lfRlJFRVpFX01PREVfRlJFRVpFX1MzIC0g
Z3Vlc3Qgdm0gaXMgZG9pbmcgUzMsIGFuZCB2aXJ0aW8tcGNpIGVudGVycyBTMyBzdXNwZW5zaW9u
Ow0KPj4+ICvCoMKgwqDCoMKgwqDCoCBPdGhlciB2YWx1ZXMgYXJlIHJlc2VydmVkIGZvciBmdXR1
cmUgdXNlLCBsaWtlIFM0LCBldGMuDQo+Pj4gKw0KPj4gd2UgbmVlZCB0byBzcGVjaWZ5IHRoZXNl
IHZhbHVlcyB0aGVuLg0KPj4NCj4+IHdlIGFsc28gbmVlZA0KPj4gLSBmZWF0dXJlIGJpdCB0byBk
ZXRlY3Qgc3VwcG9ydCBmb3IgUzMNCj4+IC0gY29uZm9ybWFuY2Ugc3RhdGVtZW50cyBkb2N1bWVu
dGluZyBiZWhhdmlvdXMgdW5kZXIgUzMNCj4+DQo+Pg0KPj4+IMKgIFxpdGVtW1xmaWVsZHtxdWV1
ZV9ub3RpZl9jb25maWdfZGF0YX1dDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIFRoaXMgZmllbGQg
ZXhpc3RzIG9ubHkgaWYgVklSVElPX0ZfTk9USUZfQ09ORklHX0RBVEEgaGFzIGJlZW4gbmVnb3Rp
YXRlZC4NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgVGhlIGRyaXZlciB3aWxsIHVzZSB0aGlzIHZh
bHVlIHdoZW4gZHJpdmVyIHNlbmRzIGF2YWlsYWJsZSBidWZmZXINCj4+PiAtLcKgDQo+Pj4gMi4z
NC4xDQo+Pg0KPj4gVGhpcyBwdWJsaWNseSBhcmNoaXZlZCBsaXN0IG9mZmVycyBhIG1lYW5zIHRv
IHByb3ZpZGUgaW5wdXQgdG8gdGhlDQo+PiBPQVNJUyBWaXJ0dWFsIEkvTyBEZXZpY2UgKFZJUlRJ
TykgVEMuDQo+Pg0KPj4gSW4gb3JkZXIgdG8gdmVyaWZ5IHVzZXIgY29uc2VudCB0byB0aGUgRmVl
ZGJhY2sgTGljZW5zZSB0ZXJtcyBhbmQNCj4+IHRvIG1pbmltaXplIHNwYW0gaW4gdGhlIGxpc3Qg
YXJjaGl2ZSwgc3Vic2NyaXB0aW9uIGlzIHJlcXVpcmVkDQo+PiBiZWZvcmUgcG9zdGluZy4NCj4+
DQo+PiBTdWJzY3JpYmU6IHZpcnRpby1jb21tZW50LXN1YnNjcmliZUBsaXN0cy5vYXNpcy1vcGVu
Lm9yZw0KPj4gVW5zdWJzY3JpYmU6IHZpcnRpby1jb21tZW50LXVuc3Vic2NyaWJlQGxpc3RzLm9h
c2lzLW9wZW4ub3JnDQo+PiBMaXN0IGhlbHA6IHZpcnRpby1jb21tZW50LWhlbHBAbGlzdHMub2Fz
aXMtb3Blbi5vcmcNCj4+IExpc3QgYXJjaGl2ZTogaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9y
Zy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8NCj4+IEZlZWRiYWNrIExpY2Vuc2U6IGh0dHBzOi8v
d3d3Lm9hc2lzLW9wZW4ub3JnL3doby9pcHIvZmVlZGJhY2tfbGljZW5zZS5wZGYNCj4+IExpc3Qg
R3VpZGVsaW5lczogaHR0cHM6Ly93d3cub2FzaXMtb3Blbi5vcmcvcG9saWNpZXMtZ3VpZGVsaW5l
cy9tYWlsaW5nLWxpc3RzDQo+PiBDb21taXR0ZWU6IGh0dHBzOi8vd3d3Lm9hc2lzLW9wZW4ub3Jn
L2NvbW1pdHRlZXMvdmlydGlvLw0KPj4gSm9pbiBPQVNJUzogaHR0cHM6Ly93d3cub2FzaXMtb3Bl
bi5vcmcvam9pbi8NCj4+DQo+IA0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFRvIHVuc3Vic2NyaWJl
LCBlLW1haWw6IHZpcnRpby1kZXYtdW5zdWJzY3JpYmVAbGlzdHMub2FzaXMtb3Blbi5vcmcNCj4g
Rm9yIGFkZGl0aW9uYWwgY29tbWFuZHMsIGUtbWFpbDogdmlydGlvLWRldi1oZWxwQGxpc3RzLm9h
c2lzLW9wZW4ub3JnDQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K
