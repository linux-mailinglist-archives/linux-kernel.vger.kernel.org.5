Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC04784AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjHVTqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjHVTqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:46:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639ABCD7;
        Tue, 22 Aug 2023 12:46:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld0+082V/NyaiseLr5AhmUD3+cpf6T2RAc1IRAN+FxXVaQjWiJevF8rTw3KTqE30S8Eii5wRiqnD+QhruHGL88UFApL8eienZ3I1SFi/VZ92Gi6WD8g/AFVhOfYEacx5dcL4f7K/zOPZVoVKTVHjZFZ0+esoRl1spvspDPuO2z5Yujyx9tNaY1mPez6AjQu3vEilyZfpsY8tSmJpFXF5SxKMJJW7EciJheEJ4FE9dqrxFC0qQVaoUoo7QzcrBRvuZ9gzD4If8TTCNdpL36zGMjzLe6KWJbvsNosINjxR6nzauLyFXZSMW690Qb/rhAn7OwBC3H3aRaq8tD5N19WE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC9ViGr70dzWSOiVRhZB+B6gLizPeQma8Hntwhc87iU=;
 b=eNTzoh5PMTyb90y0yUaoFYac8/VHTN8b5Ly1K/t4BnTMkL7ww6SD/aLqY5cx8ffpUP0/isnmFo1NiYO7dQ84gUrGX8KT0hFPuH3PT+6QSpxn6T/b0/uOfuZHC/1OdIgQQQZ8AdhtPsiqJioHuqKrDQn6+9lcBBuo01IrrzXyVV6PUHA87f824q5HcQtKkroNCRUvp1RbN7C4mZlSh8W4knGnCp6Wkqc1APnGyucw4FAwKahE7OT5IDIOOUFNleNXdlB2l/nal736cifYCUdu0/Vv5lHyJ8126IqO5boJJpNu2uO2hv4PViJQTyQH8pHWSU+se/rep3apsPHq06buFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC9ViGr70dzWSOiVRhZB+B6gLizPeQma8Hntwhc87iU=;
 b=a8ab8Jo/WRLzXF/iKtuMe/yFS6MpM7epwkWa0jueDtd3kX3IU4ujY1c/yWbowl46aU0dPQTP5T+rj/O0fpHFX13WJeY5qqtcMTPYxYbIkjQXd3DD3rztKDNAjdX3EO0vBRiMRphxxbUsuhi/3UTjPk3zRtycPMOQe7+aLsgf0RlAkng6wdqKmsJf5JAzG9XgiWKAVzsQzaI1oCcRkGsWs4aQjnZJbcLn4CA4v/yitRpu5mUjqFsxWXkDajfVUNu68cBY8RYIu4Y40NbDlA9DCFB31zOzvMdfG411qc6bTd9HvSG1dioGGKUMnoseRAkBiWvTV48jHFEHAAlrU8+qxQ==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 19:46:04 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::acc8:7a8:c30d:eec8]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::acc8:7a8:c30d:eec8%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 19:46:03 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Topic: [PATCH v9] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Index: AQHZ0Sb/VH9lgEX9qEK6Vlwv2yJncq/vwpQAgAAJ6ICAAAwaAIAG51MQ
Date:   Tue, 22 Aug 2023 19:46:03 +0000
Message-ID: <BN9PR12MB50688279EDDDB7386F0AF27BD31FA@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230817162159.242087-1-limings@nvidia.com>
 <CAPDyKFpezrjPk6Y+TS1A1E2tK4WbjdpTjPwPxLaAUD9fcaQonQ@mail.gmail.com>
 <c5f59dfd-a0dd-3b77-55fb-1087cbbbef25@intel.com>
 <CAPDyKFpEfc7EjpKDczwk9XDySug+uJ064FbrxsD6A0CY9ccOaw@mail.gmail.com>
