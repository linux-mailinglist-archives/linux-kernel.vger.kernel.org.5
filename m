Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2027CB9BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjJQEbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQEbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:31:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EA583;
        Mon, 16 Oct 2023 21:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaO/LadS7E24q9ukygYDqkyabd/XVgeOxaJHoXfKUOlwlwQUojUoYfLBqmPQls5p7cFU3ouV6g2id0JBrne9Rylg1aC4yQoMxbmvyHoRl5Z6qBu12WdmQ6yGcZGgMFGEg8/EAcDVlfmKHG0PN3WmOXKZKxESjJFew6OuAZqh0Lgh7ivz61vTcK9azfQTEcHLc9kpLvwT/APXjYBPZPzoI0cUlHPx88DbGGU0iA/B7L5Pdg+bjUnNdw+ig3aOOTdOm5C4NKCrk8U3kioySDKtcOxA/YDFs4e3952c9c3T63n565uwASobyyhXn3vAWnV9OLtGmpoA5K8Tzko181940Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Voo3KgL9d4wWYh5P994GyBMYfTDyCHp6mefNBR5htAc=;
 b=S0fPCghVfhiteCxPB6PtsIfdITXhWVVqS8diNvsVgnQdajaxku8Ih959k7J45IlEoa5aXmi0sYmZbwxIEWcpAL2X5IsHsufyhifVg9BLCh0CU8HCsGfzgjHpLUe6Ua72mFYzOZAYaZ7S29Nwnr6FPo6kdHErkoONxNq/W9znNXTdu4UgUlvI4zN9bqIDE0o9dX71m2co4jJ7KwGCCetpUK2syqebeSYMXx7ylbmxgfbSB+rwafdmD2K1d0Rd/ZUpA8EvB1zpONjsVAh1ATzKEsx7U76HA9YUhA8QWSVjJ6rQ0BJSit0Vwv/fXwdTCGw/Lj9I8wYlcc9pCEkrGphJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Voo3KgL9d4wWYh5P994GyBMYfTDyCHp6mefNBR5htAc=;
 b=BNPJUMCaFVdhXBR1JnkG4SPqSbwXOhipv2wLH9yD/uNGH0FB9Q+nPUTz/FdaWHt7ADsi97VKfvV3MZ66j9eGoIC0h4E9qEar3aZ7wfG1RnmFNft/hIG5DFDZSTNPn+2Ah0oBUI2eBxRRBonz/j7gXo1wYfO1KpQmWAWLlA2Fx6o=
Received: from SN6PR12MB2702.namprd12.prod.outlook.com (2603:10b6:805:6c::16)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 04:31:10 +0000
Received: from SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::293a:d73e:e856:543a]) by SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::293a:d73e:e856:543a%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 04:31:10 +0000
From:   "Kaplan, David" <David.Kaplan@amd.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Thread-Topic: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Thread-Index: AQHZ/TSeSSFyryg+x0KeMifZktOt3rBM8AUAgAAFVACAAAUmAIAAarCQ
Date:   Tue, 17 Oct 2023 04:31:09 +0000
Message-ID: <SN6PR12MB270273A7D1AF5D59B920C94194D6A@SN6PR12MB2702.namprd12.prod.outlook.com>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231016211040.GA3789555@dev-arch.thelio-3990X>
 <20231016212944.GGZS2rSCbIsViqZBDe@fat_crate.local>
 <20231016214810.GA3942238@dev-arch.thelio-3990X>
