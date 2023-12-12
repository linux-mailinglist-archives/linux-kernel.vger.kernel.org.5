Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9F380F670
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377107AbjLLTTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjLLTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:19:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5F2AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:19:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CECC433C7;
        Tue, 12 Dec 2023 19:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702408748;
        bh=VxUoH5W5QC5FMheEWzI9jkp0t9473bp8pPVB/cabv8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EJnt4hSjmhNoJdTQBC3pAIpLXXR60HMnuj7GY98aRzTVrTSMiSR7FQbNGgf04MACC
         UEJ1I75/BzQawTP6amcrMVoo0fzVVH7OlW78OY6upyqPsEBEtzu9wXuOK4cq0IQcMB
         FY1j3CqXTyoH0rLYlxeUcXAkSHJ694vOd9CmFZA1LTtN2Aw6hvxBwfuCRR2ZBcUic2
         vZakpo64JMHxfEPwV5B47K7y5b12bTDGFDkhaPDhK97iLDYpjLBuEOBVsbTlMpDQM5
         eqanzn7KJPQhcAk5KQfqIiu+NkkKPr66qK4V6//XNdTbTj6zMhgO0WG4zrZO7B8kbR
         oY8UG/MKLO46w==
Date:   Tue, 12 Dec 2023 11:19:07 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 09/13] rtase: Implement pci_driver suspend
 and resume function
Message-ID: <20231212111907.543e8f04@kernel.org>
In-Reply-To: <20231208094733.1671296-10-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
        <20231208094733.1671296-10-justinlai0215@realtek.com>
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

On Fri, 8 Dec 2023 17:47:29 +0800 Justin Lai wrote:
> +static int rtase_suspend(struct device *device)
> +{
> +	struct net_device *dev = dev_get_drvdata(device);
> +
> +	if (netif_running(dev)) {
> +		netif_stop_queue(dev);
> +		netif_device_detach(dev);

detach stops the queue, you don't have to call both

> +		rtase_hw_reset(dev);
