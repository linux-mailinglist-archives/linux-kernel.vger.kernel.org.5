Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466DA8137B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444140AbjLNRLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjLNRLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:11:14 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552FD12D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Json6Gx+5VDyz1RjY7w3s3YgqEG8PM6lzHzCKs9Ls0E=; b=e/vlEyU1pI3gTBvVXJlTCSqfUD
        FLOWAEnjxbUgTZZ2P3QJk1Za8f5xI3OVoAm0zbrT+lQESXRRuqclT+zSSn6obJMe4agNr6+fNfohL
        aPYtEn873AytOu2aCGW3pWWwWWAqmG2I4kjfMhQGsDhP1/FhlLiBqkTa66eboYUJARbKfzXIeD6Jx
        BGGkf/Um2nyGezHqKiN0f0SfJ+dT/Sj1ebFGgu040qpuQL2Aok3LdcGMqgfRxLgAru13Xqb9WCFxJ
        kFKMTmoV1Dc6kcafXZ7Pq1V2zbxz/A5d5adMhLuI0BX++c1DorL3bLyZsWB1iqT34Ogn8xwr8ONj+
        HJgnyx5Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49218)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rDpEg-0001jv-0J;
        Thu, 14 Dec 2023 17:10:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rDpEc-0002ix-1N; Thu, 14 Dec 2023 17:10:54 +0000
Date:   Thu, 14 Dec 2023 17:10:54 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     chenguanxi11234@163.com, arnd@arndb.de, cgel.zte@gmail.com,
        chen.haonan2@zte.com.cn, gregkh@linuxfoundation.org, jgg@ziepe.ca,
        jiang.xuexin@zte.com.cn, jroedel@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rppt@kernel.org, willy@infradead.org, yang.guang5@zte.com.cn
Subject: Re: [PATCH linux-next] ARM/dma-mapping: replace kzalloc() and
 vzalloc() with kvzalloc()
Message-ID: <ZXs3HmwFP9Qb0Jxj@shell.armlinux.org.uk>
References: <CACRpkdap4LUbMcKv_zi=25A-SZf0DJhXiyR1zn0PfuR+b=3NfA@mail.gmail.com>
 <20231213143954.2541-1-chenguanxi11234@163.com>
 <CACRpkdb-pARMSCe_kugLOFriSrwuQVXJ3L+6TnsnmDNedowDRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb-pARMSCe_kugLOFriSrwuQVXJ3L+6TnsnmDNedowDRw@mail.gmail.com>
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

On Thu, Dec 14, 2023 at 02:17:51PM +0100, Linus Walleij wrote:
> On Wed, Dec 13, 2023 at 3:41 PM <chenguanxi11234@163.com> wrote:
> 
> > >Looks good to me:
> > >Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > >Please put this patch into Russell's patch tracker.
> >
> > Hello, I would like to ask, do you mean to have
> > me CC the patch email to Russell?I don't really
> > understand what patch tracker means.Thank you.
> 
> This is Russell's patch tracker:
> https://www.armlinux.org.uk/developer/patches/
> 
> Create an account, read the help text, you can submit patches
> using a web interface or through mail.

No need to create an account if submitting by email, that will happen
automatically on the successful receipt of a patch, except of course
with password access blocked until a "forgotten password" thing is
done.

However, well worth reading the bit about adding a KernelVersion: tag
somewhere in the email!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
