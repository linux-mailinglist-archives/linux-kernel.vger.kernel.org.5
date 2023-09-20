Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4837A71AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 06:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjITE4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 00:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITE4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 00:56:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC56D7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 21:56:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5dOii8oPvRIgLDnucUFTZ8ffo+JqSXRN3TNofcGO/zF4uuCjDW0l+sl5nDfx5fVl/vNBwECrdPuL11aCpIl5phOE1B8tb0wZP1pXBruKUu5tZQHv71LrjrQ++th7IO9fGQ1xb+y+QnPCOXy/m+YF/23oTbfM3cNCfK/DnlFmPVvqyqKrE9TY5uted+RycEoB3D+/SG3jALUe+UOSrLnZmTRkeIa7LLqXmXVoHR8DU8J372mM6MmzruzsJ2Sv6e9YiAyPoSomb2P+FhQNkx9HcsWbmXQ8lgIqi57FXEEXZwxn72OHPJO2rAT3cRSmIBGrBCqM/DGo49PsyEzEZRAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfaULGnXuLTmoUIaa4oE34Xb6Z3i0INfdGZEB3gjDgE=;
 b=Vcq7H4VSC7aUZfJubopumm9kzodNHv2t48J+FuG+hkrUZRRq0ufOBfGke9j4JVAw8zsDzg2ppxITs59ygzhmn6tjMwe4NuihjlZWPATNR6SVn7SN2UhmrVdP31eMeQxSrlD/9C5/oVfvA3i58POTVQhJPWh3rKJolaHqz25FPrZozCelQuVFFiNz0dQxB7IMhhnLPV1HBsVWntOt5K0XDzeEV/mK0E5gLbc6Qbsav1NJP97upd/zykJBnb0Bh/q9PBRcMv0BWMRyWy0CtDHlX6bFaL8m7GSFQf7PRs1WU+crshMZd4IgCDgt29ppL/iO0Zt6uX4uDCYVeZSsW0+DnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfaULGnXuLTmoUIaa4oE34Xb6Z3i0INfdGZEB3gjDgE=;
 b=NclGrcmfB2Zp8BcUxCbJJ9MZcEk5uQ7a04unl0+snR+5GuY4WEPvQ71JPwXiD8cuJaOXRpOCd3d+v26l2kzT4+h24F3Emj3euB3nzSgtyWQ9xrzHWwvYtIA2Qd420b4/OsXhxlW6i5N8ct+RQ6u7ezlaCPSbL4i578WQFdIlL6E=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 04:56:35 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 04:56:35 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        Parav Pandit <parav@nvidia.com>,
        "virtio-comment@lists.oasis-open.org" 
        <virtio-comment@lists.oasis-open.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
