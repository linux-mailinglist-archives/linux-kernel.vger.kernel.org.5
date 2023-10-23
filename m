Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24857D3B25
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjJWPpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJWPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:45:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BDB127;
        Mon, 23 Oct 2023 08:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJaX5bXRnfonv2sS/DxMHXPxOIxa9Gxteo+q0N7/Q8AhJZzZw7sNB1BLPHrHU6BV44JF5XL4geKp5+KuCgnv0WXaRZKosnqmgo1SKIV1WimacXiUrTPXtrJOSaWDMm23VuGhChuseU4eY67Lxjolzb4ytA/9Nn4yKQmnU60rQ2bbqdbOlSaOT/2TG2So9bAoENeHUpb/gIVBqFpbnvs6w2UF+GLt8zkiYnwgsA6C7vWT7pKJMLnUwdhvLvDVicGWTj1Ry50m2DRqU3/Fi/cCLRi0WihTyjyB3VbMVztB8iah2Xs9cIkF5HDRRdnrqBZkFJ8PNwX64SHwWen9axjbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4JrTrRgsXPIIHVYQMAWcQL3s8fV1xtMYq3B240/gk4=;
 b=eZ/pgQmKqcv5ZzWvF7gicV+WQZTYbd4ftS7vuvWfWs8+GN+J39Ds3Vy4dfJE/T7FCwffTu1YhB/27JnSs/sI0T5mcgVTDHszI7Vpiy7/EbCZ/8zq4runTDnXLKvK1hySurpBmw5SGJhzLb6JkATs10PqaRVii3sL4UTAANQc8Yh9KnXPLqWQyPQ8/CYNUbJVDccneYNaqoOTl1n6ctN1pcqt5yu7m24/HCDybuP9SNTrnNOv1UfkjELNEzjXaCggGqscOsvwkzCLZgE4H9HuMNBnIOcy1Ulb+x6VJH6fVJKoiDdRYtt9K5ZtpwWo9PJ+F6yAsJd+4y8EoWYuh5rTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4JrTrRgsXPIIHVYQMAWcQL3s8fV1xtMYq3B240/gk4=;
 b=T3hiY/DyiSXcuYt0Xsg4HrjRUIA4K1Pshdgq61ncG7sDqPPR/QqIicPKEH4dS+nhrY0kznnUaxLOVVIYaGs4M0kzoL+/S46KvBO0R4P3o2jyl+AI2pF/TID8+SrB5tzn2l9GQbBp6jG5NFIAVt5uc55xBhDmCM8U0w1gkx0hEDQiJdPL+Kz9bgZzpT4PDgsEqSnXasPaQ8d8pVQAtYIgr18DzevBNBzi6PzePse6Fp5hzQj/fyP2z6/DtvTy5jUcxsaKmjfK/mAZ2bUyr341BngUE1x856yezfGTlcfiZGhPZBbZX/BatADek70tHpAUpdVp70e5/OwtX6Di9L/cmw==
Received: from DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Mon, 23 Oct
 2023 15:45:13 +0000
Received: from DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::87f1:f2ba:c75d:ef3e]) by DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::87f1:f2ba:c75d:ef3e%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 15:45:13 +0000
From:   Jeshua Smith <jeshuas@nvidia.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Topic: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Index: AQHZtREytrmSwIEvT06Ibqr95x6guq/abXNggAAKnoCAAI5FkIAVd3TwgCWuaxCAIP94MIAg+dpQ
Date:   Mon, 23 Oct 2023 15:45:13 +0000
Message-ID: <DM6PR12MB33710C8FE59EB3CB1404ABC0DBD8A@DM6PR12MB3371.namprd12.prod.outlook.com>
References: <20230712223448.145079-1-jeshuas@nvidia.com>
 <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <DM6PR12MB3371D86F80417641B8479B28DB0EA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371FA3AEEA4D17D94C889D5DB1BA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB337153EE2DDDB427096446F0DBF2A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371083F4E6BCE4A8D2389E7DBC5A@DM6PR12MB3371.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3371083F4E6BCE4A8D2389E7DBC5A@DM6PR12MB3371.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3371:EE_|PH8PR12MB7109:EE_
