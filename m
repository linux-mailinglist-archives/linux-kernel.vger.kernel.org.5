Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D8753946
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbjGNLJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGNLJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:09:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594C5269D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUHDNBP8+eTqMHOUdUb7SHG+/lgnkqqwCc3wwhxkIj86tUxzUCuFfx12C2jxu4F3tWClBj6JHBW5efK1S7ZQDDTF++2q4y4ai1/zob7pejDX5Qs3OQiN68wW3K2bepmqCU/R3LAn0RIAq1aF+GSQRHXatpU14DTcfRFSFmx54c+Cs1TaD0o9hvRp03ZYG25SB7N/MPIibZnalDV0ImZREg80Vr0QHr63ipg6ijZc1oHzrzIEryJYGfUhPsoRcE9etvyhqgObZ5p+3vfDvn9iCYRKP0HsHwgCdtLbEE6W2EtkKOC1KCi1H+Vwk4XuG0qGi9f85pAfBkq0/vYj6P7dvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DAxrfqf9bvXFrVgG75re4ka2eVRf14jttvWFFlVLG0=;
 b=O0vTCwswcd+fgPAIaSuXKZWl3fDGNg4Z3cQ8ozhQJazL6I3LXhy4uE8aFRlkgrK4NnzG4doFpEmpaUx7mcji03bb3kEh/tboWWgg1bBwXVLW0lchOp3hDXSd5U4IhRTGPATEKSKF8GhWr1Ad4cgk0CGgDpVCr9OlCTv3RFyWrQ/7m3F9JhcRPFnPbTL8kuR+3MqBVhOMDTLBQzhk0994cRvsb11aKokME4G9Be052g9BZCKS239rh5yPs1yME/4rfaSQiJBIT+JtnUZC/hepQ7y8y4yj+CVOdI4Kp64okfdbbmzHmy0f1jkxoE4Vs/P+kP290d/Fg6+WqltcXsxUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DAxrfqf9bvXFrVgG75re4ka2eVRf14jttvWFFlVLG0=;
 b=QlIXnchJnzEHm6Vm17Q4YB6TaWp+yDcmhaf8x+Nkqs99IlMgFVhIohUbfW2MzXzLE9Ldhd+aX/y3q6yLW6tc7EUnHbjl7pzTXe+QwvLWLBH/gQiVn6jBVE8MqXrEU45Y0Sdg2Htu2ePOYkon4A7ufaxcd4y0e5DuJKPsXiAU2nY=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Fri, 14 Jul
 2023 11:09:44 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be%6]) with mapi id 15.20.6588.022; Fri, 14 Jul 2023
 11:09:44 +0000
From:   "Chen, Guchun" <Guchun.Chen@amd.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
CC:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: RE: [regression][6.5] KASAN: slab-out-of-bounds in
 amdgpu_vm_pt_create+0x555/0x670 [amdgpu] on Radeon 7900XTX
Thread-Topic: [regression][6.5] KASAN: slab-out-of-bounds in
 amdgpu_vm_pt_create+0x555/0x670 [amdgpu] on Radeon 7900XTX
Thread-Index: AQHZsFHnfVIY7N2o7kSYxVBf7Fxvjq+te7EggAFn04CACkK0kA==
Date:   Fri, 14 Jul 2023 11:09:44 +0000
Message-ID: <DM5PR12MB246926D9E7812B792B12446CF134A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <CABXGCsN3LS2mvXOe5g8WFC=b3N=bF1u4RCQYJN-u+k=ZEWWrcA@mail.gmail.com>
 <BL0PR12MB24653A38A6D914CFF3DB2342F12DA@BL0PR12MB2465.namprd12.prod.outlook.com>
 <CABXGCsN1cnGgMn=Jg6nYfg1GccZhPX8sa=izrr9sMxZdzLiTJg@mail.gmail.com>
