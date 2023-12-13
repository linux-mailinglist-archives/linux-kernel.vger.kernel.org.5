Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F0810A08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378550AbjLMGOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjLMGOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:14:07 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B0F83;
        Tue, 12 Dec 2023 22:14:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU2Kd4NjGUn2ujHXIuBZr+6TKKG1xLOe9OOAwjRDcAxPTAfynahqBkBpXz0bD1GF9wC0WgCB6ztAkNq8WZjDtiEy55STR+xJuDOmfNfhb5xZe3Ya8agZX3VJSoWW9fFl6SuJ3gi1SeP2JrOC4SeWP8/8EeVe8woGcDAsLDsGo2+gYcWHHJnKtKJw+qFJxE/UgNpu71c7SfMs0GO2lzjez/DfyAqy22oyH16xzxMK+2Xgz8WUlQe4UH2UJ8KhloDOWNPxTd5h6pS07nz54sEzr1hKWqiP/GeNuLb5+Lw1xZRr+gwFoPPpdK8Mh1WIFWKOLTNqP9nc94dHUEVMUS110A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r77GWOKd25hBzMihfwFMqBcCL2fBwgHsNyen6uztrwA=;
 b=hqJ8sZmuFMQhGTQzniYHAmgc2xhpP7bbidCSby3q4GliHo69F6A8DHv69OEni/d5p2740l+vs4okHmGygSe9qrPJvbQipvcUHSm74ydZuU8DR9nqN8iBdwUJ8aq2o9eFRs/Vb9mLQsDBc5Bkerh4qN5oJhdmm68C601lLCyNHYByOQj2KAnI5GyTaWJeI+wQkxA42MMj4NxdCmtUyberGMWFAfxH7Cg/n5pztghu8nW+PNGfzIn2Wh5LMz5b7Bn0MNasdXIMNo6gITi6c4/cBYy61WFsBet8Bv0yAPtvdOE0imR5rgsBUtyv6j81KdR5exbcgMf6URKcPzmGLlxXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r77GWOKd25hBzMihfwFMqBcCL2fBwgHsNyen6uztrwA=;
 b=WbWjD9yMkJXIjYvFR7IS14bfzniMN+Qd0wThu3wS5xi12IspgNDLsUS51O09Sw+vRYFSUxA92E6MJ2ifBZ5bAcN30GDI5+O8fs/SOTJQD/q6xh6WJtATqR4vP3TYhuTl8cjBDV8qJ934jXlcu11zupbCTc9a+s4N5PywI43R8Ds=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.28; Wed, 13 Dec 2023 06:14:11 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::3b8e:a932:cf6d:9ff5]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::3b8e:a932:cf6d:9ff5%6]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 06:14:10 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] cdx: Unlock on error path in rescan_store()
Thread-Topic: [PATCH] cdx: Unlock on error path in rescan_store()
Thread-Index: AQHaLNx2uT2OPy4kmkmbwFoytZNg9LCl7m6AgADNvKA=
Date:   Wed, 13 Dec 2023 06:14:10 +0000
Message-ID: <DM4PR12MB77655BA189E1F71716F436E68F8DA@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <8c79956b-bf8c-4511-97cc-a16833a0630f@moroto.mountain>
 <94c5f197-9459-40fe-9c34-06359779a51a@wanadoo.fr>
