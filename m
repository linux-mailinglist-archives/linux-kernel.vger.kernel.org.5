Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD8A7EBA99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 01:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjKOAfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 19:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjKOAfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 19:35:37 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B5DC2;
        Tue, 14 Nov 2023 16:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j6H43ceFH+uSiYPqAdZsKlJaFqzhz6+CW2Ahj89Kc+s=; b=YvyxGb2hvJdkrl3jGj+xejtca0
        PdtQGqbhlPXciTcKj+2aFcyQTcHh7sGZAn6pZs4ZqkLfo0lwUT8Iep8ZTr9Wvl7rXdxs0XODv22cn
        1qS1jQz1qGwHDVU3PZT9rz+Sz1wrVTKBCy3mVZlE4ubl2fMCeAtRscVxI+xyyAdRCm/NvLcyycNFQ
        ya8qLR8SMD3o4RIWuuEljSxF1U04Yk4K/eSRwKKFni2qHOluqwyAjf8x6GYOOxfsMcjMu84zRa5dz
        oSPn6WRHhnr/HoRRTP7ncFbcO1gC0m4F39PaOTOJ7BF8zQNsmmZMm1LhDrYs6hZJ++gAqvBWsb9HK
        5Mc2yIJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r33sN-00FtHQ-2K;
        Wed, 15 Nov 2023 00:35:27 +0000
Date:   Wed, 15 Nov 2023 00:35:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Edward Adam Davis <eadavis@qq.com>,
        syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com,
        autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] autofs: fix null deref in autofs_fill_super
Message-ID: <20231115003527.GW1957730@ZenIV>
References: <000000000000ae5995060a125650@google.com>
 <tencent_3744B76B9760E6DA33798369C96563B2C405@qq.com>
 <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
 <20231114044110.GR1957730@ZenIV>
 <e2654c2c-947a-60e5-7b86-9a13590f6211@themaw.net>
 <20231114152601.GS1957730@ZenIV>
 <7b982b5e-ecad-1b55-7388-faf759b65cfe@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b982b5e-ecad-1b55-7388-faf759b65cfe@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 08:18:33AM +0800, Ian Kent wrote:

> I guess that including the locking is not going to make much difference.
> 
> I don't remember now but it was probably done because there may be many
> 
> mounts (potentially several thousand) being done and I wanted to get rid
> 
> of anything that wasn't needed.

Seeing that lock in question is not going to be contended... ;-)

Seriously, though - the fewer complications we have in the locking rules,
the better.

Al, currently going through audit of ->d_name/->d_parent uses and cursing
at the 600-odd places left to look through...