In-Reply-To: <CABXGCsN1cnGgMn=Jg6nYfg1GccZhPX8sa=izrr9sMxZdzLiTJg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a0f323e0-3c8d-421f-928d-32667c33ec12;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-14T11:07:56Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|SJ2PR12MB8111:EE_
x-ms-office365-filtering-correlation-id: 26b72080-16a3-42d5-9d7f-08db845ad415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYmI/uIdLtmmSQTwTjyFdPlYFnM0Ij9ipx4ZXfCdjdvDqbmFbhniOtIxqSeLkqujnN1Kt7rzKqwT9ut1JyM/XR6ikfCYJUpZidoCwdsgLp7n3ZMFkJF3+h74p0m/hBPEa+4o0YIh2Mj0ojSuQqGylsHRlA3OGYJ4DZbR32+YB7EKaPb873nHbXJR43sAf9yoyigAyYCQnKPUqd5bjBPCkNeKqb2nVH2i9n2JmTEJKc+i8HsKflZLNI+CgTxuIUJWHL1CDyTt5/YXTa0ZCzEjdSBvCGtlCI9KfIOqCJ4kNEagwJjav4xSanE+D17dBdc0PNYTt1+hfnHvzbET25vnLIKI7EJAPEebY/y9I63wgrL83rPxGQd7bYc65OeJao5Wtf53FIesdFMoCXpJgqZtWA8Yw7ex2A+TTNbVWdfaDIr7/h12Bj38HfYff9wCKrvomPitDEby/JEfsu2b7NLPeJmjv10cszxjsQrqFALCTTQ8S9cC9Oxz8OUvn++Qj4A1JlTuuCF40gBmcPK2yHjVtGgE8u5wrHF41gQjHdaAjAGayfMgQm+n4GkEIr5Gb9nn6nvzw2z4zv9w+hik8c4wbfA+Q/OzwGqQcrDrrIi9KtQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(478600001)(7696005)(76116006)(54906003)(71200400001)(33656002)(83380400001)(38070700005)(55016003)(86362001)(2906002)(4744005)(66946007)(53546011)(966005)(6506007)(186003)(9686003)(5660300002)(64756008)(8676002)(122000001)(38100700002)(26005)(66476007)(41300700001)(66556008)(4326008)(316002)(6916009)(66446008)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG9Kc1NQUGR5allyOGV3K2ZYalZIVGhOM0lTYWh5Mk5PRjIzcENadFEydGY2?=
 =?utf-8?B?V0xIMGphbE82MG9sc05aWUh1SlVvOVkrYndDaWRncWs2OUFsdUNJdFY5OU9s?=
 =?utf-8?B?UkJvMFd5d01FamZBNXF1TGYxUEVyZTNqMHl3VFpmcXFhVEJackp1Wkg2TjYv?=
 =?utf-8?B?M2pVbmp3R1V2STFmbUxxSXhmSXFZWW00Zkx3MFhGNmxOc1JiNlRUQWJzbkp4?=
 =?utf-8?B?OWlJaE1HTWtpNUZCMkpNdmplNHNQTmJmZG16WXBCSkhHbHhrUlJoMGk0RVZW?=
 =?utf-8?B?Y0ZFK2ZBTUlqTktxN1lzMjhrNnNFQXhPZThsYXdCdVlHa2FxWndyL0dEYjV0?=
 =?utf-8?B?cnNESCt6bUU1eDB4SEdoMURWeWNid2V2bENFRG9IT0plVFU1ZVZmTTIraGFH?=
 =?utf-8?B?dzEwVURnZ21rMlFRQ3pudnQxb05aOWhvYzBPSkY0ZVJ0Sy9XZXI2dU9NSmxQ?=
 =?utf-8?B?QWdiYVUvM1BtUDhaMldEc3VrOWFDelFXdkoybjVQNC82c0VWZDF1dERLeWMv?=
 =?utf-8?B?OFQ1NXF6d3JxeHdYVWpXUUlQeGFLUnEvdkE0U1I1Um5odjhVM1p5bXBqQVVm?=
 =?utf-8?B?Wlg4UWpiOS9rSlErUkxpQU9rQWlFNXJOOUppWWljWGhjaEIrWERUQkpQbVJE?=
 =?utf-8?B?RTZ0RkQ4ZW9HSmxlekNRbEtrS0RXYmk3ZUgvbTQ4bzhsK1RJVlhrTXBhb05M?=
 =?utf-8?B?enFIejRjRDVqaEVVK3Yyamh4cnZZeXA1R0h5TXBJT3JhL0gyamdneWdEK1JB?=
 =?utf-8?B?Rjg2bGFDalJEZlY0VHdSSSs0ZjNtTzRCSEczUlphZHB5eDhnelJxMndWTnVl?=
 =?utf-8?B?Ymh5V1lCWWVwSENFRGljWnVicXZ6NVkzWEx5d29QSndqT0FlM05tbFN0UnVa?=
 =?utf-8?B?dFhVcTJaR2NqSnAwV3NiaUJmUjU5Y3lUU0ZxUEtKTlgvczZIQmgvV3ZMWWFq?=
 =?utf-8?B?N0hQMXhDRjM0RUFuelJJd1Fqdm9MMHN0MUE3NXpuRUVyWjNucDcwQkZaVUJk?=
 =?utf-8?B?SHJXbXEyeTFob3JINnNlSG4rb3Z0Y2IwaHdlOG1Vb3dWd2pna29nVG9RSDNJ?=
 =?utf-8?B?V2xldGhtSDMxbTZ0anNDT1JXcitKTUQ2YksvMHdQREkwMkcyVGprREpXaEcx?=
 =?utf-8?B?MnpPbzFKcWw0WFh6UCtLTVZPWldIWnowWDRKaDFnWHVDRzJBSURpNThUbk9N?=
 =?utf-8?B?MThBNlN1bW8rVm1jOW9XMVd3MkUvbjRCMjJEaWxkZVZ5RVhIb3ZyQzNweUow?=
 =?utf-8?B?dGM2cFRTRkdjU1RQaHBZVHB5VGN4c2E2a1QrWWs2clpyeDhiaVlwc2lxbExx?=
 =?utf-8?B?OFRnS2owSGs5cjh4RHg2emliVXErNGZWbVRnSmpTMi92VVVwenc4Z2Q0dUlK?=
 =?utf-8?B?ZFVMRHg0Ry96RkpQWGgrTzZIbDFmWGR1aHkyOXRkbmthMUFZbnZQUExSZ0l6?=
 =?utf-8?B?aXRiWkRCSzNid3FOazlqUTVGT0V1bXpyQUtaZEdmbE9OalhOZEJjTWpGZXdp?=
 =?utf-8?B?N3NFcGxJbGE5QSs1VENHVXMyaTJ2djZwTW9kRnpqTXRzNjczOXl0eVJ5QkxO?=
 =?utf-8?B?c1l4QTZHMGNKdCtIelFRdGpiQXlmMjBSRGl5MVJyZHR2ZlR4ZHFpajM3YWRC?=
 =?utf-8?B?azVpdmxHSHNGRnhPNWZNbW9Pd3ZyMWlaOUY0ZExmbE5TWElvWFBVY2MwWFlz?=
 =?utf-8?B?bTBlSmk2NndVZkpxRkxrQ05iTmp2S3FSSHdEbGxTSkw0V3QxWWtOYXVTdk9O?=
 =?utf-8?B?d0kzNkpzd0NQZThSM3luQktHdDR6MWpFTFBaUVlhc2dpak5LRnhGVWR4TGxQ?=
 =?utf-8?B?UytrVU5rY1dqWEtYUGZQYnpCOU8vYzR3NTZEakVHUXpFRlRiajg4YUZhbE5a?=
 =?utf-8?B?bzdJajZxSWE5WnM2M1BNWVR6Y2Z6UkpRS0R0dzdMa2NwOXJTTElleGc3OTVF?=
 =?utf-8?B?TWJrQmNvalFJMkhXWUJDZ0pLbldNdkVES2ZPOGk5ZnJxZW5RV3FBMmdnQy9h?=
 =?utf-8?B?Z3ZsSWFMS1VWWGtKV0lBcFlLeldMUTVQQk5KNEdONGJZYzhxZXR0cVpmVlhH?=
 =?utf-8?B?aWdNdDZJUXZ6c1hWb1BYdmNBb1VNTDFmYTVkYXJieDd6S3IxRXFxa2dPMkc3?=
 =?utf-8?Q?BTYM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b72080-16a3-42d5-9d7f-08db845ad415
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 11:09:44.2792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+/kL61d6ds5+8jgDR/ViJnmKqcOIeDbnZLM7QpoC4zCS7x6CENHbGvysCeNWNckWzUTtRoxe+uA5vng6TA96Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWtoYWls
IEdhdnJpbG92IDxtaWtoYWlsLnYuZ2F2cmlsb3ZAZ21haWwuY29tPg0KPiBTZW50OiBTYXR1cmRh
eSwgSnVseSA4LCAyMDIzIDY6MjcgQU0NCj4gVG86IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5A
YW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1
Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGludXggTGlz
dCBLZXJuZWwgTWFpbGluZyA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1
YmplY3Q6IFJlOiBbcmVncmVzc2lvbl1bNi41XSBLQVNBTjogc2xhYi1vdXQtb2YtYm91bmRzIGlu
DQo+IGFtZGdwdV92bV9wdF9jcmVhdGUrMHg1NTUvMHg2NzAgW2FtZGdwdV0gb24gUmFkZW9uIDc5
MDBYVFgNCj4NCj4gT24gRnJpLCBKdWwgNywgMjAyMyBhdCA2OjAx4oCvQU0gQ2hlbiwgR3VjaHVu
IDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFtQdWJsaWNdDQo+ID4N
Cj4gPiBIaSBNaWtlLA0KPiA+DQo+ID4gWWVzLCB3ZSBhcmUgYXdhcmUgb2YgdGhpcyBwcm9ibGVt
LCBhbmQgd2UgYXJlIHdvcmtpbmcgb24gdGhhdC4gVGhlDQo+IHByb2JsZW0gaXMgY2F1c2VkIGJ5
IHJlY2VudCBjb2RlIHN0b3JlcyB4Y3BfaWQgdG8gYW1kZ3B1IGJvIGZvciBhY2NvdW50aW5nDQo+
IG1lbW9yeSB1c2FnZSBhbmQgc28gb24uIEhvd2V2ZXIsIG5vdCBhbGwgVk1zIGFyZSBhdHRhY2hl
ZCB0byB0aGF0IGxpa2UgdGhlDQo+IGNhc2UgaW4gYW1kZ3B1X21lc19zZWxmX3Rlc3QuDQo+ID4N
Cj4NCj4gSSB3b3VsZCBsaWtlIHRvIHRha2UgcGFydCBpbiB0ZXN0aW5nIHRoZSBmaXguDQoNClRo
YW5rcyBmb3IgeW91ciBwYXRpZW5jZSBvbiB0aGlzLCBNaWtlLiBJIHRoaW5rIGh0dHBzOi8vcGF0
Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC81NDc1OTIvIGNhbiBoZWxwIHRoaXMsIHBsZWFz
ZSB0YWtlIGEgdHJ5Lg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCj4gLS0NCj4gQmVzdCBSZWdhcmRz
LA0KPiBNaWtlIEdhdnJpbG92Lg0K
