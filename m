Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB0F77BD75
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjHNPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjHNPw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D62A3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FA7D62123
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2601C433C8;
        Mon, 14 Aug 2023 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692028377;
        bh=QHdhT1UOiRO5SU9f/mW1H4is0/CXbhjmjmJ97FnthLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZcyK/QgLuC/kz9/jar9wRn1aN80OQYL3FqopSvOjCxiqnbdwvXBpqTUgOdGxMfdx
         nFEOTrfh2lKioNvXFnb2bL/10bw6LwqwObvXSJ7JqE6OMxWc6063HzVDmYuLk2j3Oh
         2/QRRA2FJ4u2v7DD0IrDEYpZ+WJMA4ZZQmTSpfelSjW9w4qHOwJjcqdWysDj4ld17d
         Qy51snuoNji4zF/tzBqDsuuBU42qatNVZJAFvaFo/40LjoWRYi/yeFf1TbvY934jsy
         wyITBsJavUZYPxi/MZmpsJNEWEZeK4E0A8A1QhQwZSkN0MaeKQxiimNPbgLUZUwhVO
         4gA753M1f+zuA==
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: fix up the assert in i_readcount_dec
Date:   Mon, 14 Aug 2023 17:52:51 +0200
Message-Id: <20230814-unzureichend-steganografie-41db129e04fe@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811194814.1612336-1-mjguzik@gmail.com>
References: <20230811194814.1612336-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=brauner@kernel.org; h=from:subject:message-id; bh=QHdhT1UOiRO5SU9f/mW1H4is0/CXbhjmjmJ97FnthLM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTc8r3wxap5Q1vS+a+Tl058Fty494WpXeD87YYeCzd+iAh2 fxn4vKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiMocYGVZVKavdSa2/6mh7afasQ7 5hFjmvt92/oXXKfE1Ee/SNHc8Z/ruu4Vm29v/JpOYIzeP/TkUW9ngd7Zm7vKLshNpVrx/X7nABAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 21:48:14 +0200, Mateusz Guzik wrote:
> Drops a race where 2 threads could spot a positive value and both
> proceed to dec to -1, without reporting anything.
> 
> 

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

[1/1] vfs: fix up the assert in i_readcount_dec
      https://git.kernel.org/vfs/vfs/c/fbdf4da0ad64
