Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B98C7E84BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346598AbjKJUwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjKJUvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:51:46 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A8F93EB;
        Fri, 10 Nov 2023 00:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NsQ+DnYE/bAPSN7aXjsuBhHi7IqXlM77UwwV+IIISvM=; b=i6xQFLmMcUGCPg8SNtHRC0gzqH
        s1/PsMwZhcpNe8pE1MCjubNEddOBibPeqpfvWjNbM1FUJBr6EyEdPq8XLqr6jCt8raIgI1BnSyimH
        +NtoteV73RP4XxiT7WvTtP2YiUJlmnQFVD4HKK6pddoSKhmHe3Du/ttaGgtPal+mQ9QF2yDW29eCT
        FB35nXzBsK6zVhuclSqkfvfKCkpx5cm2EnBJkb/rhmOKGwx7qxOb/6fGq2kywgPnWw6ojirzH0QP0
        LZBfR9nKC/GdESNpsAYd3u953BXHdpT83iVWtuKJDqnNOrc1ESOCje8cJnalXD/hEXkaxBC8Elk9X
        DNt0MLoA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r1MlL-00DoWD-1u;
        Fri, 10 Nov 2023 08:21:11 +0000
Date:   Fri, 10 Nov 2023 08:21:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zizhi Wo <wozizhi@huawei.com>
Cc:     brauner@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        jlayton@kernel.org, dchinner@redhat.com, adobriyan@gmail.com,
        yang.lee@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH next V3] proc: support file->f_pos checking in mem_lseek
Message-ID: <20231110082111.GN1957730@ZenIV>
References: <20231110151928.2667204-1-wozizhi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110151928.2667204-1-wozizhi@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:19:28PM +0800, Zizhi Wo wrote:
> From: WoZ1zh1 <wozizhi@huawei.com>
> 
> In mem_lseek, file->f_pos may overflow. And it's not a problem that
> mem_open set file mode with FMODE_UNSIGNED_OFFSET(memory_lseek). However,
> another file use mem_lseek do lseek can have not FMODE_UNSIGNED_OFFSET
> (kpageflags_proc_ops/proc_pagemap_operations...), so in order to prevent
> file->f_pos updated to an abnormal number, fix it by checking overflow and
> FMODE_UNSIGNED_OFFSET.

1) How is that different from the previous version?
2) Would FMODE_UNSIGNED_OFFSET be wrong for those files?  If not, why not?
