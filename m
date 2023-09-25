Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF9E7AD4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjIYJiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIYJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:38:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68950A3;
        Mon, 25 Sep 2023 02:38:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE46C433C7;
        Mon, 25 Sep 2023 09:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695634694;
        bh=FBty1aJ2KqEfT3F/9J9e39s5G3Gp0wbyl1YPLGW6wkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSPUX2AdEO2Kmh6FqpBUTi3dvd79HBqhVLypLNHP4My2tHDAmCzBLuoMIIRYcty0Q
         KVh8T2XstG74tAxrHyzYcqu19Z3tXwHqxOILzJObNAzre6JeIf18oUM6HgHGx/+lk5
         aMfhaIAJHaZP8feRKmRNSM2n2I0f1Lz0kFUv+CKGgvQfJ0CtrMkeu5MlVqpmyFZQSP
         27nAaxt7xX4ct/v9uNGGu4AiGWG4IwWvqijRpi8w0118YbWxVdmYatBGw0NID6mvWC
         wr30NUyR8vNhlQgKBriq/XSphj/9khFvM3RT0u3OKKfBxSGRxtn+3sMSTyXq3C28BJ
         kpZjpT+K/u5kA==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] ovl: disable IOCB_DIO_CALLER_COMP
Date:   Mon, 25 Sep 2023 11:38:03 +0200
Message-Id: <20230925-perfide-enzianblau-5f6059909fd2@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <71897125-e570-46ce-946a-d4729725e28f@kernel.dk>
References: <71897125-e570-46ce-946a-d4729725e28f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=brauner@kernel.org; h=from:subject:message-id; bh=FBty1aJ2KqEfT3F/9J9e39s5G3Gp0wbyl1YPLGW6wkY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQKhrwVdZZgu23uom5bvSW9yVzg1qt4vX1qf/Z9Upx1PU2W /1ZuRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETmL2RkeLntbGjUqRfZ509b5sZufG cx/yDjpc2FXfU/vH1mvDVM/87IcFNV5wG3g4Zq1oSdzH9WWk5Mf3Cizdb06+/iJS9XsE4pYgMA
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

On Mon, 25 Sep 2023 00:21:35 -0600, Jens Axboe wrote:
> overlayfs copies the kiocb flags when it sets up a new kiocb to handle
> a write, but it doesn't properly support dealing with the deferred
> caller completions of the kiocb. This means it doesn't get the final
> write completion value, and hence will complete the write with '0' as
> the result.
> 
> We could support the caller completions in overlayfs, but for now let's
> just disable them in the generated write kiocb.
> 
> [...]

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

[1/1] ovl: disable IOCB_DIO_CALLER_COMP
      https://git.kernel.org/vfs/vfs/c/2d1b3bbc3dd5
