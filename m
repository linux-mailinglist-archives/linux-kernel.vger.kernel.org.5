Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78E97C65B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343567AbjJLGhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347082AbjJLGhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:37:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8FADA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:37:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b98a699f45so90458166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697092648; x=1697697448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfN4c+uJkrhU2kFJj8dGcLWVfidGbqblVgC8sawHtT8=;
        b=Reo+qnmzOb0VgBoRaxLvJSEI6UHaoX/iF4rX1Mu9JZnMjv83bzM+smxhIMPrbcq1b9
         xa23NUDKqgy6ai8G+PkZ+JAr1wN681qyiuxMrnXS55UGTLM5sGHwFUU0dSsnMb0UpSld
         jtXGHEcKF5Leh+6LMZTavq1s1O6G5Iam53COutBEH2eJno6G7fDQRsBt7bb+pRSg2ako
         Ot+RoH80nVtAgekv8Y7bg+OkDzKVVFhUKeANjjsqYPrQZrok+Rk9hjwGfzpMMMReB+oY
         IVHuWSbQQrMKcwmnMoMzZFKV2qmJ/NMQXCv0Ocv0ksDL8Ej2KEUoPKLpepYAI9PW/5RO
         6O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697092648; x=1697697448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfN4c+uJkrhU2kFJj8dGcLWVfidGbqblVgC8sawHtT8=;
        b=cFdm761RY6tojYPwu3/5jRy7rurIjSMo4PSt1pITGPNFmShterrZWHgm8thKp+1z/0
         //detfGfsLGfX3+DBypkGTb/dibo0JliM7EekF3ps4kDycA5gjHP8gWdKscOucX4JhU4
         QIbcIUS3s02yaa3ystI2uF4WOkWp4XKwq3fZDcX7Y79/mBS0jP6fkgGM03Go9ayZmo82
         heq7KJTP3wTOeM0Nu/C38bK4X9uLNmrx8JS+yJM3v/FuhsVfjxVZNXJ/I/5MlxoFUsDs
         5H5Yt3PrfRXocrFaFtsuvDvXezKA/+OCuhdi7MnAh4xvOHGt4A42RHyxMfAUwq4ECTOF
         qu9g==
X-Gm-Message-State: AOJu0YzSYomS6MP/P4U8XZ2tHf89Ks1bmqwFsEU1tpmqRyYIljI80O6R
        8kAmM1jBtqXkVs7zr+loXw8=
X-Google-Smtp-Source: AGHT+IHLBYoDU6y9+qXQ4dgFVDwWyzkUT9uROQDN323r3TRhICe4sXKrY2AckuOuZ9gLWb5wxSWlTA==
X-Received: by 2002:a17:906:144:b0:9b6:5811:d990 with SMTP id 4-20020a170906014400b009b65811d990mr18772808ejh.47.1697092647891;
        Wed, 11 Oct 2023 23:37:27 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id i25-20020a1709064ed900b009b947aacb4bsm10753461ejv.191.2023.10.11.23.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:37:27 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 08:37:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, clm@fb.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH RFC x86/nmi] Fix out-of-order nesting checks
Message-ID: <ZSeUJbZLbk2g7GC/@gmail.com>
References: <0cbff831-6e3d-431c-9830-ee65ee7787ff@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cbff831-6e3d-431c-9830-ee65ee7787ff@paulmck-laptop>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> The ->idt_seq and ->recv_jiffies variables added by commit 1a3ea611fc10
> ("x86/nmi: Accumulate NMI-progress evidence in exc_nmi()") place
> the exit-time check of the bottom bit of ->idt_seq after the
> this_cpu_dec_return() that re-enables NMI nesting.  This can result in
> the following sequence of events on a given CPU in kernels built with
> CONFIG_NMI_CHECK_CPU=y:
> 
> o       An NMI arrives, and ->idt_seq is incremented to an odd number.
>         In addition, nmi_state is set to NMI_EXECUTING==1.
> 
> o       The NMI is processed.
> 
> o       The this_cpu_dec_return(nmi_state) zeroes nmi_state and returns
>         NMI_EXECUTING==1, thus opting out of the "goto nmi_restart".
> 
> o       Another NMI arrives and ->idt_seq is incremented to an even
>         number, triggering the warning.  But all is just fine, at least
>         assuming we don't get so many closely spaced NMIs that the stack
>         overflows or some such.
> 
> Experience on the fleet indicates that the MTBF of this false positive
> is about 70 years.  Or, for those who are not quite that patient, the
> MTBF appears to be about one per week per 4,000 systems.
> 
> Fix this false-positive warning by moving the "nmi_restart" label before
> the initial ->idt_seq increment/check and moving the this_cpu_dec_return()
> to follow the final ->idt_seq increment/check.  This way, all nested NMIs
> that get past the NMI_NOT_RUNNING check get a clean ->idt_seq slate.
> And if they don't get past that check, they will set nmi_state to
> NMI_LATCHED, which will cause the this_cpu_dec_return(nmi_state)
> to restart.

This looks like a sensible fix: the warning should obviously be atomic wrt. 
the no-nesting region. I've applied your fix to tip:x86/irq, as it doesn't 
seem urgent enough with a MTBF of 70 years to warrant tip:x86/urgent handling. ;-)

Thanks,

	Ingo
