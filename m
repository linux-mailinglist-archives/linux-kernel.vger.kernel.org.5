Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44317C40F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjJJUOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJJUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:14:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3830B0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvk1wxRnLdaoqcLJGqJeyiYifja9zwBY2CPH/8lK65Z/w4dkQFL4m0tsQCAkqs1gzWvbR+mrFW+scc6W8GIce3b23oYcU8UUHnIGjY4V2vXeMKiKtm0QWBtt3b9gKliX3vPiTrbpWw6JPM0ZscaBgRuLLZBfTTq4jSpNlQjQTImT9P27klPkoqmoEkzmfhdL0EDVg7MIUxSwRxlC7onWRnOkvWqL6LoFiW17jLQag7WZ0tXv0he4i+8yPq3adwwzRZHltWTaGxw8gMQ8ssS6a2heLY3Ssa8aoMZY+2M3NHSAy3vBIIaIqHG7RA/Eci0VwEKzt1Glxr35yZWTb+nWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPKwp1BczmOzF7zeHzwuHPf6y9au47vPrDeS1lLPVFI=;
 b=HPbYI2Ap6DwHnIevQBcz+cOh8BhJ8Ia62Icz3e/XRWvuwJa8vTubmxgjfC0I4T8bKgMI2Ro4aeeik5ze/0XMjOajCL03Rtm/CfC1UJsZvJykSJUP7dVni4KGMH666o4PvYozJBgVIpTSITEZjOczF/YjHYKII9SisfPjXmlXJYuKJaYyD2plGRe6AanSWgeiHci9LpAP36IKgp9R3wu/xuGZ8nf+36psiqRys5JoAl+aKeVPjDZr2INK4o5AYNGE9ptSk1j0U4LN4sVhpgBNRc+PMnyhF0fhr7ssDiddo63RN7Yt5vxDAlhvL4MCmWiI/b2JadbomubB2LruJG7uWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPKwp1BczmOzF7zeHzwuHPf6y9au47vPrDeS1lLPVFI=;
 b=AEw6HyX60EbdngRwOLeqiCAzHcVGjpY7lUp5B/Fx0j6YzGHi5G5ac8lbWltT8uSBtO2jH69iNn0UkUNUECDiOLHQzLgu6XA46gyryj5CV1/vtCljZnMvf2RQ3FcfeHVEo1r1VX5+fxLtlHfKydFblL1sAvqwySYSiLMUApSiKXY=
Received: from SN6PR12MB2702.namprd12.prod.outlook.com (2603:10b6:805:6c::16)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 20:14:33 +0000
Received: from SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::293a:d73e:e856:543a]) by SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::293a:d73e:e856:543a%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 20:14:33 +0000
From:   "Kaplan, David" <David.Kaplan@amd.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] x86/retpoline: Ensure default return thunk isn't used
 at runtime
Thread-Topic: [PATCH 3/3] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Thread-Index: AQHZ+7EfdSMbERFYTUCoQSUf2TwgdLBDcktg
Date:   Tue, 10 Oct 2023 20:14:33 +0000
Message-ID: <SN6PR12MB2702315F5C39E5354D63E68E94CDA@SN6PR12MB2702.namprd12.prod.outlook.com>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-4-david.kaplan@amd.com>
 <20231010193643.su6iqjniuxqqke6d@treble>
