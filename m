Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAB7CF574
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjJSKf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjJSKfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:35:54 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D0011F;
        Thu, 19 Oct 2023 03:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i130iI1Z+r5f1T2dAwlxR5qKWDRf8AJBw7Wga7kKHcoe7/VNr3TkbreRTVEZgmvkk30VX4VjkTbuqs97EV+xKqG5LvbA5sDJUUVmctMQ3+hN+Zfc8GAkkqEIuEHFkhEEUUBMkXLrptHfJj201fkrHtHUUl+0eqSiv+3MvjX+4KBe3ARaAdufrdk7u84aZPcDlf60JyXCBbUzLKxaQqRSphfyTvf80/Zr63Iyy4Wm7vALvu6MqXdoNS+znw/H3fghCxBb8kfllHNPpry6gx7Tw8eRVHSWjQhKTOP4B1sO5XhujOgJMvdNW3Rp/5K5hQVwMRPd47kevj7BKg7cKOCY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36opOIJYwITzYF2tJLhaDapxVhGUNt/oJQquQlUlrho=;
 b=ERK+eeTM36tudoZ1a04SqNnjfu37nUOTgQ4KqOljYHg+B7R4kC9e19YekIMQofqYCzxeuMpQEuiHYJM/4MYHr79XPzHzWJl7UiDhsFRqI8r9bDVO0ZOungV2L206eWvzHWuIBHnGh2HRp77E5jZEaloTTxp2J936ABs9xavKeZ2zLFrP5gBCUpEGFdePxAaTdacvtJ8t082qnER46TZFMIZOg7Sa4mRLtEBhIh3DzQwWJM9v5bKa0C1GsSiPS/Zg8njfZCDGUEO8npZ+Q2BUlfos+pXSkuO9r1hPJMWa8CfCtvIbKZjVRtSgwITF1gjss8hkjOQEqLNFq2DPGoDl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36opOIJYwITzYF2tJLhaDapxVhGUNt/oJQquQlUlrho=;
 b=eOpcmu14dktKYWDnxI8bFUZEYRLHVx9afLO5XwEMnuPSsqBzewEpzAXoyPUdp1q8wSds6pgFiHBl9snlD/Gc9iuNy+YIjiOUYV4OJjfChKWuCiOCOipp/+dMnPj5SHBOkNWAI8aXnisSbaxypqrnbrAzf9sJJ889URhBrqAJ5y4=
Received: from BYAPR12MB3207.namprd12.prod.outlook.com (2603:10b6:a03:135::10)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 10:35:49 +0000
Received: from BYAPR12MB3207.namprd12.prod.outlook.com
 ([fe80::7898:321:2239:77b9]) by BYAPR12MB3207.namprd12.prod.outlook.com
 ([fe80::7898:321:2239:77b9%2]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 10:35:49 +0000
From:   "Kundanala, Praveen Teja" <praveen.teja.kundanala@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/5] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt
 to yaml
Thread-Topic: [PATCH V2 2/5] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt
 to yaml
Thread-Index: AQHaAlKPkRTsPUGct0eXlmbW/JBa+7BQ2CyAgAASlCA=
Date:   Thu, 19 Oct 2023 10:35:49 +0000
Message-ID: <BYAPR12MB3207AF897D31347BE69FD7B2CBD4A@BYAPR12MB3207.namprd12.prod.outlook.com>
References: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
 <20231019060651.23341-3-praveen.teja.kundanala@amd.com>
 <aac1b716-c4f6-46e8-88f6-e5aad5bca870@linaro.org>
