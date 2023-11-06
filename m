Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD24B7E2D0A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjKFTiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjKFTho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:37:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFC52680
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:36:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B613C433C9;
        Mon,  6 Nov 2023 19:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699299389;
        bh=PC036ppUz7C4L5kB89KO0BjzFfQ01aHfnnR0bvNZbAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uR8a3PRe6zCNA3GOFmEFH9iL9/ErOo9tQW5mogLRpy1F9f4PZFpBDxc0WZeGYhhiy
         bke5I9Wp8PsmJfB+4eBYwDufKLHyVdqFy+LB4ZYbnyPE9oNc1qwfxKvE3ODIN5XyHA
         yY+p3TAyqU/evSA3h2k2FD2Zxv9rmwsK/hIP13sQ=
Date:   Mon, 6 Nov 2023 20:36:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     johannes@sipsolutions.net, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devcoredump: Send uevent once devcd is ready
Message-ID: <2023110659-december-cranium-c98e@gregkh>
References: <1699280735-31482-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699280735-31482-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 07:55:35PM +0530, Mukesh Ojha wrote:
> dev_coredumpm() creates a devcoredump device and adds it
> to the core kernel framework which eventually end up
> sending uevent to the user space and later creates a
> symbolic link to the failed device. An application
> running in userspace may be interested in this symbolic
> link to get the name of the failed device.
> 
> In a issue scenario, once uevent sent to the user space
> it start reading '/sys/class/devcoredump/devcdX/failing_device'
> to get the actual name of the device which might not been
> created and it is in its path of creation.
> 
> To fix this, suppress sending uevent till the failing device
> symbolic link gets created and send uevent once symbolic
> link is created successfully.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

What commit id does this fix?  What in-kernel driver does this affect
that is using devcoredump?

thanks,

greg k-h
