Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A41B80EBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346565AbjLLMf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346525AbjLLMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:35:25 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E84F7;
        Tue, 12 Dec 2023 04:35:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50be24167efso6450391e87.3;
        Tue, 12 Dec 2023 04:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702384529; x=1702989329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0zDRySjMo+qwZzH47WU4ammVZHFSL1x17ewXgp1HGpg=;
        b=Qa+QruYnUXd9H2UyG/tHPsw7iCxgP9XO1gc1BMrK0STiRdib/BkpaKXGjeMt8HeqhZ
         fvcLFJh38CRwYBsbRCXxmW7CYZqwbe5hZWke8CfHwDHP78nnULSZBGhpSbaHoKw+kWi1
         buCNJeluq85a2gcpQTzLpDQjvy1CUwvhKSnCqZy/+oRvvviPovvWaeTs/3aKxnfbf2ED
         wjrgs3s4qxU20Be0jR4DL9HG2dCd9vSPnY/5+R9SB20hh2++aSzgqSZs6f4BAgfx0WXS
         /R5BprmWSuEkZOJ8Cm55KKeyV5UXF0iovAGSucxKiDT1nMU262cTsy9gtyYF3mQt0PAH
         sg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702384529; x=1702989329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zDRySjMo+qwZzH47WU4ammVZHFSL1x17ewXgp1HGpg=;
        b=VqYUw6ZAAKg8yAU+viyw16u6ln56a7W6cExgo0xGHNDlZukmDEx1qfz1UuiHjSkyYA
         Giu9u1w/ffD7tC30AF1/NK39ssJ9Zd1jyA1PCld++MKvQfSNLwX6BCdfaArK5eMQIYNC
         haa0BFfZ45qfhnMaFmvR9ehkgIY+aRNQXIbqOeScQ2D+SRimigLuJxiwIhOAf3T7dF3M
         ifGip/w9mZaBrNWepKJGLOF4kVGqk/p/DAnEBwkVolofA72T//6mexSDTw4Zi1Qnsc75
         +OAJBWYFqKLeeAQV7BkzL3ACsvNsytjCzkcY7r6S4N8bPPqdpKOWkJvKu+iqtR8lKlXU
         QWew==
X-Gm-Message-State: AOJu0YwHzV08r0Ku0PguKTeDzW8VNw5HzcypD0of0pu1jAMsDiu98j7e
        5rf2+TRzSfnp38W9bIS8pOc=
X-Google-Smtp-Source: AGHT+IHLrEi3DaNMIaL5gZeds6oRN3w6A2KUNE0rU52JiCdw7VpcF/sGrrOu8+74lqV96H44z92WRg==
X-Received: by 2002:a05:6512:48d3:b0:50b:fada:dac3 with SMTP id er19-20020a05651248d300b0050bfadadac3mr1186619lfb.108.1702384529258;
        Tue, 12 Dec 2023 04:35:29 -0800 (PST)
Received: from pc636 (host-90-235-2-229.mobileonline.telia.com. [90.235.2.229])
        by smtp.gmail.com with ESMTPSA id c16-20020a197610000000b0050bf30083b2sm1328567lff.142.2023.12.12.04.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:35:28 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 12 Dec 2023 13:35:26 +0100
To:     Qais Yousef <qyousef@layalina.io>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
Message-ID: <ZXhTjrTqZvMTXKtK@pc636>
References: <20231203011252.233748-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203011252.233748-1-qyousef@layalina.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 01:12:52AM +0000, Qais Yousef wrote:
> To allow more flexible arrangements while still provide a single kernel
> for distros, provide a boot time parameter to enable/disable lazy RCU.
> 
> Specify:
> 
> 	rcutree.enable_rcu_lazy=[y|1|n|0]
> 
> Which also requires
> 
> 	rcu_nocbs=all
> 
> at boot time to enable/disable lazy RCU.
> 
> To disable it by default at build time when CONFIG_RCU_LAZY=y, the new
> CONFIG_RCU_LAZY_DEFAULT_OFF can be used.
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
> 
> Changes since v1:
> 
> 	* Use module_param() instead of module_param_cb()
> 	* Add new CONFIG_RCU_LAZY_DEFAULT_OFF to force default off.
> 	* Remove unnecessary READ_ONCE()
> 
> Tested on qemu only this time with various config/boot configuration to ensure
> expected values are in sysfs.
> 
> Did a bunch of build tests against various configs/archs.
> 
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  kernel/rcu/Kconfig                              | 13 +++++++++++++
>  kernel/rcu/tree.c                               |  7 ++++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..2f0386a12aa7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5021,6 +5021,11 @@
>  			this kernel boot parameter, forcibly setting it
>  			to zero.
>  
> +	rcutree.enable_rcu_lazy= [KNL]
> +			To save power, batch RCU callbacks and flush after
> +			delay, memory pressure or callback list growing too
> +			big.
> +
>  	rcuscale.gp_async= [KNL]
>  			Measure performance of asynchronous
>  			grace-period primitives such as call_rcu().
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index bdd7eadb33d8..e7d2dd267593 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -314,6 +314,19 @@ config RCU_LAZY
>  	  To save power, batch RCU callbacks and flush after delay, memory
>  	  pressure, or callback list growing too big.
>  
> +	  Requires rcu_nocbs=all to be set.
> +
> +	  Use rcutree.enable_rcu_lazy=0 to turn it off at boot time.
> +
> +config RCU_LAZY_DEFAULT_OFF
> +	bool "Turn RCU lazy invocation off by default"
> +	depends on RCU_LAZY
> +	default n
> +	help
> +	  Allows building the kernel with CONFIG_RCU_LAZY=y yet keep it default
> +	  off. Boot time param rcutree.enable_rcu_lazy=1 can be used to switch
> +	  it back on.
> +
>  config RCU_DOUBLE_CHECK_CB_TIME
>  	bool "RCU callback-batch backup time check"
>  	depends on RCU_EXPERT
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ac3c846105f..8b7675624815 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2719,6 +2719,9 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>  }
>  
>  #ifdef CONFIG_RCU_LAZY
> +static bool enable_rcu_lazy __read_mostly = !IS_ENABLED(CONFIG_RCU_LAZY_DEFAULT_OFF);
> +module_param(enable_rcu_lazy, bool, 0444);
> +
>  /**
>   * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
>   * flush all lazy callbacks (including the new one) to the main ->cblist while
> @@ -2744,6 +2747,8 @@ void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
>  	__call_rcu_common(head, func, false);
>  }
>  EXPORT_SYMBOL_GPL(call_rcu_hurry);
> +#else
> +#define enable_rcu_lazy		false
>  #endif
>  
>  /**
> @@ -2792,7 +2797,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
>   */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> +	__call_rcu_common(head, func, enable_rcu_lazy);
>  }
>  EXPORT_SYMBOL_GPL(call_rcu);
>  
I think, it makes sense. Especially for devices/systems where it is hard
to recompile the kernel and deploy it. For example, Google and GKI approach.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
