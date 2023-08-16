Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE5677E9F1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345885AbjHPTwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbjHPTwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:52:38 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C015912C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:52:36 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5EFED100D943F;
        Wed, 16 Aug 2023 21:52:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3278675F34; Wed, 16 Aug 2023 21:52:35 +0200 (CEST)
Date:   Wed, 16 Aug 2023 21:52:35 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] driver core: shut down devices asynchronously
Message-ID: <20230816195235.GA15421@wunner.de>
References: <20230816154518.3487-1-stuart.w.hayes@gmail.com>
 <20230816155435.GA18922@wunner.de>
 <653f62d4-277b-7cdb-39ba-03e0e7dfc1c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653f62d4-277b-7cdb-39ba-03e0e7dfc1c0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:42:26PM -0500, stuart hayes wrote:
> On 8/16/2023 10:54 AM, Lukas Wunner wrote:
> > Is there a particular reason why you're not using the infrastructure
> > provided by kernel/async.c and <async.h>, such as async_schedule()?
> > It wraps all the work_struct plumbing and also has helpers to await
> > completion.  I imagine using that might reduce LoC in this patch.
> 
> Not a good one.  Let me look into this, thank you.

A word of caution on async_synchronize_cookie(), it awaits the cookies
*before* the one you're passing into the function, so depending on the
use case it may be necessary to add + 1 to the cookie:

https://lore.kernel.org/intel-gfx/20160621075704.GB1821@nuc-i3427.alporthouse.com/

It's a nasty gotcha.  Just so you're aware of it. :)

Thanks,

Lukas
