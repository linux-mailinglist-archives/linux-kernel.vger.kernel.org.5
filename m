Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E115E770CD8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 03:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjHEBEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 21:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjHEBEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:04:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4104EDE;
        Fri,  4 Aug 2023 18:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/y/n/8U4wHMOeAMM59bTyu32ImdlIyYJcwfP0PJEj/8TI9p2jnjbfztohZ81Baoptu0RXsqNCtqTT5kITPsbQXBillGKNEM4VZY0PSV3XTu+Td5oH6qENhaphzI8vuhLuO4fsbQMQwD2EcgC0uYT/1NibijnRidDT/EkWXTrSLVu4gzyo9z/rmzLZNTrGcefT5QvE9YnJv2Sunpm0HTowP+TI7sphspmZLYwRfHK5822QEueVs0xCzaxHvGjBrsX/utmjlgxHbumKSR+ssedJIKkOmhx4/wtu9cM+kZR+1IZaCkQiQ+tkKe+JS49CTZkl4h0iVHgPKIXqhtqzgsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oITSiRv6yTDoqQIiF3an6Ub/yQfRifEsqhnPZjoqEVU=;
 b=QqzU0Y+NPmb3aNX5pFV8mwLqL/yuyKkLMVREhSfRK5zR3ULLz70FWoLnxaLcMVg5pZQuZtVviLmkRgn4ScbtxrL7qLiJYn/jE3A1wV1+RbtEEr9Xr/rlezSIzcKjsb7RHUs6apmmbjlWecyNgnT+DX9nBhMk/d5qnQWpDDKhyE9KkZYch2233ef8o/vHpiH/94pw5xh4es5i4MlpTXL0QFnBiiReCYXFgZLOxhgD0Ti78NVFRnhDAPPJ9OAyQKWoh3cZINYrRAe/TcaIEARDQdDxnEUNJWlsigK9/SzW1Rk5kzBGuyyQPHcZN1TB3DBh6fd6rfYdhQE5NF6HKTSB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oITSiRv6yTDoqQIiF3an6Ub/yQfRifEsqhnPZjoqEVU=;
 b=kjnyY20nqjngz9dlyJ8O1D1/CHlccfTPwqXX9tmnImzqO3IBII4R2G1hOrZNNZh3vwNu/aRkIHrbPTnHmfNk/sA2JHsZ2L9waFf8HkRR3ihUJ2GgHaq6UOKOAVQHK5YM7OF6aFqTGIYPhgYyZANg+q/zRHG4jrcLocdnlaj4JvdgL1rXF+W7COJX6hTyXRKZMExFF2Byr9xJbqnbDCcqH87lsUSEtTo58mv+MkIZFQEeFNJYswXPRd3WOP6ZMGbNh/kqsTRNbxbLG7Wo0zRAP/Wt5y6lGNjmqE8VOep2knEKpaWr55iyFEpKeeIcAvFzsKHJy8VJzH6JfT2x8WefuQ==
Received: from DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Sat, 5 Aug
 2023 01:04:42 +0000
Received: from DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::ed2:99a4:2e77:89bc]) by DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::ed2:99a4:2e77:89bc%5]) with mapi id 15.20.6631.046; Sat, 5 Aug 2023
 01:04:41 +0000
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
Thread-Index: AQHZtREytrmSwIEvT06Ibqr95x6guq/abXNggAAKnoCAAI5FkA==
Date:   Sat, 5 Aug 2023 01:04:41 +0000
Message-ID: <DM6PR12MB3371D86F80417641B8479B28DB0EA@DM6PR12MB3371.namprd12.prod.outlook.com>
References: <20230712223448.145079-1-jeshuas@nvidia.com>
 <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3371:EE_|LV3PR12MB9354:EE_
