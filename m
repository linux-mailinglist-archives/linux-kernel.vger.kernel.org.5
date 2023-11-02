Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A17DF504
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbjKBO3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjKBO3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:29:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E118B13A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:29:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DE8C433BA;
        Thu,  2 Nov 2023 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698935343;
        bh=bRsB7LoOlwnaeDzBn85F8lO8jv7acyGjA2Bu9E6BZ2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/uLoMdZ7OeZHtSdv51jpB5lwNINNYilKSiD8FCSlvz3Wd5OhVqN7DpoiuTvn8mhi
         HNUUEXa//lmAQ4U16ismcVo9rOtNfuc8BrCzIZLvx2pYfPkaY3OsmYoSvxxpv3NEMP
         SULUnKFIWBs+xxjqeYA6fjFYOPDA5cvceyUbPu/U=
Date:   Thu, 2 Nov 2023 15:28:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        rafael@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
        david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
Message-ID: <2023110216-labrador-neurosis-1e6e@gregkh>
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com>
 <2023110205-enquirer-sponge-4f35@gregkh>
 <CA+CK2bDUaQDwgF-Q0vfNzHfXmn-QhnHTSE32_RfttHSGB7O3DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDUaQDwgF-Q0vfNzHfXmn-QhnHTSE32_RfttHSGB7O3DA@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 10:24:04AM -0400, Pasha Tatashin wrote:
> On Thu, Nov 2, 2023 at 1:42 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 01, 2023 at 04:08:16PM -0700, Sourav Panda wrote:
> > > Adds a new per-node PageMetadata field to
> > > /sys/devices/system/node/nodeN/meminfo
> >
> > No, this file is already an abuse of sysfs and we need to get rid of it
> > (it has multiple values in one file.)  Please do not add to the
> > nightmare by adding new values.
> 
> Hi Greg,
> 
> Today, nodeN/meminfo is a counterpart of /proc/meminfo, they contain
> almost identical fields, but show node-wide and system-wide views.

And that is wrong, and again, an abuse of sysfs, please do not continue
to add to it, that will only cause problems.

> Since per-page metadata is added into /proc/meminfo, it is logical to
> add into nodeN/meminfo, some nodes can have more or less struct page
> data based on size of the node, and also the way memory is configured,
> such as use of vmemamp optimization etc, therefore this information is
> useful to users.
> 
> I am not aware of any example of where a system-wide field from
> /proc/meminfo is represented as a separate sysfs file under node0/. If
> nodeN/meminfo is ever broken down into separate files it will affect
> all the fields in it the same way with or without per-page metadata

All of the fields should be individual files, please start adding them
if you want to add new items, I do not want to see additional abuse here
as that will cause problems (as you are seeing with the proc file.)

> > Also, even if you did want to do this, you didn't document it properly
> > in Documentation/ABI/ :(
> 
>  The documentation for the fields in nodeN/meminfo is only specified
> in  Documentation/filesystems/proc.rst, there is no separate sysfs
> Documentation for the fields in this file, we could certainly add
> that.

All sysfs files need to be documented in Documentation/ABI/ otherwise
you should get a warning when running our testing scripts.

thanks,

greg k-h
