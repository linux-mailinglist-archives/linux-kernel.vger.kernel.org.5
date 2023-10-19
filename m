Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC07CEF4D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjJSFrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJSFq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:46:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26098D76;
        Wed, 18 Oct 2023 22:46:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D960F67373; Thu, 19 Oct 2023 07:46:42 +0200 (CEST)
Date:   Thu, 19 Oct 2023 07:46:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: the nul-terminated string helper desk chair rearrangement, was:
 Re: [PATCH] nvme-fabrics: replace deprecated strncpy with strscpy
Message-ID: <20231019054642.GF14346@lst.de>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:48:49PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.

If we want that we need to stop pretendening direct manipulation of
nul-terminate strings is a good idea.  I suspect the churn of replacing
one helper with another, maybe slightly better, one probably
introduces more bugs than it fixes.

If we want to attack the issue for real we need to use something
better.

lib/seq_buf.c is a good start for a lot of simple cases that just
append to strings including creating complex ones.  Kent had a bunch
of good ideas on how to improve it, but couldn't be convinced to
contribute to it instead of duplicating the functionality which
is a bit sad, but I think we need to switch to something like
seq_buf that actually has a counted string instead of all this messing
around with the null-terminated strings.

