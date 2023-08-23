Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF94785AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbjHWOiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbjHWOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D299D10C9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6666360AC7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF5CC433C7;
        Wed, 23 Aug 2023 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692801471;
        bh=qvwKmcLD0bcZ9MTCZSnRaj7e7hj/5k6bSHlF8iHW4hQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTGCli6ZtJLxKh7kw7Gb+r30TvM5hWj475v3Hvc3nSONoaLS4klWVFx2Bj0m11R5k
         olLnVQx6NXlnJtFdHu/WRd9w0FD2evZipmh8OKA8i+kMkhFYS7aht9zHk532LoEiZP
         nRKBCv+pK63gwxPwkFQPNkubaC+y7eDpNGoW79Kg=
Date:   Wed, 23 Aug 2023 16:37:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentine Sinitsyn <valesini@yandex-team.ru>
Cc:     Tejun Heo <tj@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] kernfs: sysfs: support custom llseek method for
 sysfs entries
Message-ID: <2023082313-activator-faceless-422a@gregkh>
References: <202308230126.O8xXYkdt-lkp@intel.com>
 <20230823125834.492298-1-valesini@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823125834.492298-1-valesini@yandex-team.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 05:58:33PM +0500, Valentine Sinitsyn wrote:
> As of now, seeking in sysfs files is handled by generic_file_llseek().
> There are situations where one may want to customize seeking logic:
> 
> - Many sysfs entries are fixed files while generic_file_llseek() accepts
>   past-the-end positions. Not only being useless by itself, this
>   also means a bug in userspace code will trigger not at lseek(), but at
>   some later point making debugging harder.
> - generic_file_llseek() relies on f_mapping->host to get the file size
>   which might not be correct for all sysfs entries.
>   See commit 636b21b50152 ("PCI: Revoke mappings like devmem") as an example.
> 
> Implement llseek method to override this behavior at sysfs attribute
> level. The method is optional, and if it is absent,
> generic_file_llseek() is called to preserve backwards compatibility.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>
> ---
> v5:
>         - Fix builds without PCI mmap support (e.g. Alpha)
> v4:
>         - Fix builds which #define HAVE_PCI_LEGACY (e.g. PowerPC)
> v3:
>         - Grammar fixes
>         - Add base-patch: and prerequisite-patch-id: to make kernel test
>           robot happy
> v2:
>         - Add infrastructure to customize llseek per sysfs entry type
>         - Override llseek for PCI sysfs entries with fixed_file_llseek()
>  fs/kernfs/file.c       | 14 +++++++++++++-
>  fs/sysfs/file.c        | 13 +++++++++++++
>  include/linux/kernfs.h |  1 +
>  include/linux/sysfs.h  |  2 ++
>  4 files changed, 29 insertions(+), 1 deletion(-)
> 

Due to the high rate of errors and respins of this, I'm going to wait
until after 5.7-rc1 is out before adding it to my tree so that things
can calm down a bit...

thanks,

greg k-h
