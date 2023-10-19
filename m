Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D367CF09D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjJSHCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjJSHCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:02:44 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF8F130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:02:41 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2d9ac9926so1533762b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697698961; x=1698303761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BeYzNw+TQIgVi4kigpsKuchcyCs0gWJwXKQOHHUsYtw=;
        b=m1cmBYyKU3s8vQYq2h9OBagLuY7LjnIWUfqfF/1Ra9nLgdEtQxwSTMcmfgCJpGX73c
         ob13vt0NSDhbkEXWiHNC02xamU+YuEFighGINAsl/dU7cFV6fAfY2xGqE+V82nKXMprj
         u1yLHYA2LpXkqNgIT+1B+9qEMpiaB3EE/d2lirXzutvW/LQ/kv9GToyc2/KfT4G3ERqg
         e1Ndyy/O9x7ZJnbNHAiOrOPneEIwA365cQtGJPduzI6LvPMTr1T10BrG4MCoC0vQL6mV
         molXsrXN1eiXTVoFltT5lbeLSojcmJUj7X5wk6rEMV+mc9dvOMT3/0/RjsXWEic0TXT1
         p3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697698961; x=1698303761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeYzNw+TQIgVi4kigpsKuchcyCs0gWJwXKQOHHUsYtw=;
        b=BCb2aygSvl+2x50lTy6v8ymzlqvNWpvDDfR1xsZOTgkeSq0BfslS9R3RTCwZbrB7O4
         UoYBpMHo/Am9c/xihPjEatFkNZ3EsPiOjq98tJMPnR1Nbh5dJbXcdSbsOKUNSl24b3Zo
         elYpFeOA7V6C6Lr89SvTdbzaQS/p7dceXXTmDnQiNo6YQelL5AJI21hNtm9majFmayEX
         Ak8pQ41Pq1xTCUVtaNnjVb52dwxW0jWN8Llee1ZeO3UYTWfJF6GsfT+V9JUUND/3dBIq
         9GDPy0qGlwX4JtctiNSOpJXS7i9O4P01Cqrme6+r4mIcF0LLtpxEhrtGyEPi56XekDOy
         9zZA==
X-Gm-Message-State: AOJu0YzZp7ESU86JfHZqMhfnqCiCB50XO28t2NLU+dPXuDZW90vqAufv
        vtd/7a5pNMBdukpf1v7rlwWDHAIx3pA=
X-Google-Smtp-Source: AGHT+IG6pZbUMt33pYS5aZTyqiBlc6NtOpskeej0yxst1T7yq928Nm9lFoUXdMXGh9kSq+EdkD6HhQ==
X-Received: by 2002:a05:6808:8ce:b0:3b2:e07e:5062 with SMTP id k14-20020a05680808ce00b003b2e07e5062mr1292624oij.52.1697698960910;
        Thu, 19 Oct 2023 00:02:40 -0700 (PDT)
Received: from MacBook-Pro-3.local ([111.108.111.134])
        by smtp.gmail.com with ESMTPSA id l16-20020a635b50000000b005898df17ea4sm2716334pgm.27.2023.10.19.00.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 00:02:40 -0700 (PDT)
Date:   Thu, 19 Oct 2023 15:02:33 +0800
From:   Wei Gong <gongwei833x@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] genirq: avoid long loops in handle_edge_irq
Message-ID: <ZTDUiXnb_Sn-5bT2@MacBook-Pro-3.local>
References: <20230928100638.42116-1-gongwei833x@gmail.com>
 <87r0m3q32t.ffs@tglx>
 <ZSf3KrAk8fpyNEZr@MacBook-Pro-3.local>
 <877cnqlxmz.ffs@tglx>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FTC2iWVQn3e1B+SV"
Content-Disposition: inline
In-Reply-To: <877cnqlxmz.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FTC2iWVQn3e1B+SV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

O Fri, Oct 13, 2023 at 10:44:36AM +0200, Thomas Gleixner wrote:
> On Thu, Oct 12 2023 at 21:39, Wei Gong wrote:
> > O Mon, Oct 09, 2023 at 04:32:10PM +0200, Thomas Gleixner wrote:
> >> Now $COND is not true due to the affinity change and the edge handler
> >> returns. As a consequence nothing acks the device and no further
> >> interrupts are sent by the device.
> >> 
> >> That might not be true for your case, but that's a generic function and the
> >> zoo of hardware which uses that is massive.
> >> 
> >> So no, we are not taking a risk here.
> >> 
> >> Thanks,
> >> 
> >>         tglx
> >> 
> >>     
> > By maintaining the original loop exit condition, if a mask mismatch is 
> > detected within the loop, we will not perform the unmask_irq operation. 
> > Instead, we will wait until the loop exits before executing unmask_irq.
> > Could this approach potentially solve the issue of lost interrupts?
> 
> How so exactly?
> 

--FTC2iWVQn3e1B+SV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="p.diff.txt"

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8f8f1d62f..b846659ce 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -823,7 +823,9 @@ void handle_edge_irq(struct irq_desc *desc)
 		 */
 		if (unlikely(desc->istate & IRQS_PENDING)) {
 			if (!irqd_irq_disabled(&desc->irq_data) &&
-			    irqd_irq_masked(&desc->irq_data))
+			    irqd_irq_masked(&desc->irq_data) &&
+			    cpumask_test_cpu(smp_processor_id(),
+				    irq_data_get_effective_affinity_mask(&desc->irq_data)))
 				unmask_irq(desc);
 		}
 
@@ -832,6 +834,10 @@ void handle_edge_irq(struct irq_desc *desc)
 	} while ((desc->istate & IRQS_PENDING) &&
 		 !irqd_irq_disabled(&desc->irq_data));
 
+if (!irqd_irq_disabled(&desc->irq_data) &&
+    irqd_irq_masked(&desc->irq_data))
+	unmask_irq(desc);
+
 out_unlock:
 	raw_spin_unlock(&desc->lock);
 }

--FTC2iWVQn3e1B+SV--
