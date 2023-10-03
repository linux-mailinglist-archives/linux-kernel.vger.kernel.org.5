Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917937B6BF6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbjJCOoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbjJCOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:44:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532A4CE;
        Tue,  3 Oct 2023 07:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUtmE+3RO2n7CHDpfuhLf2mfteviyDjaYoVeDQzarHYS85w3Wyo+i0z/uW5mW4zf2enx5FoheHsz9OQka7KLcRe9Q6APZhqyAeP8YY8WvFv/DkQT8KKX9nudxUAzG7xg60eqCS1sBPWDuYvVq/pTVJ3oYLxjYnSP/QUMQk7jrhsuGLhUFUvEijOpkt78DM97Av7gZktwhiOjQS0OHYFI7Xzws56hjOfIdRoPOhGfAHd8BpspY2uKoy4AwKT9o3Vsk+YE8u66Qhz546tPmm0r949zMmw1Y+m2jKoDs8GuyBuoDHYKZvK3jNoHnhThPRHWpLV/X0ROJ3BM1TIlRmE9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWLTeZzvLJjBAGja8x59yMUzN8f9bShAoTaETTM+G9s=;
 b=Qq3Pt0BhUzPXRjkD2IJ1lIhpsQO+QgEYYOv/T2A//UnUzP/4Tcd6IwKSSBn7SAXUyx1vpDNhp+pBaoKrTnGRUVjMwkOlL24SuAwkejZG0bex/qdgTCOrnObahZNfPeKrduEB7DzisVxCRw1JaFYyXlm0AYigKpfRVzshU2HeKeZ0CCa2iKn6cr3unUvuc3W6GU6Yk6ppIbwv4PM4alHRPtNgYPnNj3B8EjrJGO4L9rol+eO7Dpiogif5Hu/JVybBQXxzcbgqJxo3gbXgfj4KmcnW/otXjDLClHKoTBdPbiWmHsuxi7nJEjpIk2fStLT3/WHkJh84fUw3tiWM5uyriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWLTeZzvLJjBAGja8x59yMUzN8f9bShAoTaETTM+G9s=;
 b=PaYnokPbyYYapGg1dAt5ivhMQDo0tQcDKuXpX2zLULOpQ2+I/vlFqYMGRoas8axGGtGYGvvGsn0e25DBlPEbB6iboWiQqYSjthRvd+pRV1xClL0z/P35R0n0gNwG8h2/8Yt/rpTdrZpGMXSBbavRSig/uOCjn7AylBezwuq0BM3qFvmlrb7tMCQZBekKhJ9tb4SFgo0wTcpArxL/TBve9cMlDzM9fJqr/hScPVKnF8LK4sPxQM17ALTO80vU5/lTqS8+hdBazLht8Qt3cB/UFfabkr2muWDe+SasNVnjtfFPKiD8NrkLWRdMejsvEflocMtGV0OiWOmeD6vDdxywhw==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 14:44:37 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::7e45:fc48:aaba:6716]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::7e45:fc48:aaba:6716%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 14:44:37 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Michael Shych <michaelsh@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform: mellanox: Fix a resource leak in an error
 handling path in mlxplat_probe()
Thread-Topic: [PATCH] platform: mellanox: Fix a resource leak in an error
 handling path in mlxplat_probe()
Thread-Index: AQHZ9C9x2SH6czTFHUq9nUWKO4bfRbA3+4GAgAAVesA=
Date:   Tue, 3 Oct 2023 14:44:37 +0000
Message-ID: <BN9PR12MB53810BC39ADE210092559CADAFC4A@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <8bd0a7944f0f4f1342333eaf8d92d8e9d5623110.1696141233.git.christophe.jaillet@wanadoo.fr>
 <7d966897-56b5-4a53-3b75-dd90072e17@linux.intel.com>
