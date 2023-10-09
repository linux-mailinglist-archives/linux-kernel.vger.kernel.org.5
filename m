Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5F7BE3AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346463AbjJIO4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346459AbjJIOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:55:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1C88F;
        Mon,  9 Oct 2023 07:55:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50892C433C8;
        Mon,  9 Oct 2023 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696863355;
        bh=b4xb+NjV8HwpVkf8km8Vp0zN8pTTrOozJrKIMoJyLcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWOqcytI+XckEtep8gcLcnVxKUZPsQKKDxNfus6FUyAOCrvufvZYWBcVrZPP5W2r2
         O8ZGaelEHzyp1zF6zwkfSJaOev5td/25Kt7raz/GgCo3qjdZknpJBgz1AbzkcX0RdN
         64GzL5ANpwg216deDrETDk+qX6so+f+Xmmd71DxI0jnPX9h/qayFTBdZcjh/lAnD+v
         pTmBxpSLfebiXyxinwVZ0g85L/WkfedPrSH4IsIDxJnxRB7WIXUscXysVK0vTMCiKN
         0OynMnvemuSieXrdqlZEx95o6ZmLQvAqNaT1L86LcrQrUsIRlrD8V33mU2BqdlMAvD
         idw1DnDLWNCbg==
Date:   Mon, 9 Oct 2023 16:55:50 +0200
From:   Simon Horman <horms@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     jreuter@yaina.de, ralf@linux-mips.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ax25: Fix potential deadlock on &ax25_list_lock
Message-ID: <ZSQUdhzSDpAlaeXK@kernel.org>
References: <20231005072349.52602-1-dg573847474@gmail.com>
 <20231007151021.GC831234@kernel.org>
 <CAAo+4rWTq33LWgVonaK+AtZ0o_UYFLrM=ODW=hSX_VtgLvYHNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAo+4rWTq33LWgVonaK+AtZ0o_UYFLrM=ODW=hSX_VtgLvYHNw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 11:43:59PM +0800, Chengfeng Ye wrote:
> Hi Simon Horman,
> 
> I think maybe not. My static analysis tool only reported this function, I
> also just manually checked the spin_lock(&ax25_list_lock) in other
> functions, and it looks like they are basically under rcv callback or timer,
> which already have BH disabled. I think the developers who wrote
> the code should be aware of this so they used spin_lock() instead of
> spin_lock_bh().
> 
> But the fixed function is a bit different, as it could be called from .ioctl(),
> which is from userland syscall and executes under the process
> context, and along the call chain BH is also not disabled explicitly. That's
> the reason why only at this place I change to spin_lock_bh().

Thanks,

I agree that seems to be the case.

Reviewed-by: Simon Horman <horms@kernel.org>
