Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4277DBED2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjJ3RZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjJ3RZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:25:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D54C0;
        Mon, 30 Oct 2023 10:24:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96856C433C7;
        Mon, 30 Oct 2023 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698686698;
        bh=PK/A8z3yZbNpKpLD9q6y6ISaFX6It4ni4b4D7mCk3SI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=j5H8ZAaD84BLwmy67QicRyv36dH42wsdA20UkFF2a8aLZF0Fxe9xRJ0bJg0BnCkJS
         XtIXZgPI/7CAzoObiWFC12KpazElRzs+9DcWe5XhaErNyOnv4Q3G04Q/lkpwTSUHcj
         smJ7LWRJfPobgmJzENxNzM2LYJ7RT/GWSWw5RkDSVYmviwm6eqqHZB8wsJMtZd0Pyr
         LIw/rCnZqFivwsVuz8uNiO/tRLovFc87oJy0HpctYCGmaJEsfW6U+1S08CaphpOw4r
         8tjrnyTHnTK26XN95CJNpDD05VX6Kc9mx2tS9mpqIxp6TzYGOtZTcy0QFiT39U1n3e
         wXXKNAvOHsv9g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: airo: replace deprecated strncpy with strscpy_pad
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231026-strncpy-drivers-net-wireless-cisco-airo-c-v2-1-413427249e47@google.com>
References: <20231026-strncpy-drivers-net-wireless-cisco-airo-c-v2-1-413427249e47@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169868669554.1993746.6778918340957233673.kvalo@kernel.org>
Date:   Mon, 30 Oct 2023 17:24:57 +0000 (UTC)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> `extra` is clearly supposed to be NUL-terminated which is evident by the
> manual NUL-byte assignment as well as its immediate usage with strlen().
> 
> Moreover, let's NUL-pad since there is deliberate effort (48 instances)
> made elsewhere to zero-out buffers in these getters and setters:
> 6050 | memset(local->config.nodeName, 0, sizeof(local->config.nodeName));
> 6130 | memset(local->config.rates, 0, 8);
> 6139 | memset(local->config.rates, 0, 8);
> 6414 | memset(key.key, 0, MAX_KEY_SIZE);
> 6497 | memset(extra, 0, 16);
> (to be clear, strncpy also NUL-padded -- we are matching that behavior)
> 
> Considering the above, a suitable replacement is `strscpy_pad` due to
> the fact that it guarantees both NUL-termination and NUL-padding on the
> destination buffer.
> 
> We can also replace the hard-coded size of "16" to IW_ESSID_MAX_SIZE
> because this function is a wext handler.
> 
> In wext-core.c we have:
> static const struct iw_ioctl_description standard_ioctl[] = {
> ...
>         [IW_IOCTL_IDX(SIOCGIWNICKN)] = {
>                 .header_type    = IW_HEADER_TYPE_POINT,
>                 .token_size     = 1,
>                 .max_tokens     = IW_ESSID_MAX_SIZE,
>         },
> 
> So the buffer size is (strangely) IW_ESSID_MAX_SIZE
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to wireless-next.git, thanks.

9beac4ee4928 wifi: airo: replace deprecated strncpy with strscpy_pad

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231026-strncpy-drivers-net-wireless-cisco-airo-c-v2-1-413427249e47@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