In-Reply-To: <94c5f197-9459-40fe-9c34-06359779a51a@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=7a9eb470-b8d2-44e4-9d47-e58006f4ade5;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-12-13T06:09:45Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|DM6PR12MB4284:EE_
x-ms-office365-filtering-correlation-id: a485bed3-254e-4ae1-d73d-08dbfba2b8c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPzD1Pb7TjyxwGZc7T3bRnIrnT1cf3WihmFTOaUIeOHvybgZ7hCjW7IOvC3IGy9setXD7hjDnQjx+/i9KjcDg7eQ2AWeGGk+cL458mpP1ngBi/hgok3GMjvfSeRwa+WOArXmAbXx9Q62AHkqEvjpQXcH42BwOmsE9MFKK9Sjf2NMvdEVCjj+ETzzAVf5wTsqRkSlaKiymBJcxSzEi44sjRCdkMYTmPoiTBcYji8sLNQdvekT4V2JAAMI21d6nks7yutybQvkLNhRwn1DHLh3qVzsawBb5xRSo6J++0l9bJvTOF9b/SV2Z9ej1q0D9KceNFXjIMFuj50Mv4pcQ1Ub9wHR8lf6mQxeCPFjSRKLK26tvL7BbHJ+kJMIecmQJD4YL859MRXUuJmu0kz+fjWHsrf8EhPctJgw0ROWc6xpZXNIBVCHB/2FjPYuNiIFNXZlpy41G1hfhQmlcPNdyikydA6hTU/ziu0iXl+m0mLn2M8bxEhSVxn5q85I0UVx01oO+BiGewgUUp3dqSoJGgh6/QWolTdrMQXWKSe0qWRbV+ZCJnrn+uFmLobxr0fD9C1K/SaBuIRnnj6MrBYtXPQLKyLVKzIr/bVtEv6nBIllZwY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(316002)(26005)(66574015)(83380400001)(9686003)(6506007)(7696005)(41300700001)(8936002)(5660300002)(8676002)(52536014)(2906002)(4326008)(478600001)(38100700002)(71200400001)(110136005)(122000001)(66476007)(86362001)(66446008)(64756008)(66556008)(76116006)(54906003)(66946007)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXpWL0F1SktpV3M5U01vT1RUVU43TldTWjRxUzdVSjZhUnc4RTFzRS9ZTjBJ?=
 =?utf-8?B?WVIydE94bTFaSlhmNXF4bkl2L25jN2JyZVBsK1VZUGptV2tpc2xpUjBXcUd1?=
 =?utf-8?B?QVVkVVBBYjIyUTlQSzVaUVRqUVRDQzlKNkVDbHh2UThTODl5NWJwdlhtbW9H?=
 =?utf-8?B?NmNiRFhZaHRzTWdaUWJkekVFMjhKNktKZW1USG1Cd0FoY1BEbTVFbVdRcFlR?=
 =?utf-8?B?NnU3N0tsUmJrU09EYjd0R2FabzVacmhySkl1R0lnRkZUbWIxdkhjTE5kWUxF?=
 =?utf-8?B?c0p2RDVmVjVTZ0NaelM3SDFLZjNZVUh3bUIydXYzb00vOXFkdDNMeS9MSDNw?=
 =?utf-8?B?Nm94U09WbnJmVFYwU04rSDVMY0JmS3FSQVhEREN6WUVGeFRFUEpOQkpIVnBO?=
 =?utf-8?B?dDB3WnVWeXJlMmxVNmU5T0lvcjAySjNndlA0WHR5UEROTjlVZkg3eXB6SUVu?=
 =?utf-8?B?OEZzdUxKd0p6VS96K3lHVGpWWW9NbXU5eCtBZjdtVHhkYVY1dUJPSkFSRXR5?=
 =?utf-8?B?SnRLcnBqdXNTMjJtZ2ZmS3Q0VklPWXY5VGRmMzYwUGVXalFZNW01bG82WUo2?=
 =?utf-8?B?TU1tTzhFY3NmbzBWK2RQWlJPQmowQ0paVWlvemJESEFsSGlOVHh3MlB2UExj?=
 =?utf-8?B?Zm9zUDRqakpHMjFJMWxOYkNlc0hlc1JYTG9iRFZNWXhwZ0VHRnJxVU9OZHBr?=
 =?utf-8?B?V2lNTWhQRXVIVVBqNkNzZm41TVUzMmNtVndqUVRMRUYyejZXK2hJakZaNkRU?=
 =?utf-8?B?aXZxTFJsS25ZRVhUa2JSYW41MUxBWlNnb0hiRjZLVXg2WEhidDZhRGpQV25B?=
 =?utf-8?B?VThmTkpEMVFOeTNmOVRLTGFEZ2d6d0MvS0lNVnh5VHVselovZFhESnFjMENF?=
 =?utf-8?B?cEpMVlJONTJkMElYTTgvd1N3NUZRTGlmbjhsUDdFZVQwR2JsNkJ0N3BFcGJp?=
 =?utf-8?B?SlVmZCtMbndkNmFYNFJXTGJQYVhYZzFDUzJtaStpYTFiOU5MeEJ1RGVkdE9R?=
 =?utf-8?B?MnZsWjcyVjBPNWdZZEtzUit3Tm0rTzZYakw5M2lIdGhaN2I3VDRPdk9KUytv?=
 =?utf-8?B?SjVFcWxsVksrMEJuaUVDcnExR1kza0hqOHRwYmZyQ2Z1V2I4Ym9lcksrWTEx?=
 =?utf-8?B?a0xicVNsWGtvQUV5Q2ZZaVJIc0FwK2hXYU13NlFCWE8xcWRSZlJ0VE9uVFdt?=
 =?utf-8?B?UmtoMDVaSFRDK2IvRm54Z2xnRHlhQmV0azJEdGN4dFpjVnJ4YjhvblluVklx?=
 =?utf-8?B?NzU3U3YraGc2elJZcVVlRkpBbGpIdzdrbmFzcWtEYmpldzVsK0lvZmNFeTg0?=
 =?utf-8?B?R3hGTVJSRi9UNkxKRVE4bmxKWHdDYlIrQ2laMnNJeDFFcWMrcFQzcXpoak5C?=
 =?utf-8?B?Y291S2ExQm5ucEFYTlNNVit1OGhaQ092bDhUbWg0bUtGMXBxT3BvVjRkMHVn?=
 =?utf-8?B?Y1d5Y2RhSy9YT1Z4UlNsZXJGNFdBK0k0YVlnYllRZi96U3E3U1ZzSWhYdkNp?=
 =?utf-8?B?REs3SXFXb29WQ0FPcllTQmFsK0xaSVpiU1B2VmJQNStsVjF2ajdjTTBCVTJm?=
 =?utf-8?B?dGVQMFM0WWtXVVh3TGFCQnVyZ0FlRjFvcG5vMy9POEpDK1I2NE1OWmNRdEMw?=
 =?utf-8?B?L0xnYllVbEpvTzNnNDIvamR1aCtHYWx2cVBLM3lSdnQ5T1lNb2I0ekg1WGh5?=
 =?utf-8?B?Q3M3dGhzeVVnM04rNE1nWC9PN1dYK2N4MnJkbE45dkRlSXVjNmpldzJtVDJl?=
 =?utf-8?B?QmgwQk1YcWZyUlFnY3QyZGVJZGRzM1lGT2J6SXBHbEJLbTRhTnJpMnhtNHZ3?=
 =?utf-8?B?a1ExR3hDcmVBZGZEV0gvTE9CWVM5ZmhCQ1Vwbm16YXA0T244NmNheXd3bERt?=
 =?utf-8?B?QjhBVVd1cEphcXFCQnQxOG5XNUFUZmE2aXR6RWtuUUZCdVRoaHArVWtzNmgr?=
 =?utf-8?B?NXg4RjF4TGlPME1HWU1ZVnlCWWcvNnA1RFBGMkMyOWs2MjZkYUhNc2RmT1dD?=
 =?utf-8?B?U2N0N2NNSkRaMi9CRHZCTVpVNTBQcng3cWpPM3N4V3ZFOCtCYkd3T2NvcEZQ?=
 =?utf-8?B?M0gyTnNQdWE1YnYweHA2anhIVCtMKzFnU29WZW83RCtOSFFVaUNVUThReHMz?=
 =?utf-8?Q?P2nw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a485bed3-254e-4ae1-d73d-08dbfba2b8c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 06:14:10.5684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGdcKuIdU/ljRcYcokFEtIX2uOteNkYCF+1p3MQkXVT3MDjCglsCoCSXk2cWt3bT3h0DEql+Z4nxqihrCK9WUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBMZSAxMi8xMi8yMDIzIMOgIDEwOjIwLCBEYW4gQ2FycGVudGVyIGEgw6ljcml0wqA6DQo+ID4g
