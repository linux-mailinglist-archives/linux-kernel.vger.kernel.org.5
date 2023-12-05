Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DAD805325
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442125AbjLELig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345109AbjLELie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:38:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB16885
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:38:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A4AC433C8;
        Tue,  5 Dec 2023 11:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701776320;
        bh=HpQfzKH9PkcgbFsZNKCTx0ikve2nD8WgZ8kDoy0hkBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWF7d+KkggDuCYM2ZU8EJIKTxe7uCccNTV72qrVHVEt6Q9Uuc/a6adZQAXfD9uQQR
         mrajWEOGXEhUvJssq7ok9NsIqToNwgakLRba7uZJ83ee2M1NxubiYugKhck/WOeVUd
         i3cD/49HSP56/Iqhx048G0eA3fX1z0WC80CDeqYTU8WrLbajgyLEG9ZVfokcGO90pq
         a/05lO9I274mHG7GxzwCX2xReZI4E5QKDm88rskarGW+U2KLvySzitr6m6e5aoPhX0
         XAqVcx6W+IP7Usyp9EOdajaLItYeRdvsxLzsHOpMXDpdKz2lDfxNGxytfdmiWqMHSL
         J5CS2r67Mm8Aw==
Date:   Tue, 5 Dec 2023 12:38:35 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Message-ID: <20231205-horchen-gemieden-8013e0f30883@brauner>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-3-keescook@chromium.org>
 <20231202212846.GQ38156@ZenIV>
 <202312021331.D2DFBF153@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202312021331.D2DFBF153@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 01:34:32PM -0800, Kees Cook wrote:
> On Sat, Dec 02, 2023 at 09:28:46PM +0000, Al Viro wrote:
> > On Sat, Dec 02, 2023 at 01:22:13PM -0800, Kees Cook wrote:
> > > Allow __free(iput) markings for easier cleanup on inode allocations.
> > 
> > NAK.  That's a bloody awful idea for that particular data type, since
> > 	1) ERR_PTR(...) is not uncommon and passing it to iput() is a bug.
> 
> Ah, sounds like instead of "if (_T)", you'd rather see
> "if (!IS_ERR_OR_NULL(_T))" ?
> 
> > 	2) the common pattern is to have reference-consuming primitives,
> > with failure exits normally *not* having to do iput() at all.
> 
> This I'm not following. If I make a call to "new_inode(sb)" that I end
> up not using, I need to call "iput()" in it...

If we wanted to do this properly then we would need to emulate consume
or move semantics like Rust has. So a cleanup function for inodes based
on scope for example and then another primitive that transfers/moves
ownership of that refcount to the consumer. Usually this is emulate by
stuff like TAKE_POINTER() and similar stuff in userspace. But I'm not
sure how pleasant it would be to do this cleanly.