In-Reply-To: <aac1b716-c4f6-46e8-88f6-e5aad5bca870@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b54704dc-0718-42f4-9197-0882a8be7ff0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T10:33:28Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3207:EE_|DM4PR12MB5278:EE_
x-ms-office365-filtering-correlation-id: 1b334797-b68d-48bd-ed9a-08dbd08f295b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+pTMzDsZEs8JhJeNFqD2pl3g5cCud+RrMi+q5vfjeSO+2D/CL8jV3UBuCSFNN0DDFu/jbUTm5sK/WTTOfjgyIxX7xNhGW3EEDxKj5ZOSWcuFUIBkPYcAg+Kdl/M58GdsjMAtqaV5EFVBmP2ZS9RJieC5DnIQ34y6Ljx727LMvjMownYT4KztfhdUlMElURkoCxc73gkUtFRlfzCYlKQ2t73MU01f/e73egDGKOLL/v+nd3fjYAjeM2Xs1YAqNb4hsqO4FcgtmjkE/gozO6J/ek9cYSnHvv/Kk0B87YugUzmtb7ipiBGtfLazBbcDJIgmWOStOc2y1O8UFKLZohYpDa6IpFWkkOwrWzEKQk+29gbmeKVQkHWLq5o9qtZ4863AHvHLmFMdU6vQuV8K6tqBSfV1Xm/Brjksbun9Sex7TqncTk/GXd+UE0haH9ex2ZlTqZR74GMiiHQqc7KbZGUouMaY8RL4RQDrxR3qkGR0f0v9T7BOPePzBI6rzteRTuQs/VsJo23Z9NSRfIkD31L9Vsb3Peg3y6sJolwZADh0my+n/vY8plb1iOI2dkxXvRTDbrXwVlVFexp9Fg6P9gpD3rX1uDSSvv0kY4uAXUQvVp0UJ55FFSsAgGmQ/PYzd7s3lZcP9V3SuEgFzvAP31Zwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(86362001)(55016003)(66476007)(66946007)(66446008)(110136005)(76116006)(66556008)(64756008)(316002)(71200400001)(966005)(478600001)(8936002)(8676002)(33656002)(5660300002)(41300700001)(52536014)(4326008)(7696005)(2906002)(6506007)(38100700002)(38070700005)(53546011)(83380400001)(26005)(122000001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzZhZVBBTG1aR1hRMFVCKzlLUHZWT2VDdnJIMCtQbnA1THNFWDNGbGMzL3Vm?=
 =?utf-8?B?TWVOT3hOc21nVERZR0oyZlFxLyt1d2wrRlNRNjRyY3FDc0ZTNVRBNGtUc3JI?=
 =?utf-8?B?U3hnbDdzUlcxL1FaaS9lYlpKdjBrL3JzRTlUajdlUE5XVUNkWllyc2FxMWJI?=
 =?utf-8?B?VER6Q0E1OUF1TVNmNVZhOGswYmtsZEFJUmtFZC8zQVYxQVMrOEpWN05Ca1Z6?=
 =?utf-8?B?Z2hkR0VLL3JMdVBoekg3SWUyOC9rdW5JOHBVbUFEcGlRZE5pNDRFaVJrditt?=
 =?utf-8?B?V2JKZkIzemRPUWduL05BQlpWT2QwS1BYU0xKeXFCZzM1R3ZhQUIrd04zR3lC?=
 =?utf-8?B?S2F4ai80M3NmaGxobGVnRi8walZFRVpSampFMElwcDUxZmw0TmtvbGxLNCts?=
 =?utf-8?B?TFZLd29RODN5eitGci9ENHFnMU5laWlER0FVLzJCRDhSZGR1dHU4K3VJN1FM?=
 =?utf-8?B?akpRa0NJQUdVT0dGcWNHZjZnN3VsSi9Ic3R5NE40c1FXdTdCKytVSDdMVUg5?=
 =?utf-8?B?bGdFQVI2aVY2OGEvd3Y0c2RiVTVwZ1hRQXlqSWZJMGFhTExHVFI3akZxZ3NT?=
 =?utf-8?B?VTBRU3RnSGpUcEFpRmIwaGxpOEFHKzB4Q3hkWW9tMkJJQ0c2YldOZk9mUTQr?=
 =?utf-8?B?dGNreCtIL2ZtVEJrNWRucS9CdUlCM2t6RE5rZXp2ZkZQeFJBZGQyN2kyVE5x?=
 =?utf-8?B?c1RNMWI5Zkl0NW41cGZ0czgvVGF4N000c0k3OW13RlpMN056cWJKQlc1eVph?=
 =?utf-8?B?SGowR0FTTWY4L2Q2OEJ5dWpKR2h5ZTdDV2ZRbm12c045aU5YRHVTcDFJYjRa?=
 =?utf-8?B?NzVCYjE2T1NTbnJ5Q1ZsLy96Tk1Db0M5UHQ0ay9ubjBsY1dBWm8xY2JXU0dH?=
 =?utf-8?B?NUN2anRSYzN2ZGUwVDBBalRuS2NWYTNBM09QbXVwZENFMDdYeVJsTkN0aEhv?=
 =?utf-8?B?L1JFRkRPM1ZkUGUyTmlpWUl6MDg5MUdtZmdVcVZaczRadXBwOEpWQ2ZJMS8y?=
 =?utf-8?B?ZmpsNVhVQm1JdGEyWFlnL2oxUHVTRlpJeDB5ejU4dmpQUTRDZVIra2tyeUpz?=
 =?utf-8?B?b2xJYkVSVmtpa1JmRlcwVi9kZ0dwa3ZXSUFvUU1MQVdFbDByTHdtUU8xUFB2?=
 =?utf-8?B?L1VER3ZuZ1RnMW5vUndycVZDdm5uZXFLLzZpUE5tNXRKTExid3QvL3FjNTM3?=
 =?utf-8?B?ZEVVV3BnckdDYVgvT2NUS2J2TDU0a3BCYlNST3ByZ3E2N0l6c21LblhzNjJI?=
 =?utf-8?B?RVZ5NkV5NklkSFhwZVhkZVlHdDZZWGNQTFdlVDloTDhSVmNvYVVEVVVhdjIr?=
 =?utf-8?B?WW9la1JzaUFSOVkwK3ZDS0JyVGpHZGtWeGZkMWlJMjVDZlFJNVZ0cWZlVjlj?=
 =?utf-8?B?UUpnQnQ2R0ZnNFZ2NmdkWTNzeDJWR3lhQ0lmZjBQOXUyWDZ6bXNKL1RZSzhz?=
 =?utf-8?B?MkFOWlBNcmFmU3VZb2dlSWF0OUVxaUk1YWhKVFFSRkYrNElmUUk2cnc5cEF4?=
 =?utf-8?B?VmFJejNWd0xSN1AxQnJoSmRld296Rm01bjZjY3pCcktJYzVVUzcxT3JUTEVT?=
 =?utf-8?B?Y2pUcmEycDgrRVpIOUF4SzMwMStTSXpRQk1TbGYycVB1UzdOSmtUVVNkVDRI?=
 =?utf-8?B?dmZKQjlFWVRoRFAwN2tiVzcyYW9qODdIdWJKbkVpT05tSnk5WXpUektlWEJv?=
 =?utf-8?B?TUdJRXZlQVBKcnh2OCtqUTdlN1JRdGR0a1lpaEwwaWdIOFVNVHRzckg2anRj?=
 =?utf-8?B?b1lhbDd0cTgrT2VJUGNoRVh4bDA4SDVZajJqSkQ0WkhzRnBqVVQzWmc4Tk5u?=
 =?utf-8?B?T0h2WlI3VStURjlSY0pKYUFtUk9uZDVuaUJFdkwyRVFZTDRHcllVcm9OTDNF?=
 =?utf-8?B?TDVzRWNBMzBHVHdZRU1KdTVhY3RpcGVGcUtzc3pacXluM0JkSjNncnBDUVZ1?=
 =?utf-8?B?VGYxRGNiK1lxcWxlL3Q1RWR0WjJSREgxbnRSeWorNFRyMEFsMC9Jay9xMXM2?=
 =?utf-8?B?UTdyUms3OTAycWNRYisrR3FTL2F3cXQrREhUcXB0MG8yV0dmWjR4Z3c3alJ0?=
 =?utf-8?B?MnZyM0c2c25SOTRncjYzMWFSK2EvaCtuNnJzVTc5TERwSS95OGpBUmZ3UXAw?=
 =?utf-8?Q?lLEM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b334797-b68d-48bd-ed9a-08dbd08f295b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 10:35:49.5376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfwPJNqGN/x1LOl4UgalhS0TwIzjf/4zIzO5jwxtoyuJipdv7cH+oUYPWgjFKbOyg35ZqNppR/2RFuzpwG9QTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEtvemxvd3NraSwNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVy
IDE5LCAyMDIzIDI6NTcgUE0NCj4gVG86IEt1bmRhbmFsYSwgUHJhdmVlbiBUZWphIDxwcmF2ZWVu
LnRlamEua3VuZGFuYWxhQGFtZC5jb20+Ow0KPiBzcmluaXZhcy5rYW5kYWdhdGxhQGxpbmFyby5v
cmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8u
b3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2ltZWtA
YW1kLmNvbT47IEt1bmRhbmFsYSwgUHJhdmVlbiBUZWphDQo+IDxwcmF2ZWVuLnRlamEua3VuZGFu
YWxhQGFtZC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBr
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDIvNV0gZHQtYmluZGluZ3M6IG52bWVtOiBD
b252ZXJ0IHhsbngsenlucW1wLQ0KPiBudm1lbS50eHQgdG8geWFtbA0KPg0KPiBDYXV0aW9uOiBU
aGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Bl
ciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9y
IHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIDE5LzEwLzIwMjMgMDg6MDYsIFByYXZlZW4gVGVqYSBL
dW5kYW5hbGEgd3JvdGU6DQo+ID4gQ29udmVydCB0aGUgeGxueCx6eW5xbXAtbnZtZW0udHh0IHRv
IHlhbWwuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmF2ZWVuIFRlamEgS3VuZGFuYWxhIDxw
cmF2ZWVuLnRlamEua3VuZGFuYWxhQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5n
cy9udm1lbS94bG54LHp5bnFtcC1udm1lbS50eHQgICAgICB8IDQ2IC0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiAgLi4uL2JpbmRpbmdzL252bWVtL3hsbngsenlucW1wLW52bWVtLnlhbWwgICAgIHwg
NDAgKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMo
KyksIDQ2IGRlbGV0aW9ucygtKSAgZGVsZXRlIG1vZGUNCj4gPiAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL3hsbngsenlucW1wLQ0KPiBudm1lbS50eHQNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL252bWVtL3hsbngsenlucW1wLW52bWVtLnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4g
PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS94bG54LHp5bnFtcC1u
dm1lbS50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS94
bG54LHp5bnFtcC1udm1lbS50eHQNCj4gPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBp
bmRleCA0ODgxNTYxYjNhMDIuLjAwMDAwMDAwMDAwMA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS94bG54LHp5bnFtcC1udm1lbS50eHQNCj4gPiArKysg
L2Rldi9udWxsDQo+ID4gQEAgLTEsNDYgKzAsMCBAQA0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAt
LS0tLSAtPSAgWnlucSBVbHRyYVNjYWxlKyBNUFNvQyBudm1lbSBmaXJtd2FyZSBkcml2ZXIgYmlu
ZGluZyA9DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IC0tLS0tIC1UaGUgbnZtZW1fZmlybXdhcmUg
bm9kZSBwcm92aWRlcyBhY2Nlc3MgdG8gdGhlIGhhcmR3YXJlIHJlbGF0ZWQNCj4gPiBkYXRhIC1s
aWtlIHNvYyByZXZpc2lvbiwgSURDT0RFLi4uIGV0YywgQnkgdXNpbmcgdGhlIGZpcm13YXJlDQo+
ID4gaW50ZXJmYWNlLg0KPiA+IC0NCj4gPiAtUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAtLSBj
b21wYXRpYmxlOiBzaG91bGQgYmUgInhsbngsenlucW1wLW52bWVtLWZ3Ig0KPiA+IC0NCj4gPiAt
PSBEYXRhIGNlbGxzID0NCj4gPiAtQXJlIGNoaWxkIG5vZGVzIG9mIHNpbGljb24gaWQsIGJpbmRp
bmdzIG9mIHdoaWNoIGFzIGRlc2NyaWJlZCBpbg0KPiA+IC1iaW5kaW5ncy9udm1lbS9udm1lbS50
eHQNCj4gPiAtDQo+ID4gLS0tLS0tLS0NCj4gPiAtIEV4YW1wbGUNCj4gPiAtLS0tLS0tLQ0KPiA+
IC1maXJtd2FyZSB7DQo+ID4gLSAgICAgenlucW1wX2Zpcm13YXJlOiB6eW5xbXAtZmlybXdhcmUg
ew0KPiA+IC0gICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJ4bG54LHp5bnFtcC1maXJtd2FyZSI7
DQo+ID4gLSAgICAgICAgICAgICBtZXRob2QgPSAic21jIjsNCj4gPiAtDQo+ID4gLSAgICAgICAg
ICAgICBudm1lbV9maXJtd2FyZSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGli
bGUgPSAieGxueCx6eW5xbXAtbnZtZW0tZnciOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2Vs
bHMgPSA8MT47DQo+ID4gLQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAvKiBEYXRhIGNlbGxz
ICovDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHNvY19yZXZpc2lvbjogc29jX3JldmlzaW9u
IHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4ND47DQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gLSAgICAgICAgICAgICB9Ow0KPiA+IC0g
ICAgIH07DQo+ID4gLX07DQo+ID4gLQ0KPiA+IC09IERhdGEgY29uc3VtZXJzID0NCj4gPiAtQXJl
IGRldmljZSBub2RlcyB3aGljaCBjb25zdW1lIG52bWVtIGRhdGEgY2VsbHMuDQo+ID4gLQ0KPiA+
IC1Gb3IgZXhhbXBsZToNCj4gPiAtICAgICBwY2FwIHsNCj4gPiAtICAgICAgICAgICAgIC4uLg0K
PiA+IC0NCj4gPiAtICAgICAgICAgICAgIG52bWVtLWNlbGxzID0gPCZzb2NfcmV2aXNpb24+Ow0K
PiA+IC0gICAgICAgICAgICAgbnZtZW0tY2VsbC1uYW1lcyA9ICJzb2NfcmV2aXNpb24iOw0KPiA+
IC0NCj4gPiAtICAgICAgICAgICAgIC4uLg0KPiA+IC0gICAgIH07DQo+ID4gZGlmZiAtLWdpdA0K
PiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL3hsbngsenlucW1w
LW52bWVtLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1l
bS94bG54LHp5bnFtcC1udm1lbS55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBp
bmRleCAwMDAwMDAwMDAwMDAuLjVkMjAzNjJhMDYxNQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0veGxueCx6eW5xbXAt
DQo+IG52bWVtLnlhbWwNCj4gPiBAQCAtMCwwICsxLDQwIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4g
PiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbnZtZW0veGxu
eCx6eW5xbXAtbnZtZW0ueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3Jn
L21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogWnlucSBVbHRyYVNj
YWxlKyBNUFNvQyBOb24gVm9sYXRpbGUgTWVtb3J5IGludGVyZmFjZQ0KPiA+ICsNCj4gPiArZGVz
Y3JpcHRpb246IHwNCj4gPiArICAgIFRoZSBaeW5xTVAgTVBTb0MgcHJvdmlkZXMgYWNjZXNzIHRv
IHRoZSBoYXJkd2FyZSByZWxhdGVkIGRhdGENCj4gPiArICAgIGxpa2UgU09DIHJldmlzaW9uLCBJ
RENPREUgYW5kIHNwZWNpZmljIHB1cnBvc2UgZWZ1c2VzLg0KPiA+ICsNCj4gPiArbWFpbnRhaW5l
cnM6DQo+ID4gKyAgLSBLYWx5YW5pIEFrdWxhIDxrYWx5YW5pLmFrdWxhQGFtZC5jb20+DQo+ID4g
KyAgLSBQcmF2ZWVuIFRlamEgS3VuZGFuYWxhIDxwcmF2ZWVuLnRlamEua3VuZGFuYWxhQGFtZC5j
b20+DQo+ID4gKw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6IG52bWVtLnlhbWwjDQo+ID4g
Kw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBjb25zdDog
eGxueCx6eW5xbXAtbnZtZW0tZncNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29t
cGF0aWJsZQ0KPg0KPiBUZXN0IHlvdXIgYmluZGluZ3MgYmVmb3JlIHNlbmRpbmcuIEkgYW0gbm90
IGEgZnJlZSB0ZXN0ZXIgb2YgeW91ciBjb2RlLi4uIEl0J3MgeW91cg0KPiBkdXR5Lg0KW0t1bmRh
bmFsYSwgUHJhdmVlbiBUZWphXSBNaXNzZWQgaXQgd2lsbCBzZW5kIFYzIGFmdGVyIHRlc3Rpbmcu
DQo+DQo+ID4gKw0KPiA+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+
ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIG52bWVtLWZpcm13YXJlIHsNCj4NCj4g
Tm9kZSBuYW1lcyBzaG91bGQgYmUgZ2VuZXJpYywgc28gIm52bWVtIi4gU2VlIGFsc28gYW4gZXhw
bGFuYXRpb24gYW5kIGxpc3Qgb2YNCj4gZXhhbXBsZXMgKG5vdCBleGhhdXN0aXZlKSBpbiBEVCBz
cGVjaWZpY2F0aW9uOg0KPiBodHRwczovL2RldmljZXRyZWUtc3BlY2lmaWNhdGlvbi5yZWFkdGhl
ZG9jcy5pby9lbi9sYXRlc3QvY2hhcHRlcjItZGV2aWNldHJlZS0NCj4gYmFzaWNzLmh0bWwjZ2Vu
ZXJpYy1uYW1lcy1yZWNvbW1lbmRhdGlvbg0KPg0KPiBJIGFscmVhZHkgYXNrZWQgZm9yIHRoaXMu
DQpbS3VuZGFuYWxhLCBQcmF2ZWVuIFRlamFdIFdpbGwgcmVmZXIgYW5kIHVwZGF0ZSBpdC4NCg0K
UmVnYXJkcywNClByYXZlZW4NCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
