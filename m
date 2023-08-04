Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8920676F7CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjHDCYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjHDCXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:23:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FA25249;
        Thu,  3 Aug 2023 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691115794; x=1722651794;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qUFUR3miiVXAIRMDDew7k1Ihp+ppiPfJkXb975JgHTE=;
  b=P6fblKyEbi+MRh/WgrbzjgZG3xxz7xvi0K+SvhzgVPklJRlYPs13+ygx
   ov3M8t49nfEZOgUNufubk2OaJk0iykTKyX8i+vqHTE2FLwnblNOQfJAMR
   DffVN5gYWY1dRhmVRoz4cjvdJgdvLRpoVwg0AUhZPLnOnobUys2WF/28/
   yW7bUMywb7ojc8b5luRvcS8/JI9r1hCQTX6jjjog2eyHp9f1BaMphOrRH
   CCPtrHBCZLfoYGQa+4qEAM83dfo0W91ncPGgfw2/viqIv9W0nWNgwX15b
   Ro8SDX276RldpDCe0Qw3Rh4xN4GMzdWkHhyChsKhNY737Y40HfSDjRU7H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373688129"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="373688129"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 19:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="733031122"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="733031122"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 03 Aug 2023 19:22:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 19:22:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 19:22:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 19:22:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 19:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q30AGiNCbLURg69YCiNX+O2KoZNDyoAg4A36wmLbSJkBksPz05LNqPYnhbmr7dGqnIoCDCFDMq0Zy6P3xTl967UJUClZo643GfDGw19N4jJxrvBxQxLJHgxayC55CBCLIYXovgwghzAMIHFHvmRpJw6ho6fzCIbAueKQDW7kW5r0D2TbvbOqO7POCx43sQ+xt3JqYqzVXWPcQiBRHZUdph5WYdn+rDOzMrGreVh2KRpziZUXqlxlpHVQWW28ZI/wnbNOCpYlYLhA5oKNe5nmnjQeh8YkCFPjs4P5MKSEIv3v4RZZuAeuBzub1joY60JXjS6zClw1QER03kqMZH+kUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RU64fCJPvBdImRwFaDjePtOtxvprYIPCRxrJPgamMU=;
 b=BWMTvPHyE2hWE9OJAbWwcL7Dz3gysCWwrCKri6nHnhwAEQPylQ1IubIBwXBGCeVAp2GM0i5GWeD8WbzalkoY2QDOT1e+u0J7PHGyG9Nf2FhQjmfWGyX4ek6LSaVmAevtrf38Dz01tlYk8M8tePK7d5lCpY5NCDQNuNZsaa7YwQyBKbvJ04UIW4bSUblFpHKB9wtXaJE+JbRIGl/SKh5cE1+i0k19XK9Vacm37FV0IxKwTP3gb34XKiqJynUJ6s0oTt6/A2sNYZ1bz6d6woyECP6Yq8cU1Zr5x35cQg1+sCWWe0qACxQbMUT4kciIMeI1PnzFqmIvIijNemAQB4G6Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 02:22:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 02:22:51 +0000
Date:   Thu, 3 Aug 2023 19:22:46 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <64cc60f691102_782a3294a2@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
 <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
