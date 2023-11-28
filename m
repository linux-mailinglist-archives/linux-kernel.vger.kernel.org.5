Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5889D7FAFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjK1BkE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 20:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjK1BkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:40:02 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2907BD;
        Mon, 27 Nov 2023 17:40:08 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1fa37df6da8so1186082fac.2;
        Mon, 27 Nov 2023 17:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701135608; x=1701740408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KMijVoZzKjmnAsmxupu7gb2DhrWpe//b9T4lGH4FwY=;
        b=jExPtyAWDITjC35tZOtKw0MnzoBfV4eroRXZYXcJVnBUOvUjeR/UEdCI7jjxj7ViWZ
         KZOmEK2nS0RwzyH45TYzB/BYQv7mJQd+XUV8QyEHx9qfrRsXPb05rD/7NbD5dKZDJNP9
         pm0rDB+g296vpV/LkjoiGL77cEPmxVMuBCmv3eZOGcy8qfIFbHXbwp0u+7yKla4ZQrY8
         bbkNXdw273rL+Ynie7JwpqDMRwLDiJdDhROXfQ8iE92sHQTq825uML3W4kIKQsx1YgHr
         v8mrwL6oCSv0NwVrMg2iY/t4qFqQslmDljGYYXClk6TttpNQjuxbgkLWEzdbs5bhf+uU
         0VFw==
X-Gm-Message-State: AOJu0Yx8cAsGw7Y7aIhNDKJc9w1VXyl+370TK8UrYsQhJGIBJIk2bUoD
        yJ0Amj6RVh3eR4dZELabPm/dWYQyi+zE+RRrDuOaOnpftPE=
X-Google-Smtp-Source: AGHT+IF2SsjExQsB/NHhZaU7EPVIoJQYuKioTorE0GXNez6nQUnzk/cFrZt3ZhgCVyn3kk8ec2GS517W3vmuiKfFEqU=
X-Received: by 2002:a05:6870:5a8b:b0:1f0:8122:554c with SMTP id
 dt11-20020a0568705a8b00b001f08122554cmr13274814oab.45.1701135608186; Mon, 27
 Nov 2023 17:40:08 -0800 (PST)
MIME-Version: 1.0
References: <TYCP286MB214616F6AE3E088C5D781A2EC6C8A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB21465F970BF56AAE5D0CEB72C6A1A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
 <002801da0da1$adb83fc0$0928bf40$@telus.net>
In-Reply-To: <002801da0da1$adb83fc0$0928bf40$@telus.net>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 27 Nov 2023 20:39:57 -0500
Message-ID: <CAJvTdKmJRsWzr8MSZdUv+1AA8AXBAoMF_CaNDAJE5EgThP5+EA@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Fix Bzy_MHz calculation equation
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Peng Liu <pngliu@hotmail.com>, Wyes Karny <wyes.karny@amd.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        liupeng17@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peng Liu,
Thanks for the close read of the documentation, and the patch.
I've applied it, though I re-wrote the commit message (below) to make
it clear it is a documentation fix, as the code was already correct.

thanks,
-Len

ps. I would have replied to your original e-mail, but there was a
period where gmail dropped mail due to space limitations.
No worries, as Doug said, everything is in patchwork.


    tools/power turbostat: Fix Bzy_MHz documentation typo

    The code calculates Bzy_MHz by multiplying TSC_delta *
APERF_delta/MPERF_delta
    The man page erroneously showed that TSC_delta was divided.

On Thu, Nov 2, 2023 at 11:31 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Peng and Wyes,
>
> Just for your information about your recent "ping"s about your turbostat patches:
>
> Please be aware that there is rarely any reply. There tends to be about 2 turbostat updates released per year. Your patches are in patchworks [1], as are some others, including an old one of mine from 2023.04.03
> Eventually there will be an update, and hopefully it will include all our patches.
>
> [1] https://patchwork.kernel.org/project/linux-pm/list/?series=&submitter=&state=&q=&archive=&delegate=107
>
> ... Doug
>
> On 2023.10.29 08:12 Peng Liu wrote:
>
> > Ping
> >
> > On 2023/10/7 13:46, Peng Liu wrote:
> >> From: Peng Liu <liupeng17@lenovo.com>
> >>
> >> To calculate Bzy_MHz, TSC_delta should multiply APERF_delta instead
> >> of dividing it.
> >>
> >> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> >> ---
> >>   tools/power/x86/turbostat/turbostat.8 | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
> >> index 8f08c3fd498d..1ba6340d3b3d 100644
> >> --- a/tools/power/x86/turbostat/turbostat.8
> >> +++ b/tools/power/x86/turbostat/turbostat.8
> >> @@ -370,7 +370,7 @@ below the processor's base frequency.
> >>
> >>   Busy% = MPERF_delta/TSC_delta
> >>
> >> -Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
> >> +Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
> >>
> >>   Note that these calculations depend on TSC_delta, so they
> >>   are not reliable during intervals when TSC_MHz is not running at the base frequency.
>


-- 
Len Brown, Intel
