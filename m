Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF766759D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjGSSgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGSSg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:36:29 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 57916172E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:36:26 -0700 (PDT)
Received: (qmail 1652203 invoked by uid 1000); 19 Jul 2023 14:36:25 -0400
Date:   Wed, 19 Jul 2023 14:36:25 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, hayeswang@realtek.com, jflf_kernel@gmx.com,
        bjorn@mork.no, svenva@chromium.org, linux-kernel@vger.kernel.org,
        eniac-xw.zhang@hp.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] r8152: Suspend USB device before shutdown when WoL is
 enabled
Message-ID: <3c4fd3d8-2b0b-492e-aacc-afafcea98417@rowland.harvard.edu>
References: <2c12d7a0-3edb-48b3-abf7-135e1a8838ca@rowland.harvard.edu>
 <20230719173756.380829-1-alexandru.gagniuc@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719173756.380829-1-alexandru.gagniuc@hp.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 05:37:56PM +0000, Alexandru Gagniuc wrote:
> For Wake-on-LAN to work from S5 (shutdown), the USB link must be put
> in U3 state. If it is not, and the host "disappears", the chip will
> no longer respond to WoL triggers.
> 
> To resolve this, add a notifier block and register it as a reboot
> notifier. When WoL is enabled, work through the usb_device struct to
> get to the suspend function. Calling this function puts the link in
> the correct state for WoL to function.

How do you know that the link will _remain_ in the correct state?

That is, how do you know that the shutdown processing for the USB host 
controller won't disable the link entirely, thereby preventing WoL from 
working?

Alan Stern
