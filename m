Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4504680143F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjLAUXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAUXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:23:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE7CA0;
        Fri,  1 Dec 2023 12:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701462191; x=1732998191;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=u+iga/4EPvYhwn5qXjCd8T0f+Aw22bj3lpjTt69PT0s=;
  b=gnTmPEYHVOxvSNg5AqCcOQ5PsxFXzVx+Tjh6YAiLCugtnb0yKjGTZE52
   ZHiqsTkJi5zCrZjjm27pZg6LvK3nQrF0GLQHcgmBROYw39S8uEQ/XMbe8
   o1thh43G1idDnYqd3v0GWelveDZDi+pgqvKvczO+WwiOcrB+1V1KxpY8E
   S1AZejLN0+edI3UAuBlJItMuVkVWuZTkK4ZcTKO/ExY0e+gF5XnpRBe2y
   XOkzx1r0TVsKler+pCjvEhM245tG8ao3b+40Qe/XHVJKNKXIlf8hAoWUA
   UN4UeghkgpEBdvFt4tutjgCSihhJ2ELgBQC6b3KiBE+gYebssN27FiLqK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="372938440"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="372938440"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 12:23:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="1017142904"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="1017142904"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 12:23:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 12:23:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 12:23:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 12:23:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 12:23:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWomWXfQ4Dr+qnAINBdQ7yDmeZ0TbDQqHwR+HVtyyZWEGfnWbFVSGxzFwYgxCu+fApIPd18ZtgFtEd/08eOKbYIyVKRQ+LEbE9vZwm6Y25V2goKSFqvxO0w9uipHMncC9RdZrwQ2NqbfPeksLk4jaF+LbOLcD9HqwiK9iZrT7z2gG26aY5pD6MW6Zc5LodOlBL7QplSXwdNzXttyYgFZduhpwYqI+t8+YDj7EUIA/Fd4pMjQWibS2t6390+dsVf0vD8Iwt6NdjSzVPrTrdYuBkTRt64aupyXy0OCEOWcCY109bI86q5oXGZG+O87LebxYsa+BsgGbwSAVN6zoCv0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Tt0XXk7DnRNDtKTXal77H+zLZq5hUai+XP94nF/a+w=;
 b=Gwjouu9y/Apv2Y56FXuNMYsDoimU3nW0m35YWvFS2AbE+oeIG6pNr2jSxU+dzj5va5nZNPO9cxzZLoFt5QIWmQqLRjBUwQyRx3tUUTGCcD4WAd1Rj2bsW84N7MuSqUjKTItz0iExC/dixETuWE/GUmpqzLTu7iwb5HBnmrPjrjBCb0YtIhi2/J8qfxSdW3U6g9Z1B/oqH/xK+iRbOA4JXWAxfTX5dfzSlmjKULWV7F3N2B/hFd31OEjS9MHVED2UktagkC107Xvjdf2KFtD0acgXec2qrY1i+PpZhqls49ARmCvTID8d3J7SEFZTEO1C6NwrDP71hveR8QlTBxgcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 20:23:07 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e%5]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 20:23:07 +0000
Date:   Fri, 1 Dec 2023 12:23:04 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>
CC:     "ashok_raj@linux.intel.com" <ashok_raj@linux.intel.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jsperbeck@google.com" <jsperbeck@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Message-ID: <ZWpAqAumIajbw4iK@a4bf019067fa.jf.intel.com>
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
 <20231122221947.781812-1-jsperbeck@google.com>
 <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
 <ZWlSRE6KNNFwIYyq@araj-dh-work.jf.intel.com>
 <b561524f3378fb1d4c69451fdbf70bb5cbbb5ec9.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b561524f3378fb1d4c69451fdbf70bb5cbbb5ec9.camel@intel.com>
