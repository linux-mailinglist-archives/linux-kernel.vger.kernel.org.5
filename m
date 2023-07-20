Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FDF75A363
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjGTAWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGTAWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:22:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E24526B2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C276133D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B817C433C7;
        Thu, 20 Jul 2023 00:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689812532;
        bh=iOhtG18Xjx35RfOoBf0pJWVGi8TqQirc725rJUlwmzk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lDAkS2y/rn4oqw1FHxQLNGIklfDbgrJoCMbXTU7b//CGZq15PX6F/Y6htgT7/H+0B
         4gM9BVSeU4xNQ3Knbc52XgNboDZKrKSKIPZY+p+WRmBK2izjDflj4Yu6dwmRITciQ6
         03Fb4GjlVMplSqJJpeXni/KCvfD1WRWFe4owrQuSnS7efq/xgUGniAgAX5adsRMYWG
         LY+4V1vgN4kd6imrz9r20g5h78H+dIf04xQaG+898vINATyKh18QK3rSizEEtR5N8X
         OwPURvG25OOCPlt6AfYt7kOieFSkynrOlWygY5ESJl3ZD66LF4l59TXtL7UvMC6Av8
         nlVq06NNKB5OA==
Date:   Wed, 19 Jul 2023 17:22:09 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
cc:     Rahul Singh <rahul.singh@arm.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jane Malalane <jane.malalane@citrix.com>
Subject: Re: [PATCH v3] xen/evtchn: Introduce new IOCTL to bind static
 evtchn
In-Reply-To: <9a917f42-1a22-0c75-459e-db30c17dbe78@epam.com>
Message-ID: <alpine.DEB.2.22.394.2307191722010.3118466@ubuntu-linux-20-04-desktop>
References: <ae7329bf1713f83e4aad4f3fa0f316258c40a3e9.1689677042.git.rahul.singh@arm.com> <9a917f42-1a22-0c75-459e-db30c17dbe78@epam.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-27211591-1689812531=:3118466"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-27211591-1689812531=:3118466
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 18 Jul 2023, Oleksandr Tyshchenko wrote:
> On 18.07.23 14:31, Rahul Singh wrote:
> 
> 
> Hello Rahul
> 
> 
> > Xen 4.17 supports the creation of static evtchns. To allow user space
> > application to bind static evtchns introduce new ioctl
> > "IOCTL_EVTCHN_BIND_STATIC". Existing IOCTL doing more than binding
> > that’s why we need to introduce the new IOCTL to only bind the static
> > event channels.
> > 
> > Static evtchns to be available for use during the lifetime of the
> > guest. When the application exits, __unbind_from_irq() ends up being
> > called from release() file operations because of that static evtchns
> > are getting closed. To avoid closing the static event channel, add the
> > new bool variable "is_static" in "struct irq_info" to mark the event
> > channel static when creating the event channel to avoid closing the
> > static evtchn.
> > 
> > Also, take this opportunity to remove the open-coded version of the
> > evtchn close in drivers/xen/evtchn.c file and use xen_evtchn_close().
> > 
> > Signed-off-by: Rahul Singh <rahul.singh@arm.com>
> > ---
> > v3:
> >   * Remove the open-coded version of the evtchn close in drivers/xen/evtchn.c
> 
> Thanks!
> 
> Looks like there is one unmentioned change in change-log since v2:
> * Make sure that evtchn hasn't been added yet before binding it in 
> evtchn_ioctl():case IOCTL_EVTCHN_BIND_STATIC
> 
> Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>
--8323329-27211591-1689812531=:3118466--
