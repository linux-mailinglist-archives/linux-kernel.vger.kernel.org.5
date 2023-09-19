Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587BF7A61FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjISMEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:04:36 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A79EF2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFVXD/V9c2i3CnZv0VX8eMxyv/wBG2dczSZmUWOWCT+vxDYKK2kzmygZci00Lt5gS5P3VZJ+fbQQa5fBGocMLID/iqpcBJcz4n0sZivHwRacugZNormJTBLdyPJ3KWdKleM3JLNLH0XsDHfkx0ZRiOdwZ8crEQE0I5LOeYpRizrQ9gahNRM4gb9t0oKLjEihsD0qu0TWsqhEefzWm+75UntZrWaOspPGrcjbOot3uM9AYTpmiC22IiKTF8lYVSMKKfNn3lNEvtHb4TiWONs+Z4Sdd4Xl5RfsgdgdBaOkvMlEWPddIHAw+GplMnjFcLIRR1veliW8pqGxhG5hB+x9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEwSpQ9+H8YTUcgQFE435zJqoWnyXCTjjJu78mWpvD0=;
 b=cYrZN7KHcIJ3NhF1L2NstW2dQyeMEyDIQvx53NayACJDpU+vNY4EHM3QoASOJlV3EoSJBchPQkaCZQiLj8AONH9bq4mGj9D+Mdicgdd1HMbgceAALjtCX7DXX4MJa9np9h8LLRPoGqhu8cHAtd5673V+BMaIMMepPXjWqIeMyCf/JcNYcvIsaA1iVYLIvNpi3AFIUciXYKIIKjazuO334ix2JVMh8yYG/UQ4QcRV9JnPcPVGmryOZSxFqeDcNSHdq9+r/dmCNZP0PC4Z9/9WLvd5DFfbpD0LBIDe1sniNCcRWSuqxEkpyQavc/jBDF5RASJSBoLup+U1E4GT7xBsLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEwSpQ9+H8YTUcgQFE435zJqoWnyXCTjjJu78mWpvD0=;
 b=s7rAfkZbMGHTSmIRG6MZUWRyhZ8rIv3c6nmtE8QJWvCrSKOwsnLrr73QXsAU3xo3HP9JIz1dS4RGnnTGL8pjmXjtszvh5XgNiA3YfYzontfq+ZoykQQ+UE6qklpHG6QwLa8dr29YL8pvPPEC4qVMGbJ52mj8FQ7yJAGzGjfslC4=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 12:04:24 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::242f:c454:9ff8:3e98%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 12:04:24 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
CC:     Gerd Hoffmann <kraxel@redhat.com>,
        =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
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
Subject: Re: [virtio-dev] [RESEND VIRTIO GPU PATCH v3 1/1] virtio-gpu: Add new
 feature flag VIRTIO_GPU_F_FREEZE_S3
Thread-Topic: [virtio-dev] [RESEND VIRTIO GPU PATCH v3 1/1] virtio-gpu: Add
 new feature flag VIRTIO_GPU_F_FREEZE_S3
Thread-Index: AQHZ5Jd4vAiT0dEvAkWqbdFs9IHp77AV0i8AgAzMBwA=
Date:   Tue, 19 Sep 2023 12:04:24 +0000
Message-ID: <BL1PR12MB5849327D32AA77C793E8E625E7FAA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230911100430.1408168-1-Jiqian.Chen@amd.com>
 <20230911100430.1408168-2-Jiqian.Chen@amd.com>
 <FR0P281MB286152665C939C9CE291CE63BCF2A@FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR0P281MB286152665C939C9CE291CE63BCF2A@FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH0PR12MB7885:EE_
