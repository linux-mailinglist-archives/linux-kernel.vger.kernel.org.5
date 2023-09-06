Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC87936DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjIFIIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjIFIIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:08:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34CBE56;
        Wed,  6 Sep 2023 01:08:38 -0700 (PDT)
Date:   Wed, 6 Sep 2023 10:08:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693987716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQsFJW/rmJbrYDUykXvzIQ/8e3FNYhD5XlVtRJWM5Kg=;
        b=FEBRc1UY1XN7TDZ4ASAUqF2PEl4NJSQAASSeDvbJQyB+RyBXO1q+epmJLxTVfJF82bXhaK
        Yv+q1rVfr6D1L82ieH1xXPTthjjNfiKkFIywqe/MY/uzAPsjvx0l+KsPOZO6w6cAcuYXt6
        5BMNU6uL3WtEB3YTQiFUSm24UKVc+bX7EWOdn/7BUYKQ7ReOFioxtRQzXOGqNd0z+dh1PF
        Na6kHdjZo0hcSRvsY90LbxyMZnQbULqebnl4Ttu3v6HBtrTG+mPGRI2ktuImOiyn0asxAv
        ESxz72c16MTfUUnl+vX3sMMjrv3xTB3j6rnMbKdlyW3o+XtbWJSSp2GAzHOZwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693987716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQsFJW/rmJbrYDUykXvzIQ/8e3FNYhD5XlVtRJWM5Kg=;
        b=GWP2ke0rDlPZWs/IDkA4AjPQpQu8Ix7Op/D4Uo20Nl1nXSw9rUfHlxDqwcYjZVyeREB/4c
        ANTljK0V295VEfBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
        linyunsheng@huawei.com
Subject: Re: [PATCH net v1] octeontx2-pf: Fix page pool cache index
 corruption.
Message-ID: <20230906080831.k5HXMqlN@linutronix.de>
References: <20230906033926.3663659-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230906033926.3663659-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-06 09:09:26 [+0530], Ratheesh Kannoth wrote:
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 8511906cb4e2..5bba1f34e4f6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1082,38 +1070,16 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u1=
6 qidx)
>  static void otx2_pool_refill_task(struct work_struct *work)
>  {
=E2=80=A6
> +	napi_schedule(wrk->napi);

This will delay NAPI until "some random point in the future" for
instance if an interrupt on _this_ CPU fires. You only set the softirq
state and never enforce it here. This works as intended if invoked from
an IRQ but this here a worker/ process context.

You can either put local_bh_disable()/enable() around napi_schedule() or
use it from a timer callback and skip the worker.

Sebastian
