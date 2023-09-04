Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED8791673
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbjIDLtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjIDLtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:49:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D69E6;
        Mon,  4 Sep 2023 04:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53DC4CE0EA2;
        Mon,  4 Sep 2023 11:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBAFC433C7;
        Mon,  4 Sep 2023 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693828165;
        bh=3aY1ZemcCH+DmD8wlavtiJU3GHr/szhhOTN+39gCg1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5lmdvMfRyX8MGh1z77HMSA+tE/JEyvm3agM7dnlDgGePu/Pl+qaflJSekwy+/9J2
         z//e4244pPFCsBb7fKV8KTjkwMRiVMrKDQoeENRxLuCgNJtmAVKBygWkj325YuXvAO
         k1eOvWeQtBUXaxTl09upFIBh9UEP65cp9LJxqxbmHxzSAVyNPNWfuiUzcOwhyE1vo2
         IDPO87PCRUaUdikF46c9kNY5e+3QLleOMzpL/yGzWELz0ciNd/eIHskKM495d6Pi2p
         vAkjLClhBXrDPpHRjaM/gqAs7ufMz05k1yRuM18WrqivnqmrSUrUfG5pPV3iPixhXt
         Td5M7EWGeMQXg==
From:   Christian Brauner <brauner@kernel.org>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, dchinner@redhat.com,
        dsterba@suse.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: Replace 1-element array with C99 style flex-array
Date:   Mon,  4 Sep 2023 13:49:18 +0200
Message-Id: <20230904-besuchen-aufgaben-26aa43101255@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821043312.1444068-1-syoshida@redhat.com>
References: <20230821043312.1444068-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=brauner@kernel.org; h=from:subject:message-id; bh=3aY1ZemcCH+DmD8wlavtiJU3GHr/szhhOTN+39gCg1I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR8PWIgHnBb8dbbVWr/7stfPePHt/Yi/6F3UUJd23ltb6e3 P27x7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiISCfD/7quyQZGB/6v2Pj1ymueSe Kb7S8dkp730XxpddXatJPbE64wMhx7M5F3/YTC00HNop23fhh/23DsoZwKz9NVzzLvLH3wKYkTAA==
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

On Mon, 21 Aug 2023 13:33:12 +0900, Shigeru Yoshida wrote:
> UBSAN found the following issue:
> 
> ================================================================================
> UBSAN: array-index-out-of-bounds in fs/reiserfs/journal.c:4166:22
> index 1 is out of range for type '__le32 [1]'
> 
> This is because struct reiserfs_journal_desc uses 1-element array for
> dynamically sized array member, j_realblock.
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

[1/1] reiserfs: Replace 1-element array with C99 style flex-array
      https://git.kernel.org/vfs/vfs/c/a7cb8be34170
