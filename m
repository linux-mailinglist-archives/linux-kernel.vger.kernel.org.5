Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35397644BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjG0EDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjG0ECw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:02:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699911BC3;
        Wed, 26 Jul 2023 21:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F194761D1F;
        Thu, 27 Jul 2023 04:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622B7C433C7;
        Thu, 27 Jul 2023 04:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690430568;
        bh=xmIo8Za+wGb3kA2DcO9/AhwOvETbc1Ip+6DhLrfwd9I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZdbvuDapJ3/oAxqWo9LZn+q1uZ1c7FPcY6urQKKOCfVI6KfKFIfyz3ZpErbhtr2SX
         ba35woGOtesd6yopwpxae/soGGWyz3B/kEGPfvRbd9RzmaRPEc2j1Pjb39iXNyGZky
         1EdJA2ILs83eyxOZWkov4G0IZZ4XUPqDU5GgF/nViIBEXc2DSic2DzGbSSlLsBE9mk
         FckXnRJpb3mkVtiPJ4TaajKJQ+tudb2+hwVbsJXP1D8o59sILscf3CEUMFKHk4eUUV
         SsqIc3f4mJsmgfrUmECxhU80bJk0WZmgXGYBvjJL3XhjXzSbh7qym/CU4kOZfczHZ3
         YwruHM8CThrmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 09ED8CE0BDA; Wed, 26 Jul 2023 21:02:48 -0700 (PDT)
Date:   Wed, 26 Jul 2023 21:02:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "open list:SLEEPABLE READ-COPY UPDATE (SRCU)" <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/5] srcu: Fix error handling in init_srcu_struct_fields()
Message-ID: <3549e916-3829-40b8-b2ae-7a969826105c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230725232913.2981357-1-joel@joelfernandes.org>
 <20230725232913.2981357-3-joel@joelfernandes.org>
 <1943e34c-3c8e-411c-a677-33f8c5b4b0e5@paulmck-laptop>
 <d7d0f4c2-dd88-4ad2-8405-3c9b5d8cbb39@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7d0f4c2-dd88-4ad2-8405-3c9b5d8cbb39@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:04:04PM -0400, Joel Fernandes wrote:
> 
> 
> On 7/26/23 17:07, Paul E. McKenney wrote:
> >> -				free_percpu(ssp->sda);
> >> -				ssp->sda = NULL;
> >> -				kfree(ssp->srcu_sup);
> >> -				return -ENOMEM;
> >> -			}
> >> -		} else {
> >> +		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
> >> +			goto err_free_sda;
> >> +		else
> >>  			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
> > Given that the "then" clause is a goto, what is the "else" clause doing
> > for us?
> > 
> 
> Not much. Agreed we can get rid of "else" and reduce indent of the
> WRITE_ONCE that follows.
> 
> Would you mind making this fixup in the patch for your apply, or would
> you like me to refresh the patch? Let me know either way, thank you!

Please include it with your next series, which has at least one other
change anyway.  ;-)

							Thanx, Paul
