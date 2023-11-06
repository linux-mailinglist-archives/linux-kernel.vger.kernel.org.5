Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1C67E2607
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjKFNtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjKFNtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:49:01 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E98BF;
        Mon,  6 Nov 2023 05:48:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj1gMlz16YrqQ4Dxb+5FE3lF6hEoxoQnaIgkpl0GRxwsB0iswZmPOzYCq9402z00omNqqtBsRNWOuixK0nGQ3lD4GqL+2AfoPw9HkMguDI+mC/36HCFq89VHGYttZIzdKdlpNPuH2HMcmxoQ8R7FS8iyMT8hvdANfgxJP+uiWmfGmi9vV93KOOHQAy8JaRIWTWU9rwn5wrtOFitfux60jhOYnRnPtvhz2ruLvoCTPPf6z+k4geH68qZkeWwH7ebjmmlCFhNhlkxvNX6JTOneFnix/hc7NThhE54PB7d/d/ujHCbLD6TO9GtE0eZlD3tw+Au0J9f6qRx1xZLQ28QNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0Cxw0NPncTfr/ZiAGRRr4Xb3dSVa6IRGzP+2XYCqc0=;
 b=Zw9Gv6oI57Ty8sOglaV3u14oAbAK2ER2XzxFbgSTdMfd2QrqTqSGPOQP8kTTMZmMRcRWJHHy+WoKHtMk85ru5AGps+W28L7gODU4uavdN6ZVCCqNyAbq/PJ7biHpwQTpQ0qp2e9MhAgQayfyUkbsd1UnSZGqsv1wkC0T48YvQxFRPtl8glSsHHHf7r/k3ZeyWp7ENztWBebCjyBONvZuPqDtmGHLcJqSlI6UYz1WzqSIQNZ50U6EJ511Fyt83wGhIuvp8W4mXlnqM+ytmRHEMj45f4BTkZDjN+3t+gbe4lu+8RcroqNHTEeiMMIPdy57Am6Fgtw2oYp34MHReZGn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0Cxw0NPncTfr/ZiAGRRr4Xb3dSVa6IRGzP+2XYCqc0=;
 b=FbhyLRrfHMoHXVDzZtpa4onJ5I9stD36c6rnvqrSM6WfHp2ZbQODKsyYfRyKG4tsrK91yiSoT0AYdxLgyLp8HeCNOWHG+HWrjO83+WQNGO+NNxIdaczE0wQr90EYB8obqCtGB4wy5e62hrgofwaICNtm6X11R9gUJPKIJzuC8Qc=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 13:48:55 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::6f1a:10d7:a72e:4e1c]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::6f1a:10d7:a72e:4e1c%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 13:48:55 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: RE: [PATCH] usb: dwc3: core: enable CCI support
Thread-Topic: [PATCH] usb: dwc3: core: enable CCI support
Thread-Index: AQHZ/ZcGAnt3cGDkQk+ZfNahH6Tg2rBTW7AAgBVuLxA=
Date:   Mon, 6 Nov 2023 13:48:54 +0000
Message-ID: <MN2PR12MB43336B903F927A7120A7E09F88AAA@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20231013053448.11056-1-piyush.mehta@amd.com>
 <20231020231615.w5m2w5bknblpkhyt@synopsys.com>