In-Reply-To: <7d966897-56b5-4a53-3b75-dd90072e17@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|BY5PR12MB4291:EE_
x-ms-office365-filtering-correlation-id: c64f1262-fb7f-40d9-542e-08dbc41f44a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xd7vRvsC/7eba6CfP2KQDSmzMdImg4bfhadurLeLETBBB5YR0o0c094PQnf0Dgwd4VUB7SwHuVB5Nj6iiqPTpFu7DFtPEEdgsXbN2P4w34QDVZf7giR0997hELdd7pYHaTHJoV684N+KyFWqt9IVI7YI4LiEGxpt3EHW5vJuk+mNTjZTmvtET6Od9/snKF/+Nno1YED4+c3fxiZtoWCXaMr9XG6HKPXL/U5jfZ2PZqI1j3yJTbI21K53Q8r7YAfLrE3QHwtcbg7k1Q+7do/6XNvNxLOuDMRsy0diUhPL1fH3u80R1SwkCuyTuL8GBsFG2fvAJG4ZMbb2g18QzYBn07gWdizjJcOSN2j8LnnyYmNjmkfR3pH4eZL+L0NFkS33UgJvONqjo63JfwDCo6r9kxKwF2tMH4qu0L7BhPLxxRWhcBik4ALgNtcLK1ANdmNnF9RKG1jQeYqY5hreyaCHgWmVtMEyaSB+VdlsZSk3jMdAAURapNtIVvesgx7Ot0g2g+CxrX9DrGezvPt3gojuAX35OfPiK+7fvKWTzV0qOp75kVjkLxdGgvIA8BkrWqewNHaBH3bQd5ZIwZ7fQl+2tWHiYbsJEj7VOZaFhJPluxVVfpVo+qctpFDwO+9RMjop
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(9686003)(53546011)(38070700005)(7696005)(6506007)(33656002)(83380400001)(86362001)(66574015)(55016003)(41300700001)(316002)(66446008)(110136005)(54906003)(66946007)(64756008)(66476007)(66556008)(5660300002)(76116006)(38100700002)(4326008)(8676002)(52536014)(8936002)(478600001)(122000001)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjUwZW96UDk5U24yNG5qdklWOXN4L2cxMnErcGt2L1k2YVQ2OFh3R29SMzA2?=
 =?utf-8?B?b2U2aVFpYUtpbm9vN3BLbUZoY1JQbUs3cE84M2JMYjFyWGo0K1BiZXE0c0hq?=
 =?utf-8?B?eWZRWlY2OGJ6YWhOZTlMV1NEa201QWdPZ0loM1hDNmEvZzArN29wbXF3U25P?=
 =?utf-8?B?OGhXak9lRVFBTWQ2T3gvSmxyazR6QzdoUXJMQTh0S3BwTmJwbGVRQ2RCNHV0?=
 =?utf-8?B?VWsrWTg0Znh0YnNNc2k0ZlVSaEUrekczUlFRWFNpaWY2ZFpCd2lmS3lYRWdQ?=
 =?utf-8?B?bUo5SGtMZUN6b2krLzlDOU9kOERvUXp4WWlUUlFoUFhhRmVFZmFUUEpDcVZD?=
 =?utf-8?B?VVdWK25YNWRSZDVtYXgxUG9BSHdxUFgrVHgrUm9kQTFPc0N4QU5NTml6S3lZ?=
 =?utf-8?B?V1FRdE1LUllRVXIyMGJhM3dKeC9WVUxlVWd5OFlwaWp4dGpMSEpFRGJtaTZy?=
 =?utf-8?B?clhxUWEvN1hOV0JCcW9vdUwwMFVPL241YVpKRmtYaldPZitSaWtKUkxCYU1z?=
 =?utf-8?B?cnZFWHU2L2ZGUzlqZjdqV0kwQWk4azBTNkRTQ09XTHFBZWdoUi9kSzVpNXJy?=
 =?utf-8?B?MWxsMzkvUkhiQVcrNEJKNm5hNW52V3FYT3dqSkJBVlFWeVJoREhIb2NLQkVI?=
 =?utf-8?B?eTUvNXlCUXNLRWQxUlNqZDZuOW8wMkhQc0ZidVlsS1hHcG9ZdzdaeGlvRE40?=
 =?utf-8?B?TjYycm4veUVrSnllZEpJTnJyY1gwL0tNVTk4TGZHRDNvVEpySjNaNGdzbCtY?=
 =?utf-8?B?bHlxNm5CeE9kZURSdDZMdlhDd2xIYUZBbmI5bzVJbmtCQ3pKbkNNZlpUb0FO?=
 =?utf-8?B?ZVdreGRsWEhoa2l4NDJ6aVJBMGV0WW1ibFNjZS92dkhlT3dYZFJURVVLMHdx?=
 =?utf-8?B?Qk51VWN6OExOblRNaTYxakF1YW9OMTNUWnVYanN4amFyT21sTDd3ckJZV0xq?=
 =?utf-8?B?eG9VZHhTYmMyT2R3RGJ2M0xjczJYNW9heW5FS0lMMWNRS3BNUWhEamE4TjdJ?=
 =?utf-8?B?cmEvaFJleTVjK3A2ajBRQ1hBelhxTmFYYlYvcy9XdDVDczJ5cTExUC9pcE82?=
 =?utf-8?B?S3gvUEZPZTE3aUZLTUc2amRJeUtqVmFiaWJvU2NXZlY2QWluSnlBVmFvSHNE?=
 =?utf-8?B?U2NGUUJoSXBpUXpvY3NlTUtmS1BtSjZrZFBuSm9KQkd6aitBNGUwdXIwanJj?=
 =?utf-8?B?UTNQcU5YT0dpeldrYVYvZnlxSHZ6R0NNRUxYYkRqSEp0SEFYYVJNczhXTDlI?=
 =?utf-8?B?VEVHcEdOY20rVndCMTg5MTF5VUU3NkpSVi9LN1l5eWFQd2psZG5wNmxJa01N?=
 =?utf-8?B?bHJBSkp1dDVkVlVtNHpLUWJTZmRYWkxITlhINThvTFBPeXFubGJSUEZjdHpP?=
 =?utf-8?B?OW9jSkROVVpEV2JIbzBBSWlrNVYzcXRZZmR0WEJ5Sk1aV2Z1MmdTb0hOaldB?=
 =?utf-8?B?NDhod0d0OWo5MlIrUS9xb09QSWRWNWg1OWhmNmJLTmNQUG5rQ01LZnBiTlg5?=
 =?utf-8?B?RUVEMmU3NW5Nd2hiaTdyeDJyVEVOUzhKVDB0cC9VZ2FsRWNabXg5NFBkWnBw?=
 =?utf-8?B?NUtWV0toZVAwcWpsbEpNWjFVSGVQRzBHVS9zclo5UGJDdm4xbS9YY25HUUhQ?=
 =?utf-8?B?b1NPWDcvY2Uva1BzS21qZWxQRTJzLzV0ek5CM1pkYXE1S2dvWmlCYURvUkdi?=
 =?utf-8?B?NlV1TElCRVUxVWdGREZsTWZ2cjhvdllIUFhUL042c1BBQTZjanRhOGdDNVIz?=
 =?utf-8?B?Skdna2JmZXlUZHd1M3JUVUg3WXRRZU9ibHhiZWRmazQzSDMvRUgzalh3M25r?=
 =?utf-8?B?TzlyQ2FHd2lqQ2ZPYzNQMG51cndiSXQvZTNPQjNnU2tIaktVd2FrWktHYmw4?=
 =?utf-8?B?VlJlb3hRUmRGd3c3Y1dJN2NBT3k4WVVHbEFWU1MvUXhvQlZCUzdtT3FPYk1q?=
 =?utf-8?B?Yml2eTZsYkJHNjVibFpnWThJUlh3Skxwd25PMGl6eWN2S00ycWNzZi9MdTdm?=
 =?utf-8?B?aUNZNUJrVTR6NG5VM0owWHpBdmxUbW42bjZmS3BFSzNreDRKenAyOGJ0SGFM?=
 =?utf-8?B?TE9MSmk3V3dTRTdORGJwSGhKZHlCYnBpRjdnQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64f1262-fb7f-40d9-542e-08dbc41f44a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 14:44:37.7292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bpRG40ZTsNXI8yHs6H7WDbJ9K9ZQtFdbjKire+Obv1lWuiYkWGFNV9LBnEo6BFg69tkU+NBEdxSNFcuywpc5mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWxwbywNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHJldmlldy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBs
