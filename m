Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3D8080A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjLGGZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGGZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:25:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99545D4B;
        Wed,  6 Dec 2023 22:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oErw/cP3v6K5Ya8MvRoT24q1uLCEk2UvmxpABeanB3I=; b=b7qtNXQAzmhYhQLy1jF6GCwRCH
        QjW3MqinvyJQYA6bgI1bw6zpavs66kYaLy1RrSXUUGZWbRZFOWm57k0vGU1uMa8W1V5TwQHsvoLlz
        8V2tlia9l/FQn58wQKDf6RmDPdmv6Aod5UAAnluBwN50VmzWBeZlqcvt8JW5dn7T4Ir4N4ZT+eAjC
        YqwIg3arRxfy+SN26sSTMoKO0XvyvfUdnmTNUOT9/VPuUvMl2558RWSer1HMtNSnONbwZuoVR6Rfv
        EVBM5vCbrAZojOfmzLZKUYL4y729A4j1WAFr03gocNmYnmeYz15rkDam7nFKFNLefbjO0lWMgrhIF
        zsmoRM9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rB7pW-00Byao-2U;
        Thu, 07 Dec 2023 06:25:50 +0000
Date:   Wed, 6 Dec 2023 22:25:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <ZXFlbn8oaTAS8PaZ@infradead.org>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
 <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com>
 <20231205132452.418722bea8f6878dca88142a@linux-foundation.org>
 <CAKwvOdn=og6h5gVdDCjFDANs3MN-_CD4OZ9oRM=o9YAvoTzkzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn=og6h5gVdDCjFDANs3MN-_CD4OZ9oRM=o9YAvoTzkzw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:39:47PM -0800, Nick Desaulniers wrote:
> Hmm...how does one know that linux/bits.h is the higher-level include
> of asm/bitsperlong.h?

I think this the wrong way of thinking.  In general we should always
avoid including asm/ headers unless there is no other way.  No other
way is not formalized right now, but I think the answer is roughly if
no linux/ headers includes that asm header.  This will probably give
a few wrong results at the moment, but it's probably worth fixing
them up.

