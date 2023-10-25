Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297E97D75F8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjJYUwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:52:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC81136;
        Wed, 25 Oct 2023 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698267160; x=1729803160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XTbrElkU1MbX6ZrhPb1QYOzV1U9Co1VHsj67ZR6GG3g=;
  b=TGq8NBDOml6EemXEi9z6ISE3nVI291MD184rYq3x5nMy8II6Rtc3wLc8
   dqzEzUlUyooxAfoTwlze/vcXw3VWYMETeDKLtijq7NTkm6hl/QPhzbcjc
   H6Hmjsz19ZJZsEvazEQPvGQiuDB7SXQ63bJA3hfQwD3itZiF62lv323gi
   t8NhIT1/qb0aJW/U4ClFOeM6kbhzTvYwUD/FyFKAbOdiX+3cbYsx2UPB+
   9InzzXxYCOsvVfU+cgZWNEx3MPzlvrhSJ2tkNDmmD+2IGTJVge7uK5CaU
   /z5bc536Sa/KoiQdt6MrrMAwQC7I/qpqagxbX0LEiQLrV7ZZWoWO908K6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="387222339"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="387222339"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708817429"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="708817429"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:52:38 -0700
Date:   Wed, 25 Oct 2023 13:52:37 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     "Moger, Babu" <babu.moger@amd.com>
Cc:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Message-ID: <ZTmAFVuYlMuCbQHz@agluck-desk3>
References: <20231024181600.8270-1-tony.luck@intel.com>
 <CALPaoChftF-H6GauKq4-c_qBJP1GJbR3-ByE5krsaQF4y4y9oQ@mail.gmail.com>
 <ZTluypa9bCWv4k2n@agluck-desk3>
 <e4994218-a7a2-4505-868e-a5c825ca4db0@amd.com>
 <b8ea0a74-347d-475f-a36d-8944ced16951@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ea0a74-347d-475f-a36d-8944ced16951@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 03:42:14PM -0500, Moger, Babu wrote:
> I meant, I was thinking bit different.
> 
> > 
> > You need these changes in only two functions, mbm_bw_count and
> > update_mba_bw. You decide which event you want to use based on availability,
> > 
> > Something like this. I updated mbm_bw_count.
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> > b/arch/x86/kernel/cpu/resctrl/monitor.c
> > index 0ad23475fe16..302993e4fbc3 100644
> > --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> > +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> > @@ -436,8 +436,16 @@ static int __mon_event_count(u32 rmid, struct
> > rmid_read *rr)
> >   */
> >  static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
> >  {
> > -       struct mbm_state *m = &rr->d->mbm_local[rmid];
> >         u64 cur_bw, bytes, cur_bytes;
> > +       struct mbm_state *m;
> > +       int evtid;
> > +
> > +       if (is_mbm_local_enabled())
> > +               evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
> > +       else
> > +               evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
> > +
> > +       m = get_mbm_state(rr->d, rmid, evtid);

Ok. Yes. That seems simpler.

Maybe I should just set a global "mbm_evtid" at mount
time. No need to check every time to see if is_mbm_local_enabled()
somehow changed and local b/w measurements were suddenly
available!

-Tony
