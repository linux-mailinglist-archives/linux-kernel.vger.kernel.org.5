Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE37E2D86
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjKFUD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjKFUDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:03:52 -0500
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [IPv6:2001:41d0:203:375::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8408DD49
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:03:49 -0800 (PST)
Message-ID: <f30438ab-01e4-4847-a72d-5a4107d7ba46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hKWfuOa3Q0szrCKnsOau3qz4CjBKZPrK1uXh9qY6QbE=;
        b=ggrMO68Hc3yQhQ3zVNjiJqUqKRXuOGWP3Q2Tqlpk8/bJrZwMlYl6hCK2QhmMsQ8+Z9SLwx
        HlUdzCtuJildD3g4yc+AY/9PZVZdr1KudBaxlhgtPl3Lc58pwUvOmmMM6ypFTNG/p8EQ6i
        WkWEfOgIbWGdpiRUaCuH8kCD4caSA/8=
Date:   Mon, 6 Nov 2023 23:03:44 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] zram: extra zram_get_element call in
 zram_read_from_zspool()
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
In-Reply-To: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 22:55, Vasily Averin wrote:
> 'element' and 'handle' are union in struct zram_table_entry.

struct zram_table_entry {
        union {
                unsigned long handle;
                unsigned long element;
        };

I do not understand the sense of this union.
From my POV it just makes it harder to check the code because an reviewer doesn't
expect that the zram element can't be used together.
Can I remove this union at all and replace zram_get/set_element calls by zram_get/set_handle instead?

Thank you,
	Vasily Averin
