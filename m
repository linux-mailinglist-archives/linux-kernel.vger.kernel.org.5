Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2290C773C4C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjHHQDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHHQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:02:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9145265AC;
        Tue,  8 Aug 2023 08:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrn7iIv++BvJt0g+6T9tgqeFSCd55l/YLJW86GDiNZhi282ZrCtAsi1fW//kApyPfk0Rn4gq24xG7OZ97uuNa3PiHtqVcez9nO9oexL7O6o7SFeSgaQx+eEQDw97iC2Qxc20PJlDU2CovufJjWhN2m5J3sF7moPgiIRvmjn0J0KIz/HEmQ6yqlH+dwrnTE9x7s+uPF4tWE5oV56r+S2nWwQ9Olv8FEbfEr/O/IU2XSk2yf9Z+1BsPuCBtm3b6Er9AwePcMkyDZzem7Ljpryjng8axtZHZUewdJ+Lil/Wtt+uzaiXY8RBuI2bI/X1oYAOyJ6AUJ0V6ujgkhopMzjFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lIlayXBJiOEB+4twdCRnrmL1LfSEw3N0g/Pz5KBnMU=;
 b=kMkInEm9loN3emEKID6Zp7rBED7u6+5RKd5tGd+ErcWwoeabHR6WZndfR+YPfptAR9GE+PsnCvpx1TW+OLR66TdTwOxrtdFZEiECqMkvWiWcWMHST+OCrISHzMSBcfn6dP90ua8boJvJdU7S7Hkez1MPPMO9odSXsMr5i6XchP/KBiCcD8eG3YU9w9zYlQCQzqAZkL1QPiOCZwoVotz0wTq5sW2dEyLbUxRN+LoW4rVNTysb3FBjt3tSGyWlKwENns1xUa6IY9EgOxcGXFe/QByFa5sW5MZ5U55U2faO8fhngT9RxJrkrTibIhm2HypvUhMpjK40isTbsHL7q42SkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lIlayXBJiOEB+4twdCRnrmL1LfSEw3N0g/Pz5KBnMU=;
 b=Shcj8XGdtvE2Fby/sQ3pNkguphe5FYI/1FDGo07TXiQZmy0bGSe7a/G4//HVZr0wMhVdTvwiyGkdYTVIkNYPXSANgjX96ipBjS66yfx64oWLsc5KK4dF7dp4WLuZWgXwlR55Qa6K4CxPzwi9+FpPoffGyg45VWp9YWF5w3IdqNsFRDGrMjBMQkvBPETh3R9AgbzVde7myJeIGRZUVi6eZ4Cg++V+/IEkXzXaoa4ydyDsznOycpcVsdl8dPH0KAoGCigZbQUlbPPdMzFvBqEwPaLxisw6462oiW39vouv4cIJK87DTv2MCTxaaCeqZ934dvn2JykpNFJcYggO850I3w==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 13:21:27 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::acc8:7a8:c30d:eec8]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::acc8:7a8:c30d:eec8%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 13:21:26 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Topic: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Index: AQHZxyuq+HOsHtVXXkaFYWsKN9h+fa/gKjSAgAA5XSA=
Date:   Tue, 8 Aug 2023 13:21:26 +0000
Message-ID: <BN9PR12MB506823B5AF3069C0C8350BE9D30DA@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230804233015.173957-1-limings@nvidia.com>
 <CAPDyKFprnX=37FDdBxiNyyr5X_6zpp87Kt7o1hxdRePZhMJO4A@mail.gmail.com>
