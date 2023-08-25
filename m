Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B35788F02
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjHYSzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjHYSyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:54:47 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA862127;
        Fri, 25 Aug 2023 11:54:43 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDtqba031959;
        Fri, 25 Aug 2023 18:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=pMkTiIDGulVPTZyLa/x01FawGNN81HNXf8mSU5lsGtk=;
 b=amFtSQ4iM8CB0UMsSNf+9B2QxrntO7iz0cnQnXq5AJxOXt/5O/QKewuYJAwP70QLiIXw
 8OP3RbSCkW8arz+txOd10tGlVkUE1+1FluPhlAsKfAiGENwPEyRlLGCiQIWQucBVy59b
 M2+0L1Ms5aT+fHFs4w3DJvILykR7O5pTYpwBLCJt4GOPK2o4hb8mgsq0lh6jz627ljiM
 smU97bniSBtqCYRhrTR0pDa4mNSqNdBBS+6iwsmFSQFuQAbvOI/zCXEvCHrtzAPznmow
 3LkYwLndvBVq2udChylROdW1WW++MxumtZWwckQd7phpZe1mWoD3Ta4agolw+/v/B50B vg== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3spwm3jck3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 18:54:22 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 6A07CD2D2;
        Fri, 25 Aug 2023 18:54:21 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 25 Aug 2023 06:54:21 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 25 Aug 2023 06:54:20 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 25 Aug 2023 06:54:20 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 25 Aug 2023 06:54:20 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6j7mfpuzr6UwaVddSGJw6sPIh4KsHK1eBaBgm4PWYG2Qgp/7STVbdijBK4waVldNENGrEs/ubjsHv0RYF3s+wtUJhkNp0UFyZDHOK8kFYJX9wcm1tvtgWPioOrLhX6ZIZgMUhYRdRq5L94o40VL+pYNUG6BAx0C8A1r3NQG5Q0ix2Bg8QTAZ/sDsxRs8CLvGOykCf6kPgNzfF5Biiuo6/uCEyJ/+PSC1+VZdhiYteWiOjDek7g0Y5dOzq7uA5ZDUfoanNkiEg3O23/C+5KxSJ1l43ok7d8pXHXJekfBbUdvswTVp70N7LfpXs2hxYuDu5xFMa2lA3FaVlCc8dyxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMkTiIDGulVPTZyLa/x01FawGNN81HNXf8mSU5lsGtk=;
 b=ofexgUm9atG78Huse2XhDmWkfSx7R8k3K1iXMaIV5BnR6cdMc4FNul+yXaFhBtAIrfLGT0TNDAlIG4sz3lTyhmaECcADu0iUliWfYru0j2zCrvwn2z6u6/tRWQvKiBg4GR1BsDN+jL2QRA2Co+hmcYR3qCyApStG+77MtDtNuwy215VB9yt/vhBRVZDiRI86esItFg+AyMuP6SdreMZvLCCGkvqn7rpLJMnhXtXso4CXWbd719UTLA8iBYmTl/K8Yvf/meadI9TXLqZYV8XBLmDHrdJBRI5i3O1yCMwc12Fr03UALlpfRGMWTfD35OO6lhu627aJfFiIC0FjCFHkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 CH3PR84MB3522.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.29; Fri, 25 Aug 2023 18:54:18 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 18:54:18 +0000
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
Subject: RE: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Thread-Topic: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Thread-Index: AQHZ0Ixvto7vnAASrEiTAeghAafYu6/tuDUAgAJzHICAAGX0gIAFz7wAgABkmgCABKKvcA==
Date:   Fri, 25 Aug 2023 18:54:18 +0000
Message-ID: <DM4PR84MB1927E85827B5450F1952E58A88E3A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
 <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
 <88B3833C-19FB-4E4C-A398-E7EF3143ED02@hpe.com>
 <1b8058e1-6e7f-4a4a-a191-09a9b8010e0a@lunn.ch>
 <CF9BD927-B788-4554-B246-D5CC6D06258F@hpe.com>
 <befbee5a-7b11-4948-a837-6311dd4d7276@lunn.ch>
