Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E597A5BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjISHwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjISHwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:52:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E7410F;
        Tue, 19 Sep 2023 00:52:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978D1C433C8;
        Tue, 19 Sep 2023 07:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695109946;
        bh=njHjTnd9YJvAgThnzsTTDZkzqNUJIPmiGtcggS0SZnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkuASuenxh/TMElcg5CGQDucAGBtOl+j+LBR1qqyiTbun4RCf5z0R8G5mE8ggLB9x
         h66Eoo1VMZiNQGxBUlkcLoxI/kQQ3yA6ESHNK5khjw/sJqWgszYlWgXJeaNZe94WSE
         NderuRDBRQFT1cvmcltgQl9Ijy0drvHoDxLNmz9k=
Date:   Tue, 19 Sep 2023 09:52:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/511] 5.15.132-rc1 review
Message-ID: <2023091958-aware-whomever-059c@gregkh>
References: <20230917191113.831992765@linuxfoundation.org>
 <d51e5236-54b5-40fd-86b8-c19a16f56904@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51e5236-54b5-40fd-86b8-c19a16f56904@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:40:36AM -0700, Guenter Roeck wrote:
> On Sun, Sep 17, 2023 at 09:07:07PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.132 release.
> > There are 511 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> > Anything received after that time might be too late.
> > 
> 
> My tests say
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 509 pass: 509 fail: 0
> 
> However, trying to build with clang (as done by ChromeOS) does report
> 
> fs/ksmbd/smb2pdu.c:6256:6: error: variable 'fp' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (work->next_smb2_rcv_hdr_off) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/ksmbd/smb2pdu.c:6367:21: note: uninitialized use occurs here
>         ksmbd_fd_put(work, fp);
>                            ^~
> fs/ksmbd/smb2pdu.c:6256:2: note: remove the 'if' if its condition is always false
>         if (work->next_smb2_rcv_hdr_off) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/ksmbd/smb2pdu.c:6248:23: note: initialize the variable 'fp' to silence this warning
>         struct ksmbd_file *fp;
>                              ^
>                               = NULL
> 
> I guess I should try to add clang build tests.
> 
> Anyway, smb2_write() already initializes fp with NULL, presumably to handle a
> similar problem, so maybe doing the same for the read function would be the
> easiest solution. Note that the initialization was added upstream with commit
> 2fd5dcb1c8ef9 ("ksmbd: smbd: fix missing client's memory region invalidation").

Thanks for the report, I'll go fix this up in the commit that causes the
build warning.

greg k-h