In-Reply-To: <CAPDyKFprnX=37FDdBxiNyyr5X_6zpp87Kt7o1hxdRePZhMJO4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|MN2PR12MB4094:EE_
x-ms-office365-filtering-correlation-id: 788e4dd1-dc87-459e-d1dc-08db98125ea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8rIy+B85ba7/1AJ7+JVnyhqf5fLuUo8VGxRNVCBwOv+Ok7MUQXNonmLQo+v7T6En4w/cQx9eSnHZtbI1RcBevepsKiJQHIto96wK/daPYkX4deqDIW6UW5DxdNUWnDiGNZ9SLM0MmEwgVLK1nIw1VFekjoGpAX2KfJauBmSW5iXVmCvD2TQEld+wr2BPWcKvWx5x1vbJaft0kid2vEBsXnmISh7UUYmr8qvD5d4VDlbJRuWeWauKYjnfE0CvcGUWIQOF+oLk5irveYWZI3Rbv6IExhZXmZ9sydiHwj4uyz7ShSVaS0jKw+jIxzc6sZMA/bFpQvFpz1Bc4rZTT2q/DnT/0rAyP+emFhX3coMChbg+qobFRZHRiGUOXFBNOP/ssl2CHcobtti0Zt21kczXlyIVWqfg4ZWF8VnN4rUnXU1rt72ZhM180nrKailOrUAPCfyuE0wxhE1yPtOkZwXOqDDF1LNrEAckXH0iGzN4Lpvfd1wvOvS/bqXvPOG0m1zfv83FBOKEcHgvf81oKBlQJCGtgIqoJpcebXIgBAtc4IBSfrtiMLyrIo0FoEEK9GNw0CnqgSG+Fxme2IabK6PMkTpeVbxQBTBGfLP+b2NaBEhszAT9I++wmAa5QSAGhebxfHLodPap+cjdL+wKz7z/AQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(186006)(1800799003)(83380400001)(2906002)(55016003)(41300700001)(5660300002)(52536014)(38070700005)(8936002)(8676002)(33656002)(86362001)(54906003)(478600001)(122000001)(38100700002)(26005)(71200400001)(7696005)(53546011)(6506007)(316002)(64756008)(6916009)(4326008)(66946007)(66446008)(66476007)(76116006)(66556008)(9686003)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUdYKzVHZWVzV0docEtWUEJXa1RYWUxVRzNJdVhGUzJrWU5Sb3lBQXk4L21z?=
 =?utf-8?B?WHpZSUdrdUlBZW5VUW5XNURTMWZUK2U1MHFLQm80S0U1bkpvNUNZS3lhd0t6?=
 =?utf-8?B?Tk1rNGdCZVlmeVJ4cWZ3Vjg5a0lsVEtXVmx1UUVhNWc2U1lnM3VRbkp2TGI0?=
 =?utf-8?B?RXJZUklINFYrdXlvSmg3RFQ0bW9zQ0dvNlNaOWUxL2I1V1p4RTVyTDU0UnlV?=
 =?utf-8?B?QjBZU2gxanE5eHJnYnN0S01welR4dEg0Z1I1SFZ1ajgxVkoweGQrWHBIaFVY?=
 =?utf-8?B?WWNoai9Sc0Q1VVRoN1hFaS9YK0gzRUt0WmxDOWJEdVZJZ1V4aWVncGtKS3E4?=
 =?utf-8?B?dHVIOWJjNGIyTDFxMndVS0ZaekNkbjJRTWV5QlFVRVlCbDRiVndyaG5FRnZI?=
 =?utf-8?B?dUR1OVNLclUrQmZEVVhPK21FM1BENjBTTjBqOC94ckxIdHRYdDJuTExMQ1Rh?=
 =?utf-8?B?T1ZYVHR6dkdwQUxXWDlIYnB0QitzdHUxMndKZ2VhZ0tIMlZ6R3N6QmU0dUlY?=
 =?utf-8?B?cjV3Q1d0TUU5dDFqRGsraGZ3STdSMHBCejVaZUFwc05xMzZkZ0ZoVS84ME1I?=
 =?utf-8?B?YjU1bjZDVGlRa0FlR0JuVlVKZ1E4MndmYWpUV2tMKzkxdmhtajVMYkVJTnZm?=
 =?utf-8?B?UStteXROT3k3d2kvVEh5Z25BMXd6OGZvY0tqRVJrMXV6d2E4d242R3ptZkov?=
 =?utf-8?B?UE94MnRLQlFGY3c0ZkVUU2hJRG5kcDVKR3FuZFZ6bGdOTlZsYWw0dXhzOFhW?=
 =?utf-8?B?VmNsejJsdXhWRmpmTnlLWTYzQUZVNXQydmxCelpuK0JWby8wSU9tNGZ1VUFO?=
 =?utf-8?B?QU9pRkw0RmxlVllUNHg4MjdpbEFuQTNzbVdiQnQwRWhxbHRqZm1OeTUwVTNI?=
 =?utf-8?B?bjVWWUlhTkxXaDdlcVRBamEyRktWdEFQYlZOdEwrbEs3SStpMWtjMzVrNUNB?=
 =?utf-8?B?TkVlc3Z4VVFwVEYySU5nZmZ4dS9yOWcvTE5xaWthVkRNTWR6Wm8xdWVFOHgz?=
 =?utf-8?B?anF1NitxNFRCdXVEc3l5Y3o2b1hiODJDeXpPVG9ZQkErTW5FT04relRtc2gv?=
 =?utf-8?B?bStVWmpPOUFpNjY0RTB0OUVIdXZIQThLUU5DVVNDVGV6L0duREx5K1JnZGdh?=
 =?utf-8?B?cTRXYzNRSGxENGJLYUd3emRPUGN6dldFM0pQSEVzMHA0TnhrcjIzbzdFMFpI?=
 =?utf-8?B?Q2xVTi9LbVptaUhmUndHem1pd2MxWDFmMlpvRkl1OTNSVlFLcWltNkJHYzd4?=
 =?utf-8?B?UEt5MkQvWmJsdnZUQjRMc0dvTzhtQi9zTDdsSzFmUFVwVVlXbzdkY1RxanhQ?=
 =?utf-8?B?MGd4RWZDV1ZZZTh5N2tsaFBQK3RWc1k5SzVZampQV1VHOFp2NTF2Qk9jbVpR?=
 =?utf-8?B?K3IyNlBZd2xyc1ZtMllTTnRmQ0NBY1lMbGVJeUJoVnBJQ3pndHMvYUVjK2FU?=
 =?utf-8?B?NTZvSzNoUXlhMnFVdUVTK2U2RWRXL3JqVlhqcDBCYy9wSGRPa3psU3hic1By?=
 =?utf-8?B?dXk4cTNHL1pGTWxOZmZXbldQbUJOd3doTEZvMUo0d3U3SWFlc3N5SkxMUFlB?=
 =?utf-8?B?cHdISkpmMGtEOVpQckFpc3hqQlFNTmhZQ3pPVEUvSXQzZzRYNmdDTFBzMjhm?=
 =?utf-8?B?YTBHdmRjN1dra0dRQllPNzNxUlRES0c5cFdtMktqYy9zVnQ2eTFVYkdBN1VC?=
 =?utf-8?B?UXh3QmJSVFFkd1hwdjcwMVdzNXloU0dxeUg3eCsvU0ZvZUNjNEJ6QVNkRGk2?=
 =?utf-8?B?UVVxYnpZN1hRdjlOeDI0NTh1aWEzRXZMSDM2Z1hDREhWN1VrV2pCekF0U2hE?=
 =?utf-8?B?Qy94RHZMR2hiVmpER0pRMFBQK3JGYWdwRXpLTTNpa3k2QSt6a0pVVmFVVzA1?=
 =?utf-8?B?MXZkRHpMc0pvc3ZtRER4QnNHZStRUDh6OWptOUFoUWU5S3NGb1IvRFM2eU5T?=
 =?utf-8?B?Vkd0RUU4UWtVaW5idmVqRGxidFd1V1dzYmV4RFJWL0ZndkZMeTZldjE4Z0RD?=
 =?utf-8?B?V0pnSFROLzF6M2FKMGUxQVJLUktiS2YrZVF0NlkxMUVYQWwxcWpmRUFaSjl2?=
 =?utf-8?B?YXBBUWdPZEc1TjFzN2pNOEJLYkhCd0xvRVp4VEdZVEwvdmxxeS94bkwwd0ti?=
 =?utf-8?Q?OFEM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788e4dd1-dc87-459e-d1dc-08db98125ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 13:21:26.7503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPHyzRm7fHi9i//3Q812guGRqZzx459dgb49SBca5RrpvPGmyyk+7KGfWgeIMsxMAyJg7Zx9TbNY6JmFs9pTwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA4LCAyMDIzIDU6