In-Reply-To: <befbee5a-7b11-4948-a837-6311dd4d7276@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|CH3PR84MB3522:EE_
x-ms-office365-filtering-correlation-id: b2208c1e-48d2-453e-e281-08dba59cafaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tAlwHTWRZMzlsU0xjusLX/Cp/1lt2Mji3VqVISTjZP4slFzwPL4rf2V5umU3nB4ZzsCHqSKOMpIX0LOR3LQFz08mdnqxBNM7m2RGoX/fpzr1AYUj8isBcgDtrDYfOA69TOmq1mVGa65bdqTkvQlnRmaouoYhU6e8qv2DPZhuWNLDFZPl7pcs7LxHfC6QEsRquAbqH3zDvOdqyVDp+9FxjbU+RIFclo6ZMok1QEL1ycJkgmKkcFbMr6NeD9PxnaaNhwzmjSeXaS+tb8iIJYVItDgpeuEfOh5Ltppo8S3X/2M5DQ6EwekDRziZvd0PEgbMscqpq60cya1BCZvYkPRmSsZ8X4c9CNbES7Ew6l3c2jit4QM5mB366U9mpDV+jriqmaXfhZz910W3kUQskK5oK5Il8gUzI7vlrSbTMz15iuZnw59M3nozCW0/V/mrX3e8qLYt8fM+v/g8T36YZ0gQTY0GFM0rIc39fz409vI9dIfbtGy9dFZ+KkgSAqPVHmH7BcEIhAFnFnkBuu+DSIMWuUqDeSJiz6g3parYWINhjbRtI9wAKkzsnIusLnLjhKhq6xfNXIx3/iorZ0SoscYflJGXzrfgaiFmmhb78eWJbP98OT4fOBjxZihw5riAc/un
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199024)(1800799009)(186009)(82960400001)(38070700005)(38100700002)(122000001)(8676002)(4326008)(8936002)(64756008)(54906003)(41300700001)(6506007)(33656002)(66446008)(316002)(7696005)(76116006)(6916009)(66476007)(66556008)(86362001)(66946007)(71200400001)(9686003)(55016003)(26005)(478600001)(7416002)(4744005)(2906002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VnLnQJymqasS5g3n6XT2h+fDU8kBP+HRUEBzXquQswsURFP0Ov+WLmtQGd84?=
 =?us-ascii?Q?+mueRGY9w1/xcj2oa1LjA1Ezg7pb4koPaNGyfHopnJNB/lULFa2w5g2ahWwZ?=
 =?us-ascii?Q?kZPntFiI8mnsGBZ7eatk/FNk1zo6TEjDAsO5iIqH+DE0/mb65E+ln5F9rMRP?=
 =?us-ascii?Q?NA6xoHo3THYRQPBO7JK9ETLl7up9Ub2ntPQ2Yp3uZc2yHpd1bPxb6Ik7FeaW?=
 =?us-ascii?Q?II5uM8QNtOmJxmU5vnmeMXp21h0xUdHrQkHG4r9IsENnl2dQPiHbUIWhp/QP?=
 =?us-ascii?Q?UBsx7rHdD+njNCU+BdaXFFbvShForrPIXhp3vmc+1FYEXLOmXVPNTBxLXUwb?=
 =?us-ascii?Q?BIn6hrQEv1M0tZCZQNV7pWnFObBmNQVomQm+hR9Vs7ROkaps3wDVmaBlv/3S?=
 =?us-ascii?Q?VinwFA0wVdkNiM8IyNIX3yNQ+f/Hfyde5xAOBsCfrZQwfu6yNyH45n4d2Uin?=
 =?us-ascii?Q?DZjCVu9pKZHG0wDSEH+HpowMBDgJUwKXHGYWM6HSTTSlOMPpebTTDoY7KZvY?=
 =?us-ascii?Q?3YGlAMtUKPmSiCWA+/ZgzmHLIgwPLKRX8QU0HgyP0VDuqGrdCRO+baQEA+Gd?=
 =?us-ascii?Q?gcaEan27A4HR9SylqvuDtzJVa4vaB9zpD7Wm/17g2gQR9X5PwoT1vDX/u2ov?=
 =?us-ascii?Q?8tSO4RC2hRXvVzezNWgXns7dUmja//bazHlp9gB/pDJ/vCQONzXTGJhUu8Xt?=
 =?us-ascii?Q?y/NIW2Ca+0dmQbP1Vg3g4UNjgTYkZ8L25qEroXcUcUjjWbZkv+iyPI1sA+WD?=
 =?us-ascii?Q?xFHSKdYliSiFARsReP4jyMzb7BOmQqPnQt23LrQKQfZmYl1HiiTNNTNl+w9d?=
 =?us-ascii?Q?5Dhq5GDg1g/J4SGqstymbu95joqf0bpyiJ1apoapJly14E0rrT7MvrVfL31e?=
 =?us-ascii?Q?ow4w7wpYYQjQ7OI3vc+9OHo6OrmfjA4nKgXsZEXe6b4c0c6UNlENe186pPNM?=
 =?us-ascii?Q?endgIw4jm/i4yq6NYK005wl2FnmpXRsyBB0IJn55hWyfy8P6XAlSCTmEYxW3?=
 =?us-ascii?Q?XQSLwzLzus79IwSlKHDlHof++xnMay770NkJWWnCmWiUTycxBkudmvB3072K?=
 =?us-ascii?Q?VE6CnWaORxphDlCXO7Dz6eC+16oUOkM4qvtshDNl4whLk1ujPflYmJBbkY4w?=
 =?us-ascii?Q?o1TwEfP7lmETgnJy4P1LFtbImWiynKYQQo+rvFdagJiBR7fqw8uW1LgDABhm?=
 =?us-ascii?Q?iRWowGNrDAays1XRSQsHQaALawtEIlOi2o+VQUN6GN4KjCtP401t4XzQgBa3?=
 =?us-ascii?Q?a3BiEczUrb9CMHVkX7MnFriFs0WmDEf8QynV+jBMWatmdQ1okyCxSRZhj7OH?=
 =?us-ascii?Q?qIQX6ROduOBFygD0TZvWs/YYW3uwj92O8uQw8sU246D/fLRzeICdsi0Yn/CQ?=
 =?us-ascii?Q?3I52LTLjoj7UKVKjPEVOajnYgPyYMNjO2EFrzY2kHKwQQYfbXJVU5v/QHRWb?=
 =?us-ascii?Q?rb0zRedCBohVtMI7u6oTGHrh+xIJ5k0qHc95pUxcpL51fxCvDGNeU1Y94+c2?=
 =?us-ascii?Q?eeWPOseOP/YqzvKMhgQOiXURtMR6RVG6WzyXzL9jHGzHfkuS9oOCGcAuESzK?=
 =?us-ascii?Q?FO2kbngDbCxJhrSy8N292mAPUfiKbUnZdH+5U8Vy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b2208c1e-48d2-453e-e281-08dba59cafaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 18:54:18.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NR4wfVUgX0YIZZvIDWkgp0oLN1gYIqMazJU1v8Mpt+bgQMh658teT4eGNzgR55KJTOX/Yksez5jAJQyjSP4npA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3522
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: aQTVhzlSJLLbi-uFii6rl6cESJBVK6Wt
X-Proofpoint-ORIG-GUID: aQTVhzlSJLLbi-uFii6rl6cESJBVK6Wt
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_16,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=938 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thank you for pointing me at the correct repo to use. I was using the
incorrect one.

> Nope, not required at all. The FEC driver was first converted to page
> pool, and then XDP support added. The conversion to page pool made the
> driver faster, it could handle more packets per second. That is why i
> suggested using it, plus it means less driver code, which means less
> bugs.

I have been trying to figure out how exactly I can translate the current co=
de
over to using the page pool api over the past week. It seems like it is qui=
et
a complex change. As the driver seems to be keeping up with our
performance requirements would it be acceptable to mark this as a
TODO: for a future enhancement?

Thank you for the assistance,

-Nick Hawkins
