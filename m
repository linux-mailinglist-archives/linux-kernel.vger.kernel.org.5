Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B5D7F3D49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjKVF2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjKVF2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:28:31 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0BA12A;
        Tue, 21 Nov 2023 21:28:27 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AM584EU010474;
        Tue, 21 Nov 2023 21:27:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=dV6fi4hP6EPv6FmkhVqw5Og+6bRZD2VBE22nmE6XYo0=; b=
        VndMGczQG/6r4x7afYqg/vlavAIsESE/5UA2t8FBsl9JO780GRu6DwJee9FeQoXP
        Bzc3ph5iTsTUY5+nB+xlCnUi3dcKFUgpXIcOaLpLxiu3u9sgEHEy7Ht+xXfcqqG0
        ryPABCWuFnNrOEMKqZjZHyrxFGqnYF/3d5qD8xBMz6Z+sTMp5FutoHBwmAM64G5J
        w33d2388cV4KccfLyuPKEYu5BW913IDP6FOW983YJtj6eAbwwYfelcCiBNo96tYZ
        xmnE5r+hQVICHZVwryeWcwl9xbGzUpjHyGC+5DMlje3RtJc3lS8ynsR980g2qkve
        yD7jUJTfwBsawKg5SYI/KQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uese431en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 21:27:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utx53FPcGgJ/Y2KrHa7SVaM0Aduvd276bR1pdSleXUTcfP8w0q7Cn3CA5w7xiNpYmoK7yIBEBcHz6PAi1io3AXzWVuo3Lzx6a0UVYYPbG8oA55aMJJocwu/7PRNovFbblxvVfwnYUlLq5N0HK/6jt9hxqUh92vFpTWu3Twu+huDbz96LyxYq8mygWf7ovrraUBk4HzYLPGhdaOfxvvhVcYEj7FoRhRjTepbd/CBzH+/t+o/e7GEUHmlRXbFdeila1O0eeWUqXN2SIIXR8HIHYiL41pj/X8u3ZjbG4A/csEZp57hnBm5qR+XCc2N2p7PVo/u/TlN9qAkmdPH35pH+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV6fi4hP6EPv6FmkhVqw5Og+6bRZD2VBE22nmE6XYo0=;
 b=hBE6e0HdE4UmZrTet7cnvCU0kWo+yfvqpZuwOG9uLsliUTT1AfAQ3V9BEeaAU+MKEK5aoGH/WC5fcyywOddq4/ZC6O1HSo5nOzk2yrPdXBiHGz2iA9jhIzwojcAA2fNn5plFaJnxWbrjCeSW3S8sl2+DsqkpwmrOLQPh2+PLa28kEw/0ywNULaxe/QSjBLL5KRmenOiiZ5523B2776sMwMkZAPIosqzPP/0x6uyKCQurrdS/GICwgqaxT7qKuRzDIwXuL/3+LH4zo/38XC9XzjtaBEmCLNVG7AlSpoocX08XACShDbOwHGTjMV9PX8VQlJ9hDr4KPlpluco3Eps+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5185.namprd11.prod.outlook.com (2603:10b6:303:6e::11)
 by SN7PR11MB7068.namprd11.prod.outlook.com (2603:10b6:806:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Wed, 22 Nov
 2023 05:27:54 +0000
Received: from CO1PR11MB5185.namprd11.prod.outlook.com
 ([fe80::131a:3b1:ff6f:b730]) by CO1PR11MB5185.namprd11.prod.outlook.com
 ([fe80::131a:3b1:ff6f:b730%7]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 05:27:54 +0000
From:   "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "sxwjean@me.com" <sxwjean@me.com>
CC:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] mm/slab: remove slab_nomrege and slab_merge
Thread-Topic: [PATCH 2/4] mm/slab: remove slab_nomrege and slab_merge
Thread-Index: AQHaG5HCMo5ZsMJEskum90YihxVPJrCEdqqAgAFaJ6A=
Date:   Wed, 22 Nov 2023 05:27:54 +0000
Message-ID: <CO1PR11MB5185A5481010CF8B541EA7A7ECBAA@CO1PR11MB5185.namprd11.prod.outlook.com>
References: <20231120091214.150502-1-sxwjean@me.com>
 <20231120091214.150502-3-sxwjean@me.com>
 <CAB=+i9TxzvHpDjZHhRfX-Cox_GuYg6-uGaG3eBhZh5vCJwpgmw@mail.gmail.com>
In-Reply-To: <CAB=+i9TxzvHpDjZHhRfX-Cox_GuYg6-uGaG3eBhZh5vCJwpgmw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5185:EE_|SN7PR11MB7068:EE_
x-ms-office365-filtering-correlation-id: 3881bf05-4bc8-498f-18e6-08dbeb1bc750
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bok2asKJlqOmY9QumVn+6eTqpIt5rQV0R/UF10w71VGMvvN6qIfXhk2Wgpjy6X3gzr6Hf3uSrxOdEy9UCm0gVNYZAr2mdyDevRbyq+0Evq6uH55ZrcKsvCW2YJLh1ZwsLisOAXUwDUz1L7W4skkAAPi0agnh9FKoqg3TnZwIKXjNFfsAuXP1dj1thhDOo7WMFG9DbWLx8Ju0/QrdLnHVGmW9O8rCQHQBOW1xobg5t81VJA0FzeFEzcsVqUaeaOEOxlYMhmoSLJ2pbOMnJf9uVeUuSIVoQMtl29q+cKU8zi/o/o9GrDZ7XR4rL5YlwwWuinSaEjr2Q2oZT73D7x9zdp8k99pfCC+p6NhUiAgjOXLF4cNbY3GYRo7Z2EhvcfyEvZhxKhPuIykvF6nIywCUXBR0fO6VrOxde5iw5gQEgbnMUYHA0R4R6S9ZOSs1u8Eweh6WYeAZL+LBFOwadKl23sZXFE1lHexoQG2qIzZSNyOdq8CGllXougQ17527pw7yQVmfEiCSaUvuA3mKm3ZqHxx+1nQSqnD9ZXD+NPmSHeatbV/6xcbvy8ITmnduPYCvxqFvt/Gqg0rMyVr444M01Qx3vVz/Whewjcqgn8+WAHngRp0EtwAvPhEUHlFQhqP3L1zaOHsL9fFBam8/vKBbWkVqnFZCZeFP2CmDyx3ch1A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(346002)(396003)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(38070700009)(55016003)(7416002)(122000001)(38100700002)(53546011)(86362001)(33656002)(2906002)(9686003)(6506007)(83380400001)(26005)(66946007)(76116006)(71200400001)(7696005)(5660300002)(66476007)(54906003)(316002)(110136005)(66556008)(64756008)(4326008)(41300700001)(478600001)(8676002)(52536014)(66446008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzJrbVJvcFdlODlaQkVMaHdwekZ2Z3QrRytPcGpkZC81eXpTYnU1N3JMZWc4?=
 =?utf-8?B?TExtMUxTMjgrbWZjYjNaaFd5OGhXM1ExTFVOUVpsMFJOdG9wZ3lCaUM1My9G?=
 =?utf-8?B?S1hTUElGbG4ra0JKTGtyK2F5aC9laGFxdnlzeTZlemZjRXkwcWg3LzNpZHB1?=
 =?utf-8?B?WFc2K2xlckhIWGdDdDE1WHQwQk1YVFpXeUVCSGJDTHFKbkpuU1B3eXRGV2Rq?=
 =?utf-8?B?dXNudTZ3ZnVLQ1pOdmhndzY0QVlLZkVjT1NoWG9VNUFQWE1zMWhIVXMzSXhz?=
 =?utf-8?B?cGVNZjdqdjJjUlhXaWtldDNQSUpkb1Q0dHBSekkzYjJzL3h4U29jR25XSFRO?=
 =?utf-8?B?UlByaUxCRjA3RUd3YmM0bzRTTE9iS1pPR0hxc2cxRkV1cEhQZzF4a0NiditF?=
 =?utf-8?B?UnNobGo5TEQ0WkdsOWpJVmMwNnlSWmlKdzFaYTZoSEZkZnJXNWg4RTZidjBP?=
 =?utf-8?B?cnVsMGhRKzdGK01FWFMwSDJPVCtFbTRBdkV0NG1taG5hWTRKSWpualVjU3ds?=
 =?utf-8?B?ZXdvKy9ud1VQbWJ2dktNMWNvdS9CMGFSR0xDZFlUU2NvaFc3MngxczlNODYz?=
 =?utf-8?B?bi9PN2NVQzZRWDNhN0lxdEg0R2VyVUlSVm1iNVB0YzJjd2RXN1NRdkdyRXU1?=
 =?utf-8?B?ZFZqOVV0U3VqcTMrQWlHKzF0d2xyL2lld084dUorUzllNmhWMnJGRjlyb1FL?=
 =?utf-8?B?cVdGNmRyaWxhaWFEcldENlhrT3h6cjk2aDZqZU44dG1HUWViNElqYUluVzh1?=
 =?utf-8?B?bVVXaGw2eDlTVnhOdXl3ZDJERFoxR3JZa3pFUXo3RGtOUDN4ZW9tOTMydHRK?=
 =?utf-8?B?ZDQ1TmYxNitsTmNycFNFMUZ3ZmdYM3Nmc0lkT3pXOHZOZC9UNk9aK1YxYUx2?=
 =?utf-8?B?Qm1tbnFSODFkQllnWWZTQ0ZjY2gyYlF2QXZXemRUQjloL2lMZ1pHdUpqcmdy?=
 =?utf-8?B?NkN0SmcyeDZIcGE1cjloeGZLblZVQXpiVmc5N1ljU1ROaWgrNXhWNFA1U3A3?=
 =?utf-8?B?cGdGYnVicHVmN0VlWXNPSG82QzlpNjFQWXpUenVsUzQzbXFxd3B2dmdRcExx?=
 =?utf-8?B?UGlnS3V2TnZzbXk2amxPTnN4M2p4LzlDNFV1anRQdnU1UGtSZ09VRVQ1bXU5?=
 =?utf-8?B?Sy9tVlZmcm12algzbWU5Yy96cGVNT2U1bUFvdHlOWWVoaks0QzI4T3Z2MmU3?=
 =?utf-8?B?bjVab0RTci8wanJiWmhScG1jd1BUN2dObGhzclFqYktkQTJwcjlidUt4RzJh?=
 =?utf-8?B?WGVDUHVFN0tqeko3Ty9BY1VVM2xvR0FiNlYxUEE0RjlQMXhzeklFakUzK2U3?=
 =?utf-8?B?b0ZuSDI4Q2pveElsL1cyWm9DaUpvNDNRRFVyTnhTVW1PWXM4T0dkRGNOTExp?=
 =?utf-8?B?Rjc2citmL3JtUFF3cmw1ZmkzNXRSVVQxNmZDanBveHltcDdxQWxKbXg2MzJi?=
 =?utf-8?B?WHd4cXNaU0lKN1NIMlhjaFZiOXZDTTg5T0RKOVV1SkZYQ2hKd0pFUW5VQmVq?=
 =?utf-8?B?Z2RHM0pzNWlSa2J6NmpYMlRVTHJVdXRRbWY1Smh0RzlLenZLcTdxT3BUbFc1?=
 =?utf-8?B?NkxZRm1iTHZZeU4vUWw4M2RiR053ZEtENDBSdXN5ZlIxNUFKYWlUdTBaeU5y?=
 =?utf-8?B?dWRCRXJsRlJyZFIvK2ROeXR5NVB4YzRralpQNlhJS2poNjBpRHljLytHNmhZ?=
 =?utf-8?B?SEFXMzVkMzdRYXR0N1dpSU5GNG80cW9kUHJVSUkwM3NGUStkWWZ4VGJ4Tkhx?=
 =?utf-8?B?WEFkTW0xYXBvSkU1dTRhRU9sSHJBRXJXT0lQNE9BWGVGZ2NFS0wwbEVkeTlQ?=
 =?utf-8?B?dUhyQWluZld6RU9wUWJpQUU3ZFhUTXh4eHd1Ulp6NG90OTN5MVZJNzJibzEr?=
 =?utf-8?B?RjRjUWw2WVlCa2N5dzNlN0lDTllhOGx6M1JxRm1TNHkwL2dnV2oxcThoejdN?=
 =?utf-8?B?T3RaUzFSRVFGVmpSV2ZkcDNWZXN2YUlDTFBhZ0s4SVJ6MzZ2NDZsMWZvR3dI?=
 =?utf-8?B?TzZZQmVPeFUwOEIrNUlkYnZ2cjdlRnZzQ25yTGgyQWNCbEluUXNubFNrbWpr?=
 =?utf-8?B?ZDhtZkYzYVRLK2dlSjA1eFRoSE9sQVB0MWJFbkJsTUg4NmNLWlJIczRnN2d5?=
 =?utf-8?B?QzZscDMrU2JYTlZRdjhvZnpjYS8vRDZzZHBPMTRjemxaWTF2eWpuTVg1U1kw?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3881bf05-4bc8-498f-18e6-08dbeb1bc750
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 05:27:54.3173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kILSLXiIOYA5PD5diH3aDkW/nXohZBoWVRb3O+KpBuKjB0den0ZOAZ2Vsp+IC6qU8SnWKBxKZx113+ACN95wR8LDFM5+wz+Pk8Vs9wdHN8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7068
X-Proofpoint-GUID: nYj7C_NL_YQ0hrZtWOIb2KRWDgWp0r3g
X-Proofpoint-ORIG-GUID: nYj7C_NL_YQ0hrZtWOIb2KRWDgWp0r3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311220039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSHllb25nZ29uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IG93
bmVyLWxpbnV4LW1tQGt2YWNrLm9yZyA8b3duZXItbGludXgtbW1Aa3ZhY2sub3JnPiBPbiBCZWhh
bGYgT2YgSHllb25nZ29uDQo+IFlvbw0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyMSwgMjAy
MyA0OjQ0IFBNDQo+IFRvOiBzeHdqZWFuQG1lLmNvbQ0KPiBDYzogY2xAbGludXguY29tOyBwZW5i
ZXJnQGtlcm5lbC5vcmc7IHJpZW50amVzQGdvb2dsZS5jb207IGlhbWpvb25zb28ua2ltQGxnZS5j
b207DQo+IHZiYWJrYUBzdXNlLmN6OyByb21hbi5ndXNoY2hpbkBsaW51eC5kZXY7IGNvcmJldEBs
d24ubmV0OyBsaW51eC1tbUBrdmFjay5vcmc7IGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi80
XSBtbS9zbGFiOiByZW1vdmUgc2xhYl9ub21yZWdlIGFuZCBzbGFiX21lcmdlDQo+IA0KPiBDQVVU
SU9OOiBUaGlzIGVtYWlsIGNvbWVzIGZyb20gYSBub24gV2luZCBSaXZlciBlbWFpbCBhY2NvdW50
IQ0KPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJl
Y29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUuDQo+IA0K
PiBPbiBNb24sIE5vdiAyMCwgMjAyMyBhdCA2OjEy4oCvUE0gPHN4d2plYW5AbWUuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEZyb206IFhpb25nd2VpIFNvbmcgPHhpb25nd2VpLnNvbmdAd2luZHJpdmVy
LmNvbT4NCj4gPg0KPiA+IFNpbmNlIHNsYWIgYWxsb2NhdG9lciBoYXMgYWxyZWFkeSBiZWVuIHJl
bW92ZWQsIHNvIHdlIHNob3VsZCBhbHNvIHJlbW92ZQ0KPiA+IHRoZSByZWxhdGVkIHBhcmFtZXRl
cnMuIEFuZCBjaGFuZ2UgdGhlIGdsb2JhbCBmbGFnIGZyb20gc2xhYl9ub21lcmdlDQo+ID4gdG8g
c2x1Yl9ub21lcmdlLg0KPiANCj4gTm8sIGtlcm5lbCBwYXJhbWV0ZXJzIHNob3VsZCBiZSBjaGFu
Z2VkIG9ubHkgaW4gYSBiYWNrd2FyZC1jb21wYXRpYmxlDQo+IHdheSAoaWYgcG9zc2libGUpDQo+
IA0KPiBCZWZvcmUgc2xhYiBtZXJnaW5nIHdhcyBzdXBwb3J0ZWQgaW4gU0xBQiwgb25seSBTTFVC
IHN1cHBvcnRlZCBpdC4NCj4gQWZ0ZXIgY29tbWl0IDQyM2M5MjljYmJlYyAoIm1tL3NsYWJfY29t
bW9uOiBjb21tb25pemUgc2xhYiBtZXJnZSBsb2dpYyIpLCB1c2luZw0KPiBzbGFiX1tub11tZXJn
ZSBwYXJhbWV0ZXJzIGZvciBDT05GSUdfU0xVQiBidWlsZHMgYmVjYW1lIGxlZ2FsLg0KPiANCj4g
SSB0aGluayB3aGF0IHRoZSBkb2N1bWVudGF0aW9uIHNheXMgaXMgInNsYWJfW25vXW1lcmdlIGVu
YWJsZXMgb3INCj4gZGlzYWJsZXMgc2xhYiBtZXJnaW5nDQo+IGFuZCBzbHViX1tub11tZXJnZSBy
ZW1haW4gc3VwcG9ydGVkIG9ubHkgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkiDQoNClllcy4g
QnV0IHNsYWIgYWxsb2NhdG9yIHdpbGwgbm90IGV4aXN0IGFueW1vcmUuIElzIHNsYWJfW25vXW1l
cmdlIHN0aWxsIHByb3Blcj8gDQpXaWxsIHRoZSB0ZXJtICJzbGFiL1NMQUIiIHN0aWxsIGJlIHVz
ZWQgaW4gdGhlIGZ1dHVyZT8gIA0KDQpSZWdhcmRzLA0KWGlvbmd3ZWkNCj4gDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBYaW9uZ3dlaSBTb25nIDx4aW9uZ3dlaS5zb25nQHdpbmRyaXZlci5jb20+
DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRl
cnMudHh0IHwgMTEgKystLS0tLS0tLS0NCj4gPiAgbW0vS2NvbmZpZyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiA+ICBtbS9zbGFiX2NvbW1vbi5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEzICsrKysrLS0tLS0tLS0NCj4gPiAgMyBmaWxl
cyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0
IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi0NCj4gZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+
ID4gaW5kZXggYzc3MDlhMTFmOGNlLi5hZmNhOWZmN2M5ZjAgMTAwNjQ0DQo+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiA+IEBAIC01
ODcwLDExICs1ODcwLDExIEBADQo+ID4NCj4gPiAgICAgICAgIHNscmFtPSAgICAgICAgICBbSFcs
TVREXQ0KPiA+DQo+ID4gLSAgICAgICBzbGFiX21lcmdlICAgICAgW01NXQ0KPiA+ICsgICAgICAg
c2x1Yl9tZXJnZSAgICAgIFtNTV0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBFbmFibGUg
bWVyZ2luZyBvZiBzbGFicyB3aXRoIHNpbWlsYXIgc2l6ZSB3aGVuIHRoZQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGtlcm5lbCBpcyBidWlsdCB3aXRob3V0IENPTkZJR19TTEFCX01FUkdF
X0RFRkFVTFQuDQo+ID4NCj4gPiAtICAgICAgIHNsYWJfbm9tZXJnZSAgICBbTU1dDQo+ID4gKyAg
ICAgICBzbHViX25vbWVyZ2UgICAgW01NXQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIERp
c2FibGUgbWVyZ2luZyBvZiBzbGFicyB3aXRoIHNpbWlsYXIgc2l6ZS4gTWF5IGJlDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgbmVjZXNzYXJ5IGlmIHRoZXJlIGlzIHNvbWUgcmVhc29uIHRv
IGRpc3Rpbmd1aXNoDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgYWxsb2NzIHRvIGRpZmZl
cmVudCBzbGFicywgZXNwZWNpYWxseSBpbiBoYXJkZW5lZA0KPiA+IEBAIC01OTE1LDEzICs1OTE1
LDYgQEANCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBsb3dlciB0aGFuIHNsdWJfbWF4X29y
ZGVyLg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIEZvciBtb3JlIGluZm9ybWF0aW9uIHNl
ZSBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0Lg0KPiA+DQo+ID4gLSAgICAgICBzbHViX21lcmdl
ICAgICAgW01NLCBTTFVCXQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIFNhbWUgd2l0aCBz
bGFiX21lcmdlLg0KPiA+IC0NCj4gPiAtICAgICAgIHNsdWJfbm9tZXJnZSAgICBbTU0sIFNMVUJd
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgU2FtZSB3aXRoIHNsYWJfbm9tZXJnZS4gVGhp
cyBpcyBzdXBwb3J0ZWQgZm9yIGxlZ2FjeS4NCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBT
ZWUgc2xhYl9ub21lcmdlIGZvciBtb3JlIGluZm9ybWF0aW9uLg0KPiA+IC0NCj4gPiAgICAgICAg
IHNtYXJ0Mj0gICAgICAgICBbSFddDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgRm9ybWF0
OiA8aW8xPlssPGlvMj5bLC4uLiw8aW84Pl1dDQoNCg==
