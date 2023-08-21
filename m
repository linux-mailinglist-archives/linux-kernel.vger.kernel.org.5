Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0046F783138
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjHUTka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjHUTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:40:29 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2106.outbound.protection.outlook.com [40.107.95.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0461EE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:40:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9fEdQPH93ZVtYF75f9Nn9j/jcBE5vGzEty2pGxsizRi2vEy7sC8b+iLbaZNRMXwMKQhkgqnQzIsv077p6KWj5wzZrAPagrtGgY7vm4NSN1kodycLMAg0qxSb8zsfrzeWLOTW0ClT9an2OaiTq0W99D5WCKOg9QWEKXWq6LSbZu/oLE8tlwg4yu7JFykrKsc114uzOZwwGzRHl5/QcUJ7GE8uEbJRgU7URBx8Q2fqr8mTaip/aItCxwHWYxjTPDkeGk/csoGrg2VtwF+DD0X1O8L7UISwZcXtS4Y0XZ1N/Y8KGDXabFlJa3AXGR7ff99j8IHfeC2IR/tI8vwBQs4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8RU7JbY0OgZdNwC45amqpAy3PgnZlwhmVT5R+PU9SY=;
 b=P69tuNrkWnTgDzDibcjRgjuO1BKvSKg7ZQx1kl45b3z0tSKSwZbQbU4rpyPtY0kGORi6XeaSBq21bPg1n8NP4hRJIOM2oHvLz9B4vkF6aC/OqHWhY4QupMHSVydjWoHi1TtvKWitSJfHPA0Mft5lEInW9P/QWOh9ybUlIyKjUelrm/rUZDKjFVzy/thQPifBJ7uOTzuYMtPtZOTwFfrSl8Ere9Jq+JbgoQ/FIovzpszTP5K/WHR4vurc3bkzfyxXbWYTgPPyo3CmFDu0fGlzFZo2GK6PSdyIaQMfJW64YRCIqJSNbfhAovCpPNXtFY3KWU7E2dL5rU2p1WaFrSTNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8RU7JbY0OgZdNwC45amqpAy3PgnZlwhmVT5R+PU9SY=;
 b=GtBaJ8D0+Li2BQrVP7XZeUOZIive4cgac0ZFS53GHvllld4pqNNs4Tz+T2KpBAPIoUw6I26KcFYNuTCuBKtBIIKSfqSC1aiD76iCgOvWLmpQ82OD+iGgMZa2HDpcnC8M/XYmT5Mn71NJUGAd7E+A9eTiAiufY/ETYRB5Um0P0sE=
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 IA0PR01MB8330.prod.exchangelabs.com (2603:10b6:208:480::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Mon, 21 Aug 2023 19:40:23 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::9683:1d6b:f08e:2839]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::9683:1d6b:f08e:2839%4]) with mapi id 15.20.6609.022; Mon, 21 Aug 2023
 19:40:22 +0000
From:   Steve Clevenger OS <scclevenger@os.amperecomputing.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] coresight: tmc: Make etr buffer mode user configurable
 from sysfs
Thread-Topic: [PATCH V2] coresight: tmc: Make etr buffer mode user
 configurable from sysfs
Thread-Index: AdnUZ1M6iGMeEgepAUi2CrQniTDSNA==
Date:   Mon, 21 Aug 2023 19:40:22 +0000
Message-ID: <b2cf0173-c404-d7d6-9eb8-054e160ca4e5@os.amperecomputing.com>
References: <20230818082112.554638-1-anshuman.khandual@arm.com>
 <bedcf27e-b273-075f-3d7b-eb99b07e7c91@arm.com>
