Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84EE7BC88E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 17:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343994AbjJGPK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 11:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjJGPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 11:10:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED041B9;
        Sat,  7 Oct 2023 08:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72083C433C8;
        Sat,  7 Oct 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696691425;
        bh=LH6IWkmyMSvjK2Q3N3HjTHI8GVBa4KuURUr6eXtccys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIzj7hK0L/DbwMAVrxGzakiLql+kw3pXx1ew0g45ixAo3GNkeQrZzd9PuDWCWxF0Q
         9IBOXzzVpCsDt4JbpDmYgKUBKpNX66jLsOOr9tVCZ3XSODwohF1YU51Wz+vb8VDu74
         8Hmcp5ZInqFxhE0tUi7gjmR1snrHvZNqezzcM1Vyz/ZSBAYEgwoRvJzHA7kujsBVpi
         2REy0U1jFFh3BGvyd+PmEiqEfNdsyDXsBeKG+hQKKqnvjFFCyUT799FTz4+7oUYpCo
         YaRyhio3Qc2+RS1XQBg66Gx7nlykEqJT67KZ7rKF79iuhooOR4XCaxgUXM4A8/t7Fp
         XhWS0vNlAW3HQ==
Date:   Sat, 7 Oct 2023 17:10:21 +0200
From:   Simon Horman <horms@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     jreuter@yaina.de, ralf@linux-mips.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ax25: Fix potential deadlock on &ax25_list_lock
Message-ID: <20231007151021.GC831234@kernel.org>
References: <20231005072349.52602-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005072349.52602-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 07:23:49AM +0000, Chengfeng Ye wrote:
> Timer interrupt ax25_ds_timeout() could introduce double locks on
> &ax25_list_lock.
> 
> ax25_ioctl()
> --> ax25_ctl_ioctl()
> --> ax25_dama_off()
> --> ax25_dev_dama_off()
> --> ax25_check_dama_slave()
> --> spin_lock(&ax25_list_lock)
> <timer interrupt>
>    --> ax25_ds_timeout()
>    --> spin_lock(&ax25_list_lock)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch use spin_lock_bh()
> on &ax25_list_lock inside ax25_check_dama_slave().
> 
> Fixes: c19c4b9c9acb ("[AX.25]: Optimize AX.25 socket list lock")
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Hi Chengfeng Ye,

Are there other functions that spin_lock(&ax25_list_lock)
that also need to use spin_lock_bh()?

...
