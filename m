Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB077AC764
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 11:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjIXJpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXJpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 05:45:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF91F1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 02:45:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833ADC433C8;
        Sun, 24 Sep 2023 09:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695548714;
        bh=LzXtXNSrED4dMzen6Q/uURvpZAZL8E9Bv/zlsiifUII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZlyGDYOLKcdOI7ErZN7x3cEp1epP1Z/Z3Ba7up5RSWSUq0KLw2R+0+1ANgitmvj4P
         QZ74tclE1yJ4rfJgn1l0QZnYAZ3lCFGLzexHP47RxgiuDjZDM1tRXRbq8fWdqtCSvi
         soo+5Q8vY70nDyo3NvUSfwRev0vbcS6gfpzjQM0fVn9BnoO9wO0dI9YsghbetekJr/
         UZFR4oKcU6XNQDnvMktSngOQU63SUCgB/tlYHXWWdNZxowRRxquMcT98surVnDqBrD
         nbkZ58dGvz5F7xM50ntR76IU71sheGal5jC6xHMo5vKMB6I+oXcTe+CTQ2FPFPXO6Q
         hdqEJOCzhREyQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Siddh Raman Pant <code@siddh.me>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qian Cai <cai@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] watch_queue: Annotate struct watch_filter with __counted_by
Date:   Sun, 24 Sep 2023 11:45:06 +0200
Message-Id: <20230924-fass-bass-7b1f7aa70dd3@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175407.work.754-kees@kernel.org>
References: <20230922175407.work.754-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=brauner@kernel.org; h=from:subject:message-id; bh=LzXtXNSrED4dMzen6Q/uURvpZAZL8E9Bv/zlsiifUII=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQKsLJ+VWk8O3WrfU6JsPL0Sq3cRXuX5S86vlXvZtll8T/P HExaOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSJsLwP/T830PVzxO/SBaxnjv9u1 xP9FfmkxNJlpX3jWsdfdZ+AanQUu6oPc5ndTmwZnf2kd/fvlWKxC5Zcu3aYk/Ho117KpkB
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

On Fri, 22 Sep 2023 10:54:08 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct watch_filter.
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

[1/1] watch_queue: Annotate struct watch_filter with __counted_by
      https://git.kernel.org/vfs/vfs/c/6b601adb5e79
