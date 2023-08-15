Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B21A77C9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjHOJCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbjHOJBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23551FCA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1C3A61D12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A920FC433C8;
        Tue, 15 Aug 2023 09:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692090085;
        bh=LQSdgjwkCQUoo/R+eG3iyhBnHLGgsgC72K3hf0dJZZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eWgKcUs/boExNg+U3koOPbNe4/Jowe0t3i81W7/Q6pqkKzGVqfDg5DHlsiD4HoBHC
         f3UYIXl+1tHbE6zQ8xrmgbOTOtFAtci/rvq6ulji+1Zn51W0E+NbG3zuB43Cpf/0zp
         sPpRN8llKSlUO4pCoPYkKNhXCiNYiSohM2dtE4EkAJbBQ5xp8vkddpKi642+T+maxU
         bFDUd4q1VPq6ZL7xlXiEY/KvP0An1YdBTF5HMR96+KWfZ3jHoNWLS32nncfU3JtsNR
         p6c5vAg4xQ7huPzlFRwhNhXpshIRWW/HduIHQ78ty6gJB5w4dXMXrm8Ia/kzRZRRYm
         UqqBMYujBBRWg==
From:   Christian Brauner <brauner@kernel.org>
To:     torvalds@linux-foundation.org, Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking: remove spin_lock_prefetch
Date:   Tue, 15 Aug 2023 11:01:17 +0200
Message-Id: <20230815-abklatsch-naschen-651453779dca@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230812161554.1676652-1-mjguzik@gmail.com>
References: <20230812161554.1676652-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=brauner@kernel.org; h=from:subject:message-id; bh=LQSdgjwkCQUoo/R+eG3iyhBnHLGgsgC72K3hf0dJZZ0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTctjvv4vuQV+petEfE6TMRi49yVLFxJf5MKHTi9Tsy8Zma b+2VjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlc6mT4Z918xshdWy7joqFg0a81xa sWznE4lfOqcsnc2M+XnxU/S2Zk6GLrfr9i5rHN8YYTzj/yYlpbJis/89Av/elJPfahj+2usgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 18:15:54 +0200, Mateusz Guzik wrote:
> The only remaining consumer is new_inode, where it showed up in 2001 in
> the following commit in a historical repo [1]:
> 
> commit c37fa164f793735b32aa3f53154ff1a7659e6442
> Author: linus1 <torvalds@athlon.transmeta.com>
> Date:   Thu Aug 16 11:00:00 2001 -0800
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

[1/1] locking: remove spin_lock_prefetch
      https://git.kernel.org/vfs/vfs/c/a3e07d2abfef
