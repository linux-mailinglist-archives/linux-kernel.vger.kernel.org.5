Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231127E7443
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjKIWOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjKIWOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:14:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BFF1FF6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:14:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0890C433C7;
        Thu,  9 Nov 2023 22:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699568043;
        bh=I6BvnQkMNjyMELc/F4h2vOUAiBMi+6ICmcsjmFpUbxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kTEO7rgELxOEzYhJPireWKiC1ovWouhACF38DYn/EqhgKdWBNewMtwe8VaHdHJzfj
         Su2mTYV4XCEacGg/yxafgOwRP6EHgYOdJUd7svwDXaqTB1qBssPsA2xVFCIQMTa/CA
         Ji+KTVxnzmbH9AMMbACohM23GCX/kajZhTAVwUvk=
Date:   Thu, 9 Nov 2023 14:14:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfp: Include __GFP_NOWARN in GFP_NOWAIT
Message-Id: <20231109141402.11f951a83a742465f5306ba2@linux-foundation.org>
In-Reply-To: <20231109211507.2262419-1-willy@infradead.org>
References: <20231109211507.2262419-1-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Nov 2023 21:15:07 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> GFP_NOWAIT callers are always prepared for their allocations to fail
> because they fail so frequently.  Forcing the callers to remember to add
> __GFP_NOWARN is just annoying and leads to an endless stream of patches
> for the places where we forgot to add it.

A possible problem is call sites where the developers were relying upon
the core MM's warning, so they chose to omit __GFP_NOWARN rather than
adding a local printk.

We're now silencing core MM's warning so those developers might lose
some diagnostic information.

Random example, arch/s390/pci/pci_clp.c:clp_refresh_fh().  After this
change, the pci_clp developers won't see (or be told about) allocation
failures in this function.  If they know about this change, they may
now choose to add a local printk.

It's not the end of the world by any means.  One possible way to
prevent this change in behavior is to add a new __GFP_WARN and go add
it to all the sites which use bare __GFP_NOWAIT and which do not have a
local printk for the allocation failure.

