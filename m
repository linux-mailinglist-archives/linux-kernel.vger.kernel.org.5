Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01A7DBCC1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjJ3PgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjJ3Pf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:35:58 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C0B3;
        Mon, 30 Oct 2023 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WE1tsrC5nD1he3EQ3Z3HGaPKaykIF9HkdVI/EJRhi6c=; b=LV7D/IWyq2Mw7vTdVg1EkrxxC1
        fzJ5yRFzlAYj4fcJjzZtnGfpsXsCDVpO/UNR4YqP7qxjUUybZ7nZGyfZdxNL8kBxxQkTNHp25yUtf
        2KJzm3FlMnAL5p+Qfjj1+ikr/MrjmBoYN+ASKZakexZnFd/Jo54EhdMWhyKesftBsfU5qrKyX8seW
        2UDWVakMncsXCtbJFuOdiZGI2aEPV89Xh1oXklyVX3NGQmGLi6KaY+dx3jnwOaLBVjTYN0oid1QbQ
        0DQd3kQw+sLq/tI01uxlHkEV+3NVgkTq8vOAmgPzCLveX2HVgoTtA134mT1CT67pbwFxd0FsFsTiv
        mF5Xt6Vw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53860)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qxUIh-0001q0-2T;
        Mon, 30 Oct 2023 15:35:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qxUIg-00047C-OV; Mon, 30 Oct 2023 15:35:34 +0000
Date:   Mon, 30 Oct 2023 15:35:34 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Simon Glass <sjg@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: boot: Support Flat Image Tree
Message-ID: <ZT/NRvLkvR8uuP5+@shell.armlinux.org.uk>
References: <20231026072628.4115527-1-sjg@chromium.org>
 <20231026072628.4115527-4-sjg@chromium.org>
 <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
 <CAFLszThguWT0u0R0EHfpBro0f-pWDwLOGk+5pQZEVhFYNKH8fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThguWT0u0R0EHfpBro0f-pWDwLOGk+5pQZEVhFYNKH8fQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 05:46:12AM +1300, Simon Glass wrote:
> Hi Masahiro,
> 
> Sure, but that is a separate issue, isn't it? We already support
> various boot targets in arm64 but not one that includes the DTs, so
> far as I can see. The old arm 'uImage' target is pretty out-of-date
> now.

Does that mean it can be removed? ;)

I've NAK'd FIT support on 32-bit Arm in the past, and I remain of the
opinion that boot loader specific packaging of the kernel should not
be in the kernel but should be external to it - even more so given the
multi-platform nature of 32-bit Arm kernels.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
