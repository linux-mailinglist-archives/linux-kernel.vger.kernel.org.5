Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201707D9EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjJ0RN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJ0RNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:13:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C97825B;
        Fri, 27 Oct 2023 10:13:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE27C433C8;
        Fri, 27 Oct 2023 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698426831;
        bh=KPuRo2bnfsBHo258rZKMPIKg4rb/dKZ3sHungljB//Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Psc4K6DkTgjU7sQjh0LKAgyBoU4EP44IST1Qj8iM1j2SrrfQB/IZcy1PuxIaRqId0
         ET8plrgucvcgH2OoPjDkVdOdFWy8oqrzVtKvEjAyOSy0viUrKnnbBpoLasmhTI7afJ
         81dJQvRBwnLSP5GBjAViUFg+3oB8wmaXkht8b28T6dkUB/ko4u3vOXqsFipahmIA1m
         7i7kiG0W85z0IND+5c0CsZU0exVTJ5jU4whCcgNsiWYnq1fxieeHDxyoflgDF0eJOZ
         TvD3SlhkwbCumwhXxUaiuSLyogvvgi2u/GSmPzioZqGfsLtzsqNDG08AQ1/kl68ezH
         u41JYh4npAOHg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] airo: replace deprecated strncpy with strscpy_pad
References: <20231026-strncpy-drivers-net-wireless-cisco-airo-c-v2-1-413427249e47@google.com>
        <202310270859.8EB5599A@keescook>
Date:   Fri, 27 Oct 2023 20:13:48 +0300
In-Reply-To: <202310270859.8EB5599A@keescook> (Kees Cook's message of "Fri, 27
        Oct 2023 08:59:32 -0700")
Message-ID: <87h6mcvvhv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

> On Thu, Oct 26, 2023 at 11:19:18PM +0000, Justin Stitt wrote:
>
>> strncpy() is deprecated for use on NUL-terminated destination strings
>> [1] and as such we should prefer more robust and less ambiguous string
>> interfaces.
>> 
>> `extra` is clearly supposed to be NUL-terminated which is evident by the
>> manual NUL-byte assignment as well as its immediate usage with strlen().
>> 
>> Moreover, let's NUL-pad since there is deliberate effort (48 instances)
>> made elsewhere to zero-out buffers in these getters and setters:
>> 6050 | memset(local->config.nodeName, 0, sizeof(local->config.nodeName));
>> 6130 | memset(local->config.rates, 0, 8);
>> 6139 | memset(local->config.rates, 0, 8);
>> 6414 | memset(key.key, 0, MAX_KEY_SIZE);
>> 6497 | memset(extra, 0, 16);
>> (to be clear, strncpy also NUL-padded -- we are matching that behavior)
>> 
>> Considering the above, a suitable replacement is `strscpy_pad` due to
>> the fact that it guarantees both NUL-termination and NUL-padding on the
>> destination buffer.
>> 
>> We can also replace the hard-coded size of "16" to IW_ESSID_MAX_SIZE
>> because this function is a wext handler.
>> 
>> In wext-core.c we have:
>> static const struct iw_ioctl_description standard_ioctl[] = {
>> ...
>>         [IW_IOCTL_IDX(SIOCGIWNICKN)] = {
>>                 .header_type    = IW_HEADER_TYPE_POINT,
>>                 .token_size     = 1,
>>                 .max_tokens     = IW_ESSID_MAX_SIZE,
>>         },
>> 
>> So the buffer size is (strangely) IW_ESSID_MAX_SIZE
>> 
>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Looks good; thanks!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

BTW most likely next week this driver and a bunch of other ancient
drivers will removed:

https://patchwork.kernel.org/project/linux-wireless/list/?series=795639&state=*&order=date

So to avoid unnecessary work on already removed drivers I recommend
using wireless-next as the baseline for wireless patches. Though I'm
still planning to apply this patch in case we ever add the driver back
(I hope not).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
