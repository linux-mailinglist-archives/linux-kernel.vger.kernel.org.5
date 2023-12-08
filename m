Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804E480AA03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573811AbjLHRFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjLHRFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:05:35 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F25D10F8;
        Fri,  8 Dec 2023 09:05:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3LPzl2zRbfrY9i4qzZwl86GBAIjWDrEf3Ic7FsZwQare1vqlf/Z3wvalkVqhh5bWw7PJp9WKBxHr/IMyOHEZPNkl/J3KBtFVSnVOM1noJ5b8CymIm3cd5cO5kG5mIGHBBNoc31m8vCw81vD2NtpRFHne5QbchjiFAiDOmz+ll4YtuSTOCoEqiDWQQYG9NWaSbq73FahmTMzlACt/2h8Zie5wM9C8XZHKY8WFnvnuboRyE4vF0ngZXXvAsIwV4B/B2RtHIg2r5i038aFZNTXE1HMCh4Q9bLvHgZT2F+DNoMtnMGlHsoi5caZD+21pzR37eZ6MFUgP2u+3PxMTAw+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmL6xVwOmtW3NZf+3Op/LrLjwAeU5ciP9cUAgiLR06Q=;
 b=GFBFHeejPpPfOXPgYzh5IVqrOxHPEGQFnYhjcItPCPcHZ9n3gRmjIy3qQX9lPw5eK9rkT4KrWjjegVwCJfNG4ai6W8IJ8wXz5UnaOg2FZ7ZIaODLR5rlUd5yXQIcapMVD3mJTNUb6SWkkf7R9OMLnsCMEFWQ2p24WN/Oap3VE+Zl0LT7G9S7b1ZjFMmrTygTB579dwIfxQCbT4ArCckExt9ZPOyhU8m5WJNxNRgHPE8cc82ojwKlV+IpPhA7JhfUsGuUcq9tg0itjYO/GQkTybOVGR5FrJdHmUiP3RJoRzrGQqp/LML6UifAqHaP0H2cffKFHdJTqpj6noT629ovcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmL6xVwOmtW3NZf+3Op/LrLjwAeU5ciP9cUAgiLR06Q=;
 b=FshwX/GR9CBK2pRwuUIRVWb37lD6qQXGtzcVkYstNww7u8Xtgz5E9tponzLntMA2byIJIRMTwn+RosBUJ/PFjBX5cJkkqgedrOcjuOdeaFYGTMe8NMW4SCyccTQyhywL5S1GvznZa7zs1hqPtx/BKTUSzmzXrNUCVIB3fDV3po4=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 17:05:34 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 17:05:34 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Topic: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Index: AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aA=
