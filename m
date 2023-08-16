Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C805377E5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344270AbjHPPzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjHPPyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:54:41 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB220DF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:54:38 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id B5943100D943F;
        Wed, 16 Aug 2023 17:54:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8B34D5D2FF; Wed, 16 Aug 2023 17:54:35 +0200 (CEST)
Date:   Wed, 16 Aug 2023 17:54:35 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] driver core: shut down devices asynchronously
Message-ID: <20230816155435.GA18922@wunner.de>
References: <20230816154518.3487-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816154518.3487-1-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:45:18AM -0500, Stuart Hayes wrote:
> Attempt to shut down devices asynchronously, by making a tree of devices with
> associated work and completion structs, to ensure that child devices are shut
> down before parents.
> 
> This can dramatically reduce system shutdown/reboot time on systems that have
> devices that take many seconds to shut down, such as some NVMe drives.  On once
> system tested, the shutdown time went from 11 minutes before the patch to 55
> seconds with the patch.
> 
> The code could be simplified by adding the work and completion structs to
> struct device, but it may make more sense to not burden it with that when there
> is likely enough memory to allocate this at shutdown time, and if there isn???t,
> it just falls back to the current synchronous shutdown.

Please wrap the commit message at 72 chars.

Is there a particular reason why you're not using the infrastructure
provided by kernel/async.c and <async.h>, such as async_schedule()?
It wraps all the work_struct plumbing and also has helpers to await
completion.  I imagine using that might reduce LoC in this patch.

Thanks,

Lukas
