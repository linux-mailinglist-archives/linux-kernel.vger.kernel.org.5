Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFAD7D1D81
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjJUOjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUOjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:39:37 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013003.outbound.protection.outlook.com [52.101.49.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92ABC0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz/+nFHSl5fbVPTfIhwpvzA9/2DQSu5H2ClwSH8HNjb6PnGGKD0I1+qxfPczVkVYPl6qJTTaNctDHVuSabefFv5OJHDuhZYyFcrFcYKygtoEMk2PenScQpk5vZpE4jVk2RPdHMZltABSV12Uc0VBcgLG1rvrFVjoG16AlnWSDhhacwNbP1luFDlE+DAwJLED54QOJ10J3JAcsCKeN84PdjU7RpQ/g9HP/Kb0aMVE6A++qtMPBk1LFyNPpOdXax6D+JbXqGUXzC5Jd1BGshLqKC/D53ALynC0SokgMlaYcHVftFVjMqQKux8O3skX6bthAg5mKbVgqGYHfhhdv8AlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpuCka/+6wFqNgay6dyeoEeUDzG+NyS7kNH/7wEQBvU=;
 b=NKtUnqc20cUXPo/MvbrBJDyLc9/RUJAKCWJTbWt9lOSe3APxT7S3Rczi0ZLhuumYwmK5+vFEaYPieHLwLcaJ/1WNG5w/S5D2XLT1ZDsCdhuFXniZ22uaSv0zKpqFp9162aDJF/bDB3S4nFbErD8iDn1A+R5CgaPiEhb9B+ckWGX3NMhEQl4ntfeyR1wcjaIke2EU2k4LEV2ohFPCw9sWFwONPl3q+m217E3pJBoJaLg+QcdHrHdYLhckQQrZQuaDodO15bYNMc2LK6ZbW1mem1DBW6nusbliy8MLXKL7+98o9DA1Jmi1U0o9+CuXIxkRgev5RDyUrMzH83Oc0h1/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpuCka/+6wFqNgay6dyeoEeUDzG+NyS7kNH/7wEQBvU=;
 b=qGjj3iWoTlGVJIEwEG+Zx7CgM1UJCRnfjkAnqxOJqhi1oEnoz5a/4ISsFXzhwISLSm0jUDbhnN+zRRDDKwPjBbtTG7Oiu2EvuFUItVOkACcVrJVgGYEY4Gmw7vZrfgKrE0EUNBsCTKL9FMUi69quMEg3LUx+vaR7TCI9Ple7fQo=
Received: from SA1PR05MB8534.namprd05.prod.outlook.com (2603:10b6:806:1dd::19)
 by CH3PR05MB9531.namprd05.prod.outlook.com (2603:10b6:610:152::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Sat, 21 Oct
 2023 14:39:30 +0000
Received: from SA1PR05MB8534.namprd05.prod.outlook.com
 ([fe80::3e01:4551:f655:e4c]) by SA1PR05MB8534.namprd05.prod.outlook.com
 ([fe80::3e01:4551:f655:e4c%6]) with mapi id 15.20.6907.025; Sat, 21 Oct 2023
 14:39:30 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Uros Bizjak <ubizjak@gmail.com>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip v2] x86/percpu: Introduce const-qualified
 const_pcpu_hot
Thread-Topic: [PATCH -tip v2] x86/percpu: Introduce const-qualified
 const_pcpu_hot
Thread-Index: AQHaBCwu8Q5oj11UlEOJ4ROt7EukH7BUUGaA
Date:   Sat, 21 Oct 2023 14:39:30 +0000
Message-ID: <C5B8B806-34CD-4654-992C-4FE3FAF85B88@vmware.com>
References: <20231021143739.843941-1-ubizjak@gmail.com>
In-Reply-To: <20231021143739.843941-1-ubizjak@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR05MB8534:EE_|CH3PR05MB9531:EE_
x-ms-office365-filtering-correlation-id: b6eb4628-4d44-422f-576b-08dbd24388b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TpeFLU2IZoA0bxMDJNrhGhIzF5kjg38/rB6iqgT/k5P9FJnMyESc/dvP5Lgf73Ehvb53J7yvA+CVIcJEwpKR1yE3GTqKKZgC0y+swRbKhWQWJ+zLYZ6vCuVDkhxM3onXZaj2CIXcJuilk2BkEVYPYOuRW5FpJVlX3O2IxFHYe6GSJ1G4psQfqE8mwHNKS/fGOOVAj+EFEarboyYBWtQAAFyV+uH9u6gg+AC+YfDFCOeo2YAvdrhloT9MjEtcvy5jLvNbQiTEiFku13YHRcmhDdhSqBlxuE4zw/EGm9Ie+yHa6Q8XMHWAiXOKqr5Ck8KBDqfO8bqO0zLNFSOZ62tzcQiDdZ7ILy2BEDpr5fq6TzrabMt1qYDB2wWugEkQ+kYGRTppGIeoWTC+xSKwVW860xQEu5RbW4R9LVlqfvvkzlI9NDmTQ6b1f3Fc8cNtjcfP7koH8P1pms1xAZLtKWxgyD97g8Lnui/Xl+RzJnUXnkPH5SwTK4oO5A978VdiBF2/n3JcY3Gwf+3vRseEll7Y9WhQUJeEOF2/YMjAvIylqCMEXYDabiR/OjptLREANxlS1ALV1i8QYgYw2H9sJnhOU76Sao9cpHky7CmuqW6+QZwzbMfyVONGXCIVPL4zYqzfIZ6vmxuOwWF8U4fygsMOeI76DQh9Or7DLu9t1gzBFjCoA49SrjMZfnTYtEpbCAtkaiVijtgi2uawFvYCRbd5xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8534.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(33656002)(38070700009)(6486002)(66476007)(66446008)(66946007)(91956017)(6916009)(478600001)(66556008)(64756008)(76116006)(54906003)(53546011)(316002)(2906002)(2616005)(26005)(5660300002)(558084003)(6512007)(122000001)(8676002)(7416002)(41300700001)(8936002)(4326008)(36756003)(71200400001)(86362001)(38100700002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CcdTxx9wTckDb9cqZEf6T5N7LfyEXDziKVovqd97xIyVk7PhX3hAIUY5pLS1?=
 =?us-ascii?Q?RJu5yymgwtcjwi8cCryNL5haJxD4JoMnZU6AR0R1GJA4l2o8wRutnsoWPoHg?=
 =?us-ascii?Q?9D13NS/6NohcuEzP03nLgEiXGU7u/1hirYS2c5GAt4cEG1CjnFzXmToI+8Eq?=
 =?us-ascii?Q?Cv53P0yFoV+fQZHTSCA7GtOeQTcsGCb/s8VjSMmGrfAhQ1OvOcsmOWi0mI/S?=
 =?us-ascii?Q?+Vq/r4Qo/24FSiYhXMN1Kb36kRuZZt4NIus4dEtLvb4tRLLLkLjOMW22n8W4?=
 =?us-ascii?Q?kG4l5fUjDxAqg832NAHmJpRbQjQBrWdpgxJosE9hUbT8SR+LdvMOnxo14U3F?=
 =?us-ascii?Q?jy25PAbUWvLKt9Nnz6XVzUlTndCthRMS+dFP6DSquRVqYBzrB2MiP1ZQDfVs?=
 =?us-ascii?Q?AKFOivQrlvZOurc3AgAxoPMnPOFSt/xEFgYOB8GXLECaal5tHtHSVrXpvHJx?=
 =?us-ascii?Q?wVUOxQajh9FsHjWjSMcm5Jd6a2BWQrGd4foyuYqkBUwQhbm8r6yJHH6EUF2R?=
 =?us-ascii?Q?6cc9eQAl4fixyIByl9Es4juK0QSo99xO2itEQzZHqgVuCRrbkM2hyyfjjRzY?=
 =?us-ascii?Q?B0QcXkr9SpneobnFy5JAV2QoBerKa5lBQy2gLLY7BfxE0LiKSPbvM4Vgcpkr?=
 =?us-ascii?Q?6BNTGwBQ2wAUxLHahdxe89YsRvxWARGgsiZ/wok99MQTFbEzorjsAjAAzUki?=
 =?us-ascii?Q?SGrT+VVgxEqSpg4F+bUorPcnRrbvi0+mZkxMN5qF/Gd5nMRuxpJp1wMzAwmH?=
 =?us-ascii?Q?pRf36dRcoAMZ/o94JQfOynKSN+aWKDFd55S4nVLowI2pG6TQMJkpOhEOVxwl?=
 =?us-ascii?Q?64BJBgAOhrmlfwyZojmKHHUXvJVawu0I6BhsZqm919gbUuNPXNZmwCCXuRU1?=
 =?us-ascii?Q?3W9Bnro6mn0HJmYGtYebLDxYVDhVqdZZcUS99m0MWMZPk+sJYadHy/Oeou/1?=
 =?us-ascii?Q?OOBDPV6/hgdY8YztYIUgrSYWkrsYqNIMBhzz6ZF5cn7Vbfg/0lCK/Zaa5Spo?=
 =?us-ascii?Q?/KPrZ9uPSD/XfwR+4QtgQlFOFIn3uUri+MW4biBmZf2tdDxvRHbh5HHG5QLQ?=
 =?us-ascii?Q?T9SzL05/hk4yR3HBWUqjk7RcHyjE2MJcZwViiKkEQ9AL7I8K6RMdy52KzTc5?=
 =?us-ascii?Q?FJYb9ImGCmsdPSTwR9GkTy9bkmdLbYoxj2rRkGe0Mebv3iveRHZ1Hcybj7Gs?=
 =?us-ascii?Q?QCZyf+8WbDw+561SvKt0fRJTWAIF2FWpdDCYWM9i7j0U4OYEAaYs7JplE3hb?=
 =?us-ascii?Q?bQTxGtnAn1+RQWGuaARd9EOBYyTzTqSonV7o+uGJ3ClFnbcivBCiWvMgqH4p?=
 =?us-ascii?Q?tGlN1TCqx2v/JRy0HR1DIGUzz6CInhAKqepx0VbLx8K10R2AM5hSja6IS+bl?=
 =?us-ascii?Q?Ug7+OTRlqeMVRt6hKhYUsi8S5bpMMs1YKw23w6YweVT2qPH4FAhGTsRQEkha?=
 =?us-ascii?Q?3Rap5Mrg9LL+TJVNXh4UZN0JTrkfCebq6ZyVuTcnQRDAP2Gl21yjosEK+AKz?=
 =?us-ascii?Q?7WL01LJKE5Ts2owOM896VfEgl/jZLKk7pU98NXjztSrtkzvvIGJ2YWUuGMnQ?=
 =?us-ascii?Q?hOrCLrpTt4FOU3sVypqymHJr70XwQoEb8eqv7lGg?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AAE613933BC87749B142F79D3043EA20@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8534.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6eb4628-4d44-422f-576b-08dbd24388b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2023 14:39:30.0799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyJtLqBpSr6y673lsrn6Y1m0a0xj5qCpbnzF72CqWVtozOUwCG3Dxl+4tNcV+w+XKZA1o+/mVxRGI4OE8PD45g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB9531
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 21, 2023, at 5:36 PM, Uros Bizjak <ubizjak@gmail.com> wrote:
>=20
> Some variables in pcpu_hot, currently current_task and top_of_stack
> are actually per-thread variables implemented as per-cpu variables
> and thus stable for the duration of the respective task

LGTM!

