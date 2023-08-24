Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5953A787227
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbjHXOsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbjHXOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:47:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB741FFC;
        Thu, 24 Aug 2023 07:47:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77E676216C;
        Thu, 24 Aug 2023 14:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889CAC433C8;
        Thu, 24 Aug 2023 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888406;
        bh=XaLad8c3FFxan6MChr8kjHNDmDO3HQzJbIWCTcuwUd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gm1mfzQDeLOeZi444RPNl6ZdTNOreRbX09ftbet83kK42U0ol1vN/EOR0cjsOdjJQ
         hhO0cI3D6+Tev3TjthHvkV+1aIi9qxjUuledfaHPZPS7oomUufJNQkPLzsIiA8ZWJk
         4OBLFGmgw01WiZQqXH4LEuz1whUKLYtHvpMK/kB8=
Date:   Thu, 24 Aug 2023 16:46:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1] KVM: x86/mmu: Fix an sign-extension bug with mmu_seq
 that hangs vCPUs
Message-ID: <2023082436-chaps-kinfolk-8588@gregkh>
References: <20230824010104.2714198-1-seanjc@google.com>
 <2023082423-ninetieth-hamlet-54dc@gregkh>
 <ZOdfU1zQ4UCQNVpz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOdfU1zQ4UCQNVpz@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 06:46:59AM -0700, Sean Christopherson wrote:
> On Thu, Aug 24, 2023, Greg Kroah-Hartman wrote:
> > On Wed, Aug 23, 2023 at 06:01:04PM -0700, Sean Christopherson wrote:
> > > Note, upstream commit ba6e3fe25543 ("KVM: x86/mmu: Grab mmu_invalidate_seq
> > > in kvm_faultin_pfn()") unknowingly fixed the bug in v6.3 when refactoring
> > > how KVM tracks the sequence counter snapshot.
> > > 
> > > Reported-by: Brian Rak <brak@vultr.com>
> > > Reported-by: Amaan Cheval <amaan.cheval@gmail.com>
> > > Reported-by: Eric Wheeler <kvm@lists.ewheeler.net>
> > > Closes: https://lore.kernel.org/all/f023d927-52aa-7e08-2ee5-59a2fbc65953@gameservers.com
> > > Fixes: a955cad84cda ("KVM: x86/mmu: Retry page fault if root is invalidated by memslot update")
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > What is the git commit id of this change in Linus's tree?
> 
> There is none.  Commit ba6e3fe25543 (landed in v6.3) unknowingly fixed the bug as
> part of a completely unrelated refactoring.

Ah, missed that in the text here, thanks!

greg k-h
