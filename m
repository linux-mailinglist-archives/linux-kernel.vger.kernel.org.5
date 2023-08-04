Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF70F76FCE3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjHDJIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjHDJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BB94C1E;
        Fri,  4 Aug 2023 02:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 044C861F5E;
        Fri,  4 Aug 2023 09:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05452C433C7;
        Fri,  4 Aug 2023 09:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691139930;
        bh=7/6eO2Rml4YZRJjhU12Ck6c16ZTJ/v83KfoE/2x3bok=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=k3ke/QYCAF7/+ouNtfRkVTgVqA5RpJfioTMUyZao8zw45IBxTyBNUTPH91CKChlJv
         HThEOvQMyFKNn8heQwfgN2VTVoYU/Dkcwftrf2XAa+1DTzVshrUp6pRGgiTsMwePtV
         ro5bKDKNUc+hfkDAVRTn9VwqAypXgdfpCKHAvkcje7loENprMrbMytaeHLoqO9gd5x
         eBONpZhKrMex35qSXiwVTvXvhAeSa+GRpnAeQ5fbWsjGZ3AFnjYd5KRWaNV4+vrvCf
         5aIENEe9tfYxQbmzKJamPApHoWt1W+mdxMg/HteY0MrImAbPv96lPffh5dW87Lzv4V
         x2m9vw17wZVog==
From:   Kalle Valo <kvalo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ipw2x00: refactor to use kstrtoul
In-Reply-To: <202308040120.183400A04@keescook> (Kees Cook's message of "Fri, 4
        Aug 2023 01:21:07 -0700")
References: <20230802-wifi-ipw2x00-refactor-v2-1-d33f765e9cd5@google.com>
        <202308040120.183400A04@keescook>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Fri, 04 Aug 2023 12:05:26 +0300
Message-ID: <87wmybjhyh.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Aug 02, 2023 at 01:23:06AM +0000, Justin Stitt wrote:
>> The current implementation seems to reinvent what `kstrtoul` already does
>> in terms of functionality and error handling. Remove uses of `simple_strtoul()`
>> in favor of `kstrtoul()`.
>> 
>> There is the following note at `lib/vsprintf.c:simple_strtoull()` which
>> further backs this change:
>> | * This function has caveats. Please use kstrtoull (or kstrtoul) instead.
>> 
>> And here, simple_str* are explicitly deprecated [3].
>> 
>> This patch also removes an instance of the deprecated `strncpy` which helps [2].
>> 
>> Link: https://lore.kernel.org/all/202308011602.3CC1C0244C@keescook/ [1]
>> Link: https://github.com/KSPP/linux/issues/90 [2]
>> Link:
>> https://docs.kernel.org/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>> [3]
>> Cc: linux-hardening@vger.kernel.org
>> Suggested-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> This looks correct to me. I would be curious to hear back from the intel
> folks if the interface continues to work correctly with real hardware.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

This is ancient hardware, not sure if anyone even have a working setup.
And even if they would have one I doubt anyone uses this sysfs interface
for anything.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
