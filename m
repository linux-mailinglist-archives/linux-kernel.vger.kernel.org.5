Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC727C4167
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjJJUlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjJJUlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:41:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AC299
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqvKLl7xvJDIqecE17Y+4uH2xA9WdQlmN0znJvCM4n2bmlsfGW/9tI+fO2uI2sUjd3x0uGw7EFLACN7y/BAAc2YJEvf2KOnDimhf1k3P60NQ2cg7XKFLfm3p8ClxzrNiPJ8PaJcURG3m4PxdvgBmjBrYNsmR0f5S+LwfKS3oumMA1REx9PYOpLlqzFq0eGbSkOUTjxADSNvjUtDOfs6SqLSHuNdCX83+ibKndl7RNrLbFHykRYSSMplUDjVcVBw1NyhxiP/PQMflGNX+DfnzI+ds5lzbdLs71q89I+WwRYbrroCb0F95Pu5/0Rq2Kb9/cPnpMdendQvCacPI7aWXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xpVN+pvuI3NvMBLiMs7QQAv3onS3bMa0YY9QtfsQFU=;
 b=CyhrMrjwxLJH3bjdb96OX9QQZrv2Whk6MT9RdEIcnjaKBzD0uQ+t6RPDRADDm3kAEpGI4ye25z/+uN8vzsmtTB8Ro1R/QIhG831TzP6SKdkZN/oLgtmIbJ4qkeJNzIyol9CyFlmyYbuiQSO5YE1S5fGl4rkamuodtnHmZdldUlfKKqPT2W0z+hPjSHSRB9lmgGAfSZY/E4QqoG5JDIrEMZHUXXbQvpTOIOHEamqR5tUcOUrUoPF9ELP0ICW9pieK4n5rYRVJs/krPElbY33lIeSlExPY/rMb2bnQ6YAshjIrSxY0mAM4YTerPwG7ApD9sz9vN3Vx42hO4lPbYgN0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xpVN+pvuI3NvMBLiMs7QQAv3onS3bMa0YY9QtfsQFU=;
 b=PiHPDT7PXmN/ztrM19k1eSybVf1Ht8hmuLGky13dZTlACoE/KFU6jI0zAqt8YPuyMttZTI3Ic8YolT5fl+WOAIrhJLXpUxyQ3eVeDfSEpEft6J3Obdvw4POdfAvvVVfpb0XhIRwkiarAF/C4csGDZoMgkUDVhk6CHDotgld+4UI=
Received: from SN6PR12MB2702.namprd12.prod.outlook.com (2603:10b6:805:6c::16)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 20:40:50 +0000
Received: from SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::293a:d73e:e856:543a]) by SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::293a:d73e:e856:543a%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 20:40:50 +0000
From:   "Kaplan, David" <David.Kaplan@amd.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Borislav Petkov <bp@alien8.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Thread-Topic: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Thread-Index: AQHZ+6IBLvdXTEvlc0iXV2L0Ns7JGLBDcLGAgAAB/oCAAAQdAIAABBJA
Date:   Tue, 10 Oct 2023 20:40:50 +0000
Message-ID: <SN6PR12MB270271533C2CF0BCB7CADB3B94CDA@SN6PR12MB2702.namprd12.prod.outlook.com>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
 <20231010201912.7pjksbparssqu34k@treble>
