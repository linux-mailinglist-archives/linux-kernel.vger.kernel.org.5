Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF74E810E21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjLMKPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjLMKPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:15:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2902511A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:15:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127B4C433C7;
        Wed, 13 Dec 2023 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702462515;
        bh=BTwkCDF6j4V1ri2o7T7fV1zwgHRy2Zj5Vzv2QOjcckI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cN9F2qWO/RcSxSEUILn89hMSiuSM53g0vOpeYMfeK+7XqBjlgTd0b+noDlyKYKeFY
         yNqrJZIuSwZY7Lc+87O7EW1KJn/xRZ3gneO8WTBZMk9xJikuLuL/mcalV2Is0xK411
         xEVAGYMmnyd2yjFwi+AqUmHjjJIm551lpdLEKvCFeLso564T5qqMoM9b4Gne0NIzZN
         RaC84zaw2Ib+hsWiR6TVhDWi46A4pSkn/ck8b5Smqw2msWN6EB783HRqG7wy4L03QK
         v1D3Cx0fFHlp3otR7hlgtZK9kcWxH7u82lpRD+0yINfOPon4wWvtIXdH3yrNhj/fWO
         rz909SVU0mmYA==
Date:   Wed, 13 Dec 2023 11:15:10 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] statmount: reduce runtime stack usage
Message-ID: <20231213-wirrungen-angetan-6556786f194b@brauner>
References: <20231213090015.518044-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213090015.518044-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:00:03AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> prepare_kstatmount() constructs a copy of 'struct kstatmount' on the stack
> and copies it into the local variable on the stack of its caller. Because
> of the size of this structure, this ends up overflowing the limit for
> a single function's stack frame when prepare_kstatmount() gets inlined
> and both copies are on the same frame without the compiler being able
> to collapse them into one:
> 
> fs/namespace.c:4995:1: error: stack frame size (1536) exceeds limit (1024) in '__se_sys_statmount' [-Werror,-Wframe-larger-than]
>  4995 | SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
> 
> Replace the assignment with an in-place memset() plus assignment that
> should always be more efficient for both stack usage and runtime cost.
> 
> Fixes: 49889374ab92 ("statmount: simplify string option retrieval")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I folded this patch and placed a link here. Thanks!
