Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2161764B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjG0IPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbjG0IOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:14:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027B05595;
        Thu, 27 Jul 2023 01:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxA8tU1b+O2e/41zfMUAaxRxqfEguP3/8CSsz3LF0WkZ92MRdummNbcFsGlqXeB+XcMlrolCzQoo3ow/62+7kU3xBStPqOV7mkwo+HzNFWY9XpYy+RUjeTHuxnqsbYJMZfQp9XUoTbxq8Kl1VD/1ViUwwpCyrOzfWPcU/IMbplqr0bDGDsUN4ZppUn5FgLYrIa+ree6ookkaLYTUI27vCrsRyI5zgwh4JyCulf5EW+dCASBxkL0GsYCc/dotlMvbW9brm2Bx2Nh68Vr/kaLU9T+U8N74zxu5dWcUdoBljIuAfBJ0FvipD2kfXLuUqlFTNkF66SEoVbDg9rtlMacWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hETwhhkJXJtSgUyW1ggp9QYTNe3JzM66WdDgA3SpaNo=;
 b=Werjb2ZknBwYLjKZD3m+UnisU0ZOjl4tpGDHBSLHGWK2L7O/mnbG9jQwaVrYpPalc5G8C2qLIeX8/X4V16r2QW02mNX6V2edg+Xme6CrsoFss1/fPZ2287rKgJu7zY3lopAeRAk764p/0Mf/pb0QeiKDqHo362+TNsTzEmzBIvukKofo0Z7BGPpF+AHHCdpzLFvl2QCR8Yy4tXhS8BSZ02Yreu8WfYwijxv+4N7MAuS5rNAIRiuUoG/MYQ2VDbfMxnEkbOTp5NAu5SM3PHV6RP7odWuDwv2o7iYmmRjwoXYmhK+nV9yqkd6e1S8uh05LqWcSxSY5HGRBeyxmjuip+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hETwhhkJXJtSgUyW1ggp9QYTNe3JzM66WdDgA3SpaNo=;
 b=OH3NVImUxUfWW6gkK2uShMNwuupgm7Lxy6V/k7H+EXE3etzMHB8EnWl/YRD656pqezwQWh50xMvpZT55RZk8CxMdRw1FusSdc/HiQ3E+8+nlcw92qGAU2peFrELnrdN1oQN1zradBk6EzPF4NEK1KAxVOBxaUlyOeYFw+rqoukOMpWG4yjG4aTI2wa/BIr9yg6cqnDbvxPNpBHAvpR97a0m7+qz/BkH66RTdh6XOv2cX3zM0rrmtp+bnfK91Ld8P3NLcAGDs6MPyClv4O1TVZMeGdlhPmcr5Ix2OZIN7KecEp1I5KbuNxNL4Hn18WlZYIfJvcxmhYAOvGzYsOZglCQ==
Received: from DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) by
 MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Thu, 27 Jul 2023 08:08:16 +0000
Received: from DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::5eba:b751:cb79:8487]) by DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::5eba:b751:cb79:8487%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:08:16 +0000
From:   Haotien Hsu <haotienh@nvidia.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     WK Tsai <wtsai@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Wayne Chang <waynec@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        Jui Chang Kuo <jckuo@nvidia.com>,
        Henry Lin <henryl@nvidia.com>
Subject: Re: [PATCH v2] usb: xhci: tegra: Add shutdown callback for Tegra XUSB
Thread-Topic: [PATCH v2] usb: xhci: tegra: Add shutdown callback for Tegra
 XUSB
Thread-Index: AQHZuVh0iq1CZafdjU2xfpfDMDisY6/KtPWAgAKbVoA=
Date:   Thu, 27 Jul 2023 08:08:15 +0000
Message-ID: <1f9a2e6de117df62c77eca0560785c49a8245ba8.camel@nvidia.com>
References: <20230718091425.307589-1-haotienh@nvidia.com>
         <2023072532-vacancy-headlock-46be@gregkh>
