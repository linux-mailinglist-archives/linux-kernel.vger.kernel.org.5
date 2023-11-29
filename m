Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8187FE0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjK2T7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjK2T7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:59:41 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D558A122
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:59:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cf856663a4so1465165ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701287987; x=1701892787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9KBIL6f5kNv/xXZoYHWBpIguDveUMS5hNXgYFdJUhQc=;
        b=EBEv+a/PYlDTqNfc6r2c3LOuZtUBgpqxB4JCeJzyyXvBL4W5pniFZZiKVGqlHT/ct6
         Tq5OSElkdSuo459nIO8SRYpbwiHryQmS6C1jpdVIDaKExERp1GHksy4f62GZh/NStWbI
         aiembdtvshbDWA3YpCxZk9AjdgdclL2WIjE3hcHYyF/OLYFRd6GnXIwpVtaeng8gGXRB
         nq0OcbRrcfcard5E8zsi1VUJp5uCJYsT6BQ967GVCEg1/et+hGnjxmNcTnD9T+07+qON
         b4Rfkl613AFTDT0vqT1iTUGiG44vVqMDhOQcUfb5uFp7/hyOmedxwVHoy/MXE7PchRLS
         BKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701287987; x=1701892787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KBIL6f5kNv/xXZoYHWBpIguDveUMS5hNXgYFdJUhQc=;
        b=AdBC9hNWaD6w7GJjhlh22RvbHMdRiV0t3r96UK72ZmQGCWFrXG2QRPeGAyNNZQ1YVO
         s+bdWKFIKuCNgY8ldeyXstuXWG4UlXy7IDgo4LKYmhtw1GiNTU6p+4yuVbyfwB0wopW3
         aX8TFhTTCAm/b48aAhkAdNfFNeHzo0kAIVptgRzqDu6gFT343soYGSBbky2Mhy0uzzcr
         JatkNglJLJVWYvT/Z4GujarF+qWvnPpdVa/mKyWewbTLn72h9M32CQ1cFgFOhid1N5k7
         fvpyKcmAZncN0v5j3PdU84zkFj9wntQeCQLSP9yNzFEAgk/RP/turucG+mTOddSmQhu9
         iyMw==
X-Gm-Message-State: AOJu0YzQZkJ9pio3U8Ef0SXt2VDDqTk5q+C/qOS5Cnp69fCXxFFjjC1H
        rvX0vPY+rErBvrZyc8mkAQQ=
X-Google-Smtp-Source: AGHT+IEdNo5LqpB0bb1334o7oTEs0OeBc4qwKwlFK9uWu+5Bhszjux18KE5478LxwRHq4PYKwAT9kw==
X-Received: by 2002:a17:902:d48d:b0:1cf:c4d3:f337 with SMTP id c13-20020a170902d48d00b001cfc4d3f337mr11645388plg.30.1701287987027;
        Wed, 29 Nov 2023 11:59:47 -0800 (PST)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001bd28b9c3ddsm12659734plf.299.2023.11.29.11.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:59:46 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:57:30 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH v2 0/4] genirq/irq_sim: misc updates
Message-ID: <ZWeXqtqJLKB02LWU@yury-ThinkPad>
References: <20231115165915.2936349-1-brgl@bgdev.pl>
 <CAMRc=MfoE93Aum4s-pweeb_idqYgUG-DBpXnhT5UW_WhVkLwHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfoE93Aum4s-pweeb_idqYgUG-DBpXnhT5UW_WhVkLwHw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:18:15AM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 15, 2023 at 5:59 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Here are a couple of updates to the interrupt simulator. Two are minor:
> > remove an unused field and reorder includes for readability. The third
> > one simplifies the error paths by using new cleanup macros. To that end
> > we also add a cleanup definition for dynamic bitmaps.
> >
> > Resending rebased on top of v6.7-rc1 and with tags collected.
> >
> > v1 -> v2:
> > - add a NULL-pointer check to the bitmap cleanup macro as advised by
> >   Peter Zijlstra
> > - initialize managed pointers when declaring them to create a clear pairing
> >   between the type and the cleanup action
> >
> > Bartosz Golaszewski (4):
> >   bitmap: define a cleanup function for bitmaps
> >   genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
> >   genirq/irq_sim: order headers alphabetically
> >   genirq/irq_sim: shrink code by using cleanup helpers
> >
> >  include/linux/bitmap.h |  3 +++
> >  kernel/irq/irq_sim.c   | 30 ++++++++++++------------------
> >  2 files changed, 15 insertions(+), 18 deletions(-)
> >
> > --
> > 2.40.1
> >
> 
> It's been two weeks since this submission and ~2.5 months since the
> first one so I guess, a gentle ping is in order. This is not a very
> controversial series - can this be applied?

Hi Bartosz,

I'm the first in the list for this series, but really only 1st patch
is related to bitmaps, and I already acked it. If you prefer that, I
can pull it in the bitmap tree.

Thanks,
Yury
