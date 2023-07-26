Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECB5763971
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGZOoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjGZOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:44:20 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02F7CE;
        Wed, 26 Jul 2023 07:44:19 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QAW8TD024827;
        Wed, 26 Jul 2023 14:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=suPOqw+37+WEw3jnRxUaVs5ElNKbFNi1/Qj3+De2VB0=;
 b=PghLP8pt+5Q8w0Fifs33EAIzAGAhmI9ddzJkUlPQbvzPddBf3eDlXYPNpYA/mem404Zx
 OVcyzT1SqaKq6RzRGhzaQRk1iIoYe+/o1MzTLyk3ZGJZAwBGKbvhQ/OCg19wUuVTE68V
 DCuz+CQwnZcpzGChCBWHOgSGd1qGYdTCb9Hu7KaH8vnKSkNtg2ZhfuPsndS1ApD2SigX
 dfpmTIsp9FIxWAVBlh+0aNOEbncoge2bmjZkhQiUvabnv+7KMXtt+4K5UZECX9o8PaFF
 iqDmL/9M8nlFnVbqGLMSI8tHI9YXVNatR/FQtx8GHg+S3kzUglzepr/5Kt+/0BgEFOXm Aw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s2wbtcm4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 14:44:03 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 87CE6801601;
        Wed, 26 Jul 2023 14:44:02 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 26 Jul 2023 02:43:51 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 26 Jul 2023 02:43:50 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 26 Jul 2023 02:43:50 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 26 Jul 2023 02:43:49 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ6fSAgqB5evE1Tdz8FA4dS7w6smf4ofJv2Vxbvo3Z6Q9jpRzc0N83FmzzxHCQ6r6lXqwghJ5+kiAs+lWT3hNTiKw+B1YoJmL2+ejarlFY1/np38b9evAQvpUCgTt6+TCSa0vVLiH0L57klRxwTva2lM6Y1mrztKDRupufr4Wq7xmilLuHjct+DKIxjUW7xE+pM7dkb2w2yuMUbeZW4+MbtyejbUFZaTwyW2cAlBU4T9Ox8mnzJqXujBDaywWk/YZbIXMpzmrlxt8L6R7YM2OiQW5hgWy8HWt6cJ17zp8FhZOtFsnYbw5LE/MKzfYQJqsy9seSAd40szYmrn8vFNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suPOqw+37+WEw3jnRxUaVs5ElNKbFNi1/Qj3+De2VB0=;
 b=mxB6eu+kdHtvibzCChmx/XMHIC2LuSlBpJT5WWMwj4hLFed4S9VpCYMOpAr5X6JIjrwdB1c37b9S65BVx484i5zQ9eOiS/lQ5noRG99fVwwjJmoisf1NjXjtxMk0b3SfB6ozr9tnzjB+tXA2tnHwEnq1sa1ah+LAZUHVN+fcnDKuGHoTgIXeIcuJbI7PfQOET56CwxhY5tuwqDirnXcZ/b+dRKKu+dd36pq9hvUjjWVuohbojSQi9M9bpaGMaHcVaCuItiAANG9SAkVpA5UkUlsch68yx5IA972RC0Wh9tNqnUSkFhrvxYXV45bmMzuJM+tAXHfZiRBNEnccXCft9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 DM4PR84MB3291.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:42::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 14:43:48 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:43:48 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
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
Subject: Re: [PATCH v1 3/5] dt-bindings: net: Add HPE GXP UMAC
Thread-Topic: [PATCH v1 3/5] dt-bindings: net: Add HPE GXP UMAC
Thread-Index: AQHZvBm+GooG93oDpUucD86cbiWeIa/ExaIAgAW2tLCAAEyvgIAAC7/QgAD+YYA=
Date:   Wed, 26 Jul 2023 14:43:47 +0000
Message-ID: <BF89A302-B6A1-4854-AAC1-015B5BC1DD91@hpe.com>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-4-nick.hawkins@hpe.com>
 <57d882ed-82e5-4584-8126-ca2007064126@lunn.ch>
 <DM4PR84MB192785EC6F2B8A76FF9E5E3F8803A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <4c19532d-a909-4ca6-a0a7-d4cd9cc828b0@lunn.ch>
 <DM4PR84MB19274F3AA411D4CAE7EE84D88803A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DM4PR84MB19274F3AA411D4CAE7EE84D88803A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.75.23071400
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|DM4PR84MB3291:EE_
x-ms-office365-filtering-correlation-id: 1bdf675e-825b-485b-1e36-08db8de6b875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yKPWb6fxvASePuAk4lbDSGIubFzdN9OaEQM8uEvi1pBxc1WtN45DXBnwI6mtgF0rfa9J0yJzw03LbJbx5f3aznCM9CR83/WxlJgv3cOnF0b+9esmQJuRPetvztUDhqZ5XR0XcJQIsAaK456CvZTnRSYoQepFieydKXJwu8WOI+dqlVEnE2CYF1fVgeksqApxHqfY6LsdJXVm60qK0624Xdq52htWjbwstbL50zV7NYXd2AycT1BD+stXbSchkeCvrUrgaAl6UbON0XXjwWsoJHtQe7wJa1y6Qleq1OFbgzW85G6k3Mz7jFUgiFWcqOFVMbtVZMCz8hq4knBuYSC7HuyZD0ryZ2/FDNqON4EjdmDyrDmXgbmw+utyAFbqZBxwHFSuBtKkxTtBktH22IcEKjPdgKfVAaWsEx7znfPg6Izi5bb/WQVjOE495V368p2S1E0KKLfPUXMMFdOGG15p9s6ZNk6f3AJ7jpuxgUMV+ht8H5/J27/G/mYOpwQ6VnOByuKza4HafPCid9h2D2WM/bXgI5LHc4JGq49lnBV/vUU4otqlMz/E2bMbuGuaIV8QP82za5nYtmubBOLcY+kJ8EqSgwl18uLQkC2B7EbMBYu/77Z6waE6tadqz3G3ksrpiCvYBuSG/3LZGAggdFdUCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(38070700005)(2906002)(71200400001)(6486002)(2616005)(38100700002)(36756003)(7416002)(186003)(5660300002)(86362001)(66899021)(41300700001)(8676002)(33656002)(316002)(6506007)(8936002)(64756008)(66556008)(6916009)(66446008)(478600001)(76116006)(6512007)(66476007)(4326008)(66946007)(82960400001)(54906003)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDBlaWhDdlJsOExUaWFxVFFnZjdyK0o1THlVNUNOZG0ranh5WW5OUXRaWmgz?=
 =?utf-8?B?d1E2cmhOcEx6NVN0UXdNS2VFSDkxbGJRMnVSY0x3bzFnTi9UK25pd3ovcUN0?=
 =?utf-8?B?aEJUK2tXR1cwelBDbE8wSkcxRExIQi96VmZEZHJ0d0NKdlNEMEVCQk5HTjYx?=
 =?utf-8?B?SVlVSGkvUUhReUhhRjAxZWswMzEyOWFjVDVnSnNITHB0dVVCb09PSDhyakVN?=
 =?utf-8?B?d2NQODNjUTVyMms2QXF3UnpMaU9JNFBQdTFwRm8vY3pmT1BuaEZZU3cyRWpl?=
 =?utf-8?B?ZUphTjc5VjlycEVnOGxWUDFKdzFyK0JHT2NjeXNGVWVid1hLcTdJaE8xU3BM?=
 =?utf-8?B?aXNlemozK0U2dWdMaEQvclA4WitnOVZSaFJDTkpsVE51TzVKeTV4NHJTeE9r?=
 =?utf-8?B?ZElMbHVCNU9sRmZ2bFk3amkxdjYwd0Vkb0tDMG1xTGZmbUJ5S1V6RDNnZVNv?=
 =?utf-8?B?cVVvdmpldFFxSVlzVXVhdTBlZ01rY2JqaityekxXNlRaeVg1WXR1L2lFUytX?=
 =?utf-8?B?NG93eXJDc3NtbmJGNTM0bDhWNmlicm9RK3JEL01nVVZZdHpGMHA3UGtRd3F2?=
 =?utf-8?B?eGJ4SnFvMHpCNFBXZUh6Q3dDRGRQWmVOMUlzT3VMT0tldDBwYTFQcnlNaDlt?=
 =?utf-8?B?WExGVUMvWU1mV25FZWN5cURkQzBHcTFoTkZ5bWRiYXZSL3dNb2d1UllyWVha?=
 =?utf-8?B?S1k0cEE4Z1NNa0NOUU5iZDdaTm5IZ1BwUy9zUmtLdDlwODVqZVZqNDc0TXp1?=
 =?utf-8?B?dmZaV2JrMjhYUEg3NGZKc01LcWdFV0NiajNLdFY1T1RxcWY3TDVseTBCNXpn?=
 =?utf-8?B?cUI4eDNZMmpwOEZjTlBUdXpLS1pTaWtuN3NBRXo5U1JPaWpwem1mVmJxeXZN?=
 =?utf-8?B?MkVrRHJvOGZNVDNLQ0RQUCtKUmhQSTZVSTJGRUJhKzhxb1pYQjIxcjdxb09y?=
 =?utf-8?B?MzQyTTFJL0JzN256RGxpTmJ0NDQvTXBQbHpnRjNwRkNpUGhaZVFtWkljZ2p0?=
 =?utf-8?B?a3lsN0Z4NklCcVJQemU0UGV1Ymp1aTQvSWxWUFg4bE1KUVlSNklGM3VhSWpS?=
 =?utf-8?B?RWhIZStGb2I3NE5oeWRCeU1jdERpcVNTYjdRQzJPVmtQR1kvck1Vd3RsTVpR?=
 =?utf-8?B?dWZ6dFQ3NytmT2NEcmxkNnd3bTVZMnBkbTBBWXA4WWowem5US2lPR1M4bTAv?=
 =?utf-8?B?U1RjQ2ZXZlFOTkw3bjdEMU5PbjFaSit5SUNCVGE4VUcxQlRxM01McUU4aEtP?=
 =?utf-8?B?bTdkMjBXY3lqcnlkcXhnOFNoeHhaNndvMllOekNjamVPWmgyQi90dHd6dVNP?=
 =?utf-8?B?WHpUaGRvNEFqaGRHSXJVTFp0RGtZMXRtalR4R21TUlFvdEZpd0NBeDBMMlNu?=
 =?utf-8?B?eEVjdTNmb0FmaUpJQ1RIOHQybTdyRE1tRnFHWnhEdnVxTlA2NmtlbXpxeVlY?=
 =?utf-8?B?YXYvcVBhS051VXJXOFYvTWJRY2wzbEtFOHQ1d0M5V0w2QUFKdXhESVNLcHFK?=
 =?utf-8?B?WGo2dHZKR3BUS0tpV1FhOC9ZSjFwcm5WOUx5WHRXTGp6Z2pFVU5yTFBDUnRN?=
 =?utf-8?B?bVE0SmhhSlh4dS9uVmo2ZGdLdlFjdjJVYTNqRDg0K2FEZGJsRkVGazZPYnpY?=
 =?utf-8?B?VGVic0IzdVRJYXdIR1pCc2NYazU4T2xXQ2JrK3VwOThkV3hSckJHc0ZTMEtO?=
 =?utf-8?B?OFQrck1DcGhWczJ0UkRBMmdmdTYzRExtdTBNQWI4MzNKSW1NWjlXQzhQc0xL?=
 =?utf-8?B?a1Z6MmI3UTNnemlVS0lVNmNkWE13V1pxb1BXYmE3Ni93bTJNQ2hGMGlJd0xx?=
 =?utf-8?B?ZXZLZDkvOXpFanMwNkc5SW5YdVJsZEZQaXlsSlVMUkhlbHVEQTZlSldnZXFM?=
 =?utf-8?B?QlRCMjBCejRtNHZZbnVaL0hZTStBMnIwT1g1a3ViODRrYjNpSVVxbUVScW83?=
 =?utf-8?B?dEVNUFZlTXRQSHpXWnF6Q2s5dW4zejBkZkVuS0NkSmpUNkljNTZ3ajllWWpj?=
 =?utf-8?B?QmUwcTB2QnlyVlVzTjR2L0tuVTIwNVhiMnZDblN4bGk0TmlpQk1EWVVGbEtY?=
 =?utf-8?B?NFZRVzdxbWxLbTNtME1lT01HcTR3amZPd04vZnRQQ2tSOWlqRzRFeW5iZTRK?=
 =?utf-8?B?N1l4V3l5QktKUDh4WEJzUmk2UCtXYWFZNHorQTFnMFlFRnI5RXRyeFgxT0tD?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAEF17C3E6D6C8458E079C3C3BB560ED@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdf675e-825b-485b-1e36-08db8de6b875
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 14:43:47.9358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68CdckeKqS8IGmi7OT8sRj7js8pwJYQNxy3TCXZErAjidlCirtMxThBbhDWlitwaPj1QypiqB8I9U6XnV/Dc7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB3291
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: _sSn-KFJCskjutbQwQIm-G3poC-ooWsp
X-Proofpoint-ORIG-GUID: _sSn-KFJCskjutbQwQIm-G3poC-ooWsp
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=621 mlxscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm90ZTogUmVzZW5kIGluIGNvcnJlY3QgZm9ybWF0Lg0KDQo+ID4gPiBEbyBib3RoIHBvcnRzIGdl
dCB0aGUgc2FuZSBNQUMgYWRkcmVzcz8NCj4gPiANCj4gPiBObyB0aGV5IGRvIG5vdC4gVGhlIGZp
cnN0IG9uZSB3aWxsIGdldCB0aGUgTUFDIGFkZHJlc3MsIHRoZSBzZWNvbmQNCj4gPiB3aWxsIGJl
IGFuIGV4dGVybmFsIHBoeSB3ZSBhcmUgbWFuYWdpbmcgdmlhIHRoZSBNRElPIHBhdGguDQoNCj4g
VGhlbiBwbGVhc2UgcHV0IHRoZSBtYWMtYWRkcmVzcyBwcm9wZXJ0eSBpbiB0aGUgY29ycmVjdCBw
bGFjZSwgaW5zaWRlDQpwb3J0QDAuDQoNCkdyZWV0aW5ncyBBbmRyZXcsDQoNCkkgd2FzIG1pc3Rh
a2VuLCB0aGUgTWFjIGFkZHJlc3MgYmVsb25ncyB3aXRoIFVNQUMsDQpub3QgdGhlIHBoeXMuIFRo
ZSByZWFzb24gcG9ydHMgYXJlIGxpc3RlZCBoZXJlIGlzDQpiZWNhdXNlIGhhdmluZyB0d28gc2Vw
YXJhdGUgcGh5LWhhbmRsZXMNCmluIG9uZSBub2RlIGlzIG5vdCBhbGxvd2VkLiBUaGUgbGF5b3V0
IG9mIHRoZQ0KaGFyZHdhcmUgaW5zaWRlIHRoZSBHWFAgaXMgdW5jb252ZW50aW9uYWwuDQoNClRo
ZXJlIGlzIGEgZGVzY3JpcHRpb24gb2YgdGhlIGxheW91dCBpbiB0aGUgY292ZXItbGV0dGVyLA0K
SSBzZWUgdGhvdWdoIEkgbmVlZCB0byBhZGQgYSBiZXR0ZXIgZGVzY3JpcHRpb24uDQpUaGUgaW50
ZXJuYWwtcGh5IGlzIGNvbm5lY3RlZCB0byB0aGUgZXh0ZXJuYWwNCnBoeSB2aWEgU0dNSUkuIFRv
IHVzZSBVTUFDMCB3ZSBuZWVkIHRvDQpjb25maWd1cmUgYm90aCB0aGUgaW50ZXJuYWwsIGFuZCBl
eHRlcm5hbCBwaHkgdG8gZW5hYmxlDQpuZXR3b3JraW5nLg0KDQpJZGVhbGx5IGl0IHdvdWxkIGJl
IHNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCnVtYWMwOiB1bWFjQDQwMDAgew0KwqDCoMKgwqDCoMKg
wqAgY29tcGF0aWJsZSA9ICJocGUsIGd4cC11bWFjIjsNCsKgwqDCoMKgwqDCoMKgwqAgcmVnID0g
PDB4NDAwMCAweDgwPjsNCsKgwqDCoMKgwqDCoMKgIGludGVycnVwdHMgPSA8MTA+Ow0KwqDCoMKg
wqDCoMKgwqAgaW50ZXJydXB0LXBhcmVudCA9IDwmdmljMD47DQrCoMKgwqDCoMKgwqDCoCBtYWMt
YWRkcmVzcyA9IFs5NCAxOCA4MiAxNiAwNCBkOF07DQrCoMKgwqDCoMKgwqDCoCBleHQtcGh5LWhh
bmRsZSA9IDwmZXh0X3BoeTA+Ow0KwqDCoMKgwqDCoMKgwqAgaW50LXBoeS1oYW5kbGUgPSA8Jmlu
dF9waHkwPjsNCn07DQoNClRoYW5rcywNCg0KLU5pY2sgSGF3a2lucw0KDQo=