x-ms-office365-filtering-correlation-id: bd96e5fc-e2aa-43ae-4215-08dbb9089104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nuqkuePyiLrg+suKEyWHGphmeMBBA7z8Ilw/ZAGVOdbX7UutDnq7KxzU0X/JO5tZf0Wwww62zlpn9qYhBhmAxgzYmKxNtLAFAExJiEh3g8l7sZP3uBHwzMHP7j1rVZc8GsImqBHZwe2b7IJN7a8//D/QmP0cLnudRBNPxlf3eevZGJ8Ngm9i4FO9mEJeiwA/4oVxMe2S2ouOcYOoE79SkEd7ldfIVcVp9J+nk+R+Ls2mblCbHG7Spc9F5OrJQzZFJ+gwZDJjjXXkKQaJQHpWQLGoSJNQmesmMxuW9TJ/WC0MjqaKZXX2eYImtc7dtA3908GSLGb+FPUrxWBIyIe613qEEmNK4ERrRvL0ZGDfBo6ZTxYvt/pSA1hHw02EZtNFqs4ngOTAeQkYpIZy6CbzlQ50Kc+weF3ITSJF8Va2m2UjNeIOgG5uPNQFLkf8vWiTDPyNH159ZwxdUVnJvndZa5Cc2Tn6HfLdFaaSvoRAx6keQCViU/O1sHf2tV1TFNntbMA7li+Cev85RxePtW5KSCKEOmW6A+TQZX2mpYubXJWERWLoqniwZJWiE59BGyYN1Uisc6QSRbbhgTtNUyeEyQbgFr6rjZqKnNJhBwwzJd0JM27ZhQghlHOHzIZvJifluEGYHxa7H3u3i7iBEzOfXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199024)(1800799009)(186009)(38070700005)(122000001)(66899024)(38100700002)(55016003)(33656002)(15974865002)(478600001)(966005)(66476007)(64756008)(54906003)(66446008)(66556008)(6916009)(66946007)(71200400001)(76116006)(2906002)(9686003)(53546011)(6506007)(7696005)(8676002)(8936002)(52536014)(5660300002)(4326008)(7416002)(41300700001)(316002)(66574015)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVhJRDY0bDI0VVhDaVZkdnlJc0pEejFsWkZoTUpyOEpTcjZZdW92MTY0a2U2?=
 =?utf-8?B?S296WFAyZ1hvM0VRZkdMQVRVOWU1aytlN01XZDUremZyMGFRSGRBemJQSnVw?=
 =?utf-8?B?bDViWklEbitWbTQ2K2U4QUN1TUtXRFpNVnNjRmNaajFLWXV0YlNwbzNKblhW?=
 =?utf-8?B?dHNFMm5ZSExPRnlNL0RGL1VZN0tsNGRyaEZRNVNnNE1XUUZweEt6SGdiM0R2?=
 =?utf-8?B?UC9FT3dmdWFjUUo1YWJkUlRRVTdsd3dhNiszNC9YQTB0cjY0WWY3Qno4RDFW?=
 =?utf-8?B?NkVDMjlhMi9qa0RqOFFoam9aZnNZSVk3M0xWeVFNSlgzU2o3UmJvbnNpMXIw?=
 =?utf-8?B?cnNncXQzaTRaYS9jMUE1M0ZRU2duNUFwMWtvNnkwTGNOVDJuVGJNc2pTK3NT?=
 =?utf-8?B?LzZMbFEwcU5YU2tsdzZJSE5OdjlTaGxqcW1mc3RISGNQcDg1cGp3bVMwUTN1?=
 =?utf-8?B?VkQxTGN4eGdLVXJub1BQdDdGVUJmMDhYdWVhREFPYVdjSzdQalFhUUtwTXFs?=
 =?utf-8?B?dGhwQkYyVjFqSXRxbUs2WUorK2dkbm1EbTRqUWxnc0tFUUhvNkZKcnY2Y09H?=
 =?utf-8?B?dDE4V0xLbHpIbFFlVFUxaFpRQk1ldlRHSFNDTkE3R04wQlBJNjFrZGJWREkz?=
 =?utf-8?B?cElxQk1OY3Fhd2NacnhyK1F6ZUFhUEdTNUdkYmlFNmI3eTcwdjdJTFk0NzY4?=
 =?utf-8?B?UTM3TGxldFp0djZUWGU4cFJLSGI0RTNSdGltRFNmTkVrTHRUT0FGVW8wYWpK?=
 =?utf-8?B?TVY1LzZrMThwR1htcHl5czdnQzF1MkMyWFdSbmtpWnpqN0ExOGYvNHhMaTlE?=
 =?utf-8?B?R1NMWUhhcnhkQ2x5SVhmVHh6ZEV4WEFuckl3QWFDRWh5L2JvSjg0L25HQlVF?=
 =?utf-8?B?TllHNlB5bkc5ZlpwM1kvVStLeXkraUVjOG1sWmRxN0RDL21ySk4xdzZydThy?=
 =?utf-8?B?WEhUWVREUGpBbGxwU3BPc0dSZWpjZGxCcGtTT2gvaE9hMEV5blg0YWM1bWRS?=
 =?utf-8?B?aWcwVTZCNDJkVWNkMXcrc0pqcVh5R3FWL2hZN0xDSGdEVk92R1R4M3A0NUNV?=
 =?utf-8?B?VjdGOUZkaWFvWmZEejBvSVNvSFBqZlVZOVF0NysrYW1zUFcrbFl4MTQ2MHov?=
 =?utf-8?B?TlV5c2hwOUkxQUtNR1hiV0xjeU5KcFJidlFDazF0YjNwcGRrY0JJbkZXZ2tS?=
 =?utf-8?B?SjRuMHlESTFBQS91NkpHWUVra0o0elNPRW40YWNRQWRsRUdNU1h5ZlJoVEJi?=
 =?utf-8?B?TDJ5UzcvY0VJM0M0anhvc2JpcEx1eTJnSExmeVladjRzVGExOHl2dlhURjZi?=
 =?utf-8?B?NUk0Zkd3S3c5N1MvVlp2ZlV3VGxxMlNURWhkN1BrMzliZFA1R2pZQ1BFOXdO?=
 =?utf-8?B?ZnJ4TDBKTjFzTTcwRWQrRnNYcEF4VENTR1RrSG1ZYkdIV3o1SDRiVmgyL1gy?=
 =?utf-8?B?SWI2MmlNcjJ6Y1ZkYjNWNGpzb2xTWE1hMlM0Rk0wb3RURjk2eE1XMjVHamZD?=
 =?utf-8?B?M2g5eHljWTBEZXZaK2ZlYjA5T01TTGlyMFpFekgrQTI5bWtNbndzZzl5a09M?=
 =?utf-8?B?dXQxZncxb09OeEEydDJTTFJWRGZLU09qbnZIZU1lSXQvKzlnTytvVC9EQXVX?=
 =?utf-8?B?b2RaYnVJano2clhUZnJDRnRPRmRWNHErRUFTUThEQ1R6dE81cW9CaE5ZTVl6?=
 =?utf-8?B?RFdNVjh2ZWlYZzl0bjlWaUlCVjkyQVlWVVd2V3RWbWtTc1NWaUtJWnB2SXpq?=
 =?utf-8?B?c2pjVjErSFBIVFNMYkVQN2pSUFcrcXpmNjdsenpnV1l3c0VKeTNnTFhwRkpT?=
 =?utf-8?B?aU5BaWJaZWdycUd3VjAvYjRVS04xTHlPRk84QzNrWlJzYTloNnFVQ0lqaEx5?=
 =?utf-8?B?djAzUkk2OFBDVlh0TEM0dFBrKzlSV1AvUmJBUnZoa1g0cFR5TjNWWnVaaGdV?=
 =?utf-8?B?SnVmK0pWQW9INjFyYkxJNGhEejlxc2V2WitGUnVvSmgvRmdtZ3ZwUTAvb2VT?=
 =?utf-8?B?QnE0VlpzMnNnNnA2WUd6ZzBZYXlYWWNBUEJTSUpXbzAvTk1lOU5iSjNJcDVN?=
 =?utf-8?B?UmxRanRmeDdOYXFhYWZNSUFpZzBWWWtweGtmMTBLOVBFZkhDVUgvbnNrK1VD?=
 =?utf-8?Q?bnvo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B14C83C68380843ACAFABDFCCEF2C16@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd96e5fc-e2aa-43ae-4215-08dbb9089104
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 12:04:24.6792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nob6f92teopDQzZmEZ2NmJbSEs+KBRhb7+oN5kOqEA4HNUqmHjHegDzEXNwp0XXI1o6sA2zKy2O3t0WIlr97oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlraGFpbCBHb2x1YmV2LUNpdWNoZWEsDQoNCkkgaGF2ZSBpbXByb3ZlZCB0aGlzIGltcGxl
bWVudGF0aW9uIHRvIHRoZSB2aXJ0aW8gcGNpIGxldmVsLiBDb3VsZCB5b3UgcGxlYXNlIHRyeSBt
eSBwYXRjaGVzIGFuZCBzZWUgaWYgdGhlbSBhcmUgdXNlZnVsIGluIHlvdXIgc2NlbmU/DQpNeSBu
ZXcgc2VyaWVzOg0KVjUgb2YgUWVtdSBwYXRjaDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Fl
bXUtZGV2ZWwvMjAyMzA5MTkxMTAyMjUuMjI4MjkxNC0xLUppcWlhbi5DaGVuQGFtZC5jb20vVC8j
dA0KVjUgb2Yga2VybmVsIHBhdGNoOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIz
MDkxOTEwNDYwNy4yMjgyMjQ4LTEtSmlxaWFuLkNoZW5AYW1kLmNvbS9ULyN0DQpWNSBvZiB2aXJ0
aW8tc3BlYyBwYXRjaDoNCmh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmly
dGlvLWNvbW1lbnQvMjAyMzA5L21zZzAwMjQ1Lmh0bWwNCg0KDQpPbiAyMDIzLzkvMTIgMDA6MzMs
IE1pa2hhaWwgR29sdWJldi1DaXVjaGVhIHdyb3RlOg0KPiBIaSBKaXFpYW4sDQo+IA0KPiBUaGFu
a3MgZm9yIHRoZSBwcm9wb3NhbC4NCj4gDQo+IFNvbWUgdGltZSBhZ28gSSB3YXMgd29ya2luZyBv
biB0aGUgc2FtZSBpc3N1ZSB3aXRoIHN1c3BlbmRpbmcgdGhlIGdwdSBkZXZpY2UNCj4gKG9uIGFy
bSkuICBBZGRpdGlvbmFsbHksIEkgaGFkIHRyb3VibGVzIHdpdGggdmlydGlvLXZpZGVvIGRldmlj
ZSBhcyB3ZWxsLCBzZWUNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIxMTIxNTE3
MjczOS5HQTc3MjI1QG9wZW5zeW5lcmd5LmNvbS9ULyBmb3INCj4gZGV0YWlscy4NCj4gDQo+IElu
IHlvdXIgY2FzZSwgdGhlDQo+IFZJUlRJT19HUFVfRlJFRVpFX01PREVfRlJFRVpFX1MzL1ZJUlRJ
T19HUFVfRlJFRVpFX01PREVfVU5GUkVFWkUgZG8gaW5mbHVlbmNlDQo+IGhvdyByZXNldCBpcyBi
ZWluZyBoYW5kbGVkIGJ5IFFlbXUsIGlzIHRoaXMgY29ycmVjdD8gIFNpbmNlIG11bHRpcGxlIGRl
dmljZXMNCj4gY2FuIGJlbmVmaXQgZnJvbSB0aGUgc2FtZSBtZWNoYW5pc20sIHdvdWxkIGl0IGJl
IHBvc3NpYmxlIHRvOiBhKSBoYXZlIGEgbW9yZQ0KPiBnZW5lcmljLCBub24gQUNQSS1iYXNlZCBu
YW1lLCBiKSBtYWtlIHRoZSBmZWF0dXJlIGdlbmVyaWMsIGFwcGxpY2FibGUgdG8gb3RoZXINCj4g
ZGV2aWNlcyBhcyB3ZWxsPw0KPiANCj4gDQo+IEJlc3Qgd2lzaGVzLA0KPiBNaWtoYWlsIEdvbHVi
ZXYtQ2l1Y2hlYQ0KPiANCj4gDQo+IA0KPiAtLQ0KPiANCj4gTWlraGFpbCBHb2x1YmV2LUNpdWNo
ZWENCj4gDQo+IA0KPiBPcGVuU3luZXJneSBHbWJIDQo+IA0KPiBSb3RoZXJzdHIuIDIwLCAxMDI0
NSBCZXJsaW4NCj4gDQo+IFRlbGVmb246ICs0OSAoMzApIDYwIDk4IDU0IDAgLSA5MDMNCj4gDQo+
IEVNYWlsOiAgIG1pa2hhaWwuZ29sdWJldkBvcGVuc3luZXJneS5jb20NCj4gDQo+IHd3dy5vcGVu
c3luZXJneS5jb20NCj4gDQo+IEhhbmRlbHNyZWdpc3Rlci9Db21tZXJjaWFsIFJlZ2lzdHJ5OiBB
bXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZywgSFJCIDEwODYxNkINCj4gDQo+IEdlc2Now6RmdHNm
w7xocmVyL01hbmFnaW5nIERpcmVjdG9yOiBSZWdpcyBBZGphbWFoDQo+IA0KPiANCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBGcm9tOiB2aXJ0aW8tZGV2QGxp
c3RzLm9hc2lzLW9wZW4ub3JnIDx2aXJ0aW8tZGV2QGxpc3RzLm9hc2lzLW9wZW4ub3JnPiBvbiBi
ZWhhbGYgb2YgSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgU2VwdGVtYmVyIDExLCAyMDIzIDEyOjA0IFBNDQo+IFRvOiBHZXJkIEhvZmZtYW5uOyBNYXJj
LUFuZHLDqSBMdXJlYXU7IFJvYmVydCBCZWNrZXR0OyB2aXJ0aW8tY29tbWVudEBsaXN0cy5vYXNp
cy1vcGVuLm9yZzsgdmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZw0KPiBDYzogcWVtdS1k
ZXZlbEBub25nbnUub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTdGVmYW5vIFN0
YWJlbGxpbmk7IFJvZ2VyIFBhdSBNb25uw6k7IEFsZXggRGV1Y2hlcjsgQ2hyaXN0aWFuIEtvZW5p
ZzsgU3Rld2FydCBIaWxkZWJyYW5kOyBYZW5pYSBSYWdpYWRha291OyBIb25nbGVpIEh1YW5nOyBK
dWxpYSBaaGFuZzsgSHVhbmcgUnVpOyBKaXFpYW4gQ2hlbg0KPiBTdWJqZWN0OiBbdmlydGlvLWRl
dl0gW1JFU0VORCBWSVJUSU8gR1BVIFBBVENIIHYzIDEvMV0gdmlydGlvLWdwdTogQWRkIG5ldyBm
ZWF0dXJlIGZsYWcgVklSVElPX0dQVV9GX0ZSRUVaRV9TMw0KPiANCj4gV2hlbiB3ZSBzdXNwZW5k
L3Jlc3VtZSBndWVzdCBvbiBYZW4sIHRoZSBkaXNwbGF5IGNhbid0IGNvbWUgYmFjay4NCj4gVGhp
cyBpcyBiZWNhdXNlIHdoZW4gZ3Vlc3Qgc3VzcGVuZGVkLCBpdCBjYWxsZWQgaW50byBRZW11LiBU
aGVuDQo+IFFlbXUgZGVzdHJveWVkIGFsbCByZXNvdXJjZXMgd2hpY2ggaXMgdXNlZCBmb3IgZGlz
cGxheS4gU28gdGhhdA0KPiBndWVzdCdzIGRpc3BsYXkgY2FuJ3QgY29tZSBiYWNrIHRvIHRoZSB0
aW1lIHdoZW4gaXQgd2FzIHN1c3BlbmRlZC4NCj4gDQo+IFRvIHNvbHZlIGFib3ZlIHByb2JsZW0s
IEkgYWRkZWQgYSBuZXcgbWVjaGFuaXNtIHRoYXQgd2hlbiBndWVzdCBpcw0KPiBzdXNwZW5kaW5n
LCBpdCB3aWxsIG5vdGlmeSBRZW11LCBhbmQgdGhlbiBRZW11IHdpbGwgbm90IGRlc3Ryb3kNCj4g
cmVzb3VyY2VzaSB3aGljaCBhcmUgY3JlYXRlZCBieSB1c2luZyBjb21tYW5kcw0KPiBWSVJUSU9f
R1BVX0NNRF9SRVNPVVJDRV9DUkVBVEVfKi4NCj4gDQo+IER1ZSB0byB0aGF0IG1lY2hhbmlzbSBu
ZWVkcyBjb29wZXJhdGlvbiBiZXR3ZWVuIGd1ZXN0IGFuZCBob3N0LA0KPiBJIG5lZWQgdG8gYWRk
IGEgbmV3IGZlYXR1cmUgZmxhZywgc28gdGhhdCBndWVzdCBhbmQgaG9zdCBjYW4NCj4gbmVnb3Rp
YXRlIHdoZW5ldmVyIGZyZWV6ZV9TMyBpcyBzdXBwb3J0ZWQgb3Igbm90Lg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+IC0tLQ0KPiAgZGV2
aWNlLXR5cGVzL2dwdS9kZXNjcmlwdGlvbi50ZXggfCA0MiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kZXZpY2UtdHlwZXMvZ3B1L2Rlc2NyaXB0aW9uLnRleCBiL2RldmljZS10eXBl
cy9ncHUvZGVzY3JpcHRpb24udGV4DQo+IGluZGV4IDQ0MzUyNDguLjFhMTM3ZTcgMTAwNjQ0DQo+
IC0tLSBhL2RldmljZS10eXBlcy9ncHUvZGVzY3JpcHRpb24udGV4DQo+ICsrKyBiL2RldmljZS10
eXBlcy9ncHUvZGVzY3JpcHRpb24udGV4DQo+IEBAIC0zNyw2ICszNyw4IEBAIFxzdWJzZWN0aW9u
e0ZlYXR1cmUgYml0c31cbGFiZWx7c2VjOkRldmljZSBUeXBlcyAvIEdQVSBEZXZpY2UgLyBGZWF0
dXJlIGJpdHN9DQo+ICAgIHJlc291cmNlcyBpcyBzdXBwb3J0ZWQuDQo+ICBcaXRlbVtWSVJUSU9f
R1BVX0ZfQ09OVEVYVF9JTklUICg0KV0gbXVsdGlwbGUgY29udGV4dCB0eXBlcyBhbmQNCj4gICAg
c3luY2hyb25pemF0aW9uIHRpbWVsaW5lcyBzdXBwb3J0ZWQuICBSZXF1aXJlcyBWSVJUSU9fR1BV
X0ZfVklSR0wuDQo+ICtcaXRlbVtWSVJUSU9fR1BVX0ZfRlJFRVpFX1MzICg1KV0gZnJlZXppbmcg
dmlydGlvLWdwdSBhbmQga2VlcGluZyByZXNvdXJjZXMNCj4gKyAgYWxpdmUgaXMgc3VwcG9ydGVk
Lg0KPiAgXGVuZHtkZXNjcmlwdGlvbn0NCj4gDQo+ICBcc3Vic2VjdGlvbntEZXZpY2UgY29uZmln
dXJhdGlvbiBsYXlvdXR9XGxhYmVse3NlYzpEZXZpY2UgVHlwZXMgLyBHUFUgRGV2aWNlIC8gRGV2
aWNlIGNvbmZpZ3VyYXRpb24gbGF5b3V0fQ0KPiBAQCAtMjI4LDYgKzIzMCw5IEBAIFxzdWJzdWJz
ZWN0aW9ue0RldmljZSBPcGVyYXRpb246IFJlcXVlc3QgaGVhZGVyfVxsYWJlbHtzZWM6RGV2aWNl
IFR5cGVzIC8gR1BVIERlDQo+ICAgICAgICAgIFZJUlRJT19HUFVfQ01EX1VQREFURV9DVVJTT1Ig
PSAweDAzMDAsDQo+ICAgICAgICAgIFZJUlRJT19HUFVfQ01EX01PVkVfQ1VSU09SLA0KPiANCj4g
KyAgICAgICAgLyogZnJlZXplIG1vZGUgKi8NCj4gKyAgICAgICAgVklSVElPX0dQVV9DTURfU0VU
X0ZSRUVaRV9NT0RFID0gMHgwNDAwLA0KPiArDQo+ICAgICAgICAgIC8qIHN1Y2Nlc3MgcmVzcG9u
c2VzICovDQo+ICAgICAgICAgIFZJUlRJT19HUFVfUkVTUF9PS19OT0RBVEEgPSAweDExMDAsDQo+
ICAgICAgICAgIFZJUlRJT19HUFVfUkVTUF9PS19ESVNQTEFZX0lORk8sDQo+IEBAIC04MzgsNiAr
ODQzLDQzIEBAIFxzdWJzdWJzZWN0aW9ue0RldmljZSBPcGVyYXRpb246IGN1cnNvcnF9XGxhYmVs
e3NlYzpEZXZpY2UgVHlwZXMgLyBHUFUgRGV2aWNlIC8NCj4gDQo+ICBcZW5ke2Rlc2NyaXB0aW9u
fQ0KPiANCj4gK1xzdWJzdWJzZWN0aW9ue0RldmljZSBPcGVyYXRpb246IGZyZWV6ZV9tb2RlfVxs
YWJlbHtzZWM6RGV2aWNlIFR5cGVzIC8gR1BVIERldmljZSAvIERldmljZSBPcGVyYXRpb24gLyBE
ZXZpY2UgT3BlcmF0aW9uOiBmcmVlemVfbW9kZX0NCj4gKw0KPiArXGJlZ2lue2xzdGxpc3Rpbmd9
DQo+ICt0eXBlZGVmIGVudW0gew0KPiArICBWSVJUSU9fR1BVX0ZSRUVaRV9NT0RFX1VORlJFRVpF
ID0gMCwNCj4gKyAgVklSVElPX0dQVV9GUkVFWkVfTU9ERV9GUkVFWkVfUzMgPSAzLA0KPiArfSB2
aXJ0aW9fZ3B1X2ZyZWV6ZV9tb2RlX3Q7DQo+ICsNCj4gK3N0cnVjdCB2aXJ0aW9fZ3B1X3NldF9m
cmVlemVfbW9kZSB7DQo+ICsgIHN0cnVjdCB2aXJ0aW9fZ3B1X2N0cmxfaGRyIGhkcjsNCj4gKyAg
dmlydGlvX2dwdV9mcmVlemVfbW9kZV90IGZyZWV6ZV9tb2RlOw0KPiArfTsNCj4gK1xlbmR7bHN0
bGlzdGluZ30NCj4gKw0KPiArXGJlZ2lue2Rlc2NyaXB0aW9ufQ0KPiArDQo+ICtcaXRlbVtWSVJU
SU9fR1BVX0NNRF9TRVRfRlJFRVpFX01PREVdDQo+ICtOb3RpZnkgZnJlZXplIG1vZGUgdGhyb3Vn
aCBjb250cm9scS4NCj4gK1JlcXVlc3QgZGF0YSBpcyBcZmllbGR7c3RydWN0IHZpcnRpb19ncHVf
c2V0X2ZyZWV6ZV9tb2RlfS4NCj4gK1Jlc3BvbnNlIHR5cGUgaXMgVklSVElPX0dQVV9SRVNQX09L
X05PREFUQS4NCj4gKw0KPiArVGhpcyBpcyBhZGRlZCBmb3IgUzMgZnVuY3Rpb24gaW4gZ3Vlc3Qg
d2l0aCB2aXJ0aW8tZ3B1LiBXaGVuIGd1ZXN0IGRvZXMNCj4gK1MzLCBsZXQgaXQgbm90aWZ5IFFF
TVUgdGhhdCB2aXJ0aW8tZ3B1IGlzIGluIHdoYXQgZnJlZXplIG1vZGUgaW4NCj4gK1xmaWVsZHtm
cmVlemVfbW9kZX0uIFZJUlRJT19HUFVfRlJFRVpFX01PREVfRlJFRVpFX1MzIG1lYW5zIGd1ZXN0
IGlzDQo+ICtkb2luZyBTMyBhbmQgdmlydGlvLWdwdSB3aWxsIGJlIGZyZWV6ZWQsIFZJUlRJT19H
UFVfRlJFRVpFX01PREVfVU5GUkVFWkUNCj4gK21lYW5zIHZpcnRpby1ncHUgY2FuIGJlIHVzZWQg
YXMgdXN1YWwuIFdoZW4gdmlydGlvLWdwdSBpcyBmcmVlemVkLCBRRU1VDQo+ICt3aWxsIG5vdCBk
ZXN0cm95IHJlc291cmNlcyB3aGljaCBhcmUgY3JlYXRlZCBieSB1c2luZyBjb21tYW5kcw0KPiAr
VklSVElPX0dQVV9DTURfUkVTT1VSQ0VfQ1JFQVRFXyosIHNvIHRoYXQgZ3Vlc3QgY2FuIHVzZSB0
aG9zZSByZXNvdXJjZXMNCj4gK3RvIHJlc3VtZSBkaXNwbGF5Lg0KPiArDQo+ICtOb3RlOiB0aGlz
IGNoYW5nZSBpcyBub3QgZW5vdWdoIHRvIHNvbHZlIHRoZSBwcm9ibGVtcyBvZiBTNCBmdW5jdGlv
bi4NCj4gK1FFTVUgbWF5IGxvc2UgcmVzb3VyY2VzIGFmdGVyIGhpYmVybmF0aW9uLiBJdCBuZWVk
cyBtb3JlIHJlc2VhcmNoIGFuZA0KPiArZGV2ZWxvcG1lbnQuIElmIFM0IGlzIHN1cHBvcnRlZCBp
biB0aGUgZnV0dXJlLCBpdCBtYXkgbmVlZCBhbm90aGVyDQo+ICtmZWF0dXJlIGZsYWcgaGVyZS4N
Cj4gKw0KPiArXGVuZHtkZXNjcmlwdGlvbn0NCj4gKw0KPiAgXHN1YnNlY3Rpb257VkdBIENvbXBh
dGliaWxpdHl9XGxhYmVse3NlYzpEZXZpY2UgVHlwZXMgLyBHUFUgRGV2aWNlIC8gVkdBIENvbXBh
dGliaWxpdHl9DQo+IA0KPiAgQXBwbGllcyB0byBWaXJ0aW8gT3ZlciBQQ0kgb25seS4gIFRoZSBH
UFUgZGV2aWNlIGNhbiBjb21lIHdpdGggYW5kDQo+IC0tDQo+IDIuMzQuMQ0KPiANCj4gDQo+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiBUbyB1bnN1YnNjcmliZSwgZS1tYWlsOiB2aXJ0aW8tZGV2LXVuc3Vic2Ny
aWJlQGxpc3RzLm9hc2lzLW9wZW4ub3JnDQo+IEZvciBhZGRpdGlvbmFsIGNvbW1hbmRzLCBlLW1h
aWw6IHZpcnRpby1kZXYtaGVscEBsaXN0cy5vYXNpcy1vcGVuLm9yZw0KPiANCj4gDQo+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiBUbyB1bnN1YnNjcmliZSwgZS1tYWlsOiB2aXJ0aW8tZGV2LXVuc3Vic2NyaWJl
QGxpc3RzLm9hc2lzLW9wZW4ub3JnDQo+IEZvciBhZGRpdGlvbmFsIGNvbW1hbmRzLCBlLW1haWw6
IHZpcnRpby1kZXYtaGVscEBsaXN0cy5vYXNpcy1vcGVuLm9yZw0KPiANCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==