Thread-Topic: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg
Thread-Index: AQHZ6u53lm7slkvYHEmC01qhzu9Vn7AiFHuAgAGJhYA=
Date:   Wed, 20 Sep 2023 04:56:34 +0000
Message-ID: <BL1PR12MB58498D05C8C2F9E7DBCF0978E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230919082802-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.6792.025)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DM3PR12MB9352:EE_
x-ms-office365-filtering-correlation-id: ea20b0fb-f2e5-4a70-525b-08dbb995f70a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: awCaxNzC6OdynC3IMf57IQgY3D3gBGAwMdMBkJd+tQP7+ixkwzE/+DP3tCqp7FA264UuA8YlmgCRtLSuq13k9FlcU06ubsuIHqELL2vSZ4pHubj/vjOyLD9AQXL7znEzyPlQcUyv9Beeb7/bKcmBdRTcjCSBU1GwCage2pcDVrPFCBjRcfMsAClrrMxzd+cosc/zz9eGVYPkVPdvC+D5psqt9iXfWyv5P3XNY7p4ylPggAo46VchjFKxsXZbJIWuBo73CSdlL7w9LH4nkQ+cCx0BFERKxqtKCdD3ZVX4pVJ+y8J1iP0WNYG+QPOqzlqjGwhtKxVvfDTsjOHNo0FKoHyxBfuOOYI0PvbLUXozPP0NrHzAS0Sp+TnsBgevhgUafstK4TPykJrkpV4YwewA4WHd4PV92lLk6iQwEFE4/WFpdQarVQrF0Fr00AwjpSP5gF8n/2pGoES1aNNHkYenRO4dOcjEx6/or+orBMJAJM+Q8isktv5QtR74De2N+lGR+tgosus2ut0gjJzQB9st9aHb2Z04G/EX7orhV/KMRrHcExc6Ni64Wh7RU89ncF2yq4LBLqrFYmqQ4eBZ/a3dSLCckJWxYGdIcVIyFLzeajJcKNNdT0SkCCHap14rUSPm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(186009)(451199024)(1800799009)(55016003)(66946007)(66476007)(2906002)(83380400001)(38100700002)(38070700005)(33656002)(9686003)(53546011)(7696005)(6506007)(71200400001)(478600001)(26005)(8676002)(8936002)(4326008)(5660300002)(41300700001)(316002)(7416002)(52536014)(122000001)(54906003)(64756008)(6916009)(66556008)(76116006)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0IrTmhsanhUc3h4NCsxZVFhZ2JKZm9JOFFhcVhQNW51N3dmT0lFMFNFVGhs?=
 =?utf-8?B?M0hUdllCNEpGSTl3WnloZnF6WFlxUTBscFRMeDVBRy9iYTBCTUNrT1JyL2FL?=
 =?utf-8?B?OUMwRzJUZWZwaDVra2tsZGVzVXArVkVZS09rb2QwVG84MmRIRjJSSHhNODZD?=
 =?utf-8?B?OE9FTVZtRTJhblIxN254L2lWcTV4b29ablIrcG8zTkNYMlNkYm5CbXJ1emZR?=
 =?utf-8?B?Q0ZHNThlZ0hBMVVtb1FDejFxbnc3alVhWmNmY2pkME5UdlB0azlJVXdmbkk3?=
 =?utf-8?B?L1hFUzg1TytFSE1kSUJtWk9tQ1IxY0FPZlZOaGFMTlJzTzlRZnNhbmZXYnFW?=
 =?utf-8?B?Q0cvaW1TTUlIVzl0S2VsdUpadWZHR3J5UVkraHBGaVdaMWc1djROcTdTRW5u?=
 =?utf-8?B?N3dQKzB2WHZJMnhNQnNCTnRWYmx0Y1BGMXROcVRYaCtoREg4Y0RVYlJZUFBn?=
 =?utf-8?B?OHRETCtCN1NWM0R2TmJpTjhkTGRkWUpKS09tTVN6RTNYelh3YWUwbE96QlJm?=
 =?utf-8?B?dmhBbEZ6SFJqNkZ1bmdOVmV0ckhtMVBBa1prTENuYkpuZUExZ0ZTOU52ZDZp?=
 =?utf-8?B?WTVGby9lbHpNTTBVejJKeXBqVkxkWjRDNDkvYm1GN1hqaDAvaExqMEVyaVhv?=
 =?utf-8?B?WE53eFVsd0hzK25EaTJkSnpQOUpMYUgvR2kybmRidWxvUnpvWWVnSi9HVTRO?=
 =?utf-8?B?QURhQjh6dUs1MGVPZ204aG1yaUZIaDVOVUVmQVJSRlVlV1kyMEZIa1h6bStM?=
 =?utf-8?B?NlhzS1JkS2lTcHNKY3ZHcmc3RjdiV1h6S1BQdEZQcDA1M3pKdmkxd2l1ZHhR?=
 =?utf-8?B?SUZKYTBsRENYK1hNR1F1TGRGamg2ZFZtaXhpMUVaNTh6cWpXRU9sR08weHhG?=
 =?utf-8?B?MzU4OUdwZWNuZ2J4UlkyM29CWXprelJweXV5ZU9yOWZCdDAyQnpadS8vTFVP?=
 =?utf-8?B?MURMRngrSUloU3BSSEFER0pMZlJQTVlHYmhMbjhVYTc1WERMeldkdWRmODVu?=
 =?utf-8?B?eDZIbEVNS2NlMHZoc1ZVbTBiWks4RnQ2MGNRSElHUWoyQzJuZTE5dHFQUG1P?=
 =?utf-8?B?VSt6SDJQZjYrTGdPcUgvcmRrNXRTbzFZdk1KSHJyV2VlVU1FUExRbEMwdkpj?=
 =?utf-8?B?SmNlNTN2dVp4WEs2OE1mWnhQRVNFMmhXVDluMGp3cW1OMFZFcjJqa1NMT0NW?=
 =?utf-8?B?ZXR1b2F1Vi9sYVJvYWQzR3RNamY4amMrb2Z4azMrSXEzdGtKOXI3NEhMVGFs?=
 =?utf-8?B?ZWhVVm5hUENhdnBnVHE5V3RFcTF2NlRUNmlSeFpVSzNUU0NIYzFHWVhlc3E5?=
 =?utf-8?B?b2lVM2dLRFluV001eXlwczdkV1NsVHJnaUw1NUpOMHIwUVFOamoxOTJXMG1p?=
 =?utf-8?B?SEtZc3BNSVZxUHBiRjRkM09acUhuZ1QyYjJETEpJUjlDemRROWlkRGpRZ01j?=
 =?utf-8?B?Y1pRRlQ3SkVnUXFLdFBIYkpPUjlzR043QkYzNlk3Qy9TVHBjcG5XSkcxRkxp?=
 =?utf-8?B?eUc5azdIczNNcnZScjF6cU1RUXBKVElMeDh6UE1OT2kwWGY2cGlOVWN3dEtw?=
 =?utf-8?B?ZDVMekZvWnN6a3ZvbllPMEpUTTR0czhBbkVYMmxKQTUxNUt5UndhdXBHa3Nx?=
 =?utf-8?B?SGt0UUVIR3QvZ290WXhMUjU2eFJ6Y3pwYkdoQVNQT2VHYlNlZ3lGeWNIbkd4?=
 =?utf-8?B?Vk1Ka2lKZXVGWDQ5SlpIVHQ5QWVoemdzZk81ZXY2cFJ0QktOWFlYNWFZM0kw?=
 =?utf-8?B?OXRpaFlUdHFUdVFyTk9VWG9CZ0twbXZlTnJHdHJYbG5kZ2E5YUtQS2Q1M0Fz?=
 =?utf-8?B?RDQ1ZkFsRFR2bVJDSFZxb2cvTkVzU1JCaU1POWpRUnAwVk1DbGtQeE83UWVq?=
 =?utf-8?B?dng4d0l1ZG54Q3R4QVNSYWM5MENzRmpOY1UwSGdQTGwwLzR0Z2NiK3NRSFgv?=
 =?utf-8?B?TEZJOFFaYWloam5uS0NkRENmSy9UTSs0RXBUcnF5b0ZBYXBTc0dEenBMd1p0?=
 =?utf-8?B?K1dBcWhHMUJIbGs2bXR0UHpQc3VMV3FRNDJxVTZnRk1mUHV2aVpqamJ1TytH?=
 =?utf-8?B?L3VlUFMzT1lQSC9LdTRmWFIyWkZCem9FajZXVUtzVVRLalV5aWRPQkZ6ZU0y?=
 =?utf-8?Q?pybA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F11F67E80DA402449B5535D2F0766777@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea20b0fb-f2e5-4a70-525b-08dbb995f70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 04:56:34.8719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYqG5KduxEDLR/ja/8MALDJyOiv6SSMhCYP00Ga6R8OgZWbnA+0t4mYodUbu7u1nTktdYu12xGGLI1PJ72x5fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFlbCBTLiBUc2lya2luLA0KDQpPbiAyMDIzLzkvMTkgMjA6MzEsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToNCj4gT24gVHVlLCBTZXAgMTksIDIwMjMgYXQgMDc6NDI6NDJQTSArMDgw
