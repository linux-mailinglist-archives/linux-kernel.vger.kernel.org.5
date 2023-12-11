Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0980C195
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjLKG4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKG4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:56:04 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FD89B;
        Sun, 10 Dec 2023 22:56:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F369Yqiw2UMejwZr2SouTsuCcV7NLO1w2DHIC0bhLAq/Op6NIt6CTTFU2yliWAqwqYRIQ9DZDr1WLNleLlSRUjA8XquN4Ank3PZMKrMdudIqt4lOP3crMxiXDbP8S3zVrHafrK9n8v1xJT6oahS30Slfe3QIupE1NGIf3Qb2T9XHKH4fdGGE7+0BHov59yYri7+aWoNkwWnKtJwEVuA/QKM8dVr16LvCEYBrGV1ZA582vVNMFKqWPUemOvmdajH2N16wZtp50qcREG0B1DtneiIygBBr12jH1YnzGuyZiOvEpMEeUOzB7AlnW+DH/C486RpYWaZ/DPiuF4bp4d1qFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkiWMfp/AVvxkXEkKehnqndLhiQ/9xPpim2ATrltnzA=;
 b=SxL7Jnjpn3cbT+aYhzXpPhQI/Pd9VxMu5yic/69zn0M18GplMsZzCWZVCPWa8TBPW6wsQ7x04Qo8tHM/wyV2bM8Yz6WPuu7uedT4WRYUGtx9WvCVU5wq5eOY4XS+OHS+Z9RhPzrIJIX6rjOSVd4Hb8IK0ArttINNmwyOpn2JpULbeswAjW3L4HugKmmZfAAfx90bl+HRValP3CjsX+TJidHkpHWGUsWnmaaGOKyaqW4826bwhrOq1KuJft4DdHZHdm0oSOzJZtTN7Srln6qXfqdPF7H1Nb3vXoMnaB7b0u9XFe24cVsX3UEp9iI3joA/fEoVpelrm0nXTNpqW+T/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkiWMfp/AVvxkXEkKehnqndLhiQ/9xPpim2ATrltnzA=;
 b=bcM43vX2gxi3+LptBW8+ufUY/vlH8l3P1R+SIrlNylnfUnTLjgAE6YzKr5BZbq3FtKSJVH/c3GnRFYf3cSF5GGuNwkOwwNZaKKrNmykSb4MoHAnLttPN8XSuMLkI6s3W3rEV7IM5fK8Wj3puAyVskYJJZm3MyhAGNBHnpIJTAzE=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 06:56:06 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 06:56:06 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Topic: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Index: AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLw
Date:   Mon, 11 Dec 2023 06:56:06 +0000
Message-ID: <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
In-Reply-To: <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|BY5PR12MB4244:EE_
x-ms-office365-filtering-correlation-id: 9c096ba5-ea66-4abd-1ba7-08dbfa163f66
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NHqilMMqy5C0ETC47US1dnUJCqcWVcT1YVHMCRjHP/Z5r55DTPqIYPx1fqDVf59z8iD8VMKCDF6LXsneSkzsLZ3+oUHBIDtHZophhEsNXDJPtk2WhRQjYU17W7bcPxLCQVTb+FGt46dfZJcZIgdmVzVYf+iDVr85XGqsog0wblgZJgVYPsxLOoP1nRyRaxeftR4dYHb2QhAdGQHmXuHvmvRR8VAtXuk0MI6IYlLIbvYBx2+0iljlv8Kja+5NBXBANTy2jFhxxmKxzxcU4Tc1Ww/hilGKWRVHSNydyylUkRg57+JAvDKXN+riumuzeUkS72V6UXIYSf6dpOvRuAdNcj3MtS/1KXCqznV+DqzSXg3LGAOWoQO+nPfrOqQl2wwuXBZk+LG0T21trT82mIY+9M8xAjPRdvgye6vNJ22HXM+RMRKa8BXp1TLwoGfBG6ows/T7E3X9fxRAENOqH7HxiN2lTqESFF1a/4dU/QiDfdP2uOWOIBbnJrI99OfJYYwIOsLgOqk0MMNsevWoeH5jGBkBI2eDE1Zpquz7OJh2gKyH034WErF9Lq//P7qielLhf/67fr1sr7HWzqxEJ3+ZvKMMdvEDdSV44K0qqYlGKI8O9ZgeT2ACU9i5gtccIzIQpzIRa8HPfjPf4eDGDzok6lkxLnwh+vhM+6M9/5clyGfFhiSJINkEtszJuzE2qnTqwX8DiaFS1q3aijT0ycGXNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(346002)(136003)(366004)(376002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(55016003)(478600001)(26005)(7416002)(5660300002)(966005)(54906003)(66946007)(64756008)(76116006)(66476007)(316002)(66446008)(66556008)(110136005)(53546011)(6506007)(7696005)(9686003)(71200400001)(83380400001)(8936002)(8676002)(4326008)(52536014)(921008)(38070700009)(2906002)(86362001)(41300700001)(122000001)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmJHZGRDWUN3aXdZcFBaOVpYVG9rV1RoVktFREZ5eXVIbUM3NGVFRGV3OEFm?=
 =?utf-8?B?R2x1aG40VUgwUndXNTRXMGZCV3k3Z0x1VHg0WjkvdHdiZWJycUJ1a1NjaC96?=
 =?utf-8?B?eDNMQTBhVnpJb0g3dm10KzhJQ2x1TnExeFFQRTg1ZUlncGFhTkZDNlNReTdE?=
 =?utf-8?B?OTg2c1RKV2FtOEJISDZldDUzZ3JkdnhyVDFRajlKd3daTEZuZ0xabFFZLzMy?=
 =?utf-8?B?K3J5cTVWejVTQjd6VldTVDJJOEsxVzkrRTF5aGJMb2NGRGRIdDNmdDRFMXVr?=
 =?utf-8?B?WUhSUUlOVnF1NllRSHUzMDlWZlcwa2NxVkswWUxmNTVtbE1RVUtxYllsbytm?=
 =?utf-8?B?QnV1bGNBNkNOTkEvU3ZORE5BY21BRCtiYXI2Yk5Ma1gzOTNRb3FlYWYvcW1I?=
 =?utf-8?B?d3BRRzM2NzhXbE15cDNFZFh0RHFGbHEzaGEyeXNWT044dUlxa2VrbUhVWi9S?=
 =?utf-8?B?WktUTXllWGs5YW11MVVXeml2SmZFcWswbVViVUxzZkxTRmcxSGNvNWd2QVVm?=
 =?utf-8?B?MVdpTml2Z2E0M08zTGpvTlhObUFiTnVLS0NGaW5Da2NYMWE1UTFNS0ZLc2lF?=
 =?utf-8?B?ZE8vampJSVQ3MWtyaEwyZWJ6K3NpZ1VHOVE2VlgveUJnSHpLUElxRW9jSktY?=
 =?utf-8?B?dWtFdE56UVd5K3JOMW4rV0VMVVN5OWNRcWZCdWJ1YUZKb1ptNXUrV1NrZ01O?=
 =?utf-8?B?bEJOaGJOMFQ5K3dnbmM1YS90dUwzTDAxaEN2eTFGN0k4djFOYzgrSUVCMDV0?=
 =?utf-8?B?WTh6QzhLV1hiMFJ0MWJ5aDVuSkVQbnVxUThpaDZYVTltWGRLV2trQ2ovL0Y4?=
 =?utf-8?B?ZWdRT1E3eVNqbW9GMDNnR056RG0yVDNCMWZpeVlrbUpjUUZPUklabER5aktE?=
 =?utf-8?B?alE4b0xCRmlacTJMTkpkMzhMVy85YkJMdnNtako5d0RJT29kbW9lK0UxL1Jq?=
 =?utf-8?B?NTlaVlFmWlg3THBCbzFPWnA3aG0xaUtuZXByZVZLRk54K3NvdWh6WmVMVVZT?=
 =?utf-8?B?S2NabWxpbFBaVWFzcld1ZllUQXhrbnBaY0U3NE5Rc011OGdRYXlYTUtnS2M4?=
 =?utf-8?B?TUZud3hNd0FERTFhR3QrOGIwOUdlZm1GWHB5aFZlNVozRjJucExoMTJTU25U?=
 =?utf-8?B?bVpJYzlmUTdOOGczWjNBcEhtNFJvQkNPY2Q4SEgzVHFNbld3YncxZVd4MVpR?=
 =?utf-8?B?d1VLSm96Q283bUllNTFrcDU5bzk3SGxyM0J4b1BSemhkSlJSdTF1c21TaVZ1?=
 =?utf-8?B?Mk9kZ0tJS0EyUGtPWlZPLytnZFdvSnczRmRBVVd0dVE4OSsvUmZuKzYxN3ZS?=
 =?utf-8?B?UmUzVlFzTGh6K1JYK1VOb3Y3TzkwMC9jQzd6ZW10bjVoY20wcUMzZ0dCMDM2?=
 =?utf-8?B?RExMZmJTOXNuckZCUWNzRFAzYVBFVElBUnd2NklCNGV2Nm9UdXhwbGkrZ2Q4?=
 =?utf-8?B?cVh4VDdpVjlWcEdpT1FhVjUzdEpNL2RCUXczeUFXR3dobm9OZmZvM2pibVEz?=
 =?utf-8?B?ZjIzVWMxa3Bic0k0ZXdIWG1xSUd4bEtxT0p3cFJXdW5EYS84WmRUdURaek5z?=
 =?utf-8?B?Z3pLSUg2bzA0SGNMYXBOT0dvYk5xdE5VTHBqQVlrUDdaTFVlb1FSdi9Sdnhk?=
 =?utf-8?B?aEtnN2RqWnhPRFA2VDh6b2hjWkc5UVVXWGg0cGVPdmlIaE9hUXRRU2JydVY4?=
 =?utf-8?B?dlAxYnU3YURQZ0FDRnpneFNmMGxhaENFbUVub3k1Q3JGeVJkRlhqOHkwM0ll?=
 =?utf-8?B?TjQ5dHNlcElDUWRNWG5xWlNBUFduOUl3K1hVNVNlMm05V21GZVBvSkJab3la?=
 =?utf-8?B?SStuWGdXWjdod3h0d3F1NEZURkJFeWNoVDZobEszTksvN3lXWEE0K3dUNG5w?=
 =?utf-8?B?Y29tTFdKa3EvREF2V2RhbFF4M2tUbFpOelY1QW5vMnQ1WWVLVnZ0MUpXaUR4?=
 =?utf-8?B?OW1Fb3B0dW54YTlKdmdiemRRT28rTkpjM2dkdDFJdWhzRmZNaXFmdzdiejgz?=
 =?utf-8?B?Y05QTjNIVG1kMDY3bzZaMFdHSkx6a0ZlMWx6U2M3ZXlqc1dWTW03NjdJVXZj?=
 =?utf-8?B?MWFlSHdmWW1LM0lzTXpmc01haG5ZbHhLT0tLclN3VTRZQUxwM05qclprdWZC?=
 =?utf-8?Q?nIho=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c096ba5-ea66-4abd-1ba7-08dbfa163f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 06:56:06.2544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btx/67p+DsrZfGLxBhDh0hpERYfdI5Irdp0mqg01YfxOP1edG4dji+y7sbVJPYp8/k9W55a1et4P5zZCOg+TwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDExLCAy
MDIzIDk6MDMgQU0NCj4gVG86IE1haGFwYXRyYSwgQW1pdCBLdW1hciA8YW1pdC5rdW1hci1tYWhh
cGF0cmFAYW1kLmNvbT47DQo+IGJyb29uaWVAa2VybmVsLm9yZzsgcHJhdHl1c2hAa2VybmVsLm9y
ZzsgbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsNCj4gcmljaGFyZEBub2QuYXQ7IHZpZ25lc2hy
QHRpLmNvbTsgc2JpbmRpbmdAb3BlbnNvdXJjZS5jaXJydXMuY29tOw0KPiBsZWVAa2VybmVsLm9y
ZzsgamFtZXMuc2NodWxtYW5AY2lycnVzLmNvbTsgZGF2aWQucmhvZGVzQGNpcnJ1cy5jb207DQo+
IHJmQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsgcGVyZXhAcGVyZXguY3o7IHRpd2FpQHN1c2UuY29t
DQo+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiBtaWNoYWVsQHdhbGxlLmNjOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsNCj4gbmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tOyBhbGV4YW5kcmUuYmVsbG9uaUBib290
bGluLmNvbTsNCj4gY2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2OyBTaW1laywgTWljaGFsIDxtaWNo
YWwuc2ltZWtAYW1kLmNvbT47IGxpbnV4LQ0KPiBhcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsNCj4gcGF0Y2hlc0BvcGVuc291cmNlLmNp
cnJ1cy5jb207IGxpbnV4LXNvdW5kQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQtDQo+IFhpbGlu
eCkgPGdpdEBhbWQuY29tPjsgYW1pdHJrY2lhbjIwMDJAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjExIDA3LzEwXSBtdGQ6IHNwaS1ub3I6IEFkZCBzdGFja2VkIG1lbW9yaWVzIHN1
cHBvcnQNCj4gaW4gc3BpLW5vcg0KPiANCj4gDQo+IA0KPiBPbiAxMi84LzIzIDE3OjA1LCBNYWhh
cGF0cmEsIEFtaXQgS3VtYXIgd3JvdGU6DQo+ID4gSGVsbG8gVHVkb3IsDQo+IA0KPiBIaSENCg0K
SGVsbG8gVHVkb3IsDQoNCj4gDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiA+
PiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDYsIDIwMjMgODowMCBQTQ0KPiA+PiBUbzogTWFo
YXBhdHJhLCBBbWl0IEt1bWFyIDxhbWl0Lmt1bWFyLW1haGFwYXRyYUBhbWQuY29tPjsNCj4gPj4g
YnJvb25pZUBrZXJuZWwub3JnOyBwcmF0eXVzaEBrZXJuZWwub3JnOyBtaXF1ZWwucmF5bmFsQGJv
b3RsaW4uY29tOw0KPiA+PiByaWNoYXJkQG5vZC5hdDsgdmlnbmVzaHJAdGkuY29tOyBzYmluZGlu
Z0BvcGVuc291cmNlLmNpcnJ1cy5jb207DQo+ID4+IGxlZUBrZXJuZWwub3JnOyBqYW1lcy5zY2h1
bG1hbkBjaXJydXMuY29tOyBkYXZpZC5yaG9kZXNAY2lycnVzLmNvbTsNCj4gPj4gcmZAb3BlbnNv
dXJjZS5jaXJydXMuY29tOyBwZXJleEBwZXJleC5jejsgdGl3YWlAc3VzZS5jb20NCj4gPj4gQ2M6
IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4+IG1pY2hhZWxAd2FsbGUuY2M7IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiA+PiBuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb207IGFsZXhhbmRyZS5iZWxsb25pQGJvb3Rs
aW4uY29tOw0KPiA+PiBjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY7IFNpbWVrLCBNaWNoYWwgPG1p
Y2hhbC5zaW1la0BhbWQuY29tPjsNCj4gPj4gbGludXgtIGFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOw0KPiA+PiBwYXRjaGVzQG9wZW5z
b3VyY2UuY2lycnVzLmNvbTsgbGludXgtc291bmRAdmdlci5rZXJuZWwub3JnOyBnaXQgKEFNRC0N
Cj4gPj4gWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBhbWl0cmtjaWFuMjAwMkBnbWFpbC5jb20NCj4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMDcvMTBdIG10ZDogc3BpLW5vcjogQWRkIHN0YWNr
ZWQgbWVtb3JpZXMNCj4gPj4gc3VwcG9ydCBpbiBzcGktbm9yDQo+ID4+DQo+ID4+IEhpLCBBbWl0
LA0KPiA+Pg0KPiA+PiBPbiAxMS8yNS8yMyAwOToyMSwgQW1pdCBLdW1hciBNYWhhcGF0cmEgd3Jv
dGU6DQo+ID4+PiBFYWNoIGZsYXNoIHRoYXQgaXMgY29ubmVjdGVkIGluIHN0YWNrZWQgbW9kZSBz
aG91bGQgaGF2ZSBhIHNlcGFyYXRlDQo+ID4+PiBwYXJhbWV0ZXIgc3RydWN0dXJlLiBTbywgdGhl
IGZsYXNoIHBhcmFtZXRlciBtZW1iZXIoKnBhcmFtcykgb2YgdGhlDQo+ID4+PiBzcGlfbm9yIHN0
cnVjdHVyZSBpcyBjaGFuZ2VkIHRvIGFuIGFycmF5ICgqcGFyYW1zWzJdKS4gVGhlIGFycmF5IGlz
DQo+ID4+PiB1c2VkIHRvIHN0b3JlIHRoZSBwYXJhbWV0ZXJzIG9mIGVhY2ggZmxhc2ggY29ubmVj
dGVkIGluIHN0YWNrZWQNCj4gPj4gY29uZmlndXJhdGlvbi4NCj4gPj4+DQo+ID4+PiBUaGUgY3Vy
cmVudCBpbXBsZW1lbnRhdGlvbiBhc3N1bWVzIHRoYXQgYSBtYXhpbXVtIG9mIHR3byBmbGFzaGVz
IGFyZQ0KPiA+Pj4gY29ubmVjdGVkIGluIHN0YWNrZWQgbW9kZSBhbmQgYm90aCB0aGUgZmxhc2hl
cyBhcmUgb2Ygc2FtZSBtYWtlIGJ1dA0KPiA+Pj4gY2FuIGRpZmZlciBpbiBzaXplcy4gU28sIGV4
Y2VwdCB0aGUgc2l6ZXMgYWxsIG90aGVyIGZsYXNoIHBhcmFtZXRlcnMNCj4gPj4+IG9mIGJvdGgg
dGhlIGZsYXNoZXMgYXJlIGlkZW50aWNhbC4NCj4gPj4NCj4gPj4gRG8geW91IHBsYW4gdG8gYWRk
IHN1cHBvcnQgZm9yIGRpZmZlcmVudCBmbGFzaGVzIGluIHN0YWNrZWQgbW9kZT8gSWYNCj4gPj4g
bm90LA0KPiA+DQo+ID4gTm8sIGFjY29yZGluZyB0byB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlv
biwgaW4gc3RhY2tlZCBtb2RlLCBib3RoDQo+ID4gZmxhc2hlcyBtdXN0IGJlIG9mIHRoZSBzYW1l
IG1ha2UuDQo+ID4NCj4gPj4gd291bGRuJ3QgaXQgYmUgc2ltcGxlciB0byBoYXZlIGp1c3QgYW4g
YXJyYXkgb2YgZmxhc2ggc2l6ZXMgaW5zdGVhZA0KPiA+PiBvZiBkdXBsaWNhdGluZyB0aGUgZW50
aXJlIHBhcmFtcyBzdHJ1Y3Q/DQo+ID4NCj4gPiBZZXMsIHRoYXQgaXMgYWNjdXJhdGUuIEluIGFs
aWdubWVudCB3aXRoIG91ciBjdXJyZW50IHN0YWNrZWQgc3VwcG9ydA0KPiA+IHVzZSBjYXNlIHdl
IGNhbiBoYXZlIGFuIGFycmF5IG9mIGZsYXNoIHNpemVzIGluc3RlYWQuDQo+ID4gVGhlIHByaW1h
cnkgcHVycG9zZSBvZiBoYXZpbmcgYW4gYXJyYXkgb2YgcGFyYW1zIHN0cnVjdCB3YXMgdG8NCj4g
PiBmYWNpbGl0YXRlIHBvdGVudGlhbCBmdXR1cmUgZXh0ZW5zaW9ucywgYWxsb3dpbmcgdGhlIGFk
ZGl0aW9uIG9mDQo+ID4gc3RhY2tlZCBzdXBwb3J0IGZvciBkaWZmZXJlbnQgZmxhc2hlcw0KPiA+
DQo+IA0KPiByaWdodC4gRG9uJ3QgZG8gdGhpcyBjaGFuZ2UgeWV0LCBsZXQncyBkZWNpZGUgb24g
dGhlIG92ZXJhbGwgYXJjaGl0ZWN0dXJlIGZpcnN0Lg0KDQpTdXJlLg0KPiANCj4gPj4NCj4gPj4+
DQo+ID4+PiBTUEktTk9SIGlzIG5vdCBhd2FyZSBvZiB0aGUgY2hpcF9zZWxlY3QgdmFsdWVzLCBm
b3IgYW55IGluY29taW5nDQo+ID4+PiByZXF1ZXN0IFNQSS1OT1Igd2lsbCBkZWNpZGUgdGhlIGZs
YXNoIGluZGV4IHdpdGggdGhlIGhlbHAgb2YNCj4gPj4+IGluZGl2aWR1YWwgZmxhc2ggc2l6ZSBh
bmQgdGhlIGNvbmZpZ3VyYXRpb24gdHlwZSAoc2luZ2xlL3N0YWNrZWQpLg0KPiA+Pj4gU1BJLU5P
UiB3aWxsIHBhc3Mgb24gdGhlIGZsYXNoIGluZGV4IGluZm9ybWF0aW9uIHRvIHRoZSBTUEkgY29y
ZSAmDQo+ID4+PiBTUEkgZHJpdmVyIGJ5IHNldHRpbmcgdGhlIGFwcHJvcHJpYXRlIGJpdCBpbg0K
PiA+Pj4gbm9yLT5zcGltZW0tPnNwaS0+Y3NfaW5kZXhfbWFzay4gRm9yIGV4YW1wbGUsIGlmIG50
aCBiaXQgb2YNCj4gPj4+IG5vci0+c3BpbWVtLT5zcGktPmNzX2luZGV4X21hc2sgaXMgc2V0IHRo
ZW4gdGhlIGRyaXZlciB3b3VsZA0KPiA+Pj4gYXNzZXJ0L2RlLWFzc2VydCBzcGktPmNoaXBfc2xl
Y3Rbbl0uDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogQW1pdCBLdW1hciBNYWhhcGF0cmEg
PGFtaXQua3VtYXItDQo+IG1haGFwYXRyYUBhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmMgIHwgMjcyICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0NCj4gLS0NCj4gPj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCAgfCAgIDQg
Kw0KPiA+Pj4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCB8ICAxNSArLQ0KPiA+Pj4gIDMg
ZmlsZXMgY2hhbmdlZCwgMjQwIGluc2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQ0KPiA+Pj4N
Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5jDQo+ID4+PiBpbmRleCA5M2FlNjliN2ZmODMuLmU5OTBiZTdjN2Vi
NiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ID4+PiAr
KysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiA+Pg0KPiA+PiBjdXQNCj4gPj4NCj4g
Pj4+IEBAIC0yOTA1LDcgKzMwMDcsMTAgQEAgc3RhdGljIHZvaWQgc3BpX25vcl9pbml0X2ZpeHVw
X2ZsYWdzKHN0cnVjdA0KPiA+Pj4gc3BpX25vciAqbm9yKSAgc3RhdGljIGludCBzcGlfbm9yX2xh
dGVfaW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3INCj4gPj4+ICpub3IpICB7DQo+ID4+PiAgCXN0
cnVjdCBzcGlfbm9yX2ZsYXNoX3BhcmFtZXRlciAqcGFyYW1zID0gc3BpX25vcl9nZXRfcGFyYW1z
KG5vciwNCj4gPj4gMCk7DQo+ID4+PiAtCWludCByZXQ7DQo+ID4+PiArCXN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnAgPSBzcGlfbm9yX2dldF9mbGFzaF9ub2RlKG5vcik7DQo+ID4+PiArCXU2NCBmbGFz
aF9zaXplW1NOT1JfRkxBU0hfQ05UX01BWF07DQo+ID4+PiArCXUzMiBpZHggPSAwOw0KPiA+Pj4g
KwlpbnQgcmMsIHJldDsNCj4gPj4+DQo+ID4+PiAgCWlmIChub3ItPm1hbnVmYWN0dXJlciAmJiBu
b3ItPm1hbnVmYWN0dXJlci0+Zml4dXBzICYmDQo+ID4+PiAgCSAgICBub3ItPm1hbnVmYWN0dXJl
ci0+Zml4dXBzLT5sYXRlX2luaXQpIHsgQEAgLTI5MzcsNiArMzA0Miw0NCBAQA0KPiA+Pj4gc3Rh
dGljIGludCBzcGlfbm9yX2xhdGVfaW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4g
Pj4+ICAJaWYgKHBhcmFtcy0+bl9iYW5rcyA+IDEpDQo+ID4+PiAgCQlwYXJhbXMtPmJhbmtfc2l6
ZSA9IGRpdjY0X3U2NChwYXJhbXMtPnNpemUsIHBhcmFtcy0NCj4gbl9iYW5rcyk7DQo+ID4+Pg0K
PiA+Pj4gKwlub3ItPm51bV9mbGFzaCA9IDA7DQo+ID4+PiArDQo+ID4+PiArCS8qDQo+ID4+PiAr
CSAqIFRoZSBmbGFzaGVzIHRoYXQgYXJlIGNvbm5lY3RlZCBpbiBzdGFja2VkIG1vZGUgc2hvdWxk
IGJlIG9mDQo+ID4+PiArc2FtZQ0KPiA+PiBtYWtlLg0KPiA+Pj4gKwkgKiBFeGNlcHQgdGhlIGZs
YXNoIHNpemUgYWxsIG90aGVyIHByb3BlcnRpZXMgYXJlIGlkZW50aWNhbCBmb3IgYWxsIHRoZQ0K
PiA+Pj4gKwkgKiBmbGFzaGVzIGNvbm5lY3RlZCBpbiBzdGFja2VkIG1vZGUuDQo+ID4+PiArCSAq
IFRoZSBmbGFzaGVzIHRoYXQgYXJlIGNvbm5lY3RlZCBpbiBwYXJhbGxlbCBtb2RlIHNob3VsZCBi
ZSBpZGVudGljYWwuDQo+ID4+PiArCSAqLw0KPiA+Pj4gKwl3aGlsZSAoaWR4IDwgU05PUl9GTEFT
SF9DTlRfTUFYKSB7DQo+ID4+PiArCQlyYyA9IG9mX3Byb3BlcnR5X3JlYWRfdTY0X2luZGV4KG5w
LCAic3RhY2tlZC1tZW1vcmllcyIsDQo+ID4+IGlkeCwNCj4gPj4+ICsmZmxhc2hfc2l6ZVtpZHhd
KTsNCj4gPj4NCj4gPj4gVGhpcyBpcyBhIGxpdHRsZSBsYXRlIGluIG15IG9waW5pb24sIGFzIHdl
IGRvbid0IGhhdmUgYW55IHNhbml0eQ0KPiA+PiBjaGVjayBvbiB0aGUgZmxhc2hlcyB0aGF0IGFy
ZSBzdGFja2VkIG9uIHRvcCBvZiB0aGUgZmlyc3QuIFdlIHNoYWxsDQo+ID4+IGF0IGxlYXN0IHJl
YWQgYW5kIGNvbXBhcmUgdGhlIElEIGZvciBhbGwuDQo+ID4NCj4gPiBBbHJpZ2h0LCBJIHdpbGwg
aW5jb3Jwb3JhdGUgYSBzYW5pdHkgY2hlY2sgZm9yIHJlYWRpbmcgYW5kIGNvbXBhcmluZw0KPiA+
IHRoZSBJRCBvZiB0aGUgc3RhY2tlZCBmbGFzaC4gU3Vic2VxdWVudGx5LCBJIGJlbGlldmUgdGhp
cyBzdGFja2VkDQo+ID4gbG9naWMgc2hvdWxkIGJlIHJlbG9jYXRlZCB0byBzcGlfbm9yX2dldF9m
bGFzaF9pbmZvKCkgd2hlcmUgd2UNCj4gPiBpZGVudGlmeSB0aGUgZmlyc3QgZmxhc2guIFBsZWFz
ZSBzaGFyZSB5b3VyIHRob3VnaHRzIG9uIHRoaXMuDQo+ID4gQWRkaXRpb25hbGx5LCBkbyB5b3UN
Cj4gDQo+IEknbSB3b25kZXJpbmcgd2hldGhlciB3ZSBjYW4gYWRkIGEgbGF5ZXIgb24gdG9wIG9m
IHRoZSBmbGFzaCB0eXBlIHRvIGhhbmRsZQ0KDQpXaGVuIHlvdSBtZW50aW9uICJvbiB0b3AsIiBh
cmUgeW91IHJlZmVycmluZyB0byBpbmNvcnBvcmF0aW5nIGl0IGludG8gDQp0aGUgTVREIGxheWVy
PyBJbml0aWFsbHksIE1pcXVlbCBoYWQgc3VibWl0dGVkIHRoaXMgcGF0Y2ggdG8gYWRkcmVzcyAN
CnN0YWNrZWQvcGFyYWxsZWwgaGFuZGxpbmcgaW4gdGhlIE1URCBsYXllci4NCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LW10ZC8yMDIwMDExNDE5MTA1Mi4wYTE2ZDExNkB4cHMxMy90Lw0K
SG93ZXZlciwgdGhlIERldmljZSBUcmVlIGJpbmRpbmdzIHdlcmUgaW5pdGlhbGx5IG5vdCBhY2Nl
cHRlZC4gDQpGb2xsb3dpbmcgYSBzZXJpZXMgb2YgZGlzY3Vzc2lvbnMsIHRoZSBiZWxvdyBiaW5k
aW5ncyB3ZXJlIA0KZXZlbnR1YWxseSBtZXJnZWQuDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyMjAxMjYxMTI2MDguOTU1NzI4LTQtbWlxdWVsLnJheW5hbEBib290bGluLmNvbS8NCg0K
PiB0aGUgc3RhY2tlZC9wYXJhbGxlbCBtb2Rlcy4gVGhpcyB3YXkgZXZlcnl0aGluZyB3aWxsIGJl
Y29tZSBmbGFzaCB0eXBlDQo+IGluZGVwZW5kZW50LiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBz
dGFjayAyIFNQSSBOQU5Ecz8gSG93IGFib3V0IGEgU1BJDQo+IE5PUiBhbmQgYSBTUEkgTkFORD8N
Cj4gDQo+IElzIHRoZSBkYXRhc2hlZXQgb2YgdGhlIGNvbnRyb2xsZXIgcHVibGljPw0KDQpZZXMs
IGh0dHBzOi8vZG9jcy54aWxpbnguY29tL3IvZW4tVVMvYW0wMTEtdmVyc2FsLWFjYXAtdHJtL1F1
YWQtU1BJLUNvbnRyb2xsZXINCg0KPiANCj4gPiBhbnRpY2lwYXRlIHRoYXQgU1BJLU5PUiBzaG91
bGQgdGhyb3cgYW4gZXJyb3IgaWYgdGhlIHNlY29uZCBvciBhbnkNCj4gPiBzdWJzZXF1ZW50IGZs
YXNoIHdpdGhpbiB0aGUgc3RhY2tlZCBjb25uZWN0aW9uIGlzIGRpZmZlcmVudD8gT3Igd291bGQN
Cj4gPiB5b3UgcHJlZmVyIGl0IHRvIHByaW50IGEgd2FybmluZyBhbmQgb3BlcmF0ZSBpbiBzaW5n
bGUgbW9kZSAoaS5lLiwNCj4gPiBvbmx5IHRoZSBmaXJzdCBmbGFzaCk/DQo+IA0KPiBCb3RoIG9w
dGlvbnMgYXJlIGZpbmUsIGJ1dCBJIGhhdmVuJ3QgeWV0IGRlY2lkZWQgb24gdGhlIG92ZXJhbGwg
YXJjaGl0ZWN0dXJlLg0KDQpPay4NCg0KUmVnYXJkcywNCkFtaXQNCj4gDQo+IENoZWVycywNCj4g
dGENCg==
