Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97C7AF81D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjI0Cai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjI0CUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:20:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F70B194
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:56:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5cd27b1acso86550955ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695761790; x=1696366590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K+cA0vEenc1gqjUMM9wmqTHY3iLNBl/eCPHeoCPbd9o=;
        b=Kq/RuLeI1lsxBMQk6FTV9WLOxdyOooQs0Jb29yl0kLyXR9SBKICMctAwUj71b2pgSm
         l7Bd2Tie3PBRIhRmzsZWl4Q5kDzQuhoFiLsCdL/5p206FS+lSLbapfL6FAfzBXOc/yC5
         DK/VWMVnjYvxdWLKh7Lxf/MwA98AJBzNG4YH5uI57g8xKa3Jd1o71Wee2HNbFxiC9i5x
         S4bAbvDf70DVjeonBw77JLXtKLzEbI1rg4UyiSfPP1dLA/V+DDBmCiiAEXAL5k8t2F2T
         SkWpIclpLt8ElFDJZOamU3AMGOj2pjI7QUm9QYn4mCw6+DTCB2gEJ31l6uFT9Ke6TGW+
         fVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695761790; x=1696366590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+cA0vEenc1gqjUMM9wmqTHY3iLNBl/eCPHeoCPbd9o=;
        b=Fd/0yvKG7R+HH6aAh/RA5hpbrMCbvMPK0Q9nu3jr2wXx17pcp65qAwra/J+VtgzXTi
         DVoIACpxeiti4EJ5j55cXjjxsBTgOcjScpBg/TXIL1Q7MbHytthP8yRyFnAOT0ZXzozO
         5qorJUf1ifTwlcHzoB4rvu/9YE36uOAYCabMZjAuOg240mI0OnMMKkqu6a+0Nhz6QYN4
         pyXnWvYeOB6I+677Ou00OwXw/I0lE0iNhceur7iwY6/J/9C7bLdfs06pCIvw08SIrR6K
         NY+462lLV+E6i3rDGmg9WNvXl/G4Ak3dIQqwxfpS+oCjqjVhn9Ukm+LCJxhxj3Wwf8oB
         tYxw==
X-Gm-Message-State: AOJu0YwuzAMpV7jauaERBWc8YcH9bgtBojOCS1t8hedugExSJjEjtds5
        tdNHAidKgwk79sY7kUDpveNI/A==
X-Google-Smtp-Source: AGHT+IHm1IEuFlvmqbG+rMZZJWspqFftAv9gQV/yoTCiylQnMNOAJue7sY122lWTZw0J/AV6+YyC/Q==
X-Received: by 2002:a17:902:c951:b0:1c3:a91a:627f with SMTP id i17-20020a170902c95100b001c3a91a627fmr12682196pla.47.1695761789886;
        Tue, 26 Sep 2023 13:56:29 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b001bdb85291casm11445673plg.208.2023.09.26.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 13:56:29 -0700 (PDT)
Date:   Tue, 26 Sep 2023 20:56:25 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prakash Viswalingam <quic_prakashv@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Avoid spurious freezer wakeups
Message-ID: <ZRNFeXZ4tRbT7ws6@google.com>
References: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
 <ZRMEHb3_0Ku1UuK_@google.com>
 <20230926200238.GB13828@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926200238.GB13828@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:02:38PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 26, 2023 at 04:17:33PM +0000, Carlos Llamas wrote:
> > 
> > This issue is hurting the performance of our stable 6.1 releases. Does
> > it make sense to backport these patches into stable branches once they
> > land in mainline? I would assume we want to fix the perf regression
> > there too?
> 
> Note that these patches are in tip/sched/core, slated for the next merge
> window.

We can wait, no problem. I just wanted to make sure we also patch stable
if needed. Elliot, would you be able to send a backport of your patches
to stable once they land in mainline on the next merge window?

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org

--
Carlos Llamas
