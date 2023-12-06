Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC7A8070EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378573AbjLFNbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378484AbjLFNbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:31:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1779D45
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:31:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3A0C433C8;
        Wed,  6 Dec 2023 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701869498;
        bh=OwMR4dVuXI2wfzttIoneLd+lFsP/aVlEanurpdeSjC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaS6U7HiH6L2Jq0Tm6s3ajg0QihHhtirXUWp2jr/7bjP0yZnvm5rNWGg26VCENBHa
         1/cBP/Dwa3q4PlQMNSoIUgk1NOIZWv4cIetvO9yokKs+BHMMvOiwTPAH+ovtyysPOA
         k1mnQPCDqwpRJgK9mueMRSMBH1cQSaMeqIi/cr54=
Date:   Wed, 6 Dec 2023 22:31:36 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: base: Introduce a new kernel parameter
 driver_sync_probe=
Message-ID: <2023120644-pry-worried-22a2@gregkh>
References: <20231206115355.4319-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206115355.4319-1-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 11:53:55AM +0000, Yafang Shao wrote:
> After upgrading our kernel from version 4.19 to 6.1, certain regressions
> occurred due to the driver's asynchronous probe behavior. Specifically,
> the SCSI driver transitioned to an asynchronous probe by default, resulting
> in a non-fixed root disk behavior. In the prior 4.19 kernel, the root disk
> was consistently identified as /dev/sda. However, with kernel 6.1, the root
> disk can be any of /dev/sdX, leading to issues for applications reliant on
> /dev/sda, notably impacting monitoring systems monitoring the root disk.

Device names are never guaranteed to be stable, ALWAYS use a persistant
names like a filesystem label or other ways.  Look at /dev/disk/ for the
needed ways to do this properly.

> To address this, a new kernel parameter 'driver_sync_probe=' is introduced
> to enforce synchronous probe behavior for specific drivers.

This should be a per-bus thing, not a driver-specific thing as drivers
for the same bus could have differing settings here which would cause a
mess.

Please just revert the scsi bus functionality if you have had
regressions here, it's not a driver-core thing to do.

thanks,

greg k-h
