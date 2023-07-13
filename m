Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3F2751EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjGMKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjGMKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:16:39 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F63F270F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UXKb8ReKi6vjKGSullcaPdOC0k6TBghM4uyawRsMGf0=; b=MPR7gAXtNr5fuBgqu+/UmCcQtu
        w0XvQvZRF+PO9lNSCvZMkZw/BypcOkHFC+l/CB7oDPzbnwJbOoPOixNtLZ8ep2rIiAkCdIMQFNULW
        fY2GkDfHBdb5N72KIhcyPYrZp1i9K2Ep6ju6KQyADiRL5IVJyhobf5BcdZfL7Huuf2W533vAyIiWC
        zvoJLufT3ij6FcUlJew07+L2W6kEZDC/9aGQwQIAMxudLBsa5viLr3yK5sC1hU5gIgNsAXvhRjhF8
        Ps3FFXU6KuSuFWAxefd1/bQzcr4+5UxkePVyL3GkVwybAdw83P1fZNlJRtuaQp7UiqGuydAqXK38q
        P8aEXmhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57662)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qJtMy-0006SO-1L;
        Thu, 13 Jul 2023 11:16:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qJtMy-00064D-9g; Thu, 13 Jul 2023 11:16:20 +0100
Date:   Thu, 13 Jul 2023 11:16:20 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     hanyu001@208suo.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] arm: mm: replace snprintf in show functions with
 sysfs_emit
Message-ID: <ZK/O9Dc2aYtXEKHd@shell.armlinux.org.uk>
References: <tencent_EFB5DEE75502CBD51C95CFE33D443DB41608@qq.com>
 <72204230a061f7d5bf19f09d524203ce@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72204230a061f7d5bf19f09d524203ce@208suo.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 06:06:15PM +0800, hanyu001@208suo.com wrote:
> coccicheck complains about the use of snprintf() in sysfs show functions.
> 
> Fix the coccicheck warning:
> WARNING: use scnprintf or sprintf.
> 
> ./arch/arm/mm/cache-l2x0-pmu.c:346:8-16: WARNING: use scnprintf or sprintf
> 
> Signed-off-by: ztt <1549089851@qq.com>
> ---
>  arch/arm/mm/cache-l2x0-pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
> index 993fefdc167a..d20626451a2e 100644
> --- a/arch/arm/mm/cache-l2x0-pmu.c
> +++ b/arch/arm/mm/cache-l2x0-pmu.c
> @@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device *dev,
>      struct l2x0_event_attribute *lattr;
> 
>      lattr = container_of(attr, typeof(*lattr), attr);
> -    return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
> +    return scnprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);

This only serves to shut up a warning. On 32-bit ARM, there is utterly
no way what so ever that "config=0x%x\n" could ever overflow 4096 bytes,
or even 32 bytes!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
