Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7080DF69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345346AbjLKXVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345313AbjLKXVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:21:36 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD6BCB;
        Mon, 11 Dec 2023 15:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mERUYNAEtYKlaEK1K617SrRF291lNcNfmDSKNE8j018=; b=k/nDpvbWr9HpLm/1Ve+oUVXWMY
        jz9h+D7jC8uEN/X+zIs+scm6ZJNlB+z0mjG9XzGbWLBWCtGFlBBaDtBqT7YOQosaJ+PVHRL/u51He
        tVa3Lgw3Rdtu2fs9EP9PJkPOVuVHTN2tPF17ahTpWnFBPu7SQ7XitooPSrH5aoP8HCwUOKtTLnnYu
        4ks7JfsXNMI3TYSGi6obww7fpOJ6Thcwjo5qnmMB1xGGFRmeLvffsBU1Jiv3hRgYQrX3lNXyd2h1q
        f7i+o/zfhoWiMhB6vHETgaYWhQ6G8f46u+tpuWMRQ6JLqHPRc839L/Thdnlqeg3qvYyly04UaE5z0
        w9Cjt2+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCpah-00B2zy-2G;
        Mon, 11 Dec 2023 23:21:35 +0000
Date:   Mon, 11 Dec 2023 23:21:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Message-ID: <20231211232135.GF1674809@ZenIV>
References: <20231208033006.5546-1-neilb@suse.de>
 <20231208033006.5546-2-neilb@suse.de>
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>
 <20231211191117.GD1674809@ZenIV>
 <170233343177.12910.2316815312951521227@noble.neil.brown.name>
 <20231211231330.GE1674809@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211231330.GE1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:13:30PM +0000, Al Viro wrote:

> dentry_kill() means ->d_release(), ->d_iput() and anything final iput()
> could do.  Including e.g. anything that might be done by afs_silly_iput(),
> with its "send REMOVE to server, wait for completion".  No, that's not
> a deadlock per se, but it can stall you a bit more than you would
> probably consider tolerable...  Sure, you could argue that AFS ought to
> make that thing asynchronous, but...
> 
> Anyway, it won't be "safe to use in most contexts".  ->mmap_lock alone
> is enough for that, and that's just the one I remember to have given
> us a lot of headache.  And that's without bringing the "nfsd won't
> touch those files" cases - make it generally accessible and you get
> to audit all locks that might be taken when we close a socket, etc.

PS: put it that way - I can buy "nfsd is doing that only to regular
files and not on an arbitrary filesystem, at that; having the thread
wait on that sucker is not going to cause too much trouble"; I do *not*
buy turning it into a thing usable outside of a very narrow set of
circumstances.
