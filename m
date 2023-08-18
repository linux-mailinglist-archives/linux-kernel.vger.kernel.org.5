Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C775B780F99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378236AbjHRPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378375AbjHRPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:51:17 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE01E48
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbwReY/QpcdfSZVnOG5P/k58a0uirq0z8jYNjolnvR0=;
 b=PpYstI5kGsDRBOYympxo0tmUgov7qOVgOFFoMVMpGAUm226uYiT1FTniRhocybrrwVGfB15oqC2pXQ3Cvwfxo7LVoL5yl31tS+ZPKngvt+AjKSfsH8EGdDpohxyPapPZEPdwV/KZqGwHFn0X1j1AH1PIqqBjJ1NKSATXdoAdHbw=
Received: from AS8P189CA0045.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:458::14)
 by AS8PR08MB9314.eurprd08.prod.outlook.com (2603:10a6:20b:5a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Fri, 18 Aug
 2023 15:51:08 +0000
Received: from AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:458:cafe::c3) by AS8P189CA0045.outlook.office365.com
 (2603:10a6:20b:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Fri, 18 Aug 2023 15:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT036.mail.protection.outlook.com (100.127.140.93) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.11 via Frontend Transport; Fri, 18 Aug 2023 15:51:08 +0000
Received: ("Tessian outbound c99fbc01d472:v175"); Fri, 18 Aug 2023 15:51:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 96885b0133f4c401
X-CR-MTA-TID: 64aa7808
Received: from 1f33c8f6b5fb.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 33777299-26D6-4836-B937-E4BAC3E3767D.1;
        Fri, 18 Aug 2023 15:51:01 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1f33c8f6b5fb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Aug 2023 15:51:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVUiYTITEqXkPsTd7jBqUKBLwUEqenn21UQnHjsrE5jjTrl9QtQ9L4eZveF7akIJeEP1KElbzXDwVK7KMy5yZZ1HRHCaAinPqBP11D432C/+BvhU2mzkpYvU5Gi+MEmkBMAhyM9fxRinCRrqDw1or6uliiBi3PZacczikxIxbKO09UhtLzb1Un0qXePjFvoTsBbq3e41iTAT8cc3tW8h5ifM6q0KCjxgVfQnmB7Kgnitk6JIZAEyCET4iO9lsJhnLP7LQ3mCCtoOl14pSYSWcb/N+TWpHI+XkOYfqn0PZixuKpWFD6VsRFg2HGQoN/MJR7oqFqBFt9L5wiLLF45nJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbwReY/QpcdfSZVnOG5P/k58a0uirq0z8jYNjolnvR0=;
 b=UH03c28112B7LuipNudQRjCv2bmtzQy7cH4veeeHDSkZHZGikJBxcubagAWHXTQ2d/fEmj41DRxKe4lWQgS+MR68wr6sEq/pdwPFAIiihb6+l37wQ9dXppUGS8KFmoH5ggTmFcVFauN0UjEc5lbbukegVHcEUq3qMuvPRBd4fi3n2RJP6P8mwYKVqGTbb7P9g4zGtOdV7NMzWUA/tsZv/xupFc6JCfiW6UIaX2m/KvE2GS358JdCJGAUR5kxfcDRpcmyR1hTxiuX2Ukehr79qxMrLUSi81zVE+VdEN7xYfxHNFncKLsbpEjcTYv7fALyJ8BGf7hKy5cxhLPlWWjs9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbwReY/QpcdfSZVnOG5P/k58a0uirq0z8jYNjolnvR0=;
 b=PpYstI5kGsDRBOYympxo0tmUgov7qOVgOFFoMVMpGAUm226uYiT1FTniRhocybrrwVGfB15oqC2pXQ3Cvwfxo7LVoL5yl31tS+ZPKngvt+AjKSfsH8EGdDpohxyPapPZEPdwV/KZqGwHFn0X1j1AH1PIqqBjJ1NKSATXdoAdHbw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS2PR08MB10055.eurprd08.prod.outlook.com
 (2603:10a6:20b:645::18) by DU0PR08MB9904.eurprd08.prod.outlook.com
 (2603:10a6:10:474::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 15:50:59 +0000
Received: from AS2PR08MB10055.eurprd08.prod.outlook.com
 ([fe80::a206:ca48:ede0:ebb4]) by AS2PR08MB10055.eurprd08.prod.outlook.com
 ([fe80::a206:ca48:ede0:ebb4%5]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 15:50:59 +0000
Message-ID: <86bced4f-06c1-73de-9aa5-bb23998479fc@arm.com>
Date:   Fri, 18 Aug 2023 16:50:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Initial testing of MPAM patches
Content-Language: en-GB
To:     Carl Worth <carl@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org
Cc:     "D. Scott Phillips" <scott@os.amperecomputing.com>,
        Darren Hart <darren@os.amperecomputing.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        Akanksha Jain <Akanksha.Jain2@arm.com>
References: <87lee8l9pb.fsf@rasp.mail-host-address-is-not-set>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <87lee8l9pb.fsf@rasp.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0438.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::18) To AS2PR08MB10055.eurprd08.prod.outlook.com
 (2603:10a6:20b:645::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS2PR08MB10055:EE_|DU0PR08MB9904:EE_|AM7EUR03FT036:EE_|AS8PR08MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d32e47e-0925-4c1b-035c-08dba002f036
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: DVgtoK1hDS5g3sM/lyl+ww9uASdnM8hSa5C0AI12Ai2gkwdwXi8r+i4dv4UPlECUMr9YquQv/luUvqC0jG2hh1+X8IcinHa5cSfl7jpvzkgQICzaHZ9DaJtbd7j5N78ZG9YFYQWuAeGMqYpgh8whUKVCjeBmyEZQMwY8W3X0W0r4+zVjbIuFUqfbc1ouzyMSnHO2HrRbd9nB2EM2OubxmGKlKUj9txBqzgbng0wrFKm1/kfgWlXzUEpxRYeidaEvmaResxSRdL47sBmQblHrb2gzzjy4uDAwy+cyr5+9ksjZZ6GifwKt3cJX17hb6kbMUX/fQSkETfOGfX0GoaAqaFChf5H/c1LivjR4Pijgggoz6ZsySGnbyJRAXyaG4/V29KNrbT+2u+3E1ibHKjE/sVhaLuCWDMiobd34mmFEYHogrb6TFNwSWtMvm9aXLRwCxyfiHrlplawkSSjXR0aoZe1npB6GUSXYdHd6pC3L4FCDrUJmNzcRC3WNMZgCcJ6dPOBq9h9qMN0HWGyEPSE/j4dQxHaJmPGrLnNAaz68DipQX7IuzIx3UPbxtilJ0B6cwcGkpnQmjVDtA9W+vG7H4hbOYKb5NZNotTZk6B8E4GI9uelfw29mhcVxTNAJ9DDaJrUGlg76G26BuPEX18iqjw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB10055.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199024)(1800799009)(186009)(31686004)(86362001)(31696002)(36756003)(38100700002)(2616005)(5660300002)(44832011)(66556008)(478600001)(6506007)(66946007)(66476007)(53546011)(6666004)(6486002)(54906003)(316002)(26005)(6512007)(4326008)(8676002)(8936002)(41300700001)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9904
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e125908b-23d0-40ec-a08c-08dba002ea38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0RPveibFXVas87YT2Ro3/Js1hVtF+qMGNuVS74mhFP1MV99b5KpanAcQtz1dvdsBJ3+7o0H69UsujWSGAec75asSz9xOygWb4JoPdqw2mxi126fSc0xwFMUdVv65+24PFZFbWaK/4VcSqZCTir/92PEi+t2oWSZYgxmwkJQGDk+zOzI8yuXWSa5F/YGNr6SI7TLbuL/4KDo6LiIZz0pNQrmXdMSpQb/KrQxiICuIizQOTs+/qqG8IQf/NXu32cokNz3d7feDEcamPMgthP2Oa3Tgz1Qc9zXlP/SVwjgZk3oQ2Cx0zJWfW2e8Cy/DdybmFWsOldFB6e7Fn5j1jYlwPpeH/vbDFPOkHpE0MZ2hS5QFsRyO0oZb/6Dg3WugFQ/QsqQG7m9/hDcHbPop2gVRigEL5OtBstsX8gNXU0MW2rfVDvk1kTdDJYxuIZmScbgzlaH0UN/6lIP95jAyN9/XmLXC3K1litVETrKe5mEzj8M49CUShOrke0KF4cJT1yUeEboyls6CIHjRv5CoaCVSjTk6JvZ1geFHsQuMkzaPl8H5aFOMmr82+gfEo1o6EVBv1HuNyCfCf0Zr4fCDn/Tw6Ft501SiG8m0mtw6GOVDokokWG5KeM8Rg7rRBNUjeUA62RbSzlTNdruYt8tQ9KS87ZZeK9hCLut24drJrFQYvremhM0hH1d5sG6dMp42hvtOQ1jHd33WYzQPZHhhyXjeztp1MJszfdTP34zAqCy4Mmnlf7mHeAocuA1acpQxA/ZSyuljwKf0GTA1a8TrlNN4w==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39850400004)(346002)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(8936002)(8676002)(4326008)(86362001)(31696002)(44832011)(5660300002)(40460700003)(36756003)(2906002)(40480700001)(26005)(2616005)(81166007)(83380400001)(336012)(6666004)(6486002)(6506007)(478600001)(356005)(36860700001)(53546011)(82740400003)(316002)(70586007)(54906003)(70206006)(47076005)(41300700001)(31686004)(6512007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 15:51:08.2726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d32e47e-0925-4c1b-035c-08dba002f036
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9314
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carl,

(CC: +Akanksha)

On 18/08/2023 15:13, Carl Worth wrote:
> I'm just getting the chance to start testing your MPAM patches on an
> Ampere implementation. Specifically, I was working with your
> mpam/snapshot/v6.3 branch [1], an earlier version of which you posted to
> the list [2].
>
> I have a few initial comments/questions. These are mostly from a
> black-box point of view, (without yet having looked at the code
> much). Later on, when I do dig into the code, I can follow up on some
> of these issues within the context of the relevant patches.


> 1. Is there a way to query the MPAM PARTID for a particular resctrl group=
?

Deliberately: no.

This is private to the kernel, the way these get allocated may change in th=
e future, so
user-space must not depend on it.

AMD want to add debug hooks for this - in a way that can't work properly on=
 MPAM as there
is no value that directly corresponds with RMID.


>    I see a file named "id" in the directory for each resource group,
>    but I get "Operation not supported" if I try to cat it.

Try mounting with '-o this_is_not_abi".
That file is for passing an identifier from resctrl to resctrl_pmu so that =
the kernel can
query the control-group properties internally.


>    Meanwhile,
>    in the code it looks like PARTIDs are being XORed with some random
>    number. Is there a deliberate attempt to obscure the PARTID?

It is. Otherwise some joker will hard-code their user-space script, instead=
 of reading the
id from resctrl - and scream regression if any of the kernel internals that=
 allocate a
partid change.

If you 'know' the default control group has all zeros for its 'id', you can=
 use that to
xor out the set - but you are on your own!


The general theme here is I don't trust user-space not to depend on any val=
ue exposed.


>    I don't know how much an end user will care about PARTID values,
>    (so it's nice that the driver manages these implicitly), but for
>    me, while debugging this stuff, it would be nice to be able to
>    query them.

This would only matter if you could somehow inspect the hardware - which yo=
u probably can.
- but users of deployed systems can't.

Sorry if this isn't the answer you want, but I'm trying to only publish pat=
ches to
kernel.org that I intend to upstream in some form.
There are a few one-offs if some debug needs something complicated, but I d=
on't carry them
around as the tree is big enough as it is. Rebasing feedback for the series=
 on the list is
painful enough already!

You can probably just hack out the safety-nets around the 'id' file and use=
 that for your
platform bringup.


> 2. Top-level resctrl resource group is not being made to take effect
>
>    When I poke at the schemata of the top-level resource group, I can
>    see that it is associated with PARTID 1.

That was a transient attempt to allow interrupts to switch to a reserved PA=
RTIDs to avoid
inheritance. The folk who wanted that behaviour said it doesn't solve their=
 problem, so
I've dropped it in later versions.


>   That is, if I do something like:
>
>       echo L3:1=3Dface > /sys/fs/resctrl/schemata
>
>    I can see the value 0xface showing up in the cache portion bitmap
>    registers associated with PARTID 1. So far, so good.
>
>    But meanwhile, I am not seeing the MPAM0_EL1 system register being
>    modified to associate the various cores in this resource group with
>    PARTID 1.

This should have already been done by the call to mpam_resctrl_move_all_use=
rs_tasks().


>    In contrast, for any lower-level resource group I create, I do see
>    MPAM0_EL1 being set with PARTID values for the cores that I put
>    into the 'cpus' node.
>
>    So it appears that PARTID 1 and its top-level resource group will
>    have no effect currently. Am I seeing that correctly?

This sounds like a bug in the patches that shift the 'default' resctrl grou=
p. They only
appeared in one version of the tree, its probably best to just rebase, or r=
evert them.

That code may come back if the behaviour of hardware the mpam driver doesn'=
t know how to
program is severely affected by resctrl messing with the configuration of P=
ARTID-0. The
scary case is slow delivery of LPIs because the GIC ITS is being throttled.

My current view is that platforms are likely to be short of PARTID as some =
folk are also
using them for monitorring, so reserving a PARTID


> 3. Is there special treatment of cpu 0?
>
>    When I put cpu 0 into a resource group I see both MPAM2_EL2 as well
>    as MPAM0_EL1 for cpu 0 being set to the group's corresponding
>    PARTID. But when I set any cpu other than 0, only MPAM0_EL1 is
>    being set for that cpu. Is this the desired behavior?

That sounds strange.

The versions of mpam_thread_switch() you have always touches MPAM1_EL1 and =
MPAM0_EL1,
always together.

How are you identifying its MPAM2_EL2 that is touched? The switch_to() code=
 only uses
MPAM1_EL1, these have different encodings but access the same register if H=
CR_EL2.E2H is
set. If it really is the MPAM2_EL2 encoding, that suggests the KVM code is =
being run.

>    I know that PARTID 0 is treated as reserved by the code, but is cpu
>    0 given any special treatment?

No - can you reproduce this on the latest branch?


> 4. The current schemata allows for cache portion, but not cache capacity

See KNOWN_ISSUES:
| Only features that match what resctrl already supports are supported.
| This is very deliberate.


>    The schemata file allows me to specify a bitmask to control
>    cache-portion partitioning. But I don't see any mechanism (nor
>    backing code) to control cache capacity partitioning.
>
>    Is this due to a limitation in mapping MPAM to the current resctrl
>    interface?

It is. Getting feature parity with x86 is the critical path to getting this=
 upstream.
Supporting other bits of MPAM can come next - we'd need a discussion with I=
ntel about how
any changes should be done, so that they can support them too if they ever =
have similar
features.

This conversation can't happen until we have some support upstream.


>    Or would it be easy to extend the schemata to include a
>    cache capacity field as well?

Probably - it just needs doing in a way that stands a chance of being porta=
ble to other
architectures.


>    I see that Amit has proposed patches recentl for extending the
>    schemata to add priority partitioning control. So I'd like to do
>    something similar for capacity partitioning control as well.

Beware this may be premature, as you can't assume mainline will merge the s=
ame
user-visible interface. Having out of tree users won't be a compelling argu=
ment.

To quote KNOWN_ISSUES:
| Until this code is merged by mainline, we should rigidly stick to the use=
r-space
| interface as it is supported by Intel RDT. This is the only way to ensure
| user-space code remains portable.
|
| Once the code is merged, adding support for the missing pieces, and how
| this impacts user-space can be discussed.


I haven't got to Amit's patches yet, but I plan to pick things like this in=
to the tree on
kernel.org so its all in one place.


Different ways of configuring an existing resource should be low risk, as w=
here the
domain-id's come from should be the same as the existing schema.


> 5. Linked-list corruption with missing cache entries in PPTT
>
>    At one point, I tried booting with the MPAM ACPI table populated
>    for my L3 cache, but without the necessary entries in the PPTT ACPI
>    table. The driver fell over with linked-list corruption, halting
>    Linux boot. I'll follow up this report with more details.

This kind of thing won't have seen much testing. Any details you can share =
would help!


> 6. No support for memory-side caches
>
>    MPAM allows for controlling memory-side caches, and the ACPI
>    specification allows them to be described. But the current code
>    appears to ignore any such caches, and won't expose them via
>    resctrl. I'm very interested to know what work would need to be
>    done to allow a memory-side cache to be supported.

This is another case of waiting for the code to be upstream so we can have =
a discussion
about new schema with other architectures.

I'd argue these should use some identifier that is visible elsewhere in sys=
fs as the
domain-id. This needs discussing with Intel/AMD as the way they would build=
 a similar
feature may have a bearing on the user-space interface.


> 7. Cache portion configuration for incorrect PARTID is applied
>
>    I've seen a case where, when trying to use a PARTID other than 1,
>    (that is, a resource group other than the top-level), the
>    configuration I've set in that resource group does not take
>    effect. Instead, the configuration for PARTID 1 takes effect.
>
>    Querying the controlling MPAM registers does not obviously explain
>    the buggy behavior. Things look correct. I'll be examining this
>    case more closely to see what's happening.

I'd be curious what the monitors report when the control group with PARTID =
1 is empty -
that should give you a hint if they are seeing traffic with the wrong label=
, or something
else is going awry.

There are some one-off cranky debug patches on my latest tree that may help=
 debug this. If
you end up using them I can share the log of what I get as the expected beh=
aviour on the
FVP/FPGA.


> So, that's what I've encountered on an initial look. I didn't call out
> all the things that are obviously working well, but there's a lot
> there. So that hasn't gone unnoticed.
>
> Thanks again for this series, and I'm looking forward to engaging on
> it more going forward.



Thanks,

James
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
