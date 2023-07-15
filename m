Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B19754C3C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 23:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGOVrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 17:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGOVrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 17:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE788213F;
        Sat, 15 Jul 2023 14:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4274260ACE;
        Sat, 15 Jul 2023 21:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAED7C433C7;
        Sat, 15 Jul 2023 21:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689457633;
        bh=0ym6BumiF8nCUMugy8PoUi1Eqilv5DUripcU8/IgzN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hq+0jPzICfhKbIt5EGXlVGPHu/7Id2j2H7y2z/sg10dTDOYulbHHbNx6DcrR3K20F
         kL8Hmzdd/P/R4ZVwCxRMsd+w8wWknU4tsAt7OfLx4iSt1Ve6s62DHxmz7hG+bAf+gX
         KFNvY5QCAMqNDltC+NDnxxh6BDIbak6HNLr9NFmAKh3Ynt/pWbQ6rq6iNrkfkGtEZO
         0mHpuC5LrSFxoQYiO7FnLgHvHcOGmfnLQ3rJAPQylTj+q86x1WEpsDa0DyjmO3Xc9e
         /V3RPUQ5b4pauvJibckDN2rKg15bI5oZfiurLf6dip1vkUf8JywculA21r8nWMd65a
         oAvCLXS4quNhg==
Date:   Sat, 15 Jul 2023 14:50:41 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_varada@quicinc.com
Subject: Re: [PATCH 2/2] rpmsg: glink: change intent work queue type
Message-ID: <5tll34ehog7smsenaskcd7j2uqgcpgmobvortf6no4ebu6ylqr@vkqtajhuri2t>
References: <20230607121731.26958-1-quic_mmanikan@quicinc.com>
 <20230607121731.26958-3-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607121731.26958-3-quic_mmanikan@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 05:47:31PM +0530, Manikanta Mylavarapu wrote:
> QDSP6 will clear heap memory once it's received
> RX_DONE event from APPS. Under heavy cpu load
> intent worker thread not able to get cpu slot
> because it's bound to kernel global work queue.
> Due to this QDSP6 firmware faces OOM and it leads
> to Q6 crash. Changing intent work queue type to
> UNBOUND workqueue ensures intent worker thread
> will be executed as early as possible.
> 

This commit message is specific and the motivation is clear, thank you!


I was hoping to move the rx_done generation directly to
qcom_glink_rx_data(), but I got side tracked on my verification of my
patches for this.

Please update the alloc_workqueue() and we can merge this first, if I
haven't gotten favourable test results until then.


PS. 75 character commit messages please.

Regards,
Bjorn

> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  drivers/rpmsg/qcom_glink_native.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 6f9a439e5046..c3e076bb863f 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -140,6 +140,7 @@ enum {
>   * @liids:	idr of all local intents
>   * @riids:	idr of all remote intents
>   * @intent_work: worker responsible for transmitting rx_done packets
> + * @intent_wq:	work queue of intent_work
>   * @done_intents: list of intents that needs to be announced rx_done
>   * @buf:	receive buffer, for gathering fragments
>   * @buf_offset:	write offset in @buf
> @@ -169,6 +170,7 @@ struct glink_channel {
>  	struct idr liids;
>  	struct idr riids;
>  	struct work_struct intent_work;
> +	struct workqueue_struct *intent_wq;
>  	struct list_head done_intents;
>  
>  	struct glink_core_rx_intent *buf;
> @@ -231,6 +233,14 @@ static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
>  	INIT_LIST_HEAD(&channel->done_intents);
>  	INIT_WORK(&channel->intent_work, qcom_glink_rx_done_work);
>  
> +	channel->intent_wq = alloc_workqueue("intent_wq", WQ_UNBOUND, 1);
> +	if (!channel->intent_wq) {
> +		pr_err("failed to create %s channel intent work queue\n",
> +		       channel->name);
> +		kfree(channel);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>  	idr_init(&channel->liids);
>  	idr_init(&channel->riids);
>  	kref_init(&channel->refcount);
> @@ -270,6 +280,7 @@ static void qcom_glink_channel_release(struct kref *ref)
>  	idr_destroy(&channel->riids);
>  	spin_unlock_irqrestore(&channel->intent_lock, flags);
>  
> +	destroy_workqueue(channel->intent_wq);
>  	kfree(channel->name);
>  	kfree(channel);
>  }
> @@ -573,7 +584,7 @@ static void qcom_glink_rx_done(struct qcom_glink *glink,
>  	list_add_tail(&intent->node, &channel->done_intents);
>  	spin_unlock(&channel->intent_lock);
>  
> -	schedule_work(&channel->intent_work);
> +	queue_work(channel->intent_wq, &channel->intent_work);
>  }
>  
>  /**
> -- 
> 2.17.1
> 
