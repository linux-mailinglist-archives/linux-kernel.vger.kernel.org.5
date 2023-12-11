Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FA880CA7D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343581AbjLKNGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:06:35 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F5983
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:06:41 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso56673221fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702299999; x=1702904799; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l2+BcaWaIdH2EhxOu9pCW0GPZ5AXB4G6Yke84Ayjtgk=;
        b=ACPPhBIk+smwBpZpkSFoaJi0+u1sSOSMJBy6vDo0A642P3CwQ5zrJ9HVBbhBruDI1k
         9xLXNWjDJ+oGTproZ/+aCD2rDAL5+0VxUD/sMHnw1fbMt7Amx/OpTM5x97UTsUmwQYNo
         s93lPc/zjklPzDi/DgBCiRGs/kp9OKFgEDRCbD3pB9NLCWflynAEkrV5dRd86HMkl61J
         UJg+aA3NMvEYpmpBkjZIGBgdYMt6PenkHJkl6vO3mM4AqdHCJGV7EyFZ9JODSRAtmbxB
         WJvlVzHnv0DLUCQNMKHzoeTPYKDr3ux+TjWWlPgZbVAB9lm/kx8HIGplbvD9qkUVz3hx
         Lumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702299999; x=1702904799;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2+BcaWaIdH2EhxOu9pCW0GPZ5AXB4G6Yke84Ayjtgk=;
        b=Pjme2xMUkvCkuuf6Luo4e3fo63tAADpzYshx5x2/ommtbC015BQ4Bx1aFuXBk40myP
         vDdT3RtyeP972dhD6XDP3xImq3nFz3VyS24j4eAK67CAsOJesv9e6ax3uQZUMTzAj5eY
         q1vPPVwzDA7+Y7qbccrb09FGMhX4e4WPCHlsk+SU0U3BL0mIr6h3krJjAMBo0R+RgZIe
         56xB53AO7SsPDH4yEdvU9srWMVenFMs5GXkk5N1L5DGL+ZQV7FmUEOZdKsuO86WiQvoh
         JYxWUkBAgvoIk6k++Q6F6k64IWstfUE3+G/zAfYXnPQ0e6JZBlbo0egnawYGpz+SUxdv
         s/mQ==
X-Gm-Message-State: AOJu0YzguE6/2OmVnMCCAMsuJ4+s9XRkpUEm1cHmRbyebqek0sOgAK1A
        nSJVjpbyEZ8TF9h5LWFDc35W/BKh57i+iNjw22aj91nn3G78xg==
X-Google-Smtp-Source: AGHT+IFo7mxJEcsQ7a6OPALPOYKg9mEKwGcuSuxDeVXOdd/stN0LOmAaKSF1pyrR5iUCmt2x3bCcUc9jf6nIvqwwUO0=
X-Received: by 2002:a2e:a103:0:b0:2cc:1dc8:4e96 with SMTP id
 s3-20020a2ea103000000b002cc1dc84e96mr1531207ljl.24.1702299999354; Mon, 11 Dec
 2023 05:06:39 -0800 (PST)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 11 Dec 2023 18:36:26 +0530
Message-ID: <CAHP4M8WQdQfjxa-oqGTEF-kfF3j8En6V5fi7gyNbGegwFqfpCQ@mail.gmail.com>
Subject: Query on a rare simultaneous processing of interrupts from GIC/NVIC
To:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

Let's say the following code is shared by multiple ISRs :

   spin_lock_irqsave
   <critical section>
   spin_lock_irqrestore



Also, following sequencing happens :

*
Low-priority interrupt comes in, and GIC/NVIC causes it jump to ISR.

*
Low-priority interrupt starts executing "spin_lock_irqsave".

*
Before preemption and interrupts could be disabled (by the executing
low-priority interrupt). high-priority interrupt comes in.
Since a higher priority interrupt has come in, the GIC/NVIC causes it
to start executing the "spin_lock_irqsave" statement.

*
Through the low-priority interrupt executing, "spin_lock_irqsave" has completed.
Preemption and interrupts are disabled, and low-priority interrupt
grabs the spin lock.

*
High-priority interrupt spins on the spin-lock.



Is the above sequencing possible?

In other words, although the first interrupt did its best to disable
all preemption and interrupts before it could enter the critical
section, yet above sequencing *will* cause the high-priority interrupt
to spin?


Many thanks in advance for your time for help !


Thanks and Regards,
Ajay
