Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3255B7DC64E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbjJaGM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjJaGMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:12:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A58124
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:12:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE766C433D9;
        Tue, 31 Oct 2023 06:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698732201;
        bh=mX1jPYCn0+AEDM+4a8CmkQlaPHEBUqVezHwNQyB9nSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AquVzduCr/YEjxcv9gCE3V3I2UhpKBNHhgiS+fM+m9kVdNaHL/hdhaDJeOTYByymy
         7XbGu9wskR6P5cRN7msLLtKlnpate2Yytqm9LD7hrw7jbzKG5c+GrHyFP1fwLruROC
         jRb7p6veLxIUqXcSBWiH45cjXYoRgWw3FOUj/zNI=
Date:   Tue, 31 Oct 2023 07:03:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH] base/node.c: initialize the accessor list before
 registering
Message-ID: <2023103129-coming-geometric-8ac0@gregkh>
References: <20231030044239.971756-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030044239.971756-1-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 12:42:39AM -0400, Gregory Price wrote:
> The current code registers the node as available in the node array
> before initializing the accessor list.  This makes it so that
> anything which might access the accessor list as a result of
> allocations will cause an undefined memory access.
> 
> In one example, an extension to access hmat data during interleave
> caused this undefined access as a result of a bulk allocation
> that occurs during node initialization but before the accessor
> list is initialized.

Is this an in-kernel driver that causes this problem?

> 
> Initialize the accessor list before making the node generally
> available to the global system.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

What commit id does this fix?

thanks,

greg k-h