Date:   Fri, 8 Dec 2023 17:05:34 +0000
Message-ID: <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
In-Reply-To: <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|DM4PR12MB8557:EE_
x-ms-office365-filtering-correlation-id: 3f3b7867-eec3-402b-041b-08dbf80fe469
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fMK4tA5fsoJEFbTqmBqIk6HDocUMXi/QKU8PqcBiott3ktLuwRK04FuJNxr7kUnhZb2/y0nbHhN3zrCRHk5oRDkEQ/J+6nr6thT1PnCvwyu4PWVM15sjF44lJhuIAUYWFro5regdRhgty9+63S3PYl2fgjGIxvBJjf2ejvjdfbBa/lCMDaxKP6q+O7P+JVEn6pUNpObDBEgI7DpqaYLIHpfF7ry15bTsuUtSfknxVfF9qmV57rOfeYsvOfWkxZAYUX6rfK1mwgAw7Uvlf8NitbG2KpXAgDXEU9juft20G4QhRHsrm8UvqYnwOYQqpTYZnG0FexEK0axvIXtFO9xFRsGL5eo6zj6/Xir6iYzuQDWOBUVToOuvhOKYGkaz4yxFYxJ+b74gM/ZRF/AI8lwjRM49j11pTpkR2acOVSRchrCjGrcTHSFYfcGmnJ0ddEOzWMZffSFzQIdDMKHKkTzQnYz7qTOrg4X/OJCxV8iM0ldxhYOI2lJ3Wbad1nQJFn0tbmsRYjmaryrQcQ/KBIzoU6Lhd1j6QwVGMs5iakdYy0V3mqmdPGPpo9V+0H8DCResdVkfjM7JEJYBsrVMwY/DgBZAcg3CxtOarAI6iA2fdrVxUs5n5hOAZ4EhoqOT54EcxVQo9WMGobDs2lo+zTsb3YnoeMWkM1sUPO6i3EGJ4seq5tSJqhIo8wM5r29Yp5F2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(55016003)(41300700001)(122000001)(38100700002)(2906002)(7416002)(316002)(38070700009)(921008)(5660300002)(4326008)(8676002)(8936002)(33656002)(76116006)(9686003)(53546011)(71200400001)(6506007)(7696005)(26005)(478600001)(64756008)(86362001)(54906003)(66556008)(66476007)(66946007)(66446008)(110136005)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjZEak5kN1V0Z1NidkpxclBPaGNILzRWakdJNVNlVHF6TmhpdHNneEh2aWVw?=
 =?utf-8?B?bERXWlIxU3pGSEN1S2cxUHpWL0FTTUtNK2dHK3ZKU09nNDdHVHczZ2kvdkV3?=
 =?utf-8?B?ODJwanFSWFMvbll4Y2kreHIzR21NMFBIN3p2Wm40SmtTUHRDQmpBOVB1SjFW?=
 =?utf-8?B?bWVnRmlNeVg5SnM1V3NPeTJVVTNvYjBkRkhabDV5VzMxU0Jnb0IxLzFiUGVI?=
 =?utf-8?B?NnljMFVQVUJUYytWaW9JV1FpYnBkVnZGYzRvT1BuZXVJWlpuQXFkbVZhejVo?=
 =?utf-8?B?azFDR0FLcDFtWGRuRmRQaUt1aGZQSVZ4SFl2bFRYc0hDU2ZhbmpxY04xblJB?=
 =?utf-8?B?RTV0R1U0QXl5TnFudHlqeTgzUlJUMGVFSklGZjFPVzlVNE5JWFNvZGJCMlgz?=
 =?utf-8?B?Z2hNOVhWMmFpOG5WTnVZNzE4cit5ZHZLZmFXRDl6dUxVYTFKUjlleDhueDZu?=
 =?utf-8?B?VUtoRDBCU05XdnZmL2gwMms5Q1FlMHpQUC9RQS9NckVnK0VZQ1c5cmVGK0li?=
 =?utf-8?B?YklqdWYrOUJza0dIVWszbXRISXpZTmZDOWk5VDBFZU96bkw2UzduanBaK0x0?=
 =?utf-8?B?VVNoZ3RFU0VoMkVMV3JHdjVMNThIcjU1emdvVGxjVFAwd0tsbjF1cFZBM29T?=
 =?utf-8?B?bGZvdXl0OUhYNkluSm5DYnRPMDNQQzlvSC9LQjEwY2M2ODFxTDltV3NKSkdR?=
 =?utf-8?B?eUp3UjlZSmx3MVJqOSs1K3ZCME5xWnVvRFQrbEo5L21Xd1F3NnlpRlh3Y0dH?=
 =?utf-8?B?QWJUYVp6UG1pUURKSkw2VjgrMmF1VllzaWdoWjhEUzFyd09hYk9iZXlFa1ls?=
 =?utf-8?B?VlpwTU1FUDhZMkhreGtZUWF3azVLTVFDZGJwNzBmWDVIdkxQaVlsOEI0OVhB?=
 =?utf-8?B?eGtuWFhNaDA4dGYwZXBuV3JscnY3c01ZbDlZUy9QV1IwYVJ5ME9DcHFtN212?=
 =?utf-8?B?blhFdm9qczZJNzJST2hmMHVnUW9SM1B6cHoycFlwdDUvc29TbTZhV1h4UlFn?=
 =?utf-8?B?d3lSRnk4OWorRFZCVGppZEtSZXQ2NE9zZFUreU1YamFEbkxWZ3ZoYXF1UWZJ?=
 =?utf-8?B?SGk5ZHFCRGJwaDZnV055eGVNd2xGajI4WDJIa3JWZ3V3MW1nM3E1dEphNFd6?=
 =?utf-8?B?QlpJK0lDWmZkd0hmc2h3aGNabEJtL1VjaURnL0J3Z0ZWSklzOHdTMlFTZzhv?=
 =?utf-8?B?M3lGMFJUZXF2cGc0TzRWNlJpV2RBSUx5Q2twZnBINVUzcEk2L2dNZ3RFV2FK?=
 =?utf-8?B?V09LQzJoc1dwdGJrVnlYVkhtQW45NjFkU1cwWjk4cjROMDNpUzF6WmtMQmZ2?=
 =?utf-8?B?Z2hvemxXSHNUZ2pkVHZzbHRxWFBSOVJ3M3JYZklnMndNN3dSamYxVW96UHJM?=
 =?utf-8?B?cHZ5bE5BNnBNY0ROaDdURDArd0VpclNWaWkzWHNGM2xkc3VjWU9zZEIyRG1s?=
 =?utf-8?B?T0R1VjNtR3QzK2t2ZitWWEJraExWbDZkT3ZlODdYTnQ3MXlzSDJTbDFrdCtz?=
 =?utf-8?B?eTRMZ21OWWd5MWFUSmlsTUZoNjM0TTY4aTFKL0hyUDZiazRZVit4ZTJTeHJ5?=
 =?utf-8?B?Rzc4bytJdk5rVnVHMy9XTUxMdzBOcnEweXZ3ak9uTWhjZXRTMkk4MjY5aXZM?=
 =?utf-8?B?YXJzL3hFSDZ0R0wyaEZPbjl1K2kzNkU4U0dESVF6UXJIZ25BOWJsOUZYLzdR?=
 =?utf-8?B?dzQrSEhsanpmYldzakVpZ1ltVnA1aEF2TTh4MlRXcmx5eGxDVVlwMVRnbEJn?=
 =?utf-8?B?a0twbXlmNXVlVDdabjN1OHJseDRFVThpOUhoSnRiQzZsYzZ3ZDNhSmdwcXEz?=
 =?utf-8?B?R1Z3VGprVDJaa1g4dndyK3poZHdmRlJnMGkwM3dpUG5vZExuTld3czh5aFpH?=
 =?utf-8?B?bmdRK2QyWGF3TVh3SG9DM0JqVmROc1JKd0VacEZFZzc2ZUZYNUNrMTR5b0pv?=
 =?utf-8?B?L21TRnAzUGkrMjRWRkVEYnZHcHVYM01CNi9MKy9LcTkwV3UzajZGQnRCYjN1?=
 =?utf-8?B?dFlOUE5ydml6OUs3KzdzaUxxdFYvSUdaOXZCdk9DdUFhQjhaYVRGbzlDVy8x?=
 =?utf-8?B?ZWZTSTRFbWo1V1RjNUdrUElGdk0rS2VJb0pPbnFKWW1lM0ZXWGxIRUNxRFVv?=
 =?utf-8?Q?yR/U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3b7867-eec3-402b-041b-08dbf80fe469
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 17:05:34.3251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iaRprxwL+2pDF7e6PN04lhFaMSP4k7HlbYcMlkR7d8NDP2zod+iFzlaUP24BGR83iI7vQgU7Ln7rvK1zyDdwBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IERlY2VtYmVyIDYsIDIwMjMgODowMCBQTQ0KPiBUbzogTWFoYXBhdHJhLCBBbWl0IEt1bWFyIDxh
bWl0Lmt1bWFyLW1haGFwYXRyYUBhbWQuY29tPjsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyBwcmF0
eXVzaEBrZXJuZWwub3JnOyBtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOw0KPiByaWNoYXJkQG5v
ZC5hdDsgdmlnbmVzaHJAdGkuY29tOyBzYmluZGluZ0BvcGVuc291cmNlLmNpcnJ1cy5jb207DQo+
IGxlZUBrZXJuZWwub3JnOyBqYW1lcy5zY2h1bG1hbkBjaXJydXMuY29tOyBkYXZpZC5yaG9kZXNA
Y2lycnVzLmNvbTsNCj4gcmZAb3BlbnNvdXJjZS5jaXJydXMuY29tOyBwZXJleEBwZXJleC5jejsg
dGl3YWlAc3VzZS5jb20NCj4gQ2M6IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IG1pY2hhZWxAd2FsbGUuY2M7IGxpbnV4LW10ZEBsaXN0
cy5pbmZyYWRlYWQub3JnOw0KPiBuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb207IGFsZXhhbmRy
ZS5iZWxsb25pQGJvb3RsaW4uY29tOw0KPiBjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY7IFNpbWVr
LCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbGludXgtDQo+IGFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOw0KPiBwYXRjaGVz
QG9wZW5zb3VyY2UuY2lycnVzLmNvbTsgbGludXgtc291bmRAdmdlci5rZXJuZWwub3JnOyBnaXQg
KEFNRC0NCj4gWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBhbWl0cmtjaWFuMjAwMkBnbWFpbC5jb20N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMDcvMTBdIG10ZDogc3BpLW5vcjogQWRkIHN0YWNr
ZWQgbWVtb3JpZXMgc3VwcG9ydA0KPiBpbiBzcGktbm9yDQo+IA0KPiBIaSwgQW1pdCwNCj4gDQo+
IE9uIDExLzI1LzIzIDA5OjIxLCBBbWl0IEt1bWFyIE1haGFwYXRyYSB3cm90ZToNCj4gPiBFYWNo
IGZsYXNoIHRoYXQgaXMgY29ubmVjdGVkIGluIHN0YWNrZWQgbW9kZSBzaG91bGQgaGF2ZSBhIHNl
cGFyYXRlDQo+ID4gcGFyYW1ldGVyIHN0cnVjdHVyZS4gU28sIHRoZSBmbGFzaCBwYXJhbWV0ZXIg
bWVtYmVyKCpwYXJhbXMpIG9mIHRoZQ0KPiA+IHNwaV9ub3Igc3RydWN0dXJlIGlzIGNoYW5nZWQg
dG8gYW4gYXJyYXkgKCpwYXJhbXNbMl0pLiBUaGUgYXJyYXkgaXMNCj4gPiB1c2VkIHRvIHN0b3Jl
IHRoZSBwYXJhbWV0ZXJzIG9mIGVhY2ggZmxhc2ggY29ubmVjdGVkIGluIHN0YWNrZWQNCj4gY29u
ZmlndXJhdGlvbi4NCj4gPg0KPiA+IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGFzc3VtZXMg
dGhhdCBhIG1heGltdW0gb2YgdHdvIGZsYXNoZXMgYXJlDQo+ID4gY29ubmVjdGVkIGluIHN0YWNr
ZWQgbW9kZSBhbmQgYm90aCB0aGUgZmxhc2hlcyBhcmUgb2Ygc2FtZSBtYWtlIGJ1dA0KPiA+IGNh
biBkaWZmZXIgaW4gc2l6ZXMuIFNvLCBleGNlcHQgdGhlIHNpemVzIGFsbCBvdGhlciBmbGFzaCBw
YXJhbWV0ZXJzDQo+ID4gb2YgYm90aCB0aGUgZmxhc2hlcyBhcmUgaWRlbnRpY2FsLg0KPiANCj4g
RG8geW91IHBsYW4gdG8gYWRkIHN1cHBvcnQgZm9yIGRpZmZlcmVudCBmbGFzaGVzIGluIHN0YWNr
ZWQgbW9kZT8gSWYgbm90LA0KDQpObywgYWNjb3JkaW5nIHRvIHRoZSBjdXJyZW50IGltcGxlbWVu
dGF0aW9uLCBpbiBzdGFja2VkIG1vZGUsIGJvdGggZmxhc2hlcyANCm11c3QgYmUgb2YgdGhlIHNh
bWUgbWFrZS4NCg0KPiB3b3VsZG4ndCBpdCBiZSBzaW1wbGVyIHRvIGhhdmUganVzdCBhbiBhcnJh
eSBvZiBmbGFzaCBzaXplcyBpbnN0ZWFkIG9mDQo+IGR1cGxpY2F0aW5nIHRoZSBlbnRpcmUgcGFy
YW1zIHN0cnVjdD8NCg0KWWVzLCB0aGF0IGlzIGFjY3VyYXRlLiBJbiBhbGlnbm1lbnQgd2l0aCBv
dXIgY3VycmVudCBzdGFja2VkIHN1cHBvcnQgdXNlIGNhc2Ugd2UgDQpjYW4gaGF2ZSBhbiBhcnJh
eSBvZiBmbGFzaCBzaXplcyBpbnN0ZWFkLg0KVGhlIHByaW1hcnkgcHVycG9zZSBvZiBoYXZpbmcg
YW4gYXJyYXkgb2YgcGFyYW1zIHN0cnVjdCB3YXMgdG8gZmFjaWxpdGF0ZSANCnBvdGVudGlhbCBm
dXR1cmUgZXh0ZW5zaW9ucywgYWxsb3dpbmcgdGhlIGFkZGl0aW9uIG9mIHN0YWNrZWQgc3VwcG9y
dCBmb3IgDQpkaWZmZXJlbnQgZmxhc2hlcw0KDQo+IA0KPiA+DQo+ID4gU1BJLU5PUiBpcyBub3Qg
YXdhcmUgb2YgdGhlIGNoaXBfc2VsZWN0IHZhbHVlcywgZm9yIGFueSBpbmNvbWluZw0KPiA+IHJl
cXVlc3QgU1BJLU5PUiB3aWxsIGRlY2lkZSB0aGUgZmxhc2ggaW5kZXggd2l0aCB0aGUgaGVscCBv
Zg0KPiA+IGluZGl2aWR1YWwgZmxhc2ggc2l6ZSBhbmQgdGhlIGNvbmZpZ3VyYXRpb24gdHlwZSAo
c2luZ2xlL3N0YWNrZWQpLg0KPiA+IFNQSS1OT1Igd2lsbCBwYXNzIG9uIHRoZSBmbGFzaCBpbmRl
eCBpbmZvcm1hdGlvbiB0byB0aGUgU1BJIGNvcmUgJiBTUEkNCj4gPiBkcml2ZXIgYnkgc2V0dGlu
ZyB0aGUgYXBwcm9wcmlhdGUgYml0IGluDQo+ID4gbm9yLT5zcGltZW0tPnNwaS0+Y3NfaW5kZXhf
bWFzay4gRm9yIGV4YW1wbGUsIGlmIG50aCBiaXQgb2YNCj4gPiBub3ItPnNwaW1lbS0+c3BpLT5j
c19pbmRleF9tYXNrIGlzIHNldCB0aGVuIHRoZSBkcml2ZXIgd291bGQNCj4gPiBhc3NlcnQvZGUt
YXNzZXJ0IHNwaS0+Y2hpcF9zbGVjdFtuXS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFtaXQg
S3VtYXIgTWFoYXBhdHJhIDxhbWl0Lmt1bWFyLW1haGFwYXRyYUBhbWQuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyAgfCAyNzIgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tDQo+ID4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oICB8ICAg
NCArDQo+ID4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCB8ICAxNSArLQ0KPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDI0MCBpbnNlcnRpb25zKCspLCA1MSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5jDQo+ID4gaW5kZXggOTNhZTY5YjdmZjgzLi5lOTkwYmU3YzdlYjYgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuYw0KPiANCj4gY3V0DQo+IA0KPiA+IEBAIC0yOTA1LDcgKzMwMDcs
MTAgQEAgc3RhdGljIHZvaWQgc3BpX25vcl9pbml0X2ZpeHVwX2ZsYWdzKHN0cnVjdA0KPiA+IHNw
aV9ub3IgKm5vcikgIHN0YXRpYyBpbnQgc3BpX25vcl9sYXRlX2luaXRfcGFyYW1zKHN0cnVjdCBz
cGlfbm9yDQo+ID4gKm5vcikgIHsNCj4gPiAgCXN0cnVjdCBzcGlfbm9yX2ZsYXNoX3BhcmFtZXRl
ciAqcGFyYW1zID0gc3BpX25vcl9nZXRfcGFyYW1zKG5vciwNCj4gMCk7DQo+ID4gLQlpbnQgcmV0
Ow0KPiA+ICsJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHNwaV9ub3JfZ2V0X2ZsYXNoX25vZGUo
bm9yKTsNCj4gPiArCXU2NCBmbGFzaF9zaXplW1NOT1JfRkxBU0hfQ05UX01BWF07DQo+ID4gKwl1
MzIgaWR4ID0gMDsNCj4gPiArCWludCByYywgcmV0Ow0KPiA+DQo+ID4gIAlpZiAobm9yLT5tYW51
ZmFjdHVyZXIgJiYgbm9yLT5tYW51ZmFjdHVyZXItPmZpeHVwcyAmJg0KPiA+ICAJICAgIG5vci0+
bWFudWZhY3R1cmVyLT5maXh1cHMtPmxhdGVfaW5pdCkgeyBAQCAtMjkzNyw2ICszMDQyLDQ0IEBA
DQo+ID4gc3RhdGljIGludCBzcGlfbm9yX2xhdGVfaW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3Ig
Km5vcikNCj4gPiAgCWlmIChwYXJhbXMtPm5fYmFua3MgPiAxKQ0KPiA+ICAJCXBhcmFtcy0+YmFu
a19zaXplID0gZGl2NjRfdTY0KHBhcmFtcy0+c2l6ZSwgcGFyYW1zLQ0KPiA+bl9iYW5rcyk7DQo+
ID4NCj4gPiArCW5vci0+bnVtX2ZsYXNoID0gMDsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICog
VGhlIGZsYXNoZXMgdGhhdCBhcmUgY29ubmVjdGVkIGluIHN0YWNrZWQgbW9kZSBzaG91bGQgYmUg
b2Ygc2FtZQ0KPiBtYWtlLg0KPiA+ICsJICogRXhjZXB0IHRoZSBmbGFzaCBzaXplIGFsbCBvdGhl
ciBwcm9wZXJ0aWVzIGFyZSBpZGVudGljYWwgZm9yIGFsbCB0aGUNCj4gPiArCSAqIGZsYXNoZXMg
Y29ubmVjdGVkIGluIHN0YWNrZWQgbW9kZS4NCj4gPiArCSAqIFRoZSBmbGFzaGVzIHRoYXQgYXJl
IGNvbm5lY3RlZCBpbiBwYXJhbGxlbCBtb2RlIHNob3VsZCBiZSBpZGVudGljYWwuDQo+ID4gKwkg
Ki8NCj4gPiArCXdoaWxlIChpZHggPCBTTk9SX0ZMQVNIX0NOVF9NQVgpIHsNCj4gPiArCQlyYyA9
IG9mX3Byb3BlcnR5X3JlYWRfdTY0X2luZGV4KG5wLCAic3RhY2tlZC1tZW1vcmllcyIsDQo+IGlk
eCwNCj4gPiArJmZsYXNoX3NpemVbaWR4XSk7DQo+IA0KPiBUaGlzIGlzIGEgbGl0dGxlIGxhdGUg
aW4gbXkgb3BpbmlvbiwgYXMgd2UgZG9uJ3QgaGF2ZSBhbnkgc2FuaXR5IGNoZWNrIG9uIHRoZQ0K
PiBmbGFzaGVzIHRoYXQgYXJlIHN0YWNrZWQgb24gdG9wIG9mIHRoZSBmaXJzdC4gV2Ugc2hhbGwg
YXQgbGVhc3QgcmVhZCBhbmQgY29tcGFyZQ0KPiB0aGUgSUQgZm9yIGFsbC4NCg0KQWxyaWdodCwg
SSB3aWxsIGluY29ycG9yYXRlIGEgc2FuaXR5IGNoZWNrIGZvciByZWFkaW5nIGFuZCBjb21wYXJp
bmcgdGhlIA0KSUQgb2YgdGhlIHN0YWNrZWQgZmxhc2guIFN1YnNlcXVlbnRseSwgSSBiZWxpZXZl
IHRoaXMgc3RhY2tlZCBsb2dpYyANCnNob3VsZCBiZSByZWxvY2F0ZWQgdG8gc3BpX25vcl9nZXRf
Zmxhc2hfaW5mbygpIHdoZXJlIHdlIGlkZW50aWZ5IHRoZSANCmZpcnN0IGZsYXNoLiBQbGVhc2Ug
c2hhcmUgeW91ciB0aG91Z2h0cyBvbiB0aGlzLiBBZGRpdGlvbmFsbHksIGRvIHlvdSANCmFudGlj
aXBhdGUgdGhhdCBTUEktTk9SIHNob3VsZCB0aHJvdyBhbiBlcnJvciBpZiB0aGUgc2Vjb25kIG9y
IGFueSANCnN1YnNlcXVlbnQgZmxhc2ggd2l0aGluIHRoZSBzdGFja2VkIGNvbm5lY3Rpb24gaXMg
ZGlmZmVyZW50PyBPciB3b3VsZCB5b3UgDQpwcmVmZXIgaXQgdG8gcHJpbnQgYSB3YXJuaW5nIGFu
ZCBvcGVyYXRlIGluIHNpbmdsZSBtb2RlIChpLmUuLCBvbmx5IHRoZSANCmZpcnN0IGZsYXNoKT8N
Cg0KUmVnYXJkcywNCkFtaXQNCj4gDQo+IENoZWVycywNCj4gdGENCg==