In-Reply-To: <20231010193643.su6iqjniuxqqke6d@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b7d60f75-971a-4855-bc40-1ac1c1e159fa;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-10T20:03:29Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR12MB2702:EE_|MW6PR12MB8914:EE_
x-ms-office365-filtering-correlation-id: 95ce87f0-ba6d-4c29-70aa-08dbc9cd848e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ODfqJkK4V9Tp2JA+u/VeuLQxmlj6woCdZjdJXrhb6MkWz42f/LN0e2ZwWuhHM9+4vQUaQhatd3JAIrrXORzCNvFDsWUv5arQ92VXXiby9qV/xzlZOVVMBxdtMBunDuWvqQdJUAKs0CmAYHsiZks0lRPpQKxU1C25NtFSm+0ofCXRnPjytzDPaUe0qT8mjxYKRTGO1GiqQNlHw9a7RcYMQGjT/uH6wGDwFV5NDDQ1NR6PCMAxNeZ6+8btSwzZk6+YPtFsh+iQWc0OhJyyCbJr17ylAaRUMLh1mC5z5kscXVf25Ao/qoraRSVPXLbmjhWw40fpDKC+tlWYfly+PuF3H4YbckQje3Dv9CwrXC7cTJ/L22wOmjuKdOQWsx5bUWnE7q+oQ5GVSuG3fkxd1iOURzBp5pF4UMMojgAUdODQlefQiXDEVYL1LorrtNpg/jfXGU7lLgINakxg+fr7o/963ex6D8jzICfLhKTnB1BRWXfXFSY4Km/ih9yDlVSELJ8OiIdT7V+o1mcWNimF5543cXOdHGncVuP2TSJMm+LN3UlR9aZ76DmFeETQtkpRhRtNz1EBQ8cOvUxQuTYi/touCDh5fzYjwb4RB/p+rz8rOTLZEPkzcnFZFXbuAeAgsoVY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2702.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(55016003)(478600001)(52536014)(4326008)(83380400001)(38100700002)(122000001)(8676002)(8936002)(6916009)(316002)(66446008)(66556008)(64756008)(54906003)(5660300002)(76116006)(53546011)(41300700001)(9686003)(2906002)(6506007)(71200400001)(66946007)(7696005)(66476007)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1dQMEwycEpNNTVITnZOeTNkdHJ1SHhtU3dxOGFWb2wrYnhraDNqZmFNTlRo?=
 =?utf-8?B?Q3hhL05TMzFMSnNzcmtZOTlXN01YeVZiYWZEK0ZtTk5sNFRRcmY2enBqb2tU?=
 =?utf-8?B?MkVpYWhIUm5VQ2VROVNDR2NwVTN4cmhmNTN6WFVISFNUWG55cUl4Y3M1ZVZL?=
 =?utf-8?B?ZWcrdUhib01ZTnRJZE1iYlBxRFNPTFhlb1UwV3UyV29NcW5lKzNKMnpTc0FO?=
 =?utf-8?B?cy9lZGdJZEw5MS9IZzRTWFR1Q1lGa2t3SUJCOWRtMkMwSWNYM1N6ZXhENjdC?=
 =?utf-8?B?Q21IYUtXWmhSeWQ5Ym4rcTVqWjdEUVlhKzcrL0FaaFcwYUQ5MWVDQTZTRmFN?=
 =?utf-8?B?aVdpRkhSd2VHYzRYdnNTTDhVL2ZzNTZTeExUb3lWRkZML2QveG10RkRBZVR4?=
 =?utf-8?B?RUlhRngzTU0xOTE2SXJiY01zd2kvdmxNZ2NHVDRuQkZOY01YTXlOUTlVMHl3?=
 =?utf-8?B?UlZMaFBLRmlGeXl3eDdFblBpWjk3eTBUaXpjS25YSmZoSGcxQkxJQWlQUDM1?=
 =?utf-8?B?a29aUFFBQkpiVVJ5UE9iMWJucjlNQ0N0SjJNTXJQWlZoQkhzdEVyYWd1ckdk?=
 =?utf-8?B?bjM0RmFSV2Q2WWh5ZlQwUVJpNHhpOFVDOFdtaHZMV2kwajhpekt0TVJYdjJN?=
 =?utf-8?B?VmdSemZ3aUlqMUNZQ3BmZVJrM3hOankvNjBxT09JVGswSmdyZGxzMDV6MUhC?=
 =?utf-8?B?cHAyd25Qb1VxeEZxK3lFbmtqa2E1SWJXU1I0MDgvT0pKTlUzR2VxWkl2YkNo?=
 =?utf-8?B?SGVENXNuSTFmY1Zkc3M3aUw4Mm1BSDF1UTFyQjhIclJKd1FTK2tVamhBdHZk?=
 =?utf-8?B?ZlVFWWt3YW81ZGNCbGFsZ1g4NksyaFZnWmF3VlF5d3FUVHB0Skw5UGVXM3pN?=
 =?utf-8?B?MXhQOC9GVlZ1NmJhNDM2YnpOdGd0dkgrbWdkMkZOdExaOGZJZDJQKzFHQ0Zn?=
 =?utf-8?B?TWV2Mnl0SmFVTklhSXhXa2pnL0tFdWh2Q1Jtb2NOQzM0d0xLWTZPQzJOVmR3?=
 =?utf-8?B?ZTZSYzB1bytFVGFqTU9Pc2w1Qm5SY0t4eEprL3g3VjY5a2tKRlpEYXFqSzFz?=
 =?utf-8?B?Z2kyVURYNmNEYklYSDk2bzZwMnNsKzVIR1dzRFFmVGFPSGZHQytqTmtpSEJx?=
 =?utf-8?B?UTdjbDN3M0thQTFpSVNUQTlaTVB1aFAwbVFUcGZtT2FjVGlNdk1uV2QrTkoy?=
 =?utf-8?B?R1VQTGdTdXBxendVMU1FSEEwV2ZydSsxZ0NTVFBXZFhHUDdXMWc1Y1o2VDkz?=
 =?utf-8?B?cGoySHYycUlvMXVmcGNCZFRHeDRsY1dsNXNHTllJeFZnSzg2M21mUmwwcUFN?=
 =?utf-8?B?R3FPcjloZUZEa3NFeUZGRGUrYU16RjZ5bDNoN0o5R010aWRsK0g1dk1Takd3?=
 =?utf-8?B?Y08wL25tNmJLazBCRll6U3N3enV4K0dzRXV6V1llVVFBQ3o4WFFXMUxVdFA4?=
 =?utf-8?B?eW9BZ3J2eDVHWEFLdytxdG9ZYy9HT3RhRVVCVlhVVGtCaWQzZGZQWCthd05I?=
 =?utf-8?B?T1A1YU81N3FiR3VoM2Z3Wml1U2JSbGVWb0Ezb0QzTHhONUFMUm0ya3FCT01t?=
 =?utf-8?B?OE9GY3hpbkZDNVdvSHJnbEhGNUFXNUY4bFJNaW01cXlXWmtmMnVlNDlpVjl1?=
 =?utf-8?B?OWhuQ0V2S3RudHhaZlUxNllldGhPVWU1U3dIbDY0UkFCcUlRSis0L0xidU5T?=
 =?utf-8?B?UnErUU9pRndTV2NmVWVYdmxNL01hcnRIM25LcjZjZ25Pajk3dHZ4NFA2T1Ri?=
 =?utf-8?B?c2Y3NFQ0RTV2SjZHMUxtVXJ0WFBnNXg1VjBBVXgvQ2FkaHVML1RBcGlLM3FV?=
 =?utf-8?B?Q3ZzcDVZQldiRnFOeGVtUTdoYVlLbmZ4dkZUbk4wbm1iVlpXYkxrbDRPOEcr?=
 =?utf-8?B?NUdLZjdoWGt2djlJaENrTUNCUVhCK3dYQnFlWWZid2ttKzNzWHJuWUxna3dL?=
 =?utf-8?B?STU5RlpQdlZpYjhWVHJ0b2xiL1kyMXlGSFpmV3EvVkdIZ3RLOGR4KzJNVTdZ?=
 =?utf-8?B?alBjNlBZVThGNnl5UmZSUThYZkZJVUtOZDViT3NaRFN5TE10ZFlITzlvTzd3?=
 =?utf-8?B?Vy9YQ1NKVk1vSU5lTWlJWjNjMHdweE5GN3V5N3lTbmlOLzVyS2xaekNmeWk2?=
 =?utf-8?Q?4kNY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2702.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ce87f0-ba6d-4c29-70aa-08dbc9cd848e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 20:14:33.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WS61lWLNbE5srzhvxLgfm2xgd79dmo/bNkeGIOvTSycQpS1H7bVCgSnNCEjDPf9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914
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
IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTAsIDIwMjMgMjozNyBQTQ0KPiBUbzogS2FwbGFuLCBE
YXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENjOiB4ODZAa2VybmVsLm9yZzsgbHV0b0Br
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMy8zXSB4ODYvcmV0cG9saW5lOiBFbnN1cmUgZGVmYXVsdCByZXR1cm4gdGh1bmsgaXNu
J3QgdXNlZA0KPiBhdCBydW50aW1lDQo+DQo+ID4gICAqDQo+ID4gLSAqIFRoaXMgY29kZSBpcyBv
bmx5IHVzZWQgZHVyaW5nIGtlcm5lbCBib290IG9yIG1vZHVsZSBpbml0LiAgQWxsDQo+ID4gKyAq
IFRoaXMgY29kZSBpcyBvbmx5IHVzZWQgZHVyaW5nIGtlcm5lbCBib290LiAgQWxsDQo+ID4gICAq
ICdKTVAgX194ODZfcmV0dXJuX3RodW5rJyBzaXRlcyBhcmUgY2hhbmdlZCB0byBzb21ldGhpbmcg
ZWxzZSBieQ0KPiA+ICAgKiBhcHBseV9yZXR1cm5zKCkuDQo+ID4gKyAqDQo+ID4gKyAqIFRoaXMg
dGh1bmsgaXMgdHVybmVkIGludG8gYSB1ZDIgdG8gZW5zdXJlIGl0IGlzIG5ldmVyIHVzZWQgYXQg
cnVudGltZS4NCj4gPiArICogQWx0ZXJuYXRpdmUgaW5zdHJ1Y3Rpb25zIGFyZSBhcHBsaWVkIGFm
dGVyIGFwcGx5X3JldHVybnMoKS4NCj4gPiAgICovDQo+ID4gIFNZTV9DT0RFX1NUQVJUKF9feDg2
X3JldHVybl90aHVuaykNCj4gPiAgICAgICBVTldJTkRfSElOVF9GVU5DDQo+ID4gICAgICAgQU5O
T1RBVEVfTk9FTkRCUg0KPiA+IC0gICAgIEFOTk9UQVRFX1VOUkVUX1NBRkUNCj4gPiAtICAgICBy
ZXQNCj4gPiArICAgICBBTFRFUk5BVElWRSBfX3N0cmluZ2lmeShBTk5PVEFURV9VTlJFVF9TQUZF
O3JldCksInVkMiIsDQo+ID4gKyBYODZfRkVBVFVSRV9SRVRIVU5LDQo+DQo+IElmIGl0J3MgdHJ1
bHkgbmV2ZXIgdXNlZCBhZnRlciBib290IChldmVuIGZvciBub24tcmV0aHVuayBjYXNlcykgdGhl
biBjYW4gd2UgdXNlDQo+IFg4Nl9GRUFUVVJFX0FMV0FZUz8NCj4NCg0KSSB0aGluayB0aGF0IGNv
dWxkIHdvcmsuICBUaGVyZSBpcyBvbmUgc3VidGxldHkgdGhvdWdoIEknbGwgcG9pbnQgb3V0Og0K
DQpUaGUgdXNlIG9mIF9feDg2X3JldHVybl90aHVuayB3aGVuIFg4Nl9GRUFUVVJFX1JFVEhVTksg
aXMgc2V0IGlzIGEgcG90ZW50aWFsIHNlY3VyaXR5IGlzc3VlLCBhcyBpdCBtZWFucyB0aGUgcmVx
dWlyZWQgcmV0dXJuIHRodW5rIGlzIG5vdCBiZWluZyB1c2VkLiAgVGhlIHVzZSBvZiBfX3g4Nl9y
ZXR1cm5fdGh1bmsgd2hlbiBYODZfRkVBVFVSRV9SRVRIVU5LIGlzIG5vdCBzZXQgaXMgb25seSBh
IHBlcmZvcm1hbmNlIGlzc3VlLCBhcyBpdCBtZWFucyB0aGVyZSBpcyBhIHJldHVybiB0aGF0IHdh
cyBub3QgcmV3cml0dGVuIHRvIGJlIGFuIGlubGluZSAncmV0JyBieSBhcHBseV9yZXR1cm5zKCku
DQoNClRoZSB1ZDIgd2FzIHByaW1hcmlseSBpbnRlbmRlZCB0byBjYXB0dXJlIGNhc2VzIHdoZXJl
IHRoZXJlIGlzIGEgcG90ZW50aWFsIHNlY3VyaXR5IGhvbGUsIHdoaWxlIGl0IGlzIGEgYml0IG92
ZXJraWxsIGp1c3QgdG8gcG9pbnQgb3V0IGEgcmV0dXJuIHRoYXQgd2FzIG5vdCBvcHRpbWl6ZWQu
DQoNCi0tRGF2aWQgS2FwbGFuDQoNCg==