x-ms-office365-filtering-correlation-id: d71d3911-4803-45b4-16a1-08dbd3df0be4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FjDXrc1NxFn9YEd569QzDnZEXt5UM4OeW+mj7ptW90hMCSXzO+i/u7V+kQ9Fd/RxIotP06AhSLkuaOcpOgZTV7z3YXxF9aqNQOcLTABdsU2bhwdM54HOfhNbm0bgwq8+Ms2deKVUmMlQT58e85mgIXW/JxLIDtYQr+plFiNquFyBgLE23A3A+PtHlCniSdUUpTI/UfKG0CTHPjdiCRnXQGyfNhpccuhqXdNO6I69q3C/jzul27DeHLonuwTi+aencSmrzSwWEphh7snc8dPpXLiVT9cjBLis2/wJkzOV2zSoahduSTzFPDbJ6j3fcTUNe016i0bsxajz5/sQ1ufU7iHHFXc+1yF4TXPuM8XaRSEAE54ASj4E0rQEHgSXWxRXWpUWbAbPc4zJuQHgwFKms3ftV6QYaOm9CV0TdAVEgQ9KnxjhN16YngoAdTktFP2N/1esmf3aswscFwcQ/+X1ru5ICy5c7xyvx0Z9VHgu+nsj4UjOPHyiWAdPavpxzvGiQN8mXbhFcdqQrXO6elyESlEbCBbXRHuLCYJvBU/0KXLgSqzAQTcKMxyws+sZke2ejNxtZMn+oV6ypeBymqcVNGuzswUIIKRbymfDuFSzzOpFNhAiqLzUaLffI/oDbqtTDucOgzAO/jEtxOKn49k3lAfpBDmADCkcjhrH17VkR68=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3371.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(66476007)(66556008)(54906003)(76116006)(26005)(64756008)(110136005)(7696005)(2906002)(55016003)(6506007)(71200400001)(316002)(33656002)(66446008)(86362001)(122000001)(66946007)(107886003)(83380400001)(53546011)(38100700002)(9686003)(38070700009)(4326008)(5660300002)(52536014)(478600001)(966005)(8936002)(7416002)(8676002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AcgGE80JGTW0q+z3fZwYTO6cRyfuWvd9Bt5uGeOz2u41+jjQbcjyIJPMHt+y?=
 =?us-ascii?Q?bQcsWh0aqWylnzfmIBGOjgJ3P3uKgIyDH9fly9ImSZOSPcHloR/VnYwMEvzt?=
 =?us-ascii?Q?e0znHSPqyDQNy3eFn8SnzYBnDshDxhmIdfvSufNKjOImp7MuBa6J4dGpOGje?=
 =?us-ascii?Q?0qwoyot6LlXwC1ZDUTDHK/THiLUqtU6rbjN5wrILv7yQm9PEupxBDpigZ4NR?=
 =?us-ascii?Q?7wTPN9V4S8a2GQ3soToUvsir5J/3w2YT89VIVhyrlA+e1JlG7GZba9FUkPKc?=
 =?us-ascii?Q?4GzV4cq/9J1N81141FPI6Zj7N3jXod0N6Cr0pxehNsohozroebYZfWlOS3ff?=
 =?us-ascii?Q?tDXFTF2n+Zse1hGCoPqqta09hKNwXVNhwN2XOFufXkS09DdkCEP/LLVucFbt?=
 =?us-ascii?Q?pFheyDPCyxvCXJP2yfttWm68ONAo3xSBgEp277Kzjz0jCeysdXTzQL6mchLb?=
 =?us-ascii?Q?5ecziBYBnQJtYaUmpZ715TzXyrHwIcJunOeopaHFGgIcLpqgN8oAguvAwa4q?=
 =?us-ascii?Q?rXPFYMAhQX5VppuqTdIl5KKEX3kvxyr56RJ0Uc0n1ytZqFyaqRXtq4ID3cw/?=
 =?us-ascii?Q?o/BlkOsX/tauczWi4BrQ0mIrg6oXeLHCnYt7MxTvlt/C0vuCQNWJi9jqHEan?=
 =?us-ascii?Q?FimVf12nVnCYISNcyFHdYmHKGUpz8OxsyO8+q6x1rJuq2a6ftEUFpP9Q0iqC?=
 =?us-ascii?Q?+wcYteWaJFSNYPq6OF4DCWQgA62KDGKQ1OMRCmWHiSVV9Ge3E5hiLeFpXAfB?=
 =?us-ascii?Q?PqdQZlUeSFMOb3rUzxp3BLJSDyeAaujlC52wiEsezMyQohBqT1zAl7rI2kQF?=
 =?us-ascii?Q?2bzeBbr8ou6C6EvLyR5Ec5osbMi59nNSSVILJ2w5PTMpUowOUQhFi8HMPZnM?=
 =?us-ascii?Q?3gQgajI30a7qk5YtvPDcYoA53F5BYnlToxfoCoyECR2JthM4NHcPOmCoZlLR?=
 =?us-ascii?Q?EwhC4BQ6ZYAOPbHJ6U2CAFLTq9r9VTSM+BkzMYg62CpEA8F0gsKesmdihvIJ?=
 =?us-ascii?Q?o9tkHVFVk2fApP6MNMPiTl6ozFIrwEnOsBfmt7qckM0CCYL3XjeCH8W/qDJb?=
 =?us-ascii?Q?nAnKonirJnfuLTCwF+PZByxKsQIw+kxMVHlZSiRGiYM0fEBfg89BsY4x0+rL?=
 =?us-ascii?Q?Ryozyk628xjZvmWYFHt35seQsK3QF91kpkMxjUaYsWmY67X5cNd5lXK8Kg7t?=
 =?us-ascii?Q?P0ETYTuy2Knjq7x/Lr01dbsC5Cgtktq+41CkteWZn/OsVEOcyd3Dtv+4Yv58?=
 =?us-ascii?Q?sCodq6VTH/YeHw95E/xIyCRaPlNhJ6qqOccyPdZPsoova3/i05rHSMvIinqj?=
 =?us-ascii?Q?w9i9v3uRQ0r7qnaE9TgOmms4inHIWy5n+yr7axemah72NL3TvkLGwwr4uztX?=
 =?us-ascii?Q?rzXAqXsYA3e9+j0PNdEtmLIB6WhB67XnMEVS9yE3aYTPp+n9QOaB+wzF34FX?=
 =?us-ascii?Q?wa4/jG75d+6N3BrCCXdlCJv4vx8epSVDr4pCz6+icxXlVcVZe98Imd6ECBnL?=
 =?us-ascii?Q?PewEfr0kYAERSZw87EyyCwUjuprMJ/bTd/mfkFmll5biKCSrpLxjquim/zGI?=
 =?us-ascii?Q?DrPPgYN9LKzNjIfPBoqYrORPfgDz7ugFAynt26ZZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71d3911-4803-45b4-16a1-08dbd3df0be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 15:45:13.3190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKOUneETTorE+ajH+FBIW92XgG7Qg7b5vT7Z0jdiiuYpg0KL9eD1+obKVZRk21wciAY1wizSJONmTUuEJO50ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can we get this merged please, or at least instructions for what needs to h=
appen to get it merged?

Thanks.

-----Original Message-----
From: Jeshua Smith=20
Sent: Monday, October 2, 2023 10:10 AM
To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@igali=
a.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.d=
e
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

Resending due to lack of responses.

-----Original Message-----
From: Jeshua Smith=20
Sent: Monday, September 11, 2023 10:16 AM
To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@igali=
a.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.d=
e
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

Any further questions? Anything else holding up this patch?

-----Original Message-----
From: Jeshua Smith <jeshuas@nvidia.com>=20
Sent: Friday, August 4, 2023 7:05 PM
To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@igali=
a.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.d=
e
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

Thanks for the reply.

It's not very easy to see. It's just a bit down from the link you sent. It'=
s the last possible action in the Serialization Actions table:
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#serializa=
tion-actions

18.5.1.1. Serialization Actions

GET_EXECUTE-_OPERATION_TIMINGS

Returns an encoded QWORD:
[63:32] value in microseconds that the platform expects would be the maximu=
m amount of time it will take to process and complete an EXECUTE_OPERATION.
[31:0] value in microseconds that the platform expects would be the nominal=
 amount of time it will take to process and complete an EXECUTE_OPERATION.

-----Original Message-----
From: Luck, Tony <tony.luck@intel.com>=20
Sent: Friday, August 4, 2023 10:31 AM
To: Jeshua Smith <jeshuas@nvidia.com>; keescook@chromium.org; gpiccoli@igal=
ia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.=
de
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

External email: Use caution opening links or attachments


> Can the maintainers please respond to my patch?

Can you give a reference to the ACPI spec where this timing information is =
documented? I'm looking at ACPI 6.5 and don't see anything about this.

https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-ser=
ialization

-Tony
