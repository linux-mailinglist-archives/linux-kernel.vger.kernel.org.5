Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAFF76E5B6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjHCKaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjHCKaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:30:23 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084A9211E;
        Thu,  3 Aug 2023 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691058623; x=1722594623;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wUOrzPuQNyPoyunb8QgHpza+TDckszmU8J98EMridjM=;
  b=KYADSan5HlINCdmOkoNAPY4yLO10FJpGBYy1JLBz4MgSLLkDdmJ8ccGj
   mfTMslPQAQ3MEd+uewFDbwC5M2J2KBQCXNTTsghWi4+ToyJjaXJ5MGDLs
   zJhAui3XoZI/HwmvWn6rISrnyYRHTvnoEOcrGAuUgCXVezsuq4Wl9CuLg
   OYLBZ206jWHeSjR8VrjH1Qn0jfM2CvQMoWzu6uOrwCuPSU6pkDuUk4hIY
   Hp1GoYlwzwavZlUPJ3ujwnQxGOxoCMMjtm2h7S3RjQ7w0yxmbH5cvH0UK
   BqCmjtr/v9tmJIQ5uPCPSdTouoqn8/YnogZkrHbP5Puyq6JgrkW5Nw0/8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350129234"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="350129234"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 03:30:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729514972"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="729514972"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 03 Aug 2023 03:30:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 03:30:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 03:30:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 03:30:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 03:30:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtJE/hKNZWjLWQmkwgy4q0DnT74gSMvT09NsY0t0q/ffSl1QhsUxm/ED7Mo66y9x6JiIJ+TghTKEvmyP9WVGT06H78GWZbxCZm6Rw5SMO/7B787yepPyTqE3Hx0kUiVi0Jbb4efJL4coQT2B1oywSzGGoVd1uhQ9FUiiIF3NGPk5iyVBQ/ACUFrusm4j3zXDRxOMLtdtk7rYToH6g3u4Li6kuf8L9NuXr94I8lzIJvj/ND/9wSdDGSQDRNJ7G4Ql94YMpWlwDA+ffPaF9Ca8+SrBiAoe2BZIVu/v3BKPju2NBPexqwWKO24NE232O8ppEt2rNGNmUKPFmtOMmR8tKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVk2R4zQDwrxXvWRgnNwwZsbLsnf3ESIQPTqBvfcr3U=;
 b=i85/P0vEMPavpFkEn0NzYWbacqcSgtQBpXJ04m5EM0lV4TUsJW7X3HP+797FUq9bSlffSQMEU74nP1qGh3A9+k1wmA86LjvQjlkZxe13Etp4O+fS+Go8S/UMJzScsCiUAI1fymw/h4QnNLOi6KvbKuBqX3FrK6UXdk2Ov9h0qzP107kckgxf0JfuZW/y9abvBrUSxSh537McJ7vZHKr2GpqHVBe9HuV/1LDCqFHGcnC9jorzfyy1JrRPu1a7LsbwnwTgj8JnBNPEw67PFbUfgsNWEALw9QvfKsoFAFxxJCm4FVjOOai6vRRRsEM/hb+8S95O6Pa2tm8GwFpXklP62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DM4PR11MB5470.namprd11.prod.outlook.com (2603:10b6:5:39c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 10:30:15 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 10:30:15 +0000
Date:   Thu, 3 Aug 2023 11:29:58 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Haren Myneni <haren@us.ibm.com>,
        Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Richard Weinberger <richard@nod.at>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        qat-linux <qat-linux@intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH 01/21] crypto: scomp - Revert "add support for
 deflate rfc1950 (zlib)"
