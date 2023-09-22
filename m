Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0744A7AADCC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjIVJZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVJZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:25:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A576CCE;
        Fri, 22 Sep 2023 02:25:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E17C433C7;
        Fri, 22 Sep 2023 09:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695374743;
        bh=MwiAl2OmUZtagJvVNwfbJoo0d7SmvqIR/m1GHGeUvUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=exwkfWhBB7UHqxU9mxyvs2+oe4sgHDKS4tXpZFVeNZdzKEjUcyfzOjSGx85sMdXA4
         EFr2cbFHyK0lnY+cx5SoMp+55ZS5IM14IXl+ryDZhqn+BVqvZKDEK3kt8nekfOhOZj
         b9RXXR7+ORkemS06SxEv2K+Np7QGnk7lWa/6qI7Q=
Date:   Fri, 22 Sep 2023 11:25:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jitindar Singh, Suraj" <surajjs@amazon.com>
Cc:     "maz@kernel.org" <maz@kernel.org>,
        "vdonnefort@google.com" <vdonnefort@google.com>,
        "philmd@linaro.org" <philmd@linaro.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "qperret@google.com" <qperret@google.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandru.elisei@arm.com" <alexandru.elisei@arm.com>
Subject: Re: [PATCH stable 6.1.y 1/2] KVM: arm64: Prevent the donation of
 no-map pages
Message-ID: <2023092243-eliminate-unless-cc2b@gregkh>
References: <20230920192729.694309-1-surajjs@amazon.com>
 <878r903snv.wl-maz@kernel.org>
 <a64c30b027951c4c533dea858150e2e807a912b7.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a64c30b027951c4c533dea858150e2e807a912b7.camel@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 10:22:54PM +0000, Jitindar Singh, Suraj wrote:
> On Thu, 2023-09-21 at 08:13 +0100, Marc Zyngier wrote:
> > On Wed, 20 Sep 2023 20:27:28 +0100,
> > Suraj Jitindar Singh <surajjs@amazon.com> wrote:
> > > 
> > > From: Quentin Perret <qperret@google.com>
> > > 
> > > commit 43c1ff8b75011bc3e3e923adf31ba815864a2494 upstream.
> > > 
> > > Memory regions marked as "no-map" in the host device-tree routinely
> > > include TrustZone carev-outs and DMA pools. Although donating such
> > > pages
> > > to the hypervisor may not breach confidentiality, it could be used
> > > to
> > > corrupt its state in uncontrollable ways. To prevent this, let's
> > > block
> > > host-initiated memory transitions targeting "no-map" pages
> > > altogether in
> > > nVHE protected mode as there should be no valid reason to do this
> > > in
> > > current operation.
> > > 
> > > Thankfully, the pKVM EL2 hypervisor has a full copy of the host's
> > > list
> > > of memblock regions, so we can easily check for the presence of the
> > > MEMBLOCK_NOMAP flag on a region containing pages being donated from
> > > the
> > > host.
> > > 
> > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Tested-by: Vincent Donnefort <vdonnefort@google.com>
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Link:
> > > https://lore.kernel.org/r/20221110190259.26861-8-will@kernel.org
> > > [ bp: clean ]
> > 
> > What is this?
> 
> Noting any details about the backport. In this case it was a clean
> backport.
> 
> > 
> > > Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
> > 
> > What is the rationale for backporting this? It wasn't tagged as Cc:
> > to
> > stable for a reason: pKVM isn't functional upstream, and won't be for
> > the next couple of cycles *at least*.
> > 
> > So at it stands, I'm against such a backport.
> > 
> 
> The 2 patches were backported to address CVE-2023-21264.
> This one provides context for the proceeding patch.
> 
> I wasn't aware that it's non functional. Does this mean that the code
> won't be compiled or just that it can't actually be run currently from
> the upstream codebase?
> 
> I guess I'm trying to understand if the conditions of the CVE are a
> real concern even if it isn't technically functional.

Why do you think the CVE is actually even valid?  Who filed it and why?

Remember, CVEs almost never mean anything for the kernel, they are not
able to be given out by the kernel security team, and they just don't
make any sense for us.

I'll go drop these patches from the stable queues for now, and wait for
you all to agree what is happening here.

thanks,

greg k-h
