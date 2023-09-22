Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735F37AAF81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjIVKaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjIVKaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:30:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F7E114
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:30:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8F6C433C7;
        Fri, 22 Sep 2023 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695378612;
        bh=4v5tPitvvC+iLh5RFLXHnFNkbavtiFXvg1aF+3bOFsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgQarKTdLtuxoaC4NZKosGRLyO8VBkWlWc/uslKv/kAXhLAelpEN1IA8A29XxxYvj
         pO60NDNcX/kApt9EUM9KHP2ba9SsyErlIx9AQ17C/woYow0Z6ah6SbfjUi0tkLrJQV
         9J+pvSfnF9SP3MIv9lICWFMbaDftHMjsTLvgUaCI=
Date:   Fri, 22 Sep 2023 12:30:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, Hongyu Xie <xy521521@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>, stable@kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: Keep interrupt disabled in initialization until
 host is running.
Message-ID: <2023092256-smudge-disallow-48d3@gregkh>
References: <1695374501-22649-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695374501-22649-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 02:51:41PM +0530, Prashanth K wrote:
> From: Hongyu Xie <xy521521@gmail.com>
> 
> [ Upstream commit 808925075fb750804a60ff0710614466c396db4 ]
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
> ---
>  drivers/usb/host/xhci.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)

What stable kernel(s) are you asking this to be applied to?

greg k-h
