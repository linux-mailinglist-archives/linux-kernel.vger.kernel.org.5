Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72187BB945
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjJFNhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjJFNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:37:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5839283
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:37:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B27EC433C8;
        Fri,  6 Oct 2023 13:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696599464;
        bh=UuJSYGmAh6rK9NuQvs+gSQo0Y9YEQ6o68p+4gUIe9fM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdE+FxrFaxnUzuhnsnrrrVZGGiqdqqGPdwFfkCgmaiK6k3/MaqVM5OEB436Zs+imZ
         XpuwhcQAOgq+nYz+q0F9MwgVkl39Z0SRxRjOYy57avhKMr2Jq35OKTTW67OxB2IFDs
         YbNxO4D9zursk1jFWlps+kG1HWN4Fuu/TlO1L+74=
Date:   Fri, 6 Oct 2023 15:37:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] staging: rtl8712: fix buffer overflow in
 r8712_xmitframe_complete()
Message-ID: <2023100645-vicinity-nuclei-3d84@gregkh>
References: <20230919092318.14837-1-Igor.A.Artemiev@mcst.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919092318.14837-1-Igor.A.Artemiev@mcst.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:23:18PM +0300, Igor Artemiev wrote:
> The value of pxmitframe->attrib.priority in r8712_issue_addbareq_cmd(),
> which dump_xframe() calls, is used to calculate the index for accessing 
> an array of size 16. The value of pxmitframe->attrib.priority can be 
> greater than 15, because the r8712_update_attrib() function can write 
> a value up to 31 to attrib.priority, and r8712_xmitframe_complete() 
> checks that pxmitframe->attrib.priority is less than 16 before 
> calling r8712_xmitframe_coalesce().

But that number comes from the hardware, so how can it ever be larger
than 15?

> Found by Linux Verification Center (linuxtesting.org) with SVACE.

How was this tested to verify that it can be triggered and that this
change solves anything?

You have read the kernel documentation for what is required when using
"research tools" like this, right?

thanks,

greg k-h
