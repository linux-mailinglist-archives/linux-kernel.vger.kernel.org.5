Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8353D7E624C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjKICkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjKICky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:40:54 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE669D58;
        Wed,  8 Nov 2023 18:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Izao/Oe+Ice4rRrR6YJ3TmwlziZFsjKfxkPlLCNcxEQ=; b=g9WBIAzllpcaX36dpcCIkUQK8F
        80fXUqCocLHtK5v+rogT6VaUEzZ1B2nyEpE4rBgHXpD4Xy626GyoqEscanpv+NcM75R9EX8q83Ku2
        1735AL5tu/RnF4KYtssAIOFkkusA/iXTLdiyXDzbW93SqXDd/+xVNKmK0jbo9pLCfW8Aj14IR27CD
        IVX8AOdCRxrGc6N631v11HKixnSsUbkb6jZULNK7g86gaU06xL+cqM89WQt0WgHPpsfjqWndk2BJA
        lU2x1WDnggBwROvBmGH7pYBpZo+eHmRy/fslh6Onj27rT/5Bfdr5ueUoZagsRxO8EG8TJuNgqBTwE
        3Q6LmhDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r0uxz-00DI50-0y;
        Thu, 09 Nov 2023 02:40:23 +0000
Date:   Thu, 9 Nov 2023 02:40:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     WoZ1zh1 <wozizhi@huawei.com>
Cc:     brauner@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        jlayton@kernel.org, dchinner@redhat.com, cyphar@cyphar.com,
        shr@devkernel.io, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH -next V2] proc: support file->f_pos checking in mem_lseek
Message-ID: <20231109024023.GZ1957730@ZenIV>
References: <20231109102658.2075547-1-wozizhi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109102658.2075547-1-wozizhi@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 06:26:58PM +0800, WoZ1zh1 wrote:
> In mem_lseek, file->f_pos may overflow. And it's not a problem that
> mem_open set file mode with FMODE_UNSIGNED_OFFSET(memory_lseek). However,
> another file use mem_lseek do lseek can have not FMODE_UNSIGNED_OFFSET
> (kpageflags_proc_ops/proc_pagemap_operations...), so in order to prevent
> file->f_pos updated to an abnormal number, fix it by checking overflow and
> FMODE_UNSIGNED_OFFSET.

Umm...  Is there any reasons why all of those shouldn't get FMODE_UNSIGNED_OFFSET
as well?
