Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E979756031
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjGQKNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGQKNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:13:45 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FD8A1;
        Mon, 17 Jul 2023 03:13:44 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H7R942008998;
        Mon, 17 Jul 2023 03:13:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=sWbOHeHsCTR6pJejLeL/mQVgFRGqZuW0Hy7Gr+cQB+k=; b=
        H9E4Dk/asu1cgxkttQFFJvz4zHtVTi3Jp6BsAUTCZR9yQ+x6MZD410C5c/YMAFpb
        RTBOzsWv93VGeegO6+CM1jnT+/yo9fuQ3lLtslie1PYqk1RAY6VyHqRpNKkFNH2j
        m7BmUvIV0zcvuZUHKVeBx3M2Yy7kjlcLIqBce/M+cJAV7BMXOkXlOeESdZCUx2pq
        3iTsYOyY+jFFFE60tmxtJ7Vgt33csyImAnloVd6pccZgBfsoRgiaT6dJ94UpzdPb
        HOmJv0CEzVApt0+pMk9mWMALykO2E5edWQG6ch0Nt/vV2Vj9PtTlzMe59lzrKt2G
        qPLUAS93RzAP6RQ0KsG42g==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rupqy9exb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 03:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcMDO4TDJTFapjHxt12ym/W4akGT/edIksn6ErAi/l4nUW8HOJmart5RiJ0Zv1XUS4zPuEr9BRNz+xivWpJEuONdf4mbV2jGIg8PBZof4ck4LIs613BHPTODb8u9nLvilfEwUBPlLG0FpG9XKlC4BQEUMBuhai3DqIJND6PyY2L3734AZ+2M46bMuvLEqVzM6UxwC9Sk+wg3/LON7pIWNLS1BcFgnGlyAUz8ihdehV5jGD4LQ6jPtuScMSimLPSGOei/wTf7gDeHwovlD2tgRDUJZSrWt/77CxTgw2viFjLtqiqXLkPz/ailW/7oYxMW1kHKws0EHWreo9IUSYKD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWbOHeHsCTR6pJejLeL/mQVgFRGqZuW0Hy7Gr+cQB+k=;
 b=aDoGXUHV2mKzLv24ck6eZXCzRWiPkEotKl+LcQ5Vs4KxsHdzCT/vogFhllZLcuziFjeZaNPAU2heDfIZG0bDUa+KStEA2FiBqtPFcQ1mNZBdG4zgNSIYmbCKG+6ViagHBXavVKoiGjHX/M1EiFmihBeB4VFwL50zQ6+o8I9yiQNyjafXV9NnfU5yuK76Gv+fO2HbvBFaVt16Pc006paiKNAZdbsgRPnP7zH0QMlHqtNCUa5H8tUMAt5+nOepWfjeBKE3uOWyrcxA2AaTlxHV3tPsaoseESYQkFPetNEh9Q/btAs8UaMh7zyZxYv//utXL8EunyF3PPMbABxZ7MuZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 10:13:30 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::c007:45a0:16f2:8b69]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::c007:45a0:16f2:8b69%6]) with mapi id 15.20.6565.028; Mon, 17 Jul 2023
 10:13:30 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc2: combine platform specific data for Intel
 Agilex and Stratix10
Thread-Topic: [PATCH] usb: dwc2: combine platform specific data for Intel
 Agilex and Stratix10
Thread-Index: AQHZuIvZZqtELlXHrk+VsNW6dqs7Tq+9tNsAgAAEMYA=
Date:   Mon, 17 Jul 2023 10:13:29 +0000
Message-ID: <PH0PR11MB5191AA947AAE954FF2169FCCF13BA@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20230717085053.1075077-1-Meng.Li@windriver.com>
 <9a3dc092-7278-cda1-cd4e-c157e0e2c431@linaro.org>
