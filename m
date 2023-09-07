Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81C3797AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245603AbjIGRsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245480AbjIGRrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:47:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D8B1BF7;
        Thu,  7 Sep 2023 10:47:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B46C43395;
        Thu,  7 Sep 2023 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694108214;
        bh=Eiz6SK/GqpmCoXTlpi6rkM1vG/IzusgKaLu2J8ONxZc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lNmwdK0igINXgKTUlE2M5AL8aAcwBLGL82xBc092o9SE8QeG66ueU70gN9x3wzaWj
         7QVF1N2SAwkrvnPeRjiN/Ncs2oFKV80LqfhPi6waSgUaY7jwDNBNnMkaNrCCupKWJG
         iOB+mAGaBLEzOTXygDVuQSHWP9afZu1ESP6FCwCUaGHliCdPjd5rDlnTdOnQ2ynmkg
         xNE8UwfSkfxl0wlcSP138wN7JOF/wudkT1n2VeQw1WMAspSFxi/2so0nXUepTJD5CA
         Dj5Zky56qn34Zk2YnuKmBvj+RviuXBnU35mOTeAasBvKGzpPPom4cosPC+EMDbAE6Q
         LMc5umqDShYoA==
Message-ID: <f08f590a-df05-4d83-984f-41b4d60af971@kernel.org>
Date:   Thu, 7 Sep 2023 19:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64/sysreg: refactor deprecated strncpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mostafa Saleh <smostafa@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
References: <20230905-strncpy-arch-arm64-v4-1-bc4b14ddfaef@google.com>
From:   Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20230905-strncpy-arch-arm64-v4-1-bc4b14ddfaef@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.09.2023 22:10, Justin Stitt wrote:
> strncpy is deprecated [1] and should not be used if the src string is
> not NUL-terminated.
> 
> When dealing with `cmdline` we are counting the number of characters
> until a space then copying these over into `buf`. Let's not use any of
> the str*() functions since the src string is not necessarily NUL-terminated.
> 
> Prefer `memcpy()` alongside a forced NUL-termination as it more
> accurately describes what is going on within this function, i.e: copying
> from non NUL-terminated buffer into a NUL-terminated buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
Hi,

some form of this patch [1] went into -next and it broke booting
on at least the Qualcomm SC8280XP-based Lenovo Thinkpad X13S.

Konrad

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=d232606773a0b09ec7f1ffc25f63abe801d011fd