X-ClientProxiedBy: MW4PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:303:8f::15) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SA3PR11MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: bb960f4f-3f09-47cd-700a-08dbf2ab5493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89EUJT+LSaIuWJCh+VzBxUYxwBJoJNInxleqOglvBHSEn3nM67HUDCCEB7V6phvyJC9b8Vu/UWp0AOmMZpHAIJ8KbLdtTxHvY5NeCglQwEv3q5Bjbn2USscz93ZTyctvoBn69L8h6CnVLvDVIumMpNSogAuNEXq1dWeTarEDKX6f7/Uta2hZ+/l8/P6eUmlQeYNmMic4g3rkf32H2Ad+AtmboksDV+/SqmqR9FrIShAos3l5OjarRMs64lGpSHpidgf0tJUI1sc6+IuqVMor2zXHymMTlRTpV7BZPheRshj2giEP/KhgF6Wuu6q6eDHlhZ7A7wJ58DgSwiBUaZUyjJd7br3jCGhKUHVXJKP8o2uhtMnCYXVtqJI8FzLNGfNVF3dJT75q7boFp5Z71cZuZAhhU4iZh7BGkGIBlS/o5N/QBv0/J6OMRbX+HoPIFq8j3IYqDjgpQARYvjfM8tTeyVTI8JZ4rxedlXOXC5YOYJ3eRjOLntiA2qLeou+fZkaXLQJRjWQYCePXVbVFGY3mGMp6BJoZ7wZGLegmsNlyvZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82960400001)(38100700002)(83380400001)(4001150100001)(8676002)(44832011)(8936002)(6512007)(86362001)(4326008)(2906002)(5660300002)(6862004)(66946007)(66556008)(316002)(6486002)(966005)(478600001)(6506007)(6636002)(41300700001)(66476007)(6666004)(54906003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EnnPFJzk4i17FYvWKADUVXINApeUqmKqkCZMJwG84cHV0LIDY42+XjLt4e?=
 =?iso-8859-1?Q?RBUV/aCywm35BArJiis/wwsFR096TifiOSMYTz+wJihI+UzttLTGxBsX5f?=
 =?iso-8859-1?Q?SgUKpP0ZEShn/jVsQkR4YzjMJinpFI29oN2WELde+3VY+ivvlpisfsmwg+?=
 =?iso-8859-1?Q?c/FjRLmHhHXrliFQ9Pi87VBlNxy91k7wyQ7Ud4gp4ZvXv+h9iE7gnHi4VV?=
 =?iso-8859-1?Q?8GWhSRe5oa+I9akDbpzfZvUtnzJyZwmkUiArJZ20XTU9brSrZe6xAFViFk?=
 =?iso-8859-1?Q?Bi9eNk2xXr/vJMrjGskMmvY9ZLDq97MFRjnIGNsueoQegVHQ7AMpb3M6cR?=
 =?iso-8859-1?Q?6ZPZISz12LU70hJeDVADzFXmKVwha+R9hDAKrQSRH/eQG3HVjuEMcKcl8h?=
 =?iso-8859-1?Q?v8jLecnfZrdFFv8ii5BlZNq1V2Y850mspUcOMnIeNE8l4iHyNLew/kbIdU?=
 =?iso-8859-1?Q?+oNxpHuRtGHonRkZ6lHeGq1SmXAfKp5dNCJdEICDlWob7oHWS0Q1rxjr5d?=
 =?iso-8859-1?Q?awUqjsjxy5GfmcsZ+8cPWh/LaCEvwHC0BAHcPqOS7py1tf7JvBi4OhWmsa?=
 =?iso-8859-1?Q?dW1nSFcgsp9I15g/5X/gqcM/q3AhG7Mo37WRI7mz3tUq6/qdYepW2lwuPS?=
 =?iso-8859-1?Q?ImYDjSUv2oe8QOsPEJ3jEALZ12Yy1DEuhdPQnosnpo3nFpQKt/nLf2Je3m?=
 =?iso-8859-1?Q?YhztRrYWU7p4gFgQcdRIFjlAOhIYrAo4zHcsvBaDl44c1YUNFWJ75O6Mml?=
 =?iso-8859-1?Q?YQ6QSNsLl4P0Hcfaelvzwb7jiW9MT92n7jyejkduhe6X2mipx+Mo8Gsn6E?=
 =?iso-8859-1?Q?CC9hxw7KjGEAf4p6vUR1qgRnqQThZoSA0bkUNOj3e29QXCZrxSaTlMV7zI?=
 =?iso-8859-1?Q?ZaU3G6CwzGLqDxhFuBoHDKz7+5LCmM4oZv21ktpJfA0wfXDKSgK0qnknF/?=
 =?iso-8859-1?Q?KKZsEriN5f84/3RnFk00lgkS2tD/iNWdAT0oaCu2/hl9GdzW31JLBFEcBZ?=
 =?iso-8859-1?Q?6pOZ8m8piLkBS5fYzXJEzdED+qEVspaOhYqzlwKwEFuPZxgcc2+bWEP/Y+?=
 =?iso-8859-1?Q?KhMmDPHd4wxqgkUu3tjXNIa6sWL9rrrr4XZF2iyH2P+dTG2/z6k+d7WnwW?=
 =?iso-8859-1?Q?TKui6NbeO3bDVRMRS+wHp2LS0pPwP5vFNhwsqHXi4O4SiErcoKvWmKiNUh?=
 =?iso-8859-1?Q?0oG9Ce+9UXf3sFdv9j0jpf3pTzuVP9jv43EPBNdrngOayDQsjb0Hc5b83v?=
 =?iso-8859-1?Q?cRQ/96h2zbI3yk6iffNmofKWoRD2OcexgUhp5qNowTrlMtAwsWueao8MiE?=
 =?iso-8859-1?Q?TvpiQulVV/yJAYHAuXAJWWULyyPm2eofQ7mY8Rjb5C9MR5/gl+Hp8wsKte?=
 =?iso-8859-1?Q?o/7Z+NkpQeYiuFJ5KwKU3/6NLR8jefK+T21e/x+Y00rb7sqU0w2BuuwOAL?=
 =?iso-8859-1?Q?iqPuTwbhXJd8Ew3AbF14gktjSPXQ2vlcg2ymRyXLorXj5DURCX70Pk5z+Y?=
 =?iso-8859-1?Q?PDClemMDq6WoKLn7YBxlLIWhvQyWyrh0kTF0jnro86Dn3OhABe6pbdkmOc?=
 =?iso-8859-1?Q?YhX27O8SFp+gdpeqPmJJKOsCNYIpUI1UL9hkugmH09XIVQDfQ6jSBYWAZP?=
 =?iso-8859-1?Q?tlb05bkJCaNxXTgrzhlB98++txSa/Q08ze?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb960f4f-3f09-47cd-700a-08dbf2ab5493
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 20:23:07.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4680rxTQxBmAhEWofNt7NKmGGpWbPhhXd/7L0s9fvDpgVBs3IvnCt47uq9K+JPQoI+gQ+Vp3o36Wg/tyTaSzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
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

On Fri, Dec 01, 2023 at 10:08:55AM -0800, Zhang, Rui wrote:
> On Thu, 2023-11-30 at 19:25 -0800, Ashok Raj wrote:
> > On Thu, Nov 23, 2023 at 12:50:47PM +0000, Zhang Rui wrote:
> > > Hi, John,
> > > 
> > > Thanks for catching this issue.
> > > 
> > > On Wed, 2023-11-22 at 22:19 +0000, John Sperbeck wrote:
> > > > I have a platform with both LOCAL_APIC and LOCAL_X2APIC entries
> > > > for
> > > > each CPU.  However, the ids for the LOCAL_APIC entries are all
> > > > invalid ids of 255, so they have always been skipped in
> > > > acpi_parse_lapic()
> > > > by this code from f3bf1dbe64b6 ("x86/acpi: Prevent LAPIC id 0xff
> > > > from
> > > > being
> > > > accounted"):
> > > > 
> > > >     /* Ignore invalid ID */
> > > >     if (processor->id == 0xff)
> > > >             return 0;
> > > > 
> > > > With the change in this thread, the return value of 0 means that
> > > > the
> > > > 'count' variable in acpi_parse_entries_array() is incremented. 
> > > > The
> > > > positive return value means that 'has_lapic_cpus' is set, even
> > > > though
> > > > no entries were actually matched.
> > > 
> > > So in acpi_parse_madt_lapic_entries, without this patch,
> > > madt_proc[0].count is a positive value on this platform, right?
> > > 
> > > This sounds like a potential issue because the following checks to
> > > fall
> > > back to MPS mode can also break. (If all LOCAL_APIC entries have
> > > apic_id 0xff and all LOCAL_X2APIC entries have apic_id 0xffffffff)
> > > 
> > > >   Then, when the MADT is iterated
> > > > with acpi_parse_x2apic(), the x2apic entries with ids less than
> > > > 255
> > > > are skipped and most of my CPUs aren't recognized.
> > 
> > This smells wrong. If a BIOS is placing some in lapic and some in
> > x2apic
> > table, its really messed up. 
> > 
> > Shouldn't the kernel scan them in some priority and only consider one
> > set of
> > tables?
> > 
> > Shouldn't the code stop looking once something once a type is found?
> > 
> 
> I also want to get this clarified but there is no spec saying this. And
> instead, as mentioned in the comment, we do have something in
> https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-local-x2apic-structure
> 
> "[Compatibility note] On some legacy OSes, Logical processors with APIC
> ID values less than 255 (whether in XAPIC or X2APIC mode) must use the
> Processor Local APIC structure to convey their APIC information to
> OSPM, and those processors must be declared in the DSDT using the
> Processor() keyword. Logical processors with APIC ID values 255 and
> greater must use the Processor Local x2APIC structure and be declared
> using the Device() keyword."
> 
> so it is possible to enumerate CPUs from both LAPIC and X2APIC.
> 

Ah, so this looks like the legacy case, old OS can atleast boot the APIC
entries and not process the x2apic ones. 

So you can potentially have duplicates

APIC = has all APIC id's < 255
X2apic has all entries > 255 OR 
	It can contain everything, so you might need to weed out
	duplicates?

