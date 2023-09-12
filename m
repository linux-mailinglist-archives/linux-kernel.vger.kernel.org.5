Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC6A79D27B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbjILNgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbjILNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:36:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A56910CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:36:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fb85afef4so2066827b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694525772; x=1695130572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yvr8K257rhZHgB+Or9xKD4QmPnZiNLnEewskHFWmNY0=;
        b=dX2DJNNe+42y2NoOKbpcuxPfnrDhwqmVwc1S0L96jojhtesovhkLevfwdkBDFFD5RZ
         aOtfPJVJHCTlTnmDg2n+G3ngcQTDpsyr67HfwTVmtSdWGpX89z97akujEDzUeoswp0hN
         aH8VDPJvbUn9RHHnGRv3Ffi1B1/IMAyUMrsPQtk5/u26Ia/LC7WTl053LRW5BQTfXfB2
         Cy52G8tVC1fczZV3FwHAEUzYztq4CIlE8qntWpNTOWo1C3pDQsw7HiqAj5dD6kqVkUya
         1qvx62JPeW/9tImH4P98NFWXy7EUWJtaBGqUmTNtAwSkcTumjP/0gAQBI7qywWTRtyep
         d/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525772; x=1695130572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvr8K257rhZHgB+Or9xKD4QmPnZiNLnEewskHFWmNY0=;
        b=gxQEjvwvtmNrk39XbZMg6V24qFC2SOdeCU7BNg79kPH6Dj4D/l2PyrTHTIQIH6XeXB
         mDjLCf/gO4xmM3dEY94KlIXbX1AxTW9AVKs/dNcz3IajvUMTENJ2V5iGForNsvghA3dJ
         jRxXwumlOdhp+5MPrv8cZ3d24fcVBR2rTT6r186i/PBR3abk21gxkc9D70Np2UYEAFI5
         uUxBiQHRfriGryZ4k5WIvZYZ1YK86HVMbEaBed/lm4xZiwHdYGtPdEfsA/bX6rgBn4Bm
         BjT1W3dXo+fQJ3qyrIsAG7n2RxqRuGzBlV2fCmzV5Uc18N5DYJprqF29/rmltYy330qn
         S0wg==
X-Gm-Message-State: AOJu0YxOvgp56X2mhEfojZ3gszWW+TgVZzD4kM18HSGtHM3BzfBGVDcn
        FHKuQvzAPAdmpRWa5QF1SHgKiTWze14=
X-Google-Smtp-Source: AGHT+IE+DNrLg/8lk5HfjUFhh0esngc37jWI5Yv4T3N6rb5I5K2y4IXp3aJa9y+q5C3OCuRBjwwwgA==
X-Received: by 2002:a05:6a20:918b:b0:134:2b31:e2a9 with SMTP id v11-20020a056a20918b00b001342b31e2a9mr13742753pzd.0.1694525771729;
        Tue, 12 Sep 2023 06:36:11 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id j13-20020aa78d0d000000b0068bff979c33sm7316468pfe.188.2023.09.12.06.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:36:10 -0700 (PDT)
Date:   Tue, 12 Sep 2023 06:36:08 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/4] genirq/irq_sim: misc updates
Message-ID: <ZQBpSCx9D6ktkoIk@yury-ThinkPad>
References: <20230912085541.13682-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912085541.13682-1-brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:55:37AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Here are a couple of updates to the interrupt simulator. Two are minor:
> remove an unused field and reorder includes for readability. The third
> one simplifies the error paths by using new cleanup macros. To that end
> we also add a cleanup definition for dynamic bitmaps.

This looks like a v2 for https://lore.kernel.org/lkml/20230812194457.6432-1-brgl@bgdev.pl/
Is it right? If so, can you keep history of submissions in the cover
email please?
