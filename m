Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0799D7B51A2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbjJBLpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjJBLpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:45:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D3EC;
        Mon,  2 Oct 2023 04:45:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9FBC433C8;
        Mon,  2 Oct 2023 11:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696247141;
        bh=icjqlZr6yaJOEPjZSqxvz3sMh4fSbBUkJFEUP00JluY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0kJq87fTCjDVun1Wf5/SoHnowBsa4oNHKsTHhAkI26pw6Da8Wq7zY+IopgN+bo/sm
         +IMENEnmFQezs0ri6cCQZFzN/WqDxRw+qLIG8zZmPuWpIZNhrgAnXJAJlTCXROytMx
         hRffJbL7O29f/TzmyMNX6gVQhSUgsvAsZCGvFHoA=
Date:   Mon, 2 Oct 2023 13:45:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Ben Dooks <ben@simtec.co.uk>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: dwc2: gadget: Fix a warning when compiling with W=1
Message-ID: <2023100226-cloak-tissue-7efa@gregkh>
References: <5cf603809388aa04c9a02bbfe3cf531c20bb043e.1695466447.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cf603809388aa04c9a02bbfe3cf531c20bb043e.1695466447.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 12:54:24PM +0200, Christophe JAILLET wrote:
> In order to teach the compiler that 'hs_ep->name' will never be truncated,
> we need to tell it that 'epnum' is not negative.
> 
> 'epnum' comes from in a 'for' loop in dwc2_gadget_init(), starting at 0
> and ending at 255. (hsotg->num_of_eps is a char)
> 
> When building with W=1, this fixes the following warnings:
> 
>   drivers/usb/dwc2/gadget.c: In function ‘dwc2_hsotg_initep’:
>   drivers/usb/dwc2/gadget.c:4804:55: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
>    4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%d%s", epnum, dir);
>         |                                                       ^~
>   drivers/usb/dwc2/gadget.c:4804:52: note: directive argument in the range [-2147483645, 255]
>    4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%d%s", epnum, dir);
>         |                                                    ^~~~~~~~
>   drivers/usb/dwc2/gadget.c:4804:9: note: ‘snprintf’ output between 6 and 17 bytes into a destination of size 10
>    4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%d%s", epnum, dir);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 5b7d70c6dbf2 ("USB: Gadget driver for Samsung HS/OtG block")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks like the kernel test robot didn't like this one :(
