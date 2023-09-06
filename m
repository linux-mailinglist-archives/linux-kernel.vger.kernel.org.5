Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB23F794503
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbjIFVSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjIFVSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:18:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF249C;
        Wed,  6 Sep 2023 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694035113; x=1725571113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hrh6MnTMRYH79ecIVpp5acj9okYIHWs+xrieAzVimug=;
  b=L8LG3Z3NciWMtoog6DTiMlkbSiyHe91oyjEkP2lR8KqDPQNC2u95kThy
   7JYgQHcg7qhjm2jvByK5vCHpq6AYKiqrzqgCCaFOljOi2w2nyGKNw6CCi
   ZQGwqwfRjvTk+esrDgygtkgZHrAvQWCbyaYgYBTQ64ipy9OA0vJeS0XME
   d7xUVOPVfcMUXqYrRclB/PZikQwX0Wyf4wqZ643Icb2GjsLP6/F55OsDE
   SD11C1Px2ALMmXMf4s48TwsflPKqwLwjyr8l/aStnpWWn7C9iPPtIXnT4
   +UmEtb1wW8FxbM07cKPiP46FopjAsqYxhCdDOlX5o5OBXLy/Ph3xOJ+pZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="379896849"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="379896849"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 14:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="884894107"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="884894107"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 14:18:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 14:18:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 14:18:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 14:18:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 14:18:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVRfTjNJHH7objPMS52GJquTmD/m6vyG7zzwkhMSiMc/gC4vXDPhDdHer007BZRDiWozol5l8w9X/fdQRWjuwbTHhJVhWFfeAjVopkR8Szpiz6h2nnD9bXu+E7bxDNltfYpgSJd75I4aahSWfp2zymSkX68ScbYa0KWOeCNJqvrEHdhn3A5z7jK4dWqlHsJ6soazZ8lfEibpGHxivDJEOchSRICW3TVR/VbGhUIdygm1KjTF9QIWKJqKlXXX4DrtDum2tPCI1wBwj+3kw5EoaQzsMVdBzHmvBJWbYCdCe9h20NqQXKuJH76AiN7H0tBAwEOlf1Q9hnuwiyxYhlgYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YunKIhrMnfv0ziiItIYjibEXhd6Bj9PyLBIn4zKIjaQ=;
 b=Udr58noRLyX3jTNLsQNb1zEMZivaG3ycPXRWw69wtXQw+lAxg7mssb5rA2YprfmAWy5R173T2XQc3uJwuS4+4BKW/WNHxCBaUHueNow6CTLRhZthVViTlBKOymbAICJR8JlcFOBl7OltOCQ6umnbpvNsr9cKnps8Ux052oE+tKKdErS9THSSR4aE+5Jh5p/f7J/DePjteWtveO9Sp268BIklbpLws+JWvkttrA3MTb47HxBUUE0z1dWHnnGSCyy2RkEosR5JVZMojD10/p3czG2fyHBl+sK0fy+MtNPRbbhqnxs3dSGn1KlVGCWf2DIUIZuLadsDa41bQNbQKqMurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 21:18:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 21:18:26 +0000
Date:   Wed, 6 Sep 2023 14:18:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 17/18] tools/testing/cxl: Add DC Regions to mock
 mem data
