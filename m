Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E966B7DC244
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjJ3WFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjJ3WFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:05:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7950C2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:05:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438ADC433C7;
        Mon, 30 Oct 2023 22:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698703513;
        bh=iEkRHFptr98Q062m7vogCShQu85MNAHIfzPgSXdjeNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CvZxCENWXz5ZUEI/xbR/udkJHnOtQDAxim1a4yu2bTaarFGYxgs0xgwyYTLMuYEZo
         lY6V0Ecqc5xz+cJGIQIJUFwliy4qIzOGll1Qv5SkQ07rx1jjs5DFENWbf8RqxRaXp7
         vCaQI/AWu/p0pDYUqlJFv+/A0BdONKPbdIFWG9GPVOPiwYMEfoSbrrK8cylcgVOfuc
         zOTudbDBy0pwxde6in1B6mbR4Ni0+H7msyFGpjHdZxrSWBxljeOd7XOnSO5oU+ICfG
         bChwNNj93Bq9A0XK4EEna0o1wdHUqSGOnqhrRwXxuYDnn0NYcNtS7Gj46ZQpKCU6no
         +MxNHxOaEsO4A==
Date:   Mon, 30 Oct 2023 15:05:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Frederik Deweerdt <deweerdt.lkml@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Add missing NULL check in
 `tls_strp_check_queue_ok`
Message-ID: <20231030150512.254220a5@kernel.org>
In-Reply-To: <ZUAmyb44sy309V6H@urola>
References: <ZUAmyb44sy309V6H@urola>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 14:57:29 -0700 Frederik Deweerdt wrote:
> We see `tls_strp_check_queue_ok` running into a NULL deref when
> evaluating `TCP_SKB_CB(skb)->seq`.
> 
> This commit attempts to address the issue by exiting the loop if
> skb->next is NULL, and has proven stable under load.
> 
> That said i don't understand the code enough to convince myself that
> the NULL check is indeed required, and i would be happy gather data if
> that's useful.

Hm. Can you share the decoded stack trace?
