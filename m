Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7C176768C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjG1Tos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbjG1Tor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:44:47 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC51D2688;
        Fri, 28 Jul 2023 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690573485; x=1722109485;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Awft7Rue0ajXLJzC8FVOsd4d8KfjUkZwsI7+KZhRdLo=;
  b=GEJzmcnWppNX2UGCzTzk9Kv1wSr/uUIqUSxh77RyzVzEY5H8Mqyeypfe
   mJY7aF5IVcZCIzd2sCwUvsR+79ihwhyf5v54Aag2iciHSTxb5684SVzOQ
   Z1ScWC8XNWWlFF0IBqvRAooXrvNCPQxgoY8X7ad9TcVOyy4BZfNM7/WAV
   7yAXHC52QRicIStTZMT8nrC/ybQGsxqDuetuaXpZTOC6GJ7edTf946G5R
   d7W9P6Qt7UvUXypt7oVyu9EpIoZ9SMu72DBRBA5FoOwDIpH6q+hG98uyn
   AwQl6GM1xecS5w+6dgxU0MsbpNGAm1SvEdTOIWLLs20+VaO/rpscTSo8S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358696854"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="358696854"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 12:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="1058254693"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="1058254693"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2023 12:44:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 12:44:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 12:44:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 12:44:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 12:44:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEALVKAWFLAAb3IRO6sU5fepQnS2rc/TnadiLT+HgCVChCjCPoWFbE9+WBh3ysELyKHTTfj9qFRPraU5zHuqeWgG2M7w35um5hrPMhb3C3zqll75ntTyxqi/ytWfD3y+0gaZ+LmE8yMNcZwDfF5YOSrlnavJUTToW+IlMVxVUesZYeTicMjrStd+tmLqGSy+8+19XLRQT4gC28k2gykCx55/eC67t6EqADrGcGWaY+IVllHqDBtz9EtVqlQLk54YCxkDztFVoZ8adx2VOEGNAoXY46WF9o4+VtgtIKji1yPj7+ASmnkn2df8UGqlltx+2440WzJzyXATHl6UafMEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWVTsnnhY3bKGA4JS1j6ufSSksJ/VGMO7WTeqhCqVHE=;
 b=F/Fvzp7B1oiNaornjgnmzDkqMw31CEnWjgU7Nv1EnCV1VKii7lXBl8xfHAkMk9F/CojrK0hnfIelTnV95HMeZmwPZfuZcgdHZrUNbBHsaYdasw5ZYcr3Xog+1KVfygHZRSNYOm2HZMkH9fOf++ICIb6CU1OQEdBtlODRUjMXslIrIkjJ2BlQnt9p+onXjNqOG9fDMby7nmrclTQh1kynHKP2EUf5aPIXrLc91Ax1xUZAeqdjse7caKbk6TcvPo8MNvmpPHUaenhUoRcKWHgmByNH7Ngtve16IbnUh8Pz69H4V/CDgUsaqC6tK4ZDyMP3LoKr1JOA4td0YUFR9o3L+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:44:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 19:44:41 +0000
