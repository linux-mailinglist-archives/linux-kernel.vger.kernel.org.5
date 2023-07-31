Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A9769C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjGaQ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjGaQ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:26:06 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020017.outbound.protection.outlook.com [52.101.61.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8338198B;
        Mon, 31 Jul 2023 09:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpNmpAaW8X/+dEhjpRNTPr5rZvm8SqHaZRaPjlyAj9lTHgq/d3uuEMXpThAM2MAyAhQNEAoArzuF3S8OG/e5ar/Svp+D1Tz/j+3OfjgJxW0vkAA1+chGxJJUpha9Nr5vXPRF3FUBdDS/gl3ffgX9tWQM0D9zxhYJQLIBb2RySDwnOnLPpZFGYXV8Y5x8HNpwL7UMc0d5ZhRuHml72KMbumT2aFyYQQfV5D+EEkAVBCUwQvTA4PS1VgsrU1y4HuSHpdJM4glC36DxhrtAldj5kxRgR4JHYcopxA5rbam94sBWm6zXIARGGrsb/1v8lYJlRFJzIe9jCfFUrRQrOsXsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrId08lUYFKfBxFS8yCuxG7ehmOX8riZnlLzMPQUi2w=;
 b=kr5PhjCzhEdzckQee4GqWeev7dKQ6PYNuOXU58K6VWedKD7Ujae6BX85m4CP28PTYqaKmSRNGzvZrrFNbRdX5eZPXWSaSYElIaIVTm9z3XKqlOE4ntNnUES9DiLQ3gTjSKV+r7cPLtSpJ2gtFnmGiXIxOsc/drMAT1PZjmGw6mGv1+/ZLK38evXvgzqh90rgkMlSSd2blZrZsBvW6mLGuVZGsceGABFeIuhX3Fah+IvYO6K4I461elXKoUaPOWdQzLumV9GTnUunaEhd5mumx7dQcFrVLTkvmyxqEh0Y8OlawZyth33EJvY0rTRs5F33dDe+pVRUc1s7OihBbceilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrId08lUYFKfBxFS8yCuxG7ehmOX8riZnlLzMPQUi2w=;
 b=bA2GDimrt2YpTMBJYTjiL5O48eR/hx7W0YrYtMBXaqs22m05QIalfksvbMf0HiZPQsh9DuxApzUPwI0pl6GF8c0WYK9wjnaYG1pMdNy3eoKHRPgN7DmAVxeB+phY2YhPYCc1f/oaGgjllya4jNj2JFPmSuwGyWyVpDhC5PZLGas=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB3027.namprd21.prod.outlook.com (2603:10b6:510:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Mon, 31 Jul
 2023 16:25:41 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Mon, 31 Jul 2023
 16:25:41 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: RE: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Thread-Topic: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Thread-Index: AQHZwU0WNJnrG48S4EOlGyY6cNlaEa/TN7UQgACcb4CAAD0WAA==
Date:   Mon, 31 Jul 2023 16:25:41 +0000
Message-ID: <BYAPR21MB168857E160C70BC76665FE6FD705A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <871qgop8dc.ffs@tglx>
In-Reply-To: <871qgop8dc.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bf2221f6-5ca1-41aa-8665-4640430365ba;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-31T16:13:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB3027:EE_
x-ms-office365-filtering-correlation-id: bb1e5a8e-17f8-4a49-c86d-08db91e2c86c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xdRLGXXbbPVhbp5fip4AHdjvtoSjc66t6s65+6M0jU507reupS3qaoGGifwLrgDAbFcyefNraWWRC/0RMhiTaaweqT/xVlh0vNkoqLUr/ONhI9RjWwAuuHoH4xKa/QkGNs3puY5c///UTrWZuWgB78RSlI0vigTyscEhanPJaqnw8wWZToZg//7pThRVNs5PqobQaAXzBqtxjQIUfji/UIGgpt6NJZIvMAalIbXL21eX6tnJ907wPZ+CamVCowEusHhNoLS4Hz575mxPxI0ibXcW94oicc6bzciBniW+nMk3W6ahEKEoDTAPDK6H40mnMaRFjOPZzzg0RD/lEXBvDHg2eM2jbX8Berf3EcruhjFbo3UwwPdqmV4K919pxrgbCiBwGwg6NMh2jeKsc1y6ihdAPrhK1twZxSpE6lh6HnJRWV7Mzbi6wxYUX8sgAAGYpKBCU46hQ9/5n80qquBzVyiHJDUKIC+5FS75nbOhZyZSawGwOudwTBdL+OiySheyUAOcWIP5nMRsTMfMJvY0pt645CAWzBTK2c2HCEpd2/F1IlcQsVz6SrtRIjZiqzR4W27UFrNB+lw3G+5eq95Ff4lNzaDDWpFsX2Xr2L0M2nTy+J2zJC//RPPYReCh2hsD0DzYO90yzYT1sFLZ0CWC+q9cbXfBFcDJNlUq6hvBXlI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199021)(7416002)(55016003)(5660300002)(52536014)(786003)(41300700001)(316002)(8936002)(8990500004)(8676002)(2906002)(66899021)(83380400001)(9686003)(38100700002)(122000001)(38070700005)(7696005)(66946007)(186003)(6506007)(82950400001)(82960400001)(26005)(54906003)(478600001)(4326008)(110136005)(64756008)(76116006)(66476007)(66446008)(86362001)(33656002)(71200400001)(66556008)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1p5V1hPaWxLcTU4ZmZjZS9uVDdmSUlUbmFORzB1UG03OEhqK0VkR01wMWFK?=
 =?utf-8?B?MytWMDlhVXZvZmpFRWI2UWpkTU1RNndsa0dFS0g3bENVbWpZVVVRdjlEaER1?=
 =?utf-8?B?WUd0K0VrVXdoMFhLaDlNbDhWUUI5dERPczlyT2NhRE9OeW1FVTFxQUNMRExs?=
 =?utf-8?B?eHJLY1cxbjNYYkJvL0dWQ2dRVXVzbWwzTkZwbm5mbitYamMwWStTVU5qTnJC?=
 =?utf-8?B?MzUvcUF0N1dlNTVrMERwZ2QzdDBOcDY1dVlpUWtGN1lhc3FtL21BWXpHTE83?=
 =?utf-8?B?b3ovQkVJZWxjaXd4aU1qT00vVXJ1cS93MDh0NVp1anFXSmc4VFlKTTlXWS83?=
 =?utf-8?B?Uko3eStxU3hpTktVZ29heWxpSkpmV1pYaG8zc1J3eWhlVnlISU9MUG0xd1Q3?=
 =?utf-8?B?QXBjemhrV2NrN3Uyam5BcDRxektlN2pja09IWG94My90ZHBGUThqZ2k1cTlO?=
 =?utf-8?B?b0ExdHBicFJGWm5zR0FLZE42clFGU21Ta3JjbzZrWmJJQ1Rocklpc0FSZVB5?=
 =?utf-8?B?NndoZWFLak85UU1PT3U1ZENsZmI3Z2VrNlZpRTM3b2lueThEbEtxd2tPMEE1?=
 =?utf-8?B?UFZnYjMraTN0aGwrdUs1TGpDOUFlamo4K2xqMGhrN1hDajNpS1JjRjBqTkVG?=
 =?utf-8?B?Rm5oQ0JaZHVzeW4vNHRXOWhGK3d6ZVExODRId3VQalBnaXRYVUxuYjZZRU5y?=
 =?utf-8?B?cHMrSEtMM2NmMWxiSWhzbVpYZjd5QXpVa05QUjhaRUVWeGw1VjFoYVE1RVdj?=
 =?utf-8?B?bGU0RUVZclNNZVQ0eU91dnFwb0tvSlI0eEt1VEJhb3lrVGRwTCtRZmd1YnN1?=
 =?utf-8?B?Z0JpK3BwdlpEb0pBRCtzUnJmb0taeXNzV0N5aXZCQXh5dG94WC9MZThuTlBF?=
 =?utf-8?B?WTEyZkkrZDU1Vzc4Y1lpSk5rZ2ZzdG9qRlF2anpLTnNleDkwNGRSV2Vqblpx?=
 =?utf-8?B?UkRPTzlWeXViV29GeTgrYkNaUnBLZ1R6UlhsSFBoU1FQYzR0LzVzMUt2VGxl?=
 =?utf-8?B?K0Z6NjAwcENXRStGSHB4aE9SU29Xd1V4dE12cWNVZW44UXhMcUlYYmVnYkt1?=
 =?utf-8?B?eEFSYVJpSlVRSmFjV3pvampmM1picmFsdkhLdHBrSWdFZFk1WkFWdnlScmZH?=
 =?utf-8?B?c2VUbjZ1M0M5QklBeDRRelpkdytPbXJuVWU1MjdhRGtIK1dtVUJlWENtTHVP?=
 =?utf-8?B?UmZjUjZBS1BwNzFiT0FGZjZmNC82Nk8rK3BndHJ3UnF0QldiOEU4NU80K0p6?=
 =?utf-8?B?cE00MDRhbHdZemVlYVFCTWNzYVhVQjZNZm9oM1REdkx4YUJuWUVleGdpTmR0?=
 =?utf-8?B?NHcvdWFVWVpmSlpldlpxRGQvTkFrVXhndllod1N6UVozc28xa2FZc2NQRDNm?=
 =?utf-8?B?WGZhVFVVZmEwS1MrMzBnN2VPTSt2cGs0Qzd0U2xFWFF1Q2VOME02RTdldm0y?=
 =?utf-8?B?Nm1iaktsckZ0VTNUOVBMRnk1Y2pNSkxrYWdNamJhQXBQaVZhQVlnNkxwM2Nr?=
 =?utf-8?B?TVdtdzRINW5TRmtkK3V4THNRcWhpaEdvOXVlc2tYSmJYK3Vwak1VbmFaT2Fj?=
 =?utf-8?B?VHdRVEh4U0JJZmF2SEdBR2xaU21qbUFacldxRFJqZGo0V0xrWllkZVZTck5B?=
 =?utf-8?B?Rng4bkFJZnUrZk1YVXRRMWo3b1NERjNxRGp0SHBSTTJLTlliOXVQSStvWFNn?=
 =?utf-8?B?dnZ5emR2ejZQMkJNV2dQcnRXOFpwYTk2ZEFES2QrNWNiWUdvU3VtUjIwVzRk?=
 =?utf-8?B?cTdYUWRkcTBDQkZocG5xN25WUmlyNFBBdG5veFNvNERNa0l6Y1ppSHJ1blhk?=
 =?utf-8?B?OHhrRVhRd0dtYUMxdEdONmdKSWxYSDZWRjBCMTJmR1BxdTMrbEFJVXczY1Nv?=
 =?utf-8?B?QURJZWFBT2NxMVZmbzhYK3AxamV1Z0pLMGZqWU9FT0pvVnVmN3ZQa2hCV1lW?=
 =?utf-8?B?WGQvdE53dVZCTjdHSnhSZ2pVdHVGc281aUVRYkdYSUYrSmlwRXdrcUhuaHRM?=
 =?utf-8?B?QUYwK2pMNmRCbXhkYmRhVTJrbmZhaXA0ODFIMGtQZ2xSNjBCMDVDc2Vub0hR?=
 =?utf-8?B?OGVUUmI0b1cxai9WWUlkeXZTVEpaWVg3V2dsSFJzNjUrNWNyT1dnc3JMTEVV?=
 =?utf-8?B?RlpmVWJxYStUTTlFM3pRYzVOYkNpNjVCdmZiaTBOVWIxWk5lTlQvOUV2SGVM?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1e5a8e-17f8-4a49-c86d-08db91e2c86c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 16:25:41.3742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HutqZ5Wu0zKPGxkdRnaZPQb/v4navHQ5ozxlh2SEjr9UDIJoWVD3fL8YYhiDZxJdSPsoe3yPdRlanb9aYy+VIH+3PtTe/KyhCaJOOPgdGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB3027
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IFNlbnQ6IE1vbmRheSwg
SnVseSAzMSwgMjAyMyA1OjM1IEFNDQo+IA0KPiBPbiBNb24sIEp1bCAzMSAyMDIzIGF0IDA0OjA1
LCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPj4gKwkvKg0KPiA+PiArCSAqIFRoZSBpbml0aWFs
IGludm9jYXRpb24gZnJvbSBlYXJseV9pZGVudGlmeV9jcHUoKSBoYXBwZW5zIGJlZm9yZQ0KPiA+
PiArCSAqIHRoZSBBUElDIGlzIG1hcHBlZCBvciBYMkFQSUMgZW5hYmxlZC4gRm9yIGVzdGFibGlz
aGluZyB0aGUNCj4gPj4gKwkgKiB0b3BvbG9neSwgdGhhdCdzIG5vdCByZXF1aXJlZC4gVXNlIHRo
ZSBpbml0aWFsIEFQSUMgSUQuDQo+ID4+ICsJICovDQo+ID4+ICsJaWYgKGVhcmx5KQ0KPiA+PiAr
CQljLT50b3BvLmFwaWNpZCA9IGMtPnRvcG8uaW5pdGlhbF9hcGljaWQ7DQo+ID4+ICsJZWxzZQ0K
PiA+PiArCQljLT50b3BvLmFwaWNpZCA9IHJlYWRfYXBpY19pZCgpOw0KPiA+DQo+ID4gVXNpbmcg
dGhlIHZhbHVlIGZyb20gdGhlIGxvY2FsIEFQSUMgSUQgcmVnIHR1cm5zIG91dCB0byBjYXVzZSBh
IHByb2JsZW0gaW4NCj4gPiBzb21lIEh5cGVyLVYgVk0gY29uZmlndXJhdGlvbnMuICBJZiBhIFZN
IGhhcyBtdWx0aXBsZSBMMyBjYWNoZXMgKHByb2JhYmx5DQo+ID4gZHVlIHRvIG11bHRpcGxlIE5V
TUEgbm9kZXMpIGFuZCB0aGUgIyBvZiBDUFVzIGluIHRoZSBzcGFuIG9mIHRoZSBMMyBjYWNoZQ0K
PiA+IGlzIG5vdCBhIHBvd2VyIG9mIDIsIHRoZSBBUElDIElEcyBmb3IgdGhlIENQVXMgaW4gdGhl
IHNwYW4gb2YgdGhlIDFzdCBMMyBjYWNoZQ0KPiA+IGFyZSBzZXF1ZW50aWFsIHN0YXJ0aW5nIHdp
dGggMC4gIEJ1dCB0aGVuIHRoZXJlIGlzIGEgZ2FwIGJlZm9yZSBzdGFydGluZyB0aGUNCj4gPiBB
UElDIElEcyBmb3IgdGhlIENQVXMgaW4gdGhlIHNwYW4gb2YgdGhlIDJuZCBMMyBjYWNoZS4gIFRo
ZSBnYXAgaXMNCj4gPiByZXBlYXRlZCBpZiB0aGVyZSBhcmUgYWRkaXRpb25hbCBMMyBjYWNoZXMu
DQo+ID4NCj4gPiBUaGUgQ1BVSUQgaW5zdHJ1Y3Rpb24gZXhlY3V0ZWQgb24gYSBndWVzdCB2Q1BV
IGNvcnJlY3RseSByZXBvcnRzIHRoZSBBUElDDQo+ID4gSURzLiAgSG93ZXZlciwgdGhlIEFDUEkg
TUFEVCBhc3NpZ25zIHRoZSBBUElDIElEcyBzZXF1ZW50aWFsbHkgd2l0aCBubw0KPiA+IGdhcHMs
IGFuZCB0aGUgZ3Vlc3QgZmlybXdhcmUgc2V0cyB0aGUgQVBJQ19JRCByZWdpc3RlciBmb3IgZWFj
aCBsb2NhbCBBUElDDQo+ID4gdG8gbWF0Y2ggdGhlIE1BRFQuICBXaGVuIHBhcnNlX3RvcG9sb2d5
KCkgc2V0cyB0aGUgYXBpY2lkIGZpZWxkIGJhc2VkIG9uDQo+ID4gcmVhZGluZyB0aGUgbG9jYWwg
QVBJQyBJRCByZWdpc3RlciwgdGhlIHZhbHVlIGl0IHNldHMgaXMgZGlmZmVyZW50IGZyb20gdGhl
DQo+ID4gaW5pdGlhbF9hcGljaWQgdmFsdWUgZm9yIENQVXMgaW4gdGhlIHNwYW4gb2YgdGhlIDJu
ZCBhbmQgc3Vic2VxdWVudCBMMw0KPiA+IGNhY2hlcywgYmVjYXVzZSB0aGVyZSdzIG5vIGdhcCBp
biB0aGUgQVBJQyBJRHMgcmVhZCBmcm9tIHRoZSBsb2NhbCBBUElDLg0KPiA+IExpbnV4IGJvb3Rz
IGFuZCBydW5zLCBidXQgdGhlIHRvcG9sb2d5IGlzIHNldCB1cCB3aXRoIHRoZSB3cm9uZyBzcGFu
IGZvcg0KPiA+IHRoZSBMMyBjYWNoZSBhbmQgZm9yIHRoZSBhc3NvY2lhdGVkIHNjaGVkdWxpbmcg
ZG9tYWlucy4NCj4gDQo+IFRCSC4gVGhhdCdzIGFuIGluc2FuaXR5LiBNQURUIGFuZCB0aGUgYWN0
dWFsIEFQSUMgSUQgZGV0ZXJtaW5lIHRoZQ0KPiB0b3BvbG9neS4gU28gdGhlIGdhcHMgc2hvdWxk
IGJlIHJlZmxlY3RlZCBpbiBNQURUIGFuZCB0aGUgYWN0dWFsIEFQSUMNCj4gSURzIHNob3VsZCBi
ZSBzZXQgY29ycmVjdGx5IGlmIHRoZSBpbnRlbnQgaXMgdG8gcHJvdmlkZSB0b3BvbG9neQ0KPiBp
bmZvcm1hdGlvbi4NCj4gDQo+IEp1c3QgZm9yIHRoZSByZWNvcmQuIFRoaXMgaGFjayB3b3JrcyBv
bmx5IG9uIEludGVsIHRvZGF5LCBiZWNhdXNlIEFNRA0KPiBpbml0IHNldHMgdG9wby5hcGljaWQg
PSByZWFkX2FwaWNfaWQoKSB1bmNvbmRpdGlvbmFsbHkuIFNvIHRoaXMgaXMNCj4gaW5jb25zaXN0
ZW50IGFscmVhZHksIG5vPw0KPiANCg0KQ29ycmVjdC4gIEJ1dCBnaXZlbiB0aGF0IHRoZSBMMyBj
YWNoZSBzcGFuIGluIHRoZSBBTUQgWmVuMSBhbmQgWmVuMg0KcHJvY2Vzc29ycyBpcyBvbmx5IDgg
Q1BVcywgdGhlcmUncyBtdWNoIGxlc3MgcmVhc29uIHRvIGNvbmZpZ3VyZSBhIFZNDQp0aGF0IG9u
bHkgdXNlcyBzb21lIG9mIHRoZSBDUFVzIGluIGFuIEwzIGNhY2hlIHNwYW4uICBIeXBlci1WIGRv
ZXMNCnRoZSBBUElDIElEIG51bWJlcmluZyBjb3JyZWN0bHkgZm9yIFplbjMgd2l0aCBpdHMgMTYg
Q1BVcyBpbiB0aGUgTDMNCmNhY2hlIHNwYW4uDQoNCj4gPiBUaGUgb2xkIGNvZGUgZGVyaXZlcyB0
aGUgYXBpY2lkIGZyb20gdGhlIGluaXRpYWxfYXBpY2lkIHZpYSB0aGUNCj4gPiBwaHlzX3BrZ19p
ZCgpIGNhbGxiYWNrLCBzbyB0aGVzZSBiYWQgSHlwZXItViBWTSBjb25maWdzIHNrYXRlIGJ5LiAg
VGhlDQo+ID4gd3JvbmcgdmFsdWUgaW4gdGhlIGxvY2FsIEFQSUMgSUQgcmVnaXN0ZXIgYW5kIE1B
RFQgZG9lcyBub3QgYWZmZWN0DQo+ID4gYW55dGhpbmcsIGV4Y2VwdCB0aGF0IHRoZSBjaGVjayBp
biB2YWxpZGF0ZV9hcGljX2FuZF9wYWNrYWdlX2lkKCkgZmFpbHMNCj4gPiBkdXJpbmcgYm9vdCwg
YW5kIGEgc2V0IG9mICJGaXJtd2FyZSBidWc6IiBtZXNzYWdlcyBpcyBjb3JyZWN0bHkNCj4gPiBv
dXRwdXQuDQo+IA0KPiBTbyBpbnN0ZWFkIG9mIGZpeGluZyB0aGUgZmlybXdhcmUgYnVncywgaHlw
ZXItdiBqdXN0IG1vdmVzIG9uIGFuZA0KPiBwcmV0ZW5kcyB0aGF0IGV2ZXJ5dGhpbmcgd29ya3Mg
ZmluZSwgcmlnaHQ/DQoNCldoYXQgY2FuIEkgc2F5LiA6LSgNCg0KPiANCj4gPiBUaHJlZSB0aG91
Z2h0czoNCj4gPg0KPiA+IDEpICBBcmUgSHlwZXItViBWTXMgdGhlIG9ubHkgcGxhY2Ugd2hlcmUg
dGhlIGxvY2FsIEFQSUMgSUQgcmVnaXN0ZXIgbWlnaHQNCj4gPiBoYXZlIGEgYm9ndXMgdmFsdWU/
ICBQcm9iYWJseSBzbywgYnV0IHlvdSBuZXZlciBrbm93IHdoYXQgbWlnaHQgY3Jhd2wNCj4gPiBv
dXQuDQo+IA0KPiBEZWZpbmUgYm9ndXMuIE1BRFQgaXMgdGhlIHByaW1hcnkgc291cmNlIG9mIGlu
Zm9ybWF0aW9uIGJlY2F1c2UgdGhhdCdzDQo+IGhvdyB3ZSBrbm93IGhvdyBtYW55IENQVXMgKEFQ
SUNzKSBhcmUgdGhlcmUgYW5kIHdoYXQgdGhlaXIgQVBJQyBJRCBpcw0KPiB3aGljaCB3ZSBjYW4g
dXNlIHRvIHdha2UgdGhlbSB1cC4gU28gdGhlcmUgaXMgYSByZWFzb25hYmxlIGV4cGVjdGF0aW9u
DQo+IHRoYXQgdGhpcyBpbmZvcm1hdGlvbiBpcyBjb25zaXN0ZW50IHdpdGggdGhlIHJlc3Qgb2Yg
dGhlIHN5c3RlbS4NCg0KQ29tbWl0IGQ0OTU5N2ZkM2JjNyAieDg2L2NwdTogRGVhbCB3aXRoIGJy
b2tlbiBmaXJtd2FyZSAoVk1XYXJlL1hlbikiDQptZW50aW9ucyBWTXdhcmUgYW5kIFhFTiBpbXBs
ZW1lbnRhdGlvbnMgdGhhdCB2aW9sYXRlIHRoZSBzcGVjLiAgVGhlDQpjb21taXQgaXMgZnJvbSBs
YXRlIDIwMTYuICBIYXZlIHRoZXNlIGJhZCBzeXN0ZW1zIGFnZWQgb3V0IGFuZCBubyBsb25nZXIN
Cm5lZWQgYWNjb21tb2RhdGlvbj8NCg0KPiANCj4gVGhlIEludGVsIFNETSBjbGVhcmx5IHNheXMg
aW4gVm9sIDNBIHNlY3Rpb24gOS40LjUgSWRlbnRpZnlpbmcgTG9naWNhbA0KPiBQcm9jZXNzb3Jz
IGluIGFuIE1QIFN5c3RlbToNCj4gDQo+ICAgIkFmdGVyIHRoZSBCSU9TIGhhcyBjb21wbGV0ZWQg
dGhlIE1QIGluaXRpYWxpemF0aW9uIHByb3RvY29sLCBlYWNoDQo+ICAgIGxvZ2ljYWwgcHJvY2Vz
c29yIGNhbiBiZSB1bmlxdWVseSBpZGVudGlmaWVkIGJ5IGl0cyBsb2NhbCBBUElDDQo+ICAgIElE
LiBTb2Z0d2FyZSBjYW4gYWNjZXNzIHRoZXNlIEFQSUMgSURzIGluIGVpdGhlciBvZiB0aGUgZm9s
bG93aW5nDQo+ICAgIHdheXM6Ig0KPiANCj4gVGhlc2Ugd2F5cyBpbmNsdWRlIHJlYWQgZnJvbSBB
UElDLCByZWFkIE1BRFQsIHJlYWQgQ1BVSUQgYW5kIGltcGxpZXMNCj4gdGhhdCB0aGlzIG11c3Qg
YmUgY29uc2lzdGVudC4gRm9yIFgyQVBJQyBpdCdzIGFjdHVhbGx5IHdyaXR0ZW4gb3V0Og0KPiAN
Cj4gICAiSWYgdGhlIGxvY2FsIEFQSUMgdW5pdCBzdXBwb3J0cyB4MkFQSUMgYW5kIGlzIG9wZXJh
dGluZyBpbiB4MkFQSUMNCj4gICAgbW9kZSwgMzItYml0IEFQSUMgSUQgY2FuIGJlIHJlYWQgYnkg
ZXhlY3V0aW5nIGEgUkRNU1IgaW5zdHJ1Y3Rpb24gdG8NCj4gICAgcmVhZCB0aGUgcHJvY2Vzc29y
4oCZcyB4MkFQSUMgSUQgcmVnaXN0ZXIuIFRoaXMgbWV0aG9kIGlzIGVxdWl2YWxlbnQgdG8NCj4g
ICAgZXhlY3V0aW5nIENQVUlEIGxlYWYgMEJIIGRlc2NyaWJlZCBiZWxvdy4iDQo+IA0KPiBBTUQg
aGFzIG5vdCBiZWVuIGZvbGxvd2luZyB0aGF0IGluIHRoZSBlYXJseSA2NGJpdCBzeXN0ZW1zIGFz
IHRoZXkgbW92ZWQNCj4gdGhlIEFQSUMgSUQgc3BhY2UgdG8gc3RhcnQgYXQgMzIgZm9yIHRoZSBm
aXJzdCBDUFUgaW4gdGhlIGZpcnN0IHNvY2tldA0KPiBmb3Igd2hhdGV2ZXIgcmVhc29ucy4gQnV0
IHNpbmNlIHRoZW4gdGhlIGtlcm5lbCByZWFkcyBiYWNrIHRoZSBBUElDIElEDQo+IG9uIEFNRCBz
eXN0ZW1zIGludG8gdG9wby5hcGljaWQuIEJ1dCB0aGF0IHdhcyBsb25nIGFnbyBhbmQgY2FuIGVh
c2lseSBiZQ0KPiBkZWFsdCB3aXRoIGJlY2F1c2UgYXQgbGVhc3QgdGhlIHJlYWwgQVBJQyBJRCBh
bmQgdGhlIE1BRFQvTVBUQUJMRQ0KPiBlbnRyaWVzIGFyZSBjb25zaXN0ZW50Lg0KPiANCj4gSHlw
ZXJ2aXNvcnMgaGF2ZSB0aGVpciBvd24gQ1BVSUQgc3BhY2UgdG8gb3ZlcnJpZGUgZnVuY3Rpb25h
bGl0eSB3aXRoDQo+IHRoZWlyIG93biBtYWdpYyBzdHVmZiwgYnV0IGltcG9zaW5nIHRoZWlyIG51
dGJvbHQgaWRlYXMgb24gdGhlDQo+IGFyY2hpdGVjdHVyYWwgcGFydCBvZiB0aGUgc3lzdGVtIGlz
IG5vdCBvbmx5IHdyb25nLCBpdCdzIGRpc3Jlc3BlY3RmdWwNCj4gYWdhaW5zdCB0aGUgT1MgZGV2
ZWxvcGVycyB3aG8gdHJ5IHRvIGtlZXAgdGhlaXIgc3lzdGVtIHNhbmUuDQo+IA0KPiA+IDIpIFRo
ZSBuYXR1cmFsIHJlc3BvbnNlIGlzICJXZWxsLCBmaXggSHlwZXItViEiICBJIGZpcnN0IGhhZCB0
aGlzIGNvbnZlcnNhdGlvbg0KPiA+IHdpdGggdGhlIEh5cGVyLVYgdGVhbSBhYm91dCA1IHllYXJz
IGFnby4gIFNvbWUgY2FzZXMgb2YgdGhlIHByb2JsZW0gd2VyZQ0KPiA+IGZpeGVkLCBidXQgc29t
ZSBjYXNlcyByZW1haW4gdW5maXhlZC4gIEl0J3MgYSBsb25nIHN0b3J5Lg0KPiA+DQo+ID4gMykg
IFNpbmNlIEh5cGVyLVYgY29kZSBpbiBMaW51eCBhbHJlYWR5IGhhcyBhbiBvdmVycmlkZSBmb3Ig
dGhlIGFwaWMtPnJlYWQoKQ0KPiA+IGZ1bmN0aW9uLCBpdCdzIHBvc3NpYmxlIHRvIGRvIGEgaGFj
ayBpbiB0aGF0IG92ZXJyaWRlIHNvIHRoYXQgYXBpY2lkIGdldHMgc2V0IHRvDQo+ID4gdGhlIHNh
bWUgdmFsdWUgYXMgaW5pdGlhbF9hcGljaWQsIHdoaWNoIG1hdGNoZXMgdGhlIG9sZCBjb2RlLiAg
SGVyZSdzIHRoZSBkaWZmOg0KPiANCj4gVGhpcyBjb2xsaWRlcyBtYXNzaXZlbHkgd2l0aCB0aGUg
b3RoZXIgd29yayBJJ20gZG9pbmcsIHdoaWNoIHVzZXMgdGhlDQo+IE1BRFQgcHJvdmlkZWQgaW5m
b3JtYXRpb24gdG8gYWN0dWFsbHkgZXZhbHVhdGUgdmFyaW91cyB0b3BvbG9neSByZWxhdGVkDQo+
IHRoaW5ncyB1cGZyb250IGFuZCBsYXRlciBkdXJpbmcgYnJpbmd1cC4gVGhhdHMgYmFkbHkgbmVl
ZGVkIGJlY2F1c2UgbG90cw0KPiBvZiB0b2RheXMgaW5mcmFzdHJ1Y3R1cmUgaXMgYmFzZWQgb24g
aGV1cmlzdGljcyBhbmQgZ3Vlc3N3b3JrLg0KDQpGYWlyIGVub3VnaC4gIEFuZCBJJ3ZlIHJlLXJh
aXNlZCB0aGUgaXNzdWUgd2l0aCB0aGUgSHlwZXItViB0ZWFtLg0KDQo+IA0KPiBCdXQgaXQgc2Vl
bXMgSSB3YXN0ZWQgYSBtb250aCBvbiByZXdvcmtpbmcgYWxsIG9mIHRoaXMganVzdCB0byBiZQ0K
PiBzdG9wcGVkIGNvbGQgaW4gdGhlIHRyYWNrcyBieSBjb21wbGV0ZWx5IHVuZG9jdW1lbnRlZCBh
bmQgdW5uZWNlc3NhcnkNCj4gaHlwZXItdiBhYnVzZS4NCj4gDQo+IFNvIGlmIEh5cGVyLVYgaW5z
aXN0cyBvbiBhYnVzaW5nIHRoZSBpbml0aWFsIEFQSUMgSUQgYXMgcmVhZCBmcm9tIENQVUlEDQo+
IGZvciB0b3BvbG9neSBpbmZvcm1hdGlvbiByZWxhdGVkIHRvIEwzLCB0aGVuIGh5cGVyLXYgc2hv
dWxkIG92ZXJyaWRlIHRoZQ0KPiBjYWNoZSB0b3BvbG9neSBtZWNoYW5pc20gYW5kIG5vdCBpbXBv
c2UgdGhpcyBpbnNhbml0eSBvbiB0aGUgYmFzaWMNCj4gdG9wb2xvZ3kgZXZhbHVhdGlvbiBpbmZy
YXN0cnVjdHVyZS4NCj4gDQo+IFlvdXJzIHNlcmlvdXNseSBncnVtcHkNCj4gDQo+ICAgICAgIHRn
bHgNCg==