In-Reply-To: <20231016214810.GA3942238@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=642cb561-c94b-4010-9117-c0f8dc15620d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-17T04:10:00Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR12MB2702:EE_|PH0PR12MB7077:EE_
x-ms-office365-filtering-correlation-id: af3f8327-30f9-4fc8-71ad-08dbcec9e338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQ9C9/OYboSP19dy4+jZ5DypH++JpXhYgX9SSO2eExArymu6OV+lb5Q/umNc3x7v4g8iXDh9rXDJZhS3SYc6gA7zcTQL/thlP7YzB5jBMHGuLH+oqfgzQpYy1dkpt9mMOVN7ScUiZPo9V8auD8oLsaxMltS0p57R3v2SAYZ0ZxavqBzUjtQUWHl16KazxxzLT74d5c/KCgfUjhFVRVCMOX7hE9N8CqAOGEMYlM2NGXrpyAgTRiKTnSMon2z7Ja4MzR37St/T0fLExe5CpLMP3gjb2NdiGoh8oa1UdEY7IoO7MNJZePrhOiRdbM5ha2Zy3wukM02OZ1RrZR1wctryt04E2XqYT3P6HUp8L+vkqrLky2JiftA+4NTp6GA54Ah3y1oH7Q0Md81W5GHQ5zO76WFvfEu3XzK1PQOsOb8LixB4hOBsgCaPwtkD8d1KO2yEN7nbn3BugXdAhWpWX15UpCD3P5ryOTR/FaCw+RKBIz7FMVdkrg78ZkNhTjZgPiWdmTXuNVhyZWSpselDOSRdmhGhTJCo3pHqIcH+8go1T5vqANo744et6NtOsXPqoh53OQ0Z6mwGP9Mf4TJa6wqZL9a7iJwq9AtPb6v1H0Pp1ZsmS8VZc10sWsBP+V5rcXSv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2702.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(55016003)(110136005)(76116006)(316002)(66946007)(64756008)(54906003)(66556008)(66446008)(38070700005)(53546011)(9686003)(26005)(83380400001)(38100700002)(122000001)(86362001)(33656002)(478600001)(6506007)(7696005)(66476007)(71200400001)(41300700001)(5660300002)(52536014)(2906002)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SoE/Gp/c0RxJjbeFcjpz3eGQlHumTc2e3Zo2gUFVedpuUxpK8go2KfnerXzY?=
 =?us-ascii?Q?fyyL5kMwuvJR0d3QNh2vzLAUlVajfYiKYZW1w+b5nvnMp9qvhptKFtlqd3mD?=
 =?us-ascii?Q?cRN5WS4Q8LRs2d3h7HKWTi6nACasW7ipwWIzrnuZNKxrIajzkJPKQ06IurwY?=
 =?us-ascii?Q?qZJRt2EL2rsyKfJXz5pJBJ5M7ztxEGe99nel6gDpaOk3SCzhuczPjsh1LTY6?=
 =?us-ascii?Q?9lkaxh0S6x9hgMtiCodCb7+rQDC4SFesYKIU70Kcynv2/OVHTxGkK5yOI3sQ?=
 =?us-ascii?Q?dBXsIcRXDr0sii/RGa7qcaiKOjdC3keTa4HfAn3QBBztVigIlxo8hwqRwlqM?=
 =?us-ascii?Q?qTVIiT5ynO1aYnI5HgllM3SwtHLiobe0P/eLNyBpLRDqlHelMltADrP52YeA?=
 =?us-ascii?Q?DrQA3hRc64gid4fapVU6WZEQvc/Q7P1DyXMfh/kpbap33ATYYaxb+htVE87a?=
 =?us-ascii?Q?0JyxOTiLtDai2V0eB/YixZI1tW91Y4gdPNxOqczjHDDoDXKJ4lPRIwbdw0a+?=
 =?us-ascii?Q?2qFeH9ieqUs3MpkDdzhh0Yrv2XB3gmu5If9AefS8NssGDRffJnACsxfP8iz2?=
 =?us-ascii?Q?wh7tPvGJhgB2hxgYa4VNTVReB2xBiqwtyAklbXYOuX1f6LatOHlT91OPYRLh?=
 =?us-ascii?Q?xrTR33dfRAu9qBnxUNeFOHvN2qiNAgQPu617ef5XzCyFUpp/dpgrIWIjl13U?=
 =?us-ascii?Q?/4/eE2PtdUj4V1uv/WTh0U0x3E2VEc0+mMogUNF1RRdDG3KQ0wOSgyh4u5xv?=
 =?us-ascii?Q?a0nsz8oBSnKsKsAUk79+O7juQgF+vrA9VtufovJ7KcmhCQHMUeEYyB08T3Fs?=
 =?us-ascii?Q?C/bic0BRdGYoD8EB5fkuBPF3nIRMn7xhHLbg6sAwrot9OiClT7KfeL3d6Mwb?=
 =?us-ascii?Q?m1CGzP/azZpqt2k5xKl3MR8p+CGp8nIcaCWm7LXrkwDgwIvw7Kh9lC9i7ktW?=
 =?us-ascii?Q?Wbvy6fOZCN0+HJOHsAlJwxSHaDZ6GlwAOZfwxvfr4rkYeGZ0L/hPKAjjhYHD?=
 =?us-ascii?Q?3zJ52b6AbsaYydWaS8CVSDNvhGiJi56ivp4oeWvy8C2Lg0iW9URnm13sD4+z?=
 =?us-ascii?Q?euIXS6cziAEx/hd5QeU6JVGam6TfbrR27SBaXmelGOo9wdDb7BYOticFHQhF?=
 =?us-ascii?Q?/s0fBi1PQy+n9YpyGcP2DqNSFFbh0ewccsdDvVfMg0ces+K43+dEtCkr5P+N?=
 =?us-ascii?Q?BXvl/ZVGH3zItQVW7NhYaoylBAUDCNn/+B+FezlnELCvPSWGytrIJvkXaEfo?=
 =?us-ascii?Q?ey7YwkAaxDRdrccQkAG3qwYazAtoIe1V1Cy7HiKXiV5LHx7ij2ZW88ITjvEp?=
 =?us-ascii?Q?o+llHtb9+vhr5MEEaa/cfd6NJg8tNjCqFt1EyalZTF699fVabz1UlS92oP9O?=
 =?us-ascii?Q?kNDfBlh3Fcrxtp52lCULTfMzsDOfKjkyxU5vsAT/lUY8MDQR0X5BvVFOlabv?=
 =?us-ascii?Q?8NgFE6aLG+Zqf0qg5hTF99Od3E+jPZcxRUlJ/kbJnrhWLhSYRBaYz99QX0bS?=
 =?us-ascii?Q?miK7aMLHjuZtylIn6KAQYoiey1jjavtYtrAt6gYuiEkxpMuYaJ29IpXFFXwr?=
 =?us-ascii?Q?E7sCTQbQgoTrXK/aAFs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2702.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3f8327-30f9-4fc8-71ad-08dbcec9e338
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 04:31:09.8696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wS659gqPH68zpGzvz2pqnCQVs+HTuBfscTKjmowpwqKdvFXwR74N6hZsgANlkBwY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: Monday, October 16, 2023 4:48 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: linux-kernel@vger.kernel.org; linux-tip-commits@vger.kernel.org;
> Kaplan, David <David.Kaplan@amd.com>; Ingo Molnar <mingo@kernel.org>;
> Josh Poimboeuf <jpoimboe@kernel.org>; Peter Zijlstra (Intel)
> <peterz@infradead.org>; x86@kernel.org; llvm@lists.linux.dev
> Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk i=
sn't
> used at runtime
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>
>
> On Mon, Oct 16, 2023 at 11:29:44PM +0200, Borislav Petkov wrote:
> > On Mon, Oct 16, 2023 at 02:10:40PM -0700, Nathan Chancellor wrote:
> > > I just bisected a boot failure that our continuous integration sees
> > > [1] with x86_64_defconfig + CONFIG_KCSAN=3Dy to this change in
> > > -tip/-next. It does not appear to be clang specific, as I can
> > > reproduce it with GCC
> > > 13.2.0 from kernel.org [2] (the rootfs is available at [3], if it is
> > > necessary for reproducing).
> > >
> > > $ make -skj"$(nproc)" ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-
> > > defconfig $ scripts/config -e KCSAN $ make -skj"$(nproc)"
> > > ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux- olddefconfig bzImage $
> > > qemu-system-x86_64 \
> > >     -display none \
> > >     -nodefaults \
> > >     -d unimp,guest_errors \
> > >     -append 'console=3DttyS0 earlycon=3Duart8250,io,0x3f8' \
> > >     -kernel arch/x86/boot/bzImage \
> > >     -initrd x86_64-rootfs.cpio \
> > >     -cpu host \
> >

