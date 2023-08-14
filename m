Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E2C77BCEA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjHNPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHNPYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49FE7E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5559963478
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6043CC433C7;
        Mon, 14 Aug 2023 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692026680;
        bh=qs1SjNIypkGp+C7wohPlxBLFU3leZyt0yoMJ9I6/Pj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWdF6Uzi1H8JnmoxAQCcvD5vAoM0wCDqkDzFxD18CDOzVV4cn1VdiaOfKrJQJSuwI
         GvdEEKCOU7wBzarwljNNld9jPrdTUm8MmGR18ccn4CkkqlyyPW6SM3cyYIgol6ZriR
         qE5+C3p23gu3/pJ1iEOm1ZdgCCB1iKaxHHNxjCeQ=
Date:   Mon, 14 Aug 2023 17:24:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yikebaer Aizezi <yikebaer61@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org
Subject: Re: WARNING in kernfs_remove_by_name_ns
Message-ID: <2023081404-stuffy-relic-d126@gregkh>
References: <CALcu4rbCwMHyi3w7Ruv=eRw-nq7+cxz8fJ+WCoN932mDjg-vBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALcu4rbCwMHyi3w7Ruv=eRw-nq7+cxz8fJ+WCoN932mDjg-vBg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 02:49:47PM +0800, Yikebaer Aizezi wrote:
> Hello,
> 
> When using Healer to fuzz the Linux-6.5-rc5,  the following crash
> was triggered.
> 
> HEAD commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f (tag: v6.5-rc5)
> git tree: upstream
> 
> And I also tried to reproduce this crash on Latest Linux-6.5-rc6, it
> still exist.

Great, can you work with the proper subsystem maintainers to resolve
this (hint, look at the traceback, it's not a sysfs issue...)

Wait:

> memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=8437 'syz-executor'
> loop1: detected capacity change from 0 to 32768
> BTRFS: device fsid 84eb0a0b-d357-4bc1-8741-9d3223c15974 devid 1
> transid 7 /dev/loop1 scanned by syz-executor (8437)
> BTRFS info (device loop1): using xxhash64 (xxhash64-generic) checksum algorithm
> BTRFS info (device loop1): disk space caching is enabled
> BTRFS info (device loop1): enabling ssd optimizations
> BTRFS info (device loop1): auto enabling async discard
> FAULT_INJECTION: forcing a failure.

You forced a failure, and look, things failed!

Success!

Why is this an issue, don't force failures, and then all should be good,
right?

thanks,

greg k-h
