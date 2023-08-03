Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C563E76E79A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjHCMBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbjHCMBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD8273E;
        Thu,  3 Aug 2023 05:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECF1C61BDF;
        Thu,  3 Aug 2023 12:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EDAC433C8;
        Thu,  3 Aug 2023 12:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691064071;
        bh=VdVcZMd++gEDJ3fMlMp1laSbmWflsqIZsBMFRJzcdrA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PtPJeh1WMsC5tgpZ6HA3D3pHneTw+XpYfBmoUK6R0HOXaXqcynDoSXhcRMqhlZ1EY
         VKdKD5o8tRWakwwrVgPto1UVbFxYiCJtMY7rD3bFTMAIhP7GWqEkjIbTVo3lLeQc72
         EzGR3j9Tj/2shuxqU2mF7wzW48CvvBupLphgSp7tQcTVPQGZbDfE1zei0luf3RaWAx
         oB0hG2yiPwvWnBYhYyydLzqaV5k4UAlIj4eRp79iaU+Ay5xmSSMTfABsh0ZMsFa2+l
         eqrgT17t112YUGivd+/4lQmftGbg3dOosmlGvQJfvcp9rSBIfKNCgYjnUULG51CqrQ
         oxfhu7jGNSRgw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ipw2x00: refactor to use kstrtoul
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230802-wifi-ipw2x00-refactor-v2-1-d33f765e9cd5@google.com>
References: <20230802-wifi-ipw2x00-refactor-v2-1-d33f765e9cd5@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169106406791.1024854.15683351104405009219.kvalo@kernel.org>
Date:   Thu,  3 Aug 2023 12:01:09 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> wrote:

> The current implementation seems to reinvent what `kstrtoul` already does
> in terms of functionality and error handling. Remove uses of `simple_strtoul()`
> in favor of `kstrtoul()`.
> 
> There is the following note at `lib/vsprintf.c:simple_strtoull()` which
> further backs this change:
> | * This function has caveats. Please use kstrtoull (or kstrtoul) instead.
> 
> And here, simple_str* are explicitly deprecated [3].
> 
> This patch also removes an instance of the deprecated `strncpy` which helps [2].
> 
> Link: https://lore.kernel.org/all/202308011602.3CC1C0244C@keescook/ [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://docs.kernel.org/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull [3]
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

I assume this is just compile tested? In that case it's always good to add
"Compile tested only." to the commit log. But I can add that this time.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230802-wifi-ipw2x00-refactor-v2-1-d33f765e9cd5@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

