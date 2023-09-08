Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C55E798850
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243557AbjIHOLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjIHOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:11:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEFF1BF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:11:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31c65820134so1925983f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694182267; x=1694787067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0CQ0+G47TeLzn0nHNVztADMp6FUr773QDhjmSsmMsc=;
        b=jNq/RTxzPUJ9vWYc8A2KgC+QnDIl/IwQuDoA0yigFB0QDlvx1rW4JRX7mgaq/I5TiX
         sKdEDFhK5zh9CD2sMk95uKgsAMJ5NjF0ZaD/qYjpUwdBIxX4cyb0NO6VpVP36kQt74L1
         bQJjmWg6fgb5z0WffyxpuS5bBH/2mAGZF7OKkkUpbt0nC2/2Kfndba3kfWw+To9y0Xjj
         9UmquYLnRdTWqCzD5tmzZX1FT8dXU2SJs5ueBC46b+nu6xbSK8dk/UIqhpNuPm2hUCbj
         1ep8qJ8aZ0sq87iWi2B1UCcdjmunJPaWVhoFjZ2x2rq8TpPydcsf+gLGAPoOBSVObRcj
         ++FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694182267; x=1694787067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0CQ0+G47TeLzn0nHNVztADMp6FUr773QDhjmSsmMsc=;
        b=XNtsdLHMiIRBKMHkBibr0jSiBM2UklO6idHdrTh1HkNRI0obuWFgdWhplff+DisT+Y
         wDHMWdqRvJOScVX+QcCuiOe7g6VadpDGNfliil0Ry2Y8U1hPKnt5OysN+VfnM6atc4J5
         0IQnWlaxy4jfnh5/sFOmuTZdbNzjuQxd3rbQ5N47tvGbQP1b97adMqgZGH5B5DvBL7dM
         E97gzcuxyyLy6Urzau87c79udTTGhdbCGn2ANjD/ALYnrbAHLIrX3aNhMzv8rybDifMn
         QIsbyW3mPHpspA9DJuLe6LGwVnhERrkM1rm4dZOz/Db0Jptp5LXRmmTgjNvw2Ww2IMzp
         ibVA==
X-Gm-Message-State: AOJu0YxGL089h62D+APFCoiJLD0G34uSlO/ZzBjQI9Skv+rMhOZ/5ps7
        JfSTuH6j4kQgqFuFP1/nguyfUQ==
X-Google-Smtp-Source: AGHT+IHaPpfGXwKUS+DavTXFA7zmXThPHAMTgMK1jjMsl6KSe5TFLr3UKuPqL8lYS+DukvL+zSfDvA==
X-Received: by 2002:a5d:6142:0:b0:314:1f6:2c24 with SMTP id y2-20020a5d6142000000b0031401f62c24mr2170720wrt.36.1694182266828;
        Fri, 08 Sep 2023 07:11:06 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d694f000000b003143c6e09ccsm2209653wrw.16.2023.09.08.07.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:11:06 -0700 (PDT)
Date:   Fri, 8 Sep 2023 15:11:05 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230908141105.ofoht5z66sm6mmq2@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230907130805.GE10955@noisy.programming.kicks-ass.net>
 <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
 <20230908102511.GA24372@noisy.programming.kicks-ass.net>
 <20230908133336.uge4hcnx4cum3lg5@airbuntu>
 <20230908135939.GD24372@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908135939.GD24372@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/23 15:59, Peter Zijlstra wrote:
> On Fri, Sep 08, 2023 at 02:33:36PM +0100, Qais Yousef wrote:
> 
> > > (even hardware has these things today, we get 0-255 values that do
> > > 'something' uarch specific)
> > 
> > Ah, could I get some pointers please?
> 
> Intel HWP.EPP and AMD CPPC EPP I think.. both intel-pstate and
> amd-pstate have EPP thingies.

Okay, thanks!

So do you see tying this to the presence of some hardware mechanisms and
provide a fallback for the other systems to define it somehow would be the best
way to explore this?


Cheers

--
Qais Yousef