Message-ID: <ZMuBpm2No70LqgZI@gcabiddu-mobl1.ger.corp.intel.com>
References: <20230718125847.3869700-1-ardb@kernel.org>
 <20230718125847.3869700-2-ardb@kernel.org>
 <ZMt4nkfpdCXxAkr5@gcabiddu-mobl1.ger.corp.intel.com>
 <CAMj1kXGn70sGAHgOttKkC6n6jfVZ9Y61NZ9ffLmJV8MK2Kh8nQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMj1kXGn70sGAHgOttKkC6n6jfVZ9Y61NZ9ffLmJV8MK2Kh8nQ@mail.gmail.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|DM4PR11MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: f5644f60-862d-4ab8-cf5d-08db940ca069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVAapvwTty3Y5x9A5HPOXg+hBOQjNW5QbdPCLuq7MhWzmq/GuZCsFWL2iUwxSzBHiltHoml5W1fH22Q7dxDqZup6fuYYv2ImOG2Y9e/n8pCNTbVUJwiKYDW/j1A3/suR1TY6vgJU4gKX4ET/N+bRehTPIlt9LZEUV5EO90z78dLIUfdxWJq1Sn6DRRVME3mE8JkCLaP1wTGlnfb1ylS3vO5YzXXed8zN9SQvxkbZ8gAXZE04At1LCIj+kXNI76IGdcyMOLCrEBBTtJiwHyyBgze0UaqaV5J3RlcKqceVoImtIRUX8DndkxdmED3s587bK1iKJ768UwRXPuyWwaofmOPSvEeJO0v7pAPhMi1BnhKj07Np1/N9JqQGiZ1AFrzMK8Ezp0MlgWUzXQ0kkbGFX0sjOQx5H2KbpXJLj9aMif+rTyR2YCqvMgW/dT8nf2plgrSXIna1pMQjTwP2VrJZDMEeBEBg99BoYTmi3WtKYTh1tOpZ82LtLIVJYZ0HrisUQYVW7fUyaEwmTrNbp9ssQmAhNx+hcIFSsXZ/mvRkKzT9vq+p0Q1t/P1s0HI/Fg7o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(36916002)(6666004)(6486002)(6512007)(41300700001)(38100700002)(82960400001)(6916009)(66476007)(66556008)(4326008)(66946007)(316002)(54906003)(478600001)(5660300002)(26005)(186003)(6506007)(8936002)(8676002)(7416002)(86362001)(4744005)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/SaLdTM+a8wA9jvBsM/zFvBk9UPJzIDXLR5Woi8hMriMpXSnjAy+6qe5ooq2?=
 =?us-ascii?Q?i01lptc3BnbCSruWaqAYBo2tThD+WrX5xtb7EIbPgs3YUDfBAZ3ZHO+Se1KX?=
 =?us-ascii?Q?5ugnSzvAsKlZZK8paP3bu1MzAF+f2lXupiZVss8nbh3HNTEl4ISuCFV2pDhC?=
 =?us-ascii?Q?c9D5qGFfhJ8vVFT1dBT9uXuP0sLAUDWfBEUy+CFxfdw9XYRKVgsi08EigBwt?=
 =?us-ascii?Q?+oi2tKtUmzTtXtN6ara9JyqT6mSV5wQ07lFneJ6Y2Xjq3DQvZNRjHOVKH6al?=
 =?us-ascii?Q?Yv0dgA8UeJJ/Ii5iHLBXhgfnvPHZNlDwBWv19Ep6h8ZRGkh3wsCfBynk9bCd?=
 =?us-ascii?Q?QAahWpb2j99ljZcAvgyK1Q8WMK9JhIblx2LHXKU2YF/luQjJz9KIySFXrXGI?=
 =?us-ascii?Q?9hBLFGwLX3mCbm8hTw9q/d4/Ak1wDU8KPiV/qKhhiVLKYO9TUceT4i5plcJS?=
 =?us-ascii?Q?Y2lbpvg8UVRuq286gwIcKAX7fTPK0xx82spLtu7umqWh70ljzHJK5ukowt2n?=
 =?us-ascii?Q?RoamfIG/rZY+b9PNItgxcdScAwhcT3uK/VbRG8OkIXmLepyCcUWA8En5wO8e?=
 =?us-ascii?Q?ov2vNnE3gkWm/RbMeUrmMCfpaY70AWwPJjc9S5hjlIyVKpaYyk7MyjMeHj8N?=
 =?us-ascii?Q?zBcs7zxmuwYgwn2Ny/ZePB6+2oyDYcWVaYZNBQvOXvMSe1KPUL+VsrZFtKrT?=
 =?us-ascii?Q?o2ECzDKVyr/0SYF/vCSqzfR1eq/eZEYkPllVSp5JF46dJT+ncJW7GrZ9hyFS?=
 =?us-ascii?Q?7mxJsQPdiCRKGl1lFhzCsHW4K69W6JIr1Zyy/7kZc0ZSZ5cpz04j2y3o+ROA?=
 =?us-ascii?Q?Hh7yKLH33MIbSCtxNF8n80x2tG1KOiHmNyrqux97YYfLJD141pICajOCJohD?=
 =?us-ascii?Q?wbkWLTn2NiLL4qRom0oKvlNI9cuBTapqlyxD4NdtuCobw0YXuQlp61KAsPsI?=
 =?us-ascii?Q?9MK6nSgHD96EzkCN1JcftpfwPCTvMx6sq+tZ6Qbqb1Exq5AD0Z4X07H6+SgX?=
 =?us-ascii?Q?juE2p1m2AuwuXH7xA/4asZuJXnXRpc2K5o41wK/iJT27ZLqi59g60Uhw+h2W?=
 =?us-ascii?Q?IcB7KwZjhAHbKYmZbzRYRbuVEXiO1m5VWPa5X8sZgrzPBKcANfrbhJ1mz4BN?=
 =?us-ascii?Q?0nm2mZBPz9TzgQ+rZcvfHuSfUAOqLh908rI1wF8EsWVGRx3nvMGrfndMTEbQ?=
 =?us-ascii?Q?qNvVcuDECcsYwtzD/t6+GSvzIj9ZzU5UuVsX+Ypuj8WwDMPxDOjsi3zA+IMv?=
 =?us-ascii?Q?BPxUjnq6JdwovOSQiMdlpk+Qy9yjw5pJ/0zDdH+TWgRUKUieiYhsmsaLGhZs?=
 =?us-ascii?Q?7DU/QmC60AQoDFbTBgzFsKNwYjWvTASoAqoxiERczKe7OnMwQCXfmJBqZj7L?=
 =?us-ascii?Q?Y0bOzc7HWBHg92qnjzqX2DFLwWhN/zm1z4yZvmMhYJAWcOACdQmDvLk7TYIk?=
 =?us-ascii?Q?5RkAH6D0UazcOhxlUbwdM2somSy7HTLb8Q0tTKklllSVM0m/ADiUAOfxoDJi?=
 =?us-ascii?Q?fMG3oZ5ZZeUZmciz4wxGWQzpC0Lvpws2bom/5d31vC8QM1PPjHqaK9zZebT6?=
 =?us-ascii?Q?Cw88qeEtePr/idGjSji7c2qhsDbv86EPB1ZwQaxY2EWYRCc6uHrEm6CNkDde?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5644f60-862d-4ab8-cf5d-08db940ca069
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 10:30:15.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wC7Wmp/4s4q/YDb+xMBiQnhtPz4UklCuliYVrVuaTIpwGSuJHj1AvSl6OTVgWKAS9+FUytYOijSL0x0Uli5A++G1qevIrT+vgMqA43IDnNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5470
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:59:00AM +0200, Ard Biesheuvel wrote:
> Any clue why zlib_deflate was chosen in this case?
I believe it was done for integrity.
The output of zlib_deflate is raw deflate with an header and a footer
defined in rfc1950. The footer contains a checksum which gets
calculated over the uncompressed data during compression and checked
after decompression.

-- 
Giovanni
