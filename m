Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C497BDCD8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376600AbjJIMwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346634AbjJIMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:52:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6939893;
        Mon,  9 Oct 2023 05:52:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774D0C433C8;
        Mon,  9 Oct 2023 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696855923;
        bh=Gd/aUOkQ3dpFucjV6W8k2UydiSxe2oz68p9fiYKX+K0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYXb87BJOIbZNHpULMLqKQHXJCHAzg69J5v6nPr8DqAzWt92Z0FH1J15o4p07MySj
         1dKjpFLOKG8AGkZay3MfkzzdcEHqbQt3tPGIVnr9SxYNhNtBhcsC5+vwkK8KKQbec8
         nt/xrOFgtgN6o144blUbzhMfZxnWQTIRQm9eFZjM=
Date:   Mon, 9 Oct 2023 14:52:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongyu Xie <xy521521@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>, stable@kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH RESEND] xhci: Keep interrupt disabled in initialization
 until host is running.
Message-ID: <2023100943-underhand-wizard-6901@gregkh>
References: <1696847966-27555-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696847966-27555-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 04:09:26PM +0530, Prashanth K wrote:
> From: Hongyu Xie <xy521521@gmail.com>
> 
> [ Upstream commit a808925075fb750804a60ff0710614466c396db4 ]
> 
> irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
> in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
> It's possible that you will receive thousands of interrupt requests
> after initialization for 2.0 roothub. And you will get a lot of
> warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
> disabled?". This amount of interrupt requests will cause the entire
> system to freeze.
> This problem was first found on a device with ASM2142 host controller
> on it.
> 
> [tidy up old code while moving it, reword header -Mathias]
> 
> Cc: stable@kernel.org
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Link: https://lore.kernel.org/r/20220623111945.1557702-2-mathias.nyman@linux.intel.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <stable@vger.kernel.org> # 5.15
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---

Any specific reason you missed adding the extra blank line in this
version of the backport that the original added?  That is going to cause
problems in the future if other patches are added on top of this that
would be expecting it because it is that way in Linus's tree.

And why is this only relevant for 5.15.y?

thanks,

greg k-h
