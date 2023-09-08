Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4FC7984DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjIHJdc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 05:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIHJdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:33:32 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD9F11B;
        Fri,  8 Sep 2023 02:33:28 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qeXrN-000Qdx-SS; Fri, 08 Sep 2023 11:33:05 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qeXrN-001RDz-Kp; Fri, 08 Sep 2023 11:33:05 +0200
Message-ID: <d0792bca7d56b47c56c0eb0157b58724a8468fd2.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: push-switch: reorder cleanup operations to avoid
 UAF bug
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Duoming Zhou <duoming@zju.edu.cn>, ysato@users.sourceforge.jp
Cc:     dalias@libc.org, kvalo@kernel.org, pavel@ucw.cz, pabeni@redhat.com,
        rostedt@goodmis.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 08 Sep 2023 11:33:04 +0200
In-Reply-To: <20230802033737.9738-1-duoming@zju.edu.cn>
References: <20230802033737.9738-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-02 at 11:37 +0800, Duoming Zhou wrote:
> The original code puts flush_work() before timer_shutdown_sync()
> in switch_drv_remove(). Although we use flush_work() to stop
> the worker, it could be re-scheduled in switch_timer. As a result,
> the UAF bug will happen. The detail is shown below:
> 
>       (cpu 0)                    |      (cpu 1)
> switch_drv_remove()              |
>  flush_work()                    |
>   ...                            |  switch_timer //timer
>                                  |   schedule_work(&psw->work)
>  timer_shutdown_sync()           |
>  ...                             |  switch_work_handler //worker
>  kfree(psw) //free               |
>                                  |   psw->state = 0 //use
> 
> This patch puts timer_shutdown_sync() before flush_work() to
> mitigate the bugs. As a result, the worker and timer could
> be stopped safely before the deallocate operations.
> 
> Fixes: 9f5e8eee5cfe ("sh: generic push-switch framework.")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>  arch/sh/drivers/push-switch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.c
> index c95f48ff3f6..6ecba5f521e 100644
> --- a/arch/sh/drivers/push-switch.c
> +++ b/arch/sh/drivers/push-switch.c
> @@ -101,8 +101,8 @@ static int switch_drv_remove(struct platform_device *pdev)
>  		device_remove_file(&pdev->dev, &dev_attr_switch);
>  
>  	platform_set_drvdata(pdev, NULL);
> -	flush_work(&psw->work);
>  	timer_shutdown_sync(&psw->debounce);
> +	flush_work(&psw->work);
>  	free_irq(irq, pdev);
>  
>  	kfree(psw);

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
