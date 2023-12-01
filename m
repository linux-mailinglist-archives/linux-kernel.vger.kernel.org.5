Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7699B800ADB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378824AbjLAM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378803AbjLAM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:27:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4454FB0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:27:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463ABC433C8;
        Fri,  1 Dec 2023 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701433638;
        bh=VLf9TWayJPl8TT4+DSau+I8bCfyYcFQKiuZmn9PQq5M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CM8B1w5kfjRuNR50iBGF18msF6xVUXENaYt9iSsjPuYmbCGOhHR6lVYoGV/eLiEIA
         fFqGE0jRrEImgYMm4Oq6pK6iCvVYadEEPHUNEzakNGKb/RRdfEl5MDZ/WqL4er8lEW
         u+SBIZLvmEDq1+p1oYDDeQ1gH4AIbFFfKO4064c13kXghVFvJ1qPckwhUwTxxKRig8
         D+MMfSi6MTm2grtTtxWZbWEeOjWzx43ZSAU54z1iEyWyYFDDCUYIJ8Ts3XVferFZZC
         Zk0J39sxjiGIltm1e8SiQLT2V0CO6Z3mtp1jln1NCIpOXzDm3B9k89C1ComQ3LOHD6
         mWqCRaqXMbqKQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iwlwifi: fw: replace deprecated strncpy with
 strscpy_pad
References: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
        <202311301354.0DAC97C@keescook>
Date:   Fri, 01 Dec 2023 14:27:15 +0200
In-Reply-To: <202311301354.0DAC97C@keescook> (Kees Cook's message of "Thu, 30
        Nov 2023 13:55:04 -0800")
Message-ID: <874jh2rtuk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Oct 19, 2023 at 05:44:59PM +0000, Justin Stitt wrote:
>> strncpy() is deprecated for use on NUL-terminated destination strings
>> [1] and as such we should prefer more robust and less ambiguous string
>> interfaces.
>> 
>> Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
>> both dump_info->dev_human_readable and dump_info->bus_human_readable are
>> intended to be NUL-terminated.
>> 
>> Moreover, since this seems to cross the file boundary let's NUL-pad to
>> ensure no behavior change.
>> 
>> strscpy_pad() covers both the NUL-termination and NUL-padding, let's use
>> it.
>> 
>> Link:
>> https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
>> [1]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Thread ping. Can the wireless folks please pick this up?

Yeah, I'll take this directly to wireless-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
