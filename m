Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347DA78C15F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjH2JZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbjH2JYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:24:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FC412F;
        Tue, 29 Aug 2023 02:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1FF465293;
        Tue, 29 Aug 2023 09:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0108DC433C8;
        Tue, 29 Aug 2023 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693301067;
        bh=kusXvvvdY8OjEpV+HMrNfp/7EGwgt1unwYM4Lul4vKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPQ9DdWzjNt5oSvZl1nQFaQSAtJr1zH1zoI0Lj/fEsd3/d0rdfh+ZZ2fD5K98eruE
         O+ZPACzU9tblMQ8o9V88rs0lJo4yBA97ylSFoX82syWxQtiPDbRQO9n3QZoaK8DhxL
         KGDsq0bh3xMy5LD6g/xIBSM3zEAmo7r+4nT45Io8akfYKFxHGM8Qt+QXkUPZsaB/rf
         XxzW6NG8Mp9JhXAfR3vhCe/OJqRyFCaaAlxAPlch70nhbqkTmcrogUKwWw+xkHYMj/
         gK/N6DQmEDXtHHMDaUCX/LZn/6JnWiu8rC93vp8ahuiMjqOFyEU1qhKbZhiX/Q4WQg
         j7KBJO939+zKQ==
Date:   Tue, 29 Aug 2023 11:24:24 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Z qiang <qiang.zhang1211@gmail.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in
 rcu_nocb_toggle()
Message-ID: <ZO25SDat3cd6opQ7@lothringen>
References: <ZOy6mfw5Yr7hsi3i@2a01cb09806c67d6fe4a366cc09da8f8.ipv6.abo.wanadoo.fr>
 <16F11103-75C4-4DCE-8272-D619ECAA96BD@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16F11103-75C4-4DCE-8272-D619ECAA96BD@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:51:09PM -0400, Joel Fernandes wrote:
> I think the issue is the loop later in the function does
> not try to toggle cpus that came online too late.
> 
> So it does not test offloading on all CPUs just because max got updated too
> late.

Right, and therefore for_each_possible_cpu() or for_each_present_cpu()
should be fine to iterate since it's ok to try to toggle an offline CPU.

> 
> One fix could be to periodically check in the loop if a new cpu at maxcpu + 1
> ever got onlined. If it did, update the maxcpu.

Is it worth the complication though?

Thanks.

> 
> Thanks.
> 
> 
> > 
> > Thanks.
