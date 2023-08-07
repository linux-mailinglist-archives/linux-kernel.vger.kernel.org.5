Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A68772626
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHGNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjHGNlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:41:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D681737;
        Mon,  7 Aug 2023 06:40:40 -0700 (PDT)
Date:   Mon, 7 Aug 2023 15:40:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691415635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8HbwuGRoab64jNr6WfTTqfse3Fi51ai1CDmJlXYwjDI=;
        b=K+GSUUxN/SLGCwYcKI+dNuDFK2JX8h0eJC5sHSYSF45eiRsIFA2c6xKudioIIg+KEGFuxS
        Wr74ss3mj84mdnknrVva7TeA8mqAh/yXYuo3HIYLrMf1kQ1TT+oxy3ohhmTGm6UW0jD+Tl
        HUKczPlLZL8/6bfbVEp43lwC08c5OLfANRTHaK5EFfkoVprnKkMoJLUQFsAgtWSzekcVmL
        /N3wFh4B6tg73yow8OWb8EGTq6VHyXp7XoLf2PWoGRoGvVRP4Ske3ca4erK9db6r12tlY1
        UgRolJ0Ih0IlBKXUapFnuFky53oohSEu/Bxh6qV3TDebD4DcKytOj6yVqLoWhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691415635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8HbwuGRoab64jNr6WfTTqfse3Fi51ai1CDmJlXYwjDI=;
        b=zOaBCsAA2Y43ouiK+7lmeg+9dLuINEyURwR4vvjS43Sgxto7FxXUL4nlpWw8U61Bn50Y5v
        A3VooxwtorSYj5Dw==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     quanyang.wang@windriver.com
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: etm3x: convert struct etm_drvdata's spinlock
 to raw_spinlock
Message-ID: <20230807134034.CBCA22uP@linutronix.de>
References: <20230711070536.3944458-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230711070536.3944458-1-quanyang.wang@windriver.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-11 15:05:36 [+0800], quanyang.wang@windriver.com wrote:
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 116a91d90ac2..af34fb82f4bb 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -518,7 +518,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
>  	struct etm_enable_arg arg = { };
>  	int ret;
>  
> -	spin_lock(&drvdata->spinlock);
> +	raw_spin_lock(&drvdata->spinlock);
>  
>  	/* sysfs needs to allocate and set a trace ID */
>  	ret = etm_read_alloc_trace_id(drvdata);

This is not going to work because etm_read_alloc_trace_id() acquires
later in the call chain id_map_lock which is a spinlock_t.
This should also lead to a splat like the one you complain about.

Sebastian
