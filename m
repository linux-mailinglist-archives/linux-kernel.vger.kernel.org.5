Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218197E7FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjKJR6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjKJR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:16 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2362142C04
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:58:36 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b2f507c03cso1191787b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699635515; x=1700240315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OPyzMEiq0OMJGTTMaw3BonYyWiqjoS8aDWEJ5pjLZhk=;
        b=mYsFxk0JZUcfN6yOJ/90lyUslR0iNdDLtJMVMz23SQuI6LMfu3BLdVyGbb5KcEFROd
         ieIMuuPU3sy5j0O83AklSR1NFAaymjou+qLTqZt6EupJ8e2Y75KwWnZTzHwWkKy0da/D
         XfmF/XgIvk+Hh85WnKg5wXeeQ3yx0Jy0FKt3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699635515; x=1700240315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPyzMEiq0OMJGTTMaw3BonYyWiqjoS8aDWEJ5pjLZhk=;
        b=BVQuzOZUCFcOVSf7/gmnsz9rqdumylJOJfDyNHpzkiQzY04e7x0e2AuFh+18/Hn+xM
         W+G8ZSTB2YdmdKIVCjwoq6IaNn8jcUlduBE6AxDEbzU+WNSPNsubnwzqr3cFMpv8z7FH
         AYLNuKWYCfFEMp5WQ+poNjrAROuddR4hNSrBTr5H3xBxG3lMLuFuFz8/tI1+o1lTd/r+
         w+7K3TPmaf525JFozgbmvhXAmm2A8ZahM39gUcqj2vnM1vwNsRLeHBWcY8Ea+JZI4Baj
         xpFU09OepDaoLdqAIze7qM1CfM7aLgkPZFsvFLcBSLn+zqz7BPrIMQOUsrK5WRlMNvSc
         Fucg==
X-Gm-Message-State: AOJu0Yy52M1kZ/1IeqEUj06Ad2ae5mUjkfP2gh6HWMXFodUW5nHfXRHt
        i2dVXRuVugCOC7+gLSmSuWRTkxjfdJH243NNsW38PA==
X-Google-Smtp-Source: AGHT+IHiCqr12OtjoFNzFwzdT0LpIrrrIR3C93lqXaIs3Tm02E7BpbEfMfc8XDLvGEfKj3czVReou6/cz9WI7bTZKO8=
X-Received: by 2002:a54:4407:0:b0:3b2:e9ab:68e2 with SMTP id
 k7-20020a544407000000b003b2e9ab68e2mr4992086oiw.7.1699635514959; Fri, 10 Nov
 2023 08:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20231109111934.4172565-1-korneld@chromium.org>
 <CAG-rBijqw2VO8AQbwBh5Cu47gBbDsOGwPgw-8hSXMWCHXi6GLw@mail.gmail.com> <ZU3pTY0qbA6cDB7f@google.com>
In-Reply-To: <ZU3pTY0qbA6cDB7f@google.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Fri, 10 Nov 2023 11:58:24 -0500
Message-ID: <CAG-rBiiXPzcMndhvT=vV7W--6i0O+26hgMcHL3wbCyKrnw6LsQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable LPM during initialization
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jason Lai <jasonlai.genesyslogic@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's something happening in this driver that doesn't
make much sense to me.

According to the pm runtime docs [1] the initial runtime pm
status of all devices is 'suspended'. Which I presume, means:
if the driver doesn't use any of the pm_runtime_*() functions
to tell the core "actually, I am active after probe", then the
device remains suspended until explicitly going active, at which
point the runtime_resume() callback is invoked.

That's the theory. In practice, what do I see on a device
containing this bridge?
Intel SoC <-> PCIe bus <-> gl9763e bridge <-> eMMC bus <-> eMMC drive

at probe() (does not exist in this driver so I stubbed it):
[ 0.601542] runtime pm is enabled = 1 (disable_depth == 0)
[ 0.601552] runtime pm is active = 2 (usage_count)

at probe_slot():
[ 0.602024] runtime pm is enabled = 1
[ 0.602027] runtime pm is active = 2

At add_host():
[ 0.602804] runtime pm is enabled = 1
[ 0.602809] runtime pm is active = 3

It looks like:
- nowhere does the gl9763e driver inform runtime pm it's active
- the device is active in probe(), probe_slot() and add_host()
- the runtime_resume() callback did not get called before
probe(), probe_slot(), or add_host().

Why is the runtime_resume() callback not invoked?
Does the driver have a runtime_pm misconfiguration issue here?

Perhaps Rafael could clarify?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/power/runtime_pm.rst?h=v6.6.1#n563
