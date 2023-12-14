Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB28126D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443154AbjLNFTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443128AbjLNFTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:19:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0BCBD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:19:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09AAC433C7;
        Thu, 14 Dec 2023 05:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702531148;
        bh=Qmguxw2VEVkdVujawfXKj9hwmQrHGLFvLZ7pg6rQI8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSEWEqGEva6OY5Pl9k5S1taXN2jrycqHbr7jLJyw0uTdJz3uyiILDCkwtjoIwfeIF
         B4FLQo71YhYmk4SpI+sGDAiOb0e8+lwzcchJHmqLA0EV1megEwmY64VoL2N9c3HHEl
         OBf+FmSRd9xKHbln/tnWntDdRYXGbmHjm4RgKoZYQqJ2JWQv8hawASRySqRIRBlOMa
         7Vw/dACuRBnenN28rwhFZQtBWEZEnoEaK2KZo1JUzCKHOdjBNFzefbLTB9CUTN2odZ
         0UudCTtjJwxRrkgrBc/Xmp2iYcJC4VrkasxVq8TmtFw3F54RKN+a9SXD8nONekoHGt
         by/vNuvkNg8EQ==
Date:   Thu, 14 Dec 2023 10:46:56 +0530
From:   Naveen N Rao <naveen@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Subject: Re: [PATCH v3] trace/kprobe: Display the actual notrace function
 when rejecting a probe
Message-ID: <adcah2zl66ghxbavtqaxzrnkbw5j2qhm4zghpen2byou45u4ck@oojp275o57pi>
References: <20231213143914.1591175-1-naveen@kernel.org>
 <20231214080210.99ff94d956307b036208520d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214080210.99ff94d956307b036208520d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 08:02:10AM +0900, Masami Hiramatsu wrote:
> On Wed, 13 Dec 2023 20:09:14 +0530
> Naveen N Rao <naveen@kernel.org> wrote:
> 
> > Trying to probe update_sd_lb_stats() using perf results in the below
> > message in the kernel log:
> >   trace_kprobe: Could not probe notrace function _text
> > 
> > This is because 'perf probe' specifies the kprobe location as an offset
> > from '_text':
> >   $ sudo perf probe -D update_sd_lb_stats
> >   p:probe/update_sd_lb_stats _text+1830728
> > 
> > However, the error message is misleading and doesn't help convey the
> > actual notrace function that is being probed. Fix this by looking up the
> > actual function name that is being probed. With this fix, we now get the
> > below message in the kernel log:
> >   trace_kprobe: Could not probe notrace function update_sd_lb_stats.constprop.0
> > 
> > Signed-off-by: Naveen N Rao <naveen@kernel.org>
> > ---
> > v3: Remove tk parameter from within_notrace_func() as suggested by 
> > Masami
> > 
> >  kernel/trace/trace_kprobe.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 3d7a180a8427..dc36c6ed6131 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -449,9 +449,8 @@ static bool __within_notrace_func(unsigned long addr)
> >  	return !ftrace_location_range(addr, addr + size - 1);
> >  }
> >  
> > -static bool within_notrace_func(struct trace_kprobe *tk)
> > +static bool within_notrace_func(unsigned long addr)
> >  {
> > -	unsigned long addr = trace_kprobe_address(tk);
> >  	char symname[KSYM_NAME_LEN], *p;
> >  
> >  	if (!__within_notrace_func(addr))
> > @@ -471,12 +470,14 @@ static bool within_notrace_func(struct trace_kprobe *tk)
> >  	return true;
> >  }
> >  #else
> > -#define within_notrace_func(tk)	(false)
> > +#define within_notrace_func(addr)	(false)
> >  #endif
> >  
> >  /* Internal register function - just handle k*probes and flags */
> >  static int __register_trace_kprobe(struct trace_kprobe *tk)
> >  {
> > +	unsigned long addr = trace_kprobe_address(tk);
> > +	char symname[KSYM_NAME_LEN];
> >  	int i, ret;
> >  
> >  	ret = security_locked_down(LOCKDOWN_KPROBES);
> > @@ -486,9 +487,9 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
> >  	if (trace_kprobe_is_registered(tk))
> >  		return -EINVAL;
> >  
> > -	if (within_notrace_func(tk)) {
> > +	if (within_notrace_func(addr)) {
> >  		pr_warn("Could not probe notrace function %s\n",
> > -			trace_kprobe_symbol(tk));
> > +			lookup_symbol_name(addr, symname) ? trace_kprobe_symbol(tk) : symname);
> 
> Can we just use %ps and (void *)trace_kprobe_address(tk) here?
> 
> That will be simpler.

Indeed - that is much simpler. v4 on its way...

Thanks!
- Naveen
