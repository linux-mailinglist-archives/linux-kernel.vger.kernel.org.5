Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D50F76B610
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjHANlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjHANlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1098139;
        Tue,  1 Aug 2023 06:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72F5F6158A;
        Tue,  1 Aug 2023 13:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926FBC433C8;
        Tue,  1 Aug 2023 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690897279;
        bh=NmSicqSVm0Cbv7rIqQBEiDWdhVa0cRCuHmqzlIkqnr4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=AopW2+aT1idkMZZqRRdvYlZTCLEGIc8mNt9tOFiWpEGAMFna3I4tnErNQOLnO8Gvp
         g4Mgf3weSS9IOwJNoZvQBhZgg/GUhb+Ea+l9Ztm0HHscEObyBLDaNOT+tdGSbGCVOc
         IPc5PQprhGdw8tm2Nw07m4Z8lJ2fCkUH92wQ5l9336KHFFbdsSgDH9vfUjoujW9N8I
         lKJUTpZF8z3FViNtoii8EZ8z6V4WQoUzsiaFItu5jlsoJg071jeRGGZhnucmd2Vj8V
         1FoRcEWxCvdYNGBxnUuSJcDPeGDZI+xgjVpeJ/zeQsJ+zrfW6ctHZATV12qKa2Q3/Q
         pVltMQPOJHB8g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ray_cs: Replace 1-element array with flexible array
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230728231245.never.309-kees@kernel.org>
References: <20230728231245.never.309-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169089727636.39272.16037953063224759518.kvalo@kernel.org>
Date:   Tue,  1 Aug 2023 13:41:18 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> The trailing array member of struct tx_buf was defined as a 1-element
> array, but used as a flexible array. This was resulting in build warnings:
> 
>     In function 'fortify_memset_chk',
>         inlined from 'memset_io' at /kisskb/src/arch/mips/include/asm/io.h:486:2,
>         inlined from 'build_auth_frame' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:2697:2:
>     /kisskb/src/include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning:
> detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>       493 |                         __write_overflow_field(p_size_field, size);
>           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Replace it with an actual flexible array. Binary difference comparison
> shows a single change in output:
> 
> │  drivers/net/wireless/legacy/ray_cs.c:883
> │       lea    0x1c(%rbp),%r13d
> │ -     cmp    $0x7c3,%r13d
> │ +     cmp    $0x7c4,%r13d
> 
> This is from:
> 
>         if (len + TX_HEADER_LENGTH > TX_BUF_SIZE) {
> 
> specifically:
> 
>  #define TX_BUF_SIZE (2048 - sizeof(struct tx_msg))
> 
> This appears to have been originally buggy, so the change is correct.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/88f83d73-781d-bdc-126-aa629cb368c@linux-m68k.org
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless.git, thanks.

1d7dd5aa3547 wifi: ray_cs: Replace 1-element array with flexible array

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230728231245.never.309-kees@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

