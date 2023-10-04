Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C967B779A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjJDGFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjJDGFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:05:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9834CA7;
        Tue,  3 Oct 2023 23:05:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA188C433C8;
        Wed,  4 Oct 2023 06:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696399513;
        bh=YPjhyhXTHc/JSPJaMPXxVEW44XmFbXt6asYBrVFetjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlZwdsxFs9UMZfcMpU6G97Yr5hUUr005ha3ia1L5hCHOEX1++ZoHT2PJ9zzSzAUg2
         jsQYHAMnLCi2djAal5jDWydHI187M2ygPvvwNhfEZ95AWZOAMbSQn+JFDEfxWowI01
         R57xSqrWXE78rJ5e6ZEfvZoU6VFdhZNopsNioEXk=
Date:   Wed, 4 Oct 2023 08:05:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     Lee Jones <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com" 
        <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <2023100421-negotiate-stammer-1b35@gregkh>
References: <20231003170020.830242-1-lee@kernel.org>
 <2023100320-immorally-outboard-573a@gregkh>
 <DB9PR10MB588170E923A6ED8B3D6D9613E0CBA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB588170E923A6ED8B3D6D9613E0CBA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 05:59:09AM +0000, Starke, Daniel wrote:
> > Daniel, any thoughts?
> 
> Our application of this protocol is only with specific modems to enable
> circuit switched operation (handling calls, selecting/querying networks,
> etc.) while doing packet switched communication (i.e. IP traffic over PPP).
> The protocol was developed for such use cases.
> 
> Regarding the issue itself:
> There was already an attempt to fix all this by switching from spinlocks to
> mutexes resulting in ~20% performance loss. However, the patch was reverted
> as it did not handle the T1 timer leading into sleep during atomic within
> gsm_dlci_t1() on every mutex lock there.
> There was also a suggestion to fix this in do_con_write() as
> tty_operations::write() appears to be documented as "not allowed to sleep".
> The patch for this was rejected. It did not fix the issue within n_gsm.
> 
> Link: https://lore.kernel.org/all/20221203215518.8150-1-pchelkin@ispras.ru/
> Link: https://lore.kernel.org/all/20221212023530.2498025-1-zengheng4@huawei.com/
> Link: https://lore.kernel.org/all/5a994a13-d1f2-87a8-09e4-a877e65ed166@kernel.org/

Ok, I thought I remembered this, I'll just drop this patch from my
review queue and wait for a better solution if it ever comes up as this
isn't a real issue that people are seeing on actual systems, but just a
syzbot report.

thanks,

greg k-h
