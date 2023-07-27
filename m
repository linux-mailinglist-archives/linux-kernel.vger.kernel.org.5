Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BF97652F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjG0L4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjG0L4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:56:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F0E272A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:56:30 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so9406835e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1690458989; x=1691063789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3EoIFwrq8xE+g8LOEHaQ4hPaKZ9Ot0ZPDi6PUTd3Sv4=;
        b=Z28AAFlS8OIFY+u+RQ87t144Dmsg/4dZ6S1LiQw92Lb8suCDlCNDRGl0v38lbRFI3E
         PVwUc1Hd/m/7H/+Tx6uldH7Mk9w9F1iASmtHzFf6QxwK7Ka35QSxXjyY2XXhx9WkqRsA
         H0tj8z9J4zJNrqq0dBu6DNfZHqysDCEwfF6q/s8MvzdkWwdScllP2/GCHvIDuGHyUyvq
         RmKZIikB+dthdNYeiYTpGQfuGOru3i4iqB9AuJ9+e6Wwf+9C9Wf4Rz0/buH9b54FDm6z
         AHurOCvdZHlXOFy+yHrS1t/ZOyC8xAL7lhfUuKe7jyufzRbd+xV+DIiu93o+R6Ac4SOv
         bLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458989; x=1691063789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EoIFwrq8xE+g8LOEHaQ4hPaKZ9Ot0ZPDi6PUTd3Sv4=;
        b=Jkx3DI6PKintxey4GoKYexfThYmnqItKALo4+VDuXI3cw/if8RbdeCWDpqht7w9ZrZ
         QBYCgcWiqNb3fB4KN59FKb0bUYGDLVQ8u/Oxx71N8rWblzQ13Y5P5291vIpIUVRMXm4h
         LnSb8gYW3wpQC0j6/VLU/wPW1SO1pXsox7eM5feDQ/ZTmT7NhKyohcblzcb5PlsSmlNf
         KPgmIy+aAVvheH85ESFRhBYSf5/ATgOSTD2utNnLCywlW3mI2ban35OY8BYk/04s8nbv
         +ZPt/a9PFWKI/QHJQEHm8K5MqtFfwb1vclx+ZJSUCAOj9zddP/ofCVT/PvrofCxvyipd
         GkCg==
X-Gm-Message-State: ABy/qLbW6uUfhfe48SjJUyrKkoXuOqygiu4c9oRJFoeOCS5qReYEjw+T
        hmET90BPklGpIChbak0PXQAlD9zquL7Ult9DLEU=
X-Google-Smtp-Source: APBJJlHbBajALsM0e61lc3Pg50Bo+OmU2y5ufWA6Xu3A1/makfSZgFsCmkjg2vqsAjFQlz7V8khK+A==
X-Received: by 2002:adf:fd0f:0:b0:317:734e:3614 with SMTP id e15-20020adffd0f000000b00317734e3614mr1766236wrr.39.1690458989124;
        Thu, 27 Jul 2023 04:56:29 -0700 (PDT)
Received: from airbuntu ([104.132.45.109])
        by smtp.gmail.com with ESMTPSA id l18-20020adfe9d2000000b003112f836d4esm1832459wrn.85.2023.07.27.04.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 04:56:28 -0700 (PDT)
Date:   Thu, 27 Jul 2023 12:56:26 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: remove util_est boosting
Message-ID: <20230727115626.kmln3cnka3ddpgpp@airbuntu>
References: <20230706135144.324311-1-vincent.guittot@linaro.org>
 <20230711154718.gudn32sru5opwvlw@airbuntu>
 <CAKfTPtC2NyZcVukzsYAEdhyxv__AURVuJ1JUoh8NGBmq0mL1hQ@mail.gmail.com>
 <39d63092-0e1d-2a0b-37e4-eea6789f8055@arm.com>
 <CAKfTPtB5VCLcKpmFpdq5Yq4ypAyoiv04t=ab6f2RnGodhNp5kA@mail.gmail.com>
 <cb0ddea0-2c85-f0ec-f726-14a29cf51fad@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb0ddea0-2c85-f0ec-f726-14a29cf51fad@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/23 23:11, Dietmar Eggemann wrote:

> Reran the Jankbench test with the patch (fix) on exactly the same
> platform (Pixel6, Android 12) I used for v3 (base, runnable):
> 
> https://lkml.kernel.org/r/20230515115735.296329-1-dietmar.eggemann@arm.com
> 
> Max_frame_duration:
> +-----------------+------------+
> |     kernel      | value [ms] |
> +-----------------+------------+
> |      base       |   163.1    |
> |    runnable     |   162.0    |
> |       fix       |   157.1    |
> +-----------------+------------+
> 
> Mean_frame_duration:
> +-----------------+------------+----------+
> |     kernel      | value [ms] | diff [%] |
> +-----------------+------------+----------+
> |      base       |    18.0    |    0.0   |
> |    runnable     |    12.7    |  -29.43  |
> |       fix       |    13.0    |  -27.78  |
> +-----------------+------------+----------+
> 
> Jank percentage (Jank deadline 16ms):
> +-----------------+------------+----------+
> |     kernel      | value [%]  | diff [%] |
> +-----------------+------------+----------+
> |      base       |     3.6    |    0.0   |
> |    runnable     |     1.0    |  -68.86  |
> |       fix       |     1.0    |  -68.86  |
> +-----------------+------------+----------+
> 
> Power usage [mW] (total - all CPUs):
> +-----------------+------------+----------+
> |     kernel      | value [mW] | diff [%] |
> +-----------------+------------+----------+
> |      base       |    129.5   |    0.0   |
> |    runnable     |    134.3   |   3.71   |
> |       fix       |    129.9   |   0.31   |
> +-----------------+------------+----------+
> 
> Test results look good to me.
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks for re-running the test!


Cheers

--
Qais Yousef
