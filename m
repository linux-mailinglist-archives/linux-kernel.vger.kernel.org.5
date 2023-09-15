Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DBB7A1D69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjIOL0d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 07:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjIOL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:26:32 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CA2189
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:26:27 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59c0a7d54bdso7286117b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694777187; x=1695381987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHXoo1uHNyxMm9bc7Yn/sSt49d2FNL34IW6B9JlvsPc=;
        b=uAMwewcl/phOx5iIAsJD8E4wGI0Zzx4X/vCF/cOtIIOXCgAylpWKXthDesHivFfFP0
         1QzOeXa3oir/Pb0+dViIqvStReu8zpAXzEjYUtMn8/tYghHpwTTIsrltR1z5DXUbioFd
         IpYL18exZrp1D6mpuAJkOHbmfJe06I+PqgWQ+U75Dcipd/ND4Ude19IMfEef6WD9hYDu
         Qd7f8uGzI28/P7E343bmK/qMHTEZqgv3diFZ6EStnbhHNqcONWvkja2amzOF+t+G+z0Z
         eBLUtJgJJ9AOGwRJb9xZc+T6T3zPbW139ESX8M9iMoaLIO6wvefedZD1O3mxOUOJIsCj
         VycQ==
X-Gm-Message-State: AOJu0YxyoLJjDKAaSTAAYgYmCE84A/rmuOszbUSR5NVqoOmlHTJi+Z8O
        iHSc90jzfo6eIL1bjrE0vIie68Ten4Z2bw==
X-Google-Smtp-Source: AGHT+IGNVGL1fSqkquZFcFag808EslAoFuUNZW9Uk47bk7CrhqIs4DsUfTg4Vl89Mcdo1b2OivpSiw==
X-Received: by 2002:a0d:cb0f:0:b0:599:da80:e1e6 with SMTP id n15-20020a0dcb0f000000b00599da80e1e6mr1501308ywd.34.1694777186842;
        Fri, 15 Sep 2023 04:26:26 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id b188-20020a0dc0c5000000b0055a07e36659sm800181ywd.145.2023.09.15.04.26.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:26:26 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d81d09d883dso443532276.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:26:26 -0700 (PDT)
X-Received: by 2002:a25:adc2:0:b0:d7a:ba02:eaa1 with SMTP id
 d2-20020a25adc2000000b00d7aba02eaa1mr1222546ybe.64.1694777186242; Fri, 15 Sep
 2023 04:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230905174935.2d75feab@gandalf.local.home>
In-Reply-To: <20230905174935.2d75feab@gandalf.local.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 13:26:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUptOPp-Ypa5r0Jqn+YVkhS2SXYNMKnPqccsSYQYG_xjA@mail.gmail.com>
Message-ID: <CAMuHMdUptOPp-Ypa5r0Jqn+YVkhS2SXYNMKnPqccsSYQYG_xjA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Removed double allocation of wq_update_pod_attrs_buf
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 8:46 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> First commit 2930155b2e272 ("workqueue: Initialize unbound CPU pods later in
> the boot") added the initialization of wq_update_pod_attrs_buf to
> workqueue_init_early(), and then latter on, commit 84193c07105c6
> ("workqueue: Generalize unbound CPU pods") added it as well. This appeared
> in a kmemleak run where the second allocation made the first allocation
> leak.
>
> Fixes: 84193c07105c6 ("workqueue: Generalize unbound CPU pods")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Just noticed this, too.
John posted a similar patch after you:
https://lore.kernel.org/all/20230913101634.553699-1-john.ogness@linutronix.de/

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
