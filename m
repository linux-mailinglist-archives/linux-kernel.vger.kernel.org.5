Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616BB7DFEF2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 06:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjKCFxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 01:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjKCFxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 01:53:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB72CA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 22:53:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5115C433C7;
        Fri,  3 Nov 2023 05:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698990812;
        bh=SLDh5CRv5TerU2o1EBxZL6kLDkZ+m92HwcWGlcin2Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l36GQT4IS9SgDme6D1V6VJfiJ4NIIfbzjSgcULp2gv2xoZl4as+v23Vm6IeIjas9P
         zOyYl6rFRxei/LG9K/esfeKO5kuILIKoIyTNE61ReIwJeOYw+F/PNBAZS7qiEzUut/
         seWtOBfck9HldM0pbHGe21ldsL3nNUy0XEFUSkgs=
Date:   Fri, 3 Nov 2023 06:53:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drivers/comedi: copy userspace array safely
Message-ID: <2023110348-drained-tameness-b943@gregkh>
References: <20231102190848.51376-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102190848.51376-2-pstanner@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 08:08:49PM +0100, Philipp Stanner wrote:
> comedi_fops.c utilizes memdup_user() to copy a userspace array. This
> does not check for an overflow.

Is there potential for an overflow today?

> 
> Use the new wrapper memdup_array_user() to copy the array more safely.

How about saying something like:
	"Use the new function memdup_array_user() in case things change
	in the future which would prevent overflows if something were to
	change in the size of the structures".

Or something to the affect of "all is good today, but make it easy to be
correct in the future as well".

thanks,

greg k-h
