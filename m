Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C2280AEF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjLHVqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbjLHVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:46:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D910E6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:46:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D536C433C8;
        Fri,  8 Dec 2023 21:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702071994;
        bh=YxUWtkRWJpGUAr3ky7ntglE3+KUpdRkTzGFHiaaIaj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tF7HO8t6qxKPtPqWQcmb7u0lHrlYtgVHpW+7EVe9JYIYvwjwpfQGqKhWrxzpHI2gi
         G+XtnfDqNSpryhmqySnfxkWfeb2fAOA9uVHsfmJOtprwfXhqvTasEdb/TdNmvmDhuH
         0dcSwQoNqki3pp16GTpT8NLLPGTCJEW2SlFo8i18KW2Iwi6s4xcDl4kmdUiRzbCHaF
         tCa1seRh1xbRX3/KWbF1/hGiz4F++y+S0QS9mkm9NJn6ReS9VteFAVwaOJ2l70Hl5u
         T/vvjtBLmpWMCIf9viWJcxBjTA9sToKEBe6sMhZMkxQDWkGQ7LYGol7KfPNhyDQ6Qf
         5kbkxloS/XJag==
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: super: use GFP_KERNEL instead of GFP_USER for super block allocation
Date:   Fri,  8 Dec 2023 22:46:26 +0100
Message-ID: <20231208-monolog-podium-bd91de100ebf@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208151022.156273-1-aleksandr.mikhalitsyn@canonical.com>
References: <20231208151022.156273-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=brauner@kernel.org; h=from:subject:message-id; bh=YxUWtkRWJpGUAr3ky7ntglE3+KUpdRkTzGFHiaaIaj0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQW9210P3U52+lH14SjmTdmerjfuDL9tn6WzvJH+5c6m OxaMC9PtKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi3moM/0NS+UTrmr4fvFPO uGxu1KTGDJmFdo6MVft2NxonrfB5HMHw3/tNgcq/voRD3xr/hlw8klucVFjxYcJJY1E7s00fTh+ SZgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2023 16:10:22 +0100, Alexander Mikhalitsyn wrote:
> There is no reason to use a GFP_USER flag for struct super_block allocation
> in the alloc_super(). Instead, let's use GFP_KERNEL for that.
> 
> >From the memory management perspective, the only difference between
> GFP_USER and GFP_KERNEL is that GFP_USER allocations are tied to a cpuset,
> while GFP_KERNEL ones are not.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: super: use GFP_KERNEL instead of GFP_USER for super block allocation
      https://git.kernel.org/vfs/vfs/c/b91dbdebd653
