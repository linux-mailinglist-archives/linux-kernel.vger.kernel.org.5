Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C47600E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGXVMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGXVL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:11:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AA81728
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:11:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso46519155e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1690233112; x=1690837912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AfI+/dZwyRnvbW784WzVt/J0ZXX0rf4WHiQ8aRnKx+U=;
        b=xEHJfJOyhIwBYYbLv/SnAm/xRJKVyLXIm+j3HIQT+6uxTnGvwrV8/X5LUH+3l5jsy4
         nPjqeU04jiRIa8nf49/ife59D60MedKDxxAPD++Rfo/1Wj1J3qFF5X0TX3wAk505Yhkj
         KdWjwpx9Q69WxtRQeMhrDIatgblhmORAZpqir8gsOlQW1XQJs/9ZS5pd2IlBKcy85QRQ
         HZNVgXKWVWocNC+n3nuUe/UiP5/rh1tdlX9WmDVzbWqi68ana1pKkbZDWQC5p1DgXtQp
         53RFv2f+OY7mRYfA3hdUOrrQb2QT6fazS5sXHlcpVVyJrxRnOHguQhZEQ4JckPUyaEDO
         OEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690233112; x=1690837912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfI+/dZwyRnvbW784WzVt/J0ZXX0rf4WHiQ8aRnKx+U=;
        b=VGAoDS/Q27l4AgH3JFSSMhaKV8tXNd7UEk6hHJM73a1BrqGnCdr4hFy63Y+V/TFGjU
         6Q+tYWNYANNO6uzOwUsbIFJhyU8A1RsSunnAEkwyRMVD9V9ivibi1k3J1A1PO5SWDOLu
         mZftB5zdaf0NgIXKtT4+YHkiBPKClpNGvJxtNvTof7YPvrAdwxk2FCw5yn2bdtcKO++G
         Cgg1v1AR/Rn9cxhM+OUWUelQV/E9cdiuBKQ2UQ5rIh4q/xI2dzOP7ZZL76VjPgN/ozbJ
         aWeoq1Z5oWfV02nt5nQYNeP4MilIKHhf87Gujniwxkvy+EhQIyZkn/8WD1U5I4K2B5+M
         M4RA==
X-Gm-Message-State: ABy/qLbJjPvguemJzwhv2MU6z8VE04OaC9YTbHkqXo3DZTk5qLrebsTr
        1wn6NXaLd/LrJBPug1D4w8fYiw==
X-Google-Smtp-Source: APBJJlEgR13CuDz/QEAo901b56xQE2uYVjEcH2xgE3Gk2y6NKe1UQS3MT6zglT5rRUb+aqSNShWHkw==
X-Received: by 2002:a05:600c:c8:b0:3fa:e92e:7a7b with SMTP id u8-20020a05600c00c800b003fae92e7a7bmr9661523wmm.15.1690233112147;
        Mon, 24 Jul 2023 14:11:52 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b003f7f475c3bcsm632733wmb.1.2023.07.24.14.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:11:51 -0700 (PDT)
Date:   Mon, 24 Jul 2023 22:11:50 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in
 load balance
Message-ID: <20230724211150.lc5dlxlbewxwr5rb@airbuntu>
References: <20230718161829.ws3vn3ufnod6kpxh@airbuntu>
 <CAKfTPtA55NemHq0tZPuiEN=c3DRZWD-7jf7ZrKdHE9y9b_szZg@mail.gmail.com>
 <20230718172522.s4gcfx3ppljwbks7@airbuntu>
 <CAKfTPtA6s82qXWOSdd6eNu__z_HZe9U_F0+RcBJj=PVKT7go7A@mail.gmail.com>
 <20230721105711.nzunqdtdaevmrgyg@airbuntu>
 <ZLqNmpQdiTC2fio5@vingu-book>
 <20230721220430.qv6eqo4dosfrsilo@airbuntu>
 <c31e5667-19b1-33a4-d1f1-a88907e239d3@arm.com>
 <20230724161038.nreywdwayiq2ypty@airbuntu>
 <1e675286-b4b8-5abd-dd4c-3f2ffdaf12c1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e675286-b4b8-5abd-dd4c-3f2ffdaf12c1@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/23 19:54, Dietmar Eggemann wrote:
> On 24/07/2023 18:10, Qais Yousef wrote:
> > On 07/24/23 14:58, Dietmar Eggemann wrote:
> >> On 22/07/2023 00:04, Qais Yousef wrote:
> >>> On 07/21/23 15:52, Vincent Guittot wrote:
> >>>> Le vendredi 21 juil. 2023 à 11:57:11 (+0100), Qais Yousef a écrit :
> >>>>> On 07/20/23 14:31, Vincent Guittot wrote:
> 
> [...]
> 
> > So I actually moved everything to a single cluster and this indeed solves the
> > lb() issue. But then when I tried to look at DT mainline I saw that the DTs
> > still define separate cluster for each uArch, and this got me confused whether
> > I did the right thing or not. And made me wonder whether the fix is to change
> > DT or port Sudeep's/Ionela's patch?
> 
> IMHO, you have to change DT.
> 
> > I did some digging and I think the DT, like the ones in mainline by the look of
> > it, stayed the way it was historically defined.
> 
> This would be a "mistake" for Arm DynamIQ based systems. We use QC RB5
> in our testing and this board schedules only within a MC sched domain (I
> guess it's: arch/arm64/boot/dts/qcom/qrb5165-rb5.dts -> sm8250.dtsi)

I did find some qcom platforms that define a single cluster after I sent my
email. Not sure if the ones I've looked at were having wrong definitions or
not.

Anyway, hope this discussion will enlighten others too ;-)


Cheers

--
Qais Yousef
