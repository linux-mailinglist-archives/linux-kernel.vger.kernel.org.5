Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9580E627
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjLLI35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjLLI3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:29:43 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C792A325F;
        Tue, 12 Dec 2023 00:28:05 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 546A320B74C0; Tue, 12 Dec 2023 00:28:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 546A320B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1702369685;
        bh=E9qH6anoPIu1fFHlQdJcDaDMF2TZeaJBTSNCTizOVQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFYAT/+Lmsxa9SwAlA9n+5OHbwSCyty97O0d521bMKxld/+Ka3eJmK80OJBUpoXZz
         TetpPHNvq1W7jz22x0W382/PEScSES7rKFSNi4sTAJdZlP5jYuvhXn5Hnvv4i9q/Ux
         q1bnTzetUat6Rx442nYBO7eS8uAeWipb4Je6sq3M=
Date:   Tue, 12 Dec 2023 00:28:05 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, decui@microsoft.com
Subject: Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Message-ID: <20231212082805.GA3521@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com>
 <5736414.DvuYhMxLoT@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5736414.DvuYhMxLoT@steina-w>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 08:19:11AM +0100, Alexander Stein wrote:
> Hi Saurabh,
> 
> thanks for the patch.
> 
> Am Samstag, 9. Dezember 2023, 04:46:16 CET schrieb Saurabh Sengar:
> > Currently there is a race in calling pci_create_resource_files function
> > from two different therads, first therad is triggered by pci_sysfs_init
> > from the late initcall where as the second thread is initiated by
> > pci_bus_add_devices from the respective PCI drivers probe.
> > 
> > The synchronization between these threads relies on the sysfs_initialized
> > flag. However, in pci_sysfs_init, sysfs_initialized is set right before
> > calling pci_create_resource_files which is wrong as it can create race
> > condition with pci_bus_add_devices threads. Fix this by setting
> > sysfs_initialized flag at the end of pci_sysfs_init and direecly call the
> 
> Small typo here: direecly -> directly
> 
> > pci_create_resource_files function from it.
> > 
> > There can be an additional case where driver probe is so delayed that
> > pci_bus_add_devices is called after the sysfs is created by pci_sysfs_init.
> > In such cases, attempting to access already existing sysfs resources is
> > unnecessary. Fix this by adding a check for sysfs attributes and return
> > if they are already allocated.
> > 
> > In both cases, the consequence will be the removal of sysfs resources that
> > were appropriately allocated by pci_sysfs_init following the warning below.
> 
> I'm not sure if this is the way to go. Unfortunately I can't trigger this 
> error on my imx6 platform at the moment (apparently timing is off).
> But reading [1] again, the most expressive way is that pci_bus_add_devices() 
> needs to wait until pci_sysfs_init() has passed.

(I correct my self a bit in my earlier reply)
The problem with waiting is that sysfs entries will be created by pci_sysfs_init
already and when pci_bus_add_devices try to create it will observe that the
entries are already existing and in such case PCI code will remove the sysfs
entries created by pci_sysfs_init. Resulting system will be having no sysfs
entries.

- Saurabh
