Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A3E80E368
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjLLEkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjLLEkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:40:32 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980FABF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:40:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iix1MfRRx+la1aahMajHbUkjp9VOqDFw0GMWeIAWiNgZMR9NkiGwLhip1oUtIw8kvxZaXbw5AmYyC3HPE++4beeAbyGQLVy3J3BtUbZMTD7NjPIiSMitH7VjFWEp2C5JKGHJc6scRM+RVgX2XHiwbRDZSAkuTWp43hHW4a9/NQAohTQYUIml1/jXbwPN1bx+QIsshtXawpFTfm8qB5jH5LRYI7lBYiRgpJrsxJOhlwQ6ivl75WDQ5Z4yyER9wMO3h8/JQr0/h0ECtJvERfcUGG+IG92dotHM3iKgK4W4vKit4OWXcbfMrh73RdutdQxL4xyS4C6/ZjGKNKatRHJIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLRCCbXkK9X1KvtFmrGmP0J6gto2KIeKLj9AoCueeEw=;
 b=eIVRR7XCdzvgXGoeRZBukTfQveiqY/PRDcagVUWVBefka2+mbIxEiEKClHUmqe15LREkE6fJEL0W91d06YrnZssF7dhD0LWs7NM4TP/LwWqxpLkUKP/M6f8cNxqsO8RtCnmC5kus3CHzE3TRRyiLB5ww0aUXgVLWjLwZ+8tbArYrMwL2EzKVjXjunI43HxqsjMURxixmSk6ApU2PE91C4EuX/J0MMpgl2k2bq2CB8yPQFFW8CFapsga6Ztus7zBfyAoomL/vgEPSzoWrT5N5nIFhOm1HmGuuW3Bw9C4uXGczfIHCOGpT/tP0uQO4Z6vg86QjxlmxW4cSPefwg38aVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLRCCbXkK9X1KvtFmrGmP0J6gto2KIeKLj9AoCueeEw=;
 b=PStlm8M8BTVEW5KEp1/asTEexjZWN5n88tz6nunPk11wV0G40NjdkNLnDg86BiBLisu8AzUE3dcfxv0w5f7ThcyMbWvDT2Huxyewz3kh73fhzQO8NvTqPaHRndGnOxoQHdMM86oj8eBx8aKIBASgoqemUZCzyTuIEEjdcsvlxDg=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 04:40:36 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::783c:98fc:819f:9c7d]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::783c:98fc:819f:9c7d%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 04:40:36 +0000
From:   "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] cdx: Explicitly include correct DT includes, again
Thread-Topic: [PATCH 2/2] cdx: Explicitly include correct DT includes, again
Thread-Index: AQHaKSrfNxzucm5q0U2D/WQUqUcCV7CkBWuQ
Date:   Tue, 12 Dec 2023 04:40:36 +0000
Message-ID: <BL1PR12MB5333079CAFA053FDE77B20839D8EA@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20231207163128.2707993-1-robh@kernel.org>
 <20231207163128.2707993-2-robh@kernel.org>