In-Reply-To: <9a3dc092-7278-cda1-cd4e-c157e0e2c431@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|SJ0PR11MB5200:EE_
x-ms-office365-filtering-correlation-id: 4b1aaf96-dc0f-4ef4-ec30-08db86ae77fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X55vvUzVIIOlMN/PS4lcrhnBMfn5Lwob073Tetc5HFaGXK9W+V3ML/V4XGXvBj2f5ZooPObCaVF8ymcKGE18O6WX+frN2Yyd/ROopBO++2YFuauRf03u0/78i0qHBn63mnN+Cm4+Lf7lTlwukWjTwKRtPulSVLWNLYENxE4QaGQZCiUYzPuf3YCl3SwHjtX8N+ymdzbbto0wNzt42hgvLc5tVlSIk7mKL3a5gjjoZk9vsRUUaaL7j/UX3ar0Ob0JG/JI3+a7ldbDIhzh+pEKCfHbbj9Er4495Yg9WS9yJbpwomXuuhpd+6uPEtPTuFLxZU29GYRDdsrbWVg6ardXeVbUQinNNaCZGGpirMukwWlAcWdS/eRW94mz1TegQF5EVok/JTaGCB3leEvHW7LXKTpA0IZNSll3l1pwbJXEQ8gSRhk/Vv7+KbzyomLQaxIOVI/5Zi2w4itU0Bq6fGd4W3uzeBtmQwvhH+mbmP3Xd/O2CSJZKTun+JymtpP3t/uup+lpezpQ73ywAPDzZV9I8HMV/dkdXBGafdvIhhwmY96L5Wfial8wCfzW+drRreL2svVWADL+5njJSUGVt6gBerJGNIKdpfoC7xx7CXX6nY1bYZQZ6+j12L+lOl7ebBr0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(136003)(396003)(376002)(346002)(451199021)(478600001)(71200400001)(7696005)(110136005)(6506007)(186003)(53546011)(26005)(316002)(9686003)(76116006)(2906002)(41300700001)(64756008)(52536014)(4326008)(66946007)(66476007)(66446008)(5660300002)(7416002)(8676002)(8936002)(38100700002)(122000001)(66556008)(86362001)(38070700005)(83380400001)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGQxTnc0VnRjbERzMStTc3N5QlVZU1RRaHdVb21tcDJNTU9scTdHbE5kNEVj?=
 =?utf-8?B?TTBrdjhEYTJyTUFyTlR2RjBPVlJZUWVma2FzUmRrR0pzQ1ZHaDh5OXlBL0Fn?=
 =?utf-8?B?cUluUnVDaTM1ckxUZUZ2amFmdlg5MENlaDA1ZjJIblNUV2JqbEQvL1gxcGY5?=
 =?utf-8?B?RFF4aGN0NWhHZTVjZ0kvaHlabGFsT0hQdUhwbTVDdHFDMGk4S1FHSHNKR0NK?=
 =?utf-8?B?bzNHTXRRQlllaWM3R0lQZ1JKajRjRXNLUVVBdEJrY28xMHZSekFKNWpMTCtS?=
 =?utf-8?B?OVJMV1BOeHdVL3QwZmNlcmZCODJSWG5qUzhzcE90MTJ0ODlvZzhiNzA4UDFX?=
 =?utf-8?B?MHhYMUpib1dEN2dlOGU1NHM3TW9PK24wUDVqQWVmWjNVOEVGaVBsUzNUMWRu?=
 =?utf-8?B?NlQ2K09NQWdHd0svODF0MjNEK0kzUXVnRkE4aGk2S1N2ZTlEZnkwUDNFZWsv?=
 =?utf-8?B?WHQ3eC9uMnNPZmdPcThpQkJPNDIvRktTY1crVGFXdG96cUNHN21EeVZxUDZz?=
 =?utf-8?B?c0tFdTB1WFo3bDViKzFSTzFhY0djU3R3YjZEV0w3MU5MYkh2QWVEWHJ3a3k5?=
 =?utf-8?B?Q3BlU0k3R3pJNG4wTnp3K1J5azU1U3E2aWVHVUV6dDEzUlVpWnJVaHVaYzBn?=
 =?utf-8?B?NW5KeWkwRFhha05SOW1RbHR4YldDSjhacVdZeExVQzVwRnhKRnVGYW1lcUhh?=
 =?utf-8?B?N0lYbTVJdFM5UWMxMHljUE5yMENNTTFGMTFTOXlwUHl6WW9VaHEwb1lwV2NJ?=
 =?utf-8?B?NE42NkNHYVlqVVdLOEZhVHZiV3d3dUx2Y0hWY0xmZHJNRG12a2hKNTI1VGo4?=
 =?utf-8?B?UVhXWFAzQlZaci9wKzhDbFluRFVoK2tscFI5VFpFQWV1MlY4VHVKY0lKZnBn?=
 =?utf-8?B?WGdwMEwzWWRlbE9xTDBQYmJpeTNrY05INWtBa3pORHZSVVNJUWRzZnNQaDlz?=
 =?utf-8?B?aC84SU5USDVGWlJhUFBJYnJjTmxFa2NXamFUMzNMVEk4VVZ4TmdXR05VTUxT?=
 =?utf-8?B?RGRrK1p1dXBWTGVMbWpxNVJCWEVKZW1wb3R5a1R3a3YyZDVvVW5JN2pnZG1n?=
 =?utf-8?B?UG4zNGVsNllEZGhDMGFlM1NpZFpJMXo4WUhLb3hZNzA1UTYyNzUwUmtHbmFh?=
 =?utf-8?B?RHdzVVhoZnlUR25BaEtyVjNsZ3FCckV5OW1sWDVqMHArUFBCMWQ2MEw3RjNH?=
 =?utf-8?B?VHBVSlpOTWlZQ3lyN0xPUmR6MW5peWwwaGhWQ1dLM0RpQWJZZGF4UnA3c2hw?=
 =?utf-8?B?azYvT2RWK2I5a2JIMkhnZ005KzJlLytKaEdOZ3dVSk83WG9UcThheG90Mnl5?=
 =?utf-8?B?eHZPcjZEanJXTXVoMUNPMUJycG9XVncrVUJiZ1ZDNEZ2SEJ3NzhJVThFbUJt?=
 =?utf-8?B?YWlUcjVGNEpER3RmK0cvOWkwTzdFd0JSb29UT1h2ZHZXMGgraUdrL0ZId3lY?=
 =?utf-8?B?THNJYVpIY0p1VjRnSDErWnVUZ1hYdlJiNXhubW5sOFYrVmd1QVVyamcycy96?=
 =?utf-8?B?MzJNbmNKSmdSMmtyYVFTbUdVUFp5cmh2Y2hDbVhjdVJwRWRWNWN0dGhVR3dR?=
 =?utf-8?B?V0Z0SWI2bnEySDRsYmNWNXd4aVlkajU1cy9WWXlDY3crTWIwSzduTXczL2k3?=
 =?utf-8?B?VEFmTjhJWWhzWmdxeWVqeStNUzVUVmRFc1ZuckFTeTB6V1VaazZNUng5VCsy?=
 =?utf-8?B?SWV0Qmh6VXJxZEx6NUpxZHJxdHh1dXNlMkRLd1dEdERJaEJsN2xMWlRodDda?=
 =?utf-8?B?OWsyTTI2TUFoNzAwNjZQdU15dzlVTlg2cWhNMVlMYTk0TmUzczMvUlBLazBu?=
 =?utf-8?B?K0tMM1R3c25RdEZCcFNEYW9ueFZUMm01aUpTV0ZiM21TTjZGb3lZRm1ZSDdL?=
 =?utf-8?B?MW9JdGN5bTFoT3EwR2dsSTBTSUhIRU52WjF5NEZQa2k5em9uUjIydjVzaE5F?=
 =?utf-8?B?QjlrZ2lmV01rOW0wRnQ2Nzl5OFZoR3RIdy9CNU9mTFVpaUJUckRQbE1Yb3dz?=
 =?utf-8?B?bmZhUmE2c1JjbmFKb1RJT0thaFVPRktKeFFSU01ySmVVSnRHc3FLL040clFH?=
 =?utf-8?B?YTJPNVRrUjA5a1E1OXpIYWVYNHJrOGJrWFJKY3RxNE5iMHBMMlFPcGZEcFgw?=
 =?utf-8?Q?KxnIqvuEO6tVDHR3pqEXnO9Lp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1aaf96-dc0f-4ef4-ec30-08db86ae77fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 10:13:29.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZIILRMrVewCfwpgO2mzGLKMp4Qhm+3TRPzWZ/yf6jom+1zsd70g6s8w0vD8tFUC+SY014ZoHFGSE24zRLHuXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
