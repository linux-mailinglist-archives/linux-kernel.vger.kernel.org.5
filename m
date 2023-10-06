Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CDB7BBAC3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjJFOsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJFOsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:48:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937BFEB;
        Fri,  6 Oct 2023 07:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRrdh2++ir7SeVnadmEcp+QTfkmhr4ASOuYl7GRZYguFGuYLa4gr8txr6+LvdMyqPwVWkZ3KtSvMhBo9CH7pgzfOVOwM9GqKEZMI0b85/fDoIl+w5EDxnSUjb+WX/DUulRDq0YNdVcTeMBPs2oZpGmy2zhtPebKURFa7ObjtX2KVHj9feWLmORqcqCulvkaxJTDt7cIcHsKKiHstRpzhdeZ4dcgT5J7ATNcrJnr9gGfzCFZz0th/6tRf+0yzSotwZ6rXOA+Lp4oG1U8wCLiAs3q6szFeilVgx1ZVTFbj4pueXrNqOooviFdWlrL+rBun1nVlt6j6tQSruoCtD1qAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw3gARtzldkmDHTCSJxbG3CsN0sb370WJM4XEqanYfg=;
 b=PbHvYDbh6KBIfY/14dvTbkHeQtUvM6lXs80ChwPNd/zdIgkSy7p3b2kctmJpCdI/gFt9gfM/7S+1AWq3pcCRTyUX706EZz33+UrvLF2lhewRvQVnf9YPiNBoUwyjOXQdGAVTWzJ0mr6oRz2GeLunloVbfH1X6JG/i2FdlDlvOHBZyw2So6QBOACRpu3r5ilm5eI7cP8MUvQMLbffm8e90G+0VoXWV4xSDiqj0BRIufVurTOtv3i1xPjrAeY2is8b/OSB/eA9JIdUnS7LAarnvVUfUkk4aFbZ4XNw+hcIeVhoCNa/sWAzodA6TsdbG3uLwpdAdHDn6zPtze1oAag1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw3gARtzldkmDHTCSJxbG3CsN0sb370WJM4XEqanYfg=;
 b=V8iRXM3nKK5gEoFzq/gCIfOtcnKKMxp0ixbb3doMUilNVasg/63uaMRIZp6RHNaSduPNTfu1pJsK+K7VKMQ5KeeQcXe7kH8qQeVUZ/g78cq47s/9MgEez4Wo3+jF8rkfIdbmJZDL+dAjOBvnLAgCtECKW4hMA5qmJdsgYuTGUrc=
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 (2603:10a6:102:34f::18) by AM7PR02MB5880.eurprd02.prod.outlook.com
 (2603:10a6:20b:105::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Fri, 6 Oct
 2023 14:48:29 +0000
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::ae8a:f8e:f622:d3db]) by PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::ae8a:f8e:f622:d3db%7]) with mapi id 15.20.6813.027; Fri, 6 Oct 2023
 14:48:29 +0000
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dlechner@baylibre.com" <dlechner@baylibre.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "pmolloy@baylibre.com" <pmolloy@baylibre.com>,
        Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "ahaslam@baylibre.com" <ahaslam@baylibre.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "david@lechnology.com" <david@lechnology.com>
Subject: Re: [PATCH v3 02/27] staging: iio: resolver: ad2s1210: fix use before
 initialization
Thread-Topic: [PATCH v3 02/27] staging: iio: resolver: ad2s1210: fix use
 before initialization
Thread-Index: AQHZ8vompzcVhoIKeUmsbI5b9X9YFrA2KPSAgAATrwCABqW9AA==
Date:   Fri, 6 Oct 2023 14:48:29 +0000
Message-ID: <de527e3f87effe7e446b44d84e43aead26f9fdec.camel@axis.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
         <20230929-ad2s1210-mainline-v3-2-fa4364281745@baylibre.com>
         <1b366292-6e05-421e-914e-6d3457886238@kadam.mountain>
         <20231002101742.0000774b@Huawei.com>
