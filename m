Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22687763FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGZTgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGZTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:36:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1E919BF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4855C61C9A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84849C433C8;
        Wed, 26 Jul 2023 19:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690400203;
        bh=a/dBC/jlctn/hRQlEtI2zf9XxRF5fYEnjWEaOm+FzpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mEQgcKN+D/YQ069Spdj95yxI9aqV3Ej/dHUdxjPQGwZZOuwRhsTjTN+rZEtGCkNOI
         pOKFzWfPCF8sRpgkcLWZTa09spUIFuWbChS+CzUTlNY/xXB7dZbVRxr4ZMzIi7XugJ
         qzj/gT6gScGnGAANZwSKG9HGyFL2Zm57AJnzMzPE=
Date:   Wed, 26 Jul 2023 12:36:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhu Wang <wangzhu9@huawei.com>
Cc:     <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] rapidio: fix -Wunused-const-variable= warning
Message-Id: <20230726123642.ab3f2c8382dfdb4fb62ae3e5@linux-foundation.org>
In-Reply-To: <20230726101714.169784-1-wangzhu9@huawei.com>
References: <20230726101714.169784-1-wangzhu9@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 18:17:14 +0800 Zhu Wang <wangzhu9@huawei.com> wrote:

> When building with W=1, the following warning occurs.
> 
> drivers/rapidio/rio_cm.c: In function ‘rio_txcq_handler’:
> drivers/rapidio/rio_cm.c:673:7: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]
>    int rc;
> 
> Since the variable "rc" is not used in function 'rio_txcq_handler',
> so we removed it to remove the warning.
> 
> ...
>
> --- a/drivers/rapidio/rio_cm.c
> +++ b/drivers/rapidio/rio_cm.c
> @@ -670,13 +670,12 @@ static void rio_txcq_handler(struct cm_dev *cm, int slot)
>  	 */
>  	if (!list_empty(&cm->tx_reqs) && (cm->tx_cnt < RIOCM_TX_RING_SIZE)) {
>  		struct tx_req *req, *_req;
> -		int rc;
>  
>  		list_for_each_entry_safe(req, _req, &cm->tx_reqs, node) {
>  			list_del(&req->node);
>  			cm->tx_buf[cm->tx_slot] = req->buffer;
> -			rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
> -						  req->buffer, req->len);
> +			rio_add_outb_message(cm->mport, req->rdev, cmbox,
> +					     req->buffer, req->len);
>  			kfree(req->buffer);
>  			kfree(req);

rio_add_outb_message() can fail.  It would be better to appropriately
handle these failures, rather than simply ignoring them.

