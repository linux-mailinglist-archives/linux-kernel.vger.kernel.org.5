Return-Path: <linux-kernel+bounces-165899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFD68B931F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F4F1C21301
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3539E18036;
	Thu,  2 May 2024 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="QAshCVDo"
Received: from smtp95.iad3a.emailsrvr.com (smtp95.iad3a.emailsrvr.com [173.203.187.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1038168DE
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714613365; cv=none; b=raBY5wcYIY+QMZs0hTGlvYM5ESfHAmI3omCdp2e18teqRz0PabpbriyW9ldlDLQOkJc2Qq3HF1rH/yuIJZOWu5Pjj775QyUGeihANjDcg6oGR2FCQ1+YoipFu8AHhrspCIVlpFrQyLKTNzIklUlqZwVBVWCngzaBjAR1W6xV3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714613365; c=relaxed/simple;
	bh=WGSyM/4CiIMkm9hEyvJ3yVSuSPYcuGcmPHUWkohwB5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgPm0n5Tj2ywbgXVltyKkLY8b68gijGsOtdCls+iF2UZ+TVpUiPIrBRjbp77riCxen9mpf6YLRJPjkks7L+ci+VXvTZPVnWI92qnHgoi6lZHasD0l7piEPEr+r5bwYXUSufa7OY58bI3KGmD/4lLhKLQn2KjRBGKheCw89sezVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=QAshCVDo; arc=none smtp.client-ip=173.203.187.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1714613357;
	bh=WGSyM/4CiIMkm9hEyvJ3yVSuSPYcuGcmPHUWkohwB5Y=;
	h=Date:From:To:Subject:From;
	b=QAshCVDo2Osp8lK+3FSZovXHrjJZX3BwGgK//GheKXXX7r8a4kr5k4t4Gfg+YH5rs
	 cXUJwsqs7fxbdH36tYB3cjuEmuXI34wC5nOnf/LIeLipWafQEli1r8T0YZqcDWKBMw
	 9MCAPCRz8wyJebKdeOM+3F9pRoCFDE3YUBvwaS4Y=
X-Auth-ID: lars@oddbit.com
Received: by smtp36.relay.iad3a.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id E7FC35484;
	Wed,  1 May 2024 21:29:16 -0400 (EDT)
Date: Wed, 1 May 2024 21:29:16 -0400
From: Lars Kellogg-Stedman <lars@oddbit.com>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net, jreuter@yaina.de, dan.carpenter@linaro.org
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Message-ID: <my4l7ljo35dnwxl33maqhyvw7666dmuwtduwtyhnzdlb6bbf5m@5sbp4tvg246f>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501060218.32898-1-duoming@zju.edu.cn>
X-Classification-ID: 65a8466f-308e-4519-ba13-d0b67ecdb47f-1-1

On Wed, May 01, 2024 at 02:02:18PM +0800, Duoming Zhou wrote:
> There are two scenarios that might cause refcount leak
> issues of ax25_dev.

This patch doesn't address the refcount leaks I reported earlier and
resolved in the patch I posted [1] last week.

Assume we have the following two interfaces configured on a system:

    $ cat /etc/ax25/axports
    udp0 test0-0 9600 255 2 axudp0
    udp1 test0-1 9600 255 2 axudp1

And we have ax25d listening on both interfaces:

    [udp0]
    default  * * * * * *  - root  /usr/sbin/axwrapper axwrapper -- /bin/sh sh /etc/ax25/example-output.sh
    [udp1]
    default  * * * * * *  - root  /usr/sbin/axwrapper axwrapper -- /bin/sh sh /etc/ax25/example-output.sh

Using the 'ax-devs' and 'ax-sockets' gdb commands shown at the end of
this message, we start with:

    (gdb) ax-devs
    ax1 ax_refcnt:2 dev_refcnt:9 dev_untracked:1 dev_notrack:1
    ax0 ax_refcnt:2 dev_refcnt:9 dev_untracked:1 dev_notrack:1
    (gdb) ax-sockets
    0xffff8881002b6800 if:ax1 state:0 refcnt:2 dev_tracker:0xffff888100ded200
    0xffff888101ac4e00 if:ax0 state:0 refcnt:2 dev_tracker:0xffff888100dec4c0

We initiate a connection from ax0 to ax1:

    call -r udp0 test0-1

When we first enter ax25_rcv, we have:

    (gdb) ax-devs
    ax1 ax_refcnt:2 dev_refcnt:9 dev_untracked:1 dev_notrack:1
    ax0 ax_refcnt:3 dev_refcnt:10 dev_untracked:1 dev_notrack:1
    (gdb) ax-sockets
    0xffff888101ac8000 if:ax0 state:1 refcnt:2 dev_tracker:0xffff888100dedb80
    0xffff8881002b6800 if:ax1 state:0 refcnt:2 dev_tracker:0xffff888100ded200
    0xffff888101ac4e00 if:ax0 state:0 refcnt:2 dev_tracker:0xffff888100dec4c0

After we reach line 413 (in net/ax25/ax25_in.c) and add a new control
block:

    ax25_cb_add(ax25)

We have:

    (gdb) ax-devs
    ax1 ax_refcnt:2 dev_refcnt:9 dev_untracked:1 dev_notrack:1
    ax0 ax_refcnt:3 dev_refcnt:10 dev_untracked:1 dev_notrack:1
    (gdb) ax-sockets
    0xffff88810245ac00 if:ax1 state:3 refcnt:2 dev_tracker:0x0 <fixed_percpu_data>
    0xffff88810245ba00 if:ax0 state:1 refcnt:2 dev_tracker:0xffff88810136c800
    0xffff888100c79e00 if:ax1 state:0 refcnt:2 dev_tracker:0xffff88810136c6e0
    0xffff8881018e9800 if:ax0 state:0 refcnt:2 dev_tracker:0xffff88810170c860

Note that (a) ax25->dev_tracker is NULL, and (b) we have incremeted the
refcount on ax0 (the source interface), but not on ax1 (the destination
interface). When we call ax25_release for this control block, we get to:

    netdev_put(ax25_dev->dev, &ax25->dev_tracker);
    ax25_dev_put(ax25_dev);

With:

    (gdb) ax-devs
    ax1 ax_refcnt:2 dev_refcnt:9 dev_untracked:1 dev_notrack:1
    ax0 ax_refcnt:3 dev_refcnt:10 dev_untracked:1 dev_notrack:1

After the calls to netdev_put() and ax25_dev_put(), we have:

    (gdb) ax-devs
    ax1 ax_refcnt:1 dev_refcnt:8 dev_untracked:-1073741824 dev_notrack:1
    ax0 ax_refcnt:2 dev_refcnt:9 dev_untracked:1 dev_notrack:1

You can see that (a) ax25_dev->dev->refcnt_tracker->untracked is now
invalid, and ax25_dev->dev->dev_refcnt is in trouble: it decrements by
one for each closed connection, even though it was never incremented
when we accepted the connection. The underflow in
..refcnt_tracker->untracked yields the traceback with:

    refcount_t: decrement hit 0; leaking memory.

Additional connections will eventually trigger more problems; we will
ultimately underflow ax25_dev->dev->dev_refcnt, but we may also run into
memory corruption because of the invalid tracker data, resulting in:

    BUG: unable to handle page fault for address: 00000010000003b0

The patch I submitted last week resolves all of the above issues and has
no refcount leaks for this particular code path. In order to avoid the
refcount leaks, those _put() calls in ax25_release need to be balanced
by _hold() calls when accepting a new connection (or we need to wrap
them in a conditional so that they're not called when ax25->dev_tracker
is NULL).

GDB commands:

    define ax-devs
      set $x = ax25_dev_list
      while ($x != 0)
        printf "%s ax_refcnt:%d dev_refcnt:%d dev_untracked:%d dev_notrack:%d\n", $x->dev->name, \
          $x->refcount->refs->counter, \
          $x->dev->dev_refcnt->refs->counter, \
          $x->dev->refcnt_tracker->untracked->refs->counter, \
          $x->dev->refcnt_tracker->no_tracker->refs->counter
        set $x = $x->next
      end
    end

    define ax-sockets
      set $x = ax25_list->first
      while ($x != 0)
        set $cb = (ax25_cb *)($x)

        printf "%s if:%s state:%d refcnt:%d dev_tracker:%s\n", \
          $_as_string($cb), \
          $cb->ax25_dev->dev->name, \
          $cb->state, \
          $cb->refcount->refs->counter, \
          $_as_string($cb->dev_tracker)
        set $x = $x->next
      end
    end

[1]: https://marc.info/?l=linux-hams&m=171447153903965&w=2

--
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS

