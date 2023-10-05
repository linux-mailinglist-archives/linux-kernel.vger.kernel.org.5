Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3F67BA2CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjJEPrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjJEPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:46:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF53661D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:03:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7865C32795;
        Thu,  5 Oct 2023 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696508268;
        bh=lt8rgcQEJlDrGU6JPLN6b36Bd1lxVPb7SqK2tFsmxNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wy1ZGUj8g0lZuAa/Mf5s6ynt8YbAA2rzcibqUjdO7aa9CUefrurLP6t6s45dA1Py4
         baG81XSuv32pJeeVAjFstIrcutK6B75HC5W1dmsOVoYsxnOxyh0ywDrETvtEPNco3C
         9Hj1KJN5u2Qf+PpJCUO5hTvx2BiG/Ls8oU4sauehQIY3nz+D0aicUDotR0DpbjUBoe
         bdhnPMf7JgVwxlFb+T5vUIX5FL+dT6gjzSIIOqm7dqDRfOFIdeB7iPObGfXbZtDeLH
         Y4ZH1t5ByOOOO4cYAreqSrDH0wGXgBpB6WoRvd08tTgZwiWERsQvxt31BZUAvm1DRf
         DWJCziqm3INHQ==
Date:   Thu, 5 Oct 2023 14:17:43 +0200
From:   Simon Horman <horms@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>,
        =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 5/5] r8152: Block future register access if register
 access fails
Message-ID: <ZR6pZ5R14xHkW3zT@kernel.org>
References: <20231004192622.1093964-1-dianders@chromium.org>
 <20231004122435.v2.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004122435.v2.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 12:24:42PM -0700, Douglas Anderson wrote:

...

> @@ -9784,7 +9904,29 @@ static int rtl8152_probe(struct usb_interface *intf,
>  	else
>  		device_set_wakeup_enable(&udev->dev, false);
>  
> -	netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
> +	mutex_lock(&tp->control);
> +	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
> +		/* If the device is marked inaccessible before probe even
> +		 * finished then one of two things happened. Either we got a
> +		 * USB error during probe or the user already unplugged the
> +		 * device.
> +		 *
> +		 * If we got a USB error during probe then we skipped doing a
> +		 * reset in r8152_control_msg() and deferred it to here. This
> +		 * is because the queued reset will give up after 1 second
> +		 * (see usb_lock_device_for_reset()) and we want to make sure
> +		 * that we queue things up right before probe finishes.
> +		 *
> +		 * If the user already unplugged the device then the USB
> +		 * farmework will call unbind right away for us. The extra

Hi Douglas,

As you are planning to re-spin anyway: farmework -> framework

> +		 * reset we queue up here will be harmless.
> +		 */
> +		usb_queue_reset_device(tp->intf);
> +	} else {
> +		set_bit(PROBED_WITH_NO_ERRORS, &tp->flags);
> +		netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
> +	}
> +	mutex_unlock(&tp->control);
>  
>  	return 0;
>  
> -- 
> 2.42.0.582.g8ccd20d70d-goog
> 