X-ClientProxiedBy: MW4PR04CA0329.namprd04.prod.outlook.com
 (2603:10b6:303:82::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 431f22ee-a436-44ca-6d68-08db9491b3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TawKGoITBhLbqOZ1F3xYmmwAMNIz/q55eF+xDr7B0jCsIL1uovlp1l7Z3E4FJ1DSyK6lNxyypPeIF5Y3/pb8dExMA6clexbvGNObW7LgS48FOuOkAmLcPEpkJHjY84kpLkJXyLejCFetsFGxSD2ir8T11KRXq+zuf9VLeF9FesHq0KqO01tSnvvEOzWa5lHcRIi2BAphgV2wbFxHF/P1N+s/FSaf3h6KPyZyht6UogvkEuHqJkTscgJbYdD1qJMDwZCmvFtS7rAysMkFAFakZ5uQ+H+I+T1xUxzW5cV2l6IYCmEt4quXp5Mv+q+PpRPsn9Ppb2snKFIBlKDt0sZMr01mARrHjf+yxuYUdSw8TSZsDIPyOEigWo16feaQhohzryTG18CiK8fFmpdVHjVlKo0pPuIE5i7lV24zw/j0ev6tKg3dsH48mcf9GYvlmN7Zq5DuzFAfGypmoHUguzOwLbB1Snt34iqkZZpf5ZqOw603jiS73TJ0qfKEuu0rtdSmS/YY2oCg3tP5mPa6cbqoLv5pacvN6KaEpO6gIH0RTiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(346002)(396003)(1800799003)(451199021)(186006)(2906002)(7416002)(5660300002)(66946007)(8676002)(83380400001)(41300700001)(8936002)(316002)(66556008)(110136005)(66476007)(4326008)(54906003)(478600001)(9686003)(6666004)(966005)(6512007)(6486002)(86362001)(38100700002)(82960400001)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pQySmXYG9i0R9unPl03WIG1ExsBLFdaTP21ijAc5JEnkWpU4MOpgoGaNBa?=
 =?iso-8859-1?Q?Ajbslklm5aCPM1kTNXGeiZwLb5VaNNBoYGf5f1DgEZKRRSq4BUobayqnli?=
 =?iso-8859-1?Q?sJA7LM1AuBKxn5LKMPePESdhi/namBU3hd1lg5Uy67Uq69gqo0ogrAy3LZ?=
 =?iso-8859-1?Q?HB2WMsEUzFeQgNioHn0iKTkJU5yajnMf8tuIhBfM+Otdurw+kEGO92R8WE?=
 =?iso-8859-1?Q?A/Z6qfKiOTWRhuwxVNNXV+jWHwPaL1SPC/ntbtK63JpUzdO4YJreKgGXuX?=
 =?iso-8859-1?Q?ePkFL4gRKDZK7AJevIOPb5pej5giz/e0Wti2ojbqD5/mhhYmdLADbaRbpq?=
 =?iso-8859-1?Q?sEHFzl3sxV0SyDdTLT8l2jB1WGcbR22cEhEguaztf5VYwW5JWZR4IiWnDi?=
 =?iso-8859-1?Q?R3Qz2DqFi5XIQ2qwrtrGN4PSKKYEoub2A4EcLdvTA4gxV+yw01C9UvayPi?=
 =?iso-8859-1?Q?2yP+PIClh7VYm7/RjX5lPEX1rkkD9QyAYOB8WjbYvAYohmQgnxeMFHIEuA?=
 =?iso-8859-1?Q?vTbZWWAF6AO3GMfSNWZX6FxRJlS08c/lJTcA2Gp2TAPlazUDuPLvfRa8eP?=
 =?iso-8859-1?Q?VpjvhHUlacWEA4LKNsuH57lxxnrfJ6Uv8LIcPGuG0XRGLJtUzCHPL+0S8z?=
 =?iso-8859-1?Q?+nCVnUWKtZn09HvX/hmGPjAhldcYzW9WdpyRRGycKyflW4yNvQfAcmDUQh?=
 =?iso-8859-1?Q?LTds0lsCfPlbHT8TdwQIkdT9fTy/tAH+YlwzplUp8RnyO9pCDM+Ks2sERG?=
 =?iso-8859-1?Q?3BozGzEblO8vjJ2FgoS0r4V0IIb31nPR5bc8Ki1oBqxF7qb1NTnN9nnBJ/?=
 =?iso-8859-1?Q?GTrPIBE3vDoFG0w/KYS2HzmKq8sVkB/KVl7trWCy6t/2UnMYerkTdJe1EO?=
 =?iso-8859-1?Q?RQLHIQBlMFcgi1SBVoGmPWw+h67x+Z+VjQ//KwrRou/Mn0ByLD6p3jRdRC?=
 =?iso-8859-1?Q?A/byICmaKb1U3MwAkf8Dzkgz5IPrdLfDSYIVVaZcBwJkV4rGgnAVnlj5DX?=
 =?iso-8859-1?Q?ho8JlUdDdHxJTb5C4LKNrajv3cpzWg6r5SnD5h+DXihVj6CZWJE2p1y/Fs?=
 =?iso-8859-1?Q?KAEJbYa6kUCCpOHoxMCDJGScJ/PsqfyKiF0LJBErAKOFblKdBp84rVH1J/?=
 =?iso-8859-1?Q?ujKqXCoSzxQZSYrAh7FkcEbHthVzASh8oF4NP4RVpNZbn9knnsNgWxBmmw?=
 =?iso-8859-1?Q?7A423kMwjwjBqgpVwsJfB74xalwMw5nWI4vCA1e2ePh8EP4ShxuroMe2TM?=
 =?iso-8859-1?Q?KaLOVklzYDlJ9W3K8dooqC3EEMWspiGCV/Ce6Z0ep6j+P0Q3nBUWDmTyGV?=
 =?iso-8859-1?Q?W8pkA35U7yMLnvzzxdGnzjnEaFnbRAV9RtDLFX1RZzElSXs/2dF+jk0bxx?=
 =?iso-8859-1?Q?vdl0tycAQT933c5jS4vc0Dkr43Dy/FM7pqfpjc6LBtxDxprvNZi9ZfkvUW?=
 =?iso-8859-1?Q?RX5o+DG56To6CdKWAgk6u7wopxA5hYXgvzTJ+P9ikXRLjbCGaIlkcOJ1sT?=
 =?iso-8859-1?Q?nTgb2eIQzbJJeyO6wpjwuyea0jm5BFCUFforpVmOnctpXr6Pc05sB2ulVA?=
 =?iso-8859-1?Q?DuEbUUbLJArqWlSvJC2DF54aHqZVYrILvzwoS47KNAR20u80agZr9creoL?=
 =?iso-8859-1?Q?jTh4eA2gsRwbXnX4X/90RebJ/jM0gVo/K+/lGkp2G16Duisy8ZY15U/g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 431f22ee-a436-44ca-6d68-08db9491b3a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 02:22:50.9800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6/BtKMyQKgF6G+rywisuHhhYXAa+OBhYifM1oLWr7wB8y2Wk1/PpbEcQx4pj0227Eov4Wxw2jZNz5qjVlantFc/oUKYS5tix+GyIS+gplA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang, Kai wrote:
> On Sun, 2023-07-30 at 08:59 -0400, James Bottomley wrote:
> > On Sat, 2023-07-29 at 21:56 -0700, Dan Williams wrote:
> > > James Bottomley wrote:
> > > > On Fri, 2023-07-28 at 12:30 -0700, Dan Williams wrote:
> > > > > The bulk of the justification for this patch kit is in "[PATCH
> > > > > 1/4] keys: Introduce tsm keys". The short summary is that the
> > > > > current approach of adding new char devs and new ioctls, for what
> > > > > amounts to the same functionality with minor formatting
> > > > > differences across vendors, is untenable. Common concepts and the
> > > > > community benefit from common infrastructure.
> > > > 
> > > > I agree with this, but ...
> > > > 
> > > > > Use Keys to build common infrastructure for confidential
> > > > > computing attestation report blobs, convert sevguest to use it
> > > > > (leaving the deprecation question alone for now), and pave the
> > > > > way for tdx-guest and the eventual risc-v equivalent to use it in
> > > > > lieu of new ioctls.
> > > > > 
> > > > > The sevguest conversion is only compile-tested.
> > > > > 
> > > > > This submission is To:David since he needs to sign-off on the
> > > > > idea of a new Keys type, the rest is up to the confidential-
> > > > > computing driver maintainers to adopt.
> > > > 
> > > > So why is this a keys subsystem thing?  The keys in question cannot
> > > > be used to do any key operations.  It looks like a transport layer
> > > > for attestation reports rather than anything key like.
> > > 
> > > Yes, it has ended up as just a transport layer.
> > > 
> > > > To give an analogy with the TPM: We do have a TPM interface to keys
> > > > because it can be used for things like sealing (TPM stores a
> > > > symmetric key) and even asymmetric operations (although TPM key
> > > > support for that in 1.2 was just removed).  However, in direct
> > > > analogy with confidential computing: the TPM does have an
> > > > attestation interface: TPM2_Quote and TPM2_Certify (among others)
> > > > which is deliberately *not* wired in to the keys subsystem because
> > > > the outputs are intended for external verifiers.
> > > > 
> > > > If the goal is to unify the interface for transporting attestation
> > > > reports, why not pull the attestation ioctls out of sevguest into
> > > > something common?
> > > 
> > > That's fair. I originally started out with a draft trusted-keys
> > > implementation, but abandoned it because that really wants a vTPM
> > > backend. There is no kernel consumer for attestation reports like
> > > other key blobs, so that leaves either a key-type that is just a
> > > transport layer or a new ABI.
> > >  
> > > I have a personal distaste for ioctls and the presence of user-
> > > defined blobs in the Keyring subsystem made me think "why not just
> > > have a key-type to convey the per-TSM attestation reports". Is that a
> > > fair observation?
> > 
> > The trouble with this argument is that it's an argument for every new
> > ioctl becoming a key type.  We have a ton of interfaces for
> > transporting information across the kernel to user boundary: sysfs,
> > filesystem, configfs, debugfs, etc ... although to be fair the
> > fashionably acceptable one does seem to change each year.  Since
> > there's nothing really transactional about this, what about a simple
> > sysfs one?  You echo in the nonce to a binary attribute and cat the
> > report.  Any additional stuff, like the cert chain, can appear as
> > additional attributes?
> > 
> 
> Sorry perhaps a dumb question to ask:
> 
> As it has been adequately put, the remote verifiable report normally contains a
> nonce.  For instance, it can be a per-session or per-request nonce from the
> remote verification service to the confidential VM.  
> 
> IIUC, exposing attestation report via /sysfs means many processes (in the
> confidential VM) can potentially see the report and the nonce.  My question is
> whether such nonce should be considered as a secret thus should be only visible
> to the process which is responsible for talking to the remote verification
> service?  Using IOCTL seems can avoid such exposure.
> 
> Probably exposing nonce is fine, but I don't know.
> 
> In fact, I raised whether we should use /sysfs to get TDX's TDREPORT (which can
> only be verified on local machine, thus needs to be singed as a Quote by the SGX
> Quoting Enclave) when we were upstreaming (the first part of) TDX attestation:
> 
> https://lore.kernel.org/lkml/20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com/T/#m18fd5167dfa32c4702dd6b4bd472ad9e8f579ad8
> 
> Quote the relevant part here:
> 
> > 
> > Implement a basic attestation driver to allow TD userspace to get the
> > TDREPORT, which is sent to QE by the attestation software to generate
> > a Quote for remote verification.
> > 
> > Also note that explicit access permissions are not enforced in this
> > driver because the quote and measurements are not a secret. However
> > the access permissions of the device node can be used to set any
> > desired access policy. The udev default is usually root access
> > only.
> 
> The IOCTL vs /sysfs isn't discussed.
> 
> For instance, after rough thinking, why is the IOCTL better than below approach
> using /sysfs?
> 
> echo <REPORTDATA> > /sys/kernel/coco/tdx/attest/reportdata
> cat /sys/kernel/coco/tdx/attest/tdreport
> 
> Each "echo <REPORTDATA>" to '/sys/.../reportdata' triggers the driver to call
> TDCALL to get the TDREPORT, which is available at '/sys/.../tdreport'.
> 
> The benefit of using IOCTL I can think of now is it is perhaps more secure, as
> with IOCTL the REPORTDATA and the TDREPORT is visible to the process which calls
> the IOCTL, while using the /sysfs they are potentially visible to any process. 
> Especially the REPORTDATA, i.e. it can come from attestation service after the
> TD attestation agent sets up a secure connection with it.

James and Dionna answered the nonce question. The kernel could enforce
"nonce || pubkey" where only pubkey is user provided. It's a
contract that the kernel need not enforce, but maybe it should.

As for sysfs and multiple requesters it is indeed awkward especially
with the suggestion that this is not a configure once and done after
establishing a channel with the attestation agent. That said the kernel
gets to pick which use cases it wants to maintain. Lets compare Keys and
sysfs side-by-side with actual code.
