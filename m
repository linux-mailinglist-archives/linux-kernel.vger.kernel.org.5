Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461097C6711
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378036AbjJLHvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343708AbjJLHvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:51:31 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944A7C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Es7QN2GEuzhlQdl0k2scO4nnsg4P8+3YcCL5L8h6RlA=;
  b=UGcSCDh23Bz2f36LsEoJPPGkcVvqGmN678hSB70f31nwLBZmObbvWSv1
   tcpWdZ6m6/un2kLdQLhD3OgAJF9WSxUM4uI+JZ0U8/IvLMae3CTqKCKjE
   iYHAu3SzTvS75yUa+7q8QGmgKnr3TNSkwg+7L6EizcRYgFKkgsNV+zqbe
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,218,1694728800"; 
   d="scan'208";a="68479733"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:51:27 +0200
Date:   Thu, 12 Oct 2023 09:51:27 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Soumya Negi <soumya.negi97@gmail.com>
cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Micky Ching <micky_ching@realsil.com.cn>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Parenthesize macro arguments
In-Reply-To: <20231012074837.GE16374@Negi>
Message-ID: <a1556f74-83ef-d32-103d-6b0b0233473@inria.fr>
References: <20231012050240.20378-1-soumya.negi97@gmail.com> <81d6e283-fd87-4fd6-964f-22cbf420cdaa@kadam.mountain> <20231012074837.GE16374@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Oct 2023, Soumya Negi wrote:

> Hi Dan,
>
> On Thu, Oct 12, 2023 at 09:33:07AM +0300, Dan Carpenter wrote:
> > On Wed, Oct 11, 2023 at 10:02:40PM -0700, Soumya Negi wrote:
> > > Use parenthesis with macro arguments to avoid possible precedence
> ...
> > >   */
> > >  #define rtsx_writel(chip, reg, value) \
> > > -	iowrite32(value, (chip)->rtsx->remap_addr + reg)
> > > +	iowrite32(value, (chip)->rtsx->remap_addr + (reg))
> >
> > These would be better as functions instead of defines.
>
> There are actually more macros in the code. Should all of
> them be redefined as functions? The original code looks like this:

You should make a static inline function if you can.  That would require
that the parameter types are the same at all call sites and that all of
the arguments are used as values, not eg as the left side of an assignment
(looks fine here).

>
> /*
>  * macros for easy use
>  */
> #define rtsx_writel(chip, reg, value) \
> 	iowrite32(value, (chip)->rtsx->remap_addr + reg)
> #define rtsx_readl(chip, reg) \
> 	ioread32((chip)->rtsx->remap_addr + reg)
> #define rtsx_writew(chip, reg, value) \
> 	iowrite16(value, (chip)->rtsx->remap_addr + reg)
> #define rtsx_readw(chip, reg) \
> 	ioread16((chip)->rtsx->remap_addr + reg)
> #define rtsx_writeb(chip, reg, value) \
> 	iowrite8(value, (chip)->rtsx->remap_addr + reg)
> #define rtsx_readb(chip, reg) \
> 	ioread8((chip)->rtsx->remap_addr + reg)
>
> #define rtsx_read_config_byte(chip, where, val) \
> 	pci_read_config_byte((chip)->rtsx->pci, where, val)
>
> #define rtsx_write_config_byte(chip, where, val) \
> 	pci_write_config_byte((chip)->rtsx->pci, where, val)
>
> #define wait_timeout_x(task_state, msecs)	\
> do {						\
> 	set_current_state((task_state));	\
> 	schedule_timeout((msecs) * HZ / 1000);	\
> } while (0)
> #define wait_timeout(msecs)	wait_timeout_x(TASK_INTERRUPTIBLE, (msecs))
>
> > >  	pci_read_config_byte((chip)->rtsx->pci, where, val)
> > > @@ -131,8 +131,8 @@ static inline struct rtsx_dev *host_to_rtsx(struct Scsi_Host *host)
> > >   * The scsi_lock() and scsi_unlock() macros protect the sm_state and the
> > >   * single queue element srb for write access
> > >   */
> > > -#define scsi_unlock(host)	spin_unlock_irq(host->host_lock)
> > > -#define scsi_lock(host)		spin_lock_irq(host->host_lock)
> > > +#define scsi_unlock(host)	spin_unlock_irq((host)->host_lock)
> > > +#define scsi_lock(host)		spin_lock_irq((host)->host_lock)
> >
> > For these ones, the name is too generic.  probably the right thing is
> > to just get rid of them completely and call spin_lock/unlock_irq()
> > directly.
>
> I understand that there should be 2 different patches, one for the
> macro-to-function rewrites & one for replacing the scsi lock/unlock macros with
> direct spinlock calls. But, should these be in a patchset(they are vaguely
> related since the patches together would get rid of the checkpatch warnings)?
> I'm not sure.

Patch set, since they affect the same file.  Otherwise, Greg doesn't know
in what order to apply them.

julia
