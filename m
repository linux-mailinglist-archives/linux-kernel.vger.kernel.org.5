Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703C97C8459
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjJML0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjJML0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:26:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33993BD;
        Fri, 13 Oct 2023 04:26:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6CFC433C7;
        Fri, 13 Oct 2023 11:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697196371;
        bh=RuJES9wsIhm/41SO2jZyNN7nyVs++ro407XwfKTbpjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpiRTsF96U0xrIWoYroczPVR26jd69RIcfdScsFLaabbJkztQOX3B/TzV/9VCM/Tg
         l66+MlKvMjYJgJfeL18Jt8z8fSV6C7dWk3nPHW2quwObtttPFSg72P72qttGvRn5Ma
         cftPiBRPyuWRX+S/OWW8VRDL5PqmMzZ6NisKa4bXF5dDHaqeHGBafADFZRPqPiytoi
         W/XbqWt6w0fQDidaERsAt9glLgtSjM/rwEOPr/wVvot5pNgC5F2BUol/Jh7keMsOmH
         3Rx36T+qsY2/KnNJb5viSuDOoZruWpcUmtZWGULZNUDH3yf/PCGFnIyUz0MHZb5dMS
         etFvO5PZDA3iA==
Date:   Fri, 13 Oct 2023 13:26:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>, Sebastian Jug <sejug@redhat.com>
Subject: Re: [PATCH] blk-mq: add module parameter to not run block kworker on
 isolated CPUs
Message-ID: <ZSkpUFlw8FINofLG@lothringen>
References: <20231010142216.1114752-1-ming.lei@redhat.com>
 <ZSWb2DNV9cIPYv5H@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSWb2DNV9cIPYv5H@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:45:44AM -1000, Tejun Heo wrote:
> > +static bool respect_cpu_isolation;
> > +module_param(respect_cpu_isolation, bool, 0444);
> > +MODULE_PARM_DESC(respect_cpu_isolation,
> > +		"Don't schedule blk-mq worker on isolated CPUs passed in "
> > +		"isolcpus= or nohz_full=. User need to guarantee to not run "
> > +		"block IO on isolated CPUs (default: false)");
> 
> Any chance we can centralize these? It's no fun to try to hunt down module
> params to opt in different subsystems and the housekeeping interface does
> have some provisions for selecting different parts. I'd much prefer to see
> these settings to be collected into a central place.

Do we need this parameter in the first place? Shouldn't we avoid scheduling
blk-mq worker on isolated CPUs in any case?

Thanks.

> 
> Thanks.
> 
> -- 
> tejun
