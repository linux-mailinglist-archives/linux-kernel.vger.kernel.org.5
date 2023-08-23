Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F37B785AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjHWOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjHWOjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:39:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46543E54
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5AEB663E9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA65C433C9;
        Wed, 23 Aug 2023 14:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692801587;
        bh=D3ai+mwxcsBP6D/tHRiglHeKOp9Ze0CA95JKdON+jQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ff8bfyCd9Q5PgKgXebgbs/e66ot0RO9apzZvs19T+h2XJArzEz3uQ97MGoPv10F2V
         R80lP+Moa+iPyLfwKDmBQNSeWLZ9LIaM2mI4DI9Tqx12yyOvPVdkoC0xUcLv+ECiLP
         jwdKJkHh2wj4h8fIp8htLIlE5Th89cnBcbfvPebY=
Date:   Wed, 23 Aug 2023 16:39:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentine Sinitsyn <valesini@yandex-team.ru>
Cc:     Tejun Heo <tj@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] kernfs: sysfs: support custom llseek method for
 sysfs entries
Message-ID: <2023082310-satisfy-outburst-1068@gregkh>
References: <202308230126.O8xXYkdt-lkp@intel.com>
 <20230823125834.492298-1-valesini@yandex-team.ru>
 <2023082313-activator-faceless-422a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082313-activator-faceless-422a@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 04:37:49PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 23, 2023 at 05:58:33PM +0500, Valentine Sinitsyn wrote:
> > As of now, seeking in sysfs files is handled by generic_file_llseek().
> > There are situations where one may want to customize seeking logic:
> > 
> > - Many sysfs entries are fixed files while generic_file_llseek() accepts
> >   past-the-end positions. Not only being useless by itself, this
> >   also means a bug in userspace code will trigger not at lseek(), but at
> >   some later point making debugging harder.
> > - generic_file_llseek() relies on f_mapping->host to get the file size
> >   which might not be correct for all sysfs entries.
> >   See commit 636b21b50152 ("PCI: Revoke mappings like devmem") as an example.
> > 
> > Implement llseek method to override this behavior at sysfs attribute
> > level. The method is optional, and if it is absent,
> > generic_file_llseek() is called to preserve backwards compatibility.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Valentine Sinitsyn <valesini@yandex-team.ru>
> > ---
> > v5:
> >         - Fix builds without PCI mmap support (e.g. Alpha)
> > v4:
> >         - Fix builds which #define HAVE_PCI_LEGACY (e.g. PowerPC)
> > v3:
> >         - Grammar fixes
> >         - Add base-patch: and prerequisite-patch-id: to make kernel test
> >           robot happy
> > v2:
> >         - Add infrastructure to customize llseek per sysfs entry type
> >         - Override llseek for PCI sysfs entries with fixed_file_llseek()
> >  fs/kernfs/file.c       | 14 +++++++++++++-
> >  fs/sysfs/file.c        | 13 +++++++++++++
> >  include/linux/kernfs.h |  1 +
> >  include/linux/sysfs.h  |  2 ++
> >  4 files changed, 29 insertions(+), 1 deletion(-)
> > 
> 
> Due to the high rate of errors and respins of this, I'm going to wait
> until after 5.7-rc1 is out before adding it to my tree so that things
> can calm down a bit...

{sigh}

I don't know what kernel version we are at anymore, it should be
"6.6-rc1".

thanks,

greg k-h
