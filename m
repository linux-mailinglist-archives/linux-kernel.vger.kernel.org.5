Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458CC7C4AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbjJKGqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344451AbjJKGqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:46:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28A09B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:46:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so5858328f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697006788; x=1697611588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwtA+hno23ELHNqbl06IpWLX/dKD8muoo0IC8mLLZDs=;
        b=Wh7jt5OVdvndEZDab8c4hvet/m6H+0ISHUosEUx5BPk+QN11+DYeYxqg6jX8AeugsZ
         0E2rSJiFspE4Nn7U80wbUWk2MVjo77j2xRHQbdaONBMQqcAx1IqBrEZ3eWtgcgzrpnEU
         2e7p1bYrLGMwMWePLTBtnoL82BdPrQY+lsvf/WB9FE092EFjHGbGu2i2CCIWIjThRoQo
         2K1Y3KWGC053qyB92of10nf2pvixAKQ52uUmOEKpBF/4vLz1vhn6fms4h9mdD9XOO8s/
         jkq0kbq7s+vRmjKV5dPWGekMxYH1QYqd2aHF/4IjkZzhdbPh+hRFz+cz/LZL3CFFKF7x
         2MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697006788; x=1697611588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwtA+hno23ELHNqbl06IpWLX/dKD8muoo0IC8mLLZDs=;
        b=cLfYFMx1wGOMM4UwUy36SpW6NsbIpANfVeCvE5Tws7YXKaR2ZuZyYLzEk25MnM8GEX
         i5XY6o7kACGLC4a9DSB3WuxND6u3xTB6BjgJUADPsvOeVLXWmm0u/dxvQEdih44PA++K
         kKrPKBIeL8pRaeaeoNeRZf4S/a9exdCJkvEIBAjbpZQS42XID1ZKgyJ3CFDHbszCVMbO
         k6PasGpFRK3n7RzGsYUrSLz5PjWmk0UiPCLMRUAcR7AV/L7IJH5DVEQbkERptljYKY2S
         D2e9ehvckGEave2QNOz4oaxDIbjZzyTSZExnxhgxcp+i99vUS3Su+EqkMM2tPu/aqbZM
         3szg==
X-Gm-Message-State: AOJu0YyYI++go7ZGVBri+1G+u69C/sLGaoOwzcCqHEJmH14nK971Cuk8
        qH60wBccwFBGL9HJT2DfYAE0jQ==
X-Google-Smtp-Source: AGHT+IHtG1J0pnk8vZPG9hX8u9FSMJhnkn+xltJNAMEP8s/F+e1JBZ/5ajTduYL0g1GbkEHXfdywfw==
X-Received: by 2002:a5d:4f8a:0:b0:319:7722:30c with SMTP id d10-20020a5d4f8a000000b003197722030cmr16162137wru.22.1697006788180;
        Tue, 10 Oct 2023 23:46:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v26-20020a5d591a000000b0030ada01ca78sm14485129wrd.10.2023.10.10.23.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 23:46:27 -0700 (PDT)
Date:   Wed, 11 Oct 2023 09:46:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 23/23] locktorture: Check the correct variable for
 allocation failure
Message-ID: <029de83a-dcf1-439d-8d6b-7267d2636e37@kadam.mountain>
References: <20231010115921.988766-1-frederic@kernel.org>
 <20231010115921.988766-24-frederic@kernel.org>
 <97ecfb49-e500-45f4-86bb-769b2d32e91c@paulmck-laptop>
 <beaba092-8545-43c9-9b65-6386f718cb01@kadam.mountain>
 <b9a976f6-c002-4e3d-8c6d-cef3953bd3a7@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a976f6-c002-4e3d-8c6d-cef3953bd3a7@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:53:36AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 10, 2023 at 05:07:00PM +0300, Dan Carpenter wrote:
> > On Tue, Oct 10, 2023 at 06:55:40AM -0700, Paul E. McKenney wrote:
> > > On Tue, Oct 10, 2023 at 01:59:21PM +0200, Frederic Weisbecker wrote:
> > > > From: Dan Carpenter <dan.carpenter@linaro.org>
> > > > 
> > > > There is a typo so this checks the wrong variable.  "chains" plural vs
> > > > "chain" singular.  We already know that "chains" is non-zero.
> > > > 
> > > > Fixes: 7f993623e9eb ("locktorture: Add call_rcu_chains module parameter")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > 
> > > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > A name change to increase the Hamming distance would of course also be
> > > good, though less urgent.  ;-)
> > 
> > "Hamming distance" is such a great phrase.  I'm going to use that every
> > time I complain about confusingly similar variable names going forward.
> 
> Glad you like it!
> 
> But the horrible thing is that I first heard that phrase back in
> the 1970s, and I am the guilty party who created these particular
> too-similar variable names.  (Why has the phrase fallen out of favor?
> No idea, really, but one guess has to do with the fact that current
> error-correcting codes must deal with different probabilities of different
> bits flipping in different directions, so you would instead needs a
> weirdly weighted variant of Hamming distance to accomplish anything with
> modern error-correcting codes.)
> 
> But how about something like the following?
> 

Looks good!

regards,
dan carpenter

