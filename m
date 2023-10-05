Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202E97BA34A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbjJEPxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjJEPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84BE63ECF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:08:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DC5C43397;
        Thu,  5 Oct 2023 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696514904;
        bh=DK81/htK+2aR7Ilf7FzYj5ATkDZv3qQF17441LDLSQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPDVrJrdB0gzVcVk+AiFyKdrZVSNnQpfOQFIaFc4NtyGmObglYpZx69OaOGxp+ZER
         py5k8PfxXKyzgWa0b2AKIWe2JEdutccIbKszNnOyOg/Ez6fPRG84YUjD8WvCIk3BrB
         1WH+4nc063LUHU7aoVjg469gO4QNqrTV5AaHuY6vc7cpm4IpVL2RZemXP5b+Af5nYr
         GTtCI56AjK7ZEqTzzo2V0FRO/oCQXaDgSWFEBDAHo08W1lf4KelpMHDtumRkW9g5ZJ
         JwdncdvmnOcD4i/6EiMekH2hr+KBQnZeckZ/4DPy7A5qJ2qSB6IYT2/b6+BV6HqVpM
         9bEe+N6iDj5Eg==
Date:   Thu, 5 Oct 2023 16:08:16 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, will@kernel.org,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZR7DUK8/OHof3uAn@lpieralisi>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231005115630.GL682044@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005115630.GL682044@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 08:56:30AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 05, 2023 at 11:56:55AM +0200, Lorenzo Pieralisi wrote:
> > On Tue, Sep 26, 2023 at 02:52:13PM +0100, Catalin Marinas wrote:
> > 
> > [...]
> > 
> > > Anyway, the text looks fine to me. Thanks for putting it together
> > > Lorenzo.
> > 
> > Thanks !
> > 
> > > One thing not mentioned here is that pci-vfio still maps such memory as
> > > Device-nGnRnE in user space and relaxing this potentially creates an
> > > alias. But such alias is only relevant of both the VMM and the VM try to
> > > access the same device which I doubt is a realistic scenario.
> > 
> > A revised log, FWIW:
> 
> What is the plan here, do you want Ankit to resend the series with
> this text?

I have put together the text to summarize the discussions that led to
this patch; if that helps somehow, yes please, make it the commit log.

> There were no comments on patch 1/2?

I don't have enough background knowledge to make a statement on this
series' code, I just wanted to make sure the architectural details are
in the commit log so that it can help the reviewers and, if it makes
it to the kernel, future developers.

Thanks,
Lorenzo
