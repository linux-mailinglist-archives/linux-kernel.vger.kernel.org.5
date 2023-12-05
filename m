Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC018044E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346103AbjLEC3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346547AbjLEC3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:29:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA9BD59
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:27:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB53C433C8;
        Tue,  5 Dec 2023 02:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701743262;
        bh=K7+Z4PmTJherMA+QfJtZKMnSBDi8EWhFiIph/biZs1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GnjCYzEDhafwXJKdGsMy2PneJB0YNeXvuZtnK43lHxTsfsr0O/w/N02fAfPr2x1Dx
         UjJtyt5OUlXmFMVr9Q3zynakR8YrhStg5Oms6+KAnyEsSbF6iqjlfpYfzwuu+V9DBY
         uvz4H7It1TmP6xGEo7C7dmYELcctCR1zAFxfM8oJLsPHo0S9Ft0MsQ8EW6ssDbmeTX
         u0O47vR4EnSbr73fDqCR4Ip8i2rwNt6jcQmxPvtXBjzpZ4QZFsRPlq5UmEHNcrXcs3
         S/sDknYjBde6i87gVOQVOLxE8HOTucdrfDkbKgM/JMtCMEFGLtxPBkMwTw613e544a
         KdGC2/MvZRyLg==
Date:   Mon, 4 Dec 2023 18:27:40 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
        netdev@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] r8152: Choose our USB config with
 choose_configuration() rather than probe()
Message-ID: <20231204182740.62a49a14@kernel.org>
In-Reply-To: <20231201102946.v2.3.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid>
References: <20231201183113.343256-1-dianders@chromium.org>
        <20231201102946.v2.3.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Dec 2023 10:29:52 -0800 Douglas Anderson wrote:
> If you deauthorize the r8152 device (by writing 0 to the "authorized"
> field in sysfs) and then reauthorize it (by writing a 1) then it no
> longer works. This is because when you do the above we lose the
> special configuration that we set in rtl8152_cfgselector_probe().
> Deauthorizing causes the config to be set to -1 and then reauthorizing
> runs the default logic for choosing the best config.
> 
> I made an attempt to fix it so that the config is kept across
> deauthorizing / reauthorizing [1] but it was a bit ugly.
> 
> Let's instead use the new USB core feature to override
> choose_configuration().
> 
> This patch relies upon the patches ("usb: core: Don't force USB
> generic_subclass drivers to define probe()") and ("usb: core: Allow
> subclassed USB drivers to override usb_choose_configuration()")

Acked-by: Jakub Kicinski <kuba@kernel.org>
