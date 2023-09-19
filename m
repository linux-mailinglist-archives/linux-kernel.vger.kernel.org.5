Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CBE7A5F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjISKVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjISKVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:21:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F40FF1;
        Tue, 19 Sep 2023 03:21:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B08C433C8;
        Tue, 19 Sep 2023 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695118876;
        bh=00igDQJ3RS0HIHvI61wYlaTY0xMEuzE9VvRZGwxN9C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wvvth7PuYkG2zqbUuKTwTQeHLYgkMLvVNANfOf736jDLc3XqujVzTKDZRMhMzGOks
         w8oGLW7cE/1vQoxoBIM3WP5sJp8oJOiET1EsnNCDL3rRaKQSAA3rFFUSAqDqzBbtV/
         94DXhR82m76Gao7hTkhrp215Vmp38OaR5+y7X/d8=
Date:   Tue, 19 Sep 2023 12:21:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/15] random tty fixes
Message-ID: <2023091952-civic-balancing-5c50@gregkh>
References: <20230919085156.1578-1-jirislaby@kernel.org>
 <6f7b65a8-bc9c-83d2-13c9-a56d85616b53@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f7b65a8-bc9c-83d2-13c9-a56d85616b53@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 01:17:49PM +0300, Ilpo Järvinen wrote:
> On Tue, 19 Sep 2023, Jiri Slaby (SUSE) wrote:
> 
> > This is a collection of random fixes for tty I did while crawling
> > through the code. Mostly done for readability and understandability. No
> > behavior change intended (except for Documentation fixes).
> > 
> > Jiri Slaby (SUSE) (15):
> >   tty: n_tty: use 'retval' instead of 'c'
> >   tty: n_tty: rename and retype 'retval' in n_tty_ioctl()
> >   tty: n_tty: use min3() in copy_from_read_buf()
> >   tty: n_tty: invert the condition in copy_from_read_buf()
> >   tty: n_tty: use do-while in n_tty_check_{,un}throttle()
> >   tty: switch tty_{,un}throttle_safe() to return a bool
> >   tty: invert return values of tty_{,un}throttle_safe()
> >   tty: fix up and plug in tty_ioctl kernel-doc
> >   tty: fix kernel-doc for functions in tty.h
> >   tty: stop using ndash in kernel-doc
> >   tty: tty_buffer: use bool for 'restart' in
> >     tty_buffer_unlock_exclusive()
> >   tty: convert THROTTLE constants into enum
> >   tty: early return from send_break() on TTY_DRIVER_HARDWARE_BREAK
> >   tty: don't check for signal_pending() in send_break()
> >   tty: use 'if' in send_break() instead of 'goto'
> > 
> >  Documentation/driver-api/tty/index.rst     |   1 +
> >  Documentation/driver-api/tty/tty_ioctl.rst |  10 +
> >  drivers/tty/n_tty.c                        |  77 ++++---
> >  drivers/tty/tty.h                          |  13 +-
> >  drivers/tty/tty_buffer.c                   |   5 +-
> >  drivers/tty/tty_io.c                       |  36 ++--
> >  drivers/tty/tty_ioctl.c                    | 234 ++++++++++-----------
> >  drivers/tty/tty_port.c                     |   6 +-
> >  drivers/tty/vt/consolemap.c                |   2 +-
> >  drivers/tty/vt/vc_screen.c                 |   4 +-
> >  drivers/tty/vt/vt.c                        |   4 +-
> >  include/linux/tty.h                        |  25 +--
> >  12 files changed, 209 insertions(+), 208 deletions(-)
> >  create mode 100644 Documentation/driver-api/tty/tty_ioctl.rst
> 
> For this whole series except the patches I commented on:
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> ...If you make the amendments I requested, please add the tag also to the 
> patches I commented on.

That's horrible, b4 will now just add this reviewed-by to all of them
when I run it :(

greg k-h
