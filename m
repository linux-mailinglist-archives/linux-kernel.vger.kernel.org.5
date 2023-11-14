Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3437EAA40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 06:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjKNFr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 00:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKNFr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 00:47:56 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFF81B9;
        Mon, 13 Nov 2023 21:47:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiAP+fcUSC+MK/KY4HKmGkUt98EoAfYZl1UFjzjXWWLAPQJtNqDnCFI8ul3E/6G4kk9J0oJTzrVEUSpLZkKFaiCDtAz67wexCRf3rYQG0zaKyHBIwpntysevX+rXWb8AXa0guxyvTxTXuRNo74+Rd9lTaRHvpfDUuORDbLFinMXVDPD2N/1a1R9x6HgC/H+CyJeesLSfvGs7h1Gqpmf3DBFhPd7WBk+KUwALQipZ0F4YlFL0nBbd0of7InNUfoeEKrTwPK66GMls8vIw3zoYQH1rQlVIidu0ZoXXtZVt6Wa0lOr8ZABWxkdjSWWl9+NK6nfSO3zfF14H/YkN/tOp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3frhb0/M86ppROAOC/z0W7r2wEm1cK2XqJg0r4gsDA=;
 b=BgCEvG6ieomDnDdJwFV1CnW0cCoX4k7DqZbK6YGC6AjelEafb6ySU6d7M4KO7CeRfhbny0HtwJ2jD71RSplVBCeqjQ3n42ux8dwlwxLXwR2f+yVk3MdLseF7jZkm9mZnrd8eHb+Y6LG0aViAXqmjrdiiUuzJVtxRZPnK2JNJCi+1QIymVc9pXvVNHahAVwSeM8bUp3tO/FtFDmfbqh45sPRyMSe5Ubu8mZJRq8TMSRtrROKTbI043IPyYZyfguWUPTYqghvzys4Am51MCxOXmPp/DYIeapY46zQ8UNd/PvO+LRNHZaEeROTncIOrImT4ltnE98lw4tOML2QaARR/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3frhb0/M86ppROAOC/z0W7r2wEm1cK2XqJg0r4gsDA=;
 b=PqFGtl9Uc86NoN1zz7Glb9vWbzdA47Q2TGZiCXHnwxvn/aR1zaQXjLtsygfxVicgbSDYyN3a4sicAcy43voXWTZ75mGygJta7LSSulyaZUmjkaC60VLPadug9QfwZIMhXde4zDZqmmCdyEGXM2cTdTQHREta85BqJxn6x3OTTQk=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 05:47:49 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5c47:dae1:11f6:5188]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5c47:dae1:11f6:5188%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 05:47:49 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Mehta, Piyush" <piyush.mehta@amd.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] usb: dwc3: xilinx: improve error handling for PM APIs
Thread-Topic: [PATCH] usb: dwc3: xilinx: improve error handling for PM APIs
Thread-Index: AQHaEfz3TugyDnU4uEGeFolEAAsY2LB0OjyAgAUQWEA=
Date:   Tue, 14 Nov 2023 05:47:48 +0000
Message-ID: <MN0PR12MB595381B6BB4BA353060A677BB7B2A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20231108043441.2103940-1-piyush.mehta@amd.com>
 <20231110233810.ojsvcg3tqmim3lzg@synopsys.com>
