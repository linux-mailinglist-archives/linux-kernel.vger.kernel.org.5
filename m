Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C357F3A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjKUXsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjKUXss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:48:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BE4D45
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:48:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF57EC433C8;
        Tue, 21 Nov 2023 23:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700610523;
        bh=IuQ9syHF5a/ttnK8/3v7I9YDeXgz5xrYtfAaCkHYAm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h6zg6XxOGmLyRKK8wojFBLWbsbJAqER2kmK+0GVLbdxv1vzmN6PuLNce1Q6D/wLBt
         3Ka6Vc/UAndkBePbQu3ooUPzWkbUtZ5a0GzQykR2kcVgqiyp/tqZga0uRrrs7m6ABP
         Lspva4iI49ltuy8GSp1DwL6R7b1aGdawhCn+QRdmDegFDUSuIu0J8qWBEB2SgBP0w2
         fNsuM3YuLpeSFsBP9iWXH8IkjoKHCA3i8erCKXcjh8DQbP+Btf5raw6jrgp4f0lgM9
         1jiBWGGdTx7BjjJnQfP70oCshUiTu+SdoxJDlKyHI+tjD9JFlrWDY0EcNL+8HOlC+i
         GdV1LB1Me0lzA==
Date:   Tue, 21 Nov 2023 15:48:41 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, longli@microsoft.com, sharmaajay@microsoft.com,
        leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
        paulros@microsoft.com
Subject: Re: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on HT
 cores
Message-ID: <20231121154841.7fc019c8@kernel.org>
In-Reply-To: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 05:54:37 -0800 Souradeep Chakrabarti wrote:
> Existing MANA design assigns IRQ to every CPUs, including sibling hyper-threads
> in a core. This causes multiple IRQs to work on same CPU and may reduce the network
> performance with RSS.
> 
> Improve the performance by adhering the configuration for RSS, which assigns IRQ
> on HT cores.

Drivers should not have to carry 120 LoC for something as basic as
spreading IRQs. Please take a look at include/linux/topology.h and
if there's nothing that fits your needs there - add it. That way
other drivers can reuse it.
