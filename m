Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2763C78CD48
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbjH2UCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbjH2UCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:02:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7598ACD9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:02:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0487A62CC0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100E8C433C7;
        Tue, 29 Aug 2023 20:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693339352;
        bh=JE20nn87VeHMvshyWGSGKYI7nCSbKrrYSpBfNqUMuvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cAlyhXnsGmJZbpRAfExbXqz+UJG/zVK+Rd73KpCAjHsXLBOvByfyIh8k9+G+LU7zT
         8M3qACrFHRCKO7/EeWNPet4AGflDTQaiEGPusWjezXPb+NR1pglbV+xhb4QeO+ITRy
         LzkW7d/8PKI0z+ol8rRdpAQ/NUKaMgYY9+vh38O/gMOOS8ZpleRW+tEMZzwGuAXQzK
         NKHGwEI0b2FARq0jYSKDgh84MidnRj+vldPPYUkf7BgwCfQSYI1THtbklO4pdieylB
         yFYJGeoUSheazLVVSFwtH0SZ4WsBIlvBp+sFuXidP8OnaL5Oe+KLbp6JhCwAFG4caR
         QPeuk4L1VHDAw==
Date:   Tue, 29 Aug 2023 15:02:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Valentin Sinitsyn <valesini@yandex-team.ru>
Cc:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, oe-kbuild-all@lists.linux.dev,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] PCI: Implement custom llseek for sysfs resource
 entries
Message-ID: <20230829200229.GA804314@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc7f3f3-b2a0-530d-9688-b725204e3270@yandex-team.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:22:54PM +0500, Valentin Sinitsyn wrote:
> On 25.08.2023 19:10, kernel test robot wrote:
> > Hi Valentine,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> [..]
> > All warnings (new ones prefixed by >>):
> > 
> >     drivers/pci/pci-sysfs.c:1268:12: warning: no previous prototype for 'pci_create_resource_files' [-Wmissing-prototypes]
> >      1268 | int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
> >           |            ^~~~~~~~~~~~~~~~~~~~~~~~~
> >     drivers/pci/pci-sysfs.c:1269:13: warning: no previous prototype for 'pci_remove_resource_files' [-Wmissing-prototypes]
> >      1269 | void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
> >           |             ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > drivers/pci/pci-sysfs.c:838:15: warning: 'pci_llseek_resource' defined but not used [-Wunused-function]
> >       838 | static loff_t pci_llseek_resource(struct file *filep,
> >           |               ^~~~~~~~~~~~~~~~~~~
> I'm not sure if I should do anything about it: arc doesn't HAVE_* anything
> PCI-related, and pci-sysfs doesn't seem to be written with this case in
> mind. Guarding pci_llseek_resource() with an #ifdef HAVE_AT_LEAST_SOMETHING
> is trivial, but it feels more like a patch to silence a bot than a proper
> fix.

Looks like it will require some untangling to figure out a nice fix,
but I think you *do* need to do something about it because I don't
want to add build errors on any arch.

Bjorn
