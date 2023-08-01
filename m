Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D876576AAC7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjHAIVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjHAIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E5D1AD;
        Tue,  1 Aug 2023 01:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A21D614B1;
        Tue,  1 Aug 2023 08:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AFFC433C8;
        Tue,  1 Aug 2023 08:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690878076;
        bh=SdSpzQrfWhfHyrXQhEcCm9xTj2Z7bwVFrrUBGSfQ6jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h44OEA5UrUyZLkbqP0xodxVwaBmCmf+8GcZO402BbcusWHfvdSiqb8Krd8BncNsrS
         dOfNuPvvR9TJOOl2qIqa6e5GaZkz7iUFi/V8f7CabPalqmVeVhuTJ8jUquY7d7htAy
         N3s0MSMa5h9+N/p8XYF9LlTZCgKutfsIQfiJQAzM=
Date:   Tue, 1 Aug 2023 10:21:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     stable@vger.kernel.org, M A Ramdhan <ramdhan@starlabs.sg>,
        sashal@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hailmo@amazon.com,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 4.19] net/sched: cls_fw: Fix improper refcount update
 leads to use-after-free
Message-ID: <2023080159-status-barracuda-99dd@gregkh>
References: <20230727174629.55740-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727174629.55740-1-sj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 05:46:28PM +0000, SeongJae Park wrote:
> From: M A Ramdhan <ramdhan@starlabs.sg>
> 
> [ Upstream commit 0323bce598eea038714f941ce2b22541c46d488f ]
> 
> In the event of a failure in tcf_change_indev(), fw_set_parms() will
> immediately return an error after incrementing or decrementing
> reference counter in tcf_bind_filter().  If attacker can control
> reference counter to zero and make reference freed, leading to
> use after free.
> 
> In order to prevent this, move the point of possible failure above the
> point where the TC_FW_CLASSID is handled.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: M A Ramdhan <ramdhan@starlabs.sg>
> Signed-off-by: M A Ramdhan <ramdhan@starlabs.sg>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> Message-ID: <20230705161530.52003-1-ramdhan@starlabs.sg>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  net/sched/cls_fw.c | 10 +++++-----

Both now queued up, thanks.

greg k-h
