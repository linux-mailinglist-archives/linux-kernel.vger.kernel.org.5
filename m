Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1AD753A18
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjGNLtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjGNLtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:49:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36752D49;
        Fri, 14 Jul 2023 04:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689335339; x=1720871339;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qtEgTm9tngU+qYi53Kkv3Oxf3bJUI65XM2fvQNzEnfw=;
  b=csgssygYSg62Ua6qOmh+GmglGfm4OVL2+i0Ep65spEG2IPW+m35DkkAw
   KYiXxEtwj79lme8Ma7TvJjzpG7deUbwJI9CuF2Y251whnEaQFPm5N/95p
   phnEWkVGzRBX7HKhvIYfIxBN5yU3iaTHYaNLZf5lVTflQyeDpNpER9Xoy
   NsLwWtTBS039CWitwLhezVK/H1hjb4tf0ZDwCByOCAtNsY9MnM22QUOew
   oTbeIJiWXNkculVP3TPkvYtyQCIH9EcJSbWRLJJJS2v1lgxnacFibUbYn
   sOiylBC+OifQ3G/zyZDl7jaayrYsS4u7NIBjYKkpR1LSPBKM/GjawCDdu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345049878"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="345049878"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1053025722"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="1053025722"
Received: from rchauhax-mobl1.gar.corp.intel.com ([10.249.35.123])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:48:56 -0700
Date:   Fri, 14 Jul 2023 14:48:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     liubin001@208suo.com
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] tty:Insert clk_put before return (clk) to release
 memory
In-Reply-To: <57adb092639743f2619c4765379b3ec7@208suo.com>
Message-ID: <619ba12e-aa3e-6bc9-5326-ade76c18a6d8@linux.intel.com>
References: <tencent_EF85BF6D0EE7D05E10D527FD335467508106@qq.com> <57adb092639743f2619c4765379b3ec7@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023, liubin001@208suo.com wrote:

> 
> tty/serial:Insert clk_put before return (clk) to release memory
> Signed-off-by: Liu Bin <liubin001@08suo.com>
> ---
>  drivers/tty/serial/bcm63xx_uart.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/bcm63xx_uart.c
> b/drivers/tty/serial/bcm63xx_uart.c
> index 55e82d0bf92d..7353b683952d 100644
> --- a/drivers/tty/serial/bcm63xx_uart.c
> +++ b/drivers/tty/serial/bcm63xx_uart.c
> @@ -851,6 +851,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
>          clk = of_clk_get(pdev->dev.of_node, 0);
> 
>      if (IS_ERR(clk))
> +        clk_put(clk);
>          return -ENODEV;

Braces missing... Didn't checkpatch complain about this?

-- 
 i.

