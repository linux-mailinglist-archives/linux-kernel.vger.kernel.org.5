Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DD77CDB56
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjJRML0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjJRMLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:11:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D6311D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:11:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392DFC433C7;
        Wed, 18 Oct 2023 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697631082;
        bh=4MLSoNAMnFdfkyMJ9V/sCOwUBrn7iUfYY1QBvTejZKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=et4vpI080XMgMIsKYaH3K5bni2cUH1sN165jKtpMoW3ZXS0AHeEGjI2Iyqxyk8Z8a
         Icr+FbJ5/WuOeOqg7jPP6XbC5In2wb3REy816qxwM6s8br6ujBv71z9lMpy1VLJoV4
         9hZUq/d49YSf2fYA8keVp8TfUV/XSPz3KV+ROvdw=
Date:   Wed, 18 Oct 2023 14:11:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 0/5] mlx5 ConnectX diagnostic misc driver
Message-ID: <2023101859-wanting-unmixed-7cfe@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
 <2023101858-underwire-donated-3ae9@gregkh>
 <20231018120025.GQ3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018120025.GQ3952@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:00:25AM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 18, 2023 at 10:31:23AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 18, 2023 at 01:19:36AM -0700, Saeed Mahameed wrote:
> > > Historically a userspace program was used that accessed the PCI register
> > > and config space directly through /sys/bus/pci/.../XXX and could operate
> > > these debugging interfaces in parallel with the running driver.
> > > This approach is incompatible with secure boot and kernel lockdown so this
> > > driver provides a secure and restricted interface to that.
> > 
> > Why not just write a UIO driver for this hardware then?
> 
> The old mechanism relied on direct config space and sometimes mmio
> access to the PCI device. We did a security analysis and concluded
> that approach could not provide the required security for what our
> customers want from the secure boot and lockdown modes. We cannot
> allow a lockdown userspace direct access to those device registers.
> 
> So, it was redesigned to be RPC driven instead of having direct HW
> access. The RPCs allow the device to provide the required level of
> security.
> 
> This new misc driver does not expose any HW registers or interrupts to
> userspace, so it does not seem like a fit for UIO.

Ok, I'll not complain, I always like "real" drivers instead of UIO ones,
nice to see this happen!

thanks,

greg k-h
