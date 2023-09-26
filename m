Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0243D7AF1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjIZR2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjIZR2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:28:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451EEDC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rG/CnIilUKIx4ZX6uO8pwj0iKoMPMtAHHOSA84Y3klc=; b=oL6KmepzwMN9ufGtDVxIlPLOip
        Bk9seHkrZWGWXfzn+vKMHLBSAw85EFiILd4DQw0SqVrMxBA2na3iCTVMJnbhGa+ykUY2jbeKuZ4wI
        w0nDkRSDQVU+NF8Bc1j+VIyUsGv5/xo4ZOK9KRejACxssMau/JA0LIyt2zAYCsEEjIgTZxC/pggej
        zVMfDP+GNNgMHBjojyriUnMWYI+dtctGLwat71ADQNTHUAyCw0V18eJFV9GQbvuGJ+RA7CVHwo0MT
        H/sPvlLIrZOWvRCrIu/8LBHZto57abnEpwSDzHEQqNecEpBD6rwPu/eLZJoEhY4RQcGoEZqf7rjey
        4QFknl2w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55628)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qlBrN-0002jh-1F;
        Tue, 26 Sep 2023 18:28:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qlBrM-0000aU-Nt; Tue, 26 Sep 2023 18:28:32 +0100
Date:   Tue, 26 Sep 2023 18:28:32 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     patches@armlinux.org.uk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: make <linux/uaccess.h> self-contained for ARM
Message-ID: <ZRMUwGbWKN6OgMzM@shell.armlinux.org.uk>
References: <20230926172253.73204-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926172253.73204-1-masahiroy@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 02:22:53AM +0900, Masahiro Yamada wrote:
> When I compiled the following code for ARM, I encountered numerous
> errors.
> 
> [Test Code]
> 
>     #include <linux/compiler.h>
>     #include <linux/uaccess.h>
> 
>     int foo(int *x, int __user *ptr)
>     {
>             return get_user(*x, ptr);
>     }
> 
> To fix them, make some asm headers self-contained:
> 
>  1. In arch/arm/include/asm/traps.h, include <linux/init.h> for __init,
>     and <linux/linkage.h> for asmlinkage.

Please drop the __init marking instead of adding linux/init.h, it's
not necessary.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
