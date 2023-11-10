Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E167E8296
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346278AbjKJTVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbjKJTUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:20:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04994884E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:12:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBA9C433C7;
        Fri, 10 Nov 2023 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699643544;
        bh=IDkJf9q/qJFiQ7tkUVGvravDFMJPMy5QQpsSAsjYTNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T8UeBQHaCQwHes7sv1XY8YK0kaIOgq3TLAflaNs33FHhx53cKPFv9YbTCaLkMgM58
         Yul3LTQSzhK4A7lXCWHmy3dP4vljIjIXnT/16XJwwefFKxJsBE+u+auaenycQi8HRz
         65qVGY3vZIC1rtVWDO7oagtYjCR7Ueir60ZdaPuXHlex3OwPpN0ZMJLNq0cJIssIwc
         ON+jYNqR57YWBlLA+ZSI3ddi3JPbsaCYSBtVcClHB0/UjjD+I6+Mc1t52SGjQpzFNW
         rpqz6ChRBUITHhE6se6UBFO9tf2pli7l8CWhMcEQNIQwbMKsvRXAmOTuVodsfCb6l7
         IRAwqF6RIrQcg==
Date:   Fri, 10 Nov 2023 11:12:23 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dipendra Khadka <kdipendra88@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v2] Fixes the null pointer deferences in nsim_bpf
Message-ID: <20231110111223.692adbd7@kernel.org>
In-Reply-To: <20231110111823.2775-1-kdipendra88@gmail.com>
References: <20231110084425.2123-1-kdipendra88@gmail.com>
        <20231110111823.2775-1-kdipendra88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 11:18:23 +0000 Dipendra Khadka wrote:
> Syzkaller found a null pointer dereference in nsim_bpf
> originating from the lack of a null check for state.
> 
> This patch fixes the issue by adding a check for state
> in two functions nsim_prog_set_loaded() and nsim_setup_prog_hw_checks()
> 
> Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com./bug?extid=44c2416196b7c607f226
> Fixes: 31d3ad832948 ("netdevsim: add bpf offload support")

Don't think so. It's probably due to Stan's extensions / reuse of 
the offload infra.

Please put more effort into figuring out when and why this started
happening. Describe your findings in the commit message.

Current patch looks too much like a bandaid.

Before you repost read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr
pv-bot: syz
pv-bot: 24h