In-Reply-To: <20231020231615.w5m2w5bknblpkhyt@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|IA0PR12MB8304:EE_
x-ms-office365-filtering-correlation-id: f513cb66-8347-4280-291c-08dbdecf1e44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bO4PYo9zhCGRynTD8zLIrBNSnLRr6hCQhbjsKXEihvE1OtI8tngvxXQnL3jPCVSNIBuAiSI56h3PyS2oiZbX25MGsRWGNgPU2VceIgoYsM9Vcv87wa+UhEsdmhmtz6TAmJsy5L07+nqXMFPj8fxpSnhVjIfjEo7PPHAacE38ZFlzlRoNlHde2wbvgWSJdloe5izt/7RB4BSV1jXTAHiV62P4Q/QWA588LzGYB5TxTa4/Dgpv0VSmMSK8HcCEh3NN9s5+8T+78tx28W1IQLPQ26tWCDSsRdP4Xq3G1213PzBgsfi1Vq5kk+LV9qj2oYL/OYG1hzlRIH2BsGOPR6bDGP/KzNzkurAK9mlyX5doO7Tzh/sgXXTKv6q+LJx2MW7vH/IMzGX2N+p4yMbIqcLX7OcLzC9OMrGvsMiWuR9RWOh8rWsgclYu1gjc13Fy3qXG0MYzsIVfN1nwz5J5ci1+UauidUedVnILhNHLrbmt7cX61CPKXRxrV6PsJsAXaD1ejCeVbI3VDqEj5gcTJm0Q5GpPafdZksQ96fcFST47D8v3EAtYxy74k/e86G1Hiqq/1JQMY2ZnKuhZJKTUkFxMfa8c5uQnVJIRvX/v+WSM+Xs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(83380400001)(316002)(6916009)(38100700002)(122000001)(53546011)(478600001)(71200400001)(6506007)(7696005)(966005)(76116006)(66446008)(54906003)(64756008)(26005)(66556008)(66476007)(66946007)(9686003)(5660300002)(2906002)(8676002)(52536014)(33656002)(4326008)(41300700001)(86362001)(8936002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVp4ck1wVExjanUvbVVrYWhFYXhtZE1GU0FVSlphcG1nTTh1bytKeEw5U253?=
 =?utf-8?B?M2c4U1JWSFJnbE9UZGtPYVphaDc4OG4za3NyeWVrMHFIcG9LU1lEOERKNElt?=
 =?utf-8?B?Ukp5S24zTmtoVSs1bG8rS3pPTkZvSERYMkhjMDFVTVk4azUvZjZCVXdJVExI?=
 =?utf-8?B?UE4vKzBGZFhQUEwydXZsTElvcFNzVzUzdnErTldMS3NmSWF4VzBVcjUybnlT?=
 =?utf-8?B?UHk3S2k0UHZpS0ZLazVyekdiN0dtSVRhaVBReEtCQ1JxZk1hVFF6NUMveXoz?=
 =?utf-8?B?VS9leXQyS1EzanMyOHlFT0pXZ0QwWGN4THZ3dStjeFRTczdMVjJHdWhMaGJk?=
 =?utf-8?B?SWx1RFVUdTJPNXI1S280aXA0M0NUVW1KMWczQXJqMGxXS3pFT2VOOW9OMDlB?=
 =?utf-8?B?MkRLSFJnOXo0OXpGTE9WMTRibTdRWU4yZmdkdHJSenYrcEJYSjRPVFFYV2VU?=
 =?utf-8?B?MXZWS3FCLytGODJCRlVERUVwTG9OR1pzU1daL090UitQSE55dmFCUnREcXRL?=
 =?utf-8?B?TnhEcTBaZUV2bW9WeTlJUmg1UFVaK0lNc3NhSHEwVHN4LzhIdi9BMkM1aXFm?=
 =?utf-8?B?ZVhCS2JZVkZHKytyRVVYekljdFdNRGVSMFlVenFXbHhsMURvNi9TbkR4TzQ2?=
 =?utf-8?B?NDh5SzhkVU5pd21qVFNScTYrZURqL2Y2dy90MkFsa0tVa29NVlFMNmlOZHNW?=
 =?utf-8?B?eEVwRi9xZFlSTTA0VVNSL3lvRlFwaTI3QmZyZ0dzcnhIZG8vWityanhQRlZD?=
 =?utf-8?B?aVlQWGhZejUrSy9xRTRHd051b1FreW8zREVQM3ZSYW1USHB2SU53T0J1eldM?=
 =?utf-8?B?czdRRm9UbEhWcTc5NXBKMkxFc3AzWjNLVjFYcUgyaDNvWVZrT2FkU1FpOVZ2?=
 =?utf-8?B?alduNXBmOUJQM25UUm01WlllbWVnSW9ZNmZZNHdqWlB2RkIyT3dINll5bHVr?=
 =?utf-8?B?WjFTaGVPOUZSeG16dnlGL05XM0JnRURHS2RyVSs5Tk1TVlZmdHllMnFJZUxR?=
 =?utf-8?B?dUVENlFjUjVmNVBxTlpWV2tlb1BNNGpOU3FkTm1VYk1HM0tJZ0hvVXJ3N1du?=
 =?utf-8?B?OTJkOXYxSVhTMEtWeDVJZHBYdlB5MFh3dVhTeTRvbU81UHV0MldMVGk3a1VW?=
 =?utf-8?B?bEFTSWt1Y21saW5CeXIwamZ2UXpEa2dCSGFyWWxmVndWTWJNck9PbVVjbTBi?=
 =?utf-8?B?bWc3NUZ6b0JhVHh5djJ2dUE0N2diV2QxS2paVnVmeVlOeFliQVVqMnZrVTh1?=
 =?utf-8?B?WWtWdUlCWUIyMDRCZFg5N3BiY0hYYVVlSzhHSmRlMDNHZHptc0d6dGZpb3BC?=
 =?utf-8?B?bHFHTlFVMlRqSUFIdEJibHVGbmduZWg3TkZ2TWhNaVpySzJRYWRGYjlsSGI0?=
 =?utf-8?B?cVJOUmNnSFVuUm5FQ2d1am1Xb3ZMbk4rcmFSVmJSZDFzSzFBOFJqODBaSEh5?=
 =?utf-8?B?bnRBVUNuUTM5SElKY3ZUOVZTTHk1RFlDTkFtclB6Y3g2azFpVk5POExFVFNI?=
 =?utf-8?B?UE4vVEV1S1g3QVQ1Z1gwa05oc01oWURBNzhqRC9oc243QXZyTWJiZTQ1dVlC?=
 =?utf-8?B?Q2hTZzFNc2ZWOER6MFA3azQ4UEpwNDJQNXQ4TDNLL3NJaVpIb3d4c2hNRnpx?=
 =?utf-8?B?enorTUFrUnp6bHdZQzJsUmQvTGNDR0IxUnFmd25sTHgyU2k5MXpGR3J4VUIv?=
 =?utf-8?B?OU5HakszWjQ4Q20wY3FxWTVyRWRaSlA4bWJiRjhWWHFvNm9QV3ZSaUdaL0FT?=
 =?utf-8?B?ZHpsVHVReDV5R3ZVOFk1SHdFN0pkWVpOVGs3RGtEUWtlOEYyeG02anNpRkFC?=
 =?utf-8?B?YXNuSjBkMFAzZ0dHZlppbmRUWGFRdlY0YzdoSG42aE5nV3dyY1FJdGEyT05X?=
 =?utf-8?B?bW54cG5taUpMa1ZJWk9tc0c0YVhkSlhVMlJITUhKcDY0NU9MUjYxTXRGbGhl?=
 =?utf-8?B?MFZRMjh6L1NMb0hZbHc3cTI4dkN0cXVUYnJCOWxnSzlXNUJTR1I4K3hWcHRz?=
 =?utf-8?B?MTM3QjNrOUpqdFhWT2RvNlBMYlpkV1IyQmdja09XMFdTcHNVYmRFVnJGME1u?=
 =?utf-8?B?aEZXNmdSTlUvS003OGlSUUwxSEwxUlFrb2J0MCtKZ0QvMFVpbjA1QnBRdEdS?=
 =?utf-8?Q?0FUI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f513cb66-8347-4280-291c-08dbdecf1e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 13:48:55.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhPWqjSOoyfCqfp4lo9IImSMdRjLbtWnql9wdKqtw46CArkT6JVFUF+qRKPxvMUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhpbmgg
Tmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgT2N0
b2JlciAyMSwgMjAyMyA0OjQ2IEFNDQo+IFRvOiBNZWh0YSwgUGl5dXNoIDxwaXl1c2gubWVodGFA
YW1kLmNvbT4NCj4gQ2M6IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBTaW1laywgTWljaGFs
IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5
bm9wc3lzLmNvbT47IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSB1c2I6IGR3YzM6IGNvcmU6IGVuYWJsZSBDQ0kgc3VwcG9ydA0KPiANCj4g
T24gRnJpLCBPY3QgMTMsIDIwMjMsIFBpeXVzaCBNZWh0YSB3cm90ZToNCj4gPiBUaGUgR1NCVVND
RkcwIHJlZ2lzdGVyIGJpdHMgWzMxOjE2XSBhcmUgdXNlZCB0byBjb25maWd1cmUgdGhlIGNhY2hl
DQo+ID4gdHlwZSBzZXR0aW5ncyBvZiB0aGUgZGVzY3JpcHRvciBhbmQgZGF0YSB3cml0ZS9yZWFk
IHRyYW5zZmVycw0KPiA+IChDYWNoZWFibGUsIEJ1ZmZlcmFibGUvIFBvc3RlZCkuIFdoZW4gQ0NJ
IGlzIGVuYWJsZWQgaW4gdGhlIGRlc2lnbiwNCj4gPiBEV0MzIGNvcmUgR1NCVVNDRkcwIGNhY2hl
IGJpdHMgbXVzdCBiZSB1cGRhdGVkIHRvIHN1cHBvcnQgQ0NJIGVuYWJsZWQNCj4gdHJhbnNmZXJz
IGluIFVTQi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpeXVzaCBNZWh0YSA8cGl5dXNoLm1l
aHRhQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gRFdDMyBSZWdpc3RlciBNYXAgTGluazoNCj4gPiBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9kb2NzLnhpbGlueC5jb20vci9lbi1V
Uy91ZzEwODctenlucS0NCj4gdWx0cmFzY2FsZS1yZWdpc3RlcnMvR1NCVVNDRkcwLVVTQjNfWEhD
SS0NCj4gUmVnaXN0ZXJfXzshIUE0RjJSOUdfcGchY2JMYllMazl4dTU0RFpNa2lUUXpNaGRDYVBB
NGdtSVZJbmVzNFplTmIyOA0KPiBBSTJwZ2VzRXZITll0am9aZld2RV90N3dsVWRadlluLVBpbzhX
akE1NWVrYWwkDQo+ID4gUmVnaXN0ZXIgTmFtZQlHU0JVU0NGRzANCj4gPiBEZXNjcmlwdGlvbglH
bG9iYWwgU29DIEJ1cyBDb25maWd1cmF0aW9uIFJlZ2lzdGVyIDANCj4gPg0KPiA+IEdTQlVTQ0ZH
MCAoVVNCM19YSENJKSBSZWdpc3RlciBCaXQtRmllbGQ6DQo+ID4gREFUUkRSRVFJTkZPCTMxOjI4
DQo+ID4gREVTUkRSRVFJTkZPCTI3OjI0DQo+ID4gREFUV1JSRVFJTkZPCTIzOjIwDQo+ID4gREVT
V1JSRVFJTkZPCTE5OjE2DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwg
MTcgKysrKysrKysrKysrKysrKysNCj4gPiBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICA1ICsr
KysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMgaW5kZXgNCj4gPiA5YzZiZjA1NGYxNWQuLmZjNjg5MmM2M2FiZiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+ID4gQEAgLTIzLDYgKzIzLDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPg0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvb2YuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L29mX2dyYXBoLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9hY3BpLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2NvbnN1bWVyLmg+DQo+ID4gQEAgLTU1OSw2ICs1NjAs
MjAgQEAgc3RhdGljIHZvaWQgZHdjM19jYWNoZV9od3BhcmFtcyhzdHJ1Y3QgZHdjMw0KPiAqZHdj
KQ0KPiA+ICAJCXBhcm1zLT5od3BhcmFtczkgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywNCj4gRFdD
M19HSFdQQVJBTVM5KTsgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBkd2MzX2NvbmZpZ19zb2Nf
YnVzKHN0cnVjdCBkd2MzICpkd2MpIHsNCj4gPiArCWlmIChvZl9kbWFfaXNfY29oZXJlbnQoZHdj
LT5kZXYtPm9mX25vZGUpKSB7DQo+ID4gKwkJdTMyIHJlZzsNCj4gPiArDQo+ID4gKwkJcmVnID0g
ZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1NCVVNDRkcwKTsNCj4gPiArCQlyZWcgfD0gRFdD
M19HU0JVU0NGRzBfREFUUkRSRVFJTkZPX01BU0sgfA0KPiA+ICsJCQlEV0MzX0dTQlVTQ0ZHMF9E
RVNSRFJFUUlORk9fTUFTSyB8DQo+ID4gKwkJCURXQzNfR1NCVVNDRkcwX0RBVFdSUkVRSU5GT19N
QVNLIHwNCj4gPiArCQkJRFdDM19HU0JVU0NGRzBfREVTV1JSRVFJTkZPX01BU0s7DQo+ID4gKwkJ
ZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dTQlVTQ0ZHMCwgcmVnKTsNCj4gPiArCX0NCj4g
PiArfQ0KPiA+ICsNCj4gDQo+IFlvdSdyZSBvdmVyd3JpdGluZyBkZWZhdWx0IHZhbHVlcyBmb3Ig
YWxsIHBsYXRmb3Jtcy4gRG9uJ3QgZG8gdGhhdC4gTm90IGV2ZXJ5DQo+IHBsYXRmb3JtIHN1cHBv
cnRzIHRoaXMgc2V0dGluZy4gT25seSBhcHBseSB0aGVzZSBzcGVjaWZpYyBzZXR0aW5ncyB0byB5
b3VyDQo+IHBsYXRmb3JtLg0KDQpUaGlzIERXQzNfR1NCVVNDRkcwIHJlZ2lzdGVyIGlzIHBhcnQg
b2YgdGhlIERXQzMvQ29yZSBzeXN0ZW0uIEluIGdsdWUvdmVuZG9yIGRyaXZlcnMsIEkgY291bGRu
J3QgZmluZCBhIHdheSB0byBhY2Nlc3MNCnRoZSBEV0MzL0NvcmUgYWNjZXNzIHJlZ2lzdGVyLiAg
Q291bGQgeW91IHBsZWFzZSBwcm92aWRlIGEgc3VnZ2VzdGlvbiBmb3IgdGhlIFhpbGlueCBnbHVl
IGRyaXZlciAoZHdjMy9kd2MzLXhpbGlueC5jKSB0bw0KYWNjZXNzIGR3YzMgcmVnaXN0ZXJzPw0K
DQo+IA0KPiBCUiwNCj4gVGhpbmgNCj4gDQo+ID4gIHN0YXRpYyBpbnQgZHdjM19jb3JlX3VscGlf
aW5pdChzdHJ1Y3QgZHdjMyAqZHdjKSAgew0KPiA+ICAJaW50IGludGY7DQo+ID4gQEAgLTExMzcs
NiArMTE1Miw4IEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykN
Cj4gPg0KPiA+ICAJZHdjM19zZXRfaW5jcl9idXJzdF90eXBlKGR3Yyk7DQo+ID4NCj4gPiArCWR3
YzNfY29uZmlnX3NvY19idXMoZHdjKTsNCj4gPiArDQo+ID4gIAlyZXQgPSBkd2MzX3BoeV9wb3dl
cl9vbihkd2MpOw0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlnb3RvIGVycl9leGl0X3BoeTsNCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuaCBpbmRleA0KPiA+IGE2OWFjNjdkODlmZS4uYmQ5MzcwMjVjZTA1IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmgNCj4gPiBAQCAtMTczLDYgKzE3MywxMSBAQA0KPiA+ICAjZGVmaW5lIERXQzNfT1NU
UwkJMHhjYzEwDQo+ID4NCj4gPiAgLyogQml0IGZpZWxkcyAqLw0KPiA+ICsvKiBHbG9iYWwgU29D
IEJ1cyBDb25maWd1cmF0aW9uIFJlZ2lzdGVyOiBBSEItcHJvdC9BWEktY2FjaGUvT0NQLVJlcUlu
Zm8NCj4gKi8NCj4gPiArI2RlZmluZSBEV0MzX0dTQlVTQ0ZHMF9EQVRSRFJFUUlORk9fTUFTSwlH
RU5NQVNLKDMxLCAyOCkNCj4gPiArI2RlZmluZSBEV0MzX0dTQlVTQ0ZHMF9ERVNSRFJFUUlORk9f
TUFTSwlHRU5NQVNLKDI3LCAyNCkNCj4gPiArI2RlZmluZSBEV0MzX0dTQlVTQ0ZHMF9EQVRXUlJF
UUlORk9fTUFTSwlHRU5NQVNLKDIzLCAyMCkNCj4gPiArI2RlZmluZSBEV0MzX0dTQlVTQ0ZHMF9E
RVNXUlJFUUlORk9fTUFTSwlHRU5NQVNLKDE5LCAxNikNCj4gPg0KPiA+ICAvKiBHbG9iYWwgU29D
IEJ1cyBDb25maWd1cmF0aW9uIElOQ1J4IFJlZ2lzdGVyIDAgKi8NCj4gPiAgI2RlZmluZSBEV0Mz
X0dTQlVTQ0ZHMF9JTkNSMjU2QlJTVEVOQQkoMSA8PCA3KSAvKiBJTkNSMjU2IGJ1cnN0ICovDQo+
ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KUE0NCg==