In-Reply-To: <bedcf27e-b273-075f-3d7b-eb99b07e7c91@arm.com>
Reply-To: Steve Clevenger OS <scclevenger@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:610:50::30) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR01MB8062:EE_|IA0PR01MB8330:EE_
x-ms-office365-filtering-correlation-id: 69000e47-9a19-4fd3-ac5a-08dba27e75b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPn9pfNAZVIvkA95S7yoL9PC1APAIYL3yHPVQnwJzVBnYZKfBlW0KZzAPGxQ8bHywv3qs0aBb6QKkjkHCn54PxTqD1hyBhS48vWqW6myMqQOP3y7sfsZxpnZG5dS9PoNIVDsc+KCHPa7j5nWmia5PZuSGy6uksyrGfN6gilYT27+ACsIxU9UxhaN1S8GfjmuyAxit4BGprZTZQI45aeOnhyxuIw9j6xhy6K5tQ1h4cBi89q25nxZYHiFxr+v7gsK7blbhbMcaAEPCsoMZ+K7U8GEyYaMqUgmu5ZCAASEuE1FS8rR5bXPZuit2sXJueyhS1s7phRP2IIxT49oLDL8+cr4rRSWuyATDWgIOSzNwOso94Bh/P3vECxeePV53nkpJ8QJeaiW8w8EItkRkoyxzkk021trsenUTlWVpIcTGBPFAlXm6ONSZkaP10BwWWVY0/wPdg+1yAjF3nTBZVwn7zHN1NWN6SeCR1iBb7rTH+g7Z1oXouegmET5gEHS63HuF0blrAJKu2nYJdTK+23EEDHiCBbSG1147sDuA3ubHUU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39850400004)(366004)(1800799009)(451199024)(186009)(71200400001)(8936002)(8676002)(4326008)(316002)(478600001)(66556008)(31686004)(966005)(66446008)(64756008)(110136005)(54906003)(66476007)(66946007)(41300700001)(6486002)(6506007)(6512007)(122000001)(38100700002)(66899024)(26005)(53546011)(5660300002)(2616005)(31696002)(2906002)(86362001)(3450700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjM1bmZHTm5UdkNGK3MzSnRlMEUyNXNyOHN3Zmx1Rmo1SHhQMys1cnlNRkVX?=
 =?utf-8?B?d0tZTWEwOWFISXRTN0JBQ0dZYytaelErb3BvakFDck1RY3hiOHpvdDkwTHk5?=
 =?utf-8?B?VFlvZzlVT1psSllWSXJJQWEvT0sxQW9yV0Z6VnRJZEVEclhOeU4rdmxEV3Y3?=
 =?utf-8?B?S0IyeU1Ia1RyWndibmtkaHBFN0pTUGpaQVlmS2h5OU1HMWFlWjh6ZHJQMlJq?=
 =?utf-8?B?amJjSVJ1NWcxclNLcGZLOTBVZzVaL1JNbWxLNnNzbHQ4OUtmazZOcmk2Y1lI?=
 =?utf-8?B?VEJ1dVZIeGN4TEF6SWQ0enJxY1dzYmNuNFQ4aUpnQW1ySFFjek1hLytMVEJD?=
 =?utf-8?B?eHlEc09WQTFTWGdIWENZN1d3ZzJ2Q3JwMkttdXdQb0xrK25SbkhYbUNVSm9n?=
 =?utf-8?B?cjA3eEJmWmlHbXNwOHB3VWkrLytDZjZVMGxTWDA3VnNMbW1lWTBWbzNMYmVP?=
 =?utf-8?B?YnVGMHdraGV3cVVYcksvYnBDZVk2M29scEZDUGM5aXpFQXN5TENRb3pBZ3Y2?=
 =?utf-8?B?b0x5Vk9CcGptem1xK2xPOXI0bC9sVXhuR3FJbGE3WnlRRFNESXRTdXBlT2xu?=
 =?utf-8?B?aTl1N21VVkk5Q2o2SU5zeGJBdDRZQmEzNlo3UmNTR2FzdVRTVWZhQVZJQUVp?=
 =?utf-8?B?NmorSSt4OFJmL1dQQzBwK0o3enI1bWl1dnhWTHdvM3duWXRSSmUvOUI5cFZS?=
 =?utf-8?B?TWdRNkNNd0JYU2FsOXZJRHp2N1dUdUJGMnFROXhMalV2Q0RoZzFsT01mK25V?=
 =?utf-8?B?ZVlHM1dFd1ZiS1NYejFvakpHY3JwTTR0Y0J2QUc0by9RWU9vZmRXNlFla2Zz?=
 =?utf-8?B?VXJaclIvSmp2Q0xqVlFDMS9kZmN1ZFNCNW1OZWtWSCswWDRDNVZoTm5WUEZp?=
 =?utf-8?B?Y2s3UTUwVXpkbkFWRDBXc2RucCt0cVlLc05ialAxamUvQXV4aGJ2MTNaUFIz?=
 =?utf-8?B?S2tRUDA4RXk0NmNMRlJCUEhDTGJweHh1a0wvc0dsSkhhOGJVNmxkdlZpaThl?=
 =?utf-8?B?ZTBhVVpKUmZLWlp2SWM0VS82Qlo4a0ZwUWtqZG9EWS82cTB4TWdPY1FmeE1H?=
 =?utf-8?B?MTA3R1JneUhiL1IrTzZsT0huZVEzNmxKOHkwdU4wMVRzcG9LUkdVZllkMnlO?=
 =?utf-8?B?OWpUaEUxcTFnekVoaVpvc2h3Q1VoNkZBUWwwZDZ4M1pBSS9HSm9PblZYanpx?=
 =?utf-8?B?WjNmZTVrUXlvc0xCTzRoTVpBbUJObjljYXdJNXFodGhzd0pVNXFFUlZHZWhw?=
 =?utf-8?B?bnJCUlp6bXdadTRTY2FmKzlPU21xTzNoRVdBL0FXS09sODBiNiswVzNkVzRa?=
 =?utf-8?B?SmJha3Y0NmdBWTVJN1lZcEhJS1ZQMEZ0dlZVWE9tVzNYaWJqMmtqYTBBei9s?=
 =?utf-8?B?OFFEZzgzaTNDSW55eGE0eEk4UHR0Yk9ibFRYcjhtb0o5SHpOZzZPOHo0Ulln?=
 =?utf-8?B?MWduQXZ5WTcyU0NTMWt6Wm1hYUJCQnpQZitQREdsdWdtclBqd0d6UnNRd2lo?=
 =?utf-8?B?eXpkZElxTEx2YmlTSVFrMTJrRng0dVc2Mk9PSWlQRXRqQk11TTF6UCtFQ2h2?=
 =?utf-8?B?VlhZeEwwUjRRMzBqNVlNWmN5bC96clpkWnJzM2pvQTQzbHFBSW8rR003VjYy?=
 =?utf-8?B?SFlnUFBUVjVMRW8xQmMvREh5b2hIZXMxZGhxZFBQRzVBZ1JvUWI3ZkV5Mkwy?=
 =?utf-8?B?WFkxTVAvYUVuODByQ0FGWGlkOGp6QURXb1pTcWowVi8zRWF2T3lpbHRtelNa?=
 =?utf-8?B?T1V1TTFtUjdKUWZpQjVaZFl0bktCSzlNM1lBd2hSYkw1UkM4N05oaHF1bm1K?=
 =?utf-8?B?NDJqdkUyTGh5M2RNMndOZ1NLc3o1SEJUUEFHT20yb3M5NWljYlVBalFjbkps?=
 =?utf-8?B?UWV3VUtYZGd5SlRMRkZVczlRUDcwOFQ2czhOQTd1Y054ODNTVk1ybkFlVVVl?=
 =?utf-8?B?ZkZBZVhoVmprNUhjK2U2VTFQYUFvaGRqV05MdkFUUjIzUmwrM1BLSkpRRzN2?=
 =?utf-8?B?ZnlhRWNwejR1TUlYK1VrcG1qVmMzVW4zTGEwN1NNUDRCaDRJUEt1TktZNXpB?=
 =?utf-8?B?Vm9lZUIveVR3S3lPWGlPVW96N1dtZndoeW5RREgyQk5BMlZ3emtWSzlVb2t3?=
 =?utf-8?B?S2pGMTY1bWw3dHJrZjZOSllwTXN3Z0RDM1o5bVhuY0liUXdCU0k2R1h4djJv?=
 =?utf-8?Q?btDJj5FHFulblmc/SyQDURS0u+xrtFDogStflb4L4Sb3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9B9F3525331B441AD49096B0E84030F@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69000e47-9a19-4fd3-ac5a-08dba27e75b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 19:40:22.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUjVktlgQRfQlw3bDacUFaIUiWNF7pdVkdIVCn/PgymokZln4lIS81LAxqGlsyMtliNG+7aK3yoexrvBW5NnskgacXV3IJxsXz5Zrv7dmLyGCPPwmf31dyD1OZJtr+ol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8330
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBTdXp1a2ksDQoNCkkgbWF5IGJlIGFibGUgdG8gdGVzdCBpdCB0aGlzIHdlZWsuIFlvdSd2
ZSBhbHJlYWR5IHBvaW50ZWQgbWUgYXQgdGhlDQpwYXRjaCB0aHJlYWQocykuIFRoZSBtYWluIGhv
bGR1cCBpcyBJIG5lZWQgdG8gbWVyZ2UgdGhlIDYuNiBwZW5kaW5nDQpwbGF0Zm9ybSB3b3JrIGlu
IG9yZGVyIHRvIHVzZSB0aGUgQW1wZXJlIEFDUEkuIEkgY291bGRuJ3QgZ2V0IHRoZXNlDQpwYXRj
aGVzIHRvIGFwcGx5IGRpcmVjdGx5IHRvIDYuNCBsYXN0IEkgdHJpZWQuDQoNClN0ZXZlIEMuDQoN
Ck9uIDgvMTgvMjAyMyAyOjM5IEFNLCBTdXp1a2kgSyBQb3Vsb3NlIHdyb3RlOg0KPiBDYzogU3Rl
dmUNCj4gDQo+IFN0ZXZlLA0KPiANCj4gQXJlIHlvdSBhYmxlIHRvIHRlc3QgdGhpcyB3aXRoIENB
VFUgPw0KPiANCj4gDQo+IE9uIDE4LzA4LzIwMjMgMDk6MjEsIEFuc2h1bWFuIEtoYW5kdWFsIHdy
b3RlOg0KPj4gQ3VycmVudGx5IFRNQy1FVFIgYXV0b21hdGljYWxseSBzZWxlY3RzIHRoZSBidWZm
ZXIgbW9kZSBmcm9tIGFsbA0KPj4gYXZhaWxhYmxlDQo+PiBtZXRob2RzIGluIHRoZSBmb2xsb3dp
bmcgc2VxdWVudGlhbGx5IGZhbGxiYWNrIG1hbm5lciAtIGFsc28gaW4gdGhhdA0KPj4gb3JkZXIu
DQo+Pg0KPj4gMS4gRkxBVCBtb2RlIHdpdGggb3Igd2l0aG91dCBJT01NVQ0KPj4gMi4gVE1DLUVU
Ui1TRyAoc2NhdHRlciBnYXRoZXIpIG1vZGUgd2hlbiBhdmFpbGFibGUNCj4+IDMuIENBVFUgbW9k
ZSB3aGVuIGF2YWlsYWJsZQ0KPj4NCj4+IEJ1dCB0aGlzIG9yZGVyIG1pZ2h0IG5vdCBiZSBpZGVh
bCBmb3IgYWxsIHNpdHVhdGlvbnMuIEZvciBleGFtcGxlIGlmDQo+PiB0aGVyZQ0KPj4gaXMgYSBD
QVRVIGNvbm5lY3RlZCB0byBFVFIsIGl0IG1heSBiZSBiZXR0ZXIgdG8gdXNlIFRNQy1FVFIgc2Nh
dHRlcg0KPj4gZ2F0aGVyDQo+PiBtZXRob2QsIHJhdGhlciB0aGFuIENBVFUuIEJ1dCBoYXJkIGNv
ZGluZyBzdWNoIG9yZGVyIGNoYW5nZXMgd2lsbCBwcmV2ZW50DQo+PiB1cyBmcm9tIHRlc3Rpbmcg
b3IgdXNpbmcgYSBwYXJ0aWN1bGFyIG1vZGUuIFRoaXMgY2hhbmdlIHByb3ZpZGVzDQo+PiBmb2xs
b3dpbmcNCj4+IG5ldyBzeXNmcyB0dW5hYmxlcyBmb3IgdGhlIHVzZXIgdG8gY29udHJvbCBUTUMt
RVRSIGJ1ZmZlciBtb2RlDQo+PiBleHBsaWNpdGx5LA0KPj4gaWYgcmVxdWlyZWQuIFRoaXMgYWRk
cyBmb2xsb3dpbmcgbmV3IHN5c2ZzIGZpbGVzIGZvciBidWZmZXIgbW9kZQ0KPj4gc2VsZWN0aW9u
DQo+PiBwdXJwb3NlIGV4cGxpY2l0bHkgaW4gdGhlIHVzZXIgc3BhY2UuDQo+Pg0KPj4gL3N5cy9i
dXMvY29yZXNpZ2h0L2RldmljZXMvdG1jX2V0cjxOPi9idWZfbW9kZXNfYXZhaWxhYmxlDQo+PiAv
c3lzL2J1cy9jb3Jlc2lnaHQvZGV2aWNlcy90bWNfZXRyPE4+L2J1Zl9tb2RlX3ByZWZlcnJlZA0K
Pj4NCj4+ICQgY2F0IGJ1Zl9tb2Rlc19hdmFpbGFibGUNCj4+IGF1dG8gZmxhdCB0bWMtc2cgY2F0
dcKgwqDCoCAtLS0tLS0tLS0tLS0tLS0tLS0+IFN1cHBvcnRlZCBUTUMtRVRSIGJ1ZmZlcg0KPj4g
bW9kZXMNCj4+DQo+PiAkIGVjaG8gY2F0dSA+IGJ1Zl9tb2RlX3ByZWZlcnJlZMKgwqAgLS0tLS0t
LT4gRXhwbGljaXQgYnVmZmVyIG1vZGUgcmVxdWVzdA0KPj4NCj4+IEJ1dCBleHBsaWNpdCB1c2Vy
IHJlcXVlc3QgaGFzIHRvIGJlIHdpdGhpbiBzdXBwb3J0ZWQgRVRSIGJ1ZmZlciBtb2Rlcw0KPj4g
b25seS4NCj4+IFRoZXNlIHN5c2ZzIGludGVyZmFjZSBmaWxlcyBhcmUgZXhjbHVzc2l2ZSB0byBF
VFIsIGFuZCBoZW5jZSB0aGVzZSBhcmUNCj4+IG5vdA0KPj4gYXZhaWxhYmxlIGZvciBvdGhlciBU
TUMgZGV2aWNlcyBzdWNoIGFzIEVUQiBvciBFVEYgZXRjLg0KPj4NCj4+IEEgbmV3IGF1dG8nIG1v
ZGUgKGkuZSBFVFJfTU9ERV9BVVRPKSBoYXMgYmVlbiBhZGRlZCB0byBoZWxwIGZhbGxiYWNrDQo+
PiB0byB0aGUNCj4+IGV4aXN0aW5nIGRlZmF1bHQgYmVoYXZpb3VyLCB3aGVuIHVzZXIgcHJvdmlk
ZWQgcHJlZmVycmVkIGJ1ZmZlciBtb2RlDQo+PiBmYWlscy4NCj4+IEVUUl9NT0RFX0ZMQVQgYW5k
IEVUUl9NT0RFX0FVVE8gYXJlIGFsd2F5cyBhdmFpbGFibGUgYXMgcHJlZmVycmVkIG1vZGVzLg0K
Pj4NCj4+IENjOiBTdXp1a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPg0KPj4g
Q2M6IE1pa2UgTGVhY2ggPG1pa2UubGVhY2hAbGluYXJvLm9yZz4NCj4+IENjOiBKYW1lcyBDbGFy
ayA8amFtZXMuY2xhcmtAYXJtLmNvbT4NCj4+IENjOiBMZW8gWWFuIDxsZW8ueWFuQGxpbmFyby5v
cmc+DQo+PiBDYzogQWxleGFuZGVyIFNoaXNoa2luIDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXgu
aW50ZWwuY29tPg0KPj4gQ2M6IGNvcmVzaWdodEBsaXN0cy5saW5hcm8ub3JnDQo+PiBDYzogbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+PiBDYzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogQW5zaHVtYW4gS2hhbmR1YWwgPGFuc2h1
bWFuLmtoYW5kdWFsQGFybS5jb20+DQo+PiAtLS0NCj4+IFRoaXMgYXBwbGllcyBvbiB2Ni41LXJj
Ng0KPj4NCj4+IENoYW5nZXMgaW4gVjI6DQo+Pg0KPj4gLSBSZW5hbWVkIHN5c2ZzIGZpbGUgZXRy
X2J1Zl9tb2Rlc19hdmFpbGFibGUgYXMgYnVmX21vZGVzX2F2YWlsYWJsZQ0KPj4gLSBSZW5hbWVk
IHN5c2ZzIGZpbGUgYnVmX21vZGVfY3VycmVudCBhcyBidWZfbW9kZV9wcmVmZXJyZWQNCj4+IC0g
UmVuYW1lZCBldHJfc3VwcG9ydHNfZmxhdF9tb2RlKCkgYXMgZXRyX2Nhbl91c2VfZmxhdF9tb2Rl
KCkNCj4+IC0gUmVuYW1lZCBjb3Jlc2lnaHRfdG1jX2dyb3Vwc1tdIGFzIGNvcmVzaWdodF9ldGZf
Z3JvdXBzW10NCj4+IC0gUmV1c2VkIGNvcmVzaWdodF90bWNfZ3JvdXBbXSBmb3IgdHJpZ2dlcl9j
bnRyIGFuZCBidWZmZXJfc2l6ZQ0KPj4gLSBGYWxsYmFjayB0cnlpbmcgRVRSX01PREVfQVVUTyB3
aGVuIHVzZXIgcHJlZmVycmVkIG1vZGUgZmFpbHMNCj4+IC0gTW92ZWQgRVRSIHN5c2ZzIGRldGFp
bHMgaW50byBjb3Jlc2lnaHQtdG1jLWV0ci5jDQo+PiAtIERyb3BwZWQgZXRyX2Nhbl91c2VfZmxh
dF9tb2RlKCkgY2hlY2sgd2hpbGUgb2ZmZXJpbmcgRVRSX01PREVfRkxBVA0KPj4gaW4gc3lzZnMN
Cj4+IC0gTW92ZWQgc3RydWN0IGV0cl9idWZfaHcgaW5zaWRlIGNvcmVzaWdodC10bWMtZXRyLmMN
Cj4+IC0gTW92ZWQgZ2V0X2V0cl9idWZfaHcoKSBhbmQgZXRyX2Nhbl91c2VfZmxhdF9tb2RlKCkg
aW5zaWRlDQo+PiBjb3Jlc2lnaHQtdG1jLWV0ci5jDQo+PiAtIFVwZGF0ZWQgbW9udGggaW4NCj4+
IERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLWNvcmVzaWdodC1kZXZpY2VzLXRt
Yw0KPj4NCj4+IENoYW5nZXMgaW4gVjE6DQo+Pg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjMwNzI4MDg0ODM3LjI3NjU1MS0xLWFuc2h1bWFuLmtoYW5kdWFsQGFybS5jb20vDQo+
Pg0KPj4gwqAgLi4uL3Rlc3Rpbmcvc3lzZnMtYnVzLWNvcmVzaWdodC1kZXZpY2VzLXRtY8KgwqAg
fMKgIDE2ICsrKw0KPj4gwqAgLi4uL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LXRtYy1j
b3JlLmPCoCB8wqAgMTUgKystDQo+PiDCoCAuLi4vaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2ln
aHQtdG1jLWV0ci5jwqDCoCB8IDExMSArKysrKysrKysrKysrKysrLS0NCj4+IMKgIGRyaXZlcnMv
aHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQtdG1jLmjCoMKgIHzCoMKgIDMgKw0KPj4gwqAg
NCBmaWxlcyBjaGFuZ2VkLCAxMzEgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+IA0K
PiANCj4gTG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IFN1enVraQ0KPiANCj4gDQo=
