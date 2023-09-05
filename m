Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8B27931F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbjIEW1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244652AbjIEW1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:27:30 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CE4FA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 15:27:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-501bd164fbfso2221618e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 15:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693952843; x=1694557643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUOKbypPycGaibquhiHpCbUwj8/Cuiw080z6tXHBtyE=;
        b=DU8PaC+A6PiaCIN0W/5eAIERZW2J7dMciDr95uHg86wdH2ui0csKVJts97Wy+DIemA
         /X96u2PozmXDW6jePcKPnKplGmWsex11kqp0MRWJnCPtO1OB7PoDD0xxKIdou/mRnWjS
         t111Sr5qLvL2X9gRVaQF7tdA3BOQlWsqPqqzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693952843; x=1694557643;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUOKbypPycGaibquhiHpCbUwj8/Cuiw080z6tXHBtyE=;
        b=fkguSw0dPTZ5lr2edZlrH2xVw+u6vgRzu+SU3fJ5VG6CSGgO7YGGq+RpLQGroCLwlc
         1WZGsk76XURaYeKuS1XiEkMjYPGWwrvmt85L6LPjmTCmGgGp5MzUH958iW3in4/4Mykg
         EHONAvqugfRwXcku9XUsHXNTjAbQ9XQg8GcJ4/Z8SzkrvTsL9OKb18Qtcp6gaIT+FonA
         NmYaU94XbsaApZiqUENwWswK7bxXkJA1/TJQR8KHzoeberaQR0u1J+PoM6uXleRj6Sgq
         Z4cTd5du8oioZDw3XKhMBR+xmBJnGcNqa0w7gANS9KT/uuznGRylf6wHgWYwHpl6UKKh
         NabQ==
X-Gm-Message-State: AOJu0YxUyogDeFoROGs9bmTWh9pkIbx6v2N66EfC1kUkyTkdGrrRszY6
        R8I+3huIKWE/IPZ95c/DIHKF0yg3YeSXAup9SLcxZg==
X-Google-Smtp-Source: AGHT+IEFY5QAWw0Wz8S+7TKv5jGQ8nerbW6isiVGv1RG13u+enH77qyZg81YHw/ApBgnGwd3cNZNPgH/BHzjwSYFpdc=
X-Received: by 2002:a05:6512:291:b0:4fd:f7a8:a9f3 with SMTP id
 j17-20020a056512029100b004fdf7a8a9f3mr845683lfp.38.1693952843686; Tue, 05 Sep
 2023 15:27:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Sep 2023 17:27:23 -0500
MIME-Version: 1.0
In-Reply-To: <20230901055011.GT3465@black.fi.intel.com>
References: <20230831011405.3246849-1-swboyd@chromium.org> <20230831011405.3246849-2-swboyd@chromium.org>
 <20230901055011.GT3465@black.fi.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 5 Sep 2023 17:27:23 -0500
Message-ID: <CAE-0n50XCw7ugkoTAUfb5Jrr6-Vh=bvXfTOSeHV_ymyOQfRB2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/x86: intel_scu_ipc: Check status after
 timeouts in busy_loop()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mika Westerberg (2023-08-31 22:50:11)
> On Wed, Aug 30, 2023 at 06:14:01PM -0700, Stephen Boyd wrote:
> > It's possible for the polling loop in busy_loop() to get scheduled away
> > for a long time.
> >
> >   status = ipc_read_status(scu);
> >   <long time scheduled away>
> >   if (!(status & IPC_STATUS_BUSY))
>
> How can the status bit change here as we are the only user and the SCU
> access is serialized by ipclock?

I don't know how the SCU works. I thought that IPC_STATUS_BUSY bit was
cleared by the SCU when it was done processing. With that assumption, I
tried to show that the status is read and then the process schedules
away for a long time and has an outdated view of the busy bit.
