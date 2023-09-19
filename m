Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE177A5FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjISKfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISKfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:35:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1CBEA;
        Tue, 19 Sep 2023 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1695119735;
        bh=XaXVz4yeLyNPYtcxciiR6RMieKxG6wAEkS00BDFRrJE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=A/Qz4dVevwY4AGsejMiiFQ0MwKv7WsEVGGC2sX0verJD1HZBGgSvc3/0PoKlrlKkI
         qr53abDYtPiVUtxnIWKRPBmyrz7Sv5431NkEh1GZ4SmNEBbPLbppLdIJnXA5obdXRJ
         4Vsp2p8rpE28gHDDQ7VFvAuI/yEPozYCZotNVgHMb3sa7hkqRbt+Ah4H9HRKXJk7Nn
         QstPCtSYQKk2dseiwHLoEjMNB0rZ+qQNIQq3+Ejij1+f3OecJs4JMh/eHxFYxqNVMJ
         n+Gp8RVfsJBRTWD/JVJG4CK2A/ovCB7WhMFsyhaSvch91dVrV/DSUFQ3kdB2z0Zl/K
         BbGd1S9tVn8ug==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqdNQ6tRfz4x2r;
        Tue, 19 Sep 2023 20:35:34 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Justin Stitt <justinstitt@google.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2] hwmon: (ibmpowernv) refactor deprecated strncpy
In-Reply-To: <20230919-strncpy-drivers-hwmon-ibmpowernv-c-v2-1-37d3e64172bc@google.com>
References: <20230919-strncpy-drivers-hwmon-ibmpowernv-c-v2-1-37d3e64172bc@google.com>
Date:   Tue, 19 Sep 2023 20:35:34 +1000
Message-ID: <87il86tpqh.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> writes:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>
> A suitable replacement is `memcpy` as we've already precisely calculated
> the number of bytes to copy while `buf` has been explicitly
> zero-initialized:
> | 	char buf[8] = { 0 };
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - prefer memcpy to strscpy (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-hwmon-ibmpowernv-c-v1-1-ba6b7f42c98c@google.com
> ---
>  drivers/hwmon/ibmpowernv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
