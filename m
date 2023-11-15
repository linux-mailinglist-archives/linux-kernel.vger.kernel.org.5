Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A19C7ED5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbjKOVOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOVOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:14:11 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2778F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1700082845; bh=W9KXgXVjkRP1ZMFtQmwVxTYS6mN2ITCo/XA2zoJqWUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TEDeaIlUv/PTImbVcF2pLGH1b9d75kSmERFBAXc/E9DVyWLn8Vw7dUiUr7CqgvPru
         wFm+LQ1G29vuL1LhD4b52lljINYapfc5wyZn6dtZaHUA+utaNfLi/jtC6DwEbGJKn5
         v5AXtJBPJbOtwbG38oW+7mA0I1yskSL0ih5agytA=
Date:   Wed, 15 Nov 2023 22:14:05 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     huangzaiyang <huangzaiyang@oppo.com>
Cc:     tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, ZaiYang Huang <hzy0719@163.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH] workqueue: Make a warning when a pending delay work
 being re-init
Message-ID: <54af48a0-2d3c-4888-953b-28760f129d33@t-8ch.de>
References: <20231115113427.1420-1-huangzaiyang@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231115113427.1420-1-huangzaiyang@oppo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-15 19:34:27+0800, huangzaiyang wrote:
> There is a timer_list race condition if a delay work is queued twice,
> this usually won't happen unless someone reinitializes the task before performing the enqueue operation,likeï¼?
> https://github.com/torvalds/linux/blob/master/drivers/devfreq/devfreq.c#L487
> A warning message will help developers identify this irregular usage.
> 
> Signed-off-by: ZaiYang Huang <hzy0719@163.com>
> ---
>  include/linux/workqueue.h | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 24b1e5070f4d..54102ed794e5 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -266,6 +266,22 @@ static inline void destroy_delayed_work_on_stack(struct delayed_work *work) { }
>  static inline unsigned int work_static(struct work_struct *work) { return 0; }
>  #endif
> 
> +/**
> + * work_pending - Find out whether a work item is currently pending
> + * @work: The work item in question
> + */
> +#define work_pending(work) \
> +       test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))
> +
> +/**
> + * delayed_work_pending - Find out whether a delayable work item is currently
> + * pending
> + * @w: The work item in question
> + */
> +#define delayed_work_pending(w) \
> +       work_pending(&(w)->work)
> +
> +
>  /*
>   * initialize all of a work item in one go
>   *
> @@ -310,6 +326,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
> 
>  #define __INIT_DELAYED_WORK(_work, _func, _tflags)                     \
>         do {                                                            \
> +               WARN_ON(delayed_work_pending(_work));                   \

How does this work when the data _work points to is not yet initialized?
Reading uninitialized data is UB and may spuriously trigger the warning.

>                 INIT_WORK(&(_work)->work, (_func));                     \
>                 __init_timer(&(_work)->timer,                           \
>                              delayed_work_timer_fn,                     \
> @@ -318,6 +335,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }

[..]

> --
> 2.17.1
> 
> ________________________________
> OPPO

The gunk at the end of the mail will prevent your patch from being
considered at all.

> 
> ±¾µç×ÓÓÊ¼þ¼°Æä¸½¼þº¬ÓÐOPPO¹«Ë¾µÄ±£ÃÜÐÅÏ¢£¬½öÏÞÓÚÓÊ¼þÖ¸Ã÷µÄÊÕ¼þÈË£¨°üº¬¸öÈË¼°Èº×é£©Ê¹ÓÃ¡£½ûÖ¹ÈÎºÎÈËÔÚÎ´¾­ÊÚÈ¨µÄÇé¿öÏÂÒÔÈÎºÎÐÎÊ½Ê¹ÓÃ¡£Èç¹ûÄú´íÊÕÁË±¾ÓÊ¼þ£¬ÇÐÎð´«²¥¡¢·Ö·¢¡¢¸´ÖÆ¡¢Ó¡Ë¢»òÊ¹ÓÃ±¾ÓÊ¼þÖ®ÈÎºÎ²¿·Ö»òÆäËùÔØÖ®ÈÎºÎÄÚÈÝ£¬²¢ÇëÁ¢¼´ÒÔµç×ÓÓÊ¼þÍ¨Öª·¢¼þÈË²¢É¾³ý±¾ÓÊ¼þ¼°Æä¸½¼þ¡£

[..]
