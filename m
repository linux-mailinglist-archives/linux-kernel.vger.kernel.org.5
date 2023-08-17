Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF06677F093
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbjHQGfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348256AbjHQGex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:34:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146302700;
        Wed, 16 Aug 2023 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692254089;
        bh=QOKoW3wyRNr1RLwRnOsY4BbnnwrSfpgB6x3DEw7vRYI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YtX6jgHNQC0nPGKx1/R/ojff9UHbjVywbxalcoJG1mImb7/m3AfOy1YxIRzmpUbXz
         XMOqb3hmaYHVodauNH9eIpdozm6OBERMmsll7/Pw+Wl0cb9VQ/2acakYaNYNBXADU1
         O9zbt1mjuLqWzpm2qnJy//jGVuMgsiuvuuFbOULlvWIbaDARBudQxqDQZHZgua4nNq
         BaBkSHCqV8nZZfoFR5FIXAu/CUfAjssMfrDBv75ftIBAQM65jNufcC778EP8Y6dbTH
         FIFgeb/6SxFuQcbuJ1QvROfVwJ9x+X54Mv9MVyQf8i0ZvwA422MnIBpZdqsUHF03T9
         yd7OYR/Nrd/RQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRFbs15Tdz4wZn;
        Thu, 17 Aug 2023 16:34:49 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Justin Stitt <justinstitt@google.com>,
        Geoff Levand <geoff@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] powerpc/ps3: refactor strncpy usage
In-Reply-To: <20230816-strncpy-arch-powerpc-platforms-ps3-repository-v1-1-88283b02fb09@google.com>
References: <20230816-strncpy-arch-powerpc-platforms-ps3-repository-v1-1-88283b02fb09@google.com>
Date:   Thu, 17 Aug 2023 16:34:47 +1000
Message-ID: <87350i6ut4.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> writes:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>
> `make_first_field()` should use similar implementation to `make_field()`
> due to memcpy having more obvious behavior here. The end result yields
> the same behavior as the previous `strncpy`-based implementation
> including the NUL-padding.
>
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note:
> This follows up on a previous RFC which can be found here:
> https://lore.kernel.org/all/20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com/
> ---
>  arch/powerpc/platforms/ps3/repository.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This looks good to me. I'll pick this up directly, Geoff let me know if
this breaks something somehow.

cheers