I think I found the problem, although I'm not sure the best way to fix it.

When KCSAN is enabled, GCC generates lots of constructor functions named _s=
ub_I_00099_0 which call __tsan_init and then return.  The returns in these =
are generally annotated normally by objtool and fixed up at runtime.  But o=
bjtool runs on vmlinux.o and vmlinux.o does not include a couple of object =
files that are in vmlinux, like init/version-timestamp.o and .vmlinux.expor=
t.o, both of which contain _sub_I_00099_0 functions.  As a result, the retu=
rns in these functions are not annotated, and the panic occurs when we call=
 one of them in do_ctors and it uses the default return thunk.

This difference can be seen by counting the number of these functions in th=
e object files:
$ objdump -d vmlinux.o|grep -c "<_sub_I_00099_0>:"
2601
$ objdump -d vmlinux|grep -c "<_sub_I_00099_0>:"
2603

If these functions are only run during kernel boot, there is no speculation=
 concern.  My first thought is that these two object files perhaps should b=
e built without -mfunction-return=3Dthunk-extern.  The use of that flag req=
uires objtool to have the intended behavior and objtool isn't seeing these =
files.

Perhaps another option would be to not compile these two files with KCSAN, =
as they are already excluded from KASAN and GCOV it looks like.

--David Kaplan
