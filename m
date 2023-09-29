Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA8C7B2B17
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjI2FPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjI2FPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:15:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA51AE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:15:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4053f24c900so35305e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695964541; x=1696569341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efBzdUz4E1mRCTntOxAJpAn2plhV/lB8ZB1zgWlI4Es=;
        b=qFZsdQ2/AJsIWGzh5XHhi3g39MBk/Xnoyz/gYvIk30VzlbI7LT8g1AZBv44DPAGCT6
         wceMos8tzUddDYgpdgBtapeGs6yU+V+MBtQm367Cg7Vw71FQsWpdFQ6chNVmhkjuVuwg
         bp+VWfZBk1pzbKWVvRvzRu2GxK1ltWv9ZoYGhtEvjBSwEjaYa2wcUiH18va7FlPZjFlK
         BTxY+esuFz8Q9Lbg8564RlMbovuXrp/7KRrNpQH4CWBQ9Q2hXtaHpC6ngQOYedBEtbax
         s2/j6Jtaob2BWMjF365ocfscZ8YSDi9g6UYkWlW9LmYaOC+kHIdkKymRQzynGTtEalrt
         byOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695964541; x=1696569341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efBzdUz4E1mRCTntOxAJpAn2plhV/lB8ZB1zgWlI4Es=;
        b=rjlzzZF+ZOuCDBQT8/BsT0v0qZlNM+YxrDkAoqGsqiTAza+u8pLHrNPL8u54nq4WNq
         oltCCit/SBex63ctgWr2NB4PzIIp+zUOLMBQxSHfAc/3gO1QYiTsJ73yQ6EcqU9MmukO
         v5c24/wTW7DYaYgb9KXhyXlzQvPdp6aWaUrAZfBZ6kAuRYKdXpNDnbSy3PWOTvtVhRpV
         8aSrJfkg3qLOnC/+r0HgTzHRyzzm/ZxRKj7lUdk5ojBDwM3ekoNQmyvvEBYgFrGMvWzr
         9vNYGjpN+mkpp14K8A/YpiA6Ioer8gMh9BdKFP2Jwv0WnM++1/R6lkTgw+pv801yKFZ9
         HMEA==
X-Gm-Message-State: AOJu0YxlMVU/KLjAZiLkQ1NI+rX/exzj+vKVjCrO9iV7fy1yzPSOGRxG
        BtHdGDuGywNSrfvUGCbQKXZrlm+37IIfGrFhV5AK
X-Google-Smtp-Source: AGHT+IGGDGKqptEZv/WnwMLswdZ9PPXni90i065Pu7UM1Bhewpjh98RbfvPJk4nt3UhWJdYSpmWImk/dGRj31n/QaT0=
X-Received: by 2002:a7b:c445:0:b0:400:46db:1bf2 with SMTP id
 l5-20020a7bc445000000b0040046db1bf2mr431969wmi.2.1695964540632; Thu, 28 Sep
 2023 22:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230929023737.1610865-1-maheshb@google.com>
In-Reply-To: <20230929023737.1610865-1-maheshb@google.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 28 Sep 2023 22:15:27 -0700
Message-ID: <CANDhNCqb5JzEDOdAnocanR2KFbokrpMOL=iNwY3fTxcn_ftuZQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] time: add ktime_get_cycles64() api
To:     Mahesh Bandewar <maheshb@google.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 7:37=E2=80=AFPM Mahesh Bandewar <maheshb@google.com=
> wrote:
>
> add a method to retrieve raw cycles in the same fashion as there are
> ktime_get_* methods available for supported time-bases. The method
> continues using the 'struct timespec64' since the UAPI uses 'struct
> ptp_clock_time'.
>
> The caller can perform operation equivalent of timespec64_to_ns() to
> retrieve raw-cycles value. The precision loss because of this conversion
> should be none for 64 bit cycle counters and nominal at 96 bit counters
> (considering UAPI of s64 + u32 of 'struct ptp_clock_time).
>
> Signed-off-by: Mahesh Bandewar <maheshb@google.com>
> CC: John Stultz <jstultz@google.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: Richard Cochran <richardcochran@gmail.com>
> CC: netdev@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  include/linux/timekeeping.h |  1 +
>  kernel/time/timekeeping.c   | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> index fe1e467ba046..5537700ad113 100644
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -43,6 +43,7 @@ extern void ktime_get_ts64(struct timespec64 *ts);
>  extern void ktime_get_real_ts64(struct timespec64 *tv);
>  extern void ktime_get_coarse_ts64(struct timespec64 *ts);
>  extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
> +extern void ktime_get_cycles64(struct timespec64 *ts);
>
>  void getboottime64(struct timespec64 *ts);
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 266d02809dbb..35d603d21bd5 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -989,6 +989,30 @@ void ktime_get_ts64(struct timespec64 *ts)
>  }
>  EXPORT_SYMBOL_GPL(ktime_get_ts64);
>
> +/**
> + * ktime_get_cycles64 - get the raw clock cycles in timespec64 format
> + * @ts:                pointer to timespec variable
> + *
> + * This function converts the raw clock cycles into timespce64 format
> + * in the varibale pointed to by @ts
> + */
> +void ktime_get_cycles64(struct timespec64 *ts)
> +{
> +       struct timekeeper *tk =3D &tk_core.timekeeper;
> +       unsigned int seq;
> +       u64 now;
> +
> +       WARN_ON_ONCE(timekeeping_suspended);
> +
> +       do {
> +               seq =3D read_seqcount_begin(&tk_core.seq);
> +               now =3D tk_clock_read(&tk->tkr_mono);
> +       } while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +       *ts =3D ns_to_timespec64(now);
> +}

Hey Mahesh,
  Thanks for sending this out.  Unfortunately, I'm a bit confused by
this. It might be helpful to further explain what this would be used
for in more detail?

Some aspects that are particularly unclear:
1) You seem to be trying to stuff cycle values into a timespec64,
which is not very intuitive (and a type error of sorts). It's not
clear /why/ that type is useful.

2) Depending on your clocksource, this would have very strange
wrapping behavior, so I'm not sure it is generally safe to use.

3) Nit: The interface is called ktime_get_cycles64 (timespec64
returning interfaces usually are postfixed with ts64).

I guess could you clarify why you need this instead of using
CLOCK_MONOTONIC_RAW which tries to abstract raw cycles in a way that
is safe and avoids wrapping across various clocksources?

thanks
-john