NDAgQU0NCj4gVG86IExpbWluZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNvbT4NCj4gQ2M6IEFkcmlh
biBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgRGF2aWQgVGhvbXBzb24NCj4gPGRh
dnRob21wc29uQG52aWRpYS5jb20+OyBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNv
bT47IGxpbnV4LQ0KPiBtbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjZdIG1tYzogc2RoY2ktb2YtZHdjbXNoYzog
QWRkIHJ1bnRpbWUgUE0gb3BlcmF0aW9ucw0KPiANCj4gT24gU2F0LCA1IEF1ZyAyMDIzIGF0IDAx
OjMwLCBMaW1pbmcgU3VuIDxsaW1pbmdzQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhp
cyBjb21taXQgaW1wbGVtZW50cyB0aGUgcnVudGltZSBQTSBvcGVyYXRpb25zIHRvIGRpc2FibGUg
ZU1NQw0KPiA+IGNhcmQgY2xvY2sgd2hlbiBpZGxlLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IERh
dmlkIFRob21wc29uIDxkYXZ0aG9tcHNvbkBudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IExpbWluZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiB2NS0+djY6DQo+
ID4gICAgIC0gQWRkcmVzcyBBZHJpYW4ncyBtb3JlIGNvbW1lbnRzIGFuZCBhZGQgY29vcmRpbmF0
aW9uIGJldHdlZW4NCj4gPiAgICAgICBydW50aW1lIFBNIGFuZCBzeXN0ZW0gUE07DQo+ID4gdjQt
PnY1Og0KPiA+ICAgICAtIEFkZHJlc3MgQWRyaWFuJ3MgY29tbWVudCB0byBtb3ZlIHRoZSBwbV9l
bmFibGUgdG8gdGhlIGVuZCB0bw0KPiA+ICAgICAgIGF2b2lkIHJhY2U7DQo+ID4gdjMtPnY0Og0K
PiA+ICAgICAtIEZpeCBjb21waWxpbmcgcmVwb3J0ZWQgYnkgJ2tlcm5lbCB0ZXN0IHJvYm90JzsN
Cj4gPiB2Mi0+djM6DQo+ID4gICAgIC0gUmV2aXNlIHRoZSBjb21taXQgbWVzc2FnZTsNCj4gPiB2
MS0+djI6DQo+ID4gICAgIFVwZGF0ZXMgZm9yIGNvbW1lbnRzIGZyb20gVWxmOg0KPiA+ICAgICAt
IE1ha2UgdGhlIHJ1bnRpbWUgUE0gbG9naWMgZ2VuZXJpYyBmb3Igc2RoY2ktb2YtZHdjbXNoYzsN
Cj4gPiB2MTogSW5pdGlhbCB2ZXJzaW9uLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0
L3NkaGNpLW9mLWR3Y21zaGMuYyB8IDcyDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5j
IGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS0NCj4gb2YtZHdjbXNoYy5jDQo+ID4gaW5kZXggZTY4
Y2Q4Nzk5OGM4Li5hYWY2NjM1OGY2MjYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1vZi1kd2Ntc2hjLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9m
LWR3Y21zaGMuYw0KPiA+IEBAIC0xNSw2ICsxNSw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51
eC9vZl9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0K
PiA+DQo+ID4gQEAgLTU0OCw5ICs1NDksMTMgQEAgc3RhdGljIGludCBkd2Ntc2hjX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4NCj4gPiAgICAgICAgIGhvc3QtPm1t
Yy0+Y2FwcyB8PSBNTUNfQ0FQX1dBSVRfV0hJTEVfQlVTWTsNCj4gPg0KPiA+ICsgICAgICAgcG1f
cnVudGltZV9nZXRfbm9yZXN1bWUoZGV2KTsNCj4gPiArICAgICAgIHBtX3J1bnRpbWVfc2V0X2Fj
dGl2ZShkZXYpOw0KPiA+ICsgICAgICAgcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gPiArDQo+
ID4gICAgICAgICBlcnIgPSBzZGhjaV9zZXR1cF9ob3N0KGhvc3QpOw0KPiA+ICAgICAgICAgaWYg
KGVycikNCj4gPiAtICAgICAgICAgICAgICAgZ290byBlcnJfY2xrOw0KPiA+ICsgICAgICAgICAg
ICAgICBnb3RvIGVycl9ycG07DQo+ID4NCj4gPiAgICAgICAgIGlmIChya19wcml2KQ0KPiA+ICAg
ICAgICAgICAgICAgICBkd2Ntc2hjX3JrMzV4eF9wb3N0aW5pdChob3N0LCBwcml2KTsNCj4gPiBA
QCAtNTU5LDEwICs1NjQsMTUgQEAgc3RhdGljIGludCBkd2Ntc2hjX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4gICAgICAgICBpZiAoZXJyKQ0KPiA+ICAgICAgICAg
ICAgICAgICBnb3RvIGVycl9zZXR1cF9ob3N0Ow0KPiA+DQo+ID4gKyAgICAgICBwbV9ydW50aW1l
X3B1dF9zeW5jKGRldik7DQo+ID4gKw0KPiANCj4gVGhlIGFzeW5jIHBtX3J1bnRpbWVfcHV0KCkg
aXMgcHJvYmFibHkgc3VmZmljaWVudCAtIGFuZCBpdCB3b3VsZCBhbGxvdw0KPiB0aGUgcHJvYmUg
dG8gY29tcGxldGUgYSBiaXQgInNvb25lciIuDQoNClN1cmUsIHdpbGwgdGVzdCBhbmQgdXBkYXRl
IHRoZSBsaW5lIGluIHY3Lg0KDQo+IA0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiAg
ZXJyX3NldHVwX2hvc3Q6DQo+ID4gICAgICAgICBzZGhjaV9jbGVhbnVwX2hvc3QoaG9zdCk7DQo+
ID4gK2Vycl9ycG06DQo+ID4gKyAgICAgICBwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gPiAr
ICAgICAgIHBtX3J1bnRpbWVfcHV0X25vaWRsZShkZXYpOw0KPiA+ICBlcnJfY2xrOg0KPiA+ICAg
ICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHBsdGZtX2hvc3QtPmNsayk7DQo+ID4gICAgICAg
ICBjbGtfZGlzYWJsZV91bnByZXBhcmUocHJpdi0+YnVzX2Nsayk7DQo+ID4gQEAgLTYwNiw2ICs2
MTYsMTIgQEAgc3RhdGljIGludCBkd2Ntc2hjX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
Pg0KPiA+ICsgICAgICAgcmV0ID0gcG1fcnVudGltZV9mb3JjZV9zdXNwZW5kKGRldik7DQo+IA0K
PiBDYW4gZHdjbXNoY19zdXNwZW5kKCkgYmUgY2FsbGVkIGZvciBhIGRldmljZSB0aGF0IG1heSBi
ZSBhdHRhY2hlZCB0bw0KPiB0aGUgQUNQSSBQTSBkb21haW4/DQoNCkJsdWVGaWVsZCBTb0MgaXMg
dGhlIG9ubHkgY2hpcCB0aGF0IHVzZXMgQUNQSSBpbiB0aGlzIGRyaXZlciBmb3Igbm93IGFuZCBp
dCBkb2Vzbid0IHN1cHBvcnQgU3lzdGVtIFNsZWVwLiBUaHVzLCB0aGUgZHdjbXNoY19zdXNwZW5k
KCkgd29uJ3QgYmUgY2FsbGVkLiBCdXQgSSBndWVzcyBpdCBtaWdodCBiZSBwb3NzaWJsZSB3aGVu
IG90aGVyIG5ldyBjaGlwIHN1cHBvcnQgaXMgYWRkZWQgaW50byB0aGlzIGRyaXZlci4gSXMgaXQg
YSBjb25jZXJuPw0KDQo+IA0KPiA+ICsgICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAg
ICAgICBzZGhjaV9yZXN1bWVfaG9zdChob3N0KTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJu
IHJldDsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gICAgICAgICBjbGtfZGlzYWJsZV91bnBy
ZXBhcmUocGx0Zm1faG9zdC0+Y2xrKTsNCj4gPiAgICAgICAgIGlmICghSVNfRVJSKHByaXYtPmJ1
c19jbGspKQ0KPiA+ICAgICAgICAgICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUocHJpdi0+
YnVzX2Nsayk7DQo+ID4gQEAgLTYyNSw2ICs2NDEsMTAgQEAgc3RhdGljIGludCBkd2Ntc2hjX3Jl
c3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gICAgICAgICBzdHJ1Y3QgcmszNXh4X3ByaXYg
KnJrX3ByaXYgPSBwcml2LT5wcml2Ow0KPiA+ICAgICAgICAgaW50IHJldDsNCj4gPg0KPiA+ICsg
ICAgICAgcmV0ID0gcG1fcnVudGltZV9mb3JjZV9yZXN1bWUoZGV2KTsNCj4gPiArICAgICAgIGlm
IChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICAgICAg
ICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHBsdGZtX2hvc3QtPmNsayk7DQo+ID4gICAgICAg
ICBpZiAocmV0KQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+IEBAIC02NDYs
NyArNjY2LDU1IEBAIHN0YXRpYyBpbnQgZHdjbXNoY19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2
KQ0KPiA+ICB9DQo+ID4gICNlbmRpZg0KPiA+DQo+ID4gLXN0YXRpYyBTSU1QTEVfREVWX1BNX09Q
Uyhkd2Ntc2hjX3Btb3BzLCBkd2Ntc2hjX3N1c3BlbmQsDQo+IGR3Y21zaGNfcmVzdW1lKTsNCj4g
PiArI2lmZGVmIENPTkZJR19QTQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgZHdjbXNoY19lbmFi
bGVfY2FyZF9jbGsoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpDQo+ID4gK3sNCj4gPiArICAgICAg
IHUxNiBjdHJsOw0KPiA+ICsNCj4gPiArICAgICAgIGN0cmwgPSBzZGhjaV9yZWFkdyhob3N0LCBT
REhDSV9DTE9DS19DT05UUk9MKTsNCj4gPiArICAgICAgIGlmICgoY3RybCAmIFNESENJX0NMT0NL
X0lOVF9FTikgJiYgIShjdHJsICYgU0RIQ0lfQ0xPQ0tfQ0FSRF9FTikpDQo+IHsNCj4gPiArICAg
ICAgICAgICAgICAgY3RybCB8PSBTREhDSV9DTE9DS19DQVJEX0VOOw0KPiA+ICsgICAgICAgICAg
ICAgICBzZGhjaV93cml0ZXcoaG9zdCwgY3RybCwgU0RIQ0lfQ0xPQ0tfQ09OVFJPTCk7DQo+ID4g
KyAgICAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGR3Y21zaGNfZGlzYWJs
ZV9jYXJkX2NsayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkNCj4gPiArew0KPiA+ICsgICAgICAg
dTE2IGN0cmw7DQo+ID4gKw0KPiA+ICsgICAgICAgY3RybCA9IHNkaGNpX3JlYWR3KGhvc3QsIFNE
SENJX0NMT0NLX0NPTlRST0wpOw0KPiA+ICsgICAgICAgaWYgKGN0cmwgJiBTREhDSV9DTE9DS19D
QVJEX0VOKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGN0cmwgJj0gflNESENJX0NMT0NLX0NBUkRf
RU47DQo+ID4gKyAgICAgICAgICAgICAgIHNkaGNpX3dyaXRldyhob3N0LCBjdHJsLCBTREhDSV9D
TE9DS19DT05UUk9MKTsNCj4gPiArICAgICAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGlj
IGludCBkd2Ntc2hjX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gK3sN
Cj4gPiArICAgICAgIHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gZGV2X2dldF9kcnZkYXRhKGRl
dik7DQo+ID4gKw0KPiA+ICsgICAgICAgZHdjbXNoY19kaXNhYmxlX2NhcmRfY2xrKGhvc3QpOw0K
PiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW50IGR3Y21zaGNfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+
ID4gKyAgICAgICBzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
Ow0KPiA+ICsNCj4gPiArICAgICAgIGR3Y21zaGNfZW5hYmxlX2NhcmRfY2xrKGhvc3QpOw0KPiA+
ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsjZW5kaWYNCj4g
PiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBkd2Ntc2hjX3Btb3BzID0g
ew0KPiA+ICsgICAgICAgU0VUX1NZU1RFTV9TTEVFUF9QTV9PUFMoZHdjbXNoY19zdXNwZW5kLCBk
d2Ntc2hjX3Jlc3VtZSkNCj4gPiArICAgICAgIFNFVF9SVU5USU1FX1BNX09QUyhkd2Ntc2hjX3J1
bnRpbWVfc3VzcGVuZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICBkd2Ntc2hjX3J1
bnRpbWVfcmVzdW1lLCBOVUxMKQ0KPiA+ICt9Ow0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgcGxh
dGZvcm1fZHJpdmVyIHNkaGNpX2R3Y21zaGNfZHJpdmVyID0gew0KPiA+ICAgICAgICAgLmRyaXZl
ciA9IHsNCj4gPiAtLQ0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