MCwgSmlxaWFuIENoZW4gd3JvdGU6DQo+PiBXaGVuIGd1ZXN0IHZtIGRvZXMgUzMsIFFlbXUgd2ls
bCByZXNldCBhbmQgY2xlYXIgc29tZSB0aGluZ3Mgb2YgdmlydGlvDQo+PiBkZXZpY2VzLCBidXQg
Z3Vlc3QgY2FuJ3QgYXdhcmUgdGhhdCwgc28gdGhhdCBtYXkgY2F1c2Ugc29tZSBwcm9ibGVtcy4N
Cj4+IEZvciBleGNhbXBsZSwgUWVtdSBjYWxscyB2aXJ0aW9fcmVzZXQtPnZpcnRpb19ncHVfZ2xf
cmVzZXQgd2hlbiBndWVzdA0KPj4gcmVzdW1lLCB0aGF0IGZ1bmN0aW9uIHdpbGwgZGVzdHJveSBy
ZW5kZXIgcmVzb3VyY2VzIG9mIHZpcnRpby1ncHUuIEFzDQo+PiBhIHJlc3VsdCwgYWZ0ZXIgZ3Vl
c3QgcmVzdW1lLCB0aGUgZGlzcGxheSBjYW4ndCBjb21lIGJhY2sgYW5kIHdlIG9ubHkNCj4+IHNh
dyBhIGJsYWNrIHNjcmVlbi4gRHVlIHRvIGd1ZXN0IGNhbid0IHJlLWNyZWF0ZSBhbGwgdGhlIHJl
c291cmNlcywgc28NCj4+IHdlIG5lZWQgdG8gbGV0IFFlbXUgbm90IHRvIGRlc3Ryb3kgdGhlbSB3
aGVuIFMzLg0KPj4NCj4+IEZvciBhYm92ZSBwdXJwb3NlLCB3ZSBuZWVkIGEgbWVjaGFuaXNtIHRo
YXQgYWxsb3dzIGd1ZXN0cyBhbmQgUUVNVSB0bw0KPj4gbmVnb3RpYXRlIHRoZWlyIHJlc2V0IGJl
aGF2aW9yLiBTbyB0aGlzIHBhdGNoIGFkZCBhIG5ldyBwYXJhbWV0ZXINCj4+IG5hbWVkIGZyZWV6
ZV9tb2RlIHRvIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcuIEFuZCB3aGVuIGd1ZXN0DQo+
PiBzdXNwZW5kcywgaXQgY2FuIHdyaXRlIGZyZWV6ZV9tb2RlIHRvIGJlIEZSRUVaRV9TMywgYW5k
IHRoZW4gdmlydGlvDQo+PiBkZXZpY2VzIGNhbiBjaGFuZ2UgdGhlaXIgcmVzZXQgYmVoYXZpb3Ig
b24gUWVtdSBzaWRlIGFjY29yZGluZyB0bw0KPj4gZnJlZXplX21vZGUuIFdoYXQncyBtb3JlLCBm
cmVlemVfbW9kZSBjYW4gYmUgdXNlZCBmb3IgYWxsIHZpcnRpbw0KPj4gZGV2aWNlcyB0byBhZmZl
Y3QgdGhlIGJlaGF2aW9yIG9mIFFlbXUsIG5vdCBqdXN0IHZpcnRpbyBncHUgZGV2aWNlLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4g
LS0tDQo+PiAgdHJhbnNwb3J0LXBjaS50ZXggfCA3ICsrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3RyYW5zcG9ydC1wY2kudGV4
IGIvdHJhbnNwb3J0LXBjaS50ZXgNCj4+IGluZGV4IGE1YzY3MTkuLjI1NDM1MzYgMTAwNjQ0DQo+
PiAtLS0gYS90cmFuc3BvcnQtcGNpLnRleA0KPj4gKysrIGIvdHJhbnNwb3J0LXBjaS50ZXgNCj4+
IEBAIC0zMTksNiArMzE5LDcgQEAgXHN1YnN1YnNlY3Rpb257Q29tbW9uIGNvbmZpZ3VyYXRpb24g
c3RydWN0dXJlIGxheW91dH1cbGFiZWx7c2VjOlZpcnRpbyBUcmFuc3BvcnQNCj4+ICAgICAgICAg
IGxlNjQgcXVldWVfZGVzYzsgICAgICAgICAgICAgICAgLyogcmVhZC13cml0ZSAqLw0KPj4gICAg
ICAgICAgbGU2NCBxdWV1ZV9kcml2ZXI7ICAgICAgICAgICAgICAvKiByZWFkLXdyaXRlICovDQo+
PiAgICAgICAgICBsZTY0IHF1ZXVlX2RldmljZTsgICAgICAgICAgICAgIC8qIHJlYWQtd3JpdGUg
Ki8NCj4+ICsgICAgICAgIGxlMTYgZnJlZXplX21vZGU7ICAgICAgICAgICAgICAgLyogcmVhZC13
cml0ZSAqLw0KPj4gICAgICAgICAgbGUxNiBxdWV1ZV9ub3RpZl9jb25maWdfZGF0YTsgICAvKiBy
ZWFkLW9ubHkgZm9yIGRyaXZlciAqLw0KPj4gICAgICAgICAgbGUxNiBxdWV1ZV9yZXNldDsgICAg
ICAgICAgICAgICAvKiByZWFkLXdyaXRlICovDQo+Pg0KPiANCj4gd2UgY2FuJ3QgYWRkIGZpZWxk
cyBpbiB0aGUgbWlkZGxlIG9mIHRoZSBzdHJ1Y3R1cmUgbGlrZSB0aGlzIC0NCj4gb2Zmc2V0IG9m
IHF1ZXVlX25vdGlmX2NvbmZpZ19kYXRhIGFuZCBxdWV1ZV9yZXNldCBjaGFuZ2VzLg0KSSBoYXZl
IGNvbmZ1c2VkIGFib3V0IHRoaXMuIEkgZm91bmQgaW4gbGF0ZXN0IGtlcm5lbCBjb2RlKG1hc3Rl
ciBicmFuY2gpOg0Kc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyB7DQoJLyogQWJvdXQgdGhl
IHdob2xlIGRldmljZS4gKi8NCglfX2xlMzIgZGV2aWNlX2ZlYXR1cmVfc2VsZWN0OwkvKiByZWFk
LXdyaXRlICovDQoJX19sZTMyIGRldmljZV9mZWF0dXJlOwkJLyogcmVhZC1vbmx5ICovDQoJX19s
ZTMyIGd1ZXN0X2ZlYXR1cmVfc2VsZWN0OwkvKiByZWFkLXdyaXRlICovDQoJX19sZTMyIGd1ZXN0
X2ZlYXR1cmU7CQkvKiByZWFkLXdyaXRlICovDQoJX19sZTE2IG1zaXhfY29uZmlnOwkJLyogcmVh
ZC13cml0ZSAqLw0KCV9fbGUxNiBudW1fcXVldWVzOwkJLyogcmVhZC1vbmx5ICovDQoJX191OCBk
ZXZpY2Vfc3RhdHVzOwkJLyogcmVhZC13cml0ZSAqLw0KCV9fdTggY29uZmlnX2dlbmVyYXRpb247
CQkvKiByZWFkLW9ubHkgKi8NCg0KCS8qIEFib3V0IGEgc3BlY2lmaWMgdmlydHF1ZXVlLiAqLw0K
CV9fbGUxNiBxdWV1ZV9zZWxlY3Q7CQkvKiByZWFkLXdyaXRlICovDQoJX19sZTE2IHF1ZXVlX3Np
emU7CQkvKiByZWFkLXdyaXRlLCBwb3dlciBvZiAyLiAqLw0KCV9fbGUxNiBxdWV1ZV9tc2l4X3Zl
Y3RvcjsJLyogcmVhZC13cml0ZSAqLw0KCV9fbGUxNiBxdWV1ZV9lbmFibGU7CQkvKiByZWFkLXdy
aXRlICovDQoJX19sZTE2IHF1ZXVlX25vdGlmeV9vZmY7CS8qIHJlYWQtb25seSAqLw0KCV9fbGUz
MiBxdWV1ZV9kZXNjX2xvOwkJLyogcmVhZC13cml0ZSAqLw0KCV9fbGUzMiBxdWV1ZV9kZXNjX2hp
OwkJLyogcmVhZC13cml0ZSAqLw0KCV9fbGUzMiBxdWV1ZV9hdmFpbF9sbzsJCS8qIHJlYWQtd3Jp
dGUgKi8NCglfX2xlMzIgcXVldWVfYXZhaWxfaGk7CQkvKiByZWFkLXdyaXRlICovDQoJX19sZTMy
IHF1ZXVlX3VzZWRfbG87CQkvKiByZWFkLXdyaXRlICovDQoJX19sZTMyIHF1ZXVlX3VzZWRfaGk7
CQkvKiByZWFkLXdyaXRlICovDQoNCglfX2xlMTYgZnJlZXplX21vZGU7CQkvKiByZWFkLXdyaXRl
ICovDQp9Ow0KVGhlcmUgaXMgbm8gcXVldWVfbm90aWZfY29uZmlnX2RhdGEgb3IgcXVldWVfcmVz
ZXQsIGFuZCBmcmVlemVfbW9kZSBJIGFkZGVkIGlzIGF0IHRoZSBlbmQuIFdoeSBpcyBpdCBkaWZm
ZXJlbnQgZnJvbSB2aXJ0aW8tc3BlYz8NCkkgYWRkIHRoZSBvZmZzZXQgZm9yIGZyZWV6ZV9tb2Rl
KFZJUlRJT19QQ0lfQ09NTU9OX0ZfTU9ERSksIGFuZCBjaGFuZ2UgdGhlIG9mZnNldCBvZiBRX05E
QVRBIGFuZCBRX1JFU0VUDQotI2RlZmluZSBWSVJUSU9fUENJX0NPTU1PTl9RX05EQVRBICAgICAg
NTYNCi0jZGVmaW5lIFZJUlRJT19QQ0lfQ09NTU9OX1FfUkVTRVQgICAgICA1OA0KKyNkZWZpbmUg
VklSVElPX1BDSV9DT01NT05fRl9NT0RFICAgICAgIDU2DQorI2RlZmluZSBWSVJUSU9fUENJX0NP
TU1PTl9RX05EQVRBICAgICAgNTgNCisjZGVmaW5lIFZJUlRJT19QQ0lfQ09NTU9OX1FfUkVTRVQg
ICAgICA2MA0KDQo+IA0KPiAgIA0KPj4gQEAgLTM5Myw2ICszOTQsMTIgQEAgXHN1YnN1YnNlY3Rp
b257Q29tbW9uIGNvbmZpZ3VyYXRpb24gc3RydWN0dXJlIGxheW91dH1cbGFiZWx7c2VjOlZpcnRp
byBUcmFuc3BvcnQNCj4+ICBcaXRlbVtcZmllbGR7cXVldWVfZGV2aWNlfV0NCj4+ICAgICAgICAg
IFRoZSBkcml2ZXIgd3JpdGVzIHRoZSBwaHlzaWNhbCBhZGRyZXNzIG9mIERldmljZSBBcmVhIGhl
cmUuICBTZWUgc2VjdGlvbiBccmVme3NlYzpCYXNpYyBGYWNpbGl0aWVzIG9mIGEgVmlydGlvIERl
dmljZSAvIFZpcnRxdWV1ZXN9Lg0KPj4gIA0KPj4gK1xpdGVtW1xmaWVsZHtmcmVlemVfbW9kZX1d
DQo+PiArICAgICAgICBUaGUgZHJpdmVyIHdyaXRlcyB0aGlzIHRvIHNldCB0aGUgZnJlZXplIG1v
ZGUgb2YgdmlydGlvIHBjaS4NCj4+ICsgICAgICAgIFZJUlRJT19QQ0lfRlJFRVpFX01PREVfVU5G
UkVFWkUgLSB2aXJ0aW8tcGNpIGlzIHJ1bm5pbmc7DQo+PiArICAgICAgICBWSVJUSU9fUENJX0ZS
RUVaRV9NT0RFX0ZSRUVaRV9TMyAtIGd1ZXN0IHZtIGlzIGRvaW5nIFMzLCBhbmQgdmlydGlvLXBj
aSBlbnRlcnMgUzMgc3VzcGVuc2lvbjsNCj4+ICsgICAgICAgIE90aGVyIHZhbHVlcyBhcmUgcmVz
ZXJ2ZWQgZm9yIGZ1dHVyZSB1c2UsIGxpa2UgUzQsIGV0Yy4NCj4+ICsNCj4gDQo+IHdlIG5lZWQg
dG8gc3BlY2lmeSB0aGVzZSB2YWx1ZXMgdGhlbi4NClRoYW5rcywgSSB3aWxsIGFkZCB0aGUgdmFs
dWVzLg0KDQo+IA0KPiB3ZSBhbHNvIG5lZWQNCj4gLSBmZWF0dXJlIGJpdCB0byBkZXRlY3Qgc3Vw
cG9ydCBmb3IgUzMNCkRvIEkgbmVlZCB0byBhZGQgZmVhdHVyZSBiaXQgdG8gREVGSU5FX1ZJUlRJ
T19DT01NT05fRkVBVFVSRVM/IEFuZCBlYWNoIHRpbWUgd2hlbiBJIHdyaXRlIGZyZWV6ZV9tb2Rl
IGZpbGVkIG9uIGtlcm5lbCBkcml2ZXIgc2lkZSwgSSBuZWVkIHRvIGNoZWNrIHRoaXMgYml0Pw0K
DQo+IC0gY29uZm9ybWFuY2Ugc3RhdGVtZW50cyBkb2N1bWVudGluZyBiZWhhdmlvdXMgdW5kZXIg
UzMNClNvcnJ5LCBJIGFtIG5vdCB2ZXJ5IHN1cmUuIERvIHlvdSBtZWFuIHdoZW4gZnJlZXplX21v
ZGUgaXMgc2V0IEZSRUVaRV9TMywgd2hhdCBvcGVyYXRpb25zIHNob3VsZCBkcml2ZXIgYW5kIGRl
dmljZSB0byBkbz8gQ2FuIHlvdSBlbGFib3JhdGUgb24gaXQsIG9yIGdpdmUgYW4gZXhhbXBsZT8N
Cg0KPiANCj4gDQo+PiAgXGl0ZW1bXGZpZWxke3F1ZXVlX25vdGlmX2NvbmZpZ19kYXRhfV0NCj4+
ICAgICAgICAgIFRoaXMgZmllbGQgZXhpc3RzIG9ubHkgaWYgVklSVElPX0ZfTk9USUZfQ09ORklH
X0RBVEEgaGFzIGJlZW4gbmVnb3RpYXRlZC4NCj4+ICAgICAgICAgIFRoZSBkcml2ZXIgd2lsbCB1
c2UgdGhpcyB2YWx1ZSB3aGVuIGRyaXZlciBzZW5kcyBhdmFpbGFibGUgYnVmZmVyDQo+PiAtLSAN
Cj4+IDIuMzQuMQ0KPiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==
