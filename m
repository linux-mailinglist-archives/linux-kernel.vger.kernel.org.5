Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F537CA460
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjJPJja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjJPJj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:39:28 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2120.outbound.protection.outlook.com [40.107.22.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42A697
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJd/cuCxB/1KockDfPc7CLaK77HH1V6n3SKlEdedGxfHLxu3TAcasC6rcN7EZQ1kBONw5LsKaV2Zf97iwYHE2+OUwAP0UxK7ssF6bDYaZRwZKz9wWnBK9Ie6tIgzRBE+jvUX8fjB93G5rwbOyiz6Y7qK8cxhxE0paCgKqztJwvkyvQnzYqnEENpADJB0BMqnP/7pKGHdT1qswle8HQyxkP+GBkkdPxq54bSmly8i+ZWQ7yV+7t2Q5oso1t+OdKbFuZHGu19cJFQ+5s0LpP+dheT8KhK5u65ztpY2VsDepXeoFbbZ0htkUp9wPxT44TXlqNLo7KTNzZWaqTL8kSolGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1NhTVgpeNGil0nDYUXSnJ74iW4SU67XoLkoH+wYb+g=;
 b=W65lww3MBP6BTcwLGR+wxc5TU1wP5bf1JMihUKaqFHB5dd5zrdpFJlpC55kURbhsHALjT857kqkcOIJ/uc/BDJRGaPYW19TxSMvzyF1mGOib7tsff2wWEBbNnvtTBt7iJ+W3RhKu8E1mZx9iz9hGrqfEe7sZ6RP25q7zw2snQwVaJEIOA729kz78Sdeio8HryJEdnO4EU/bRGlCpK0oDYD7GcMLAC/Gf37KFEiSTuXWg5WsdgYXJ/qLX1UvP0qaK9OSXWKglbQzw6M1SQyfWhL7mzU3wuV5uS4yWZ3SzbC0EVljQ2pK/YhHuRTLJN25K3jkZGAC81FSUBLsPU9tyrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1NhTVgpeNGil0nDYUXSnJ74iW4SU67XoLkoH+wYb+g=;
 b=Z0KtnIOKInJwLHJRGK917SexL0cXmYvk5JUY+kA+3sZqcK4ikZl1YvBkWmWfwQga3a5q/vbwhcupU2Gu38T38QDrbeE/fTIz6v6kU/v3T1D4fgkmT2+Kiqv+XVBpK41p21PIJirnfbN7DhFE9AVH99icIIHj1nYrs21vko5v6Fc=
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com (2603:10a6:20b:1da::16)
 by DBAPR06MB7077.eurprd06.prod.outlook.com (2603:10a6:10:1a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 09:39:21 +0000
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::c2f3:e304:fe49:3514]) by AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::c2f3:e304:fe49:3514%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 09:39:21 +0000
From:   SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Topic: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Index: AQHZr1hWPkDpy3UlU0qGBS67M1mV0q+3GdCAgAHeK4CAPY5YgIAvS6uAgBWqFYCAAEtqAIAACFeAgAAKcICAAUdUAIAAMwOAgAAD0ICAACfxgIAEEGaAgAs50wA=
Date:   Mon, 16 Oct 2023 09:39:21 +0000
Message-ID: <fd6b5e43-7e90-b98d-79be-0c65840ec433@leica-geosystems.com>
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
 <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
 <a8271289-0611-4e37-cf37-0be19a85656b@leica-geosystems.com>
 <084ed945-7674-280f-5866-9238473a294d@leica-geosystems.com>
 <17989610-d069-40e2-9b4d-7ca6bdf2497e@linaro.org>
 <a24d7b3b-4077-9dbe-49ae-96f595b42223@leica-geosystems.com>
 <2d7271b3-dd60-44bb-9700-f6a5295ea873@linaro.org>
 <372046cb-9135-9a6c-fdb7-307a42f55b30@leica-geosystems.com>
 <a86b93c4-a507-47c7-bdce-4aed8dfcf929@linaro.org>
 <eb2a9138-a76e-4b1e-e001-315149c4dabd@leica-geosystems.com>
 <f0a7acb3-00b5-433d-af5c-724a509fb816@linaro.org>
 <bc76767e-00c1-47ca-9a27-2aa7d2a262f6@linaro.org>
 <b9b7bb93-fe23-34dd-6a30-b1b0d792861f@leica-geosystems.com>
 <2e3ce75d-7e2d-4e62-8660-48a41074c20c@linaro.org>
