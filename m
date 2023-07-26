Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B616E762D24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjGZHWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjGZHWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:22:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12C54C24;
        Wed, 26 Jul 2023 00:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 263F161536;
        Wed, 26 Jul 2023 07:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F35DC433C8;
        Wed, 26 Jul 2023 07:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690355903;
        bh=Lmm+4McdjfF7XNhSI+TigH314Z3lKfBItXi5XhHhA/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PchRafcDVLFtMd90/7z41tLGON8pwMw//Ta/zKZvcxeiFlRP9ksoiI/+R4p0SltvF
         i/SIjUOr7es2D3cNbuDA0Pd3t5ySWrJ2CCdmvs/EZ/FJZcTk6dmCwvc1qnasOrYRpb
         LoUpVwyga+unCQAYm7VPDB0zoVI+KvX1mTSnnjJ0=
Date:   Wed, 26 Jul 2023 09:18:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     liulongfang <liulongfang@huawei.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:bugfix a controller halt error
Message-ID: <2023072629-unblended-perky-4732@gregkh>
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <2023072153-module-wannabe-5637@gregkh>
 <bc2cd818-c7ad-9061-29ce-f5390d44d8ab@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc2cd818-c7ad-9061-29ce-f5390d44d8ab@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 02:44:01PM +0800, liulongfang wrote:
> On 2023/7/21 19:08, Greg KH Wrote:
> > On Fri, Jul 21, 2023 at 06:00:15PM +0800, liulongfang wrote:
> >> On systems that use ECC memory. The ECC error of the memory will
> >> cause the USB controller to halt. It causes the usb_control_msg()
> >> operation to fail.
> > 
> > Why does ECC memory matter here?
> >
> 
> This is a test conducted under a special test scenario.
> ECC memory errors are caused by some test tools.

What memory is failing, and why does just this single check matter in
the whole kernel?

If hardware is broken, and failing, it's not the job of the kernel to
protect against that, is it?  Shouldn't the ECC memory controller have
properly notified the kernel of the fault and reset the machine because
it is now in an undetermined state?

> > Are you sure this is correct?  How was this tested?  Seems to me that
> > this will still return "success" if this code path ever happens, what am
> 
> You are right. I made a patch error here. The code modification should be like this:
> if (r < 0) {
> 	retval = r;
> 	kfree(buf);
> 	goto fail;
> }

This means that you didn't test this change at all, so I don't really
think it is needed :(

thanks,

greg k-h
