Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9B3754C22
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 23:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjGOVlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 17:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjGOVle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 17:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F1A270A;
        Sat, 15 Jul 2023 14:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9973D60C38;
        Sat, 15 Jul 2023 21:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218BEC433C8;
        Sat, 15 Jul 2023 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689457292;
        bh=YJO1lPmdORdx8sjgLX1VcQo0a5JqUgbk5mWI0fSfdDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2MojLP/AAFu8X+JVi8T4pfNXm7a/BtOTXfShvAXn8CdE5xZ0Qg/isXHaAoAFwqph
         ddawgdKS74ut4A/5Cm/HF2UpSFwZj31L1LkYsgsZUEjiUWzPjfdcT78yUu1U7/dFpt
         u0nLkuUCIqrvLb0MyOkgMRyAXu7f6VoEr/mlnZcQOFv84UGEYRiDArOgIDlx2BBNM2
         uAYaQoOzA+QMvVQZtW/iDuXmiKlkah9sSbZqLB7/7XDx5K+48Mc4RTtyFikb2t5muT
         9uZbHsN+iGSBND8dH0DkoSHZvbsAs7yQOeRb0b6H3v1za2fYG4H9gr/T7VRWxrRv0z
         Xz68gmhscGzew==
Date:   Sat, 15 Jul 2023 14:44:59 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_varada@quicinc.com
Subject: Re: [PATCH 1/2] rpmsg: glink: change rx work queue type
Message-ID: <ig7nexzsgmxehoezgdyisnl5akapckuvw63qccbpbee2v5wb7u@bwsbwxhzt3ji>
References: <20230607121731.26958-1-quic_mmanikan@quicinc.com>
 <20230607121731.26958-2-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607121731.26958-2-quic_mmanikan@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 05:47:30PM +0530, Manikanta Mylavarapu wrote:
> In case of heavy cpu load, rx worker thread
> not able to get cpu slot because it's bound
> to kernel global work queue.
> 
> Glink client drivers will return timeout
> error if they didn't receive response
> within stipulated duration. Changing rx
> work queue type to UNBOUND workqueue
> ensures rx worker thread will be executed
> as early as possible.
> 

I'm guessing that you're referring to the fact that incoming intent
requests (GLINK_CMD_RX_INTENT_REQ) are handled in the rx_worker. But I
shouldn't have to guess, please improve your commit message to be
slightly more specific.

Could we/should we handle the intent requests differently?

Please also use 75 character long lines in your commit message.

> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 1beb40a1d3df..6f9a439e5046 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -81,6 +81,7 @@ struct glink_core_rx_intent {
>   * @rx_pipe:	pipe object for receive FIFO
>   * @tx_pipe:	pipe object for transmit FIFO
>   * @rx_work:	worker for handling received control messages
> + * @rx_wq:	work queue of rx_work
>   * @rx_lock:	protects the @rx_queue
>   * @rx_queue:	queue of received control messages to be processed in @rx_work
>   * @tx_lock:	synchronizes operations on the tx fifo
> @@ -100,6 +101,7 @@ struct qcom_glink {
>  	struct qcom_glink_pipe *tx_pipe;
>  
>  	struct work_struct rx_work;
> +	struct workqueue_struct *rx_wq;
>  	spinlock_t rx_lock;
>  	struct list_head rx_queue;
>  
> @@ -822,7 +824,7 @@ static int qcom_glink_rx_defer(struct qcom_glink *glink, size_t extra)
>  	list_add_tail(&dcmd->node, &glink->rx_queue);
>  	spin_unlock(&glink->rx_lock);
>  
> -	schedule_work(&glink->rx_work);
> +	queue_work(glink->rx_wq, &glink->rx_work);
>  	qcom_glink_rx_advance(glink, sizeof(dcmd->msg) + extra);
>  
>  	return 0;
> @@ -1665,6 +1667,8 @@ static void qcom_glink_cancel_rx_work(struct qcom_glink *glink)
>  	/* cancel any pending deferred rx_work */
>  	cancel_work_sync(&glink->rx_work);
>  
> +	destroy_workqueue(glink->rx_wq);
> +
>  	list_for_each_entry_safe(dcmd, tmp, &glink->rx_queue, node)
>  		kfree(dcmd);
>  }
> @@ -1750,6 +1754,10 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
>  	INIT_WORK(&glink->rx_work, qcom_glink_work);
>  	init_waitqueue_head(&glink->tx_avail_notify);
>  
> +	glink->rx_wq = alloc_workqueue("glink_rx_wq", WQ_UNBOUND, 1);

Please see the description in e.g. 56310520308a ("soc: qcom: qmi: Use
alloc_ordered_workqueue() to create ordered workqueues")

Regards,
Bjorn

> +	if (!glink->rx_wq)
> +		return ERR_PTR(-ENOMEM);
> +
>  	spin_lock_init(&glink->idr_lock);
>  	idr_init(&glink->lcids);
>  	idr_init(&glink->rcids);
> -- 
> 2.17.1
> 
