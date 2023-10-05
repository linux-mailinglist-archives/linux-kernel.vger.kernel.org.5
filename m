Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3C27B9904
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbjJEAB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjJEABZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:01:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401839E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:01:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69215C433C7;
        Thu,  5 Oct 2023 00:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696464081;
        bh=pT9bmZ/bh9lBQv3geI9gE4cnZuBHmmOmTxUsClrb6Fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JRd87dnOFadg5OvUjak2dHXVko0c6jmwa6+NDYsPZVf4pdl4xVij21I48MK4Ub96A
         ewuuo/fsKr+1izHtrClBss4FJM58CPItamH8YToY1tF3WhWDi9jg+XU2+fxn2UFzD7
         Fa2TWVeDy0UmYIfUXwdA9Coltz8+jLxgb10U8yoJBdQJIojur7FLv2fRCqcsUiuXWw
         Axr3Udy/gPKlyvgXanCdlWnsc83jvhEqeKW1+rDdED1BuHAxrOEo1NW8IfQqt4zqSL
         tD22Ab1ciklntJQ+V5mi8MOy344z9iAXedkpgKRyUPQyrMqQWQpNs0ukT9k+wbtHVU
         G2g7K0ht1ILYA==
Date:   Wed, 4 Oct 2023 17:01:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
Message-ID: <20231004170120.1c80b3b4@kernel.org>
In-Reply-To: <20230926182625.72475-1-dg573847474@gmail.com>
References: <20230926182625.72475-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 18:26:25 +0000 Chengfeng Ye wrote:
> I find tcf_gate_act() acquires &gact->tcf_lock without disable
> bh explicitly, as gact->tcf_lock is acquired inside timer under
> softirq context, if tcf_gate_act() is not called with bh disable
> by default or under softirq context(which I am not sure as I cannot
> find corresponding documentation), then it could be the following 
> deadlocks.
> 
> tcf_gate_act()
> --> spin_loc(&gact->tcf_lock)  
> <interrupt>
>    --> gate_timer_func()
>    --> spin_lock(&gact->tcf_lock)  

This is a TC action, I don't think it can run without BH being already
disabled, can it?
-- 
pw-bot: cr
