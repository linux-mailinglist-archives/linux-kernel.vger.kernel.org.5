Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C1B7A1A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjIOJ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjIOJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:26:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB80730DF;
        Fri, 15 Sep 2023 02:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694769910; x=1726305910;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Dl5e9nvtvoay6nbLKFpX4/b6GOacVIKhsuZx+SNWBWA=;
  b=N7sWQtSCkRjss5ezN0UDBcSZh26zmb1rpPHA9sM1fLAeqjQxh7xxwCBr
   F/XdTUv8xhMksLRphCPx7YBwGMYLsjyVsI4ph2+zVTqrgH+RCPIn5c6CJ
   CTeRlbWaJPYflXd+Qd32Y3eZXAWqMJnurRsxmfpmJ9bDPuwf9cmJ9IMB7
   SSDsTwflK0XjvgiEIuRhJbGa8ts10Oi6isZWu5gNypj4vRmsX/OsI3dm3
   J59oXd4LMO7alA+/yZB/TmjYI6qCbgjERPSK6EfXfpwudM7dgqaTL34ZE
   zPyqHndZSO/P6bnGee0P/hEwKk+KvTsFvO0ihXJvl1E7YE5o5/nzThWd2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="465571244"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="465571244"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="738264445"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="738264445"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:24:55 -0700
Date:   Fri, 15 Sep 2023 12:24:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH tty v1 06/74] serial: 8250: Use port lock wrappers
In-Reply-To: <20230914183831.587273-7-john.ogness@linutronix.de>
Message-ID: <4f44c64d-bd2-c10-8ae3-25f1b4594df@linux.intel.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de> <20230914183831.587273-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1271593363-1694769897=:2347"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1271593363-1694769897=:2347
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 14 Sep 2023, John Ogness wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> When a serial port is used for kernel console output, then all
> modifications to the UART registers which are done from other contexts,
> e.g. getty, termios, are interference points for the kernel console.
> 
> So far this has been ignored and the printk output is based on the
> principle of hope. The rework of the console infrastructure which aims to
> support threaded and atomic consoles, requires to mark sections which
> modify the UART registers as unsafe. This allows the atomic write function
> to make informed decisions and eventually to restore operational state. It
> also allows to prevent the regular UART code from modifying UART registers
> while printk output is in progress.
> 
> All modifications of UART registers are guarded by the UART port lock,
> which provides an obvious synchronization point with the console
> infrastructure.
> 
> To avoid adding this functionality to all UART drivers, wrap the
> spin_[un]lock*() invocations for uart_port::lock into helper functions
> which just contain the spin_[un]lock*() invocations for now. In a
> subsequent step these helpers will gain the console synchronization
> mechanisms.
> 
> Converted with coccinelle. No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-1271593363-1694769897=:2347--
