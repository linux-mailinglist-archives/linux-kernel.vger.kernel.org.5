Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7737F563A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjKWB6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjKWB6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:58:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5E51AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:58:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BCCC433C7;
        Thu, 23 Nov 2023 01:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700704717;
        bh=k/Kqifw95eX22wpJAL4068fjhEgemFbnYz4GNnlPpnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ALm9+4FKhue6uXJoWhd7z/bgKK5xvZGxBBsllEkV4FK7FrGTrnyIhguBcrlUz8I5r
         CzhyTjRRLa8zreSX8sYEIDWVbhvXMmVetZetYMprcfIUKkIBzshnAhRGQIBz2n8xlx
         CD5TWbtmJFReBiyt1E673rMPMY3us/ohUTYsRQ/7UZgPYtaXG3rOySdUvPRmZZ7tHK
         /wnjuhX4hZ2Byt8LhAmGZjLvORDVSB8ocpblll6yVMUdsJEijK6a4MBI4WljYL+nEr
         1EP5j49Dl6JawbJj1CoGH6T2BUCUqU2KJDqirWrS80XKBWeJLsLmr6BWabNK3i4mUu
         YPKZFP3ULQw+w==
Date:   Thu, 23 Nov 2023 10:58:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 0/2] bootconfig: Support early options in embedded
 config
Message-Id: <20231123105833.419a9cda0fc25f45a877b436@kernel.org>
In-Reply-To: <20231121231342.193646-1-oss@malat.biz>
References: <20231121231342.193646-1-oss@malat.biz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Thanks for the patch.

On Wed, 22 Nov 2023 00:13:40 +0100
Petr Malat <oss@malat.biz> wrote:

> These 2 patches add a support for specifying early options in embedded
> bootconfig and merging embedded and initrd bootconfig into one.
> 
> To allow handling of early options, it's necessary to eliminate allocations
> from embedded bootconfig handling, which can be done by parsing the config
> data in place and allocating xbc_nodes array statically.

Hm, my concern is that this can introduce some sort of overhead to parse
the bootconfig.

> 
> Later, when initrd is available, it either replaces embedded data or is
> appended to them. To append initrd data, it's necessary to relocate already
> parsed data to a bigger memory chunk, but that's not a problem, because
> xbc_node structure uses offsets and not absolute pointers.

However, as you did on this series, it is OK that it does an additional parse
for the initrd bootconfig (do not parse twice)

Let me comment your patch.

Thanks!

> 
> Also, update the documentation to make users aware early options can't be
> configured in the initrd.
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
