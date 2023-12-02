Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3EB801EE2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjLBVmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBVmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:42:13 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41173E5;
        Sat,  2 Dec 2023 13:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a4d9QklxmnGGroHG//jR+2ndksGsehf1JIlbPa4U3UM=; b=D0ukNH9/MJN/gphDZ8G97Jjici
        BtO25Ui608rDQzJOweJlH+bo/VJXoixG7Vvnqn+l/3A5AxszfBcEO0MX4P4bwXXHkiz1DjN7HnAZW
        y+Kccv06YthbRqhrJ1ANAH+qQF30d5LHpl1s/jQs7W/q+HT99uMejhgMtjt8X1I5PNRO0g56ojKpY
        9u5lJQQIlLOWZwaGEJK/DdQxV1/4I/knz5Qk877uZMN97/JONSSAiF2zYa9aaF1KCX6gSYldLrePI
        15yLjJb1NQGA6dVHXjjOV+V9VkWR2WJ07tNGMgjcmUHFHSbNn+19b3QBDnOHP6Td/LrbkR+c6fkfv
        DoEDnrpw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r9Xka-006OCx-1s;
        Sat, 02 Dec 2023 21:42:12 +0000
Date:   Sat, 2 Dec 2023 21:42:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Message-ID: <20231202214212.GR38156@ZenIV>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-3-keescook@chromium.org>
 <20231202212846.GQ38156@ZenIV>
 <202312021331.D2DFBF153@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312021331.D2DFBF153@keescook>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

No.  I would rather *not* see IS_ERR_OR_NULL anywhere, but that's
a separate rant.

> > 	2) the common pattern is to have reference-consuming primitives,
> > with failure exits normally *not* having to do iput() at all.
> 
> This I'm not following. If I make a call to "new_inode(sb)" that I end
> up not using, I need to call "iput()" in it...
> 
> How should this patch be written to avoid the iput() on failure?
> https://lore.kernel.org/all/20231202212217.243710-4-keescook@chromium.org/

I'll poke around and see what I can suggest; said that, one thing I have
spotted there on the quick look is that you are exposing hashed dentry associated
with your inode before you set its ->i_private.  Have an open() hit just after
that d_add() and this
static int pstore_file_open(struct inode *inode, struct file *file)
{
        struct pstore_private *ps = inode->i_private;
        struct seq_file *sf;
        int err;
        const struct seq_operations *sops = NULL;

        if (ps->record->type == PSTORE_TYPE_FTRACE)
... with happily oops on you.
