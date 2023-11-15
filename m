Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C497EC4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbjKOORQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjKOORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:17:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A74E7;
        Wed, 15 Nov 2023 06:17:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9D1C433C8;
        Wed, 15 Nov 2023 14:17:06 +0000 (UTC)
Date:   Wed, 15 Nov 2023 14:17:04 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] Revert "mm/kmemleak: move the initialisation of
 object to __link_object"
Message-ID: <ZVTS4DN1nVFIvdOe@arm.com>
References: <20231115082138.2649870-1-liushixin2@huawei.com>
 <20231115082138.2649870-2-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115082138.2649870-2-liushixin2@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 04:21:37PM +0800, Liu Shixin wrote:
> Move the initialisation of object back to__alloc_object() because
> set_track_prepare() attempt to acquire zone->lock(spinlocks) while
> __link_object is holding kmemleak_lock(raw_spinlocks). This is not
> right for RT mode.
> 
> This reverts commit 245245c2fffd0050772a3f30ba50e2be92537a32.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

You can also add:

Fixes: 245245c2fffd ("mm/kmemleak: move the initialisation of object to __link_object")

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I now realised that we update the object allocation stack trace via the
delete_object_part() when we shouldn't. I'd say __alloc_object() can
take a trace_handle as argument and if it's !0, set it directly whithout
calling set_track_prepare() (as a separate patch).

-- 
Catalin
