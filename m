Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935C5769F87
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjGaRdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjGaRdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:33:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3710F1A7;
        Mon, 31 Jul 2023 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690824799; x=1722360799;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G3IghZ72499gIzwhKRk8ne5zfktRe1hSjMrax64LjsA=;
  b=nd5Ayv6Kb1h84UR2VjQLscrIc+MOhtqwg2jmIEX6qOdIgBzvHagUY4UD
   pqpBom7Zdc7DMW/zKAoA3Dmkz/8kr6gqZarP422Ax84/K8P6a5395PCWn
   I2s7VU8h8LgVfAxBoeBRjTIH9LaVlMLaiAfgMTeSWBSY18HY8mVoPpW0F
   PIM9BcDpyeKst2AVVbua/lmSdmZGLRdsDd7d1i3mda8plQ7g4Y2vtGQho
   Nsus8MU4CGgCF1OZiAnzNLhlV63NuVAsO5DZlCk/YNh0yaHrrhJSUkigT
   SGMCF/nNMbyMTLjQDeQn9ccFsPrnHQbOWw3Bwr7+Yr6C4TSGSPh9/4Qck
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="367985670"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="367985670"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 10:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="705500952"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="705500952"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2023 10:33:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 10:33:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 10:33:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 10:33:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 10:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3do6w5LXDcmkSqBvCI7Bl+AMKpfR+HENPnMYm+JCWlUzY9kkRgvhsO08eqMgZDWBacG8Twvw/SAD75k+baxehr/KIVErhAnM5Uh3FAbAtbLQkyX97l4pbrnvekRNeY1E5MOHVb+cPsP5mMqv8osClPyUdUhnBTYrE93r0mA7oFTY4rgsW2y0h942A1DwFqY42GxggZolFFnVm7pJNPOWaB/gVmAjuB05xXVa59NQ5W2pETf1nf2nnn7cY9aR/wmSmbRYcy2KsFDG36T+ojKyf1pW+xDZTHUGiThCT8UY1DI0lsZZal+9RrTQCe1GjiBXtCTZRRjJpszj6Au/0wsOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0KSLJPjsTNN/nm9ET7jJFhbxAJf7bklshk6lJ8cFL8=;
 b=l5+/bde36kWjCdPCJ7YpOWZZTSMR4ZaGisdDnnFGAkV1zpnVjoX09hVIoYJ8P9E9kTazLyYMCKGvDG3B7TH2EQmGF+5nOvIPQcsDnjAJS4w+j3Gf+L/WFYdacHhCfrHr3BO7MQFkXeKs9xKNbVEDkk5fIlRorEaSI6pRfdQJ+QwhWF85Mw0i2qvIMfdFln/bssb9VQ/a5QK/TrTim/9j6pfWWg8e2x9noDfMiAmmN8+RZLxctzlmDd2J90lIHeRJlTds+iL5oJwVVY+Vbz+TYm0Q//2gEOPhW2qHC1guNicZs6BvyTopL32wNQcCGEqp/3OZaR9xyMB674NkCCnEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 17:33:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 17:33:15 +0000
Date:   Mon, 31 Jul 2023 10:33:12 -0700
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
Message-ID: <64c7f0583d5ee_51ad029484@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <CUE22P5RYPH3.1K05T2OCK1CN1@seitikki>
 <64c41aa5ba9ac_a88b29494@dwillia2-xfh.jf.intel.com.notmuch>
 <CUG9XAK3RNFF.GWCYLXSTWX5E@seitikki>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CUG9XAK3RNFF.GWCYLXSTWX5E@seitikki>
