Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7818177BEAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjHNRMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjHNRMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:12:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95594E63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692033139; x=1723569139;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gAo2Mhiyy3CMlyHWRj+iWUhicUdt0+bV1lGGTLk7JtI=;
  b=YrUga5aZJtFo7YVndpjxT4QBcBqrMOxk6xkhDFafiO86DJiB6Dubaqop
   Uf1MMuDKoXfe6r/J3vu+QwKkAH+fkG7wLTT4AFMuleEMgwZvCbzNju/30
   iqWMBPzh/iftzEhFcesP1/lut3ESAxHYs21fDapjR48nnsXhUCgjl71S+
   buNOJyz7n9Q38D6gWmZ6iScGOtjH+80RWf89rIBaIbe05nV0bnju5GVnK
   vkR1ylDrHtA8NQVsIN3hp0yo105boN52xZJgxrW3TQN3mRMtej+64PflE
   6YXlXauefA3PsIN6ig4GhR1UPcMKPVJj1+froibgZsciVcRD8KkEHolMi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="370993418"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="370993418"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 10:12:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="710406179"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="710406179"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2023 10:12:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:12:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 10:12:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 10:12:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 10:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKNFxb78awipLJ+4Y9OlpAtDYMfB73o3s52hNLeXM24xeW97W/dFRPPZqh6zEZaTiKXUCO3ejnJdw00xhHVioStA3K957r42KvFcjpaQZ7p1v7ZUArifUnhGDfZTFN1xXy0fAnzdvDKtpoJHaBP1rb5Nc+QAECSUmhf83N3mFM57RweLUv3I8rLwq9YQ+uDOuhHcYmjGhgmxwDX3GZyxhVk6GUC1lddlEA1J7vsjXuf0M8CG5VNGkj4mK06QkxoG8xDzyTK+EFpKPGPCqsjycXaGMkTNp+TWbSDyVqMfeqA3JIMGqSDDHExp/yYIHdRw6nw0Ppaulm6SW4DMniFbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qI8FxvpitcIO0vxgqIfcFhrR7qPbYWzr36ExG0KFRY=;
 b=d1MfoGNJufdWdypV8EDgoIfJ74h17KN20g2S0aMAjTJFRBdcNfLz+5vM4ZzrDVLLuxR1YTJk640ZgwWMex9I9GVl9zSzvFn3a5I3ljnyX6gSxp2lZD4Dtvnz/5CUrGu1BrKKA6IwqeTvSRIWvKtaIZX73PVvhhia6iZAQyaGSGPq2+yasaUZJATxw85CWP9ffqOGe48oGKEZUZk5IS+7MbtW3WJ4fCpCfjOidc6b0EnF9Byo5bT9DxffvIjCgRRwoKhcqywkmI0JDmc9Y0Tdhp0qAKDzhivwUjanamPgs7XtSZfi8nbAZRYhNlsjHnd2jdHEqF6mjjqK0uDr4xeqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4733.namprd11.prod.outlook.com (2603:10b6:806:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 17:12:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 17:12:14 +0000
Date:   Mon, 14 Aug 2023 10:12:11 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>
CC:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] tsm: Attestation Report ABI
Message-ID: <64da606b171cc_2138e29484@dwillia2-xfh.jf.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com>
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4733:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fff46a-05d8-4cce-aa1c-08db9ce99af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rM6RZN6T4oJ+0Rmc4acGG4cMzW/WLLr/TuFhszCS7nFIDInlc0DxZVNhZlbmx9yDZNQShKvtWkz1SFac2yNgl+U+ysbJN3W3UqAEOv56X0BZefRoqyIpdi9PXI5GHskDeMcIrE6+mWqBC1SwzRwtJtY8uL6cwebIvWbP5VtbDIac79s8eEVgdxbcMqyGCylZKpzudB5r/+BPrDmlI0AU6/RMg/kCzfHjA6hMooYqGEAM5gyCIacuphyg06+O8ffEGtmwO489ZIVjaJyAMabQCvGOIyeDIiIMFmgTcollREYa2dst7m0b6lCIAawW1TdSCv/vWzNv/YBB9h2uQLAO200KTgtsmx7VuH3ZFwikx8UpLeDpjTbrn8Di8LOtA1Up9Iud3zSR9uH4jt0XdfUB7pisYnUpM2ekGW2HnWC5qrYu2vKvoc5eJk/y16N3GgvriJjzvU3Ekpsqk4B1Jf1uT9c+klGn3mwyeVPJ59F2+Z1V1X698TACmWt0egcByYAvH4xfQl6lNISwHUDBq2owtKY1FPIoGtSsB1oQ6GFZ9fbi3bjQ0waCFFSnEGeBRhIt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(1800799006)(186006)(66899021)(6666004)(6486002)(110136005)(6506007)(478600001)(82960400001)(86362001)(83380400001)(9686003)(7416002)(6512007)(26005)(66946007)(53546011)(2906002)(38100700002)(316002)(4326008)(66476007)(8676002)(66556008)(54906003)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mMfBS0ecTRwGYywMXFHZMYr5sw95IX9TE3EKopp7td1Cke9JJvOuNIAaKd3p?=
 =?us-ascii?Q?yj2cDPvtb+dtaYFEGhnOvSbG5hJ5blVwzPWfx/P0NktoBy88T8WkoQ1yTX8E?=
 =?us-ascii?Q?mLD2+TBUSqBz7drEx9ZavSn9coEdzXFt8rkf3jRx3SAipxKKMkBkCy0NyHm0?=
 =?us-ascii?Q?5TX1t4+vteZLz9hCbVGKHraIoV7nsTQ9Z7qK+uVw/JEv7zVv4OON4drdGsc1?=
 =?us-ascii?Q?DiXxXLu1sFDfQKWmMQO8tkerj2fMUhp2byvvQ0dflZuJc5nHu64VQdgKJNGG?=
 =?us-ascii?Q?NtIP8qD/4B3JSjuxZOV52reH+kribWNUGQ0XBTMgDuFqwyLHgQJ76HUJgyU2?=
 =?us-ascii?Q?3uwhwi46twgAIC3xGgWUP0C+g1zTH2dP/AbAWrpFZQFzr7+3VQ/QYvb5/cll?=
 =?us-ascii?Q?ec0j2+Ow5WvGLVg6TTdvseqnwy1u/6DEZDzKg9iRjr0VIBxYoJbxwA5KDap+?=
 =?us-ascii?Q?yQZmnorU5L/nsb9mpgcH7Fb6KYUeCRdhh6+ErxULhc9HiZboqejTQJlW9pnw?=
 =?us-ascii?Q?p16qhnbg+euuMrF1N1EJwRCikJJD6H8TyZAs/4vDfL5Z8V6qd7119ME3LCIB?=
 =?us-ascii?Q?Cb4S9Ua1OE3v+bcClF44nVB3ZhDsMJh7jO52fcOFIRivpd7Dj9CWX5zJ5e4H?=
 =?us-ascii?Q?h9iDBfQt5PMQGEUYjT5LT4E8HGmvjCm99Ha6OwAg+44Amg6XgSsn/zUwvEUc?=
 =?us-ascii?Q?thXMYfvNBWjmObTozeHe7X+qIImf3/xwf9ODBD50ysxWO2thHSdjDH624LIW?=
 =?us-ascii?Q?tequIWMSHjVhNut9JMr4iSZNXjrCJcgfKTC2ROcR2TqVyK0XI5/U125s7Von?=
 =?us-ascii?Q?DMaV+xxdNNjJ0lmr8WLeWCooyIHWIO3DKlPcIgDy7stQTqJKGHGkWAB5e98Z?=
 =?us-ascii?Q?zNdBQSEdjt5JO55maBX/06UBk88bSBhMG8y8cy6PIkaVUqH2QEijFkhn9oZY?=
 =?us-ascii?Q?Yu2yn/tz1CdfAKx3bhMPWTADzs8y7ko4cruLTuKn6mscikDGCjSusvu6fvWK?=
 =?us-ascii?Q?DoziSmKyZHqa5vEkvUkPkJwJR2r2kZtfco1W67YgHWqicD3CRf5uqAfZMQXZ?=
 =?us-ascii?Q?pdaBAmmKpMM+Bm5b1Rr+v9mbL3NNqBFj3y3EMFR/F/yp64meeK6cSLzzhWGg?=
 =?us-ascii?Q?v02HEBgNvLTnUkHlroXm5B2D66XQQ9Ali/IhjdoPaYVbUcamv9JfSm7LlNek?=
 =?us-ascii?Q?Pli62pqcALwlEDI4mqAf8kAfVylHo7yEIZQFRJE6XfwQ9ADFsP3FuaEXF1UY?=
 =?us-ascii?Q?jBSRA7VNF/rm7co2XgOO2m4B697QRAKt1V46jvmxtTmCZIqyUelMk25iGL9e?=
 =?us-ascii?Q?cn+rxwI6AX+sEQF2UpQ/BZ7194tH+5ZoLyr0YMTLy2hQLJYh0wVlvljlvGMI?=
 =?us-ascii?Q?oR9w0hA16LiAZQx1wpej7WTET0ivF7jSl6WrRnPi2qRRnPCaXqA4Vpr8kgaq?=
 =?us-ascii?Q?FHw6f260OhyoKFi5/EG2rSEUOhZS/PYh+lMMVpYcgpdywIsGYmZ98leWXBfr?=
 =?us-ascii?Q?c6B3+RTx/TJ0/4BSSI6OrZyJH03g0r4H1Su4dBiXMXbpdM+A0Tv3qpz7tlK+?=
 =?us-ascii?Q?u3npmyE2qAF7qd4XTW+DrbprjOuwtOpM+Viy2w/5adirEbyvKm8bNue378uK?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fff46a-05d8-4cce-aa1c-08db9ce99af8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:12:14.8377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7N40hk2tG+Xr0NogI1eU8W74cjugqLKOZZKqb3Nmt/ZxC+eQVhwaE6abwCcps3Dp0sm+tgGUvUY34wGSFwgBss+WZoaoktder4adTNOb2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4733
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremi Piotrowski wrote:
> On 8/14/2023 9:43 AM, Dan Williams wrote:
> > Changes since v1:
> > - Switch from Keyring to sysfs (James)
> > 
> > An attestation report is signed evidence of how a Trusted Virtual
> > Machine (TVM) was launched and its current state. A verifying party uses
> > the report to make judgements of the confidentiality and integrity of
> > that execution environment. Upon successful attestation the verifying
> > party may, for example, proceed to deploy secrets to the TVM to carry
> > out a workload. Multiple confidential computing platforms share this
> > similar flow.
> > 
> > The approach of adding adding new char devs and new ioctls, for what
> > amounts to the same logical functionality with minor formatting
> > differences across vendors [1], is untenable. Common concepts and the
> > community benefit from common infrastructure.
> > 
> > Use sysfs for this facility for maintainability compared to ioctl(). The
> > expectation is that this interface is a boot time, configure once, get
> > report, and done flow. I.e. not something that receives ongoing
> > transactions at runtime. However, runtime retrieval is not precluded and
> > a mechanism to detect potential configuration conflicts from
> > multiple-threads using this interface is included.
> > 
> 
> I wanted to speak up to say that this does not align with the needs we have
> in the Confidential Containers project. We want to be able to perform attestation
> not just once during boot but during the lifecycle of the confidential VM. We
> may need to fetch a fresh attestation report from a trusted agent but also from
> arbitrary applications running in containers.
> 
> The trusted agent might need attestation when launching a new container from an
> encrypted container image or when a new secret is being added to the VM - both
> of these events may happen at any time (also when containerized applications
> are already executing).
> 
> Container applications have their own uses for attestation, such as when they need
> to fetch keys required to decrypt payloads. We also have things like performing
> attestation when establishing a TLS or ssh connection to provide an attested e2e
> encrypted communication channel.

...and you expect that the boot time attestation becomes invalidated
later at run time such that ongoing round trips to the TSM are needed? I
am looking at "Table 21. ATTESTATION_REPORT Structure" for example and
not seeing data there that changes from one request to the next. Runtime
validation likely looks more like the vTPM use case with PCRs. That will
leverage the existing / common TPM ABI.

> I don't think sysfs is suitable for such concurrent transactions. Also if you think
> about exposing the sysfs interface to an application in a container, this requires
> bind mounting rw part of the sysfs tree into the mount namespace - not ideal.

sysfs is not suitable for concurrent transactions. The container would
need to have an alternate path to request that the singleton owner of
the interface generate new reports, or use the boot time attestation to
derive per container communication sessions to the attestation agent.