In-Reply-To: <2e3ce75d-7e2d-4e62-8660-48a41074c20c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR06MB7137:EE_|DBAPR06MB7077:EE_
x-ms-office365-filtering-correlation-id: 5c487a05-11c2-4249-9db1-08dbce2bc692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GLi63y41q2cxTO+ZFB34KU7pHgNEQXf31wWgg8Ks1Mmq362/3UeZEyQfNJXQ0h549+kFF96A1xGa4eZQgbnSK8JHZQkSm80tXFcu36SJyUq+OPZ5KzGa3ekYeM+VLD0TgJjRj3aJmW1mK9+RA5C3XSxWoPQUi9w+W5AcMLUZ+RVPAnMtqJOGHLpk/aefccX0JjwGqCKQc2FspH6YNbv5hdw0Py+LP1I1bOcGwFPzvMaZSSlfnKeGLpaF6qTQzwx5ixhSzSMPDAbZ2VM1WY2ZdRWCwV4KVG/l0TlWxV71AGwFVI4j7zD7Ei8wn4iVgbT+IbRCWjozGDT9wnXa/H3bBKBTiot+EVMIpC7oD4rOwqs7h63hR2D985s9U9zizwS5WZabNrxhdBeeDjEZDwXnPUomqwN9XT2hM3LTAbR2clFjRz9HfshKknJ53PDsTogqDxCvL0yGdBn4rNZJ8mVgFeCRFH+LYk26CfB844p4HD7Vr7XrqX2pbJbLU0paFAc+rpRnTj6GbJPffi5PJjxXsQGCr3PAdsGJ4FKDidCOPDpq2gjpCr+YQKma4vQmPjKKLrPcZ0VECwFawBhk1NfReBPnI+ZBbjf96pYOF2sBoAhAGGvm0BMlNjYuVuJpqq3XD2RgXs02ZXkjlWL/NKmxSKIYj9udxOLElUCzM8337qA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7137.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(110136005)(2906002)(41300700001)(6486002)(86362001)(966005)(478600001)(31696002)(64756008)(66446008)(66476007)(66556008)(36756003)(91956017)(66946007)(53546011)(76116006)(6512007)(6506007)(316002)(38070700005)(8676002)(8936002)(26005)(2616005)(107886003)(31686004)(83380400001)(122000001)(4326008)(71200400001)(38100700002)(5660300002)(138113003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm9mN2wzQmhLVk16Q3dPQU9hR2xBSUNrR0VkeS9qLzZqVjlNN21sSEJBVjZO?=
 =?utf-8?B?YVVpRDFEamYvSnZISjlRZG9EdlJJeElBMTloL01JYjhPOHJlbUZVUXRhem5X?=
 =?utf-8?B?L0l0czBJVXJxN01rVVMyVmk5Nm9mWmVRTU5FNEdvM0Vsc2MyMkpVQ1owZlB1?=
 =?utf-8?B?Zmc4ajVwQ0Q4UVJFdVU1QTNUZk95dHpNaUJ2Ky9HZCtJczRKVVBSRVhyVWNJ?=
 =?utf-8?B?YW5QZHF6V0o2ZlpoQ294dzltS1RhSmQvM2orRGkveWp1MEJPM1VIWUxjeHcw?=
 =?utf-8?B?c2Y3U2kzUytRYnR4R2Z1WE93NmxiWm9FdHl1YzN0MTRCR3UwM2krRjhUMFB1?=
 =?utf-8?B?dmtIVExMcUFhNlIxbC8zcktmaUdHQ3NrS0lSbW9DSURYQVFPbmlsOE9jOEtz?=
 =?utf-8?B?Z2VPNVNFUkc4WEZ4WnpUNGRhUDZsZS9lK2I2bGdQMG9QZU82NkZJYk12d0NJ?=
 =?utf-8?B?VDFvNUZ4UG8xL0lkME5EK0pFbDZMcVZhckg0OUJRbzVJeTNVNUxuenY2dUYw?=
 =?utf-8?B?MjFCQ1pRMDY4dnMzQm5YUTlyWEplcndJeFB5RFZyOWZ4R3pmWWtBb3RFRXZZ?=
 =?utf-8?B?ekNoeVd3SmZBSU5yQzdvOUFLK3ozd3Iwb0prYkI2bUd6Z1FVeEVoZitTcjJY?=
 =?utf-8?B?NS93c1kvaFpEUmFsRlpwT0NReGdSRTVVSWpSNnNtMGFCVWMyT1pZVHZXa01Q?=
 =?utf-8?B?SnYyNXNNRXRTaGxNN2RHby90R3ZqRVlTUnRvNEoxR0VWbzA0Ym92cEUrZkpw?=
 =?utf-8?B?eWNuUVBnN2Y5ek4zVkhCaElneEZ4Vld5RnREc0U2bkswMGlKdUMzRUIwVzlq?=
 =?utf-8?B?T0FCeUE3dlN6UnRvZHY0VEJEQWVkQVI3ZmtBaU00c0VsbzhvL0FDRkdEdlFH?=
 =?utf-8?B?VTM5dUJoV1UrSU5zcUhlaWVYNEFFL2RVWUJSeFZ1ajZma3BGc0UxMXAxK0Jl?=
 =?utf-8?B?RWNnYThwUHdwbUpOMmJHZzBOb1JiNzVVNmg2NGlZWlFrZ0l5amVmZUpTVlk4?=
 =?utf-8?B?Y0JzOUpCOUJNUjZnWng1MlQrZXEvd0t2NWVrWUdyQnh5SXFwUVBjTnYzb2dE?=
 =?utf-8?B?TmExeWJJOS80cEJ3SXF5cFhKYnpxb0tVcU11aG9EUXl4aHBublRUYU9vTXRk?=
 =?utf-8?B?Smpoa2x0eWEvMWU1RW9Ua2g3dGphc1pGenhZWnI0dzloS0pKMVZXc1ZQWVJ6?=
 =?utf-8?B?ZWpiRW01aU8wVXBiZlNFd2FXUG1tZ0lGam4xSnZpV1BSZVg2WFNHSFlYbk5n?=
 =?utf-8?B?RDZFVkZ5cGdVZW9mNmczNlpsOEI0aTBoZGZ0eGlMVXNGS1ZIckNxbWl1WERW?=
 =?utf-8?B?blhBS2xGYVJoNFFPZ0RSOC9rdGFxZlp1bk9jM0w0YTZUR3plMGw3QyszVDFu?=
 =?utf-8?B?aURoaW5QQVhMdTZQUGN1a0VYdE03STBHZVc2YlkwUTZIR1RoWldTQnIvb0NC?=
 =?utf-8?B?eWwrYUZkdUlxdEprbk41Ykl1MDhVYk02c3ArZ1hXb2pyL3N6ODRBM0xPVVVr?=
 =?utf-8?B?N2Q1TkpqQU5FNUtkMXF4YzFjdWFlREx0WjZGZ0x2alF2WEdud2wxZExlelpX?=
 =?utf-8?B?VVZqMllrUVR5RzJhblYzUUJBSWUyelBMV1Y4eGNjK0pOQjA3TldmeE9JemJv?=
 =?utf-8?B?R1ZDZVVUQmx2U2FFNFV2cDlzOXVBUzBtZ3IwNjBkUGozZ3dPbCtQZXpSYWlG?=
 =?utf-8?B?WTd6SmxMTzBoUlcxeEFMVmlPTE1YN0s3WnBjVlFXMG5qN2tjb2UxZ3ZJZEhP?=
 =?utf-8?B?bmRYQmF4Tm11Mm1rdlA0Q0Y3QmxnVnR4Y1BnQURNWnBaUk9KYVhpSUx2Q2VT?=
 =?utf-8?B?ZkszUXVCeVNMc0p1ZHZkUXl5cDhuQUJ5RGFFVWFoR2pqQzZQOGxtNGtFenho?=
 =?utf-8?B?YlVtUHpMN0puemRidkkwWFVrQmUwRWZOODZGVnFUTy83MmRRNzAvbUczR216?=
 =?utf-8?B?aVpGK1FVODdUdTljY05xSjgwS0l0Z3c2a2JKSW1xS0s0b1BPVGUveitZdmU4?=
 =?utf-8?B?bU5rRWRzNGVyU1hjOVhzK0JOMHB5WWNDRVRURkNYb1F6UFJES1B1Si9Oais0?=
 =?utf-8?B?bVBxM2xVeWZWRDVtYzBJTnBnQjFMc3hnOHZFY0Y0Z2F4clVQa0l4V2hFTkhE?=
 =?utf-8?B?NVZpSjNuWmNuOWhFa2IxM1RSZitZbngyQi9zL0NXcjYraHpTM3o5UHNVOGpX?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C81596741C450648A5482D8D3BC4F527@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7137.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c487a05-11c2-4249-9db1-08dbce2bc692
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 09:39:21.2989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sx7+6/Kkp7kFIRZvb/QhV9mwS8HBCsxWO60kjMCelZV3bjg2ysXbOpromUjU0wTz+ndr5pwF6tGwpQ831fSSD8K4MSXXcAG0P7oFOzOgqeAh0BKT760ywFY1KvKOS5wi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB7077
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCj4gT24gMTAvNi8yMyAxNzowOSwgU0hVS0xBIE1hbXRhIFJhbWVuZHJhIHdyb3Rl
Og0KPj4NCj4+DQo+PiBIZWxsbyBUdWRvciwNCj4+DQo+IEhpIQ0KPiANCj4+DQo+Pj4gT24gMTAv
Ni8yMyAxNDozMywgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4+Pj4NCj4+Pj4gSGksDQo+Pj4+DQo+
Pj4+IFRoYW5rcyBmb3IgdGhlIGRlYnVnZ2luZyBpbmZvLg0KPj4+Pg0KPj4+PiBPbiAxMC82LzIz
IDExOjMwLCBTSFVLTEEgTWFtdGEgUmFtZW5kcmEgd3JvdGU6DQo+Pj4+DQo+Pj4+IGN1dA0KPj4+
Pg0KPj4+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4+Pj4+DQo+Pj4+PiBJTU8sIEhBU18xNkJJVF9TUiBmbGFnIGlzIGNhdXNpbmcg
bG9jay91bmxvY2sgZmFpbHVyZSwNCj4+Pj4+IHNpbmNlIEJQIGJpdHMgYXJlIGNhbGN1bGF0ZWQg
d3JvbmcgdGhlbi4NCj4+Pj4+DQo+Pj4+PiBJIHRlc3RlZCBhbHNvIGZvciBhIGNhc2Ugd2hlcmUg
SSBkb24ndCBwYXJzZSBTRkRQIGFuZA0KPj4+Pj4gcmV2ZXJ0ZWQgdGhlIGNvbmRpdGlvbiBpbiAg
bWljcm9uX3N0X25vcl9kZWZhdWx0X2luaXQoKQ0KPj4+Pj4gZm9yIDE2QklUIFN0YXR1cyBSZWdp
c3RlciBGbGFnLiBBbmQgbG9jay91bmxvY2sgZmFpbHMgd2l0aA0KPj4+Pj4gc2FtZSBsb2cgYXMg
Tm9uLXdvcmtpbmcgY2FzZS4NCj4+Pj4+DQo+Pj4+PiBBbmQgdGhpcyBtdDI1cXU1MTIgaGFzIDgt
QklUIFNSIGFzIHR5cGljYWwgbWljcm9uLXN0IGZsYXNoLg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gSW5k
ZWVkLCB0aGUgcHJvYmxlbSBpcyB0aGF0IEhBU18xNkJJVF9TUiBnZXRzIHNldCB3aGVuIGl0IHNo
b3VsZG4ndCBoYXZlDQo+Pj4+IHRvLiBUaGlzIG1lYW5zIHRoYXQgdGhlIEJGUFQgdGFibGUgb2Yg
dGhlIGZsYXNoIGlzIHdyb25nIGFuZCB3ZSBzaG91bGQNCj4+Pj4gZml4IHRoZSBwYXJzZWQgc2V0
dGluZ3MgdmlhIGEgcG9zdF9iZnB0IGhvb2suDQo+Pj4+DQo+Pj4+IERvZXMgdGhlIGZvbGxvd2lu
ZyBmaXggeW91ciBwcm9ibGVtPw0KPj4+Pg0KPj4+DQo+Pj4gaGVyZSBpdCBpcyBhZ2FpbiwgdGhp
cyB0aW1lIGNvbXBpbGUgdGVzdGVkOg0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRk
L3NwaS1ub3IvbWljcm9uLXN0LmMNCj4+PiBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0
LmMNCj4+PiBpbmRleCA0YWZjZmM1N2M4OTYuLjIwZjc2ZTI3ODA5NSAxMDA2NDQNCj4+PiAtLS0g
YS9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+Pj4gKysrIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9taWNyb24tc3QuYw0KPj4+IEBAIC0xODAsNiArMTgwLDE4IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZmxhc2hfaW5mbyBtaWNyb25fbm9yX3BhcnRzW10gPSB7DQo+Pj4gICAgICAgICAg
IH0sDQo+Pj4gICAgfTsNCj4+Pg0KPj4+ICtzdGF0aWMgaW50IG10MjVxdTUxMmFfcG9zdF9iZnB0
X2ZpeHVwKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb25zdCBzdHJ1Y3Qgc2ZkcF9wYXJhbWV0ZXJfaGVhZGVyDQo+Pj4gKmJmcHRfaGVh
ZGVyLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHNm
ZHBfYmZwdCAqYmZwdCkNCj4+PiArew0KPj4+ICsgICAgICAgbm9yLT5mbGFncyAmPSB+U05PUl9G
X0hBU18xNkJJVF9TUjsNCj4+PiArICAgICAgIHJldHVybiAwOw0KPj4+ICt9DQo+Pj4gKw0KPj4+
ICtzdGF0aWMgc3RydWN0IHNwaV9ub3JfZml4dXBzIG10MjVxdTUxMmFfZml4dXBzID0gew0KPj4+
ICsgICAgICAgLnBvc3RfYmZwdCA9IG10MjVxdTUxMmFfcG9zdF9iZnB0X2ZpeHVwLA0KPj4+ICt9
Ow0KPj4+ICsNCj4+PiAgICBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gc3Rfbm9yX3Bh
cnRzW10gPSB7DQo+Pj4gICAgICAgICAgIHsNCj4+PiAgICAgICAgICAgICAgICAgICAubmFtZSA9
ICJtMjVwMDUtbm9uamVkZWMiLA0KPj4+IEBAIC00MDUsMTAgKzQxNywxMCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGZsYXNoX2luZm8gc3Rfbm9yX3BhcnRzW10gPSB7DQo+Pj4gICAgICAgICAgIH0s
IHsNCj4+PiAgICAgICAgICAgICAgICAgICAuaWQgPSBTTk9SX0lEKDB4MjAsIDB4YmIsIDB4MjAs
IDB4MTAsIDB4NDQsIDB4MDApLA0KPj4+ICAgICAgICAgICAgICAgICAgIC5uYW1lID0gIm10MjVx
dTUxMmEiLA0KPj4+IC0gICAgICAgICAgICAgICAuc2l6ZSA9IFNaXzY0TSwNCj4+PiAtICAgICAg
ICAgICAgICAgLm5vX3NmZHBfZmxhZ3MgPSBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfA0K
Pj4+IFNQSV9OT1JfUVVBRF9SRUFELA0KPj4+IC0gICAgICAgICAgICAgICAuZml4dXBfZmxhZ3Mg
PSBTUElfTk9SXzRCX09QQ09ERVMsDQo+Pj4gKyAgICAgICAgICAgICAgIC5mbGFncyA9IFNQSV9O
T1JfSEFTX0xPQ0sgfCBTUElfTk9SX0hBU19UQiB8DQo+Pj4gU1BJX05PUl80QklUX0JQIHwNCj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgU1BJX05PUl9CUDNfU1JfQklUNiwNCj4+PiAgICAg
ICAgICAgICAgICAgICAubWZyX2ZsYWdzID0gVVNFX0ZTUiwNCj4+PiArICAgICAgICAgICAgICAg
LmZpeHVwcyA9ICZtdDI1cXU1MTJhX2ZpeHVwcywNCj4+PiAgICAgICAgICAgfSwgew0KPj4+ICAg
ICAgICAgICAgICAgICAgIC5pZCA9IFNOT1JfSUQoMHgyMCwgMHhiYiwgMHgyMCksDQo+Pj4gICAg
ICAgICAgICAgICAgICAgLm5hbWUgPSAibjI1cTUxMmEiLA0KPj4+DQo+Pj4gY3V0DQo+Pg0KPj4N
Cj4+IFRoYW5rcy4gWWVzLCB0aGlzIHBvc3QgIEJGUFQgZml4dXAgcmVzb2x2ZXMgbG9jay91bmxv
Y2sgaXNzdWUgYW5kDQo+PiBJIGRvbid0IHNlZSBIQVNfMTZCSVRfU1IgZmxhZyBpbiBwYXJhbXMu
DQo+IA0KPiBHb29kLiBQbGVhc2Ugc2VuZCBzb21lIHBhdGNoZXMgYWRkcmVzc2luZyBhbGwgdGhh
dCB3ZSBkaXNjdXNzZWQgdW50aWwgbm93Lg0KDQp2MzogDQpodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3Byb2plY3QvbGludXgtbXRkL3BhdGNoLzZiODlhZTRlNGQ3YTM4MTA1MDc0NjQ1OGNi
MDAwY2QzYzYwZjdhNDIuMTY5Njg0OTQyMy5naXQubWFtdGEuc2h1a2xhQGxlaWNhLWdlb3N5c3Rl
bXMuY29tLyANCg0KDQo+Pg0KPj4gRGF0YXNoZWV0IGlzIHB1YmxpYzoNCj4+IGh0dHBzOi8vbWVk
aWEtd3d3Lm1pY3Jvbi5jb20vLS9tZWRpYS9jbGllbnQvZ2xvYmFsL2RvY3VtZW50cy9wcm9kdWN0
cy9kYXRhLXNoZWV0L25vci1mbGFzaC9zZXJpYWwtbm9yL210MjVxL2RpZS1yZXYtYi9tdDI1cV9x
bGt0X3VfNTEyX2FiYl8wLnBkZj9yZXY9YjI1OWFhZGMzYmVhNDllYTgyMTBhNDFjOWFkNTgyMTEg
DQo+Pg0KPiBJJ2xsIHRha2UgYSBsb29rIGxhdGVyIHRvZGF5Lg0KPiANCj4gQ2hlZXJzLA0KPiB0
YQ0KPj4NCj4+Pj4gSWYgeWVzLCBwbGVhc2UgYWRkIHNvbWUgcHJpbnRzIGluIHNmZHAuYyB0byBk
ZXRlcm1pbmUgd2hlcmUgaXQncyBzZXQsDQo+Pj4+IGVpdGhlciBpbiBCRlBUX0RXT1JEMTVfUUVS
X1NSMl9CSVQxIG9yIEJGUFRfRFdPUkQxNV9RRVJfU1IyX0JJVDFfTk9fUkQNCj4+Pj4gSXMgdGhl
IGRhdGFzaGVldCBmb3IgdGhpcyBmbGFzaCBwdWJsaWM/IFdvdWxkIHlvdSBzZW5kIG1lIGEgbGlu
ayB0byBpdA0KPj4+PiBwbGVhc2U/DQo+Pj4+DQo+Pj4+IENoZWVycywNCj4+Pj4gdGENCg==
