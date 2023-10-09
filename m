Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2F17BE477
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376942AbjJIPR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376736AbjJIPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:17:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2870EA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:17:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D296C433B7;
        Mon,  9 Oct 2023 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696864671;
        bh=IxC3QSqPVebIUIRAWD+xhWprjzDHOIt3IBTBrp48heo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QSbOy7tie+ysnc34WLh7T8qM5g5Hep59jVakIVVg7b/MLulFFJE5pGb2GEvBqMXGP
         KnPwAWfAtpkN5ufKCIYccOCr0pHzqBOgPgWGVayiYQ3kTC8V8nhQEci7ZEfbkKpNr1
         dWuP2ig4eXLIFQYtUdJrBCCYEzfViD6GeE8o21oy8YYoi1kUdDEe78p8H/dA684ILU
         iqpceVibFcCNj/hVcRFLegXJWz4fcAvOEN80JOMXa+CpkPMfLyiKIjst/IFXBx6ehk
         vqoKVr/tZVUXoOR+jWI7fUWXRUkJoPfK3ASN++C+Ec0RxBwr7+yPGQ5F8Wdllz93uT
         mTUCc57DJgP3g==
Date:   Mon, 9 Oct 2023 08:17:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     3chas3@gmail.com, davem@davemloft.net, horms@kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] atm: solos-pci: Fix potential deadlock on
 &cli_queue_lock
Message-ID: <20231009081750.2073013d@kernel.org>
In-Reply-To: <CAAo+4rUE=+9Kp8CvMH3w15dJotkX03h=5YMV+hu-YSobkwj1NA@mail.gmail.com>
References: <20231005074858.65082-1-dg573847474@gmail.com>
        <20231006162835.79484017@kernel.org>
        <CAAo+4rUE=+9Kp8CvMH3w15dJotkX03h=5YMV+hu-YSobkwj1NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2023 23:58:36 +0800 Chengfeng Ye wrote:
> > and irqsave here. I think you're right that it's just softirq (== bh)
> > that may deadlock, so no need to take the irqsave() version in process
> > context.  
> 
> Yes, spin_lock_bh() is enough.
> 
> I just found spin_lock_irqsave() is more frequently used in this file, so I
> also used spin_lock_irqsave() here for uniformity consideration at that time.
> 
> Should I send a new patch series to change this to spin_lock_bh()? That's
> better for performance consideration.

Yes, performance is one reason and another is that the code will 
be easier to understand if the locking matches the requirements.
