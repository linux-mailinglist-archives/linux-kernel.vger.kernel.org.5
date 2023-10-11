Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D637C4E83
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjJKJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjJKJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:25:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096C91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:25:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA638C433C8;
        Wed, 11 Oct 2023 09:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697016321;
        bh=H6hczvEGO5lDOEmW4bdM01igMaYzI5yA6f/BcJPMAOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4jF+XmrdukufeT4JGseh7EHMH6K0d+at2C4b79eGN8CrJEVqPMRB2aPfVMqoIx0l
         1l1IccuQR6q6lzkyWVW4m27Z27pw0oos2Bo0m4+vbiFdvp8ELn+4Z9CDM0Ki6CUWWE
         Xix480nXqB+7mo6GSwQo30yokMLEsDc+E80INVt8=
Date:   Wed, 11 Oct 2023 11:25:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     wsa@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com,
        Richard.Gong@amd.com, kai.heng.feng@canonical.com,
        sebastian.reichel@collabora.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3] usb: typec: ucsi: Use GET_CAPABILITY attributes data
 to set power supply scope
Message-ID: <2023101102-pointless-causing-2269@gregkh>
References: <20231009184643.129986-1-mario.limonciello@amd.com>
 <ZSUOcdtWQ/AlAH+c@kuha.fi.intel.com>
 <1e8c1db9-5d52-4b39-8bdf-7d7d70ed1157@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e8c1db9-5d52-4b39-8bdf-7d7d70ed1157@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:49:35PM -0500, Mario Limonciello wrote:
> On 10/10/2023 03:42, Heikki Krogerus wrote:
> > On Mon, Oct 09, 2023 at 01:46:43PM -0500, Mario Limonciello wrote:
> > > On some OEM systems, adding a W7900 dGPU triggers RAS errors and hangs
> > > at a black screen on startup.  This issue occurs only if `ucsi_acpi` has
> > > loaded before `amdgpu` has loaded.  The reason for this failure is that
> > > `amdgpu` uses power_supply_is_system_supplied() to determine if running
> > > on AC or DC power at startup. If this value is reported incorrectly the
> > > dGPU will also be programmed incorrectly and trigger errors.
> > > 
> > > power_supply_is_system_supplied() reports the wrong value because UCSI
> > > power supplies provided as part of the system don't properly report the
> > > scope as "DEVICE" scope (not powering the system).
> > > 
> > > In order to fix this issue check the capabilities reported from the UCSI
> > > power supply to ensure that it supports charging a battery and that it can
> > > be powered by AC.  Mark the scope accordingly.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
> > > Link: https://www.intel.com/content/www/us/en/products/docs/io/universal-serial-bus/usb-type-c-ucsi-spec.html p28
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > 
> > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Thanks!
> 
> Greg, this behavior is pretty awful with the hang at bootup on these OEM
> systems, do you think this can come into one of the 6.6-rcX or should it
> wait until 6.7?

I'll queue it up for 6.6-final, thanks.

greg k-h
