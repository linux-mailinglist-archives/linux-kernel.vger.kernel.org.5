Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3467277E4D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbjHPPNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344093AbjHPPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:13:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58EA1B4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692198804; x=1723734804;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QzNlwZg4oU2xbbbH+8dn28oOop/UNFkYFG4ecij/gec=;
  b=KqsO4suYo+0xeLaA9AJeW8FVHape6p9MByx5n2YydJhq24sMT1ZAtpjY
   szFLsPMBQysvltZUO62iT+6vogRJhUbkmVzRY37sHZHpeql8q8kwbZxzG
   3lX6GYI0aWxJ+TMofcJLONBKG/VKoz33byTdo8oChdFOcqY5J6O51ayP6
   0a0JDch6OqH0gIobFnBmb0fycOn/AUvrwQ/bofVXbg1kQAFr4Et7yxNwz
   ahqSFK5fsVH0CaTeJXwKZ3d19rQrrP2ofjO9JlMJ+jTgcrIUZVhYJf+mc
   eWv/BLFcze0BtImzmpWGAh1WwPi7xl52iymtsg8sKEhjml4U8zGxkzUyW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="370031268"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="370031268"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 08:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848519124"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="848519124"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 08:13:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 08:13:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 08:13:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 08:13:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 08:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfNNLJCMVo/yY+IFJx7WTQjpNDKhlON4pBjPH7Zdp69vhfFuM2uXhRr6GCt4Nj96fGWBqg9YTIozFAV2MqY562t6uNa6SwZ09B2FavA6JqjVf1ixnUyoyHGspCwVCmwK1RF3KBSIgyUc2QfEbgkx+WJys3LQNUlwzh3HUy98mRg7A+fsQ97hoqGJS0Y67EYJv996qkqS8m3+6YrxU2wFfpxyi+9HRuX25Ndpod2yxus2KZFWY2FKpUNiDQMh1r/rpo1yItNT9ai1F8Yovf4mvOxoPK/j56fL9lOO3SDAXDki/U3t0bZOax4OT6w2gm0ExkZmoA7obpzxSk4IbwbzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaCPBq+ellgdShAd6Ti+5UBxAugEnoVqXuP2CtIZE+Y=;
 b=K+vO7SCdt4QdZM+CC4IwCdSOZ/1VMjjGrdptcuGiTG2actzwfunggNywxR22mwzSwqhum1XSh1Qvqp4Z01vIETmY+Lk6SO5B1oStmqOvAqxJWnOV4mGwkW9m4Hq1TUzRnU2gY8GQMvAIpZIr3V5eYgNwYmgnJD4W5IdtVEysRUyQmpLtfDYF1J+BLm2jmeBMBFu+p8sby0uj9bw8pjMy+Z0Lx83YQ8TbpAYPl+g7AaDwtoHjinNEZaDAw3X9MHkdSm2InCUAn76DC4yFi1uzwmvg+ICIl1gBegawqWQPOd5PhIUE5jrb/IQ075D33Lmd3+OrBz0l1U8Z+o1sw1XGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4751.namprd11.prod.outlook.com (2603:10b6:806:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 15:12:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 15:12:59 +0000
Date:   Wed, 16 Aug 2023 08:12:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>
CC:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, <peterz@infradead.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] tsm: Introduce a shared ABI for attestation
 reports
Message-ID: <64dce778240af_5ea6e29419@dwillia2-xfh.jf.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
 <7fada981-bc73-774e-bff3-e9be56c52b66@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7fada981-bc73-774e-bff3-e9be56c52b66@amd.com>
