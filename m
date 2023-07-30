Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA57D7683BA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 06:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjG3E4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 00:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3E4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 00:56:31 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666B5210B;
        Sat, 29 Jul 2023 21:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690692990; x=1722228990;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jC0GHuF66xJu43Chnp4x2J44xFuJHg64HpspIxSfRn8=;
  b=SkBAJtiU58k+mXkGt/PVjtIY3vB8Tjo5q2JRbyaQ5p+tX1+nvtbY52mG
   PZtS5QwZMUY9dWQ6YsdDuyhx8Nhegm6kjcYBvTuuFwn6fBfspK3Aid83o
   8sPzofFHWCJRJ0QgexUD4hwPTf8kDgISsPRNVV53a0dMlY0WATxBVEnTb
   GSrIv9iwoS5hj5TZy7lHN/1ogDfWG9BA3TvV4sR7WHklasEa3X5bzI7NZ
   IPZ3MTKCUPLblLBvGaTPVXK7iMYuL8yh6BA3qF1dbQDf6mDHVL2ifIxjr
   HThnF09X5NRVUbmWDsl6aWuUjn2zAGrQgMCxHum+J/xPjbE5sYZhTLwGv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="368822764"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="368822764"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 21:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="677935244"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="677935244"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 29 Jul 2023 21:56:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 21:56:28 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 21:56:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 29 Jul 2023 21:56:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 29 Jul 2023 21:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehEFxEIkXvomidvk0m6+hnY9S7oQipZp+IS4IVR4ptLKJxCnJGLrPAdK1fY+w77co9DIQj4obJFyqExT7I1atn5EtL0xdIEzmjdmEz+TAn9hR2d1XMBMCjrO6r1S/BOb7XrYEgvxKGwUz+2ysP2c20Bl5uf22Bd9lRIu+F/GVq2B9sLC4CPA2suglOQywynB793Y3X3yqs8pkdy3+AhARSb4CI5vTJ+BjSRRdl6sXyhX3NPZtGXRPcwwzv+Qk8SzVBa6KEtFyvZ9NkoysT4CS/uX6iC+aNkN2cv8GmzEQWwUkMW7SYxdEOoA1m7EM0jG41lyIsimiyk7cKuvTB9JXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys2dSSxmA/WuWW3ztYgZ3GpULvSJGaCXAtnAAMNY4vc=;
 b=BtcV+TWjoebxlQzUJ8YN32eWB9eH9fktjfwsBCIJap9OHey8Xt3xV8p0r4Va0VFm4aykB9TXD3gDNlznesgLCj3az46Wf2ayCSJLmHKZLR8/a4TDSQlYxLZagXV2qSwGnKwTNk2yKKltzLphY0Pb6yT+tlAOATznUV0/XT2++emW5u2ldN3zHKGpe/YUWxJvQk8OhQI5uxhl4AdQ0FSVdBFjDPmGqTgDAWfFf8PHQZKykvjjtgXWu11aH4+aMDmb8jmmaFlB4Va3fUqfEYp4/j4eunf05rbKzX/g4cOnY4wfhSihiPHTpkOAmYOqOcMp/v76BE8k9iAYxxGzTN9toQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6845.namprd11.prod.outlook.com (2603:10b6:806:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sun, 30 Jul
 2023 04:56:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.026; Sun, 30 Jul 2023
 04:56:18 +0000
Date:   Sat, 29 Jul 2023 21:56:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dan Williams <dan.j.williams@intel.com>, <dhowells@redhat.com>
CC:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Dionna Amalie Glaze" <dionnaglaze@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
X-ClientProxiedBy: MW3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:303:2b::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: aac0bb22-bd1d-4a35-f04a-08db90b94f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGfCRUEx7JKrtGxK9zBEyZ1zNyEqGCuH2wHGwC0YUN7z2D9mIszvHk/+9qxlxOGDhstXmh9rfrSkZzdaw0ilrnXJh0Hcro3N83PC4SvP3iG5cWmMBkG8BQUCUrztfl9LRJF3jn9JBgM+m+wsm37mj8ZGtKxjP7Pls1nOStQExCGYD0gvMncVIJ7LHnQJz/RCn0B9B+86tupRyEh8/4EMSVLmiFgug9bkL7s/oDinJiJ/MsVO1oXxEf+ZgW9BWmGbTS5ifCo60k1VgOBrQo2ckjh/f4SjVLt08X7obe3KktZURXPzqlko27pF/sWirxzI8u6PPauQJ2JvaWVFrI9Ro46KddrQO0A9YAvDcNFo6bmlRMulpykRrNlkgxfd8z74At2TDy/UqcugIExJ2sqUBwRyNytSKsCpDFGjaK2IvRrZRbZOz3Jnvxy4EySFhbTe+yuO/nG/oXIw6BcgLF6FrsLlRqS8yAN9G2uQ8udFrEABvhlLatqvZvilGP8XLe6Spk94k7KVOVH/Ex1jE0GzXdPCD721vDHaVChSgsfyA5QlcLKkfKTLCeBcyZco9OPi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(8676002)(8936002)(26005)(110136005)(54906003)(41300700001)(82960400001)(316002)(4326008)(6512007)(9686003)(5660300002)(186003)(6506007)(6666004)(66556008)(66946007)(478600001)(6486002)(66476007)(7416002)(86362001)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6dp3sRSKLuoC14WPR1hUbpS+pqqRntuuBm6/b/iarUCFCoEWmPGqI18kASG5?=
 =?us-ascii?Q?N8B8HC0GfUR1GMkrF+FxeC5ixzNFoYCtFu0yjbbu7ykfDM2XnOSqionf9Xeo?=
 =?us-ascii?Q?VMp9n+I6fKmy4MrCnDOUwNA1j1CkgVTZmbBoiOLxbJac+ZUOmBbKGYLn6GTI?=
 =?us-ascii?Q?BFVFvMOnNUnIRqIl+vmRSp+6ihuNTq9SgpaTV4fXip62quBmnhU0WYW+yIzW?=
 =?us-ascii?Q?afWWQvkO0MHP5/vysSMqLqRcIbRycpifAKvyUu/PwTUmjIDpYrgCIEbAvlVx?=
 =?us-ascii?Q?PZe1z2rnRhp165uOyUogxbd7lJjzsXhkyrQ9UiwY8u1sGNELk/j7VjoWjRtp?=
 =?us-ascii?Q?VAqBypPiXRXVArMdhCU0zQRTFWMD19qWW//ZkyiMp0E7FkafO19/gc8rJIuX?=
 =?us-ascii?Q?M2srBkoYw9kkPJwMa/ICGdU7ZNOmCbf4aw7NBDjSWqJnAJxvqNRoQxm090QV?=
 =?us-ascii?Q?zlWzBJ4VAk373paN4y4xsJs93JdioYSCKKkv0HCzy9EN+LoqyIIEuvMONuYp?=
 =?us-ascii?Q?HstwNOxMJkuyuJCkTFtguIn5QqNbes/OpZTW42Li1MBRAXld3RR7gRKBh7ed?=
 =?us-ascii?Q?O7o2JVFu5Jd438EY/AGkKFOsrBIG0WYUYTRpf/dSpPZsGRcwcAc60z7x7T1Z?=
 =?us-ascii?Q?zlP6IWVRMBCEJFPg8rhBsKKRwoqm7rs/dopt2Y3Lobns06jxw0KEKrgHaW+o?=
 =?us-ascii?Q?vBJAP/JjR6v+WtcMNiIMGrzgLnRwD6BVkhU24WgyA5OG9rU8CPGuvlHrrGfk?=
 =?us-ascii?Q?gCmynYeYpWkcDoH19zHR7sf94OInS6V4aBSEBqzQ4EswNxy8Ft22kHkmFd2J?=
 =?us-ascii?Q?HKiwwt9AMpz4KCkbVz61JgTZ/D6zLPJG7lUqtcWqWpqAUVOowIba27abHmn9?=
 =?us-ascii?Q?miEO0zFA3PW/UAvXojQpEtqUUoD6JWwoSnriXKf2dbjwbAEVFdiAxpwQiZ0D?=
 =?us-ascii?Q?BYTZGP8+uakWSbWU8mRe3JfPTRjNMQ+NyhrME+99ART41Ez6yvlIf33NHAwv?=
 =?us-ascii?Q?3C8nqpWETSYsSvcUaMQzxNxCcc/d94g22lH8Szq5HFHsnPzCtoD7ZD10aB0n?=
 =?us-ascii?Q?BDPkyk3mZShnXF0bQgGqZzmVd83aDI+iBvYXrFw4XPmA7kEGBzBWD+6cyeYo?=
 =?us-ascii?Q?lBeWMFuV1LETb0h/v4BNUZg7+OrF9+SwXU/tZZnyObIuCPfHoNZpggj+Ane8?=
 =?us-ascii?Q?YjFwO0ehZ75bKk5gfByVBw99+obBcYlalC9UOvH4sTwC10vPnb5vrivsbWyU?=
 =?us-ascii?Q?ny/SG3q1WhRPBMqKxjQw9Hbji2KeEM2UKGy7xWTWaabEa5u8Z+c8zAuAnhiw?=
 =?us-ascii?Q?hWcMyEqz9HHfZaFdHyAC0xrAm/YJHaGo6JVpMMyCJ3GDTenXEdZccBC0q1lk?=
 =?us-ascii?Q?BCFUbfqKW+lBPsyF+8Yp9cjOQpwBKWpj0nlNtpUguxhJWQkPO3OvABycdBoJ?=
 =?us-ascii?Q?ULd2fE3FaPqyGAxCPRBr/8wwYZHm9h7dm/HL1DyYn/NXal4E14SDfV4t90hu?=
 =?us-ascii?Q?HTXU/UwaBB3vzu4nnVQpMvyONvvKWJVHMN2pM9yKJnA+tokIEJDmQDXkprpq?=
 =?us-ascii?Q?UfcVy4YSYVwzur9iBtwKKTXfCd62tkKJ6eYnTOnaC+MmcNKnn7fETD1yvXGu?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aac0bb22-bd1d-4a35-f04a-08db90b94f68
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2023 04:56:18.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWrx2Ra5PoWPM5ZzOOM1vlSy/qnOflfMlV9XDHyoGFN/J1oxMAg1SYlyk4iw4r+0MbSQ1y3ZE8xusNm5zlt4jVgeYDjITho/MODy0LnK0kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6845
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Fri, 2023-07-28 at 12:30 -0700, Dan Williams wrote:
> > The bulk of the justification for this patch kit is in "[PATCH 1/4]
> > keys: Introduce tsm keys". The short summary is that the current
> > approach of adding new char devs and new ioctls, for what amounts to
> > the same functionality with minor formatting differences across
> > vendors, is untenable. Common concepts and the community benefit from
> > common infrastructure.
> 
> I agree with this, but ...
> 
> > Use Keys to build common infrastructure for confidential computing
> > attestation report blobs, convert sevguest to use it (leaving the
> > deprecation question alone for now), and pave the way for tdx-guest
> > and the eventual risc-v equivalent to use it in lieu of new ioctls.
> > 
> > The sevguest conversion is only compile-tested.
> > 
> > This submission is To:David since he needs to sign-off on the idea of
> > a new Keys type, the rest is up to the confidential-computing driver
> > maintainers to adopt.
> 
> So why is this a keys subsystem thing?  The keys in question cannot be
> used to do any key operations.  It looks like a transport layer for
> attestation reports rather than anything key like.

Yes, it has ended up as just a transport layer.

> To give an analogy with the TPM: We do have a TPM interface to keys
> because it can be used for things like sealing (TPM stores a symmetric
> key) and even asymmetric operations (although TPM key support for that
> in 1.2 was just removed).  However, in direct analogy with confidential
> computing: the TPM does have an attestation interface: TPM2_Quote and
> TPM2_Certify (among others) which is deliberately *not* wired in to the
> keys subsystem because the outputs are intended for external verifiers.
> 
> If the goal is to unify the interface for transporting attestation
> reports, why not pull the attestation ioctls out of sevguest into
> something common?

That's fair. I originally started out with a draft trusted-keys
implementation, but abandoned it because that really wants a vTPM
backend. There is no kernel consumer for attestation reports like other
key blobs, so that leaves either a key-type that is just a transport
layer or a new ABI.

I have a personal distaste for ioctls and the presence of user-defined
blobs in the Keyring subsystem made me think "why not just have a
key-type to convey the per-TSM attestation reports". Is that a fair
observation?

An ioctl interface would make sense for a common report format, but the
presence of per-TSM options and per-TSM format modifiers (like SEV
privilege level and "extended" attestation reports) attracted me to the
ability to just have "options" specified at report instantiation time.
I.e. like the options specified to trusted-key instantiation.

> I also don't see in your interface where the nonce goes?  Most
> attestation reports combine the report output with a user supplied
> nonce which gets added to the report signature to defend against
> replay.

The user supplied data is another argument to instantiate the report
blob. The instantiation format is:

    auth <ascii hex blob user data> [options]

...for example:

    # dd if=/dev/urandom of=pubkey bs=1 count=64
    # keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=2" @u

> Finally, I can see the logic in using this to do key release, because
> the external relying entity usually wishes to transport secrets into
> the enclave, but the currently developing use case for that seems to be
> to use a confidential guest vTPM because then we can use the existing
> TPM disk key interfaces.  Inventing something completely new isn't
> going to fly because all consumers have to be updated to use it (even
> though keys is a common interface, using key payloads isn't ... plus
> the systemd TPM disk encryption key doesn't even use kernel keys, it
> unwraps in userspace).

I do think the eventual vTPM enabling is separate from this and I
mention that in the changelogs. That functionality like
SNP_GET_DERIVED_KEY is amenable to a trusted-keys frontend and being
unified with existing TPM paths.

This report interface on the other hand just needs a single ABI to
retrieve all these vendor formats (until industry standardization steps
in) and it needs to be flexible (within reason) for all the TSM-specific
options to be conveyed. I do not trust my ioctl ABI minefield avoidance
skills to get that right. Key blob instantiation feels up to the task.
