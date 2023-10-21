Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7C37D1FB3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 23:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjJUVBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 17:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjJUVBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 17:01:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD83197
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 14:01:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A90C433C8;
        Sat, 21 Oct 2023 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697922062;
        bh=/7FhwT9KHbzyIHyGJPKE9GlSv/bKN0SmkZxHVjFhIhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xknAE6PfHfAth+H3gLKKf55Y1ZaBJ9QwNlseF0Fa7oO9wLTL4dxrcePv+uAZ3v1Ai
         m9ZYHWqSrcIC9oOcazNjF0bIFZVO6tUKfg8myUQXWRZW9AnOpr10ButqAVTtaMbHYu
         0Q2gqf8Cdku2FkI/XTLWiqp1X8iow6PCSGzDOu9s=
Date:   Sat, 21 Oct 2023 23:00:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc:     michal.simek@amd.com, tanmay.shah@amd.com,
        mathieu.poirier@linaro.org, ben.levinsky@amd.com,
        nava.kishore.manne@amd.com, marex@denx.de, robh@kernel.org,
        arnd@arndb.de, ruanjinjie@huawei.com, sai.krishna.potthuri@amd.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>
Subject: Re: [PATCH v3 1/5] firmware: xilinx: Update firmware call interface
 to support additional arg
Message-ID: <2023102105-frivolous-kindred-f566@gregkh>
References: <20231016111301.13369-1-jay.buddhabhatti@amd.com>
 <20231016111301.13369-2-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016111301.13369-2-jay.buddhabhatti@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 04:12:57AM -0700, Jay Buddhabhatti wrote:
> System-level platform management layer (do_fw_call()) has support for
> maximum of 5 arguments as of now (1 EEMI API ID + 4 command arguments).
> In order to support new EEMI PM_IOCTL IDs (Secure Read/Write), this
> support must be extended to support one additional argument, which
> results in a configuration of - 1 EEMI API ID + 5 command arguments.
> 
> Update zynqmp_pm_invoke_fn() and do_fw_call() with this new definition
> containing additional argument. As a result, update all the references
> to pm invoke function with the updated definition.

There are simpler ways to do this to keep from having to constantly add
new parameters that do nothing to the existing calls.  Why not do this
in #defines that handle multiple arguments, or even simply functions
that can have less arguments to prevent this constant churn you go
through.

That will also make it more obvious that the other arguments mean
nothing for most of these callers, which is a good thing.

What is going to happen when you need to add support for another
argument?

thanks,

greg k-h
