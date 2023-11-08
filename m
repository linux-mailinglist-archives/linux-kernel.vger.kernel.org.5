Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2BD7E4F00
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjKHCmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKHCmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:42:20 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28371184
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:42:18 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7ad501764f4so118943539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 18:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1699411337; x=1700016137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0/YVAel4Gttz4i2ZT43a1gG1mnikYVH5WxWUT8rkkA=;
        b=X3IRmnQBd3UijRz2S8HIOYIOvuFYHMaBGZ+mKP2ErA9xJfEcCS1TXT9nCWTg+ZpHnm
         mfB5bAYgVi8+GOGCFgvY3cune1fTdlNXgl+17em80ChbNeU8AtBOGOVTQ9lSCF+7rP1/
         dRftoH/NELbyQ66eXUFMTMNKv4EIPSHe1itP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699411337; x=1700016137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0/YVAel4Gttz4i2ZT43a1gG1mnikYVH5WxWUT8rkkA=;
        b=VhDcjAFibo32+4OAjWc4RvejicmgTRMN6yVOnRX1hgCb7NT0ZTMol2vC/CNHS5jY10
         zAX/oIDXKiMc6PMNsunIUSqD1NFFBuhJQNQCpclwJqCjvAL776tceQXP0lIAmHEn7KcZ
         ALlgRzsdGsFCK5Uea9HTaAPcp9lVTssJ463UCaGbfXzvWovrSg8Ze59z4CO8Tas+CxoO
         LMCvC4epk6g/D0O5h83ssyeBWLasAFWtLh3aVwcvsLWqi9xX1C0Ul2qcxgv5u8YNoaFg
         0Xjh/oQX8/rUQhzMydzUIYXCHic8SN88vT/a6yv4nQI4LkLW0NNNUROeMdT4HUlyXyKH
         B3tw==
X-Gm-Message-State: AOJu0Yyn5CcCjpjwuif58gb9vyoLn/s5TRfkRGNyPdWXxfIbOWEIY0pn
        InSr9aX9MFVXqINfT2lwdJMdbA==
X-Google-Smtp-Source: AGHT+IGIIe2W7d5LVTX6AoRFW05ZsrY22EQeoefXPK016WTBYYH6khHyH8shA8THqOmVsKy3XSIzLw==
X-Received: by 2002:a5d:9282:0:b0:794:efb0:83d6 with SMTP id s2-20020a5d9282000000b00794efb083d6mr742434iom.12.1699411337472;
        Tue, 07 Nov 2023 18:42:17 -0800 (PST)
Received: from localhost (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id ft8-20020a056638660800b00452e02e784fsm3052078jab.144.2023.11.07.18.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:42:16 -0800 (PST)
Date:   Wed, 8 Nov 2023 02:42:16 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <20231108024216.GB2992223@google.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <d6811957-1cb7-489d-a3da-f38622d7f515@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6811957-1cb7-489d-a3da-f38622d7f515@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 12:58:48PM +0100, Daniel Bristot de Oliveira wrote:
[...]
> >> One more consideration I guess is, because the server is throttled
> >> till 0-laxity time, it is possible that if CFS sleeps even a bit
> >> (after the DL-server is unthrottled), then it will be pushed out to a
> >> full current deadline + period due to CBS. In such a situation,  if
> >> CFS-server is the only DL task running, it might starve RT for a bit
> >> more time.
> >>
> >> Example, say CFS runtime is 0.3s and period is 1s. At 0.7s, 0-laxity
> >> timer fires. CFS runs for 0.29s, then sleeps for 0.005s and wakes up
> >> at 0.295s (its remaining runtime is 0.01s at this point which is < the
> >> "time till deadline" of 0.005s). Now the runtime of the CFS-server
> >> will be replenished to the full 3s (due to CBS) and the deadline
> >> pushed out. The end result is the total runtime that the CFS-server
> >> actually gets is 0.0595s (though yes it did sleep for 5ms in between,
> >> still that's tiny -- say if it briefly blocked on a kernel mutex).
> > 
> > Blah, I got lost in decimal points. Here's the example again:
> > 
> > Say CFS-server runtime is 0.3s and period is 1s.
> > 
> > At 0.7s, 0-laxity timer fires. CFS runs for 0.29s, then sleeps for
> > 0.005s and wakes up at 0.295s (its remaining runtime is 0.01s at this
> > point which is < the "time till deadline" of 0.005s)
> > 
> > Now the runtime of the CFS-server will be replenished to the full 0.3s
> > (due to CBS) and the deadline
> > pushed out.
> > 
> > The end result is, the total runtime that the CFS-server actually gets
> > is 0.595s (though yes it did sleep for 5ms in between, still that's
> > tiny -- say if it briefly blocked on a kernel mutex). That's almost
> > double the allocated runtime.
> 
> I think I got what you mean, and I think I took for granted that we were
> doing overload control on the replenishment, but it seems that we are not..
> 
> I just got back from a doct appt, I will do a proper reply later today.

Ah ok! Thanks Daniel! And hope the appointment went well.

 - Joel

