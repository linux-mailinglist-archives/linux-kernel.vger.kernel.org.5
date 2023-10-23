Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88B7D3D87
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjJWR0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjJWR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:26:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E23D127;
        Mon, 23 Oct 2023 10:26:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66675C433C8;
        Mon, 23 Oct 2023 17:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082010;
        bh=N0T7cOgCbINrOXJ2SVCDOAHG/2PRx25LOpY5Fkz1Gk4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=u2QXvS5IZazJ+Om2SJK9qimi0fz7wYBRKR6LUZODW6csSKeVGy8/V4BnRchYeyyev
         vHMm3Xna0eh6/tkWAVIiID7436mKW1UamEvtL3uLzOV2KU8WIf045HHchPa2NfEkwv
         pi8JKiaWajd5O2SQksuay03/s9Kp4nlBkXa/Mi7jq8Td/To80hquCMOiTNzIzuTmx4
         OpRuHqly4RVxj3yuHcPbT27a2m9PQc4VSc9UpHMHwrZCuDMBli9CAYoy6MYcTweDWA
         qg5XMukhS3IuXGhd/lT7fQ8dpwOB9E3I9mBrl4yzH7oTydWE66TPHUUKAS8aTQFvTa
         rap6oEjpmEjrA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ipw2x00: replace deprecated strncpy with
 strscpy_pad
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231017-strncpy-drivers-net-wireless-intel-ipw2x00-ipw2200-c-v2-1-465e10dc817c@google.com>
References: <20231017-strncpy-drivers-net-wireless-intel-ipw2x00-ipw2200-c-v2-1-465e10dc817c@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169808200764.695306.10833187895555987178.kvalo@kernel.org>
Date:   Mon, 23 Oct 2023 17:26:49 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `extra` is intended to be NUL-terminated which is evident by the manual
> assignment of a NUL-byte as well as its immediate usage with strlen().
> 
> Moreover, many of these getters and setters are NUL-padding buffers with
> memset():
> 2439  |	memset(&tx_power, 0, sizeof(tx_power));
> 9998  | memset(sys_config, 0, sizeof(struct ipw_sys_config));
> 10084 | memset(tfd, 0, sizeof(*tfd));
> 10261 | memset(&dummystats, 0, sizeof(dummystats));
> ... let's maintain this behavior and NUL-pad our destination buffer.
> 
> Considering the above, a suitable replacement is `strscpy_pad` due to
> the fact that it guarantees both NUL-termination and NUL-padding on the
> destination buffer.
> 
> To be clear, there is no bug in the current implementation as
> MAX_WX_STRING is much larger than the size of the string literals being
> copied from. Also, strncpy() does NUL-pad the destination buffer and
> using strscpy_pad() simply matches that behavior. All in all, there
> should be no functional change but we are one step closer to eliminating
> usage of strncpy().
> 
> Do note that we cannot use the more idiomatic strscpy invocation of
> (dest, src, sizeof(dest)) as the destination buffer cannot have its size
> determined at compile time. So, let's stick with (dest, src, LEN).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

8890b9bca38f wifi: ipw2x00: replace deprecated strncpy with strscpy_pad

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231017-strncpy-drivers-net-wireless-intel-ipw2x00-ipw2200-c-v2-1-465e10dc817c@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

