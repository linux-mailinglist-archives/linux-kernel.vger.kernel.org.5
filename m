Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81D57DEBF0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348503AbjKBEih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbjKBEig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:38:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4444DA6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 21:38:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6344BC433C8;
        Thu,  2 Nov 2023 04:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698899913;
        bh=0AuTmcgzxAIiWFtDkxCVvVBcBp3v8F+NagoSXD+wt40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pnTtKefvBCEJADqaRG5dPwiI+9is4rwcSTWQ4e8sBa21wJFhHccesWg8NlIankZnW
         AZui+UwDszoQCXzOEL7p+6mdvSoD6Q4TqmnZUNe+Hi9R+reVcdxjzRPGxy8K/5SAXU
         xVrKfDtv/WsWjXpimRPvrFl/vn5xa8Ua32ipv9gdCKgXqqTmAYua8Nn4/t2K6AzxjI
         9h2lRptq37Y4yifH1vnZ7GpJYBf+hW6+nc09oxM0RyOrLnfYKCoufqzg9h1EDJ8DJt
         57SOAbIidmwFU2VwLAUsJ8BaBQI5ZxaRA/rKJmRv4fYwjoVDFw3lPlGBK4VrBQETBz
         bf9QCnJdc96Xg==
Date:   Wed, 1 Nov 2023 21:38:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ren Mingshuai <renmingshuai@huawei.com>
Cc:     <caowangbao@huawei.com>, <davem@davemloft.net>,
        <khlebnikov@openvz.org>, <liaichun@huawei.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <oneukum@suse.com>, <yanan@huawei.com>
Subject: Re: [PATCH] net: usbnet: Fix potential NULL pointer dereference
Message-ID: <20231101213832.77bd657b@kernel.org>
In-Reply-To: <20231101125511.222629-1-renmingshuai@huawei.com>
References: <20231101123559.210756-1-renmingshuai@huawei.com>
        <20231101125511.222629-1-renmingshuai@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 20:55:11 +0800 Ren Mingshuai wrote:
> >23ba07991dad said SKB can be NULL without describing the triggering
> >scenario. Always Check it before dereference to void potential NULL
> >pointer dereference.  
> I've tried to find out the scenarios where SKB is NULL, but failed.
> It seems impossible for SKB to be NULL. If SKB can be NULL, please tell
> me the reason and I'd be very grateful.

What do you mean? Grepping the function name shows call sites with NULL
getting passed as skb.