In-Reply-To: <20231002101742.0000774b@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|AM7PR02MB5880:EE_
x-ms-office365-filtering-correlation-id: a416887a-c38c-46b5-04df-08dbc67b4dee
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s0DetQlzpqG6AhBQjYNZjiixTygZZAjiT0UcxaAhLkie5HbVRVVrsmiuV/M7SuhoXn7p0YeN4/jVdFTCgnxNtekrXfx7u2njQ25mBZqn5TUa+TA3dzLtJKJ4azfnepg/zUJZVSzigzIV1mWLER+jXyryKOGY2kBjpKqAoQulhIUgMLexYLsutHCsj4Nb9IXgH5Avxv9IFx4vwm8z3fYRQ3FaHoFU2MqQ7+ZFgYPB1/sgwnXfNI4vWwuWUjAVPSgfU2kwStaehIol3Z8ZJ1BAoTnMYBtgG1WmmOtlezPDT71T3ghaNb3Jpp+a1OPB1K65rAGztQ3nYaCCCsSlKKbe1pL7EC26yUUK+vvGwes/1Qh6DA5nA+mKF/NEf9bGYZbmad2ySyZHL95guegsdfO/Gf5QrmunE0+/+LyXkVgz9puEDJ2KpDFpuM9wPGUg7y1JV21m3I4OWfyl3JSZzebLg28c8hrfj2f7A70HW3KJtMNSZAWflTVbwldqVnETFJes0URa/r/GHOeGJX+ZnQnLckOqYwtDBa6W914O3rmi8MQMIz39JENCD++6lo8+3E4VZ4kBaV2f/1bkxbpCyJrzyeMr5f7umYSAdpFFMMS4IAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(86362001)(36756003)(66899024)(7416002)(6506007)(66446008)(6486002)(6512007)(76116006)(91956017)(41300700001)(110136005)(66946007)(66476007)(66556008)(8676002)(71200400001)(122000001)(316002)(8936002)(2616005)(5660300002)(26005)(64756008)(4326008)(966005)(54906003)(2906002)(38100700002)(38070700005)(83380400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzFtWnFwZ1NOYm1tdjgvUXVnRjgxTmpCb1dsYUR5dktQdVh6YmV3TU5JUnly?=
 =?utf-8?B?ZVRWS1c4bXI1TE8wRm9sOGJnYTFzSkRTZ1J2NndnVWlVUXoxM29RKzZmRmQw?=
 =?utf-8?B?Zjd3VzdXSnM2cThDWlF3bmVYc05TWUk0ajJVUDhhVHJwTmVJMENuRjdFU2dM?=
 =?utf-8?B?M3VSQVFvMFJBSURFRnQyMFhVZmlDdnRpdktjYk5VNlVFYnIxUHhXaWgySlpT?=
 =?utf-8?B?eEYxYVQ5b3oxSUVEUnRyN1cxa3pjNi94cnFwdVU5VEhwVVRlZ0ZWQnJxWVl4?=
 =?utf-8?B?NkQza0F1aVI0L1VoS2s0OE0xNTMxVWpMVGNUVmQzK0d5Y2U4eENkN1ZCcWQw?=
 =?utf-8?B?dFp2MXZocXNFekRKUDdDRzFwU2VkWklVOUduL1NPck5wV1V3VHFnN1dvdWQy?=
 =?utf-8?B?eHRuSTJtZGJrcytpdERWVUFrdE55VUNobmIwM3g4S1dRRDE5OHV4Zy9CVlNr?=
 =?utf-8?B?cGlaTFJVUHFkbVZodFNIanVHY1hTUUNkeHk2anVWeWtaSEFvcHlJRnNUNWNh?=
 =?utf-8?B?SXZqZUluSG50eVhERTkrdFdDMXpqK3pVZy9lRjZyY01yL2ZyWmsxaWhaZG1Q?=
 =?utf-8?B?ZVRMa3BLdk9EemRiNEtwS3pzTS9ZbDcxdm9vTUVoaDcyczRIUmJkSjNxa05u?=
 =?utf-8?B?S2g4Z285N2U5bnIvUnF0Ni9VME43MW1MZit3eTRpLzFzZUhTazVaenhIYnZl?=
 =?utf-8?B?Z1N6YmI2VUlncEZibzh4U21KaXZCaVQ2SUFDQTdpTnpIamRicjNnQkljQXla?=
 =?utf-8?B?dlFxZnBCRXZRR2VRMUVPZ2hlYnNwQWZYL1lDT1ByNXMyMldIQTRPdDhEcVdq?=
 =?utf-8?B?SVc4aEJVNVg2WmMxUytMazd4L2E1NDVoWXlERUkwY2tDUU9YNUlacDRiTnNr?=
 =?utf-8?B?aTFBbEZDL2MyN2VYM2VaM2N3ZExHd0RreTBtSHZ5M0lkUk9jUEdxM3NFcnV3?=
 =?utf-8?B?VTMwNkpvVzJ0VFpsRHVsSlQrMm11SWhQcUJwa2tRSmlabG1zRm9oL1BrZEhk?=
 =?utf-8?B?azlqRm1CWGFKV2FkZ29KalN6aUdRMXc0Y21NT2NrckdBTUdhUTZHN29jTDBh?=
 =?utf-8?B?RDM5TTY1T0E4NnhkYUtjOE1PalorU3FqVStQdDlYSytIdklVS0w4TzE1S0JF?=
 =?utf-8?B?MTFzWldyWFVLbUNOcER4N0tCRmFIeHRuKzhsaXdpc1NvWmZmTVo1ejJ0RTlh?=
 =?utf-8?B?amVnRlBqR3FvM1dSN2RHVlpjOFFUSzl1aytFcnNkRmZPVjJjQWRHY1dUNlFR?=
 =?utf-8?B?R1JaYzZVL0xqOXE4YW1iOXhVQWNONzVjQnROR3JqTi9vb21OYkpOVUpjYm1h?=
 =?utf-8?B?UG5sYXVsVm9aSlhvUzVGQktDTXpmVEIwbWhMNHJrUkswTjlqd21EZXViYjlZ?=
 =?utf-8?B?aXNvbUVjSGZacFJ3Y2ZkbnYvZFhNSnI1ZDZXSjgxQythZGhPd2dNQkJseDJ4?=
 =?utf-8?B?NEprSWFyb0JQM0hjdHZyYmlkR0Y4NXRrV1VaREhkN2F0dXd6anlWdEZEL3Rw?=
 =?utf-8?B?WHFXRU9NOHBCYWdIWHJXVTVodDQzc2FwVklQZXppaDZxSkl3MFI3M1M1ZGkr?=
 =?utf-8?B?OW9UOUNZSEJSbDErekxOa3hKYXgvYWNkL056ZHBRcmR2aklUM25ZNTlkTFFU?=
 =?utf-8?B?ei9qRERaMGJGOUVZK0JyNFMwUVJjRExwUHBTUUtPOFVJM3lIQ2wyd2ttZEFq?=
 =?utf-8?B?a1Vidzh1dkswUkZjZmVqVDhia0RjUVkxanAvWG1xcGhHdG1FRStxb2UrQ2U3?=
 =?utf-8?B?aGVJekV6YUZGdnhob1R5NC8zMUR4a0x6aTdKcUEwT3ZBWklIV0U2Y1VHNUIr?=
 =?utf-8?B?SGwyQjRaTytacGNBNEYwaWVGOE9iSkM2akVqeUYvK0dWTlFGelYwMjdqV2Vn?=
 =?utf-8?B?dXk3MURSbUxPd25MTVJDK2xlOThlaVJYRmp3MURXV3ZFQTJMMGFOT2ZLMERq?=
 =?utf-8?B?VkdYeUdLekxUek5BOU9EakdoRnNuTkpCSTFmT09PcW9BYnRoWENMdFQ5ZFVM?=
 =?utf-8?B?Mjl3WDZ1eFlCODl0aHlqUkN2TkFuWHRVdWJFYU5aQUVoSUhsbDkrVzJjWlNv?=
 =?utf-8?B?VkVoY3k4T3BGeXE1Y0JRMmdDZjlUbUl4YXg5cFJTWkhNdkx5UFhIRTM4UzJP?=
 =?utf-8?Q?OX+ul3JRCJxVOEXd1SpAETRBN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1226D041471BB54185E74A007FE7EF44@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a416887a-c38c-46b5-04df-08dbc67b4dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 14:48:29.3234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iFAcWvcsBdMhUSET/J41lrhf+PWlegVaH8uVRJmnHgbn1AOFrdcE94pkzFZOh/x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5880
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTAyIGF0IDEwOjE3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBIbW0uIFdoYXQgaGFwcGVuZWQgdG8gcm9hZHRlc3Q/ICBJIHdhcyBob3BpbmcgdGhhdCB3
b3VsZCBzb2x2ZSB0aGlzIHNvcnQNCj4gb2YgaXNzdWUgYnkgYWxsb3dpbmcgc2ltcGxlIHRlc3Rp
bmcgb2YgYmFzaWMgZnVuY3Rpb25hbGl0eS4uLg0KDQpSb2FkdGVzdCBpcyBhbGl2ZSBhbmQgd2Vs
bC4gIFNldmVyYWwgb2YgbXkgY293b3JrZXJzIGhhdmUgYmVlbiB1c2luZyBpdA0KZm9yIGRldmVs
b3BtZW50IGFuZCB0ZXN0aW5nIG9mIG5ldyBkcml2ZXJzWzBdWzFdWzJdWzNdWzRdIGFuZA0KcGF0
Y2hlc1s1XVs2XSwgYW5kIHRoaXMgaGFzIHJlc3VsdGVkIGluIGVhc2llciB0ZXN0aW5nIGFuZCBy
ZWZhY3RvcmluZw0KZHVyaW5nIGRldmVsb3BtZW50LCBtb3JlIHJvYnVzdCBjb2RlLCBhbmQgb2Yg
Y291cnNlIHRoZSBhYmlsaXR5IHRvDQplYXNpbHkgZGV0ZWN0IHJlZ3Jlc3Npb25zIGFmdGVyIHRo
ZSBwYXRjaGVzIGFyZSBtZXJnZWQuDQoNClswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMjMwMzIzLWFkZC1vcHQ0MDAxLWRyaXZlci12Mi0yLTBiYWUwMzk4NjY5ZEBheGlzLmNvbS8N
ClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2QyMThhMWJjNzU0MDJiNWViZDZlMTJh
NTYzZjczMTVmODNmZTk2NmMuMTY4OTc1MzA3Ni5naXQud2FxYXIuaGFtZWVkQGF4aXMuY29tLw0K
WzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvN2I4NTZiNzRjNGMwZjhjNmM1MzlkN2M2
OTIwNTFjOTIwM2IxMDNjMC4xNjkyNjk5OTMxLmdpdC53YXFhci5oYW1lZWRAYXhpcy5jb20vDQpb
M10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMTAwMi1yeDgxMTEtYWRkLXRpbWVz
dGFtcDAtdjEtMS0zNTM3MjdjZjdmMTRAYXhpcy5jb20vDQpbNF0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDIzMDUwMi10cHM2Mjg3eC1kcml2ZXItdjMtMi1lMjUxNDBhMDIzZjVAYXhp
cy5jb20vDQpbNV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMTAxMjEwMjM0Ny4x
NTMyMDEtMS1jaGVuaHVpekBheGlzLmNvbS8NCls2XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzIwMjIwNDEzMTE0MDE0LjIyMDQ2MjMtMy1jYW1lbC5ndW9AYXhpcy5jb20vDQoNCkluIGZh
Y3QsIGJ5IHJ1bm5pbmcgb3VyIHJvYWR0ZXN0cyBvbiBuZXdlciBrZXJuZWxzIHdlIGhhdmUgZm91
bmQNCm51bWVyb3VzIGJ1Z3NbMTBdWzEyXVsxNF0gYW5kIHJlZ3Jlc3Npb25zWzddWzhdWzldWzEx
XVsxNV0gaW4gbWFpbmxpbmUsDQppbmNsdWRpbmcgc3Vic3lzdGVtLWxldmVsIGlzc3VlcyBhZmZl
Y3Rpbmcgb3RoZXIgZHJpdmVycyB0b28uDQoNCls3XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzIwMjMwOTExLXJlZ3VsYXRvci12b2x0YWdlLXNlbC12MS0xLTg4NmViMWFkZThkOEBheGlz
LmNvbS8NCls4XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwOTE4LXBvd2VyLXVh
Zi12MS0xLTczYzM5NzE3OGM0MkBheGlzLmNvbS8NCls5XSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMjMwODI5LXRwcy12b2x0YWdlcy12MS0xLTdiYTRmOTU4YTE5NEBheGlzLmNvbS8N
ClsxMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDYxMy1nZW5pcnEtbmVzdGVk
LXYzLTEtYWU1ODIyMTE0M2ViQGF4aXMuY29tLw0KWzExXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMjIwNTAzMTE0MzMzLjQ1NjQ3Ni0xLWNhbWVsLmd1b0BheGlzLmNvbS8NClsxMl0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaWlvLzIwMjIwODE2MDgwODI4LjEyMTg2Njct
MS12aW5jZW50LndoaXRjaHVyY2hAYXhpcy5jb20vDQpbMTNdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWlpby8yMDIyMDUxOTA5MTkyNS4xMDUzODk3LTEtdmluY2VudC53aGl0Y2h1cmNo
QGF4aXMuY29tLw0KWzE0XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1paW8vMjAyMjA2
MjAxNDQyMzEuR0EyMzM0NUBheGlzLmNvbS8NClsxNV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtc3BpL1l4Qlg0YlhHMDJFNGxTVVdAYXhpcy5jb20vDQoNCihUaGUgYWJvdmUgbGlzdHMg
YXJlIG5vdCBleGhhdXN0aXZlLikNCg0KPiBIb3BlIGl0IGlzIHN0aWxsIGhlYWRlZCBmb3IgYSBu
ZXcgdmVyc2lvbiAvIHVwc3RyZWFtIQ0KDQpJIHB1c2hlZCBvdXQgYW4gdXBkYXRlIHdpdGggYSBz
cXVhc2ggb2YgKG1vc3QgcGFydHMgb2YpIG91ciBpbnRlcm5hbA0KdmVyc2lvbiBvdXQgdG8gdGhl
IGZvbGxvd2luZyByZXBvLCBpdCdzIGJhc2VkIG9uIHY2LjYtcmM0Lg0KDQogIGh0dHBzOi8vZ2l0
aHViLmNvbS92d2F4L2xpbnV4L3RyZWUvcm9hZHRlc3QvZGV2ZWwNCg0KKFRoZXJlIGFyZSBjdXJy
ZW50bHkgNiBsaW5lcyBvZiAtLWRpZmYtZmlsdGVyPU0gYWdhaW5zdCB2Ni42LXJjNCBvbiB0aGUN
CiBsaW5rZWQgcmVwby4gIFR3byBvZiB0aG9zZSBhcmUgZnJvbSBhIHBhdGNoIHdoaWNoIGlzIHBv
c3RlZCBhbmQgd2FpdGluZw0KIGZvciByZXZpZXcgb24gdGhlIGxpc3RzLCBhbmQgdGhlIHJlc3Qg
YXJlIGZvciBlbmFibGluZyByZWdtYXAgZGVidWdmcw0KIHdyaXRlcyB3aGljaCBhcmUgdXNlZCBm
cm9tIHNvbWUgb2YgdGhlIG5ld2VyIHRlc3RzLikNCg0KU2luY2Ugcm9hZHRlc3QgaXRzZWxmIGRv
ZXMgbm90IHJlcXVpcmUgYW55IHBhdGNoZXMgdG8gdGhlIGtlcm5lbCBvciBhbnkNCm91dC1vZi10
cmVlIG1vZHVsZXMsIHRoZSBtYWludGVuYW5jZSBvZiB0aGUgZnJhbWV3b3JrIHdvdWxkIG5vdCBy
ZWFsbHkNCmJlIHNpbXBsaWZpZWQgYnkgcHV0dGluZyBpdCBpbiB0aGUgdXBzdHJlYW0gdHJlZS4g
IEhvd2V2ZXIsIHRoZXJlIGlzIG9mDQpjb3Vyc2UgYSBwb3RlbnRpYWxseSBsYXJnZSBiZW5lZml0
IHRvIHRoZSBxdWFsaXR5IG9mIG1hbnkga2luZHMgb2YNCmtlcm5lbCBkcml2ZXJzIGlmIHJvYWR0
ZXN0IGdldHMgdXNlZCBieSBvdGhlcnMsIGFuZCBoYXZpbmcgaXQgaW4tdHJlZQ0KY291bGQgZmFj
aWxpdGF0ZSB0aGF0LiAgQW5kIGl0IHdvdWxkIHBvdGVudGlhbGx5IGFsbG93IHJlZ3Jlc3Npb25z
IGxpa2UNCnRoZSBvbmVzIHdlJ3JlIGZpbmRpbmcgdG8gYmUgY2F1Z2h0IF9iZWZvcmVfIHRoZXkg
Z28gaW4sIHNpbmNlIGFueW9uZQ0KY2FuIHJ1biB0aGUgdGVzdHMgd2l0aG91dCBzcGVjaWFsIGhh
cmR3YXJlLg0KDQpUaGUgaWRlYSBvZiBoYXZpbmcgdG8gbWFpbnRhaW4gaXQgaW4tdHJlZSBhbmQg
ZG9pbmcgYWxsIHRoZSB3b3JrIHRoYXQNCmdvZXMgYWxvbmcgd2l0aCB0aGF0IChkZWFsaW5nIHdp
dGggdGhlIGV4cGVjdGF0aW9ucyBvZiBtYWludGFpbmVycywNCndyYW5nbGluZyBwYXRjaGVzIGZy
b20gbWFpbGluZyBsaXN0cywgZXRjKSwgaXMgc29tZXRoaW5nIEkgcGVyc29uYWxseQ0KaGF2ZSBo
YWQgYSBoYXJkIHRpbWUgd2FybWluZyB1cCB0bywgYnV0IEkgaGF2ZSBzb21lIGNvd29ya2VycyB3
aG8gbWF5DQpwb3RlbnRpYWxseSBiZSBpbnRlcmVzdGVkIGluIHRoYXQga2luZCBvZiB3b3JrLCBz
byBJIHdvdWxkbid0IHJ1bGUgb3V0DQphbm90aGVyIHBvc3Rpbmcgb2YgdGhlIHBhdGNoIHNldCB0
YXJnZXRpbmcgdXBzdHJlYW0gc29tZXRpbWUgaW4gdGhlDQpmdXR1cmUuDQo=
