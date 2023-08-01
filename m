Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363B276A565
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjHAATh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHAATe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:19:34 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F6133
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 17:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690849173; x=1722385173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZEulNWdnP1duSXBMmYXkpzEDKmjHjBb+oQsjgX3lU0w=;
  b=Ds5II6khFJwL018pEUPaC/DiVbYzaVNwR79Hg5IrhzWj5FHtbb/0QYte
   mOYcTP0V56RMWZ0jphg8y5q+7bkvQfq2lxtbC2/P7L1TJ7pYI94gJQcfa
   8i5ZEmtH0U5dHd8PLtE7djD/t69+iEBVghXQ8r05UV6mnEptbghPDEvfc
   njGI5UEwxfGvb0+dgfWjUZbcPEucSW3GOB2B8/5P0mZcnrSbJYz8Ul2oB
   P4u+jyFWWHF5q3GA2q/JDo2edpqG5roc9Af9wnv/50Oc6aCCAECWyZzyU
   hmbFQEjpT3CUSPXRzhHgHSP0No8KH4segDDK476oX6/NMqD3WITiskfCd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="348754695"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="348754695"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 17:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728465612"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="728465612"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 17:19:32 -0700
Date:   Mon, 31 Jul 2023 17:19:31 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Peter Newman <peternewman@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "Pitre, Nicolas" <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "aricciardi@baylibre.com" <aricciardi@baylibre.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [RFC PATCH 0/2] Resctrl - rewrite (WIP)
Message-ID: <ZMhPk8xckzkLEGJc@agluck-desk3>
References: <20230620033702.33344-1-tony.luck@intel.com>
 <ZJqhDYLG+/Kr44sp@x1>
 <SJ1PR11MB60832BA425B43CA19C778100FC27A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZJ4clUlN2OujgHlC@agluck-desk3>
 <ZMCEjZgyi5oI+KWh@x1>
 <ZMElMLPWi0+2jCp8@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMElMLPWi0+2jCp8@agluck-desk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:52:48AM -0700, Tony Luck wrote:
> On Tue, Jul 25, 2023 at 07:27:25PM -0700, Drew Fustini wrote:
> > 
> > Also, is resctrl2_v65rc1 the latest to branch to test?
> 
> Yes. That's the latest. There haven't been any updates for a
> few days because I'm working on a module to support pseudo-locking.
> I'm half-way there (can do most of the bits to set a group into
> pseudo-locked mode ... about to work on the cleanup when the
> group is removed, the filesystem unmounted, or the module unloaded).

Updated version available at:

git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git

Branch: resctrl2_v65rc4

Some minor fixes to core code, also changes to support pseudo-locking
(core code for the "mode" file plus some new functions in the resource
structure to call into modules to support this).

-Tony