X-ClientProxiedBy: MW4PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:303:b6::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4751:EE_
X-MS-Office365-Filtering-Correlation-Id: 035dd71b-c0d4-442a-011c-08db9e6b46e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWPzyHYp7ln7I8h6k72J+2HwEHtfNhMuhlHEyD7F9MavgPHSyHDpb2CvHVF3vCK1j1BaeZVJ8u+XFtwZdhc4iGpDfDe35aq0+7oURj8bxb2QIFAoVXylqqtXv8aNWghruGL8itjoAApstgRU3+KphmVUkoyHLf1P9pXhDeNBrh8Kgx4XlRNJgPyjsC+gjE3dB5cbV474ExhNVPnc56wriYGbELO2NbyUOz1In03vuvR/hOkh2QENxkTRbAy3WUHKyLXYZvqAUJcsWctdQy7SlTTNvEZiqQANc+0ktAkATjn020v409ze/Yb1ONcMQX/HvfapSUKO0AhkWsoKohCg3RYW/yyX6JCFI3i6UeKkKaBahQo8nBpnd76gzFNl/Ekh49iT2N6MtH5xHTKhk97oMcj0sJEzc6ylLyOqGHl7pRnpS/jmN9y8gUwyS1qzsKwOPAiMAoO4SLGZhmqEVWXoGfqj+l3scoLa1Pzgo8cNygFtVspud88weDFz+ILEDLUqayJU8PmJAFwj8COBdGRLLyHpat47sIpDmhLMvfgHgpFlttWt0otefoWIL0r8ycv9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(8676002)(4326008)(8936002)(82960400001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(9686003)(6512007)(6506007)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+n8wL3mfiLr+2Z+8VlhnesO8qlraIdKiEi9e9XmXCrFPWqieDAyWI61o6BrJ?=
 =?us-ascii?Q?D5QDRJKnx8BeQhRI34wyA4VSGrk2ct7Es/uQuHgENAZFATMwMydswcb2TplB?=
 =?us-ascii?Q?1xVkYJWScD0xr7xS9UyHYM/1LR5oM3CfKhDO/Kb9ZgyRw3+A0FrbM47x0Zpe?=
 =?us-ascii?Q?HWYc1zPK9cFMuDr3q2FTWGWBnf4MnL97jnZZkyiQX2p+pvKMQq4ozpZEqJe+?=
 =?us-ascii?Q?/fu7Bchuk81TQfyZvrZwC2t+J+KGn7GFS24EuC9q1WPQJdp2TEFdKaB1l2hc?=
 =?us-ascii?Q?4OpaLDe4lWlWRubAuE98fblOzi3xyC8Wv2T2HHIhJdWBEdJL0KtigK6lU1p7?=
 =?us-ascii?Q?oxgW8Lkj62ce5EUO/RJcGOYTiNgsq9h1VrVPskFOV/DILEQBQMRqOPbrVQgj?=
 =?us-ascii?Q?n2wGJesndaMUNjflVpxDISSSOlDhP2y8GY/PJxIXqN1DBNca9ik36Z5D4X0h?=
 =?us-ascii?Q?jXiY3uOeWxc9mLWzlavFLTGuLvoAccFmDi+PGEWZok+0vj9qlrui4BO75oyG?=
 =?us-ascii?Q?4BSDvxYMRHRNnMWAaa86FZr3V6XE5XIw02Ti6IDLjAZhvlTpp3hi8E00+ur8?=
 =?us-ascii?Q?djj3A4gpGcSXR1mH8Bo8wrE4jCIzUNwHBOtlZI5TKNhvjE5SgKUhsOdwgPTQ?=
 =?us-ascii?Q?uGxzPQIUIX2l9Bc6fPWRRz///wnXnHJKoteaCkr4S2NHcqvT8pWD+IwKxMdb?=
 =?us-ascii?Q?tAiR8p45WjznSjuSx9o9jFoqHnJCkDfPZXrFMqETyt4kiQuX7OzJh1WBiTT7?=
 =?us-ascii?Q?ELDkSOt4THTXmbbbOX0Vm3jfbtQ5CmwnBy4dmpN5mNLLAaeBGOmXRwsiRAQR?=
 =?us-ascii?Q?1/N0uRdYn22ecJx+0ycsI9G94M+KOzIcqcrsfgpwzloH/31jOgoFq41ZqWX8?=
 =?us-ascii?Q?ajouCjLkRDx4VZu26AFlF8tPT4VawjFWIuj28lrGGxX0O0AvB/kLbnWxXcWf?=
 =?us-ascii?Q?OCHM5uc//usmPZlp2pVn/t/LWZ5jTPrP+oIWyYYkOj/3O4fDbrwtEDNRz9+K?=
 =?us-ascii?Q?HfGxvFiY7ZeIkS71F+O/diX7EhF9CYFXXcm9tFqyDzp/Bk6BhNy9ted2rlC9?=
 =?us-ascii?Q?azzWDe046VGTZhR50/G3BV+/tV7mNM2SqFsWJB362gjpUXizpI54CPRHokzD?=
 =?us-ascii?Q?c8Oor8Ev2e4vl6uygiIy8+OSy1PcVe/1wfYokUd6VFrPaaFws+ujdM6wcbdB?=
 =?us-ascii?Q?4s1gwF+MFpEGncmOqr0m75CknjwmqH8H92NqGoKtdnGWSqlxVICKwhdwXgbu?=
 =?us-ascii?Q?gwRU0jNpiTDN4T2fcPoRiulUGdgY5zazovmuagujqF/FGIXZD5h2o+NrZOHr?=
 =?us-ascii?Q?ojeY1abzPWy1jyeSMthFMZgzYOv4guTJbHm16Mfusmvh7ahWye3Nvgdqhdn7?=
 =?us-ascii?Q?FAm+AHoRo0gz1Ha8AGLjYmaQ1B1WtP4IsGO/QdsT8vb2iavVDcB8mu4tALDn?=
 =?us-ascii?Q?cjibLrxDthYECbMqd9WoSztcf/KZKZeV5pHKFip+qY7/ubXh5BCg6+eYU2nM?=
 =?us-ascii?Q?3aZJNnSDbWw81UhiCqiFapIDZMfdQOp26k8tmGyRfYVp5SfGlrCx2GBiajeF?=
 =?us-ascii?Q?2EyyxTDbJk/d0AqZp1fTq+uPWKmXcOuq8DjWG99z8GDQnxGVlc36uLJ/aKU1?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 035dd71b-c0d4-442a-011c-08db9e6b46e1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:12:59.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGpS5fzntiozdzxLBWRKyvt11fYiDInmF1RswuGW4jIA9lefKQhaaE3zg4UzYeSZwjMR7NM1XLi/BljTiVhK/yqNPfqPukOteNNPDh0t94o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4751
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Lendacky wrote:
> > +static ssize_t privlevel_store(struct device *dev,
> > +			       struct device_attribute *attr, const char *buf,
> > +			       size_t len)
> > +{
> > +	unsigned int val;
> > +	int rc;
> > +
> > +	rc = kstrtouint(buf, 0, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	guard(rwsem_write)(&tsm_rwsem);
> > +	if (tsm_report.desc.privlevel == val)
> > +		return len;
> > +	tsm_report.desc.privlevel = val;
> > +	tsm_report.write_generation++;
> 
> So I'm wondering if this use of write_generation helps or not. Since it 
> isn't incremented if the levels are the same, that might present race 
> conditions.
> 
> What if user A requests vmpl 2 and privlevel is already 2, then 
> write_generation is not incremented. But before user A can read back the 
> generation value user B can request vmpl 3 and cause write_generation to 
> be incremented.
> 
> This may not be a problem for VMPL, since that can be checked in the 
> returned attestation report, but it could be for the report format. If the 
> extended format is requested but changed to default, then the additional 
> certs might not be returned and the guest may think there aren't any...?
> 
> Maybe incrementing the write_generation no matter what is best.

True, and good eye. If write_generation does not always increment once
per write there is no way to assume the state of the parameters. Will
fix.
