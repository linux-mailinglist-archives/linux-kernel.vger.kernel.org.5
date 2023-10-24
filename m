Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131217D4B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjJXJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjJXJFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:05:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7796CCC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:05:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8BCC433C8;
        Tue, 24 Oct 2023 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698138343;
        bh=59hvrldRJ6uHH8sM4+zj+t2v8z3bBouCHY3CG9BajyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGA4ESXhY0f2OKr4KInojAvuScuCjl6gw45D8810SB2NH1jT9Qkw2Fwh/77nYuDLm
         WU/1Rhdxr1BvFskdbItp3xC5s6cgPLw/NT3evNHurwJUU5M9/tfCLWyEgV/9H6CIL7
         TMMJOvJu/RDOG6ijDVUzPtUluBMs+OhpvNTzwRj3fz00rguNZ9arGfMB1njOu06jSI
         4RVpXmoPLasREjRm3E+7wI2yzjK7367voCx5QTP6sMpAz9czVeZstHqriVgHLFlt4y
         9lRiqs+t40TnJdB/wcohgUeoKMcsV2Iop/lmRxBAi85icypa8bB3NsSRry6JLg2wBP
         VDos+C0gyn9ig==
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bill O'Donnell <bodonnel@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] autofs: fix add autofs_parse_fd()
Date:   Tue, 24 Oct 2023 11:05:30 +0200
Message-Id: <20231024-vorarbeit-unmittelbar-009365985901@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023093359.64265-1-raven@themaw.net>
References: <20231023093359.64265-1-raven@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=brauner@kernel.org; h=from:subject:message-id; bh=aN5/eaaNILz6XykqLa8odZYq/sxBDsVAL1pYfRRqBBo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSad+wXlSgyEkhNUlzaGalaaiWs94KfLf3doztHQo59nPL6 TfmUjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInoZjP8D97ucS50F9fss3Mm+Si2qr JcP2F7feGBixtsgqZbqu72PM7wP/3PhByWVMfnBh8f/6v/8MZEN6uyY1Pxpf/VhzMONj1iZAQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 17:33:59 +0800, Ian Kent wrote:
> We are seeing systemd hang on its autofs direct mount at
> /proc/sys/fs/binfmt_misc.
> 
> Historically this was due to a mismatch in the communication structure
> size between a 64 bit kernel and a 32 bit user space and was fixed by
> making the pipe communication record oriented.
> 
> [...]

Thanks for the fix!

---

Applied to the vfs.autofs branch of the vfs/vfs.git tree.
Patches in the vfs.autofs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.autofs

[1/1] autofs: fix add autofs_parse_fd()
      https://git.kernel.org/vfs/vfs/c/d3c50061765d
