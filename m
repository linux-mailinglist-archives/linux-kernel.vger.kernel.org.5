Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D980EB41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjLLMGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346516AbjLLMFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:05:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305B3F3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:05:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c31f18274so50698335e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702382757; x=1702987557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=13Ja0Nw0pPSuSjFH0IeSQRlQSG+h5LbxqOjPprrcVUw=;
        b=LBTBVL+e6HjCFWoT5yz3khfIQFU+1yrZ0091b8YaLlhi6LhWpOoStg+TCbnC6rs2S5
         MKRojI3gw3lQiPqgPRrY5iNnaR1YJ2KwGimH+OkAwcDpzrTCSFeTgDoUbIFYN0hXHSfr
         tmr8lJmsgTzZ9GasTICsEw/En6yAWjItt0DQIPTYLHvhcEhW61iGDJECbVRHw1EaEIBd
         AO4NJT23w5FVZANyWyWZkuDr5tARX2i1tlhReEBxHqOhlfSMjf+ZyVXIfi8DNTym89Tb
         WnFNgnWczL27cjFgjkw+2O29GTstuY3Hrk7jWWm9E7A8jkoiPuawniEecm5RdM2J5Xix
         8xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702382757; x=1702987557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13Ja0Nw0pPSuSjFH0IeSQRlQSG+h5LbxqOjPprrcVUw=;
        b=a1FiX2I5qiRzK8BM33dqhsTQQEtxb0qI/+4SNApbgFv50S3eRfKTFzH2BH7gCLMrff
         xDYSfZG2tekGA/dgJHu9RAT/Su54gKiNYtK8NaDMmHYjrVOZMjYMWOQO1JJsGeAISdTn
         znW8LF3smGb0lZmLMmqJ9iJhLbUEGy7wDq6xYp6tRp3B/utZkC/1iMt81K9hE6FZP6sr
         oeWsI9/RmSY/N/+SqFYzupFuieKwJ6TsaC2/3IYI/Zrec2Vtqv5FFLyHbxiwwl0HBCht
         TU3pnoTGsXg9LKvPeFPXinCZPeVQGjGrauuOlnJun+y55ctNEl2dyeoW2UiWqS+hvWwl
         7sYg==
X-Gm-Message-State: AOJu0Yy/4JM/wTITu3bfHNbjVW3+KFiZUsyGIy08h1NpdK5bCzsVn4ZV
        sP522j3UoDbTVrAHE33dQXKoxQ==
X-Google-Smtp-Source: AGHT+IGgjoAn2HE1UEgBwViiepp0+DZatRSss7QIX4mMogy9AnMEBgnie0Cd206XFxiA8r5oPda77g==
X-Received: by 2002:a05:600c:4812:b0:40c:3bb2:ca58 with SMTP id i18-20020a05600c481200b0040c3bb2ca58mr2815131wmo.31.1702382757343;
        Tue, 12 Dec 2023 04:05:57 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c0a1400b004064e3b94afsm18818476wmp.4.2023.12.12.04.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:05:56 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:05:55 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
Message-ID: <20231212120555.wradm57buz7ckv4p@airbuntu>
References: <20231203011252.233748-1-qyousef@layalina.io>
 <20231205162043.GA2558193@google.com>
 <20231207172032.kto27hfdxa4juq7b@airbuntu>
 <0d531690-1240-4356-a647-b4c71a56b31d@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d531690-1240-4356-a647-b4c71a56b31d@joelfernandes.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/23 01:26, Joel Fernandes wrote:
> On 12/7/23 12:20, Qais Yousef wrote:
> > On 12/05/23 16:20, Joel Fernandes wrote:
> > 
> >> I think a better approach is not do an anti-CONFIG option and instead do
> >> a shorter parameter "rcutree.lazy=0". If CONFIG_RCU_LAZY is set, then we can
> >> just default to keeping lazy on. I'd like to avoid proliferation of already
> >> large number of RCU config options and more chances of errors.
> > 
> > The issue is that we don't want to ship with default on :-)
> 
> Yes, so you can ship with rcutree.enable_lazy=0 which this patch adds, no? In
> theory, you can accomplish this by simply CONFIG_RCU_LAZY=y and
> rcutree.enable_lazy=0 or rcutree.lazy=0.
> 
> However, I see the inconvenience factor (you have to set a boot parameter
> without making this a purely .config affair) so I am not terribly opposed with
> this patch (I am also guilty of adding a CONFIG option to avoid having to set a
> boot parameter (for unrelated feature), but in my defense I did not know a boot
> parameter existed for the said feature). ;-)

It is more than inconvenience. The GKI doesn't ship with a specific userspace.
So we can't guarantee the boot parameter will be set and have to rely on no one
missing the memo to add this additional parameter.

And to speed up adoption and testing, I am backporting the feature to 5.10,
5.15 and 6.1. It is risky enough to get a backport, but to default on it could
  introduce more subtle surprises. But not doing so we could end up waiting for
2 years before enough people move to the latest LTS that contains the feature.

> 
> >> I also want lazy to be ON for everybody configuring it into the kernel by
> >> default (those who don't want it just set CONFIG_RCU_LAZY=n), this is what
> > 
> > This is still the default behavior.
> > 
> > And all or nothing approach is not practical. You're telling me if I can't ship
> > with default off, then I must disable it altogether. Adoption will become
> > harder IMHO.
> 
> No, that's not what I said. You misunderstood me (which is probably my fault at
> not being more clear). It is not all or nothing. I am just saying you can
> accomplish "default off" by just setting the boot parameter. With this patch,
> you are not willing to do that out of convenience, which I can understand but
> still we should at least have a discussion about that.

Okay, sorry if I misunderstood.

> 
> > 
> >> tglx also suggested that's why we made changed of our initial prototypes of
> >> call_rcu_lazy() and instead we made call_rcu() to put everyone on the lazy
> >> train and not add more APIs (thus causing more confusion to kernel
> >> developers). This was a bit painful, but it was worth it.
> > 
> > I think implementation details make sense, but orthogonal to the problem of
> > enabling CONFIG_RCU_LAZY=y but still ship with default off. It is a risky
> > change and we want to start staging with default off first.
> 
> Never had any issue with that. I very much want to see this safely rolled out to
> Android. ;-)
> 
> > Not allowing this
> > in upstream means I'll either have to resort to keep it disabled, or carry out
> > of tree patch to get what I want. Both of which would be unfortunate.
> 
> There is already precedent for building things into the kernel but keeping them
> default off, so I don't have an issue with the experimentation use case. I was
> just discussing whether the additional CONFIG is really needed when you already
> have added a boot param to keep it default-off. If you have an argument for why
> that would be really helpful [1].
> 
> Also, nit: rcutree.enable_lazy is probably better than rcutree.enable_rcu_lazy.
> The 'rcu' is redundant.

It matches the config option so feels natural to have them both named the same?

> 
> Other than that, the patch LGTM but if you could update the commit log with
> details about [1], that would be great. And while at it, you could add my tag:

You forgot to include [1]? Or I'm just blind today?

> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks!

--
Qais Yousef