In-Reply-To: <2023072532-vacancy-headlock-46be@gregkh>
Reply-To: Haotien Hsu <haotienh@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5988:EE_|MW3PR12MB4425:EE_
x-ms-office365-filtering-correlation-id: e13e7cd3-7877-488c-cadf-08db8e78a188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x+GlLVvBWWuz3e5JHLZ8PS0LxGV1BorqTJA1G0/+WBN/nRVpRz3+K88TvzY8M3LR3hp/UgnahjsA2JUXBP1W67rK35gs6FkcV4TAGmoth/pCqHbmvrTa8TS05th4zWuCZZygfNpeckY5xtCKc3OF5i+QmPo4SzEmzpHyXp46Vp3uhcSvHKAYpsK5a2tfdHRNTY5bEY8T/jK1dT+E+adaFHeWhlDaMCIiKncfW71fnvtIAwVfOlom8HyiQE+tDXQphy1m/eLrdj2LimQJ+3LwtvVOs6ZPX0huMw/7BfwiKwMhnONV9uDGAR9Wa2vceDch+jLNR2pNLFxpitixa1EyImlvIFVX91yV1YgVKmVPOOKtvHwwiGZWxa0d9n5+GDd2ltK8jcuiGVoAmM88gxUcl0/0WfHv3DWMLpPLZCIP8RwlB3upL4MNNsyznhCYwuhUrPd2bPiDZZdb9VGxlVMlUP6qhh5bI5NrFeiEasUJVLlyKNyHkfdoAscEFwQP03YypAm5+QeL1SeKEuPM4utjUoiec+nMwIdSAQREYSSfEwBRsMKayiwvxIdvtXr0w2kbujLB1phfpccuiA3a0jrLTg+Y76kKVX78bDI38XZWIOGaLJbB3pdjgWIsdjYcML3s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5988.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(316002)(64756008)(71200400001)(76116006)(91956017)(4326008)(66556008)(66476007)(66946007)(66446008)(6916009)(122000001)(36756003)(478600001)(6486002)(6512007)(38100700002)(86362001)(2906002)(54906003)(3450700001)(38070700005)(41300700001)(2616005)(107886003)(5660300002)(8936002)(8676002)(6506007)(26005)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTEyRlBNSzBYeGh2VlFiVWR1QWlWemkwaGM5aXhqbFQzQ3JFZHVXNHQ0ZGZn?=
 =?utf-8?B?WUFHZ2JtUU1MTFJWK1VEM2NLUWFqTmovODZRMVJHWHhOWGk3bkk2OFlLYmJB?=
 =?utf-8?B?aHMwQXBYYmFMSGpTWEQ1OWI1SUtheUlteFdHN3lQV0lzcnhtYUlJeHVMa2Zz?=
 =?utf-8?B?NXBYa3hqaDcwODBxbGJaVXlrQWJiL0l0bVpoUDFabFV0dENka2RXWlIwT1F0?=
 =?utf-8?B?NUk1UjFGT2tnVHVCaGg0QWlxMjczM1A2RTBJc1BKcXd3SHVhY05oR3RMaWVZ?=
 =?utf-8?B?YjFseTZ6RnZEZ1BLVzUrK3FUd2FWZXFZVE5DaWlmMHR3MWV2MHBqb2lXckFS?=
 =?utf-8?B?Z2hHMDRXcCtyOVBibDhpdEZuSTVuQ0IyclFjVmVQSUtFLzNzZS9FendPZk0y?=
 =?utf-8?B?S1dGbGFCdUo3SUpqYkxFZkpPQ0QzRjNUS2FoWmh2emRtWTUrWkk2YXN3bGJm?=
 =?utf-8?B?UDU5VEoxQ1ZjWXQ0aW93eEpLNjNGR1BXTjMxR1g2NDlnVlUwZFFkeTNrdHVX?=
 =?utf-8?B?dmFhUGpBSG80czY5Y2xvSVZmUlRGL3FSZW5pK2hFQnFnWXkycUlYd0FqVGNW?=
 =?utf-8?B?M0ZnMUNVeDEzcHBjazdDVW1yTHVpVExocG1NQ2FvQmxiY1NUOW54M3Z0a3gz?=
 =?utf-8?B?QmxKdHQraXBWa2N0WGlOb29iclFWQ0w0QXZzeENxbG1EYmF1eTBQdDlsNTFG?=
 =?utf-8?B?ZXArQ2JTS1FvcGdXNGlpMld2cVBWMXRkeHl6VUxjY3FNSDNkUmZpc01FcHQz?=
 =?utf-8?B?Ym5weXJybWxBdC9icFdoTEYyakZOc2p6a3JqSCtVMHFPQ29CMjBuMVVGQ25P?=
 =?utf-8?B?TkFZUkdlWHUrdFJwdzZwTjUxc0cxYTRzSHFkVGpkNzdoNEZwbStDekdLN0xR?=
 =?utf-8?B?VE9rZUhiL0wrZDFRSUVJelRod0xFVHRSY1N2bXpTUFVHUk9yN3RvNFdSNzRq?=
 =?utf-8?B?Z3RaUlVla2JDTDJ5c3dhTmtaamhndHgycFRXclB0Y1ZLdmhNKzhzOTc2YW5F?=
 =?utf-8?B?RWpuY0pKeTdLNHJJZlo3QVViVEhEdWtKMHVxQ0NiOUpJeUloRlFqTHpHTHp5?=
 =?utf-8?B?dUovT3kySDVhT2ZVS01GdU1LcDJhNDdXR1AxYUpyQkVvNXV1aTluMWFEcVJZ?=
 =?utf-8?B?L0U1dHYzWlVBWUNXbGgvdEppc0EwZ0kyVUQweGpDajFkcFgzc1lsc21neno4?=
 =?utf-8?B?RXl1bmduVFJkVUUvMWVaMzREQ1B5VGJYSnl1RGpDdVJKd05OWDY3ekRTSzlC?=
 =?utf-8?B?UHI3Z2JEcDA0cUtmNHA2UE94Tks3WlprTTUzT09ob3NldmxnUUhncVRJaHhD?=
 =?utf-8?B?UHY0UDNPN0pBTU9PTmJVenJuZXlvRkdCYzlVNGM3clFoOFU2ZTlpR203cnV4?=
 =?utf-8?B?WjVvejRxenhzR2ZiZ2Q3Y3RFalpPZThoMVRSTlFqWGNlRnRnZGh6YTMra3hY?=
 =?utf-8?B?T0hXTTh2U3dyeEFXbE5Ta1h1dlRxd0lWb3k2S1VtQTk2V3IycU9DUldDc3ZE?=
 =?utf-8?B?RW5ZbG9GeXJaeWxRR1I5N3lSbTZuZHBlaVB6cStIN2lLc0c4Q085SG1vcWND?=
 =?utf-8?B?MDkrbEY1aVpDV1ZxRUJlTnFNcWZkRHdmQ213SjgrYnd5TzcwYW44am1tajVJ?=
 =?utf-8?B?ZysrbWV4cEd0b0tOQ0F2Z0x6UGtNcFhTMTB3RW1lVWJScDVTWTF3TEQzUEd5?=
 =?utf-8?B?cmZ5cDl6ci9FMkxLUlkyUFEwSjJZS3lWRnBMNW9OYVRVWHBxQkJlVGVVeGZE?=
 =?utf-8?B?SFlFQVhxSmdOc1k2QmxWSjVaalo4MERZMzk4OStwTzNDT3gyeFpPb3g2djF0?=
 =?utf-8?B?K1BaaURGdjZEUVR4UHM1KzlraGMzNDVqL0oyYm10WHdKZjNkTmlxQVkvOE1J?=
 =?utf-8?B?ZFpCQzdQeWNsbE9YakdxUk9SV0xMWXdiZWhIRGtCTmt1U2JKRlVIZWY3bEZC?=
 =?utf-8?B?Y3FJd21LZlNPWEVtWGw1S3VmanphYk5mSGlmTnBUR0pqNTE5TnBLUnROZjdR?=
 =?utf-8?B?TUhMb0ROVzVyTlJaOUcxN2lKQlkzVWpoUWdnanIxRkRyWlBTZHdUdlNYanJy?=
 =?utf-8?B?SC9kR0oxY2I3aVdDTmRhc1FDb3VTc2xyRXk0MW5meFlZclJNUnN2U2c3Ym5o?=
 =?utf-8?Q?johwENVJvu3mT/94n5ndk5aWh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7C8C8C8BB860542A1E0251225A0CE64@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13e7cd3-7877-488c-cadf-08db8e78a188
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 08:08:15.9816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Rb+/iKynpc+guH+VJHNhxR66An0tZCNjMZaAjRnmvZoOgsbqnxeXC8XwpUArrssUzYwqgDuLf42XyXlkBHv0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTI1IGF0IDE4OjE5ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFj
aG1lbnRzDQo+IA0KPiANCj4gT24gVHVlLCBKdWwgMTgsIDIwMjMgYXQgMDU6MTQ6MjVQTSArMDgw
MCwgSGFvdGllbiBIc3Ugd3JvdGU6DQo+ID4gRnJvbTogSGVucnkgTGluIDxoZW5yeWxAbnZpZGlh
LmNvbT4NCj4gPiANCj4gPiBJZiBtZW1vcnkgYWNjZXNzZXMgYnkgdGhlIFRlZ3JhIFhVU0IgY29u
dHJvbGxlciBhcmUgdHJhbnNsYXRlZA0KPiA+IHRocm91Z2gNCj4gPiB0aGUgU01NVSAoU3lzdGVt
IE1NVSksIHRoZSBoYXJkd2FyZSBtYXkgY29udGludWUgYWNjZXNzaW5nIG1lbW9yeQ0KPiA+IGV2
ZW4NCj4gPiBhZnRlciB0aGUgU01NVSB0cmFuc2xhdGlvbnMgaGF2ZSBiZWVuIGRpc2FibGVkIGR1
cmluZyB0aGUgc2h1dGRvd24NCj4gPiBwcm9jZXNzIGFuZCB0aGlzIGNhbiBpbiB0dXJuIGNhdXNl
IHVucHJlZGljdGFibGUgY3Jhc2hlcy4NCj4gPiBGaXggdGhpcyBieSBhZGRpbmcgYSBzaHV0ZG93
biBpbXBsZW1lbnRhdGlvbiB0aGF0IGVuc3VyZXMgdGhlDQo+ID4gaGFyZHdhcmUNCj4gPiBpcyB0
dXJuZWQgb2ZmIGR1cmluZyBzeXN0ZW0gcmVib290IG9yIHNodXRkb3duLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IEhlbnJ5IExpbiA8aGVucnlsQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSGFvdGllbiBIc3UgPGhhb3RpZW5oQG52aWRpYS5jb20+DQo+ID4gQWNrZWQtYnk6IFRo
aWVycnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5jb20+DQo+ID4gDQo+ID4gLS0tDQo+ID4gVjEg
LT4gVjI6IFJlc2VuZCBmb3IgdGhlIHR5cG8gaW4gdGhlIG1haWxpbmcgbGlzdA0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktdGVncmEuYyB8IDI4ICsrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQo+IA0KPiBEb2VzIG5vdCBhcHBseSBhZ2FpbnN0IDYuNS1yYzQgYXQgYWxsIDoo
DQoNCkkgcmViYXNlZCB0aGUgcGF0Y2ggYW5kIHNlbnQgaXQgYWdhaW4uDQpJIGFtIHNvcnJ5IGFi
b3V0IHRoYXQuDQo=
