Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DAF80EA48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346330AbjLLLXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:23:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11458D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:23:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE88C433C8;
        Tue, 12 Dec 2023 11:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702380229;
        bh=Yc6c1Duux/aJZRVG7ThxsBy8BNeRcHgqMI331FQ/0lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQeIAI1kJuI/5OuNNBvzd6M4m7J6nrtCoQ250xSXJJxIcgkTdwrAy27H5eQu2U7m8
         39AgFBelagybs6K9nmu7SmpfuBRfDR88+rrllFl0vdnRJXWe+avkZKgobfiB4D/tPc
         ha07K3CNSHmVJ6f+i/aKKVhmVrUAUKJl1xqWN+yKowuCISNJjfmcrUZOyj0LsumflV
         mzCp4BOOmxpPMelq6fiBgsNsZ2WaoQcZUjcmFENqQbWD5oxE9O6RQKruwjWCPc63G8
         5aMF3mnvbZwRc3daXLt5iQpnUJIjq61aHeIvpcCmaUl0TI5uzsAfM3123lfHkxqN7f
         HOatnoH+aeZ9Q==
Date:   Tue, 12 Dec 2023 11:23:44 +0000
From:   Simon Horman <horms@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v1 1/1] net: dl2k: Use proper conversion of
 dev_addr before IO to device
Message-ID: <20231212112344.GZ5817@kernel.org>
References: <20231208153327.3306798-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208153327.3306798-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 05:33:27PM +0200, Andy Shevchenko wrote:
> The driver is using iowriteXX()/ioreadXX() APIs which are LE IO
> accessors simplified as
> 
>   1. Convert given value _from_ CPU _to_ LE
>   2. Write it to the device as is
> 
> The dev_addr is a byte stream, but because the driver uses 16-bit
> IO accessors, it wants to perform double conversion on BE CPUs,
> but it took it wrong, as it effectivelly does two times _from_ CPU
> _to_ LE. What it has to do is to consider dev_addr as an array of
> LE16 and hence do _from_ LE _to_ CPU conversion, followed by implied
> _from_ CPU _to_ LE in the iowrite16().
> 
> To achieve that, use get_unaligned_le16(). This will make it correct
> and allows to avoid sparse warning as reported by LKP.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312030058.hfZPTXd7-lkp@intel.com/
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy,

I agree with your reasoning that the explicit conversion is reversed.

Reviewed-by: Simon Horman <horms@kernel.org>