X-Proofpoint-GUID: -Lh64ZyVGc9G40-rqAYq___VnRC35W7h
X-Proofpoint-ORIG-GUID: -Lh64ZyVGc9G40-rqAYq___VnRC35W7h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_07,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307170091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIEp1
bHkgMTcsIDIwMjMgNTo0MiBQTQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVyLmNv
bT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGty
enlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4g
ZGluZ3V5ZW5Aa2VybmVsLm9yZzsgaG1pbmFzQHN5bm9wc3lzLmNvbTsgbGludXgtdXNiQHZnZXIu
a2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBkd2MyOiBj
b21iaW5lIHBsYXRmb3JtIHNwZWNpZmljIGRhdGEgZm9yIEludGVsIEFnaWxleA0KPiBhbmQgU3Ry
YXRpeDEwDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIGNvbWVzIGZyb20gYSBub24gV2luZCBS
aXZlciBlbWFpbCBhY2NvdW50IQ0KPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUuDQo+IA0KPiBPbiAxNy8wNy8yMDIzIDEwOjUwLCBNZW5nIExpIHdyb3RlOg0K
PiA+IEludGVsIFN0cmF0aXgxMCBpcyB2ZXJ5IHRoZSBzYW1lIHdpdGggQWdpbGV4IHBsYXRmb3Jt
LCB0aGUgRFdDMiBJUCBvbg0KPiA+IHRoZSBTdHJhdGl4IHBsYXRmb3JtIGFsc28gZG9lcyBub3Qg
c3VwcG9ydCBjbG9jay1nYXRpbmcuIFNvLCBiYXNlZCBvbg0KPiA+IGNvbW1pdCAzZDhkMzUwNGQy
MzMoInVzYjogZHdjMjogQWRkIHBsYXRmb3JtIHNwZWNpZmljIGRhdGEgZm9yIEludGVsJ3MNCj4g
PiBBZ2lsZXgiKSwgY29tYmluZSBwbGF0Zm9ybSBzcGVjaWZpYyBkYXRhIGZvciBJbnRlbCBBZ2ls
ZXggYW5kDQo+ID4gU3RyYXRpeDEwIHRvZ2V0aGVyLiBJbiBhZGRpdGlvbmFsLCBpbiBvcmRlciB0
byBhdm9pZCBicmVha2luZyB0aGUgb2xkDQo+ID4gZGV2aWNlIHRyZWUsIGtlZXAgY29tcGF0aWJs
ZSBzdHJpbmcgImludGVsLHNvY2ZwZ2EtYWdpbGV4LWhzb3RnIiB1bmNoYW5nZWQuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBNZW5nIExpIDxNZW5nLkxpQHdpbmRyaXZlci5jb20+DQo+ID4gLS0t
DQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMi55YW1sICAg
fCAyICsrDQo+IA0KPiBCaW5kaW5ncyBhcmUgYWx3YXlzIHNlcGFyYXRlIHBhdGNoLg0KPiANCg0K
R290IGl0Lg0KDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvYWx0ZXJhL3NvY2ZwZ2Ffc3RyYXRp
eDEwLmR0c2kgfCA0ICsrLS0NCj4gDQo+IEFzIERUUyBpcy4NCj4gDQoNCkdvdCBpdC4NCg0KPiA+
ICBkcml2ZXJzL3VzYi9kd2MyL3BhcmFtcy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgNiAr
KysrLS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3VzYi9kd2MyLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2IvZHdjMi55YW1sDQo+ID4gaW5kZXggZGM0OTg4YzAwMDljLi5jOThjYTk4ZDUwMzMgMTAw
NjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2My
LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3
YzIueWFtbA0KPiA+IEBAIC01MSw2ICs1MSw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAg
ICAgICAgLSBhbWxvZ2ljLG1lc29uLWd4YmItdXNiDQo+ID4gICAgICAgICAgICAgICAgLSBhbWxv
Z2ljLG1lc29uLWcxMmEtdXNiDQo+ID4gICAgICAgICAgICAgICAgLSBpbnRlbCxzb2NmcGdhLWFn
aWxleC1oc290Zw0KPiA+ICsgICAgICAgICAgICAgIC0gaW50ZWwsc29jZnBnYS1oc290Zw0KPiAN
Cj4gV2hlcmUgaXMgU29DIHNwZWNpZmljIGNvbXBhdGlibGU/DQo+IA0KDQpUaGUgc29jZnBnYSBp
cyBhIFNvQyBmYW1pbHksIGl0IGluY2x1ZGVzIEFnaWxleCBhZCBTdHJhdGl4MTAgU29Dcy4NCklu
IGZhY3QsIHdlIG9ubHkgbmVlZCB0aGUgY29tcGF0aWJsZSAiIGludGVsLHNvY2ZwZ2EtaHNvdGcg
IiBpcyBlbm91Z2guDQpCdXQgaW4gb3JkZXIgdG8gYXZvaWQgYnJlYWtpbmcgdGhlIG9sZCBkZXZp
Y2UgdHJlZSBmb3IgYWdpbGV4IHBsYXRmb3JtLCBJIHJlc2VydmUgdGhlIG9sZCBjb21wYXRpYmxl
Lg0KU28sIEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0aGUgU3RyYXRpeDEwIGNvbXBhdGlibGUgbGlr
ZSAiaW50ZWwsc29jZnBnYS1zdHJhdGl4MTAtaHNvdGcgIg0KDQo+ID4gICAgICAgICAgICAtIGNv
bnN0OiBzbnBzLGR3YzINCj4gPiAgICAgICAgLSBjb25zdDogYW1jYyxkd2Mtb3RnDQo+ID4gICAg
ICAgIC0gY29uc3Q6IGFwbSxhcG04MjE4MS1kd2Mtb3RnDQo+ID4gQEAgLTY0LDYgKzY1LDcgQEAg
cHJvcGVydGllczoNCj4gPiAgICAgICAgICAgIC0gY29uc3Q6IHNucHMsZHdjMg0KPiA+ICAgICAg
ICAtIGNvbnN0OiBzYW1zdW5nLHMzYzY0MDAtaHNvdGcNCj4gPiAgICAgICAgLSBjb25zdDogaW50
ZWwsc29jZnBnYS1hZ2lsZXgtaHNvdGcNCj4gPiArICAgICAgLSBjb25zdDogaW50ZWwsc29jZnBn
YS1oc290Zw0KPiA+DQo+ID4gICAgcmVnOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9hbHRlcmEvc29jZnBnYV9zdHJhdGl4MTAuZHRz
aQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9hbHRlcmEvc29jZnBnYV9zdHJhdGl4MTAuZHRz
aQ0KPiA+IGluZGV4IGVhNzg4YTkyMGVhYi4uYzVhNTE2MzZmNjU3IDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvYWx0ZXJhL3NvY2ZwZ2Ffc3RyYXRpeDEwLmR0c2kNCj4gPiAr
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2FsdGVyYS9zb2NmcGdhX3N0cmF0aXgxMC5kdHNpDQo+
IA0KPiAuLi4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMg
Yi9kcml2ZXJzL3VzYi9kd2MyL3BhcmFtcy5jDQo+ID4gaW5kZXggOGVhYjVmMzhiMTEwLi42YmIy
N2EyNGU5ZTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9wYXJhbXMuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMNCj4gPiBAQCAtOTMsNyArOTMsNyBAQCBz
dGF0aWMgdm9pZCBkd2MyX3NldF9zM2M2NDAwX3BhcmFtcyhzdHJ1Y3QNCj4gZHdjMl9oc290ZyAq
aHNvdGcpDQo+ID4gICAgICAgcC0+cGh5X3V0bWlfd2lkdGggPSA4Ow0KPiA+ICB9DQo+ID4NCj4g
PiAtc3RhdGljIHZvaWQgZHdjMl9zZXRfc29jZnBnYV9hZ2lsZXhfcGFyYW1zKHN0cnVjdCBkd2My
X2hzb3RnICpoc290ZykNCj4gPiArc3RhdGljIHZvaWQgZHdjMl9zZXRfc29jZnBnYV9wYXJhbXMo
c3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiANCj4gV2h5PyBPbGQgbmFtZSB3YXMgb2suLi4N
Cj4gDQoNCk9sZCBuYW1lIGluY2x1ZGVzIHN0cmluZyAiYWdpbGV4IiB0aGF0IHJlcHJlc2VudHMg
b25seSBhZ2lsZXggU29DLg0KVGhpcyBwYXRjaCBpcyB1c2VkIHRvIGNvbWJpbmUgcGxhdGZvcm0g
c3BlY2lmaWMgZGF0YSBmb3IgSW50ZWwgQWdpbGV4IGFuZCBTdHJhdGl4MTAsIHNvIGNyZWF0ZSBh
IGNvbW1vbiBmdW5jdGlvbiBuYW1lIGZvciBzb2NmcGdhIGZhbWlseS4NCg0KPiA+ICB7DQo+ID4g
ICAgICAgc3RydWN0IGR3YzJfY29yZV9wYXJhbXMgKnAgPSAmaHNvdGctPnBhcmFtczsNCj4gPg0K
PiA+IEBAIC0yNjYsNyArMjY2LDkgQEAgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBkd2MyX29m
X21hdGNoX3RhYmxlW10gPSB7DQo+ID4gICAgICAgeyAuY29tcGF0aWJsZSA9ICJzdCxzdG0zMm1w
MTUtaHNvdGciLA0KPiA+ICAgICAgICAgLmRhdGEgPSBkd2MyX3NldF9zdG0zMm1wMTVfaHNvdGdf
cGFyYW1zIH0sDQo+ID4gICAgICAgeyAuY29tcGF0aWJsZSA9ICJpbnRlbCxzb2NmcGdhLWFnaWxl
eC1oc290ZyIsDQo+ID4gLSAgICAgICAuZGF0YSA9IGR3YzJfc2V0X3NvY2ZwZ2FfYWdpbGV4X3Bh
cmFtcyB9LA0KPiA+ICsgICAgICAgLmRhdGEgPSBkd2MyX3NldF9zb2NmcGdhX3BhcmFtcyB9LA0K
PiA+ICsgICAgIHsgLmNvbXBhdGlibGUgPSAiaW50ZWwsc29jZnBnYS1oc290ZyIsDQo+ID4gKyAg
ICAgICAuZGF0YSA9IGR3YzJfc2V0X3NvY2ZwZ2FfcGFyYW1zIH0sDQo+IA0KPiBBcmVuJ3QgdGhl
eSBjb21wYXRpYmxlPyBXaHkgZG8geW91IG5lZWQgbmV3IGVudHJ5IGZvciBjb21wYXRpYmxlIGRl
dmljZXM/DQo+IA0KDQpJbiBmYWN0LCB0aGUgdXNiIElQIGluIEFnaWxleCBhbmQgU3JhdGl4MTAg
YXJlIHRoZSBzYW1lLiBCdXQgaXQgaXMgbm90IHJlYXNvbmFibGUgdG8gdXNlIGFnaWxleCBjb21w
YXRpYmxlIHN0cmluZyAiaW50ZWwsc29jZnBnYS1hZ2lsZXgtaHNvdGciIGluIFN0cmF0aXgxMCBk
dHMgZmlsZXMuDQpTbywgSSBjcmVhdGUgYSBjb21tb24gZnVuY3Rpb24gbmFtZSBhbmQgY29tcGF0
aWJsZSBzdHJpbmcgZm9yIHNvY2ZwZ2EgZmFtaWx5IHRoYXQgaW5jbHVkZXMgQWdpbGV4IGFuZCBT
dHJhdGl4MTAgU29Dcy4NCg0KVGhhbmtzLA0KTGltZW5nDQoNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KDQo=