In-Reply-To: <20231110233810.ojsvcg3tqmim3lzg@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH0PR12MB5451:EE_
x-ms-office365-filtering-correlation-id: 7b176045-9d73-46d6-be18-08dbe4d53c0d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: em5Ofry/ygH5u2N04ah4AihFe93ovNVpIjN+A6UbAr5hnqLrIp3YP8cWle6DwCAt/6knfvwFhhhXx6LxSJo2HJMdZWrIXLEJFKMza26Mgdmeu9WvDj+teQBk5pyaYQI3nVMpsC+3BP8Ft0Z52wY9JQtqWZqgTiu/L43ocoj+IjVN6SOu1dp5wClafs2RvDptCFYe/Z6Mi/74NOMa1pQF91crO5KQt1lXIvJfx94Eh26LXwX+ei2P5ly2IAZm8a8Ir83o4Xy5EMe5qF+OuFe0RrAHiYVq0Kuht/v1LYy5fewD5WTWUT7L+yp1t2Ydu9Zt0p4VGPHXMRxgwQf8KxEVG4pCWUQFq0XF8PDO6/W46og+nxfRbKnK0LjI01LSyrVjYKVVO793WuZyBjbF1NuY5Htf5WfJezb04J5/sCJJ+7KMZewDX/VEvAXB+Ia+syvsgsE76BdYkiwOIeCpI5k2RmIomJBGxpfObIXhHL5uQetJwrH6MSMpMn1gZln+ANLdnQU/bCLCPNqipDa+LSBWSnvxf0JvUP+h0MYgyvmPOTjUa60IbrmFUCl+UC6uKpQqcIwEi1aZecUy1pbpCgtpbhllnXL3/rLyZwe9ZC/U6zrlbW7xMZPmgscng/h/fBPs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(71200400001)(66476007)(316002)(64756008)(66446008)(76116006)(110136005)(54906003)(8676002)(4326008)(8936002)(52536014)(66556008)(478600001)(66946007)(6636002)(41300700001)(33656002)(2906002)(86362001)(5660300002)(38100700002)(122000001)(26005)(7696005)(53546011)(6506007)(9686003)(83380400001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWliMmJxeUdXQ1FWNi8zcmNwN000Z3BITmlmMTZsdmprN0NSTjg0Qytmempi?=
 =?utf-8?B?c1Y5RnRNS2IvZkw5VUhWbjNlZm1CTmlVeWRmUmJ4S25VS0J2WFJ3aE5HZ0RB?=
 =?utf-8?B?UFFFcXZKV0Q1dldac21xQ1VHZ0RDMWNqVEFYb2UyMzl3RU5WZFl6Rm5lUytM?=
 =?utf-8?B?aUVPT1puT2UxZHlmdkRKeHFNSGZxYXYyeWQrQWRTcEI4U1JRVTZsZlVDR3Y3?=
 =?utf-8?B?dFlkOExZRlc2VjlBYjFSNjNhREJjTTRIV2JzNklQaGxJS1lpeG5vM291S05o?=
 =?utf-8?B?Q2lpczA3bWRFMUhiRU1oTVg2aWNIRkRmOE1qNjlrR1FPaTZSQmozaU1hejMv?=
 =?utf-8?B?L1Z0bTlYK1RrVDhpdzY3VjFiWWpOUVVuaEJnUHlSNVQxc05OTzlJUXZwUkoy?=
 =?utf-8?B?Q2cxdlhRMVljRjl6UStZeHUxZDUzdTJBVDhrb3dRWDVPNi9VRUV5UmIvTWVi?=
 =?utf-8?B?akU2M1NhTTlLMDNaa3I5U2hDU0NWT0lUYmpIMDBwQk9XNHZtM3pNQWVzU3Jw?=
 =?utf-8?B?RnpNZk5QZy9qTnJZRkVPY25sdHNlU2VNbGxSOGo0amYvd2NUNjF4cVNNQTN6?=
 =?utf-8?B?d3pic2E3N0xDMS9HckRVTHNSNmcxOUxBb2RxeWk4RVJIeWxtRVEwRS9Kc0RQ?=
 =?utf-8?B?eWhNdkdnckZTVjA2VEczRjNRalVDbGo3cGhSNm9pelJiSDVXc1FENW5QZFFT?=
 =?utf-8?B?RUkxc2syNUlnV0ZFQ1NTRGF0eW5xUXBMUDlZMjRwa0tiTE1sNTlWZjZhMlN6?=
 =?utf-8?B?dmwwQ3hRRC9mcnFnTVNEdFo5NUQ5OWJSNDg0SFR1cEQ0ZHpCZ0h0ZmFKbHJX?=
 =?utf-8?B?aVZ5UncwTzVFdVVERzRiNmRFbTNZeVVFOUtMTVlnSXIvWmR2NEI3ZWVpSVpm?=
 =?utf-8?B?RXhzaDlNZFpKOTgrMnBGcVhYVXo1N3hNNi9yZm40dW9JcExYYnVlVGFqclhw?=
 =?utf-8?B?V1VuQlhaSlJmVU1VT0dYQ3NpT1FUN3d0LzlUK0NXR285ZVlKQURNVksrRTNG?=
 =?utf-8?B?V3ZJQXFtRUFEVUpTamNVRXBSVUdQQXhhbEdEM2E5Y3BpblEwVkNRSkYvdG5j?=
 =?utf-8?B?OThRWFNId01NSS9tUXZVR0V3Z0FERS95eHYraGpZZVRVMDFocWNNa2ZnRDFG?=
 =?utf-8?B?Zk9XWEExN3BJSERZWWgxL3hGaXlWVGFRTy9sZ1paVzdSQTV5SjltRjFVZ3A4?=
 =?utf-8?B?S1pSVEFFb3JSaFgxSGFRclp0L2srWW9EeFFhZUFQSTVZcXVMRWY3dmJrazBE?=
 =?utf-8?B?VllYSjk3akxXU0RzWDNHUjgxSGRBdXFWakovTnBraEw2Ny81QkxEOFBUTDhq?=
 =?utf-8?B?UUxmVTViWE1uK2xTdFNRSXVPZU92NEhMc2t0OEhPZTBRK0RxMXhxemx1WTUy?=
 =?utf-8?B?SzJTbmdtTVEzejJvL1ZvTjIvQUptT2ZONko5eTJ6VFA2dmJGVzRhOGhTNDdN?=
 =?utf-8?B?WjdRRCtBMHYyaTdYUlpPTWJhSHU0dnZxZEQ4VGpUMFZRVmlBMXlMZWYyYjZ0?=
 =?utf-8?B?L0VsUGg5bjVwTXZ5cjZPN3hBZ1lZQ09hS0trNlZPNkdpQXN2dmxabGlOZjhI?=
 =?utf-8?B?Zk5qNFd5cGtRWHhLcFptV3FUSlJBU0VRZTU5VTBacDRscWVrNng0WTR0SU95?=
 =?utf-8?B?V2xSb0Y1c2tMT2FpV2ZuWkMxQnExWXRpM2ZwOFcwSkZyY2lWY2FHa1hieFpw?=
 =?utf-8?B?OXhJWU12K3kzU3R3dzY0NFpvWXoraHExWVNRY2x1WkJrV2ZaanJuSUUybE5u?=
 =?utf-8?B?N1Y0clE0NjBKMFdXVXVUUG5RUU1sU3ZkSUE4NDc2b1pMSHZ1TEN6anhBL2E4?=
 =?utf-8?B?bFczM2pZbFF2UkVKcjFBd3EvSGtyUS9EN204WTR4aEQvWCtCRzhoV044K1Qy?=
 =?utf-8?B?bmlsaDk3UmROeVRQM0FydEw4U3hDRGZLYStpWS9BRWhKcGFYUmFLMUVTTnlu?=
 =?utf-8?B?TTFHeXBUdjRJU1BVZ0ZpUjlGQ09EcjdobUZRTjh4eW1pRVgxNnZxSjJZQXlz?=
 =?utf-8?B?c0JzaVF3K3BzWEoydFBHYlJIeXZ1OEplZjYyZ1gxTXUzbXNDbEhZRm4zR3BK?=
 =?utf-8?B?Z0Vpci80cGgyVTRYQ0IzdWR0QWZhRm52dTFPZ2NaNTQyMlNJdXRnc09VaHlx?=
 =?utf-8?Q?xmh8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b176045-9d73-46d6-be18-08dbe4d53c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 05:47:48.9439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3shemPspHQ5WQuIsgDZe6LI4PtH0JfmS/qeO+S01i+1NUWELpWOyki2qLBw6LzE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciAxMSwgMjAy
MyA1OjA5IEFNDQo+IFRvOiBNZWh0YSwgUGl5dXNoIDxwaXl1c2gubWVodGFAYW1kLmNvbT4NCj4g
Q2M6IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2lt
ZWtAYW1kLmNvbT47DQo+IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT47
IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSB1c2I6IGR3YzM6IHhpbGlueDogaW1wcm92ZSBlcnJvciBoYW5kbGluZyBmb3IgUE0gQVBJcw0K
PiANCj4gT24gV2VkLCBOb3YgMDgsIDIwMjMsIFBpeXVzaCBNZWh0YSB3cm90ZToNCj4gPiBJbXBy
b3ZlIGVycm9yIGhhbmRsaW5nIGZvciBQTSBBUElzIGluIHRoZSBkd2MzX3hsbnhfcHJvYmUgZnVu
Y3Rpb24gYnkNCj4gPiBpbnRyb2R1Y2luZyBkZXZtX3BtX3J1bnRpbWVfZW5hYmxlIGFuZCBlcnJv
ciBsYWJlbC4gUmVtb3ZlZA0KPiA+IHVubmVjZXNzYXJ5IEFQSSBwbV9ydW50aW1lX2Rpc2FibGUg
Y2FsbCBpbiBkd2MzX3hsbnhfcmVtb3ZlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGl5dXNo
IE1laHRhIDxwaXl1c2gubWVodGFAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2Iv
ZHdjMy9kd2MzLXhpbGlueC5jIHwgMTAgKysrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiA+IGIvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LXhpbGlueC5jIGluZGV4IDViN2U5MmY0NzZkZS4uOWNmMjZlOWExYzNkDQo+ID4gMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jDQo+ID4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9kd2MzLXhpbGlueC5jDQo+ID4gQEAgLTI5NCwxMCArMjk0LDE1IEBAIHN0YXRp
YyBpbnQgZHdjM194bG54X3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gPg0KPiA+ICAJcG1fcnVudGltZV9zZXRfYWN0aXZlKGRldik7DQo+ID4gIAlwbV9ydW50aW1l
X2VuYWJsZShkZXYpOw0KPiA+ICsJcmV0ID0gZGV2bV9wbV9ydW50aW1lX2VuYWJsZShkZXYpOw0K
PiANCj4gWW91IGp1c3QgZGlkIHBtX3J1bnRpbWVfZW5hYmxlKCkgcmlnaHQgYWJvdmUsIHdoeQ0K
PiBkZXZtX3BtX3J1bnRpbWVfZW5hYmxlKCkgYWdhaW4/DQoNClRoaXMgd2lsbCBmaXggaW4gbmV4
dCB2ZXJzaW9uLg0KPiANCj4gPiArCWlmIChyZXQgPCAwKQ0KPiA+ICsJCWdvdG8gZXJyX3BtX3Nl
dF9zdXNwZW5kZWQ7DQo+ID4gKw0KPiA+ICAJcG1fc3VzcGVuZF9pZ25vcmVfY2hpbGRyZW4oZGV2
LCBmYWxzZSk7DQo+ID4gLQlwbV9ydW50aW1lX2dldF9zeW5jKGRldik7DQo+ID4gKwlyZXR1cm4g
cG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChkZXYpOw0KPiA+DQo+ID4gLQlyZXR1cm4gMDsNCj4g
PiArZXJyX3BtX3NldF9zdXNwZW5kZWQ6DQo+ID4gKwlwbV9ydW50aW1lX3NldF9zdXNwZW5kZWQo
ZGV2KTsNCj4gDQo+IFRoaXMgZG9lc24ndCBsb29rIHJpZ2h0LiB3aHkgc2V0IHN0YXR1cyBzdXNw
ZW5kZWQgaGVyZT8NCg0KU3RhdHVzIGlzIHNldCB0byBzdXNwZW5kZWQgaW4gdGhlIGV4aXQgcGF0
aCB0byB1bmRvIHRoZSBzdGF0ZQ0Kc2V0IGJ5IHBtX3J1bnRpbWVfc2V0X2FjdGl2ZSgpLiBUaGUg
aW5pdGlhbCBydW50aW1lIFBNIHN0YXR1cyBvZiANCmFsbCBkZXZpY2VzIGlzICdzdXNwZW5kZWQn
Lg0KDQpUaGVyZSBpcyBhIG1lbnRpb24gb2YgaW4gRG9jdW1lbnRhdGlvbi9wb3dlci9ydW50aW1l
X3BtLnJzdA0KRm9yIHRoaXMgcmVhc29uLCBvbmNlIHBtX3J1bnRpbWVfc2V0X2FjdGl2ZSgpIGhh
cyBiZWVuIGNhbGxlZCBmb3IgdGhlIGRldmljZSwgDQpwbV9ydW50aW1lX2VuYWJsZSgpIHNob3Vs
ZCBiZSBjYWxsZWQgZm9yIGl0IHRvbyBhcyBzb29uIGFzIHJlYXNvbmFibHkgcG9zc2libGUgDQpv
ciBpdHMgcnVuLXRpbWUgUE0gc3RhdHVzIHNob3VsZCBiZSBjaGFuZ2VkIGJhY2sgdG8gJ3N1c3Bl
bmRlZCcgd2l0aCB0aGUgaGVscCBvZg0KcG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKCkuDQoNCj4g
DQo+IEJSLA0KPiBUaGluaA0KPiANCj4gPg0KPiA+ICBlcnJfY2xrX3B1dDoNCj4gPiAgCWNsa19i
dWxrX2Rpc2FibGVfdW5wcmVwYXJlKHByaXZfZGF0YS0+bnVtX2Nsb2NrcywgcHJpdl9kYXRhLQ0K
PiA+Y2xrcyk7DQo+ID4gQEAgLTMxNSw3ICszMjAsNiBAQCBzdGF0aWMgdm9pZCBkd2MzX3hsbnhf
cmVtb3ZlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAljbGtfYnVsa19k
aXNhYmxlX3VucHJlcGFyZShwcml2X2RhdGEtPm51bV9jbG9ja3MsIHByaXZfZGF0YS0NCj4gPmNs
a3MpOw0KPiA+ICAJcHJpdl9kYXRhLT5udW1fY2xvY2tzID0gMDsNCj4gPg0KPiA+IC0JcG1fcnVu
dGltZV9kaXNhYmxlKGRldik7DQo+ID4gIAlwbV9ydW50aW1lX3B1dF9ub2lkbGUoZGV2KTsNCj4g
PiAgCXBtX3J1bnRpbWVfc2V0X3N1c3BlbmRlZChkZXYpOw0KPiA+ICB9DQo+ID4gLS0NCj4gPiAy
LjI1LjENCj4gPg0K
