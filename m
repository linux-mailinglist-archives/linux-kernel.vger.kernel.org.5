Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2A7BBC7B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjJFQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjJFQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:09:52 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2129.outbound.protection.outlook.com [40.107.241.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10E9E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRwHMRjlVHayaVJbF9o2pqZ7dGoN99sIKBflppElgL3j19EnFax4eR1QyY7nAHzIderKJSFIhNMHekjptCnoNIfnFeZtcmiame+br6+EBVoPserqINp0iQn3DGCu9Z+DYiVeTCul2EERodK8Rg1m9uPZUN7jgoYQA3M8VJhjuGoG1akN4mRrdyS/2XxTVgIT5MwXJX36CcEUbrk+PwoRCV490kayF1YeYJpYc93n53smOcaqx5bhfRJLQx9U2WvkH7mQHsfkPDX8TW/kx/CDBr3b3E/DpZ7oxx1YBqDRpwQqcCXcYkB75D1iebI+CvTyDJM9lZOmy/aP+6U/6bHIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NtvBGuiEMDz0YNFnRruMJr8VMV5z5RjjljC8OlGncc=;
 b=Cm6JV+1wkT4TL5OZmw0p7sgQp5w2X23+Do2P4qlFkhbY0h3H9yrzovXpzb2MP5H64pnVVJ5DZgjzaVuedwQaAbFmvM7Fg+RFzIQQH0d1CtZsRbpj88AD1AhDHYO5GI9roAZVSIm7S0tGAe7JlE5Tv8yP3rTeY1iEN5xZJiBXh5w511DFn4/VUsGrKpBncMuslNUe97PJcO4qDlMVZVDW8Nbr/0oEEtETXbCC9nk3nymqxSTKoEHNNOlrUsSASKSV3YOz8vnFC4wRuZXksriKcV4VUSTNe6uuaEkwFcGnZ5c4QCy4YCrKUtxTSOV6lSEiNEoss0qz+ZLtFC7U3vA0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NtvBGuiEMDz0YNFnRruMJr8VMV5z5RjjljC8OlGncc=;
 b=T0IikxpJK8OugMOhBob4BtYgaaTBt0NU4TYj63nwcVTJ3vW8XInjBPj8suLU4iKNZLj80lsVJOV7oGhhCh1msofB1zNfGer+2w2AdUFsbCWzSOUPK8ob3e3NMMkLhqayMatKH/2UGwMvyNH0VMpn6RoKF+p1wxcAvjmCdpNSWbI=
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com (2603:10a6:20b:1da::16)
 by DB9PR06MB7370.eurprd06.prod.outlook.com (2603:10a6:10:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 16:09:47 +0000
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::b828:856c:4735:e870]) by AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::b828:856c:4735:e870%7]) with mapi id 15.20.6838.024; Fri, 6 Oct 2023
 16:09:47 +0000
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
Thread-Index: AQHZr1hWPkDpy3UlU0qGBS67M1mV0q+3GdCAgAHeK4CAPY5YgIAvS6uAgBWqFYCAAEtqAIAACFeAgAAKcICAAUdUAIAAMwOAgAAD0ICAACfxgA==
Date:   Fri, 6 Oct 2023 16:09:47 +0000
Message-ID: <b9b7bb93-fe23-34dd-6a30-b1b0d792861f@leica-geosystems.com>
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
In-Reply-To: <bc76767e-00c1-47ca-9a27-2aa7d2a262f6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR06MB7137:EE_|DB9PR06MB7370:EE_
x-ms-office365-filtering-correlation-id: 3bcd374d-8c90-490f-ecfa-08dbc686a96c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hNFG/cJQDak6f6PaEkmhmgMOe+znLl/TKCaRubxpVbppLqi6wAJLeXO5OLD8m6QDdhrelvT4Qm/gkl8hXHHQYncmXb2hfcT7wzekWLIBWy5FlJsMhKiiBuFlnQh7uRUfa35Pmr09DqK0KKZbhUfCUnEVmiIqDutswInbVAF2SFmAL7OKO46Pgj8gEL7P69agWjanhr+kQngvfh7M4H3CL9Y3JV1aCLqv093izb5CwUT8R/neENTkMIrDa7oUIotZNHh+I8IpBFlxCtYkgU2fUCuToWyNW0l4DLmq/opgnS23qdazZwQG6b+8FF+SvzVXJlFklqQmzT7uegkX+fGtUEr/qs8VMOET2LojucHirS4NjdKCg7MnE1AZz23lDk9VFqGJ+ZJjf48f+95YR5tL/oSFLXwtNHlX7n4Iyq9y9em6RAcn6hMa5y9G/pNJ8yypCKy+vOhRGT/1gNhzFn/+aaYJxAlTcC07y1QhOq5fmXRjDkvEkSmGLJg6pdVZ0vHN9FUvzTjuYhP41DP620kyzB+RQdv1cPAFta9y5Axhv4H3DI+dsCt3ijqDOefj49C9Sq+i6JsK4BKzhFszzX1ixaf7VDP95LctcwYKqjm2FWJIQQV24OdeRSDZxbJvYS6Y/c4wg3CrNjRRozyA+U93qTpcJd0NE8rJmpgxZp/LTYo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7137.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(38070700005)(83380400001)(38100700002)(86362001)(31696002)(36756003)(122000001)(53546011)(76116006)(316002)(64756008)(6512007)(66556008)(66476007)(6506007)(66946007)(107886003)(110136005)(91956017)(41300700001)(66446008)(6486002)(966005)(2616005)(478600001)(71200400001)(31686004)(4326008)(8676002)(26005)(5660300002)(8936002)(138113003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djcyS2o3Ymt3amRtYTg5b3dtQzlmMU1sZ29RZ0l6bjhVQit0ZmJxUUpmNWdt?=
 =?utf-8?B?bGFVYUQ0YUtpQ0RkZVR1QUxYUlNOdlUrZ1BOdGU2M1VGaGNXR3JNb0dNRDYv?=
 =?utf-8?B?Qmg0STZNd1NXSlNZd3FDZ1Q3UXp6YWRFTzNXVklWWUtSaDFCQjhPVGxzY2lX?=
 =?utf-8?B?aHhvcnNoL2RYdC9KUlRpQnpRUFhVTE4ydU56ZlY0M2M4UjFSeW9pY05mWTdl?=
 =?utf-8?B?b0pycHFSVVk2T3BCY1JKdWxBZFVkQUNsb2h6WElaaUNFNzU4TnZIdTJMcnJW?=
 =?utf-8?B?SURJR0MvN0wwVm42dmtQZENSNHhnU1dKcGh1eEsydXlpTCs2L0F3OFFNRTVp?=
 =?utf-8?B?Z09HSTV6c1NubDI3akxnODBBNjNHdHRRV3RwSG5UbVFoUnp1K3JHZS91OGhR?=
 =?utf-8?B?c3V4U2NWOHdIZWRGS1B6YlVnY0duWGU0UWI4ZXdCbU9kT0dPc2MvRGNuYzVa?=
 =?utf-8?B?RUJYMTJYU05rWlorZ2NWUk9XdGJ6UVpNUncrQ3ZpNUl0cWJLU3h1WTkzeTU1?=
 =?utf-8?B?QlpWT04wajVBVVZuMFoxa1M4N0U0bnVORkphZndac0thaDhMSStyamZBdWZM?=
 =?utf-8?B?eExSczB4N0Q3ZUE2cXhhT0tBcm8yLzl4dDBwVmtrVzYrK3g3SGNoc3F5REIx?=
 =?utf-8?B?RE1OcUR5ajJOdlFSNzJwaTN4QkQ4ZUtjK2taQ1pBVlorY0c2dlFTVWVQRHpy?=
 =?utf-8?B?UTc0TSt1WUpaWWJ5MmpJcmJINi96b2NhRk10NUs0emFEejg0bUZiVDJrVjRQ?=
 =?utf-8?B?VDJIcldmdEswS01sR0RNMDNXbXp3NzlVYmZNVXFRaTFvRDM4ZXU4MEVjZWsr?=
 =?utf-8?B?cmtDcXU1ZkNFWXVEbm5VbE00U2ViTGx3SnhnUTdjTjdQVVZZaExZR3VpL29a?=
 =?utf-8?B?a2NqT3QxbmZ4aFJKbm9lK0FlSW5zSXdicHBrY2N1Z2pwajlPY25jREt0c0gy?=
 =?utf-8?B?NUlzOXNoejVpLzlIMlFFSVAzWDdWOCtHSTE0NHFVMnozRGxNMUtSYlpYeTFT?=
 =?utf-8?B?K1pYWVFLYlQ5V21wbyt4cGVNczRkOUYzSE4zUjRRMlNMNEYvV1l1Vi9jVm5U?=
 =?utf-8?B?NTFybVU4Vkg1M0ZxckJFclNLWk5sZVZaaUFsVVU1UklRcWtCM3RVK2VaZElK?=
 =?utf-8?B?WDJhOGdFZGM3KzIzUzFwcm1qMEIreXdkZmdDcC8rM0RzelFnemF2UTd0b3dl?=
 =?utf-8?B?MjJzZHIvVGRSZzlpZkpOcHpBemN5UGZ4THhXcGJkby9JN3pmeTVNbzREK2hS?=
 =?utf-8?B?djhvV1pGTlUvcW5aaTA5Wm56WmNHM1FiZUVuekpoVGkraXl6T1NrOTd1TW9y?=
 =?utf-8?B?R2ZYc0dkaHRCY05ydTY3R0xSRmZtTC9hQzN1MW96dG51eC9hc3RpS3hLc0Qw?=
 =?utf-8?B?UGV0N2VtNzd3cUN1WEJoK0d2UlN2ZXl5MXhpeHBRSEdpZkkzbzZPRkYwaWtK?=
 =?utf-8?B?WUV2NmxzZkpvU1JWS0xOcmZ3Ym1xS29qRklxT3FPT1ZxaEFIWGRraUtGUGY5?=
 =?utf-8?B?empnaFphM0hNUEZVRUtweTBkd2R4cThZanh1NklLQVMweFI2OGl3dnd5bFpq?=
 =?utf-8?B?akdVR2lMUjFVNlp6N3pNQVRMekZPUjcyczZyOTVyelJTdTUxSU13TXUwcUdK?=
 =?utf-8?B?ZEg2NHVDVmVpRG9meGdFTHdtbTFZNlg2M1BnN0Q4N3R4N3dXM0xYTWJCdko3?=
 =?utf-8?B?S2kyT0UvaExYemZCbkNMUWExcExVWFdTd0Y4MEd5T3cxTnlyV3Y1VDZqNlZN?=
 =?utf-8?B?VkpRNjNVN2Jsd3NRLzhTL3Z3RHFpckNiVWcvdVViL2dDOU9uYWpUOW9DQWU3?=
 =?utf-8?B?d3ViTEQ3R2pFZFBzMUpzR2ZqYmh3YUtjS1JJQXg5MlE0c042cjYzSzh4eFBX?=
 =?utf-8?B?eTVhZ2FKTGlBL1NNUkxWUEhEaEdNdVp6Tlc4Q0U3TG1yU1FWMUtTV1YwaEFT?=
 =?utf-8?B?Nm1pM2xvKzdXN0dYbUVWcXIwbE03dXhWeU9Eck9ibmlacVB6d2p5Y0ttcGhU?=
 =?utf-8?B?OG44OUZCSmRWZWQ0NmZlQW4vQ0lVclEvQW9uRzcxOGcrYnVMVjBETGk3TEsv?=
 =?utf-8?B?ZmF6TTkyL21kY2w0dFNzbGVmWDhrS21JOEZQd1EyamRSWDY2eG13S3gzUkhC?=
 =?utf-8?B?T0FFT25xS2FXbmFtcUh4SzVnV2JFY2YzQk51dHB2YkQ3RGNpT0dQNExyVEFS?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB8A2F4B8FBE2C418367E568C7B7AA80@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7137.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcd374d-8c90-490f-ecfa-08dbc686a96c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 16:09:47.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfA1SRNjmcAQghz/c8ieTA1gtgWzchvcaeBbRwhpXWelgxi39chSO1ycKYrlNm6HHEar8EovMHhgRMFF4XAXHrGNg8jjwSvLL9dXq0blbmsPwRtALFI2dC9A821HW9iu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7370
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkhlbGxvIFR1ZG9yLA0KDQoNCj4gT24gMTAvNi8yMyAxNDozMywgVHVkb3IgQW1iYXJ1cyB3
cm90ZToNCj4+DQo+PiBIaSwNCj4+DQo+PiBUaGFua3MgZm9yIHRoZSBkZWJ1Z2dpbmcgaW5mby4N
Cj4+DQo+PiBPbiAxMC82LzIzIDExOjMwLCBTSFVLTEEgTWFtdGEgUmFtZW5kcmEgd3JvdGU6DQo+
Pg0KPj4gY3V0DQo+Pg0KPj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4NCj4+PiBJTU8sIEhBU18xNkJJVF9TUiBmbGFnIGlzIGNh
dXNpbmcgbG9jay91bmxvY2sgZmFpbHVyZSwNCj4+PiBzaW5jZSBCUCBiaXRzIGFyZSBjYWxjdWxh
dGVkIHdyb25nIHRoZW4uDQo+Pj4NCj4+PiBJIHRlc3RlZCBhbHNvIGZvciBhIGNhc2Ugd2hlcmUg
SSBkb24ndCBwYXJzZSBTRkRQIGFuZA0KPj4+IHJldmVydGVkIHRoZSBjb25kaXRpb24gaW4gIG1p
Y3Jvbl9zdF9ub3JfZGVmYXVsdF9pbml0KCkNCj4+PiBmb3IgMTZCSVQgU3RhdHVzIFJlZ2lzdGVy
IEZsYWcuIEFuZCBsb2NrL3VubG9jayBmYWlscyB3aXRoDQo+Pj4gc2FtZSBsb2cgYXMgTm9uLXdv
cmtpbmcgY2FzZS4NCj4+Pg0KPj4+IEFuZCB0aGlzIG10MjVxdTUxMiBoYXMgOC1CSVQgU1IgYXMg
dHlwaWNhbCBtaWNyb24tc3QgZmxhc2guDQo+Pj4NCj4+DQo+PiBJbmRlZWQsIHRoZSBwcm9ibGVt
IGlzIHRoYXQgSEFTXzE2QklUX1NSIGdldHMgc2V0IHdoZW4gaXQgc2hvdWxkbid0IGhhdmUNCj4+
IHRvLiBUaGlzIG1lYW5zIHRoYXQgdGhlIEJGUFQgdGFibGUgb2YgdGhlIGZsYXNoIGlzIHdyb25n
IGFuZCB3ZSBzaG91bGQNCj4+IGZpeCB0aGUgcGFyc2VkIHNldHRpbmdzIHZpYSBhIHBvc3RfYmZw
dCBob29rLg0KPj4NCj4+IERvZXMgdGhlIGZvbGxvd2luZyBmaXggeW91ciBwcm9ibGVtPw0KPj4N
Cj4gDQo+IGhlcmUgaXQgaXMgYWdhaW4sIHRoaXMgdGltZSBjb21waWxlIHRlc3RlZDoNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+IGIvZHJpdmVy
cy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KPiBpbmRleCA0YWZjZmM1N2M4OTYuLjIwZjc2ZTI3
ODA5NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KPiAr
KysgYi9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+IEBAIC0xODAsNiArMTgwLDE4
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBtaWNyb25fbm9yX3BhcnRzW10gPSB7
DQo+ICAgICAgICAgIH0sDQo+ICAgfTsNCj4gDQo+ICtzdGF0aWMgaW50IG10MjVxdTUxMmFfcG9z
dF9iZnB0X2ZpeHVwKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3Qgc3RydWN0IHNmZHBfcGFyYW1ldGVyX2hlYWRlcg0KPiAqYmZwdF9o
ZWFkZXIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHNm
ZHBfYmZwdCAqYmZwdCkNCj4gK3sNCj4gKyAgICAgICBub3ItPmZsYWdzICY9IH5TTk9SX0ZfSEFT
XzE2QklUX1NSOw0KPiArICAgICAgIHJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgc3Ry
dWN0IHNwaV9ub3JfZml4dXBzIG10MjVxdTUxMmFfZml4dXBzID0gew0KPiArICAgICAgIC5wb3N0
X2JmcHQgPSBtdDI1cXU1MTJhX3Bvc3RfYmZwdF9maXh1cCwNCj4gK307DQo+ICsNCj4gICBzdGF0
aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gc3Rfbm9yX3BhcnRzW10gPSB7DQo+ICAgICAgICAg
IHsNCj4gICAgICAgICAgICAgICAgICAubmFtZSA9ICJtMjVwMDUtbm9uamVkZWMiLA0KPiBAQCAt
NDA1LDEwICs0MTcsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHN0X25vcl9w
YXJ0c1tdID0gew0KPiAgICAgICAgICB9LCB7DQo+ICAgICAgICAgICAgICAgICAgLmlkID0gU05P
Ul9JRCgweDIwLCAweGJiLCAweDIwLCAweDEwLCAweDQ0LCAweDAwKSwNCj4gICAgICAgICAgICAg
ICAgICAubmFtZSA9ICJtdDI1cXU1MTJhIiwNCj4gLSAgICAgICAgICAgICAgIC5zaXplID0gU1pf
NjRNLA0KPiAtICAgICAgICAgICAgICAgLm5vX3NmZHBfZmxhZ3MgPSBTRUNUXzRLIHwgU1BJX05P
Ul9EVUFMX1JFQUQgfA0KPiBTUElfTk9SX1FVQURfUkVBRCwNCj4gLSAgICAgICAgICAgICAgIC5m
aXh1cF9mbGFncyA9IFNQSV9OT1JfNEJfT1BDT0RFUywNCj4gKyAgICAgICAgICAgICAgIC5mbGFn
cyA9IFNQSV9OT1JfSEFTX0xPQ0sgfCBTUElfTk9SX0hBU19UQiB8DQo+IFNQSV9OT1JfNEJJVF9C
UCB8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX0JQM19TUl9CSVQ2LA0KPiAg
ICAgICAgICAgICAgICAgIC5tZnJfZmxhZ3MgPSBVU0VfRlNSLA0KPiArICAgICAgICAgICAgICAg
LmZpeHVwcyA9ICZtdDI1cXU1MTJhX2ZpeHVwcywNCj4gICAgICAgICAgfSwgew0KPiAgICAgICAg
ICAgICAgICAgIC5pZCA9IFNOT1JfSUQoMHgyMCwgMHhiYiwgMHgyMCksDQo+ICAgICAgICAgICAg
ICAgICAgLm5hbWUgPSAibjI1cTUxMmEiLA0KPiANCj4gY3V0DQoNCg0KVGhhbmtzLiBZZXMsIHRo
aXMgcG9zdCAgQkZQVCBmaXh1cCByZXNvbHZlcyBsb2NrL3VubG9jayBpc3N1ZSBhbmQNCkkgZG9u
J3Qgc2VlIEhBU18xNkJJVF9TUiBmbGFnIGluIHBhcmFtcy4NCg0KDQpEYXRhc2hlZXQgaXMgcHVi
bGljOiANCmh0dHBzOi8vbWVkaWEtd3d3Lm1pY3Jvbi5jb20vLS9tZWRpYS9jbGllbnQvZ2xvYmFs
L2RvY3VtZW50cy9wcm9kdWN0cy9kYXRhLXNoZWV0L25vci1mbGFzaC9zZXJpYWwtbm9yL210MjVx
L2RpZS1yZXYtYi9tdDI1cV9xbGt0X3VfNTEyX2FiYl8wLnBkZj9yZXY9YjI1OWFhZGMzYmVhNDll
YTgyMTBhNDFjOWFkNTgyMTEgDQoNCg0KPj4gSWYgeWVzLCBwbGVhc2UgYWRkIHNvbWUgcHJpbnRz
IGluIHNmZHAuYyB0byBkZXRlcm1pbmUgd2hlcmUgaXQncyBzZXQsDQo+PiBlaXRoZXIgaW4gQkZQ
VF9EV09SRDE1X1FFUl9TUjJfQklUMSBvciBCRlBUX0RXT1JEMTVfUUVSX1NSMl9CSVQxX05PX1JE
DQo+PiBJcyB0aGUgZGF0YXNoZWV0IGZvciB0aGlzIGZsYXNoIHB1YmxpYz8gV291bGQgeW91IHNl
bmQgbWUgYSBsaW5rIHRvIGl0DQo+PiBwbGVhc2U/DQo+Pg0KPj4gQ2hlZXJzLA0KPj4gdGENCg==
