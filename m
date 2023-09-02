Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3C6790A32
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 00:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjIBWzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 18:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjIBWzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 18:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D60ACF6;
        Sat,  2 Sep 2023 15:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8CA860E93;
        Sat,  2 Sep 2023 22:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E8BC433C8;
        Sat,  2 Sep 2023 22:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1693695331;
        bh=pihSQW8CJUH01a8SNi5TsadWucjrNQIZustgBgJrkgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lfA41V19zanFLGj5+kq10lX9sBYrQQBLdY6in/Pi4uc6pYiYSKbawjWmhpupgbIDc
         6WZ4C9ec4kyLWYMHsKVmMKcJuocCP+nsJMJzf/sRjjPrb9Mz1aVJIRF/LQ3TdjGoXV
         lgX4m6IwJJDEQlPGSTeNcYSWi9UffMnphQn1Jb7k=
Date:   Sat, 2 Sep 2023 15:55:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ze Zuo <zuoze1@huawei.com>
Cc:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <axboe@kernel.dk>, <ying.huang@intel.com>,
        <aneesh.kumar@linux.ibm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 1/2] zram: add a parameter "node_id" for zram
Message-Id: <20230902155529.61384b25aae68abb9c262552@linux-foundation.org>
In-Reply-To: <20230901071942.207010-2-zuoze1@huawei.com>
References: <20230901071942.207010-1-zuoze1@huawei.com>
        <20230901071942.207010-2-zuoze1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 15:19:41 +0800 Ze Zuo <zuoze1@huawei.com> wrote:

> Add a parameter "node_id" to zram to support storing pages on specific
> node_id node memory.

Please document this in Documentation/admin-guide/blockdev/zram.rst

Should it be a group of nodes rather than a single one?  If this
feature is useful, people will want that.

> Now, zram memory allocation is random, however in some cases, specifying
> specific nodes for memory allocation for zram may have good effects. In
> addition, when memory tier is supported, demotion can be achieved not
> only through page migration,  it is also possible to apply for memory by
> specifying zram on low-speed device nodes, such as CXL memory devices,
> and compressing pages to these devices through memory reclamation to
> achieve similar effects to migration.

Are any performance testing results available from using this feature?