In-Reply-To: <20231010201912.7pjksbparssqu34k@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c2fa3f60-205e-4576-88ca-aece6e4073b0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-10T20:33:46Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR12MB2702:EE_|IA1PR12MB7543:EE_
x-ms-office365-filtering-correlation-id: 62e79dc4-c5f5-4032-c297-08dbc9d130a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BH123s8ViKB/TL88OUamPmL1fyCPKcVfNqVNpyROyrrvprCyA4Z1cEzdAQJgG/ikaeO9YtmOAJaj/sKJbkgFGlw/xJhaRnkWveAyIc3MqVLAwlahsPLr/5RFeSZ8cdFXzofNs3vYnqCzi8e6I7MyL5eV5FYxmLvvXmg0gtC5WMTUC7LlJqzuycKvC+2Ai3fzslo44X+CSTcT6a5a2l4AvaUnzwABSG3akEHGccvRMSypV75FxcgbCcvbvK/N3h0xY81Pun6AZAzoZZqOcpP43lZrBqmy0TwVxhBZxWdRRjt0dP3z3UMF1iHp2CKI9ugUahrkHQpBSCiNPUJvAL8G9QC0KhQinPL7qikM0zhS0nE7ZY8llNFFVKSQ6YTgzBspfKS+JARUUDdOSkWwoSslnFOU8XWX34YrLuHsFHFhhvQT2zeQx/UrTWanP2FQLzoN1VgtVl6R6tPqnKfLrwmMYq1JF4Od/VdoRMInhljJJtZpzuMbqS/H8rdS7f8DnAyiHpn+GdOz9lnq7j9ririaheysqKfwsOAac0ILfceTcsP+v1BfzI6zIGZtirYI6EnZopvez7LIF2BsWvZaLBrJmMGa4SrRLvB3aFcjyS6GMW76GDq0TM+HGzgtInI6dwz5bmpYTeKBCOPEMNpDtu2DHA2mbRW2QvTihy67WTYc21seFiAbAYZKUeJUPnZTxrXE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2702.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(33656002)(38070700005)(55016003)(6506007)(53546011)(2906002)(316002)(66556008)(66946007)(64756008)(41300700001)(478600001)(9686003)(66446008)(76116006)(110136005)(71200400001)(7696005)(66476007)(5660300002)(52536014)(54906003)(26005)(8676002)(83380400001)(8936002)(4326008)(38100700002)(122000001)(142923001)(101420200003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGMzWTEyamVPKzlsYUpyNXo0Wm51eVF2ZU93aTNFUmFOUi9sUFpQZmFOZk9T?=
 =?utf-8?B?WkNBUFcwMDdhSDlXZVhBZnRWYXdwRnRwWVB0SzJ2ejhLQm03bEZCTk5HMXVw?=
 =?utf-8?B?RXNkMUdWM2RqZy9CUHhpTVc1K0NzQ0psMEFpcVUrQk91QXFHenRFR1h0UFpk?=
 =?utf-8?B?UkJNUHE0aEttK2dZM1hQWSt4SGVNSld1N25EbmNUVXVMVUtCN2ZCWGtVOVRU?=
 =?utf-8?B?N0JKaEFZVlYxSDdYVkJsbXVOWllUS2h6K1NwWHhLMDJNekVQbWQzZCsrZWFa?=
 =?utf-8?B?bTFScDMyeWNNYjY4UEFwK3NSWTVEbDhCNDB4UUV2LzBlemVoekNuT2dFQ25L?=
 =?utf-8?B?RVBsbE5US0dmcUV1WHRWZGJyMGpkeFAvNkVwTDh5NmlGNXc5dG1vQTl4bmpG?=
 =?utf-8?B?WHB5cWxqRkhWaEFhWndtMzh6ZzRkWmJwSjRLWjZ3TUw5V0RrbmR1MGxFNmV6?=
 =?utf-8?B?WHdyYXJRekYxeWZvNGVFRW1PQ1N0WElpSkcvS3NBV1RxcUJVTTBMU2x1d1py?=
 =?utf-8?B?NGpZdzJyamlhV001WUFsTjJhQisvUmpxZzN2OE9MWW96cmQyVytNenMzbHNs?=
 =?utf-8?B?WUErd0Y2TWJCWmhmMEg5VjRhQ292VjhpK0paWXZ4YWpVWlpRWEd5R2IzdDdZ?=
 =?utf-8?B?cjhMM3dKdWFYYXpHN0ZlcWoxUmk4bkVKcGk3d3d3ei94N0xqNGxycXZZODl6?=
 =?utf-8?B?ZEZaSFBnMERQVjZqUzZmcEE1U2EwNlJLUXRuUHNTTnJybEdiUVZxalRCSGd6?=
 =?utf-8?B?a3MrZ2hKQUxFbEFOcEF6S3BieldoLyttVkFoeGJtd0trb1NDNVM2elNxM2lv?=
 =?utf-8?B?QnJwTW51S04rcWZYR0ZXZTNTWE5VL2RGQWFMcGNJcSt3SHcveVZ0MFk5c01Y?=
 =?utf-8?B?WmtVdEdSZGE3Ym5FYVk3ZUJGUWROVTVHSU9MRXhmV3RtVVlzN0JxSDI0MFY0?=
 =?utf-8?B?OVkvYmhVbTA0ZmtSVSs1ajBKZkVMRDNheDBJdzBmZEpob1EyWjAxNVFSTEtq?=
 =?utf-8?B?NnRwTHd3a2h3cCtUaVdoWjd0T3U3VHVTTEhaVGJybWEySDl2Y2s1Zm9zRVFE?=
 =?utf-8?B?V3AxNWtUMGEzb25hVzdLM2xMMFZiWmFueTUyWVIvT2w0RzJtVStSVmU3VDEw?=
 =?utf-8?B?YUlVc1VOZk10N1JBeDI5aFBVSlhVNUYzclYzRkZrdk1BWkZzdmNXdGhYTEwr?=
 =?utf-8?B?SjFaS2FPOFpIU29BWWV5SGZpZ3dJTlZId3UrK1IveFR1N2Jsbk5kZkp4ZjdL?=
 =?utf-8?B?M3hpb0RWUWQrTHh0MHdEdFVoaG1lR1pKVkFIOGh6bWpxdkczUnA3ZGxxcXhO?=
 =?utf-8?B?NThCZGZyRW1COU1BVkpVNzYwaWZib2JPZ3NvVERxMDZ1MW5TMVRUTDIydnBN?=
 =?utf-8?B?dnFNWWRiR1FJcGtTSjRtb1ErNno3K3NSakEyeDZIVkF4aXdwYWt1WUJkTDZG?=
 =?utf-8?B?TTYwS1JSMElPa2Yvdm1ncGQ4NjNhY3YzOUtkUzRzeFBRemxvREdtK05XRVBC?=
 =?utf-8?B?VWEzQU5ZUWo3TzMwbGpKa1Z4WjZzaUczdUVvWFVyN2tJSEkzenloMXFIaC9W?=
 =?utf-8?B?aXZuZjJ1b1dnTnRpN1VucGFScjV1NVdIZzJyc0FGeVA1aExQRXJwaTZnRk44?=
 =?utf-8?B?OGNjWUUyL005Sy9PRi8rekZSOVZDOXhLL0VoQmQ2akFXZjU0MmtxVzBwVnJR?=
 =?utf-8?B?Z1cxU2Q1YklMQUZMdnJhUkVLd2lwMVM4UVg3QWFXVklEOGxRY3lUM2RUZjli?=
 =?utf-8?B?UzhySWFHYXVCaGVlVlpXR2NMWWJtK3VqMGxWc09hOEJYMHNFL2pJUW4rN1V2?=
 =?utf-8?B?aTgrQlBPVE1qcEVMNjlMNFc0WnZPZS9UTnFYbGhkQ1N6aWNTUHBoVDlQeHdO?=
 =?utf-8?B?TkdzZTNvNDRYRjdhUnlMVTd1a3BaTWxZVEU2djRlYkhsQ2tEWkhnRzZDeXIz?=
 =?utf-8?B?T0J6MmJCaTY0TGwrVkZrSE90QVo0L0RQL0Z0eTdOb3U5YU5qUCt5WVhsbWRz?=
 =?utf-8?B?K2JoLy94VXg4dFNUd0VGQVZ5YldmMUltL2hmTnRLUnpKeE16Zkx1Nk1zVmpm?=
 =?utf-8?B?UUt0cnBZdmkrazRmbDV2U2l1MVlNeGsxTHNzTjlzU3FvSkhtUzdlZ0dGeHlD?=
 =?utf-8?Q?jBaY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2702.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e79dc4-c5f5-4032-c297-08dbc9d130a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 20:40:50.4605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbxcvBp2Hs1s+EMI4olFRxFeWA9W9BqsaG5AfWsL2/MKTFPTsfX+EeHTmtkgidQl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+DQo+
IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTAsIDIwMjMgMzoxOSBQTQ0KPiBUbzogQm9yaXNsYXYg
UGV0a292IDxicEBhbGllbjguZGU+DQo+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+OyBLYXBsYW4sIERhdmlkDQo+IDxEYXZpZC5LYXBsYW5AYW1kLmNvbT47IHg4NkBr
ZXJuZWwub3JnOyBsdXRvQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBSZXZlcnQgIng4Ni9yZXRwb2xpbmU6IFJl
bW92ZQ0KPiAudGV4dC4uX194ODYucmV0dXJuX3RodW5rIHNlY3Rpb24iDQo+DQo+IENhdXRpb246
IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJv
cGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywg
b3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMTA6MDQ6MjlQ
TSArMDIwMCwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiA+IE9uIFR1ZSwgT2N0IDEwLCAyMDIz
IGF0IDEyOjU3OjIxUE0gLTA3MDAsIEpvc2ggUG9pbWJvZXVmIHdyb3RlOg0KPiA+ID4gQWxzbyB3
ZSBjb3VsZCBtYWtlIG9ianRvb2wgcHJvcGVybHkgZGV0ZWN0IHRoZSBub24tcmVsb2NhdGVkIGp1
bXANCj4gPiA+IHRhcmdldC4NCj4gPg0KPiA+IEkgd2FzIHdvbmRlcmluZyBhYm91dCB0aGF0Li4u
IEkgZ3Vlc3MgaXQgY2FuIGNvbXB1dGUgdGhlIEpNUCB0YXJnZXQNCj4gPiBhbmQgY29tcGFyZSBp
dCB0byB0aGUgYWRkcmVzcyBvZiBfX3g4Nl9yZXR1cm5fdGh1bms/DQo+DQo+IEZpbmUsIHlvdSB0
d2lzdGVkIG15IGFybSA7LSkNCj4NCj4gVGhpcyBzZWVtcyB0byBkbyB0aGUgdHJpY2suICBMZW1t
ZSB3cml0ZSB1cCBhIHByb3BlciBwYXRjaC4NCj4NCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL29ianRv
b2wvY2hlY2suYyBiL3Rvb2xzL29ianRvb2wvY2hlY2suYyBpbmRleA0KPiBlMzA4ZDFiYTY2NGUu
LjZjYmM5ODEyYTM2ZSAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvb2JqdG9vbC9jaGVjay5jDQo+ICsr
KyBiL3Rvb2xzL29ianRvb2wvY2hlY2suYw0KPiBAQCAtMTYxMCw2ICsxNjEwLDExIEBAIHN0YXRp
YyBpbnQgYWRkX2p1bXBfZGVzdGluYXRpb25zKHN0cnVjdA0KPiBvYmp0b29sX2ZpbGUgKmZpbGUp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gICAgICAgICAgICAgICAg
IH0NCj4NCj4gKyAgICAgICAgICAgICAgIGlmIChqdW1wX2Rlc3QtPnN5bSAmJiBqdW1wX2Rlc3Qt
PnN5bS0+cmV0dXJuX3RodW5rKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGFkZF9yZXR1
cm5fY2FsbChmaWxlLCBpbnNuLCB0cnVlKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29u
dGludWU7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsNCj4gICAgICAgICAgICAgICAgIC8qDQo+
ICAgICAgICAgICAgICAgICAgKiBDcm9zcy1mdW5jdGlvbiBqdW1wLg0KPiAgICAgICAgICAgICAg
ICAgICovDQoNClRoaXMgbG9va3MgZ29vZCB0byBtZSBpbiBteSB0ZXN0aW5nIHNvIGZhci4NCg0K
LS1EYXZpZCBLYXBsYW4NCg==
