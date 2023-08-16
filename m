Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F74777D749
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbjHPA5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbjHPA4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:56:49 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493A2112;
        Tue, 15 Aug 2023 17:56:48 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FIYCf5025867;
        Wed, 16 Aug 2023 00:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=ZGP1j1EVkIG5dzOI6M4iAZPeNxdo3DSRJ37e7D5HaHM=;
 b=Fs/tKca/dEeUFhAhLUa/99wqdW8hZmmGnsnGPLiWBeUQgSSIKOZBJ8cxMOYKG5nvutOs
 XUdN78YjCDiZwz6OplOu1+ymiiVw9mhIPfY/q5rRRUZzSSs/XVDKl/alkXnJj3RFQ/+4
 tibKPHsAMsAslItwRf3v04v6xIfL6CojBlpD/R22VheHPe6pu4o0XFJ0geYbX4p1M7cp
 l+UpcVibWi5CRBZA/BUheo1Nl1f0ScQwMvD7eW2jyvBN5thApd6TzGC+oY7EgiCGnE8j
 wr4+c1+Di6nUD7oJw76269Lavqfxg2Lv8U9qPJEDfSnTLdP5hUMqwKuVxFmyFC8sQ4+V TQ== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sgerq2dcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 00:56:33 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 12484802B86;
        Wed, 16 Aug 2023 00:56:31 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 15 Aug 2023 12:56:01 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 15 Aug 2023 12:56:00 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 15 Aug 2023 12:56:00 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 16 Aug 2023 00:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReIH33/A23na3SVpxDysMbL57G1Vvl5kQVqNRxPOtL250StBxY2xquGjWiSSFmcKQ7NfbKWtALxDIGx7vfvWyxeJW/TRiJQPKpEVAXKLB7AsYCONxlsKB7v0nra2knvzdl3p9uBdlMI3F8ZBw/ULPmxXtKH2U5WZoBvabF9QW0qBBUcJNU/RAssMBZqUYi1Zs4kY83D7JpdMWtIMNhMvDpmZYaf296w8X7YPH/wwEUw32sGqDSOjOJPLT0huWwrVBqAdWDxGQDXLOFB0bAqw/umZ+TbbInSoOZ+W4wwGYu/svbTuFeW51LtfnPG+VxZpVp+yYLuIUC+1hD20BsjWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGP1j1EVkIG5dzOI6M4iAZPeNxdo3DSRJ37e7D5HaHM=;
 b=PUWbOECaZR8Lhh1kqz1Qh8IR8OAEbVwQZw/siGO4TjtGsfVFDh2LYjRS75mnmueoqSnWyxnNMetccPpQ+bc7iJht0BYEL55dcEzsVxggR9tzRGx+YBCUZ3hTZunDyysEad1NoTr0+bPh5LgE+QBlZaVtR4bZjQ0vP8jNp+pEs8r3thvDhaDXlPhoF+ghhsewhck0eprTitbP3QTjXpZ3bi2Bs5+N0xkU/TNNhAS+mKPYU2L6hN4sAQrmzGcsWM8bcjWkTW2EdRZcwIEVSaqeI2c7ianwFZP3BGxjJZtcaG4t2yD7Xk3wOpIpsCyqjhs+Y+ha4rkIYk3++ezI82FAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 SJ0PR84MB1674.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 00:55:57 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 00:55:57 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] net: hpe: Add GXP UMAC MDIO
Thread-Topic: [PATCH v2 2/5] net: hpe: Add GXP UMAC MDIO
Thread-Index: AQHZxX8E0XE9XXVGkk+QibmMDm2vZ6/XmYaAgBRAewA=
Date:   Wed, 16 Aug 2023 00:55:56 +0000
Message-ID: <75F51B6F-A477-4A2B-B40F-1CC894546CF2@hpe.com>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-3-nick.hawkins@hpe.com>
 <0b227994-2577-4a74-b604-79410f5607b8@lunn.ch>