Message-ID: <64f8ec9f3241d_1e8e782941c@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-17-f740c47e7916@intel.com>
 <20230830132037.00005348@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230830132037.00005348@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afc75b4-66da-4339-9f62-08dbaf1ecf45
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CeVh3FTF+CPlBtx/qjIQF/QpVQdWKBSNdeXA+RBZk9G9z+KLN9Y2a4Ta9Hx4mOqGyjNlmEPFkmYpyLADE3zXXOqghkU5VTLucVDWsHcVpntisJCOg2hrEn1RHIcBFzFaTRtxt19y7q/WuDYdeYa/QaXYdCMW0EEnQSjZK8gVxyHNctRpCyKTy8NhSyNMV1W1/3Jf2iuMsWldvftbMw64+ip3gvn7g2SFBKOTN0YIi5t6FtSFRGWAPRT0U2h7rl5X7fhmUz6AcWTyTWudlzerFLidgqEZOP9z20eYjrpuNs8uNMHJNtMUE4zsEwTSfeV5dAQUMkbFxF3UMF04MuSwP9CblBtBRh4tWhSx4h4QgLVxRgpGnhsE9YntmZ9qEoRs2O4nC3eGcYVfnpmV6B11ygYZ8JSgKqUi899/0OXXSYFlK1GnYvp7saJe8mJuNq9hlslJRi3s4ZuG3md7N1R1vohF1VTv62H+8ggjYZ++tlvfX3dQwy/AXHWAxOc5ZaG3WOJYavU0KE6l5AFgcmvzgWITGcmKZYqRS2LY8VGle4Tfoe2galoITCMA9S3YPJJR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(1800799009)(186009)(451199024)(82960400001)(9686003)(6666004)(6486002)(6506007)(86362001)(38100700002)(26005)(2906002)(6512007)(83380400001)(478600001)(110136005)(4326008)(41300700001)(8936002)(8676002)(5660300002)(66476007)(316002)(54906003)(66556008)(44832011)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XxmrJ+9GhUslfB8ZjqZqr65YKZ/VClvsrHeDLH7TCaEf8B2LKoCSoeo3Y+7x?=
 =?us-ascii?Q?tGOpluOYdLS2rQPtJXWsmhko+Cm52QEm/vABjwoHmue1924jQfUFx+ILsPzd?=
 =?us-ascii?Q?86Nbnf9HKfl+rm71Ez8URixG5+mEkFtd8Sm6q9obDcktoCr9D1ACYER1ZXE2?=
 =?us-ascii?Q?ccUE4t2JUu4240+/zCR0alDQLPDQQm+f4qZYPg9+MZHGTHm/0OB9EIeOdqwM?=
 =?us-ascii?Q?LlalslWLQcgII+/IMSV2pA4qwzgYz33cDT2I6hThoZTjUNT5Msxm74XDYFlQ?=
 =?us-ascii?Q?X19E9lLvYDESuPKYb5XZxAjn3kPzJOcKlnq3k1SXmLNSBSRjC+6EhkzZv75y?=
 =?us-ascii?Q?QbS127yjHjyHOb5agCDxSW60VZf7wP0df48brcWusSvcS5IUhBvRhdIfO/c8?=
 =?us-ascii?Q?HkhPrJrPMPr6exk1meNGx3ot5qIBHGRHTqxtrpoOdMLA0/Jhmwrxj727gyT7?=
 =?us-ascii?Q?uCZVJDRGINjRedUmq4Ifnz49lDhIezpv9RqH3V1NjQ+4kDNSXQEIigQaRlQK?=
 =?us-ascii?Q?wBDZcQoeCivoEnsDdevhxZY6FVZdk1OI4IE+s5L/GspQurJVkUFNh1sXqVji?=
 =?us-ascii?Q?5fu6hQX/N/QErtXPZQHB9gIx+wFJidRVMssgJAG2orI0XrfPXsQbvy3qImP2?=
 =?us-ascii?Q?OEZayRQhVANKQwuNrlN/oiThR90W6/dEQh7HEajOC9DiMAlAcM1SCSOuM72e?=
 =?us-ascii?Q?7STUE+OH2fLnpLs39f3bSQGYyGju1iYhnG650iQk0Tn3p91YvQzLsNJ5I6//?=
 =?us-ascii?Q?9+mLUarsepPqiYHDW5Kv+d8xvzU+pKcjJIMgaoD3ybWSSptqk+RgCwGwSnPA?=
 =?us-ascii?Q?2X9PRjDlV+lo9Rq9gn5r6rPPdSWdCVG60CyXob3AhW/Iv+aOehxLiYP/FLdm?=
 =?us-ascii?Q?d6kgH6LXwczAzGzlO/Mexz/UvSK9ajHGvOxlBykpyOL6GNlxDPXJ/NycqFan?=
 =?us-ascii?Q?NQAZhghZvGicxvFOAWHx7osgWfbDq6YAJ6DOGj86QfonJ4i/gR88mfS7lgT8?=
 =?us-ascii?Q?j9lEOMt4w3V83aIFqCcr/OHRO+aDtPqiio+75XfmFUKdKOo0shPDb9+K5++l?=
 =?us-ascii?Q?Zm2Bx3nVo4lIs+iclkTVu/2qqpfz/VqYB40dZV92lFn2p6pUbwj7WwAKioo1?=
 =?us-ascii?Q?r2fuzQ9Cu/eY28ejskLuLAlx9pMYDysqYOqPk/JXSAnJ8yvO4Wu+gQ0eZcTt?=
 =?us-ascii?Q?h++FBdrK8mJ0q9pz4u/5exJ84uJq/wceG3laZ0qakVuYnfCoYQ4ilGFQ7gDl?=
 =?us-ascii?Q?ZyjNnX/vVtsKm35P46vn2dTeLK1ifbitNqcZ/P6tglbLHmBlWmg6N8gi3Jtt?=
 =?us-ascii?Q?hGVuj7wpt5F8IFcnXAcz27NAF30NWJSjejqv6f+VZl42SrUuoKp1sN3Q54+I?=
 =?us-ascii?Q?ghMNXU42Oiugf4UEEmWbxbKuwDMkr+Mm+iT1v3lnFD9BryvvhBPDFLeQy/4k?=
 =?us-ascii?Q?/rYY7wlY88DfpIa6Ns4lLOjUEEUBJX47vlrx5HflFEL8ciBi9OE531GfZL/8?=
 =?us-ascii?Q?yMAp9ffyxA/Cs38J+isKkpYigHox/FhcYPN1MAmQ6Viv4H3DUerNpAZZknog?=
 =?us-ascii?Q?crcwBbSzkbu77Kyfq72KRu6tkE/OpIm9m7Oh9hLb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afc75b4-66da-4339-9f62-08dbaf1ecf45
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 21:18:26.6042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knDD6oUvyBRhK+TfA1jb40O4BCOlnnK7ZP0r2Rcs1HI9J9TIXVcPvMgpd+SZQzbXRjzUl5g138fauOODIW6iFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:21:08 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > To test DC regions the mock memory devices will need to store
> > information about the regions and manage fake extent data.
> > 
> > Define mock_dc_region information within the mock memory data.  Add
> > sysfs entries on the mock device to inject and delete extents.
> > 
> > The inject format is <start>:<length>:<tag>
> > The delete format is <start>
> > 
> > Add DC mailbox commands to the CEL and implement those commands.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Looks fine to me.  Totally trivial comment inline.
> 
> FWIW
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
> > +
> >  static int mock_gsl(struct cxl_mbox_cmd *cmd)
> >  {
> >  	if (cmd->size_out < sizeof(mock_gsl_payload))
> > @@ -1315,6 +1429,148 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
> >  	return -EINVAL;
> >  }
> >  
> 
> Bit inconsistent on whether there are one or two blank lines between functions.

I missed this one in my internal review.  There should be no
inconsistency...  always 1 unless I messed up!  :-D

Thanks,
Ira
