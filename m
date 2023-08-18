Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E578780E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377827AbjHROl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377791AbjHROl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:41:26 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA0313D;
        Fri, 18 Aug 2023 07:41:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96625240005;
        Fri, 18 Aug 2023 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692369683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vdf4aayJ0vPBWLh4X8ERuVknKut4vB+x850UDEbCdew=;
        b=M5ywLWrJ9DO27wEEih+ZiVSahP+0h+tFT0E0O8vzpJBNotTUAf/98HltMgG/GzDva8Ktmq
        D62mYb6hV8sDwAipA0U6OiZRhvxWGYKxHbFP0YKLclLA80PpRTaVcaFXivtRQ7iUkdkbYL
        1Ae3yDkxB/+o40rjEmaBlF+DcRwI2YLyorbHBDAGbgkWHbygQMS0f+uowTK8959Zzqp3Jk
        bFuVpUptuWAFQ32fgGtTATOU5fAKAknino+FWe8ISEZD86ioYWTrm5k3ct5W2MwPBwA5Hx
        nJWT5om1C5g0oN4s8LkUD6BQ5qtCS/Ra9Ww7XhtoFUYXywoZlq/IxoYqMCTgWg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdalam@quicinc.com, quic_srichara@quicinc.com,
        dan.carpenter@linaro.org
Subject: Re: [PATCH 07/10] mtd: rawnand: qcom: Unmap sg_list and free desc within submic_descs()
Date:   Fri, 18 Aug 2023 16:41:22 +0200
Message-Id: <20230818144122.145966-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805174146.57006-8-manivannan.sadhasivam@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bb7a103d4594bbec8fc74d10da2dd227e21cae35'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-08-05 at 17:41:43 UTC, Manivannan Sadhasivam wrote:
> There are two types of dma descriptors being used in this driver allocated
> by, prepare_bam_async_desc() and prep_adm_dma_desc() helper functions.
> These functions map and prepare the descriptors to be used for dma
> transfers.
> 
> And all the descriptors are submitted inside the submit_descs() function.
> Once the transfer completion happens, those descriptors should be unmapped
> and freed as a part of cleanup.
> 
> Currently, free_descs() function is doing the said cleanup of descriptors.
> But the callers of submit_descs() are required to call free_descs() in both
> the success and error cases.
> 
> Since there are no other transactions need to be done after submit_descs(),
> let's just move the contents of free_descs() inside submit_descs() itself.
> 
> This makes sure that the cleanup is handled within the submit_descs()
> thereby offloading the cleanup part from callers.
> 
> While at it, let's also rename the return variable from "r" to "ret".
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
