Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328837B3B65
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjI2Unl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjI2Unh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:43:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6961B0;
        Fri, 29 Sep 2023 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696020215; x=1727556215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k35CTLxwYNMJbh/KVFe+2nbeQOog2WQUMF7Mb5YVfcw=;
  b=MSTxC/8jy7Wx5WcqAW3dxFbwzZcElwJfPd/RAy3oYSshDHcM8G5UvPxm
   CuCSdTFXOAxeqIqVRGRvp0Os4QZbTqLOBU5l5UIQWApE7PPlpv76BYRDS
   bzzS6crDQkx2lE5khDScKii/JlWPO1Sr6XA79SrVySO+MVeWiIm3TEoeu
   So6h89lKTdabRRkLLfUPYq/31fYkovfGd8J51gRA6LnsDj9fRrrLDJpgN
   qUDopfVoJfKo4LDzJuEm9OiJRZDrZ+A/fN2lwF6tGb7KbCnZvoRsd5OSk
   F7cJw7hcZ1N2m1Agx5i1fzHNg0Nf5i3Q1y2Qn+JS1YQwht4nJi1ZGO812
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="386237611"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="386237611"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="815695986"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="815695986"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:06:15 -0700
Date:   Fri, 29 Sep 2023 13:06:13 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v6 4/8] x86/resctrl: Split the rdt_domain and
 rdt_hw_domain structures
Message-ID: <ZRcuNbO4/GF2OiG5@agluck-desk3>
References: <20230829234426.64421-1-tony.luck@intel.com>
 <20230928191350.205703-1-tony.luck@intel.com>
 <20230928191350.205703-5-tony.luck@intel.com>
 <CALPaoCgN2PBQymAXK_f1ggs_JwyARBuWruP-sPA1QKJMxvv9ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCgN2PBQymAXK_f1ggs_JwyARBuWruP-sPA1QKJMxvv9ow@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 03:44:54PM +0200, Peter Newman wrote:
> Hi Tony,
> 
> On Thu, Sep 28, 2023 at 9:14 PM Tony Luck <tony.luck@intel.com> wrote:
> >  /**
> > - * struct rdt_hw_domain - Arch private attributes of a set of CPUs that share
> > - *                       a resource
> > + * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
> > + *                       a resource for a control function
> 
> wrapped line not quite aligned anymore

Fixed

> 
> >   * @d_resctrl: Properties exposed to the resctrl file system
> >   * @ctrl_val:  array of cache or mem ctrl values (indexed by CLOSID)
> > + *
> > + * Members of this structure are accessed via helpers that provide abstraction.
> > + */
> > +struct rdt_hw_ctrl_domain {
> > +       struct rdt_ctrl_domain          d_resctrl;
> > +       u32                             *ctrl_val;
> > +};
> > +
> > +/**
> > + * struct rdt_hw_mon_domain - Arch private attributes of a set of CPUs that share
> > + *                       a resource for a monitor function
> 
> wrapped line not quite aligned anymore

Fixed

> 
> 
> > --
> > 2.41.0
> >
> 
> Reviewed-by: Peter Newman <peternewman@google.com>

Thanks

-Tony