V2UgYWRkZWQgbG9ja2luZyB0byB0aGlzIGZ1bmN0aW9uIGJ1dCB0aGVzZSB0d28gZXJyb3IgcGF0
aHMgd2VyZQ0KPiA+IGFjY2lkZW50YWxseSBvdmVybG9va2VkLg0KPiA+DQo+ID4gRml4ZXM6IGYw
YWY4MTY4MzQ2NiAoImNkeDogSW50cm9kdWNlIGxvY2sgdG8gcHJvdGVjdCBjb250cm9sbGVyIG9w
cyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5h
cm8ub3JnPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9jZHgvY2R4LmMgfCAxNCArKysrKysrKyst
LS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NkeC9jZHguYyBiL2RyaXZlcnMvY2R4
L2NkeC5jDQo+ID4gaW5kZXggZDg0ZDE1MzA3OGQ3Li5mNGY5ZjBjODhjMDkgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9jZHgvY2R4LmMNCj4gPiArKysgYi9kcml2ZXJzL2NkeC9jZHguYw0KPiA+
IEBAIC01NzIsMTIgKzU3MiwxNiBAQCBzdGF0aWMgc3NpemVfdCByZXNjYW5fc3RvcmUoY29uc3Qg
c3RydWN0IGJ1c190eXBlDQo+ICpidXMsDQo+ID4NCj4gPiAgIAkvKiBSZXNjYW4gYWxsIHRoZSBk
ZXZpY2VzICovDQo+ID4gICAJZm9yX2VhY2hfY29tcGF0aWJsZV9ub2RlKG5wLCBOVUxMLCBjb21w
YXRfbm9kZV9uYW1lKSB7DQo+ID4gLQkJaWYgKCFucCkNCj4gPiAtCQkJcmV0dXJuIC1FSU5WQUw7
DQo+ID4gKwkJaWYgKCFucCkgew0KPiA+ICsJCQljb3VudCA9IC1FSU5WQUw7DQo+ID4gKwkJCWdv
dG8gdW5sb2NrOw0KPiA+ICsJCX0NCj4gPg0KPiA+ICAgCQlwZCA9IG9mX2ZpbmRfZGV2aWNlX2J5
X25vZGUobnApOw0KPiA+IC0JCWlmICghcGQpDQo+ID4gLQkJCXJldHVybiAtRUlOVkFMOw0KPiA+
ICsJCWlmICghcGQpIHsNCj4gPiArCQkJY291bnQgPSAtRUlOVkFMOw0KPiA+ICsJCQlnb3RvIHVu
bG9jazsNCj4gDQo+IFVucmVsYXRlZCB0byB5b3VyIHBhdGNoLCBidXQgc2hvdWxkIHdlIGhhdmUg
YSBvZl9ub2RlX3B1dChucCk7IGhlcmUsIG9uDQo+IGVhcmx5IGV4aXQ/DQoNClllcy4gb2Zfbm9k
ZV9wdXQobnApIGlzIG5lZWRlZCBoZXJlLg0KDQpUaGFua3MsDQpBYmhpaml0DQo=
