Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254377A4DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjIRP5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjIRP5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:57:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A6E270B;
        Mon, 18 Sep 2023 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695052509; x=1726588509;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=9mdSjBgak3X7CxWik+JVulIYQIwZzjIpi9uzcf4feQE=;
  b=De/fi7BxQvmSa9hdvh/ur5YXcXK6NWnTa/xopyFAQnE433NA5REc+x7i
   bBldD6snaG9rzkruN5nwxImGHk2T6TorLy2ccS7VXH/ph0knaaTn0Cq2Z
   aIX8b0Oe2EagY3KMfpLhNkDr2YbwntEykCAu4hqHW6EzOOBLT72vdeYUf
   L7dJs18sQABeZxQIYk5huaq6dewQT72Q0w3+hvaqfTeTqGUzBxHR5vMHL
   K1gTT6J2MScuO14YWAFohQV43q7kRqPmyP5zPJD9J1H4hw1NIxZJ4urdB
   4tQgut5UFoKAw0In/nCLh+REAC3X4b2fdjlmfzE8j1sZOe7g3jflpoIxF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="466000301"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="466000301"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="861064597"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861064597"
Received: from nprotaso-mobl1.ccr.corp.intel.com ([10.252.49.156])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:26:43 -0700
Date:   Mon, 18 Sep 2023 16:26:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Stephen Boyd <swboyd@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v4 2/4] platform/x86: intel_scu_ipc: Check status upon
 timeout in ipc_wait_for_interrupt()
In-Reply-To: <a0573057-8b93-f6f8-59eb-e8d30ac7035f@redhat.com>
Message-ID: <f3d06f3d-1dee-54c2-88b9-f33cfb86366@linux.intel.com>
References: <20230913212723.3055315-1-swboyd@chromium.org> <20230913212723.3055315-3-swboyd@chromium.org> <2bd9b7e2-a558-305b-bfd9-e64c28b6303d@linux.intel.com> <a0573057-8b93-f6f8-59eb-e8d30ac7035f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-543075989-1695043025=:1832"
Content-ID: <87977fa8-8a4f-18c8-6c6-1c2f8fd622cb@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-543075989-1695043025=:1832
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <d1a9ce37-d373-c568-271f-5872936c1b0@linux.intel.com>

On Mon, 18 Sep 2023, Hans de Goede wrote:
> On 9/15/23 15:49, Ilpo Järvinen wrote:
> > On Wed, 13 Sep 2023, Stephen Boyd wrote:
> > 
> >> It's possible for the completion in ipc_wait_for_interrupt() to timeout,
> >> simply because the interrupt was delayed in being processed. A timeout
> >> in itself is not an error. This driver should check the status register
> >> upon a timeout to ensure that scheduling or interrupt processing delays
> >> don't affect the outcome of the IPC return value.
> >>
> >>  CPU0                                                   SCU
> >>  ----                                                   ---
> >>  ipc_wait_for_interrupt()
> >>   wait_for_completion_timeout(&scu->cmd_complete)
> >>   [TIMEOUT]                                             status[IPC_STATUS_BUSY]=0
> >>
> >> Fix this problem by reading the status bit in all cases, regardless of
> >> the timeout. If the completion times out, we'll assume the problem was
> >> that the IPC_STATUS_BUSY bit was still set, but if the status bit is
> >> cleared in the meantime we know that we hit some scheduling delay and we
> >> should just check the error bit.
> > 
> > Hi,
> > 
> > I don't understand the intent here. What prevents IPC_STATUS_BUSY from 
> > changing right after you've read it in ipc_read_status(scu)? Doesn't that 
> > end you exactly into the same situation where the returned value is stale 
> > so I cannot see how this fixes anything, at best it just plays around the 
> > race window that seems to still be there after this fix?
> 
> As I understand it the problem before was that the function would
> return -ETIMEDOUT; purely based on wait_for_completion_timeout()
> without ever actually checking the BUSY bit:
> 
> Old code:
> 
> 	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT))
> 		return -ETIMEDOUT;
> 
> This allows for a scenario where when the IRQ processing got delayed
> (on say another core) causing the timeout to trigger,
> ipc_wait_for_interrupt() would return -ETIMEDOUT even though
> the BUSY flag was already cleared by the SCU.
> 
> This patch adds an explicit check for the BUSY flag after
> the wait_for_completion(), rather then relying on the
> wait_for_completion() return value which implies things
> are still busy.

Oh, I see, it's because the code is waiting for the completion rather than
the actual condition.

> As for "What prevents IPC_STATUS_BUSY from 
> changing right after you've read it in ipc_read_status(scu)?"
> 
> AFAICT in this code path the bit is only ever supposed to go
> from being set (busy) to unset (not busy), not the other
> way around since no new commands can be submitted until
> this function has completed. So that scenario cannot happen.

This is not what I meant.

I meant that if the code has decided to return -ETIMEDOUT, the status bit 
still change at that point which makes the return value to not match. This 
race is still there and given the changelog was a bit sparse on what race 
it was fixing I ended up noticing this detail.


-- 
 i.
--8323329-543075989-1695043025=:1832--