In-Reply-To: <CAPDyKFpEfc7EjpKDczwk9XDySug+uJ064FbrxsD6A0CY9ccOaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|CH2PR12MB4280:EE_
x-ms-office365-filtering-correlation-id: 4ded5666-6bdc-4883-924a-08dba3486b72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I7zS1NstEHaq+MRE6N1BHcpOUS2gKZ+wexdfYUZf1saHK4l6C4cFyt3RUI77audocxMjqzqV10X3EEXpNIew72FpgnNCnB9vIEvoEGTLZZ0t7ncUffEzVoOYQFQTDQ1EP5Dxd2FQVzT1nWLeh9llNDLZslSksT8hDfiyowyOuZIBISDYPpFm+KXybZMbUhGBu19OTxqGMn3QgZctzjVxRwkhfqFQgeuYf7FM6vuBe45PKdVJznpAIe4YLxRXq7rLRQsr0r6FVEuBrQgPZZBg01rohNsgkrvzeWuff6y+Wkpj4oUjLU5gl8TjuPud6UPW6ex8p0e9Xna/F1vOWh1pvSLxlqntYlimoRmsaDg/6OCvG6ei2nrhIHzWV5OKIJ9pN6eV68mu5ocwALefHCOVfsyvxp68bzSCOzf9x2HNBvcQtT61BwVAkO2gaY70aOS89ESF2HgGWjTwsOK8vaxhygpDE+ccYhr6v0QpDNlVaGM+GTWXHpWhYqab9r6EtDUWMy2bRx3TMS3nn8HlmU4syuK8nzkSS88TtkqQ7/krwfCBp6yidMUI7OSSTvGHGm9ZQkSURNy7Z6S+Mw66og7YE9yFj9GrDlW/aFGWpf5kZRDIo02SDdkXpsSNVJFkOBjsc6yJujOQ93zNtv+3oKkj5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199024)(186009)(1800799009)(2906002)(38070700005)(38100700002)(6506007)(53546011)(83380400001)(5660300002)(26005)(33656002)(52536014)(86362001)(7696005)(8676002)(8936002)(4326008)(316002)(66946007)(9686003)(64756008)(54906003)(76116006)(66556008)(66446008)(66476007)(110136005)(478600001)(122000001)(71200400001)(55016003)(41300700001)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REowcGdNcnNLZmhqNVViVGRUTFJvV2J0OU5TclJJQzJyOXFsdTRFWXMySCt4?=
 =?utf-8?B?TFpQVGYwRTA5ZFc1ODhMVGhnSDVWNHdSakYya1ovRllMRys1NXNkaWNYY2gz?=
 =?utf-8?B?UC9taEZEYlpvbExHMU05WTN5OGova0d0aWRvOXBoK0JVd1g2dnkxUFZveWRk?=
 =?utf-8?B?ZDkvZDQrRmJhMGU0Rm1JaWZFOUlzMUpmUkk1UDdWUUVrUGxEdlNySEdJN3o1?=
 =?utf-8?B?NjYxSkV1UlhZeGNOdjA3ejBJZnFkZ0NtZDI0cnluNVE4dXB2TWNxenpmdWJG?=
 =?utf-8?B?S3JYcHdiN0FVaExGVFVzWUMrQmZQTHJuODltRXFQaGZPczFmblJYVTlhNm0x?=
 =?utf-8?B?UzlqQ0xVdEZyaVUvV0FCV0Z0VnNoaFpCeFhZVktUN1FlZXlFV0NhT2FONGhQ?=
 =?utf-8?B?NDJHQWlOYW9maUt3S1Y1cEpPN0JoYWNXaENWeEEyZ3hpRVhjSmU3QUNoalJ0?=
 =?utf-8?B?SjhOSWp0UzdnR3Y0amVhRHNUTG5IbExyYTNaaXI2ZXBBUDg3NTBOQ1ZLTUlp?=
 =?utf-8?B?c3RKdk1BVnk2RUZJU2FIWW0xZW1pRGNpbmxLRWJ6NFp3QVJ0VWF6dTcyMzFG?=
 =?utf-8?B?czFQdkw1U0tnU2s3OXhTRFVOd3ErcnhaVnpYQmMwRGtwQlhXMHhnM0htL2J5?=
 =?utf-8?B?c1NaUEh3OW1nVXhQY3FxNXVrVm12RlRYbmlna0NndVZiTXo3VDZhaE9WT1I1?=
 =?utf-8?B?b1ZpU2pUc08zdWM2UkNaSjhDK2RKR0I0MUxyQTlHa0F4L29HUmVPZFFVcTVt?=
 =?utf-8?B?bmRacEZQbHRZNGF0cWxLMVJDdkU4NDY0dmU4aFNrcnE4Y0NHa2JuTHNOYWRN?=
 =?utf-8?B?eDc5RU5xRUU1UGF6TmNpdzQxLzRIUHhoSDA3elBvQnBWQkZCWXRzOC9WcHlq?=
 =?utf-8?B?L0dqQWluK2h2OUxSZ291WC9MYWEvdWZaQkZRdnE3SS9CMWZBSFBCVkpEVktV?=
 =?utf-8?B?ZEJnR0Q5WVliZlYyQmtuZ0pBL2w3YXJYNTl6Uk9hN0U1elN5eWNNVDRYdTZR?=
 =?utf-8?B?akxFa3RiRHpqVEpzdUk0V1RoVTBnUndsNHN3cVJSY2o1cWRHOGp3cVVpdVR5?=
 =?utf-8?B?TkJRYkM2RkdpM0JldW9XekNDQUZOMEw0elFPeTRqVU9ROEgvYktSVXdnVWVv?=
 =?utf-8?B?d0NleElkUWxZckFTVi9ZTnlCbHpzV2t4eFg0TXd3ektDOVRGajJGZUh3Q0hk?=
 =?utf-8?B?bkJmN0puc2lVYkRKN0pWdHdXemNsU3N5UUxSQjhVSGplYUsvNHlucDdPNHVZ?=
 =?utf-8?B?cERFTnRlaDhDUGFDZUFRRVpzdHJJWENONHVPdm11MTA5SklzUGdKQ01jQnNm?=
 =?utf-8?B?aGFqZkFHOXFCRy8xU2xpU3BINFRLeVpRRC84QWNaTHRacytveThxdU9nNlpY?=
 =?utf-8?B?a3MvWkdrL2R1VjA3ckhzMFE0bEZaa2RveWZEVW52L0kzMzgxcy9kd3dlNWZU?=
 =?utf-8?B?QTFlT0Q3Ri94ZUQ1bFVIczZndUpRQjlWSXJET2ozc0IrTTdneVlFSlUvQzg2?=
 =?utf-8?B?RGtPcDVUNDJIU2FhMERxUDgzYXZLOVQ4MStEL2xJYTN1NXJvWFNjQUVUdVlF?=
 =?utf-8?B?Vk1uRkNwdXVZemFHblkrQ2g0UjRNR1BubGpVT212dklWK2gyK0lkbUZ2cURa?=
 =?utf-8?B?SGw5bTBRSGhTQkJKZ2FaM1pMdnNxdk9yQXE2Szc4VE1DUmFKZjcxTlNIbEFw?=
 =?utf-8?B?UUFHT21PMkRUWFh4V3lBRmVzd1BUeFUzM0ZiT0N2VTdGRk1YTWRtdVJyam1z?=
 =?utf-8?B?N2lVYklKSC9DMlNCNEFGc3cxWkg2UGRMNnp5L3h3UkNubGNYOUpuS1BmcFFV?=
 =?utf-8?B?dU1SN3BsVkZkYzh6UXRpNkg4Rm14VDdmMkM5cmxuU1pzWHg1bDRQaHV1Z2dn?=
 =?utf-8?B?eHNuZmh4WlZSZHRXYzRMSkIvNjFMUXMreFNEMkQ1MVo2SWNNUVZrZ2ZWNWZz?=
 =?utf-8?B?UWJSa1hUaG5Sekt5ZDl6U2JPWU5Hd3p4QUdCaHFWUnBIME0yL3lWOTZZVCto?=
 =?utf-8?B?NkhSdU84dU83N3M3bHYxSVpjb0RIOE15ZnVTOU9oZmtuSWtxY2Zwb3J1L0Jx?=
 =?utf-8?B?RHE5WUxwSllSdDU4T0tYSHo4U2c0NFZRL1JaUVRWcXlueTJGRUZlVlpYZkth?=
 =?utf-8?Q?RH5M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ded5666-6bdc-4883-924a-08dba3486b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 19:46:03.8323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Qn/RIk+kYcNbOnqmMplePLYuBXOW3//LGRR/4YqR49tH0HUzm6M82FOXcVrHiEStTAXkxv6YXrPbrsoq031XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDE4LCAyMDIzIDY6
MTkgQU0NCj4gVG86IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBD
YzogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPjsgRGF2aWQgVGhvbXBzb24NCj4gPGRh
dnRob21wc29uQG52aWRpYS5jb20+OyBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNv
bT47IGxpbnV4LQ0KPiBtbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjldIG1tYzogc2RoY2ktb2YtZHdjbXNoYzog
QWRkIHJ1bnRpbWUgUE0gb3BlcmF0aW9ucw0KPiANCj4gT24gRnJpLCAxOCBBdWcgMjAyMyBhdCAx
MTozNiwgQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IHdyb3RlOg0K
PiA+DQo+ID4gT24gMTgvMDgvMjMgMTI6MDAsIFVsZiBIYW5zc29uIHdyb3RlOg0KPiA+ID4gT24g
VGh1LCAxNyBBdWcgMjAyMyBhdCAxODoyMiwgTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29t
PiB3cm90ZToNCj4gPiA+Pg0KPiA+ID4+IFRoaXMgY29tbWl0IGltcGxlbWVudHMgdGhlIHJ1bnRp
bWUgUE0gb3BlcmF0aW9ucyB0byBkaXNhYmxlIGVNTUMNCj4gPiA+PiBjYXJkIGNsb2NrIHdoZW4g
aWRsZS4NCj4gPiA+Pg0KPiA+ID4+IFJldmlld2VkLWJ5OiBEYXZpZCBUaG9tcHNvbiA8ZGF2dGhv
bXBzb25AbnZpZGlhLmNvbT4NCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBMaW1pbmcgU3VuIDxsaW1p
bmdzQG52aWRpYS5jb20+DQo+ID4gPj4gLS0tDQo+ID4gPj4gdjgtPnY5Og0KPiA+ID4+ICAgICAt
IEFkZHJlc3MgQWRyaWFuJ3MgY29tbWVudCB0byBkbyB0aGUgcG1fcnVudGltZV9wdXQoKSBpbg0K
PiA+ID4+ICAgICAgIGR3Y21zaGNfcmVzdW1lKCkgaW5zdGVhZDsgRXJyb3IgcGF0aCBjaGFuZ2Vz
IG5vdCBpbmNsdWRlZCB5ZXQuDQo+ID4gPj4gdjctPnY4Og0KPiA+ID4+ICAgICAtIEFkZHJlc3Mg
VWxmJ3MgY29tbWVudCAob3B0aW9uLTEpOw0KPiA+ID4+ICAgICAtIFVwZGF0ZXMgZm9yIEFkcmlh
bidzIGNvbW1lbnQgdG8gcmVtb3ZlIHRoZSBmb3JjZV9zdXNwZW5kL3Jlc3VtZQ0KPiA+ID4+ICAg
ICAgIGluIGR3Y21zaGNfcmVzdW1lKCkvZHdjbXNoY19zdXNwZW5kKCk7IEFkZCBjb21tZW50cyBm
b3INCj4gPiA+PiAgICAgICBkd2Ntc2hjX3Jlc3VtZSgpL2R3Y21zaGNfc3VzcGVuZCgpOw0KPiA+
ID4+IHY2LT52NzoNCj4gPiA+PiAgICAgLSBBZGRyZXNzIFVsZidzIGNvbW1lbnQ7DQo+ID4gPj4g
djUtPnY2Og0KPiA+ID4+ICAgICAtIEFkZHJlc3MgQWRyaWFuJ3MgbW9yZSBjb21tZW50cyBhbmQg
YWRkIGNvb3JkaW5hdGlvbiBiZXR3ZWVuDQo+ID4gPj4gICAgICAgcnVudGltZSBQTSBhbmQgc3lz
dGVtIFBNOw0KPiA+ID4+IHY0LT52NToNCj4gPiA+PiAgICAgLSBBZGRyZXNzIEFkcmlhbidzIGNv
bW1lbnQgdG8gbW92ZSB0aGUgcG1fZW5hYmxlIHRvIHRoZSBlbmQgdG8NCj4gPiA+PiAgICAgICBh
dm9pZCByYWNlOw0KPiA+ID4+IHYzLT52NDoNCj4gPiA+PiAgICAgLSBGaXggY29tcGlsaW5nIHJl
cG9ydGVkIGJ5ICdrZXJuZWwgdGVzdCByb2JvdCc7DQo+ID4gPj4gdjItPnYzOg0KPiA+ID4+ICAg
ICAtIFJldmlzZSB0aGUgY29tbWl0IG1lc3NhZ2U7DQo+ID4gPj4gdjEtPnYyOg0KPiA+ID4+ICAg
ICBVcGRhdGVzIGZvciBjb21tZW50cyBmcm9tIFVsZjoNCj4gPiA+PiAgICAgLSBNYWtlIHRoZSBy
dW50aW1lIFBNIGxvZ2ljIGdlbmVyaWMgZm9yIHNkaGNpLW9mLWR3Y21zaGM7DQo+ID4gPj4gdjE6
IEluaXRpYWwgdmVyc2lvbi4NCj4gPiA+PiAtLS0NCj4gPiA+PiAgZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS1vZi1kd2Ntc2hjLmMgfCA3Ng0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0K
PiA+ID4+ICAxIGZpbGUgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4gPiA+Pg0KPiA+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3
Y21zaGMuYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5jDQo+ID4gPj4g
aW5kZXggZTY4Y2Q4Nzk5OGM4Li4zYjQwZjU1Y2UyYTQgMTAwNjQ0DQo+ID4gPj4gLS0tIGEvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMNCj4gPiA+PiArKysgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYw0KPiA+ID4+IEBAIC0xNSw2ICsxNSw3IEBADQo+ID4g
Pj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiA+PiAgI2luY2x1ZGUgPGxpbnV4L29m
Lmg+DQo+ID4gPj4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiA+PiArI2luY2x1
ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiA+PiAgI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+
DQo+ID4gPj4gICNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0KPiA+ID4+DQo+ID4gPj4gQEAgLTU0
OCw5ICs1NDksMTMgQEAgc3RhdGljIGludCBkd2Ntc2hjX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gPj4NCj4gPiA+PiAgICAgICAgIGhvc3QtPm1tYy0+Y2FwcyB8
PSBNTUNfQ0FQX1dBSVRfV0hJTEVfQlVTWTsNCj4gPiA+Pg0KPiA+ID4+ICsgICAgICAgcG1fcnVu
dGltZV9nZXRfbm9yZXN1bWUoZGV2KTsNCj4gPiA+PiArICAgICAgIHBtX3J1bnRpbWVfc2V0X2Fj
dGl2ZShkZXYpOw0KPiA+ID4+ICsgICAgICAgcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gPiA+
PiArDQo+ID4gPj4gICAgICAgICBlcnIgPSBzZGhjaV9zZXR1cF9ob3N0KGhvc3QpOw0KPiA+ID4+
ICAgICAgICAgaWYgKGVycikNCj4gPiA+PiAtICAgICAgICAgICAgICAgZ290byBlcnJfY2xrOw0K
PiA+ID4+ICsgICAgICAgICAgICAgICBnb3RvIGVycl9ycG07DQo+ID4gPj4NCj4gPiA+PiAgICAg
ICAgIGlmIChya19wcml2KQ0KPiA+ID4+ICAgICAgICAgICAgICAgICBkd2Ntc2hjX3JrMzV4eF9w
b3N0aW5pdChob3N0LCBwcml2KTsNCj4gPiA+PiBAQCAtNTU5LDEwICs1NjQsMTUgQEAgc3RhdGlj
IGludCBkd2Ntc2hjX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
Pj4gICAgICAgICBpZiAoZXJyKQ0KPiA+ID4+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9zZXR1
cF9ob3N0Ow0KPiA+ID4+DQo+ID4gPj4gKyAgICAgICBwbV9ydW50aW1lX3B1dChkZXYpOw0KPiA+
ID4+ICsNCj4gPiA+PiAgICAgICAgIHJldHVybiAwOw0KPiA+ID4+DQo+ID4gPj4gIGVycl9zZXR1
cF9ob3N0Og0KPiA+ID4+ICAgICAgICAgc2RoY2lfY2xlYW51cF9ob3N0KGhvc3QpOw0KPiA+ID4+
ICtlcnJfcnBtOg0KPiA+ID4+ICsgICAgICAgcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+ID4g
Pj4gKyAgICAgICBwbV9ydW50aW1lX3B1dF9ub2lkbGUoZGV2KTsNCj4gPiA+PiAgZXJyX2NsazoN
Cj4gPiA+PiAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShwbHRmbV9ob3N0LT5jbGspOw0K
PiA+ID4+ICAgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHByaXYtPmJ1c19jbGspOw0KPiA+
ID4+IEBAIC02MDIsOSArNjEyLDEzIEBAIHN0YXRpYyBpbnQgZHdjbXNoY19zdXNwZW5kKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gPiA+PiAgICAgICAgIHN0cnVjdCByazM1eHhfcHJpdiAqcmtfcHJp
diA9IHByaXYtPnByaXY7DQo+ID4gPj4gICAgICAgICBpbnQgcmV0Ow0KPiA+ID4+DQo+ID4gPj4g
KyAgICAgICBwbV9ydW50aW1lX2dldF9zeW5jKGRldik7DQo+ID4gPj4gKw0KPiA+ID4+ICAgICAg
ICAgcmV0ID0gc2RoY2lfc3VzcGVuZF9ob3N0KGhvc3QpOw0KPiA+ID4+IC0gICAgICAgaWYgKHJl
dCkNCj4gPiA+PiArICAgICAgIGlmIChyZXQpIHsNCj4gPiA+PiArICAgICAgICAgICAgICAgcG1f
cnVudGltZV9wdXQoZGV2KTsNCj4gPiA+PiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
PiA+PiArICAgICAgIH0NCj4gPiA+Pg0KPiA+ID4+ICAgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVw
YXJlKHBsdGZtX2hvc3QtPmNsayk7DQo+ID4gPj4gICAgICAgICBpZiAoIUlTX0VSUihwcml2LT5i
dXNfY2xrKSkNCj4gPiA+PiBAQCAtNjQyLDExICs2NTYsNjUgQEAgc3RhdGljIGludCBkd2Ntc2hj
X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gPiA+PiAgICAgICAgIH0NCj4gPiA+Pg0KPiA+ID4+IC0gICAgICAg
cmV0dXJuIHNkaGNpX3Jlc3VtZV9ob3N0KGhvc3QpOw0KPiA+ID4+ICsgICAgICAgcmV0ID0gc2Ro
Y2lfcmVzdW1lX2hvc3QoaG9zdCk7DQo+ID4gPj4gKyAgICAgICBpZiAocmV0KQ0KPiA+ID4+ICsg
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4+ICsNCj4gPiA+PiArICAgICAgIHBtX3J1
bnRpbWVfcHV0KGRldik7DQo+ID4gPg0KPiA+ID4gVG8gc2ltcGxpZnkgdGhlIGVycm9yIHBhdGgs
IEkgd291bGQgc3VnZ2VzdCB0aGF0IHlvdSBtb3ZlIHRoZSBjYWxsIHRvDQo+ID4gPiBwbV9ydW50
aW1lX3B1dCgpIHRvIGR3Y21zaGNfc3VzcGVuZCgpLiBJbiBmYWN0IHdoYXQgeW91IG5lZWQgaXMg
anVzdCBhDQo+ID4gPiBjYWxsIHRvIHBtX3J1bnRpbWVfcHV0X25vaWRsZSgpLCBzb21ld2hlcmUg
YWZ0ZXIgdGhlIGNhbGwgdG8NCj4gPiA+IHBtX3J1bnRpbWVfZ2V0X3N5bmMoKS4NCj4gPiA+DQo+
ID4gPiBUaGlzIGlzIGJlY2F1c2UgcnVudGltZSBzdXNwZW5kIGlzIHByZXZlbnRlZCBieSB0aGUg
UE0gY29yZSBhcyBpdA0KPiA+ID4gYnVtcHMgdGhlIHVzYWdlIGNvdW50IHdpdGggYSBwbV9ydW50
aW1lX2dldF9ub3Jlc3VtZSgpIGluIHRoZQ0KPiA+ID4gZGV2aWNlX3ByZXBhcmUoKSBwaGFzZS4N
Cj4gPg0KPiA+IEkgdGhvdWdodCB5b3UgZGlkbid0IHdhbnQgdG8gYXNzdW1lIHRoYXQsIGJlY2F1
c2UgaW4gdGhhdCBjYXNlDQo+ID4gaXQgY2FuIGp1c3QgYmUgcG1fcnVudGltZV9yZXN1bWUoKSBp
bnN0ZWFkIG9mIHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSwNCj4gPiBhbmQgdGhlbiBubyAncHV0JyBp
cyBuZWVkZWQgYXQgYWxsLg0KPiANCj4gSSBkb24ndCByZWFsbHkgY2FyZSwgYnV0IGp1c3Qgd2Fu
dGVkIHRvIGtlZXAgaXQgYXMgc2ltcGxlIGFzIHBvc3NpYmxlLg0KPiANCj4gU28geWVzLCBJIGFt
IGZpbmUgd2l0aCBhIHBtX3J1bnRpbWVfcmVzdW1lKCkgdG9vLiBNYXliZSBldmVuIHNpbXBsZXIN
Cj4gaW4gdGhpcyBjYXNlLCBhcyB3ZSBhcmUgbm90IHVzaW5nIHBtX3J1bnRpbWVfZm9yY2Vfc3Vz
cGVuZHxyZXN1bWUoKQ0KPiBhbnltb3JlLg0KDQpUaGFua3MuIFdpbGwgcG9zdCB2MTAgd2l0aCAn
IHBtX3J1bnRpbWVfcmVzdW1lKGRldik7JyBpbiBkd2Ntc2hjX3N1c3BlbmQoKSB0byBrZWVwIGl0
IHNpbXBsZS4NCg0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
