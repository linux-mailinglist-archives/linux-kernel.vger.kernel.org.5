Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288257F84E0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbjKXTqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKXTqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:46:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF63D4E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:46:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A37C433C8;
        Fri, 24 Nov 2023 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700855213;
        bh=Lh3HwY/b7OgZdLgEYvxR/BK2codpIRRolyXRRFsmkA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1TeqK+R7WpZrlSDMwr2q5pUslqvDxUZQ/UjxaJG+a+2rZfxsGXQNrT1gBW/xcg3d
         feK85zHpN7c7s/J3L4BZY4s2cA12sCo1tZooLL/uUINxBnte0yNzB5tKcEUnJIIzBE
         dQnZNWfWK6iDwM+O19xWtf5vMHsVzVU2FWUEdS9fSdbjh6V1DsTH4k5fw+TRbQQ0nf
         1aXJ55F30UiQwH8Hn3BRQl8vU5RxrySYTod89qXmE3ZC/5x4zNd3j3XC96nr9aYH3H
         FB7zwZ+dS2iFk0yunM1KYvxTWoySec2R9fGQCplSue259exrB4xj8nui3qSPromI0v
         ZIx0g3lb7WiRQ==
Date:   Fri, 24 Nov 2023 19:46:46 +0000
From:   Simon Horman <horms@kernel.org>
To:     Alexey Makhalov <amakhalov@vmware.com>
Cc:     linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.co,
        bp@alien8.d, mingo@redhat.com, tglx@linutronix.de,
        zackr@vmware.com, timothym@vmware.com,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, netdev@vger.kernel.org,
        richardcochran@gmail.com, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, linux-graphics-maintainer@vmware.com,
        pv-drivers@vmware.com, namit@vmware.com, akaher@vmware.com,
        jsipek@vmware.com
Subject: Re: [PATCH 4/6] input/vmmouse: Use vmware_hypercall API
Message-ID: <20231124194646.GW50352@kernel.org>
References: <20231122233058.185601-1-amakhalov@vmware.com>
 <20231122233058.185601-5-amakhalov@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122233058.185601-5-amakhalov@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 03:30:49PM -0800, Alexey Makhalov wrote:
> Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
> Eliminate arch specific code. No functional changes intended.
> 
> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>

Hi Alexey,

it is not strictly related to this patch, but I notice than an x86_64
allmodconfig build with W=1 using gcc-13 fails to compile this file.

It appears that the problem relates to both priv->phys and
psmouse->ps2dev.serio->phys being 32 bytes.


drivers/input/mouse/vmmouse.c: In function ‘vmmouse_init’:
drivers/input/mouse/vmmouse.c:455:53: error: ‘/input1’ directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Werror=format-truncation=]
  455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
      |                                                     ^~~~~~~
drivers/input/mouse/vmmouse.c:455:9: note: ‘snprintf’ output between 8 and 39 bytes into a destination of size 32
  455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  456 |                  psmouse->ps2dev.serio->phys);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

...