x-ms-office365-filtering-correlation-id: 3356d9d9-dc8a-447b-7a8b-08db954ff2f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UH8VbNEL7KpKOSwleZGA9fOoaTgGUJmmDL0RKJbTcMAakcG4yr8c2hZ2+1yptmEs1E3Pi98w0ZtErfv4DV3bUHbhO1rwZSdaI6x3IQojbjdecrjTwu9KXjTIo/kafuYWwnInAbX4qSPT+uVj9b0u+JtBtfgmcz7YAXQZWIHoGz3CpUHQ9mExRqrpS8kEYAIdk/wSx8MC5es3WMwBGXLFSLPBxljwRUNmV83GnyLqZDOJCyCi76s0os0N5l+RQgosw1qmYNZ/njgmsK+j3qhXwhSb0zPkn12gVW7yfz+ahekLbiuNMpqD+2v8FA55fMxzSLwrUclkCido6HJRNphEuT/rCnJNYqtQhBSSereGBN1sjhC9hMrXV5xcNrbJmnCfwe2XVwwsG9SiWHuZznm+ju41Er+8dOSlR9QlO6c/4AMXDbPfLqgennLE2t6G8oODUXdhZGF2XzaxMj2wAgRXUraaOc4srVfGvl0REfKdrv7b6wgm0RKBVndVF2uzW1P1rGd4lUD7JBZuAKHqsPhPdon4mNKJL6ohLrCDeAHSPnjrG6XfJ/BZDr00L6g/05mgV6oStQ5nXhRwNuJ5x+N7kbDJuos+hNUIuxOMNthsc1A6rdMTzJG4OPhRsgqMFJBhPFLGksP9Zm7mfM9YnPxQdmLv9HotQTJCb0fVD0K9YdM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3371.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(1800799003)(186006)(83380400001)(107886003)(6506007)(26005)(8676002)(53546011)(66476007)(2906002)(4326008)(76116006)(316002)(66946007)(64756008)(5660300002)(66446008)(66556008)(41300700001)(7416002)(8936002)(966005)(52536014)(9686003)(71200400001)(7696005)(478600001)(110136005)(55016003)(54906003)(38100700002)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9+5P557dH/8WkDtKSyhNqoNx9rrKQptZ9gnVbyp2g503Xe8pqpuvIDdejqmg?=
 =?us-ascii?Q?ujkzt56OvOYyeJ0a49aIMqt3t37eDWqTQftENhqBKpbDQwb0TD78ybKB5rwe?=
 =?us-ascii?Q?R8lvlorVSCglICgj5qbABnCY3tE2OVZWMOERldphlaY6/obJFjH7YIrZ1hWH?=
 =?us-ascii?Q?eKFAH0ktQdCP/Zo65HVzxB/UmLCCK0fOezp7g+BDtJIKrbnIgNRsX/IyX/Yr?=
 =?us-ascii?Q?lsSiNRdd8xrMXN10pgJPFdVaqglZJiAZlQ9vkzlp09+0mDSiaBVxPqHTtk3L?=
 =?us-ascii?Q?29TAYdl6aReVjfBu+i/qD8UTfk4nyDfoYdBG2qt2AF5LcmLComzPG6EX/GKI?=
 =?us-ascii?Q?JIV5gSyvw2teBwwwTquxZ/jhUnnDLw9Ue6ilOmBhRiVZ/njycHgp65GqzJdN?=
 =?us-ascii?Q?A/Hyhj2Q8aoFykXTF6NS9dpK4DYob//5K/X94nl+c5fuHCC/powr8+2UJ+WU?=
 =?us-ascii?Q?qcSaSPgEZcYgqLoMoxkE+uj8YBPgmxVDJxWBVZ6CCXlVW+gUWr1kwXGqLngM?=
 =?us-ascii?Q?zEyltQREBlEKkfCFalTWwT3Iad6r3s3eR/w3Vx0uf0T4cWf383Rse/HawwLn?=
 =?us-ascii?Q?ldeKk3N7uLlS/lqAxmr/hzzLh8URDcPL/RLj1hePaPosn4me31HCsRQ//8/m?=
 =?us-ascii?Q?3eE/Nlnh9M5ZwkAOA1Uk5DFzh8tXYFcx0nsc3wjciWZRvmRhibRj9KTg+dBk?=
 =?us-ascii?Q?R3TQXf8ekP5jYE5UY8Jobjh6o9pWX96xSMz5qjAYkhPAqSrrGcU8P9zxU7IP?=
 =?us-ascii?Q?KOpt5icgxM1L+SwtIIT/sRaVDhl6Q2xuEYlkrWnIyB5jGyruub5OyFLbWwSt?=
 =?us-ascii?Q?pv0TBNHOWCHeuHKu4cYByBeTUTGrzpKO2eftFgrU/BZ4K+jAmydf2k94ScE+?=
 =?us-ascii?Q?WmG/YMjqoBtEn3c9uswsFlJ1JlzfCaeuSGOUOJlN858w63k+xdHxQJIIhJOg?=
 =?us-ascii?Q?/85oR6pC0BjUyK+AkVAf/c2iZqwEZbgdz8UhgxXQgLCN2kDFyug/dWx8D2v5?=
 =?us-ascii?Q?A70uSoOZsK9xo/W6O/GVDtZQ3L8N5kmEaTKIeN1L1kVlfI6Ty7yK1CIDsWcB?=
 =?us-ascii?Q?aGWH2DTiA82CbY93tylRN2povt/Ek71DhaXTjREfO1Ota5U1ulqmIo0YOa3f?=
 =?us-ascii?Q?Eav58EP1pRlZdaR57DO+BgKe2+BriW96N++AfNEW36wY63b+w/YAFCytDArB?=
 =?us-ascii?Q?ObAoUdExhXB5DXtuW9fHFz87SIvFS9jfFITf/Ut2q7+Uk6tGsPUE6PqeYb7E?=
 =?us-ascii?Q?alxap/WnoMiyt/mA7thNL7xaJ7TVZjFHFN4EZB1nImFvELz4TAIQGqnnYVAt?=
 =?us-ascii?Q?jjYqdD/yeZNhDN/ue2ncygD7TUfd71VH4R9CtL2P1t2VrS2bKRCSwdvJLuYF?=
 =?us-ascii?Q?XfLGBjrxfm35zt1QPxhLvJDmQkhbHUvReLmyP0SA3RVC5xB4FlHH8I5Gcz7E?=
 =?us-ascii?Q?u6GQY3JCDNwJTyBG620cbWpAbqqnLQTipCf6UqTEnqcHrMv6TcQdq3WHhDUv?=
 =?us-ascii?Q?ZWAAl6D5X9PRMJq37nLPlSyl2ul/Nwo1jhwVVC2pJCkFuJf/RjjbdSwhpDCH?=
 =?us-ascii?Q?M2GqVMBDExvJOP/WAzdJnxFNbxMHpKyuFATKCSAy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3356d9d9-dc8a-447b-7a8b-08db954ff2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2023 01:04:41.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZWVjBfS0QedWnqYjshnfNMSQyWO87Og2f+nCoxpm2DE2VyHCQuQHNOT97YmLsqY6fmCnN/5nh0CRylojNBxtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