X-ClientProxiedBy: MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: b7946bad-0669-4889-6107-08db91ec3894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpiIXXK2MV56NTTFoEiiIQYG0c27is+5VBxDrDKe/FKciU4+uvosKfL7zXn/Ogqs79JZ5t5YsKBTC1HHty72wJAbnMqjIPNgUY1L4M+aHujXLjiH5oE3ZPvs9g6hSKmwA/VzVAkDba94VH0Wxf+Mmg9tz+yZHFscQrhJIEZ/raysJVJ0ibTzRtJiawimiQPOkTlbZIICunEinjvARHrxrMF4J5g4MSfLZNYhAzTU83p30kEnQ223Vo/pRgbG+ajNE1f8gm78UUuAST8V1RP2bojdomtYxwGmdI21ZNA7w7Lrvss8ix1YnQSePhj+MZU9Mcy+3yTNQbCWaSwlIJiVnh4lMOmDl2S9Q9AyvR7u6jM51lG9PixZmI370JnrMMvDwDY4PQe8YuCFIAa/Dy2KUlFacUfMQmx8HJr+PT9GTJzWMd07j9qs2r/KDliaEj/6/SL01+7vjPfl+w6a2dYAAyUlYgijGZma4/+8+CXTWO3iQaJcDcx4xJNEtmYUsHtLwEWms94KK3Lz1azG7BesHX4NltjuDMfjcdLB04EgeyTUWuue/u+h9D3AwFZ8cLUr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(2906002)(316002)(8936002)(8676002)(7416002)(5660300002)(41300700001)(86362001)(6512007)(9686003)(26005)(6506007)(478600001)(6666004)(6486002)(83380400001)(82960400001)(186003)(66476007)(4326008)(66946007)(66556008)(38100700002)(110136005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dsmvp8NGTP6E8vsvGC8PP7RWT5Deg+hTMKVdrrBdUr/FJi1NKGUbox40B0ml?=
 =?us-ascii?Q?uywwx1ri0g/kr/uhXXLGBQ2gD1Ro9Cy+6KwFkhGpC6eKNAK81wR8NQ361uUK?=
 =?us-ascii?Q?HqzSndsoQTPMhP1gcOB75VjBp/NM37HwCrGSByKpYyCIhND6TqbcB6ROeC2Y?=
 =?us-ascii?Q?JqtwR0hpesjPNxZ09vwrdUsldjJZ/mdO8C5x1L8+TUlJuKs27K/lBXDn63qd?=
 =?us-ascii?Q?ph1PjtdMKFAfH4HsDYL6lY5u6n6n3maWFJWW+J8lvrSwrfXWuvtf46VuHf5b?=
 =?us-ascii?Q?DchKyHvxOhyR6tVLVTcQi9jeG/KfZT6IXILtYNXyJyS7FWJ5zV0uqquUEhkd?=
 =?us-ascii?Q?e8KT+xuHOwibkRsrJtmlph3UO38SlxoKmGX4kQI366L/7ymaKLX5LbNEFD2r?=
 =?us-ascii?Q?9s6dj3opRu8rA1k3AsAT1Ff413m4rv9f+w6rJE31khdTBxMvsuQzOWmSU1z3?=
 =?us-ascii?Q?Ko6nljDfWQo10IzYZ1UuvDDZ+iFd+/+b0FU+TnQYeSCrV0km1ey5wKLOllF0?=
 =?us-ascii?Q?I/+rlgofTbhQ6Syp5cLYJ3dK+J+l5SKo4Iw1QbFS3bapNTzLc9o1VqsSMCD9?=
 =?us-ascii?Q?ePBd/ICrUVtT/f7PIAp2GxW2SW2IJZh2yy7AKYGootIK4RxMNpLDkqSBmVr8?=
 =?us-ascii?Q?RYB+J7pVlIqSQZBf40nMm4UYsCDZ8tAxRIHSK/jQzqFsqM4U8CSIClzs4F4e?=
 =?us-ascii?Q?tJbNH/tITebW3FPYD1JcRV7+T6eK88myvxTYoojvE1F+JuQBCH6zqAnOmPKa?=
 =?us-ascii?Q?YgW61X4TPTDEmRMn9+c3LHESg2libjsNzwWaknUGjFXy5LKrvbAFknsIRUV0?=
 =?us-ascii?Q?VJwAoS8TAqLCb95vHsg6ltGvtiQSW/KE1Z0x2DNwQodNUupT8DWy3S/5vi1c?=
 =?us-ascii?Q?pdpqQXSkCrYGZxbsabeU4GK+gTmljw08E//kO1E4dV+zYb7fWBlDbsJHwZQL?=
 =?us-ascii?Q?gE/s9TsTswoVeJ6ZusH40zs0ir1QgvJc7Xg1t16TQDIztIOSKKGV1bZwgTPr?=
 =?us-ascii?Q?yD+ikmL7mLPWW9nnzhmHDFqsfWPijoD4YBX5OtklL7ntHs8G+8makd4x7Oxu?=
 =?us-ascii?Q?eZSrt90jAeUz11YvSS4DjJSoaw3H1n2k2UDPqat3G/dDiIIMUfJxjWEAjc1f?=
 =?us-ascii?Q?KW0kTXCmbkxzH7sEVtAyGQeJJ5wdviGxyCKyT/XCiZgueHvN2R63c3zLBbiV?=
 =?us-ascii?Q?QL6WTG9eG2EweYlRnW2sDSmkH2yS2UHOepj9uZv1hruoivfkajoGUSoTZQIl?=
 =?us-ascii?Q?llrTGjgIFlyOjxKRikDywyVyfetqoEb+MZFGfLIPQC9hUx4NYgXNB99fg+0L?=
 =?us-ascii?Q?mKhCnoXUDzBKOYMomENgRVMHIlHJATqHWTq5zuCrlXZ5Tnt7fLsmU8z6sGvu?=
 =?us-ascii?Q?FKD1Qdb0skchbffeFrWjutBb7zXUppvWNtOLquwhW5ay9H/IH/FJuxF/n1ax?=
 =?us-ascii?Q?9gsWHTU3GOxj0zqTT6M1HElYNcLt8MPKj4hMjm5oXzlK+WAiUTbMpXzeEOxr?=
 =?us-ascii?Q?FyDBZkKdUdVbJ5vKL69ud/R3bgwlQiI5EHwMhX+CqptiZE78b+6G8EdqEOT7?=
 =?us-ascii?Q?S+8Gml5Ty5C2/mRzV33Gl0OuoD+WOFkbHA25k3fXwmgKouGD53x+S6lHFLBJ?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7946bad-0669-4889-6107-08db91ec3894
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:33:15.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbZDpL/V0E+zj8eqKn3/01tQPsplUaTLsx3x/l/8u/JbvSzmfAy22sQ16NRvOwCmWI45uAULaikcpZEwvZQKX5HIOKANhsZOBDMIgqrabOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6418
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

Jarkko Sakkinen wrote:
> On Fri Jul 28, 2023 at 7:44 PM UTC, Dan Williams wrote:
> > Jarkko Sakkinen wrote:
> > > On Fri Jul 28, 2023 at 7:30 PM UTC, Dan Williams wrote:
> > > > The bulk of the justification for this patch kit is in "[PATCH 1/4]
> > > 
> > > /patch kit/patch set/
> > > 
> > > > keys: Introduce tsm keys". The short summary is that the current
> > > > approach of adding new char devs and new ioctls, for what amounts to the
> > > > same functionality with minor formatting differences across vendors, is
> > > > untenable. Common concepts and the community benefit from common
> > > > infrastructure.
> > > >
> > > > Use Keys to build common infrastructure for confidential computing
> > > 
> > > /Keys/Linux keyring/
> > > 
> > > > attestation report blobs, convert sevguest to use it (leaving the
> > > > deprecation question alone for now), and pave the way for tdx-guest and
> > > > the eventual risc-v equivalent to use it in lieu of new ioctls.
> > > >
> > > > The sevguest conversion is only compile-tested.
> > > >
> > > > This submission is To:David since he needs to sign-off on the idea of a
> > > > new Keys type, the rest is up to the confidential-computing driver
> > > > maintainers to adopt.
> > > >
> > > > Changes from / credit for internal review:
> > > > - highlight copy_{to,from}_sockptr() as a common way to mix
> > > >   copy_user() and memcpy() paths (Andy)
> > > > - add MODULE_DESCRIPTION() (Andy)
> > > > - clarify how the user-defined portion blob might be used (Elena)
> > > > - clarify the key instantiation options (Sathya)
> > > > - drop usage of a list for registering providers (Sathya)
> > > > - drop list.h include from tsm.h (Andy)
> > > > - add a comment for how TSM_DATA_MAX was derived (Andy)
> > > > - stop open coding kmemdup_nul() (Andy)
> > > > - add types.h to tsm.h (Andy)
> > > > - fix punctuation in comment (Andy)
> > > > - reorder security/keys/Makefile (Andy)
> > > > - add some missing includes to tsm.c (Andy)
> > > > - undo an 81 column clang-format line break (Andy)
> > > > - manually reflow tsm_token indentation (Andy)
> > > > - move allocations after input validation in tsm_instantiate() (Andy)
> > > > - switch to bin2hex() in tsm_read() (Andy)
> > > > - move init/exit declarations next to their functions (Andy)
> > > >
> > > >
> > > > ---
> > > >
> > > > Dan Williams (4):
> > > >       keys: Introduce tsm keys
> > > >       virt: sevguest: Prep for kernel internal {get,get_ext}_report()
> > > >       mm/slab: Add __free() support for kvfree
> > > >       virt: sevguest: Add TSM key support for SNP_{GET,GET_EXT}_REPORT
> > > >
> > > >
> > > >  drivers/virt/coco/sev-guest/Kconfig     |    2 
> > > >  drivers/virt/coco/sev-guest/sev-guest.c |  135 ++++++++++++++-
> > > >  include/keys/tsm.h                      |   71 ++++++++
> > > >  include/linux/slab.h                    |    2 
> > > >  security/keys/Kconfig                   |   12 +
> > > >  security/keys/Makefile                  |    1 
> > > >  security/keys/tsm.c                     |  282 +++++++++++++++++++++++++++++++
> > > >  7 files changed, 494 insertions(+), 11 deletions(-)
> > > >  create mode 100644 include/keys/tsm.h
> > > >  create mode 100644 security/keys/tsm.c
> > > >
> > > > base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> > > 
> > > So how does this scale? Does it scale to TDX, SGX, TPM's or even TEE's
> > > (ARM SM, RISC-V Keystone etc.). I'm not sure about the scope but we want
> > > of course something that adapts to multiple use cases, right?
> >
> > TPMs and TEEs are covered by trusted-keys. I do think a "TSM" flavor of
> > trusted-keys is in scope for where some of these implementations are
> > headed, but that comes later. I talk about that in the changelog that
> > functionality like SNP_GET_DERIVED_KEY likely wants to have a
> > trusted-keys frontend and not isolated behind a vendor-specific ioctl
> > interface.
> 
> TEE's and TPM's are not the exact same thing. Are we sure that any
> future ARM SMC like TEE interface what you say will hold?

Agree, they are not the same thing, I assume that's why trusted-keys has
a TEE and a TPM backend. Also that's the point of common interface
proposals for the per vendor experts to take a look and make sure it
fits their needs. If you have contacts there, please highlight this
thread to them.

> Why do we need a new key type, when we have already trusted keys?

As I mentioned to James to the comment from him about vTPM, if that ends
up just looking like a standard TPM to Linux then nothing new is needed.

> This whole territory should be better defined so that everything
> will fit together.

Yes, the per-vendor differentiation in this space is an impediment to
kernel interface design.

> > This facility is different, it is just aiming to unify this attestation
> > report flow. It scales to any driver that can provide the ->auth_new()
> > operation. I have the sev-guest conversion in this set, and Sathya has
> > tested this with tdx-guest. I am hoping Samuel can evaluate it for
> > cove-guest or whatever that driver ends up being called.
> 
> What about SGX without TDX?

My hope would be that anything that can not be fronted by TPM2_Quote
directly can by frontend by this "TSM" class device (as I will be
switching from Keyring to sysfs).
