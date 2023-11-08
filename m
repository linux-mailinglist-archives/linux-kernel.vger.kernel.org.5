Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9EF7E5A94
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjKHP40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjKHP4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:56:23 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 160E71FDC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:56:20 -0800 (PST)
Received: (qmail 1021850 invoked by uid 1000); 8 Nov 2023 10:56:19 -0500
Date:   Wed, 8 Nov 2023 10:56:19 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guan-Yu Lin <guanyulin@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     gregkh@linuxfoundation.org, len.brown@intel.com, pavel@ucw.cz,
        heikki.krogerus@linux.intel.com, mkl@pengutronix.de,
        hadess@hadess.net, mailhol.vincent@wanadoo.fr,
        ivan.orlov0322@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pumahsu@google.com, raychi@google.com, albertccwang@google.com
Subject: Re: [PATCH] rpm: pm: enable PM_RPM_EXCEPTION config flag
Message-ID: <3fe5414a-570f-4bfa-aa2f-909d7799551b@rowland.harvard.edu>
References: <20231031093921.755204-1-guanyulin@google.com>
 <f75d6cd2-fa9f-4820-969f-2a8839d78c9e@rowland.harvard.edu>
 <CAOuDEK0NcijUKAL3fGtO=Ks+Y38TRhJcVx+ff-QUyUA0LcQ1Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuDEK0NcijUKAL3fGtO=Ks+Y38TRhJcVx+ff-QUyUA0LcQ1Bw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 04:45:43PM +0800, Guan-Yu Lin wrote:
> Thanks for the questions. Let me first introduce my motivation for
> proposing this feature. We can discuss the implementation details later.
> 
> Motivation:
> Currently, system PM operations always override runtime PM operations.
> As runtime PM reflects the power status of devices, there is a
> possibility that runtime PM states that a device is in use, but system
> PM decides to suspend it. Up to now, we have assumed that a device can't
> function without resources from the system, so the device should acquire
> a wakelock to prevent this from happening. However, what if the device

[From the fact that you mention wakelocks, I assume that you're trying 
to implement something for Android systems rather than Linux systems 
in general.]

> does not need the system's support to function? Or only needs limited
> resources (e.g., only limited power source or clock) to function? In this
> situation, we would like to keep the device on but allow the system to
> suspend. This is an example where we would like devices to follow runtime
> PM rather than system PM.

To put it more simply, you want a way to leave some devices in an active 
state while the rest of the system is suspended.  It's not clear why you 
have dragged runtime PM into the discussion (apart from the obvious fact 
that you won't want to keep a device active if it isn't active already).

This sounds like a major change, not something to be done with a simple 
override.  You should discuss it with Rafael Wysocki and the linux-pm 
mailing list before trying to implement anything.

> Feature Supported:
> 1. Devices could control the priority of system PM and runtime PM during
>    runtime.

This seems like a totally unnecessary side issue.  Forget about runtime 
PM for the time being and concentrate instead on which devices you want 
to keep active.

> 2. The control should be at the device level, meaning that different
>    devices should control their own priorities.
> 
> Goal of This Patch:
> 1. Design a framework to support features above.
> 2. Apply it into usb for demonstration.

You may find that it is easier (and less work in the long run) to design 
the general framework and get it working than to concentrate on one 
particular subsystem.

Alan Stern
