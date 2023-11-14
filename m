Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464567EB999
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjKNWus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjKNWup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:50:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C09DE3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 14:50:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2640BC433C8;
        Tue, 14 Nov 2023 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700002241;
        bh=N6HqswbYFj8oQ63GBlegHfbRdhg4wqQxWCHvJV54ZCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OgjCzaqRU3NzDSlEFgW7HdJNRVstmszAwYAAfqtQckuts3E8nrAh/KTpW2xN5fDpk
         XkNoq9Y2rZRYlNNYruTF6vaFT8MVWYVqoHJZocMgZe25E23lsYxylIFRI6hbq/HwKv
         q1JYLJZt302R3wXVMELnHyUXbYXf9Gxj6NDNccBc=
Date:   Tue, 14 Nov 2023 14:50:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Chris Li <chrisl@kernel.org>, tj@kernel.org,
        lizefan.x@bytedance.com, Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org,
        roman.gushchin@linux.dev, Shakeel Butt <shakeelb@google.com>,
        muchun.song@linux.dev, Hugh Dickins <hughd@google.com>,
        corbet@lwn.net, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm <linux-mm@kvack.org>, kernel-team@meta.com,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        david@ixit.cz
Subject: Re: [PATCH v4] zswap: memcontrol: implement zswap writeback
 disabling
Message-Id: <20231114145040.4b90d49d4ace1621c87f9c79@linux-foundation.org>
In-Reply-To: <CAKEwX=PT=5nvLhUyMmi=hq0_2H-4kmO9tOdqFvHEtaWF+e8M1Q@mail.gmail.com>
References: <20231106231158.380730-1-nphamcs@gmail.com>
        <CAF8kJuPXBLpG2d4sje6ntrA+U-AnLzu3sNpJK02YxNcg04YNng@mail.gmail.com>
        <CAKEwX=OgN_xQWrp_OYkK1BRq3DFW4he9OSycdjBm0BNy+vpPAg@mail.gmail.com>
        <CAF8kJuN--EUY95O1jpV39yv5FDu0OYanY6SZeBPk5ng4kRyrjA@mail.gmail.com>
        <CAKEwX=PT=5nvLhUyMmi=hq0_2H-4kmO9tOdqFvHEtaWF+e8M1Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2023 16:06:58 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

> It's a bit of a micro-optimization indeed. But if for some reason I need
> to send v5 or a fixlet, I'll keep this in mind!

I'm seeing a lot of rejects against current mainline, so yes please.