In-Reply-To: <20231207163128.2707993-2-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=2390ba6d-c4a9-48bb-86bf-b71bb2ee6146;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-12-11T12:17:49Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|MN2PR12MB4192:EE_
x-ms-office365-filtering-correlation-id: 0be9526e-342b-4b56-5029-08dbfacc7c26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: glA6uLtl9wx0RwPxvUz4EZXW4GtPC7jCGt2+dnU6DfZ8DzqljJEsnoeUN83359X2t66/LGOpD9ioiRXjNg8UoiFE1n/Du1lhfKHKIDrUNr9S9avqIEnZ28uycX5puIVceUxpdwyDWZ/su2A6FqCLhbxSdl0G0Tc4+ZoQGlwSx4CdL5h8D+zq8EgYK2Ol8CbEuCWsTvQSUxV7T7CxP4pEQ0ayfsogs7b6HgqCkUnnu/HEEy6V7oXjDO0gYk6tYj2twRx/KF3fS0BswooO83b/u0dilj9F/dK7P5sTgm/4nQz8aM6F5nAKbv9XNVyq7M3gwbOGRrPPoT4/d5GsQnT1laLrLL6ZlGwRZWax3slmnvaDxHPXALZyWEtPrAGCZVlfZaQmj47S/1OAu9ErlMXDgmO2iGAOrEmQrJw5CJRsZ3uEku7ID+IxWSHX4xl33IObFQyurxXRexk8M4okQsUGYqbg28qYHrIzGDOd++hm7NRB24faTpqNJvVnATsuNW1EkdEaPfyaMD1ysIvMbWoyIHZoHpCCRMAvLkNTwT9D9gCO3m/wjS1m/piYsVUliGWOIIWBIeC7Zg9N/F865U8iL0a1hMBu8nTPvIGYAhv1JkADMOcNAPGKzGsVlQn8bCBK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(83380400001)(53546011)(7696005)(6506007)(9686003)(38100700002)(122000001)(5660300002)(8676002)(4326008)(52536014)(8936002)(41300700001)(2906002)(71200400001)(478600001)(110136005)(316002)(6636002)(66556008)(64756008)(66446008)(66476007)(66946007)(76116006)(33656002)(86362001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M+ME7Q6eZ/T3/g1cRKqvMo6bjNf8LkFys2gcflZh0QwWXeU9ZcnTCo4XlF8b?=
 =?us-ascii?Q?D4YjkPG2pXZ+7x1WwYwXM6HsymeOpQ5w/H+TSQlLkAZUBTt281ADdlMookcV?=
 =?us-ascii?Q?ykfFZ4WrETDHd/MWh9tgBWYdY0sBu89s8KD+y309nHaDq1KNgOwpLggmU8Q1?=
 =?us-ascii?Q?5SH7Z4tYrEOUPUw4t5gSJ5j1b6YApxQ7lwG+iyrqqyFiMMPbacNeILxuV5m3?=
 =?us-ascii?Q?+KNHhHyCwMNlY9nNlO/8x+6Wrfdu6WkHDvPHReVUaP7u1H/YdKSK9zhXvtFP?=
 =?us-ascii?Q?hxX8d1DfgmtI5VFH3gQfBMEgn/e4LAW0x8cIjLQgLmv/FpkBe4e/FGjZc2EC?=
 =?us-ascii?Q?uQ2kG3q0qirSUPq2HXPgl1zA5znnotQ2HMf9EtQXixC2G6uwie2rk7UhrjhK?=
 =?us-ascii?Q?GNNiEY3tk5/nwsxgrOVI38I5xCE9V1O9dYOSOXfna30acIYA4F1VdTPpLqqh?=
 =?us-ascii?Q?m64PS9e6OB0VwYyydnNq8t1MgxMI2XjepOqkyfMnxB3pe/h6mvSfloqY43XX?=
 =?us-ascii?Q?dOjcUY+OL2dRVgaoQUPnvAreTVQNRXKmbeHlPzRfS2HUPmIzzt6w0Ywd/Md0?=
 =?us-ascii?Q?97TxYMD1HbHMyYD4LqdZ7YfTws/GpInDWvsi9ErePi9RRfwMEzZ/6eoO+zS+?=
 =?us-ascii?Q?TArUgo0DXOj/TL0jlFdvJk291vseFAMRJgDgu9+xK/jDoabkdpCVlE+eJbBw?=
 =?us-ascii?Q?Y3QLRZ+kqPyKJ8D2rtkeqW1k7hxGhAbtvzEWEvCzqtuPGl6WBI8JQD6hPAkQ?=
 =?us-ascii?Q?0jSWqratSOm4t0Lk8fQz7zJXQQO6jGd+9b71agkPh+J+7i5Zl44o0HjtEj4r?=
 =?us-ascii?Q?KxTwHa/1kikJqJA6s4dHoCAcouqCgyqCoKZUVq39IHNMj7D7v8ara6sw/wwZ?=
 =?us-ascii?Q?z1H5IWW6ZNv9Htoh0oQEnSks2fhRV1WypUwec4lnjKuRiOnVAfTqMGt70fxS?=
 =?us-ascii?Q?hELdYBPEPyP+RMgUB8sHIt4WExm9gL8qaBieh+GtzLSjYSetoHXH0+HCGRze?=
 =?us-ascii?Q?pz8SjLhIp5SMIqF2SnDW6rx5KSW4Qc5MCDoIBTUBvIOnkgE19ypSxhbA5sXS?=
 =?us-ascii?Q?/zcaaRhGFoTNDywlrC5BetNnx5hDZ18RQzTZ1K2wsasGSVv/pi3BcyxfGNa9?=
 =?us-ascii?Q?BsEDH649N9xw7F/IgyoIRMV2oCC14d96na9rCxLA+MA0RJZbM4qjyGeTHsIb?=
 =?us-ascii?Q?gDNtcLeYtn5J4QkZu5aAHIZrk97jA+D86dhrTfYXyolEltWOjHtAnTgoMQLW?=
 =?us-ascii?Q?OLNtZJ+zYyUr8ySFQnfU7II0WBCY08C+VedxKAlHU6vG2vk2MGjK50RuimD8?=
 =?us-ascii?Q?fGfaaJ64zbuJCE2EiYwAcloX6vCz1KhOmt58VnuR4u5jcFI1GJ71KFAi+FW3?=
 =?us-ascii?Q?X7hWNucSm6uIOlLJQYWHD6dA5x2yxgRotRj8dXqd4ROkwmxhf83DhIhPg8RS?=
 =?us-ascii?Q?rSExT2p352wg8Ltxjk/6Es2a81lSDMcLfWy8E+b8YlwtqDea8H/TaMrJjiDN?=
 =?us-ascii?Q?ClYvzolZEYsYR/4cizds+CgCVitWNtme5rsca19MrwgFqAhc8n+5MQASim03?=
 =?us-ascii?Q?25wtttWzNlmeqVaW19Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be9526e-342b-4b56-5029-08dbfacc7c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 04:40:36.6012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5g+rt7uVryQBgDsDh2gZsE0YF4caT8V++IRAbAUBe+1B1tHXgxR5ZmKZGgdRiUs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, December 7, 2023 10:01 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Gupta, Nipun
> <Nipun.Gupta@amd.com>; Agarwal, Nikhil <nikhil.agarwal@amd.com>;
> Gangurde, Abhijit <abhijit.gangurde@amd.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH 2/2] cdx: Explicitly include correct DT includes, again
>=20
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h and
> of.h. As a result, there's a pretty much random mix of those include file=
s used
> throughout the tree. In order to detangle these headers and replace the
> implicit includes with struct declarations, users need to explicitly incl=
ude the
> correct includes.
>=20
> CDX was fixed once, but commit ("cdx: Remove cdx controller list from cdx=
 bus
> system") added another occurrence.
>=20
> Fixes: 54b406e10f03 ("cdx: Remove cdx controller list from cdx bus system=
")
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Nikhil Agarwal <Nikhil.agarwal@amd.com>

