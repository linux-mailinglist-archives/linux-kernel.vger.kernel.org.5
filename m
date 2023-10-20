Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460CE7D1644
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjJTTWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjJTTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:22:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A4D41;
        Fri, 20 Oct 2023 12:22:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC81C433C8;
        Fri, 20 Oct 2023 19:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697829729;
        bh=tURciTQclBfgEIbO47BJ7qrPj5Gyb3NVEPoOlslHMzM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=odQm5THCIczSy3qQHKgscLkiFBw00Ekbo2mzdQf96X5KdbdJUMbO0AtEIVwMiCTcr
         B1PMTsYqwd2tGwRK/8pO3c8GHlFJFQbC9HWxogQtxKO7r+0T+eaB046bTk+5+dRzpA
         f+Lk3+WmFrbVqcy9qM/++UYniBvi+Bh5kRZ3QIBP/hLmfTlJSWUUIF3pBrrU4lczSt
         /Pt/Ew3srWcfzUA+/1RSfDuUnE/QUnC/7zawcQfFvBS8TR/FmffXaKVuZzqCcklZeW
         /fE2eQSQlYCU2jJvsw4Xpn0TbYZYzaC4/RYwL8rTmXIPIc8TCdqd5BiVdPAg0gNy1p
         B9Mg3zerYd2jQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A8904CE0AE2; Fri, 20 Oct 2023 12:22:08 -0700 (PDT)
Date:   Fri, 20 Oct 2023 12:22:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove unused macros from rcupdate.h
Message-ID: <b2a15247-fbe6-47bd-9857-5d5163834dfc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231020173015.30509-1-pedro.falcato@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020173015.30509-1-pedro.falcato@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 06:30:15PM +0100, Pedro Falcato wrote:
> ulong2long, USHORT_CMP_GE and USHORT_CMP_LT are redundant and have been
> unused for quite a few releases.
> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
> Just a boring chore patch that cleans up a few unused macros.
> 
> I'm *very* interested in knowing how that ulong2long macro came along,
> though. What was wrong with '(long) a'?

Signed integer overflow, if I remember correctly.  But the Linux-kernel
build process forced signed integer overflow to be defined.

Queued for v6.8, thank you!

							Thanx, Paul

>  include/linux/rcupdate.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 5e5f920ade9..b9b6b828115 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -34,9 +34,6 @@
>  
>  #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
>  #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
> -#define ulong2long(a)		(*(long *)(&(a)))
> -#define USHORT_CMP_GE(a, b)	(USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> -#define USHORT_CMP_LT(a, b)	(USHRT_MAX / 2 < (unsigned short)((a) - (b)))
>  
>  /* Exported common interfaces */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func);
> -- 
> 2.42.0
> 
