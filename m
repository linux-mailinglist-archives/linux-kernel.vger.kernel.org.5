Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCDB78C2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjH2Kx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjH2Kx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:53:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34311AD;
        Tue, 29 Aug 2023 03:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36C076549D;
        Tue, 29 Aug 2023 10:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F02AC433CA;
        Tue, 29 Aug 2023 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306403;
        bh=Shsj+vPzu/D2j5Y+GxlorxF1u84+Dwugwd6FWmNj63U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9hoWJSJY1mz3pLb8V9jQNig/TJu9aFLXi2oC1NqPy/HLp6cWNJTwIhOcfyKL/zpz
         D1TEo+zfG38H99g+0Wdh4U2l6b/Smp/G4m7IAKuPs76+LFguQX72m7eoDm9v8mkgvk
         OxZW/pPJJ4AqdtW68+gnOyWx4Rbi5TTpqbxP8AtVsQstkaRZmffSDBUCu3POif59fr
         1ggsAxZIxRYdsQZI7lieQESxFqUkmx9eDIfISPsDNAr+8QyOzH6nUN9Z4nCgcT4Dw+
         1Sy4htezlnhqrNLGV5PPrWIyvGP23o7xOTrk1P/H7PT69HzQIoqnajvgksezWxwm0k
         V3wT3trXTGLpA==
Date:   Tue, 29 Aug 2023 12:53:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        paulmck@kernel.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 3/5] tree/nocb: Adjust RCU_NOCB_WAKE_* macros from
 weaker to stronger
Message-ID: <ZO3OIBYSYx/jBv7s@lothringen>
References: <20230729142738.222208-1-joel@joelfernandes.org>
 <20230729142738.222208-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729142738.222208-4-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 02:27:33PM +0000, Joel Fernandes (Google) wrote:
> This is needed to make the next patch work correctly as we rely on the
> strength of the wakeup when comparing deferred-wakeup types across
> different CPUs.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 192536916f9a..0f40a9c2b78d 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -288,8 +288,8 @@ struct rcu_data {
>  
>  /* Values for nocb_defer_wakeup field in struct rcu_data. */
>  #define RCU_NOCB_WAKE_NOT	0
> -#define RCU_NOCB_WAKE_BYPASS	1
> -#define RCU_NOCB_WAKE_LAZY	2
> +#define RCU_NOCB_WAKE_LAZY	1
> +#define RCU_NOCB_WAKE_BYPASS	2
>  #define RCU_NOCB_WAKE		3
>  #define RCU_NOCB_WAKE_FORCE	4

Good change but make sure to audit all the occurences of
RCU_NOCB_WAKE_LAZY and RCU_NOCB_WAKE_BYPASS. For example this breaks
do_nocb_deferred_wakeup_timer() that will now ignore RCU_NOCB_WAKE_LAZY
timers.

Thanks.
