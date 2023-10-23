Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2277D3DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjJWR34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjJWR3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:29:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A812A1717;
        Mon, 23 Oct 2023 10:29:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C05C433BF;
        Mon, 23 Oct 2023 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082144;
        bh=QHFYOWlkGzWzBm8/TDgaH/NxaV2cslJrLINWwlJQA/s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FVgWfTu2X8tsb3prDb290Ls4nIJjC2E6e+STuJrtghR8sn4A7zuJHXf7ReOr7uRv9
         X3vbQv5lLeOSahlR7Q0Uj6EQiFbDa7hbehu/4xm7jPh8xDXnKVgbO8Sbu5voHC9keB
         EdxUfDnK9RwbuZ/OmB0SSicqHWPu/CiDyPCWTd1pknVzWmra/gjOAW9JZ9B09Q9EgS
         PGJIpp9kqg5jS6OYM6k1RcRBTHhxtxrrWmEPo/DZ8SFeBrL7+3g2cVTmTXJ4LGRF4G
         FFpCqxIKSgvx6YfwS8Fy0h0HoG5xSVkkLb3Fx8Tbj1J8hx4kvIlHDBu6PJNW7cMbj9
         uYIcOimdXRO/Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: wl18xx: replace deprecated strncpy with strscpy
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com>
References: <20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169808214096.695306.16867371927362677555.kvalo@kernel.org>
Date:   Mon, 23 Oct 2023 17:29:02 +0000 (UTC)
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
> wl->chip.phy_fw_ver_str is obviously intended to be NUL-terminated by
> the deliberate comment telling us as much. Furthermore, its only use is
> drivers/net/wireless/ti/wlcore/debugfs.c shows us it should be
> NUL-terminated since its used in scnprintf:
> 492 | DRIVER_STATE_PRINT_STR(chip.phy_fw_ver_str);
> which is defined as:
> | #define DRIVER_STATE_PRINT_STR(x)  DRIVER_STATE_PRINT(x, "%s")
> ...
> | #define DRIVER_STATE_PRINT(x, fmt)   \
> | 	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
> | 			  #x " = " fmt "\n", wl->x))
> 
> We can also see that NUL-padding is not required.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> The very fact that a plain-english comment had to be made alongside a
> manual NUL-byte assignment for such a simple purpose shows why strncpy
> is faulty. It has non-obvious behavior that has to be clarified every
> time it is used (and if it isn't then the reader suffers).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

fb329e8b1d88 wifi: wl18xx: replace deprecated strncpy with strscpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

