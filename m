Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460BD798166
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 06:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbjIHE76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 00:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIHE75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 00:59:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4850D19AB;
        Thu,  7 Sep 2023 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694149192; x=1725685192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=frFa2A5SVWE7iimjbT1DhSuiHkk/xjKviFEZ54bN9r0=;
  b=NtgXqvmSJSUBWZE0DBNCT0bnf84bN80LFJRIzMPBJGseu4LgrZWhHIT5
   +9UeVeEUJ5eDxiY5x+x//mYrEGvvrx8NUv2W1DtLBL5TJ6cJ23wcl9Drd
   U919dGkAvaisQzSkiQysltYkRUHIFrCc0HR4nqvsK3DGlsZkeTK7HlVs1
   1VQpuTByD6NJ3/NAZAhKGeOnnfg/cSdvL8OQG1yFZsVM+503QSZczO94n
   +C77l38Fm5z8A8PiMbCtsKMUETOzbUpx2YZfoXrNKzwsDp1rzc/ux1wcY
   iTgOMnqZbXB7L9wIfH9wTGr0HdzBVEV17+47vCuzlyh9pxsAzktyNirN4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="463939480"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="463939480"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 21:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="719007615"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="719007615"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Sep 2023 21:59:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 41E49192; Fri,  8 Sep 2023 07:59:46 +0300 (EEST)
Date:   Fri, 8 Sep 2023 07:59:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Check status after
 timeout in busy_loop()
Message-ID: <20230908045946.GM1599918@black.fi.intel.com>
References: <20230906180944.2197111-1-swboyd@chromium.org>
 <20230906180944.2197111-2-swboyd@chromium.org>
 <20230907053513.GH1599918@black.fi.intel.com>
 <CAE-0n51Ut296M2ZetuzXGpX32pS11bbWzfcbaFfqNxgSjzafJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE-0n51Ut296M2ZetuzXGpX32pS11bbWzfcbaFfqNxgSjzafJw@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 01:11:17PM -0700, Stephen Boyd wrote:
> Quoting Mika Westerberg (2023-09-06 22:35:13)
> > On Wed, Sep 06, 2023 at 11:09:41AM -0700, Stephen Boyd wrote:
> > > It's possible for the polling loop in busy_loop() to get scheduled away
> > > for a long time.
> > >
> > >   status = ipc_read_status(scu); // status = IPC_STATUS_BUSY
> > >   <long time scheduled away>
> > >   if (!(status & IPC_STATUS_BUSY))
> > >
> > > If this happens, then the status bit could change while the task is
> > > scheduled away and this function would never read the status again after
> > > timing out. Instead, the function will return -ETIMEDOUT when it's
> > > possible that scheduling didn't work out and the status bit was cleared.
> > > Bit polling code should always check the bit being polled one more time
> > > after the timeout in case this happens.
> > >
> > > Fix this by reading the status once more after the while loop breaks.
> > >
> > > Cc: Prashant Malani <pmalani@chromium.org>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Fixes: e7b7ab3847c9 ("platform/x86: intel_scu_ipc: Sleeping is fine when polling")
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >
> > > This is sufficiently busy so I didn't add any tags from previous round.
> > >
> > >  drivers/platform/x86/intel_scu_ipc.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> > > index 6851d10d6582..b2a2de22b8ff 100644
> > > --- a/drivers/platform/x86/intel_scu_ipc.c
> > > +++ b/drivers/platform/x86/intel_scu_ipc.c
> > > @@ -232,18 +232,21 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
> > >  static inline int busy_loop(struct intel_scu_ipc_dev *scu)
> > >  {
> > >       unsigned long end = jiffies + IPC_TIMEOUT;
> > > +     u32 status;
> > >
> > >       do {
> > > -             u32 status;
> > > -
> > >               status = ipc_read_status(scu);
> > >               if (!(status & IPC_STATUS_BUSY))
> > > -                     return (status & IPC_STATUS_ERR) ? -EIO : 0;
> > > +                     goto not_busy;
> > >
> > >               usleep_range(50, 100);
> > >       } while (time_before(jiffies, end));
> > >
> > > -     return -ETIMEDOUT;
> > > +     status = ipc_read_status(scu);
> >
> > Does the issue happen again if we get scheduled away here for a long
> > time? ;-)
> 
> Given the smiley I'll assume you're making a joke. But to clarify, the
> issue can't happen again because we've already waited at least
> IPC_TIMEOUT jiffies, maybe quite a bit more, so if we get scheduled away
> again it's a non-issue. If the status is still busy here then it's a
> timeout guaranteed.

Got it thanks!

> > Regardless, I'm fine with this as is but if you make any changes, I
> > would prefer see readl_busy_timeout() used here instead (as was in the
> > previous version).
> 
> We can't use readl_busy_timeout() (you mean readl_poll_timeout() right?)
> because that implements the timeout with timekeeping and we don't know
> if this is called from suspend paths after timekeeping is suspended or
> from early boot paths where timekeeping isn't started.

Yes readl_poll_timeout(). :)

I don't think this code is used anymore outside of regular paths. It
used to be with the Moorestown/Medfield board support code but that's
gone already. Grepping for the users also don't reveal anything that
could be using it early at boot.
