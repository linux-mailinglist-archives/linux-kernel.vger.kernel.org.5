Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52E97C9337
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjJNH3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNH3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:29:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E76C2;
        Sat, 14 Oct 2023 00:29:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DD7C433C7;
        Sat, 14 Oct 2023 07:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697268587;
        bh=t4c1adpH10ty/zfKFnqCTgo2DQwG7YdUBbzGZstMMQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdNQl4Z3hRpyFSPqeobB9ZK0gxWKCdp1JyTcopWAz6zURN9Fd8BAY496uKtEvJr/9
         nrNzpWOi0PicSKaw0lviGNM8e11yNWadmnEM4+W5jV1cjdGnBK1n/XmxO3vGwj6Cuf
         EBeuI8mJhWVNqz5Pwb0sC91EFukA61XXPiqZ0rUCR9DEN0ZU9HDXCxeP+YCOd+PV5r
         5orrKD9OsBBHf99gdgIUWq8X481Mk6SXFxGdjqtPmd9NR/TxpFNUFOL+bXLD/SPUL+
         MBU5N/OFi1v2nM1rMriYYW3q7wmk46I+3j9T5C16NOxae4Vtz2lhN9YawIQ+rYJNdU
         Nq6UnWzOQDkOA==
Date:   Sat, 14 Oct 2023 09:29:43 +0200
From:   Simon Horman <horms@kernel.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzbot+509238e523e032442b80@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] rfkill: fix deadlock in rfkill_send_events
Message-ID: <20231014072943.GV29570@kernel.org>
References: <20231013110638.GD29570@kernel.org>
 <20231014024321.1002066-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014024321.1002066-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 10:43:22AM +0800, Edward AD wrote:
> Hi Simon Horman,
> On Fri, 13 Oct 2023 13:06:38 +0200, Simon Horman wrote:
> > I am wondering if you considered moving the rfkill_sync() calls
> > to before &data->mtx is taken, to avoid the need to drop and
> > retake it?
> If you move rfkill_sync() before calling &data->mtx, more code will be added 
> because rfkill_sync() is in the loop body.

Maybe that is true. And maybe that is a good argument for
not taking the approach that I suggested. But I do think it
is simpler from a locking perspective, and that has some merit.

> > 
> > Perhaps it doesn't work for some reason (compile tested only!).
> > But this does seem somehow cleaner for me.
> BR,
> edward
> 
