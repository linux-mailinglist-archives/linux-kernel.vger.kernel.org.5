Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA657892D2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHZAzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjHZAyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:54:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E826B8;
        Fri, 25 Aug 2023 17:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A776C62E76;
        Sat, 26 Aug 2023 00:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761E1C433C8;
        Sat, 26 Aug 2023 00:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693011289;
        bh=KunlMoFaeB09wWpK/chJYbgKS5tfp+/UPw8r6E8VtDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSgNX7cYWf2qXdMFCXD0W7Ors9olo5dw9e/ubec5mBKB8+DJR3PCWeflqAWBrUYb0
         X2o1UjfBWV5qTqbf0R8Lyfjk7WbHr6/e9tZbXrkfFpeHMJIEbFRzSPg/1k6AtNDdPQ
         sZjVeIQtT4GkUioINsligfhNom5WIP9u9+YfPIfsmYXUjEyvo2EUYYVv3xuLnNyk21
         hgqTssuXFfgYZNLh61C4bGjExZxsLv6euZ2K/V3DTMdq5nJlvnxrW1MfQtt3V59Tf6
         k+j1ErQANSDNyg6LyJNEEX4Nd5fsU4uYXW/KhjIVrr6PExmaSUoyfC1xPXi15w2pPR
         P/ZFZ5u2L4xiQ==
From:   SeongJae Park <sj@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qing Zhao <qing.zhao@oracle.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/sysfs: add __counted_by() annotation
Date:   Sat, 26 Aug 2023 00:54:47 +0000
Message-Id: <20230826005447.109776-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202308251426.94092475C3@keescook>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Fri, 25 Aug 2023 14:32:34 -0700 Kees Cook <keescook@chromium.org> wrote:

> On Fri, Aug 25, 2023 at 02:04:41AM +0000, SeongJae Park wrote:
> > Commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> > added __counted_by() annotation.  The underlying attribute for the
> > feature is still under development, but adopting it can improve the
> > readability of the code.  Apply it to four dynamic arrays in DAMON sysfs
> > code.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/sysfs.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 808a8efe0523..36a176f38726 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -93,7 +93,7 @@ static const struct kobj_type damon_sysfs_region_ktype = {
> > 
> >  struct damon_sysfs_regions {
> >  	struct kobject kobj;
> > -	struct damon_sysfs_region **regions_arr;
> > +	struct damon_sysfs_region **regions_arr __counted_by(nr);
> >  	int nr;
> >  };
> 
> Unfortunately this isn't supported yet for non-flexible-array-members:
> 
> mm/damon/sysfs.c:96:14: error: 'counted_by' attribute may not be specified for a non-array field
>    96 |         struct damon_sysfs_region **regions_arr __counted_by(nr);
>       |                                     ^~~~~
> 
> We'll have to wait a bit before we can add this patch.

Thank you for checking this and let me know.  Ok, I will wait.

> Thank you for
> getting it ready, though!

Owing to your previous contributions.  Thank you for helping me make DAMON code
better to read :)

> This support is next in line. :)
> 
> The FAM support is likely ready to land, though[1]. I just tested it
> today.
> 
> -Kees
> 
> [1] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/628459.html
> 
> -- 
> Kees Cook
> 


Thanks,
SJ
