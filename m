Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B67845A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjHVPeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjHVPeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:34:19 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448DFC7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:34:18 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-790970a8706so166362539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692718457; x=1693323257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=23HZEtSy74oKRHG4dRJMMnNxq2Nhz1/Vw/8CyykmCFA=;
        b=sy4v8ZilSundFmjh1wetcR8Cq484nYree/rTTCQXHX1HbVxrtmaDT+XSjMzjOsx7Ip
         03VhBqHfzRlt7wI8RITAWh3v2kxBml8XLfjbBkObFoqrUSaux5+qwJ26bM2YiO54yiFu
         vbj51a8T39bvpCTKbhZOI34cKH/I1j2PkfeEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718457; x=1693323257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23HZEtSy74oKRHG4dRJMMnNxq2Nhz1/Vw/8CyykmCFA=;
        b=eg9VE+2FJ+WaXjcFc9w7vAirpm6aWraJzko3DcxOfyMfYh9s12Bjw75bPciOPVqzAo
         Qe8Q2rFsQdPRB6KhvAAoELlpl/tkMKXCPtwgMvft0+15xVon8ZJfbhwbeyq3AfvK57C5
         DUK4zxqvkARHbP8SYRmDhtaOhbAwi42ORahLTMKkVv3jSCmzOnQus18IN/jhVHJ6Ip6N
         C/E94wh7Ncybj4S1M7tuzPvBLz1QIxM01Mdt57GNx1kfLE4J4JonQbcuwgrefp+oB/iD
         eDVwf1yv/wdDbbaUT4jKgzu8gvz0ldpwr4CxhZwWWCJNdRbZtAmIKV/kp+hY5DJ/GeuU
         XbQg==
X-Gm-Message-State: AOJu0YwYcRwfuiTknxmPRGqy7TEB8j98xI8GKmcmlxAZOt41EF5xXpo+
        xbSxgY5bUY4bJKXZnGNrh7BL3w==
X-Google-Smtp-Source: AGHT+IHGD5ggcRJRfTk5XATu8k1Uz0pBZJzm3JpEKzEMirIhJduTlwj54ThHlo9nj2B2EDZdQpso8g==
X-Received: by 2002:a5d:8550:0:b0:783:6272:afbb with SMTP id b16-20020a5d8550000000b007836272afbbmr63912ios.9.1692718457609;
        Tue, 22 Aug 2023 08:34:17 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id g4-20020a02c544000000b0042b3ad1656bsm3163204jaj.45.2023.08.22.08.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:34:16 -0700 (PDT)
Date:   Tue, 22 Aug 2023 15:34:16 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        chenhuacai@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V3] rcu: Update jiffies locally in rcu_cpu_stall_reset()
Message-ID: <20230822153416.GA72567@google.com>
References: <20230822040248.329442-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822040248.329442-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 12:02:48PM +0800, Huacai Chen wrote:
> The KGDB initial breakpoint gets an rcu stall warning after commit
> a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection in
> rcu_cpu_stall_reset()").
> 
> [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CPU
[...]
> 
> [1] https://lore.kernel.org/rcu/20230814020045.51950-1-chenhuacai@loongson.cn/T/#t
> 
> Cc: stable@vger.kernel.org
> Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection in rcu_cpu_stall_reset()")
> Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Use NMI safe functions.
> V3: Add comments to explain why.
> 
>  kernel/rcu/tree_stall.h | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b10b8349bb2a..e4e53113d062 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -150,11 +150,26 @@ static void panic_on_rcu_stall(void)
>   * rcu_cpu_stall_reset - restart stall-warning timeout for current grace period
>   *
>   * The caller must disable hard irqs.
> + *
> + * The jiffies updating may be delayed for a very long time due to tickless and
> + * irq disabled, especially in the KGDB case, so we need to add the delayed time
> + * (delta) to rcu_state.jiffies_stall.
> + *
> + * This function may be called in NMI context, so we cannot use ktime_get_ns()
> + * and ktime_get_coarse_ns(). Instead, we use their inaccurate but safe friends
> + * ktime_get_mono_fast_ns() and ktime_get_seconds() which will cause rcu_state.
> + * jiffies_stall to be a little large than expected (harmless and safer).
>   */
>  void rcu_cpu_stall_reset(void)
>  {
> +	u64 curr, last, delta;
> +
> +	curr = ktime_get_mono_fast_ns();
> +	last = ktime_get_seconds() * NSEC_PER_SEC;
> +	delta = nsecs_to_jiffies(curr - last);
> +
>  	WRITE_ONCE(rcu_state.jiffies_stall,
> -		   jiffies + rcu_jiffies_till_stall_check());
> +		   jiffies + delta + rcu_jiffies_till_stall_check());
>  }

I prefer the following diff on top of your patch to take advantage of UBSAN
detecting overflows.

If you take my diff, feel free to add:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---8<-----------------------

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5e9e4779bdf1..3398cf2d19c5 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -162,14 +162,15 @@ static void panic_on_rcu_stall(void)
  */
 void rcu_cpu_stall_reset(void)
 {
-	u64 curr, last, delta;
+	ktime_t last, delta_ns;
+	u64 delta_jiff;
 
-	curr = ktime_get_mono_fast_ns();
 	last = ktime_get_seconds() * NSEC_PER_SEC;
-	delta = nsecs_to_jiffies(curr - last);
+	delta_ns = ktime_sub(ktime_get_mono_fast_ns(), last);
+	delta_jiff = nsecs_to_jiffies(delta_ns);
 
 	WRITE_ONCE(rcu_state.jiffies_stall,
-		   jiffies + delta + rcu_jiffies_till_stall_check());
+		   jiffies + delta_jiff + rcu_jiffies_till_stall_check());
 }
 
 //////////////////////////////////////////////////////////////////////////////
