Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F057F0D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjKTIX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjKTIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:23:54 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90B795
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:23:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C71B467373; Mon, 20 Nov 2023 09:23:46 +0100 (CET)
Date:   Mon, 20 Nov 2023 09:23:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Jens Axboe <axboe@kernel.dk>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        randyj@purestorage.com, hcoutinho@purestorage.com
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Message-ID: <20231120082346.GA11622@lst.de>
References: <20231115185439.2616073-1-yzhong@purestorage.com> <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk> <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com> <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com> <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com> <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com> <20231117132846.GB7867@lst.de> <ZVeW-8cNNVOvNdaR@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVeW-8cNNVOvNdaR@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 09:38:19AM -0700, Keith Busch wrote:
> The effects log is per-CSI so different command sets won't create
> conflicts.

True.  But that wasn't the point anyway.  It is that different
controllers might expose very different namespaes with different
capabilities.  Maybe a controller with HDD namespaces vs flash might
be a better example.

> Namespaces that are not shared don't really matter here because this
> problem is unique to mulitpath.

Indeed.

> It doesn't make sense for effects logs to be different per-controller
> for the same shared namespace. The spec doesn't seem to explicitly
> prevent that, but hints that all hosts should be seeing the same thing
> no matter which controller they're connected to:

Also agreed as already indicated in the past mail.
