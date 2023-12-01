Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF9580021B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377152AbjLAD2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLAD2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:28:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF1112F;
        Thu, 30 Nov 2023 19:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701401309; x=1732937309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wIDHMJGhj47KQxQ6hhrFS+GGY32Iqm7h01EukEKzsx4=;
  b=V7zpC93gyr9V2EWkH7An6lwZz9FIeKH7N4aNUPy3QpZT2V70zVkcTxjo
   4nrOUkZU22qopOms9ue6SS64h/TME23ohmftR4XHb6G6SfnF0czgjvDNf
   CxwpP7S7WTidAYU0zhmj4BYq5Srz078NW2jtXrTe30PKqtr/GeX81V606
   FNW8MsM1gs3ZRupinsfyVCD3JmsCKEanjCfQXmZ6UbFfGGIpj5yMdVao2
   tLdnCFznqtCZNhQ7QAZ5GkH16qbvzh3rejfDR83ouPptqCu+S+RiBFay2
   mDaqkeiw1A3RF+mXOY48GGNukbv/Ma29Te3tLoiCOKMjpLv2OFyXxkTIM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="383824655"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="383824655"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 19:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="11015073"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 19:28:23 -0800
Date:   Thu, 30 Nov 2023 19:25:56 -0800
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "jsperbeck@google.com" <jsperbeck@google.com>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Message-ID: <ZWlSRE6KNNFwIYyq@araj-dh-work.jf.intel.com>
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
 <20231122221947.781812-1-jsperbeck@google.com>
 <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:50:47PM +0000, Zhang Rui wrote:
> Hi, John,
> 
> Thanks for catching this issue.
> 
> On Wed, 2023-11-22 at 22:19 +0000, John Sperbeck wrote:
> > I have a platform with both LOCAL_APIC and LOCAL_X2APIC entries for
> > each CPU.  However, the ids for the LOCAL_APIC entries are all
> > invalid ids of 255, so they have always been skipped in
> > acpi_parse_lapic()
> > by this code from f3bf1dbe64b6 ("x86/acpi: Prevent LAPIC id 0xff from
> > being
> > accounted"):
> > 
> >     /* Ignore invalid ID */
> >     if (processor->id == 0xff)
> >             return 0;
> > 
> > With the change in this thread, the return value of 0 means that the
> > 'count' variable in acpi_parse_entries_array() is incremented.  The
> > positive return value means that 'has_lapic_cpus' is set, even though
> > no entries were actually matched.
> 
> So in acpi_parse_madt_lapic_entries, without this patch,
> madt_proc[0].count is a positive value on this platform, right?
> 
> This sounds like a potential issue because the following checks to fall
> back to MPS mode can also break. (If all LOCAL_APIC entries have
> apic_id 0xff and all LOCAL_X2APIC entries have apic_id 0xffffffff)
> 
> >   Then, when the MADT is iterated
> > with acpi_parse_x2apic(), the x2apic entries with ids less than 255
> > are skipped and most of my CPUs aren't recognized.

This smells wrong. If a BIOS is placing some in lapic and some in x2apic
table, its really messed up. 

Shouldn't the kernel scan them in some priority and only consider one set of
tables?

Shouldn't the code stop looking once something once a type is found?

sapic is only for IA64 correct?

sapic_entries = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_SAPIC,....)

if sapic_entries
	return sapic_entries;

x2apic_count = ...

if x2apic_count
	return x2apic_count;

apic_count = ...

Maybe you should add if all entries are marked INVALID for APIC, just
ignore the whole table?

Cheers,
Ashok