Date:   Fri, 28 Jul 2023 12:44:37 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, <dhowells@redhat.com>
CC:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Dionna Amalie Glaze" <dionnaglaze@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <64c41aa5ba9ac_a88b29494@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <CUE22P5RYPH3.1K05T2OCK1CN1@seitikki>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CUE22P5RYPH3.1K05T2OCK1CN1@seitikki>
X-ClientProxiedBy: MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: e84de3a5-d6b5-4d20-84af-08db8fa3159e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHfQXb8bZ+delfC2fnjYh/rjQ9l5f2fQIHwL3ZGrRWHEMwz5HEKfv0bh/bi+E6XTC9VK+tjRLg89TgS+Hxwh9JAcm17kG4BIHos5q5pSJGwPmu9RISL/GGkSG5yzqdzdJBCMb/9BLvvdMtZ2aLoHr9rwH6ORhDY5kFSJEQyaSPS2SGde970KEfDA7V5nRqgzGaoQZVGZk05azIHuPvsJLZHufr0LIO0BOBs+737U6IsG7eZ5xZ4pRwUvuWkj1EiTGJ77fxQyqDNYT6m7P9YqA1lIGdHAKBInyyBQOM/9h0YTGAEApF7oQ0SEHmi9FftqpHtvfWcKCJgBA/5TXEPOa7zUnX7qD7hxP0IOUk+G1N2g4zTBYLT3BC5G+gh9RFlRl5lWSXUpRAlkeVwZVLf5MRPHRWtr2zuiAeBCv/Gg/VhLJkuU9bTRQ+EpY9Bj1a63JAy8VbxB52ze8PuGIIJTzdWEtIxLGds6xVZ94fMJ1jX1PLY8lg/zMiDMRRiN8YLg3m/yXLc20+IdAfS/rA0/dbV0NuHX//KjqGjGK9O0e7q0iJC+Y4WT3aO6OGdxbA9kScQvFEbX+d3WMH1N3hxV4GZ4dpFEdc6xbAqFTF7bjD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(26005)(186003)(6506007)(2906002)(54906003)(82960400001)(8676002)(8936002)(7416002)(110136005)(86362001)(478600001)(6666004)(6486002)(6512007)(4326008)(9686003)(38100700002)(316002)(66556008)(5660300002)(66946007)(41300700001)(66476007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHF3gWQuP0+ZEku+l/bX+rhBEToNshfjifh24J9KdMTE6dDs7dEqRpbCev4v?=
 =?us-ascii?Q?g4h3YZ/cwsbtIz7TkQ2adxcqiKnelQaUQ7/B+K2a/GtRvfu/Dj9LVSRp3EQL?=
 =?us-ascii?Q?V9F6OyBRmLpIoXyOWPqvmx0KJPaKGJAXNZDIvqR2iO0kqFSMo2YQXY7EcCf9?=
 =?us-ascii?Q?kM6d0HUznb8kdOchQO5mRUOQxXIJun6nvG41JTT2uZISx7M6GvisqBxrtQJr?=
 =?us-ascii?Q?AbinyADUANcuHEr6A5x8JcSw7oKWLVnbqzZNdfgsYmDP0NVnDnZWI2VOxett?=
 =?us-ascii?Q?Ch4gojfs1T+6Ztal70OpKQPT0KWk5JOFnO9ahsuVXkbZplKuKoOOp7ZcTy1L?=
 =?us-ascii?Q?zgIp3ONCf168q4mRil3s5OeD7wMumcTDcJioosmdmYo38jnt9hZbXVZOWF02?=
 =?us-ascii?Q?uyrSBjY29tXuaS4pkTK1/TKMlXIbO9r87tHF+F3OMkxSoUuaEy2MWNcivkcb?=
 =?us-ascii?Q?aSra4UJCCmfP3QUr0ccSOy5jov3mrSWTHceD64GSR/vW6S2jzK+b+f5vcDS5?=
 =?us-ascii?Q?s2ZJAmGLYFe/dql4Pdey8IUwKQumBR/wz11pAaY+qClVKk852hv7h1AdDPn0?=
 =?us-ascii?Q?Anu38n9vt9n9dl/POwEPPmFxjz0kIC7BAyE8PQjx6R0UnQN9EePfqfsBv3vN?=
 =?us-ascii?Q?E+J6YA6R6fTTP74sudn5DWlZiwDz60o7VQfpuDMvOPdrp3G+KtxflJw/r4Ob?=
 =?us-ascii?Q?orNK+kJvEHv3wJB1lKEJ3LoFBwtOdfRFtYIUEgULlcOaJcJhzm194Ep1tvgQ?=
 =?us-ascii?Q?iB/rl82mrIhoIRk4Z0SebKW9P4l7YPeDvsmvvqbQLaeeMcVQoJRsW4diq2x3?=
 =?us-ascii?Q?RmUaQ6oQftvawLVMcGc0Gi1yhNs+9PB7U0J6Mu1h19iSSpFdM0GQGplMTVDi?=
 =?us-ascii?Q?Mmg4hiwc1nrSbU0UK7wn3tlPuzWWBOPIkGrOXm/BMPEZ8yqJ+vhaCUQpbnvW?=
 =?us-ascii?Q?xfWapGscXhldX16SVCfr+f68q34gM8ecDhOHUBoMXJD/QCU3BHfy/gtTvPQl?=
 =?us-ascii?Q?ytEK7/z3SLS8IBBqWFfjF3YRbr0v+si5mfBki29pIOzHLUFHpdDnOrejXbZC?=
 =?us-ascii?Q?faxRYi/KZ+2nfGifh8pfGgKD/A/euaupuYm86VBPnJblxmLMjaU+PD42PkC8?=
 =?us-ascii?Q?aFIghs60QEshAoE38ILuiC3Z+S/LKq+wBQ/h065mXh3RH/A6rDHlgd5gXOpj?=
 =?us-ascii?Q?5QK6FXSzu4I3C2Jkjs7H4xEzMSTNMcejvMbfTYHeqt6oM5Q7btBoiTSj64aT?=
 =?us-ascii?Q?rF6/P7QADrYDE52AmgyFu4T8u6RS2vRusoC+GYbl04JSV4KOCaoNkdxcb28/?=
 =?us-ascii?Q?nKOJAvjDFvNrgdTN+n7S2dsfFAe4uJPo7qIJKtl+nZsOXiVh8w1Nwc95M534?=
 =?us-ascii?Q?WR8E+srkwaugP+aujCOsV+lrAXgSPSwUWoM2S/OCYSL/C9eIX0Ybq6YQBZCP?=
 =?us-ascii?Q?WW4UbGh3LXACpUs46sXbyUJ4lDRNFFJFDeWCDFsmBSKgLCoxKN2iW1lvzNAn?=
 =?us-ascii?Q?vLzQZBjEv+4Spf+yivs3ZUMKcty3LSrRbO1RKqZvsRKlpm74njNLU9wHd7f6?=
 =?us-ascii?Q?OUyRwz/z9mIB7zR83tjB++Ks5UBocLUh1jyigqDacMPiM/ozHnIsF5GT1G6g?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e84de3a5-d6b5-4d20-84af-08db8fa3159e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:44:40.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7605YvniLXpXeXaeZa+MF8mcj1rl7QI8iyIODfvqbETlRVt1zEnzWgGXzCmW0VVi5/+ZOtu7CSyzXXyZG0vhfgcHXcl6JJUeHotCVPcnMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5144
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko Sakkinen wrote:
> On Fri Jul 28, 2023 at 7:30 PM UTC, Dan Williams wrote:
> > The bulk of the justification for this patch kit is in "[PATCH 1/4]
> 
> /patch kit/patch set/
> 
> > keys: Introduce tsm keys". The short summary is that the current
> > approach of adding new char devs and new ioctls, for what amounts to the
> > same functionality with minor formatting differences across vendors, is
> > untenable. Common concepts and the community benefit from common
> > infrastructure.
> >
> > Use Keys to build common infrastructure for confidential computing
> 
> /Keys/Linux keyring/
> 
> > attestation report blobs, convert sevguest to use it (leaving the
> > deprecation question alone for now), and pave the way for tdx-guest and
> > the eventual risc-v equivalent to use it in lieu of new ioctls.
> >
> > The sevguest conversion is only compile-tested.
> >
> > This submission is To:David since he needs to sign-off on the idea of a
> > new Keys type, the rest is up to the confidential-computing driver
> > maintainers to adopt.
> >
> > Changes from / credit for internal review:
> > - highlight copy_{to,from}_sockptr() as a common way to mix
> >   copy_user() and memcpy() paths (Andy)
> > - add MODULE_DESCRIPTION() (Andy)
> > - clarify how the user-defined portion blob might be used (Elena)
> > - clarify the key instantiation options (Sathya)
> > - drop usage of a list for registering providers (Sathya)
> > - drop list.h include from tsm.h (Andy)
> > - add a comment for how TSM_DATA_MAX was derived (Andy)
> > - stop open coding kmemdup_nul() (Andy)
> > - add types.h to tsm.h (Andy)
> > - fix punctuation in comment (Andy)
> > - reorder security/keys/Makefile (Andy)
> > - add some missing includes to tsm.c (Andy)
> > - undo an 81 column clang-format line break (Andy)
> > - manually reflow tsm_token indentation (Andy)
> > - move allocations after input validation in tsm_instantiate() (Andy)
> > - switch to bin2hex() in tsm_read() (Andy)
> > - move init/exit declarations next to their functions (Andy)
> >
> >
> > ---
> >
> > Dan Williams (4):
> >       keys: Introduce tsm keys
> >       virt: sevguest: Prep for kernel internal {get,get_ext}_report()
> >       mm/slab: Add __free() support for kvfree
> >       virt: sevguest: Add TSM key support for SNP_{GET,GET_EXT}_REPORT
> >
> >
> >  drivers/virt/coco/sev-guest/Kconfig     |    2 
> >  drivers/virt/coco/sev-guest/sev-guest.c |  135 ++++++++++++++-
> >  include/keys/tsm.h                      |   71 ++++++++
> >  include/linux/slab.h                    |    2 
> >  security/keys/Kconfig                   |   12 +
> >  security/keys/Makefile                  |    1 
> >  security/keys/tsm.c                     |  282 +++++++++++++++++++++++++++++++
> >  7 files changed, 494 insertions(+), 11 deletions(-)
> >  create mode 100644 include/keys/tsm.h
> >  create mode 100644 security/keys/tsm.c
> >
> > base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> 
> So how does this scale? Does it scale to TDX, SGX, TPM's or even TEE's
> (ARM SM, RISC-V Keystone etc.). I'm not sure about the scope but we want
> of course something that adapts to multiple use cases, right?

TPMs and TEEs are covered by trusted-keys. I do think a "TSM" flavor of
trusted-keys is in scope for where some of these implementations are
headed, but that comes later. I talk about that in the changelog that
functionality like SNP_GET_DERIVED_KEY likely wants to have a
trusted-keys frontend and not isolated behind a vendor-specific ioctl
interface.

This facility is different, it is just aiming to unify this attestation
report flow. It scales to any driver that can provide the ->auth_new()
operation. I have the sev-guest conversion in this set, and Sathya has
tested this with tdx-guest. I am hoping Samuel can evaluate it for
cove-guest or whatever that driver ends up being called.
