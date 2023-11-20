Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD787F1524
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjKTODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjKTOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:02:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61BFD70
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:02:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF78C433C8;
        Mon, 20 Nov 2023 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700488957;
        bh=FCrmZ65nO1A52VtVMBc8whDn/taxA3mU5UI2kUhmaBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guWpBVNRYMm597lpO9bdcyXMBxX2ZOKL54b3ONVQMl2r6M1sVbA3ntY+anjCWwu+G
         l9G1hCcXaWFzztr61p92+zv1vtW3ruDSqjMYcGv2u3w7wmmDDtFn38NlTKfoUviD/8
         /EsINeGMXuz+GISsqakEWIMjJA051VhFGikrOQaTmvnzM1/FNXRpogPJCou3TXv2cn
         PJyuERk9vkLmc2oI5SZyQV9eK92i6VL59ut61dCI+hBldU8vUn/7YN0bxXfuc1VrVS
         3mYECa+fU8JK78i7NaRCPQIuB0l1Y9QX2hLt8I0034PV7U6HVC6Nc99Y2UVegx0Ynp
         PVwdYgEpO0/XA==
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] autofs: add: new_inode check in autofs_fill_super()
Date:   Mon, 20 Nov 2023 15:01:55 +0100
Message-ID: <20231120-dergleichen-parkverbot-dbfcafdc0c26@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119225319.331156-1-raven@themaw.net>
References: <20231119225319.331156-1-raven@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=brauner@kernel.org; h=from:subject:message-id; bh=Tnvki9Nfk5bjCuJJqhEtlw/13JFN9XNgay+otjhGek0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRGp13W+LxKUurNC1s+x59cvw/7tMrVTeWWbEvUde+7n 1TyNEm1o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIPnzAynO3sWrh7xged89FF jsZvkuYI6l/6JfOsfN2E10LHDs9/8p3hf+TLLN2HwQsYFGON0r7e38rmVPS8Nrli41ympPWdLQs FeQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 06:53:19 +0800, Ian Kent wrote:
> Add missing NULL check of root_inode in autofs_fill_super().
> 
> While we are at it simplify the logic by taking advantage of the VFS
> cleanup procedures and get rid of the goto error handling, as suggested
> by Al Viro.
> 
> 
> [...]

I've removed an unused variable. I also changed it so that it errors out
right after autofs_get_inode() returns NULL.

---

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] autofs: add: new_inode check in autofs_fill_super()
      https://git.kernel.org/vfs/vfs/c/368e8258536e
