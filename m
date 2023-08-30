Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82E78D1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 03:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbjH3Bgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 21:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241579AbjH3Bg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 21:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32CACC2;
        Tue, 29 Aug 2023 18:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58F9660E99;
        Wed, 30 Aug 2023 01:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38016C433C8;
        Wed, 30 Aug 2023 01:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693359383;
        bh=0T61JhZvBgtGqTFCxU7ee9dwkyQB1gfq2ay5n+uX9HM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBU3UyEDn9KBvrJspSdcvxZ/i/yQRLuIi/gAfUUsMXID2Az4PxAo4rK04tzWzyp+u
         Se7JZy/rdzOxMjePY1C0mZ8gLkZxYrMNEtmCNpU9cI6TVtk3eu7M7rdnetGzvuExJW
         llTxt0gPw/5049P/a7+dtBma2qaEMPSXXVSa/KuugzrUzj1wiZGrLsSAsyGj6ZbPCR
         tzsnvvp1wIr2KYpsf0w6Rv0LGAEmGksaKp2U+D5gjWhSAFwU3PKh+PlRc5VLSAMAc/
         pcWlX4mM4kcnr/zdvtUh8b974pDRnmQbtvDfDrhhuRiLqs7m7oB/BjmnthV8Kl+Gew
         lnEKj6Hmd59zA==
From:   SeongJae Park <sj@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: add a tracepoint for damos apply target regions
Date:   Wed, 30 Aug 2023 01:36:21 +0000
Message-Id: <20230830013621.46216-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829191629.25c5f0e2@rorschach.local.home>
References: 
MIME-Version: 1.0
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

Hi Steven,

On Tue, 29 Aug 2023 19:16:29 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 27 Aug 2023 00:40:45 +0000
> SeongJae Park <sj@kernel.org> wrote:
> 
> > +	TP_STRUCT__entry(
> > +		__field(unsigned int, context_idx)
> 
> 4 bytes
> 
> > +		__field(unsigned int, scheme_idx)
> 
> 4 bytes
> 
> > +		__field(unsigned long, target_idx)
> 
> 8 bytes
> 
> > +		__field(unsigned int, nr_regions)
> 
> 4 bytes
> 
> > +		__field(unsigned long, start)
> 
> This is going to cause a 4 byte hole. I would move nr_regions after end
> so that it stays properly aligned.

That makes sense, thank you for letting me know this!  I will do so in the next
spin.


Thanks,
SJ

> 
> -- Steve
> 
> 
> 
> > +		__field(unsigned long, end)
> > +		__field(unsigned int, nr_accesses)
> > +		__field(unsigned int, age)
> > +	),
> > +
> 
