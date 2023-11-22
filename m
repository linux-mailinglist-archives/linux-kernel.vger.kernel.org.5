Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53F7F43CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjKVK1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjKVK1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:27:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D272171E;
        Wed, 22 Nov 2023 02:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700648824; x=1732184824;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fn/U3ax+BTUOrMmFTZ8WOmfBf3T0PsrvpDNHpbWZ7Rw=;
  b=lMk8bWN5s1lbPF4frO2VbFhmFBlATBrVP8k/B80yD9L2L3SNjHIVANeO
   OS5BvahuR/jB797q8BdMIxq0/eYEV3OPZ1B8ihSYodUxRu0PYA/s+5gFb
   x+sYqakZb0DeigCgF748Id6gLkcsve2N89SgerIwEyoviUucLyyU1jY9N
   P9fBnNkH+Mm9zcrRmf23HnXz5x8gLE1sjVFJYa7TPTaCqkOsASTFaVjh0
   polDHSCFc9oJlJc5PkaXyhzFKZwc4/tFHDnkBlfHyo6VczzwZU7V4y3+k
   2jp+sNFCLEZlwyD8j11DG/OKL+9aBZU9ts1WQFZjzN0SGql8arO9hQlSk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="377057312"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="377057312"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910746321"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="910746321"
Received: from johannes-ivm.ger.corp.intel.com ([10.249.47.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:27:01 -0800
Date:   Wed, 22 Nov 2023 12:26:55 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/17] tty: move locking docs out of Returns for functions
 in tty.h
In-Reply-To: <ce8e5446-9fcf-4692-90e5-1c5fa75a880f@kernel.org>
Message-ID: <46ef4b89-6a6b-ddb1-fec8-eb9749e9b0f3@linux.intel.com>
References: <20231121092258.9334-1-jirislaby@kernel.org> <20231121092258.9334-5-jirislaby@kernel.org> <e74f4dfb-55f2-f997-6a70-a1b7edd11016@linux.intel.com> <bdb4cd62-2d17-4d19-b429-1232ec863456@kernel.org> <ce8e5446-9fcf-4692-90e5-1c5fa75a880f@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-719030075-1700648822=:1917"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-719030075-1700648822=:1917
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 22 Nov 2023, Jiri Slaby wrote:

> On 22. 11. 23, 7:45, Jiri Slaby wrote:
> > On 21. 11. 23, 10:48, Ilpo Järvinen wrote:
> > > On Tue, 21 Nov 2023, Jiri Slaby (SUSE) wrote:
> > > 
> > > > Both tty_kref_get() and tty_get_baud_rate() note about locking in their
> > > > Return kernel-doc clause. Extract this info into a separate "Locking"
> > > > paragraph -- the same as we do for other tty functions.
> > > > 
> > > > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > > > Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > ---
> > > >   include/linux/tty.h | 12 +++++++-----
> > > >   1 file changed, 7 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/include/linux/tty.h b/include/linux/tty.h
> > > > index 4b6340ac2af2..7625fc98fef3 100644
> > > > --- a/include/linux/tty.h
> > > > +++ b/include/linux/tty.h
> > ...
> > > > @@ -436,10 +438,10 @@ void tty_encode_baud_rate(struct tty_struct *tty,
> > > > speed_t ibaud,
> > > >    * tty_get_baud_rate - get tty bit rates
> > > >    * @tty: tty to query
> > > >    *
> > > > - * Returns: the baud rate as an integer for this terminal. The termios
> > > > lock
> > > > - * must be held by the caller and the terminal bit flags may be
> > > > updated.
> > > > + * Returns: the baud rate as an integer for this terminal
> > > >    *
> > > > - * Locking: none
> > > > + * Locking: The termios lock must be held by the caller and the
> > > > terminal bit
> > > > + * flags may be updated.
> > > 
> > > I don't think the second part about the flags really belongs here, I'd
> > > keep it the description.
> > 
> > Any idea what does the part says in fact? I had not been thinking about the
> > content and now I don't understand it.
> 
> Maybe before:
> commit 6865ff222ccab371c04afce17aec1f7d70b17dbc
> Author: Jiri Slaby <jirislaby@kernel.org>
> Date:   Thu Mar 7 13:12:27 2013 +0100
> 
>     TTY: do not warn about setting speed via SPD_*
> 
> 
> tty->warned was "the terminal bit".
> 
> Let's drop that part. And we can make tty const there too.

Good point. 

The commit you point to is probably unrelated though but thanks anyway 
because it gave me this idea which I think is the correct reference: I 
removed the ->c_cflag alteringin 87888fb9ac0c ("tty: Remove baudrate dead 
code & make ktermios params const"). It had become deadcode anyway long 
since (I never went through the arch headers to find how long ago).

So yes, dropping the second part seems the correct way to go.

-- 
 i.

--8323329-719030075-1700648822=:1917--
