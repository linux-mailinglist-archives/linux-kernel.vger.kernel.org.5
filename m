Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5837914D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245488AbjIDJev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjIDJeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:34:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F339DD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:34:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so1517211a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 02:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693820083; x=1694424883; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T4VZstNDexYspt5bnA8VRpCNwoCeT6mBX258YaBCK68=;
        b=eLwaHo6xC2KK/LYcggRdxgrLelJ1Q6tmxLAPifSkq1IeE+U1dt9q2M7zw+psHxqtx+
         e5kBIkwa/h3693RL0luZzHMZxKoZdQYUxFq8YiYEpRhbfxPwB67T8ksv1xxsQUP2FMPE
         qwzIjPMOpq0N1VXEGqhXG8LqmOlsyG6pLm7LIcOAkJCUxm48XG1PNaRv3K5Bo4fR7HNn
         l5X/3Ol+jBUV22zNQuKflqHQnGNJzwALoYMqgF9erJmVgxjmYx5pwbNJCcRmwBu0RKyA
         ck2eTd2uiqdVCjiTL6nF3237/MyBJ+1fANKTENu5aNxYSV2FYq+lZYGQb+6hSk9lKCIg
         tEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693820083; x=1694424883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4VZstNDexYspt5bnA8VRpCNwoCeT6mBX258YaBCK68=;
        b=gQFtnKjmvO7FcIPluu346hb/Y9iBOouYdpSsNpv16gQJWpL6G+T1t4a2vjuF9U7fLQ
         oU/OCpIOfe0jMsUyMbJ3ujmDukWmLCBN4pJhskcIiDejbqMgNy+TVx6wLSehe1x2qppB
         yLNfWMKelE7EXcmpSLBQNfLkYvWq8Y3bglfnkSVw7gfWqtV2t3erhzBQv5dg/I6le5on
         F2D/0FqtDcech8FGcRUaT6A2Nmgz5cmrM+zzt6jVuZEn794Jou3YFB4TVuNsASJBTq1i
         D35tfQF4koKsPthYLCxVWfKUdKoPaNanurAIgXqdeCLNOI0VX1K5iyvgTb6dc5ARiJlD
         HHkg==
X-Gm-Message-State: AOJu0YxmIgUBTyIGgbwzUazV29Mvj7VixnZPRH2kJwNXvzhzwaPQaSOg
        irFHdrA0d0La6M1ZACyvlTICpw==
X-Google-Smtp-Source: AGHT+IFwo5SBQC7kCzaUBXWFt09wwIK7lljg5WDdeP5eo0N1dPWYn+VMAcp5e/Ia/8cWHU9hUh8fPw==
X-Received: by 2002:a17:906:3054:b0:9a1:ad87:1354 with SMTP id d20-20020a170906305400b009a1ad871354mr6827041ejd.34.1693820083487;
        Mon, 04 Sep 2023 02:34:43 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:8020:2b3e:29eb:352d:d92e])
        by smtp.gmail.com with ESMTPSA id fx4-20020a170906b74400b009887f4e0291sm5867179ejb.27.2023.09.04.02.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 02:34:43 -0700 (PDT)
Date:   Mon, 4 Sep 2023 11:34:42 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH v5 00/12] can: m_can: Optimizations for m_can/tcan part 2
Message-ID: <20230904093442.cu6d5b6gm5ngfli6@blmsp>
References: <20230718075708.958094-1-msp@baylibre.com>
 <108a41e492dcfa4a7c59e44aac7dfb502e595962.camel@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <108a41e492dcfa4a7c59e44aac7dfb502e595962.camel@geanix.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 08:51:48AM +0200, Martin Hundebøll wrote:
> On Tue, 2023-07-18 at 09:56 +0200, Markus Schneider-Pargmann wrote:
> > Hi Marc, Simon and everyone,
> > 
> > v5 got a rebase on v6.5 with some small style fixes as pointed out in
> > v4.
> > 
> > It is tested on tcan455x but I don't have hardware with mcan on the
> > SoC
> > myself so any testing is appreciated.
> > 
> > The series implements many small and bigger throughput improvements
> > and
> > adds rx/tx coalescing at the end.
> > 
> > Based on v6.5-rc1. Also available at
> > https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.5?ref_type=heads
> 
> For the whole series:
> Tested-by: Martin Hundebøll <martin@geanix.com>

Thank you Martin!

Best,
Markus

> 
> Thanks,
> Martin
> 
> > Changes in v5:
> > - Add back parenthesis in m_can_set_coalesce(). This will make
> >   checkpatch unhappy but gcc happy.
> > - Remove unused fifo_header variable in m_can_tx_handler().
> > - Rebased to v6.5-rc1
> > 
> > Changes in v4:
> > - Create and use struct m_can_fifo_element in m_can_tx_handler
> > - Fix memcpy_and_pad to copy the full buffer
> > - Fixed a few checkpatch warnings
> > - Change putidx to be unsigned
> > - Print hard_xmit error only once when TX FIFO is full
> > 
> > Changes in v3:
> > - Remove parenthesis in error messages
> > - Use memcpy_and_pad for buffer copy in 'can: m_can: Write transmit
> >   header and data in one transaction'.
> > - Replace spin_lock with spin_lock_irqsave. I got a report of a
> >   interrupt that was calling start_xmit just after the netqueue was
> >   woken up before the locked region was exited. spin_lock_irqsave
> > should
> >   fix this. I attached the full stack at the end of the mail if
> > someone
> >   wants to know.
> > - Rebased to v6.3-rc1.
> > - Removed tcan4x5x patches from this series.
> > 
> > Changes in v2:
> > - Rebased on v6.2-rc5
> > - Fixed missing/broken accounting for non peripheral m_can devices.
> > 
> > previous versions:
> > v1 -
> > https://lore.kernel.org/lkml/20221221152537.751564-1-msp@baylibre.com
> > v2 -
> > https://lore.kernel.org/lkml/20230125195059.630377-1-msp@baylibre.com
> > v3 -
> > https://lore.kernel.org/lkml/20230315110546.2518305-1-msp@baylibre.com/
> > v4 -
> > https://lore.kernel.org/lkml/20230621092350.3130866-1-msp@baylibre.com/
> > 
> > Markus Schneider-Pargmann (12):
> >   can: m_can: Write transmit header and data in one transaction
> >   can: m_can: Implement receive coalescing
> >   can: m_can: Implement transmit coalescing
> >   can: m_can: Add rx coalescing ethtool support
> >   can: m_can: Add tx coalescing ethtool support
> >   can: m_can: Use u32 for putidx
> >   can: m_can: Cache tx putidx
> >   can: m_can: Use the workqueue as queue
> >   can: m_can: Introduce a tx_fifo_in_flight counter
> >   can: m_can: Use tx_fifo_in_flight for netif_queue control
> >   can: m_can: Implement BQL
> >   can: m_can: Implement transmit submission coalescing
> > 
> >  drivers/net/can/m_can/m_can.c | 517 +++++++++++++++++++++++++-------
> > --
> >  drivers/net/can/m_can/m_can.h |  35 ++-
> >  2 files changed, 418 insertions(+), 134 deletions(-)
> > 
> > 
> > base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> 
