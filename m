Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE17BC2E9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjJFX2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjJFX2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:28:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56CE93
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:28:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7EAC433C8;
        Fri,  6 Oct 2023 23:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696634916;
        bh=f5eweFB5hd+xL6C7jrCKOvGvrLEavAJkP3G3+xCH9sg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ezPcYympZev/th+LBy9uF0GsqZCUFNQFiJNcub94b15mhHWP52Xg7V0T//Is3MdmH
         BT+Vvlp1nD8n/r64ZriB5nWBsRgM765u/CjF+9vw/pSHqtR5XGo1Xw09c9IcZ7FgU8
         7W0rU/TBUnn2XY1ftVOC5Or4gevTjWzpO0vTYqAtZ2YfPzoLSsyVoGfwq3GB1HTXAr
         txpi2BajhHUjRK00GC/6iya7g9zdK2X8fddu+CRtfsMqqw4CvYflbo7qf/m/hViSMj
         u/j7hfiGHUdJn5hTZXD+T4LVkVFv3fLCFWFbDq5zigGGamxv+A7mLHYJR75Nhldjpf
         WfwoB2K+N2geA==
Date:   Fri, 6 Oct 2023 16:28:35 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     3chas3@gmail.com, davem@davemloft.net, horms@kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] atm: solos-pci: Fix potential deadlock on
 &cli_queue_lock
Message-ID: <20231006162835.79484017@kernel.org>
In-Reply-To: <20231005074858.65082-1-dg573847474@gmail.com>
References: <20231005074858.65082-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Oct 2023 07:48:58 +0000 Chengfeng Ye wrote:
> As &card->cli_queue_lock is acquired under softirq context along the

you say softirq here

> following call chain from solos_bh(), other acquisition of the same
> lock inside process context should disable at least bh to avoid double
> lock.
> 
> <deadlock #1>
> console_show()
> --> spin_lock(&card->cli_queue_lock)  
> <interrupt>
>    --> solos_bh()
>    --> spin_lock(&card->cli_queue_lock)  
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch uses spin_lock_irqsave()
> on the card->cli_queue_lock under process context code consistently
> to prevent the possible deadlock scenario.

and irqsave here. I think you're right that it's just softirq (== bh)
that may deadlock, so no need to take the irqsave() version in process
context.
-- 
pw-bot: cr
