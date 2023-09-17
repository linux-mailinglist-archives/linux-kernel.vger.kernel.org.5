Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13E77A36DB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbjIQR0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbjIQR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:26:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2139.outbound.protection.outlook.com [40.107.114.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D47BF9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3AScnde9RT/SpOmBfN/MV4i3yg7sMq8eEA9qmsW9kd/3xJHRJC1kZdbCthXqqbLuLwl4y5wsvbOkwlCzIbHONqqAwMOMzvu9DMlY3/PqN+kGC5k24/LTrIvxmzROikkU4mlr5BMroXvH6zhhQeanXY5G6j1RLyoIaqjBEcfcSjO4ODvxB/CaL5qIME8q0U91wIMkGICis/XrpjM4j4xyyx38PD6OIVWt8DpYp9BeOMSBDoWhJGMBmMSSGR5mcPGLMiowp/Cr3d7Zqg0HI4h1YKWsExOCnAzupTJVgtTON/hl0hhPRIzS6Cq/SXGtaYUzeFN7VyywHTkakLcBLglkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw668z8Q8SOHtstJVfEMdMZRbqXhCA999Yhd2tyVjt0=;
 b=nFd1nWMLh5tadgSnLFu5Zg98q8dg6dEbe58YkwwOqg/HhsdhiL/P9TF6sqj2PqNpbC6kNXw3jG7fxUPo1qoU3hijuZYhSnIUDeLVCzxMQczvTgaf4jK7SachmZOf7M8HpbRG4H/Bg54fr5MAtALxmv6VO3PTTprf0Sa/q9DQG8QECJjiOTR1fhxa4HgsHU9PK9VtkiZRofAeXdeOKK9bmmrQTS2dCPqYSGqLD2Y8rPMvnTnCuM1uearPqvik+xx5wGtGN99WACkNQufJJUGSkl/Da427Ym35SsqkngV7Bw5TOxBa60PcuDOrGhoVRaIrHDH3BomFOXS9/SEEnWkgPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw668z8Q8SOHtstJVfEMdMZRbqXhCA999Yhd2tyVjt0=;
 b=xhX0+SOg2xd9INtbCrNekNlueBx3URsa0niyV1mEghN8QvI5x8mP6/ehfIo5qYg51quLCX5g6cOTboYbEZl1uy/tcaBTNNk3JZhxrOsAyb6M8kTLKv9tEKQ5pDbHN9LRcVoyQ0hA7GiFSAEjH6r6AqF5qLTKeXDu/7uQ83dthvY=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYWP286MB3676.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3f4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.13; Sun, 17 Sep 2023 17:26:14 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7dbd:f4f5:734e:c93e]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7dbd:f4f5:734e:c93e%6]) with mapi id 15.20.6813.014; Sun, 17 Sep 2023
 17:26:13 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "yunjunlee@chromium.org" <yunjunlee@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFMU0E6IGR1bW15OiBGaXggJmRwY20tPmxvY2sg?=
 =?utf-8?Q?deadlock_issues?=
Thread-Topic: [PATCH] ALSA: dummy: Fix &dpcm->lock deadlock issues
Thread-Index: AQHZp3fywsqsa+nIJUORNCRxL38reK+b0p+AgAEUS5KAgt7nGQ==
Date:   Sun, 17 Sep 2023 17:26:13 +0000
Message-ID: <TYCP286MB1188D5F722F42601A08DA29D8AF4A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB1188FEE149369A32D90DCE288A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <87edlzwgti.wl-tiwai@suse.de>
 <TYCP286MB1188D860B56B9FF1FCAA79148A26A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB1188D860B56B9FF1FCAA79148A26A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB1188:EE_|TYWP286MB3676:EE_