aW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDMgT2N0b2JlciAyMDIzIDE1OjA2DQo+
IFRvOiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPg0K
PiBDYzogVmFkaW0gUGFzdGVybmFrIDx2YWRpbXBAbnZpZGlhLmNvbT47IEhhbnMgZGUgR29lZGUN
Cj4gPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBNYXJrIEdyb3NzIDxtYXJrZ3Jvc3NAa2VybmVsLm9y
Zz47IE1pY2hhZWwNCj4gU2h5Y2ggPG1pY2hhZWxzaEBudmlkaWEuY29tPjsgTEtNTCA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz47IGtlcm5lbC0NCj4gamFuaXRvcnNAdmdlci5rZXJuZWwu
b3JnOyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBwbGF0Zm9ybTogbWVsbGFub3g6IEZpeCBhIHJlc291cmNlIGxlYWsgaW4gYW4gZXJy
b3INCj4gaGFuZGxpbmcgcGF0aCBpbiBtbHhwbGF0X3Byb2JlKCkNCj4gDQo+IE9uIFN1biwgMSBP
Y3QgMjAyMywgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiANCj4gPiBJZiBhbiBlcnJvciBv
Y2N1cnMgYWZ0ZXIgYSBzdWNjZXNzZnVsIG1seHBsYXRfaTJjX21haW5faW5pdCgpLA0KPiA+IG1s
eHBsYXRfaTJjX21haW5fZXhpdCgpIHNob3VsZCBiZSBjYWxsZWQgdG8gZnJlZSBzb21lIHJlc291
cmNlcy4NCj4gPg0KPiA+IEFkZCB0aGUgbWlzc2luZyBjYWxsLCBhcyBhbHJlYWR5IGRvbmUgaW4g
dGhlIHJlbW92ZSBmdW5jdGlvbi4NCj4gPg0KPiA+IEZpeGVzOiAxNThjZDgzMjA3NzYgKCJwbGF0
Zm9ybTogbWVsbGFub3g6IFNwbGl0IGxvZ2ljIGluIGluaXQgYW5kIGV4aXQNCj4gPiBmbG93IikN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxl
dEB3YW5hZG9vLmZyPg0KPiA+IC0tLQ0KPiA+IFRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gY29tcGFy
aXNvbiBiZXR3ZWVuIGZ1bmN0aW9ucyBjYWxsZWQgaW4gdGhlDQo+ID4gcmVtb3ZlIGZ1bmN0aW9u
IGFuZCB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aCBvZiB0aGUgcHJvYmUuDQo+ID4NCj4gPiBGb3Ig
c29tZSByZWFzb24sIHRoZSB3YXkgdGhlIGNvZGUgaXMgd3JpdHRlbiBhbmQgZnVuY3Rpb24gbmFt
ZXMgYXJlDQo+ID4gcHV6emxpbmcgdG8gbWUuDQo+IA0KPiBJbmRlZWQsIHByZS9wb3N0IGFyZSBt
aXhlZCB1cCBmb3IgaW5pdC9leGl0IHZhcmlhbnRzIHdoaWNoIG1ha2VzIGV2ZXJ5dGhpbmcNCj4g
dmVyeSBjb25mdXNpbmcgYW5kIHRoZSBjYWxsIHRvIG1seHBsYXRfcG9zdF9pbml0KCkgaXMgYnVy
aWVkIGRlZXAgaW50byB0aGUgY2FsbA0KPiBjaGFpbi4NCj4gDQo+IFRoZXNlIHdvdWxkIHNlZW0g
YmV0dGVyIG5hbWVzIGZvciB0aGUgaW5pdC9kZWluaXQgd2l0aCBwcm9wZXIgcGFpcmluZzoNCj4g
DQo+IC0gLi4uX2xvZ2ljZGV2X2luaXQvZGVpbml0IGZvciBGUEdBL0NQTEQgaW5pdC4NCj4gLSAu
Li5fbWFpbmJ1c19pbml0L2RlaW5pdA0KPiAtIHBlcmhhcHMgdGhlIHJlc3QgY291bGQgYmUganVz
dCAuLi5fcGxhdGRldnNfcmVnL3VucmVnDQo+IA0KPiBUaG9zZSBhbG9uZSB3b3VsZCBtYWtlIGl0
IG11Y2ggZWFzaWVyIHRvIGZvbGxvdy4NCj4gDQo+IEluIGFkZGl0aW9uLA0KPiAtIG1seHBsYXRf
aTJjX211eF9jb21wbGl0aW9uX25vdGlmeSgpIGxvb2tzIGp1c3QgdXNlbGVzcyBjYWxsIGNoYWlu
IGxldmVsDQo+ICAgYW5kIHNob3VsZCBiZSByZW1vdmVkIChpdCBhbHNvIGhhcyBhIHR5cG8gaW4g
aXRzIG5hbWUpLg0KPiAtIE1heWJlIC4uLl9wbGF0ZGV2X3JlZygpIChjdXJyZW50bHkgbWx4cGxh
dF9wb3N0X2luaXQoKSkgc2hvdWxkIGJlIGNhbGxlZA0KPiAgIGRpcmVjdGx5IGZyb20gbWFpbmJ1
c19pbml0KCkgb3IgZXZlbiBmcm9tIC5wcm9iZSgpIGFuZCBub3QgZnJvbSB0aGUNCj4gICBtdXgg
dG9wbyBpbml0Lg0KPiANCj4gPiBTbyBSZXZpZXcgd2l0aCBjYXJlIQ0KPiANCj4gSXQgZG9lcyBu
b3QgbG9vayBjb21wbGV0ZSBhcyBhbHNvIG1seHBsYXRfaTJjX21haW5faW5pdCgpIGxhY2tzIHJv
bGxiYWNrIGl0DQo+IHNob3VsZCBkbyBpdCBtbHhwbGF0X2kyY19tdXhfdG9wb2xvZ3lfaW5pdCgp
IGZhaWxlZC4NCj4gDQo+IFNpbmNlIGN1cnJlbnRseSBtbHhwbGF0X2kyY19tYWluX2luaXQoKSBp
cyB3aGF0IHVsdGltYXRlbHkgY2FsbHMNCj4gbWx4cGxhdF9wb3N0X2luaXQoKSBkZWVwIGRvd24g
aW4gdGhlIGNhbGwgY2hhaW4gKHVubGVzcyB0aGUgY2FsbCB0byBpdCBnZXRzIG1vdmVkDQo+IG91
dCBmcm9tIHRoZXJlKSwgaXQgd291bGQgYmUgYXBwcm9wcmlhdGUgZm9yDQo+IG1seHBsYXRfaTJj
X21haW5fZXhpdCgpIHRvIGRvL2NhbGwgdGhlIGNsZWFudXAuICBBbmQgbmVpdGhlciAucHJvYmUo
KSBub3INCj4gLnJlbW92ZSgpIHNob3VsZCBjYWxsIG1seHBsYXRfcHJlX2V4aXQoKSBkaXJlY3Rs
eSBpbiB0aGF0IGNhc2UuDQo+IA0KPiBTbyB0d28gYWx0ZXJuYXRpdmUgd2F5cyBmb3J3YXJkIGZv
ciB0aGUgZml4IGJlZm9yZSBhbGwgdGhlIHJlbmFtaW5nOg0KPiANCj4gMSkgTW92ZSBtbHhwbGF0
X3Bvc3RfaW5pdCgpIGNhbGwgb3V0IG9mIGl0cyBjdXJyZW50IHBsYWNlIGludG8gLnByb2JlKCkN
Cj4gICAgYW5kIG1ha2UgdGhlIHJvbGxiYWNrIHBhdGggdGhlcmUgdG8gbWF0Y2ggdGhhdC4NCj4g
MikgRG8gY2xlYW51cCBwcm9wZXJseSBpbiBtbHhwbGF0X2kyY19tYWluX2luaXQoKSBhbmQNCj4g
ICAgbWx4cGxhdF9pMmNfbWFpbl9leGl0KCkuDQo+IA0KPiBJJ2QgcHJlZmVyIDEpIGJlY2F1c2Ug
aXQncyBtdWNoIHNpbXBsZXIgdG8gZm9sbG93IHRoZSBpbml0IGxvZ2ljIHdoZW4gdGhlIGluaXQN
Cj4gY29tcG9uZW50cyBhcmUgbm90IGhpZGRlbiBkZWVwIGludG8gdGhlIGNhbGwgY2hhaW4uDQo+
IA0KDQpJIHdvdWxkIHByZWZlciB0byBrZWVwIG1seHBsYXRfaTJjX211eF9jb21wbGl0aW9uX25v
dGlmeSgpIGFzIHNlcGFyYXRlDQpmdW5jdGlvbi4gSSBhbSBnb2luZyB0byB1c2UgaXQgYXMgYSBj
YWxsYmFjay4gDQoNCkkgc3VnZ2VzdCBJJ2xsIHByZXBhcmUgdGhlIG5leHQgcGF0Y2hlczoNCg0K
MS4NCkFzIGEgYnVnZml4LCBmaXggcHJvdmlkZWQgYnkgQ2hyaXN0b3BoZSBhbmQgYWRkaXRpb25h
bCBjbGVhbnVwIGluDQptbHhwbGF0X2kyY19tYWluX2luaXQoKToNCg0KQEAgLTY1MTQsNiArNjUx
NCwxMCBAQCBzdGF0aWMgaW50IG1seHBsYXRfaTJjX21haW5faW5pdChzdHJ1Y3QgbWx4cGxhdF9w
cml2ICpwcml2KQ0KICAgICAgICByZXR1cm4gMDsNCiANCiBmYWlsX21seHBsYXRfaTJjX211eF90
b3BvbG9neV9pbml0Og0KKyAgICAgICBpZiAocHJpdi0+cGRldl9pMmMpIHsNCisgICAgICAgICAg
ICAgICBwbGF0Zm9ybV9kZXZpY2VfdW5yZWdpc3Rlcihwcml2LT5wZGV2X2kyYyk7DQorICAgICAg
ICAgICAgICAgcHJpdi0+cGRldl9pMmMgPSBOVUxMOw0KKyAgICAgICB9DQogZmFpbF9wbGF0Zm9y
bV9pMmNfcmVnaXN0ZXI6DQogZmFpbF9tbHhwbGF0X21seGNwbGRfdmVyaWZ5X2J1c190b3BvbG9n
eToNCiAgICAgICAgcmV0dXJuIGVycjsNCkBAIC02NTk4LDYgKzY2MDIsNyBAQCBzdGF0aWMgaW50
IG1seHBsYXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiBmYWlsX3JlZ2lz
dGVyX3JlYm9vdF9ub3RpZmllcjoNCiBmYWlsX3JlZ2NhY2hlX3N5bmM6DQogICAgICAgIG1seHBs
YXRfcHJlX2V4aXQocHJpdik7DQorICAgICAgIG1seHBsYXRfaTJjX21haW5fZXhpdChwcml2KTsN
CiBmYWlsX21seHBsYXRfaTJjX21haW5faW5pdDoNCiBmYWlsX3JlZ21hcF93cml0ZToNCg0KMi4N
Ck1vdmUgbWx4cGxhdF9wcmVfZXhpdCgpIGluc2lkZSBtbHhwbGF0X2kyY19tYWluX2V4aXQoKQ0K
DQozLg0KRml4IG9mICcgY29tcGxpdGlvbicgbWlzc3BlbGxpbmc6DQpzL21seHBsYXRfaTJjX21h
aW5fY29tcGxpdGlvbl9ub3RpZnkvIG1seHBsYXRfaTJjX21haW5fY29tcGxldGlvbl9ub3RpZnkN
Cg0KNC4NCg0KUmVuYW1pbmc6DQptbHhwbGF0X3ByZV9pbml0KCkvbWx4cGxhdF9wb3N0X2V4aXQo
KSB0bw0KCW1seHBsYXRfbG9naWNkZXZfaW5pdCgpL21seHBsYXRfbG9naWNkZXZfZXhpdCgpDQoN
Cm1seHBsYXRfaTJjX21haW5faW5pdCgpL21seHBsYXRfaTJjX21haW5fZXhpdCgpIGtlZXAgYXMg
aXMuDQoNCm1seHBsYXRfcG9zdF9pbml0KCkvbWx4cGxhdF9wcmVfZXhpdCgpIHRvDQoJbWx4cGxh
dF9wbGF0ZGV2c19pbml0KCkvbWx4cGxhdF9wbGF0ZGV2c19leGl0KCkNCg0KV2hhdCBkbyB5b3Ug
dGhpbms/DQoNClRoYW5rcywNClZhZGltLg0KDQo+IC0tDQo+ICBpLg0KPiANCj4gDQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L21seC1wbGF0Zm9ybS5jIHwgMSArDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGxhdGZvcm0veDg2L21seC1wbGF0Zm9ybS5jDQo+IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYv
bWx4LXBsYXRmb3JtLmMNCj4gPiBpbmRleCAzZDk2ZGJmNzlhNzIuLjY0NzAxYjYzMzM2ZSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9tbHgtcGxhdGZvcm0uYw0KPiA+ICsr
KyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L21seC1wbGF0Zm9ybS5jDQo+ID4gQEAgLTY1OTgsNiAr
NjU5OCw3IEBAIHN0YXRpYyBpbnQgbWx4cGxhdF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+ICpwZGV2KQ0KPiA+ICBmYWlsX3JlZ2lzdGVyX3JlYm9vdF9ub3RpZmllcjoNCj4gPiAgZmFp
bF9yZWdjYWNoZV9zeW5jOg0KPiA+ICAJbWx4cGxhdF9wcmVfZXhpdChwcml2KTsNCj4gPiArCW1s
eHBsYXRfaTJjX21haW5fZXhpdChwcml2KTsNCj4gPiAgZmFpbF9tbHhwbGF0X2kyY19tYWluX2lu
aXQ6DQo+ID4gIGZhaWxfcmVnbWFwX3dyaXRlOg0KPiA+ICBmYWlsX2FsbG9jOg0KPiA+DQo=