In-Reply-To: <0b227994-2577-4a74-b604-79410f5607b8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.75.23071400
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|SJ0PR84MB1674:EE_
x-ms-office365-filtering-correlation-id: 894dc786-5568-4a5e-1b87-08db9df38cf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bDgmpkb/1XI+uzrYVYEEVqvfPFezAfXWjYWrX57zlrGtDxRA53LJsrot+uOPiB3CmsEWH/j4wWKfQIDHTk4dXYM+J2QcHBxO3/JzylyZL2HZCAozuGzcrzqgQGRHTmY8KPnBttOr/tCLdAnHMBTB3Zch/OCad+qGJeEiShbyZHXk8ME541llxWuOY+sNkEDjfeNL/zES3IRcpcFMJ1jH+LXeQeAnVHZ3DBPSvbLIG2QC9DWKwu1sO6kulfBuanrHlQ84Bm9CgmyOQeh21VFDIim6U5FOizSfJs3bw5K3E8EexwoKwqhGGbFvxHFIuVAlfpV/YmtxnCkn+dSJRjWUMlF+h8YN/nSs5ti+vuzTiaf0ciTjWanmmhiu4KXf1dadILa2AOO6G10ZanMWpMCE1GBGmkZevtoEr2x86+FMTtdGokmhUifn4SihGi3b5sq9XRG7L5XDh/Y1v6Ukchc9zmVtxv/bfrqZ4IUD74JiRC+BhhF1jvS6TiEr1mGzLqgNJcLZqHSSMCXrAEZfYIQ0Sgz6Sii4Q/JXggUx0/wJmwObhYLQGV38devkDnRTdeWCqDl3O94P4McLQ2/m2C+vkDJ0gM2f/9AWGSly1rNAaZUiXtiYPqUPSsT1zKdY3kuUhp7VwCZZbCKj9fqRt/m5EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(478600001)(86362001)(6486002)(71200400001)(82960400001)(2616005)(36756003)(76116006)(38070700005)(6506007)(66476007)(5660300002)(66556008)(66946007)(316002)(41300700001)(6916009)(122000001)(33656002)(38100700002)(91956017)(83380400001)(54906003)(64756008)(66446008)(4326008)(2906002)(7416002)(8936002)(8676002)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFRCMEREZUVpVEZoYUZIN2Q1cjg4YW1vZ3BjZDJWcXBMVGljU0lwNVpsYlQw?=
 =?utf-8?B?Y29WZWgyeVQ1RW5zK2dreFh3R2l5RWkrVHl3TFVvdDc0VldsamVoSUE2UzB5?=
 =?utf-8?B?UzViZTNvTGY5QThiRTkvKyswa3J1QURwSmYxOTFuNGxhd0dHaENndE5UelQ5?=
 =?utf-8?B?V0EyQk91ekVaN0U5ajRPdWNMZVI3cndTVThQZ0JleFV5Q2ozUE9Wa2lzei9M?=
 =?utf-8?B?TWpGYkt0cmlQYjE0L2w5aUd0NTllQzZJdzR4WjZoaU45TXR1a0dzbnk0bGZV?=
 =?utf-8?B?YlZGdnFPRzJQVjVQeUVpMFdobEFVenZMVWl4aEZIUmhBd3I4dXMxQ09NR3B1?=
 =?utf-8?B?MkE4VVhpZ2ltY0lUK1BTTEpuQkpmMnpmMjFzbWh1MnpteTVoTTMxSnlBMmds?=
 =?utf-8?B?NW5BKzVncjNPTXM2OWVTcmdaU08xYTBBY2NhWjZaRUtnYjFFdk5ZMkxrNFNH?=
 =?utf-8?B?bFA1S3hnWkFiTGRVcU5pdDEybk9JWFFnY1lRUEQ0TlJzVnIyNzUvdEZ1ZUVM?=
 =?utf-8?B?U0hWWkxVdGRRV1pOUjVjR3ZUZjRHdCtnT25uRzE5RjVCMjV3SVVqZm9paG9y?=
 =?utf-8?B?Z01IcDU3YXdOQ2hQd3JKT3U4UVlMZkhQMmlTdmVzVC9MdUVLRFdYWkxkNVVz?=
 =?utf-8?B?K0dQdllMVUtaaEM5V0w5ZnBUNWFyUFozcHJEL1M1bXMzUUhCaFZ6b2U0UEVP?=
 =?utf-8?B?MElqWVV2dm11Y2grTmFKRmNwaU5ZV0JnMnYvdUUvWTM1MHQwbXl1SGFkKytm?=
 =?utf-8?B?WGhSdHh2VHEyTG8xeG55d1VaNlNHSi9oY2tWVEVoR0hTWmp4RSt0MCthbjd1?=
 =?utf-8?B?ZVl0eG9Wa0xkdjhMajVjbkZFVk1PQVVvbTM0YzlDTnZwYWZhWk5wbTdNYTVk?=
 =?utf-8?B?L0M0MTRyOXVUNUZqcEtJY09HWDB5dEk2djMyL2dnelhvcy9ZbmgwM3c4akxW?=
 =?utf-8?B?LzZTbWE4cmNFWmo0KzZBKzcwZDhESjZ5cVE3SDNEdWs3Q281SzdCcFBQbGlY?=
 =?utf-8?B?cUtweEVuTXhNbnc3TTFEeGlYZ3J2T2wwcUxkK3BKdFlMajlZQ3AwVUovL0Jh?=
 =?utf-8?B?N1FEbDRDSjIwdGdlZ1FVc2JsbVZZWmZOMFJ2ekp4OFJ0eFBkbXZROGZGdXU5?=
 =?utf-8?B?ZHpEZkt6Y3FQdHpicUhPZjdhZXI4bVdUenE4N0FBVFpRdDFzckd5Yy80SWcr?=
 =?utf-8?B?TEZOUXEwSEszaS9QZEIzZUhBcXdEQUZLNmh3MUdhdnVPSVphMnpibzFDZjFN?=
 =?utf-8?B?Um9ZSlR2TmFFZ3QwVHpUbnBsMG9NU0hzdEJ4dzQ2emp2cCtGdFhVRDJjTU8x?=
 =?utf-8?B?YlNoOGJrcnpGN3IrR1JKN1VlZjFBdzdsVHNsYmZ5V09xY3lYT1JxR1FCay9j?=
 =?utf-8?B?SEl0R0ZwSktiMUdhM3AzNHd1Szc3aXZWSGgxd2Rnc09hM1h4UHNMeFVIcjVp?=
 =?utf-8?B?TU5DTjVUdlJPblVNZHg1dzUrNU8xSFlYc0E5aFVFWFFiclRNZ0U1NUQvV3VD?=
 =?utf-8?B?UUgxWDgxTWxNT1ZPYUcyWTdzUVljRWhreDF6NFV2Z3FmeStRVUV3L1RYNDRw?=
 =?utf-8?B?eGVsWUtXQmxpS2dqNlJqRTIxODRYNnpUM2tlK0hQd0Z3VTVqOW1uRDlHMXda?=
 =?utf-8?B?UEVSOUQ5UVNZZXBIT3FFMWt3b25oMk1GajNNaU1tek51M3JrNFRTZWJVQWUx?=
 =?utf-8?B?R3lYaWtsbWVWMlJCUmFyYnk1Nkh1cVZGcExCSlM2TVBFcFFuajVtVnVXemVT?=
 =?utf-8?B?WW54R1QvN3VHK0RsMExFNUV6NTg3RVlGdTJhUXAwdTdKNExZOThSQVcrdmth?=
 =?utf-8?B?aUZlVDlhajQ0aHc5SXp3WkhNazRzN3NIQStxL3JWaThERnVURHZYeVhQUlVs?=
 =?utf-8?B?RUFSSGdvUEErSStEWlhGa1I4K05ZRjhJV0JyWGM3ZmRNTVRBTVhITW95aVAx?=
 =?utf-8?B?cDYwaTRaeDBpR0laT25JcVNDQVhnbG42bnlVeUdQOHRDbGIzMExhVzhPRHB2?=
 =?utf-8?B?cUhDZStuVHpieXBoN0NITzVlQ0hXcGkzTnEyNG9ab25pV2lkc1NTcVFMdTFJ?=
 =?utf-8?B?ajRsNGxJQm1HcElicDBXM212dnc1ZEdlK1l4VjZaeG9td1Z2SnlYQUxvMXdQ?=
 =?utf-8?B?aWZNQnlOVktYcFVPTUxxeEtLLzMrSDVBK0I1SGlvZG0zdm1nbE1pNGNxbktW?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CE7EEFA05BFE54E987B932F2F147798@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 894dc786-5568-4a5e-1b87-08db9df38cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 00:55:57.0165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhX1bmOvojT6LC5u0RvrSiVq1Q1L232cc4IVmFubvbVtrZSDpqksQSRe+5BRYbkMz1TW18LE+WvBjnL6Lp4L7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1674
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: I-vyDomMacB4eCQ5e1jbY_NWbW-o6ib9
X-Proofpoint-ORIG-GUID: I-vyDomMacB4eCQ5e1jbY_NWbW-o6ib9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_22,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=856
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160007
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R3JlZXRpbmdzIEFuZHJldywNCg0KSSBoYXZlIGEgZm9sbG93IHVwIHF1ZXN0aW9uIGJlbG93Og0K
DQo+PiArc3RhdGljIGludCB1bWFjX21kaW9fcmVhZChzdHJ1Y3QgbWlpX2J1cyAqYnVzLCBpbnQg
cGh5X2lkLCBpbnQgcmVnKQ0KPj4gK3sNCj4+ICsgc3RydWN0IHVtYWNfbWRpb19wcml2ICp1bWFj
X21kaW8gPSBidXMtPnByaXY7DQo+PiArIHVuc2lnbmVkIGludCBzdGF0dXM7DQo+PiArIHVuc2ln
bmVkIGludCB2YWx1ZTsNCj4+ICsgaW50IHJldDsNCj4+ICsNCj4+ICsgc3RhdHVzID0gX19yYXdf
cmVhZGwodW1hY19tZGlvLT5iYXNlICsgVU1BQ19NSUkpOw0KPj4gKw0KPj4gKyBzdGF0dXMgJj0g
fihVTUFDX01JSV9QSFlfQUREUl9NQVNLIHwgVU1BQ19NSUlfUkVHX0FERFJfTUFTSyk7DQo+PiAr
IHN0YXR1cyB8PSAoKHBoeV9pZCA8PCBVTUFDX01JSV9QSFlfQUREUl9TSElGVCkgJg0KPj4gKyBV
TUFDX01JSV9QSFlfQUREUl9NQVNLKTsNCj4+ICsgc3RhdHVzIHw9IChyZWcgJiBVTUFDX01JSV9S
RUdfQUREUl9NQVNLKTsNCj4+ICsgc3RhdHVzIHw9IFVNQUNfTUlJX01STlc7IC8qIHNldCBiaXQg
Zm9yIHJlYWQgbW9kZSAqLw0KPj4gKyBfX3Jhd193cml0ZWwoc3RhdHVzLCB1bWFjX21kaW8tPmJh
c2UgKyBVTUFDX01JSSk7DQo+PiArDQo+PiArIHN0YXR1cyB8PSBVTUFDX01JSV9NT1dORVI7IC8q
IHNldCBiaXQgdG8gYWN0aXZhdGUgbWlpIHRyYW5zZmVyICovDQo+PiArIF9fcmF3X3dyaXRlbChz
dGF0dXMsIHVtYWNfbWRpby0+YmFzZSArIFVNQUNfTUlJKTsNCg0KDQo+IEkgYXNzdW1lIFVNQUNf
TUlJX01PV05FUiBtdXN0IGJlIHNldCBpbiBhIHNlcGFyYXRlIG9wZXJhdGlvbj8gQnV0DQo+IHVz
aW5nIF9fcmF3X3dyaXRlbCgpIGknbSBub3Qgc3VyZSB0aGVyZSBpcyBhbnkgYmFycmllciBiZXR3
ZWVuIHRoZSB0d28NCj4gd3JpdGVzLg0KDQpJcyB0aGVyZSBhIGZ1bmN0aW9uIHlvdSB3b3VsZCBy
ZWNvbW1lbmQgdXNpbmcgaW5zdGVhZD8NCg0KVGhhbmsgeW91IGZvciB0aGUgYXNzaXN0YW5jZSwN
Cg0KLU5pY2sgSGF3a2lucw0KDQoNCg0K