x-ms-office365-filtering-correlation-id: db9fe7e5-af71-40f2-f238-08dbb7a33169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OTyMXyvtwuoIJcWeSjZa/qTgpSQb8T0/6CuTyWqJ/mQ0u6nL48MQznd+6iwRxCP96XA4zFMEsm4VqmFm2qG2zB84o1YAloF+BDIij867RCwhWkHW/ow4ltTd//aefcfa0VUiGNYzhudrK6zpV8+tTomroQt5vGtJrrU7WD9BavAR7zJDK0c7hKc53gerHdEGVwonxfYXUhIitca/K07Tr2NUEV+BIM0L+NYyFfT+W3aI/xIk2IdPmLUYFbNdC5TLacWHturVMLvnlcW7R5iCquzvn1oFEK6fNyI9zhAJK/Vl6h5etxNBi0YoEk7MFgHukdM1PIAHGmiboRWlUhxKsOfKQbuj9QGUfq2tm2DHUhFx6xyCYxDqUOtPS+vXrBzj9vPRVl9R+P2kdQd3jfL/xWlpbnrS0p3rcqOEblwsZNZqrF4E1ZLEUjEs1scJV1E2ewClqWpwzREYXhr8MQH/FidVmXeyUBF0336OZ1ePCtiZubONJfsuDctndEyxErq9aQhSRDMGiCgCvS8FB2ed04RbFtDyCamQGgyOz+BMCwmsDYGl6nIZ4MEBt4XPSPEyxfSckYUyfi6JksPLYHc3rSKfp0W8IBFtNn4n8Cg9I+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199024)(186009)(1800799009)(316002)(786003)(6916009)(8936002)(4326008)(41300700001)(55016003)(26005)(83380400001)(9686003)(966005)(224303003)(478600001)(55236004)(7696005)(6506007)(71200400001)(86362001)(122000001)(38070700005)(38100700002)(33656002)(91956017)(76116006)(66476007)(64756008)(54906003)(66446008)(66556008)(66946007)(2906002)(4744005)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG9VeVh2OXc5MmllMGZidk82eWQ1SENYWVNiYnFWM21vMm1rV2VDazhEd0Vw?=
 =?utf-8?B?Sjc1ZWl6V2tvZzNyaG9BbURJaVllYktER0x1TVpKMzdRK29Uclg2R01FNTA4?=
 =?utf-8?B?NFNKRUxYbkR3cis5WUtUZlVIclRuakV3MnZOYzJSWTN2QVJSZUZ1Qm1yakpt?=
 =?utf-8?B?WU5sZ0hNMlMzSmFIU2E4eVNsaUFFN3c0RGhHbFdoQ1hVRklTZzNJMytwbW85?=
 =?utf-8?B?WWRINVhvbTlKS2pGTXlaNC9yWk9ZeE1RZWRjUlMzdDNNQWlMOGhkaGNSUG5o?=
 =?utf-8?B?UTRHbndvOTgzL1RNMTAydEpFb29EQWdXR0VDZG9XVmZvZXRyclJUd095SVBv?=
 =?utf-8?B?bDNzM2JyNE91R29hMWp5S2tlZEhQclNtbWFhK3pvQU9yN2o1N2QwcHh6QmJD?=
 =?utf-8?B?RE9GMXBXN0NSbDd1VGgwTEpSaHRVU0V1MzN1bG9obERzOHo1ZUZ6S3ZkZ1ZM?=
 =?utf-8?B?eXJsVm50UGkxNlJZQWplTFNRc3VCb2kyVTFkYnNtQkx5dHBXRmdPQ214SGFw?=
 =?utf-8?B?UDA2Zit5TXk0Q1dYdy85WktNUlNaL0NkeTRQZ05qMDBra1k1d2pXNU1qZ3ND?=
 =?utf-8?B?bWNmRFk3OW56VU85T3B4cTd0aGl6a2NOeEsyN1NuMHhEMXh5SG9JNXRnc21Q?=
 =?utf-8?B?cnI4bmdaSEVEWko2aW5PQy94V1AzdEdRbjB3Tlo1RFhJMUtVNEwxcUNtV2lD?=
 =?utf-8?B?TXFtc2Z6Y05RalZ3MTBFaXJZRmlkb1J6amwvVFVLT1JDa0x1NlRQazJMQ2Jw?=
 =?utf-8?B?RkpMc3RSMXAyM3RLOUJ5bG90LytTSVd2ck84RWtqQ3pIWUllaE85VHZFN3c3?=
 =?utf-8?B?ckw4aWJxWnlCK09ZNS9JdUN2b1dDbFR4cVVDVkhZWjZ5ZTBJeSs0RjJDOS9R?=
 =?utf-8?B?MUdEYlRSNnlJVXBreFh0ZDMwRzZTZmpsc2NUc1hKMjBKeGZYWXRoU3MyY0ZH?=
 =?utf-8?B?MG5hUGgzbFVWTm5kU2tXYldqbGxGZGxBU2QzamdOMFEvZU91Si9SaGFhM1hZ?=
 =?utf-8?B?bTRaNGhPZllhdmlCWHpFeUFRRzZFdWVjbk1XYlJlaXZ1YVNyNkx3cjRjK1Zi?=
 =?utf-8?B?aGN5SERiUmlyT3p6aW8xMkt0aW1Ub0k2THJjMGRkTWRiemJqSnFTK1FtZzJR?=
 =?utf-8?B?ZWJHbVJxM3JxU1ZtenRlMmFrYUJ3b1pPK2dzUE53WFIxUit0emxXR1k1Ri80?=
 =?utf-8?B?TVNaSVhzS1pOTnVJeDhvbTh0QURSaGFzbkRnZ2g0a2NMQ3JZMm50QmRkeDRS?=
 =?utf-8?B?TitRSlZQaDFsK1Z6aEhsempCazl0NVBjaTduL0s3YzFvQmg0bmpBZ1ZBSDRI?=
 =?utf-8?B?NWkzM3VWOWJKYmIwdGVsMGNHNHNJVHlUa2gxbDdiWkxET1RCa1pUZlpwY1Zp?=
 =?utf-8?B?d2RyLzFOa29kY0R2NUgxMUhWN093cjJXdVNkblRxS3IzRitlOVZ1K0ljUElR?=
 =?utf-8?B?ME9iUWliN2tXMWFIalVhZ3MwVWJhQzJvZ2RCbzRUODVzRFN2cGw2STQvSzJu?=
 =?utf-8?B?bCs4a2JBb1dmNXgyeGVyNitYcWRkWWcreldYRTlTYjdueEwrTDNXMkZ0eXdy?=
 =?utf-8?B?ZGFWdUpNNnVkQnQ4SW9BVUVLeVU4aWpwaEgzYmZSbmlsQ25Bb1FQS3cyUXhz?=
 =?utf-8?B?VWpJUzY4REJrb1YvUml2YWRyK1IzRFRjRHFPS0VWRjJDelZmdXR2ckl6a2kx?=
 =?utf-8?B?S1pYZzVRYXNyeE02Q0xVNVlYazFXWXVnTjlLaWxDbDRpRmhmM3Q5Ky9CTGNG?=
 =?utf-8?B?akM2Q2E4Nk41WjZjanlUaDRIVjRVOG1mTGRWNzYvOUt5bFAxWitxM2kwZXk0?=
 =?utf-8?B?bkF0S1ZENzZkSllPY3lpRDl4NDBRd09LWStxb0VxUlJzRVBoRWx6ZjhUelIy?=
 =?utf-8?B?dkk2bGdHYm0yV2gydmhrUTdIZjNHS1NDRStPV2NtdHZvSHQ2T0FDRS9waTA5?=
 =?utf-8?B?ZWp5Z2hoOU9OZmRXU3ZQV1MwK3N1TVNrMStMOWdFWHJBRmNoV3ArUVg4RVFD?=
 =?utf-8?B?K1h3SmY2Q25SNWRuRWxPc3Y1b2JuRmQycXdIbjFHd1M5VzlORUpCZWVseGlY?=
 =?utf-8?B?bElrRkxIUjc0b3RQU1U3VFF6dTVpN3F3bDdPYlI5VFNGNmRTN0tUT0JWMUE4?=
 =?utf-8?Q?PDp2Gf+ncBBPo1Xu3gZka1KAg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: db9fe7e5-af71-40f2-f238-08dbb7a33169
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2023 17:26:13.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86SFcgMMGrOiN+AORgA/zRH2FtSSO9I74l6WfVhinB5HQaXjQ1p7utVhnspxJSGVb8Vm1qsJMoaikLnexUH1pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3676
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGFrYXNoaSwKClNvcnJ5IGZvciBpbnRlcnJ1cHQgeW91IGFnYWluIGFmdGVyIHN1Y2ggYSBs
b25nIHRpbWUuIEkganVzdCBub3RpY2UgdGhlcmUgd2FzIGFuIG9sZCBwYXRjaCBwb3N0ZWRbMV0g
ZnJvbSB5b3UgdGhhdCBtYWRlIHBjbSBwb2ludGVyKCkgYW5kIHRyaWdnZXIoKSBjYWxsYmFja3Mg
Y291bGQgYmVpbmcgYWJsZSB0byBiZSBleGVjdXRlZCB1bmRlciBub24tYXRvbWljIGNvbnRleHQs
IGJ5IHVzaW5nIG11dGV4IGluc3RlYWQgb2Ygc3Bpbl9sb2NrX2lycSgpLgoKSSBmaW5kIHNldmVy
YWwgc2ltaWxhciBkZWFkbG9ja3MgbGlrZSB0aGlzIG9uZSBvbiBvdGhlciBwbGFjZXMoaW5zaWRl
IHBvaW50ZXIoKSBhbmQgdHJpZ2dlcigpIGNhbGxiYWNrcyBhbmQgYmVpbmcgaW50ZXJydXB0ZWQg
YnkgaGFyZGlycSksIEkgYW0gY29uZnVzaW5nIHdoZXRoZXIgdGhleSBjb3VsZCBiZSByZWFsIGRl
YWRsb2NrcywgYXMgaWYgdGhlc2UgY2FsbGJhY2tzIGFyZSBleGVjdXRlZCB1bmRlciBub24tYXRv
bWljIGNvbnRleHQgdGhlbiB0aGV5IGNvdWxkIGJlIHJlYWwgcHJvYmxlbS4KClRoYW5rcyBtdWNo
IGlmIHlvdSBhcmUgYXZhaWxhYmxlIHRvIHJlcGx5LApDaGVuZ2ZlbmcKClsxXcKgaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2Fsc2EtZGV2ZWwvcGF0Y2gvMTQwOTU3MjgzMi0z
MjU1My0yLWdpdC1zZW5kLWVtYWlsLXRpd2FpQHN1c2UuZGUv
