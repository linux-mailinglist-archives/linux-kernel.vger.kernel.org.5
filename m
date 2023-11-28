Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700087FB65F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343930AbjK1JyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbjK1Jx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:53:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7825D10E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:54:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C879CC433C7;
        Tue, 28 Nov 2023 09:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701165244;
        bh=n+Ar5X9JSbp0izchwv6/lFQCJOtaNSaVKuhBCyJ0pnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1wjBmdoLl7hA6XpxnkWmlyKxAiYTdui/gybppPOw7NS+DRXo6/xBDKX/6If3IIf0+
         WGL5S78lFOV5BeHSOlVSI37fD5lory5sZTs8rL1trKebejjW+DFd8RzMrYykR/hl2f
         hKfMpDdYQyGqZ1Azxcv+rKHq1Jz2Y+OTHbl5XLoE=
Date:   Tue, 28 Nov 2023 09:54:01 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        initramfs@vger.kernel.org, stable@vger.kernel.org,
        Rob Landley <rob@landley.net>
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is
 given
Message-ID: <2023112826-cesspool-cabbie-06c5@gregkh>
References: <20231120011248.396012-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120011248.396012-1-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 08:12:48PM -0500, Stefan Berger wrote:
> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
> 
>   If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
>   default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
>   line.
> 
> This currently does not work when root= is provided since then
> saved_root_name contains a string and rootfstype= is ignored. Therefore,
> ramfs is currently always chosen when root= is provided.
> 
> The current behavior for rootfs's filesystem is:
> 
>    root=       | rootfstype= | chosen rootfs filesystem
>    ------------+-------------+--------------------------
>    unspecified | unspecified | tmpfs
>    unspecified | tmpfs       | tmpfs
>    unspecified | ramfs       | ramfs
>     provided   | ignored     | ramfs
> 
> rootfstype= should be respected regardless whether root= is given,
> as shown below:
> 
>    root=       | rootfstype= | chosen rootfs filesystem
>    ------------+-------------+--------------------------
>    unspecified | unspecified | tmpfs  (as before)
>    unspecified | tmpfs       | tmpfs  (as before)
>    unspecified | ramfs       | ramfs  (as before)
>     provided   | unspecified | ramfs  (compatibility with before)
>     provided   | tmpfs       | tmpfs  (new)
>     provided   | ramfs       | ramfs  (new)
> 
> This table represents the new behavior.
> 
> Fixes: 6e19eded3684 ("initmpfs: use initramfs if rootfstype= or root=  specified")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Rob Landley <rob@landley.net>
> Link: https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Who should take this patch?  Me?  Or someone else?

thanks,

greg k-h
