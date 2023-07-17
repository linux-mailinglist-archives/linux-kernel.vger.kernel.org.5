Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BA4756D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGQTnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGQTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:43:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F5BD3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:43:52 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689623030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIYuBceOvZxFcNDniGd0KrPzPzR4CRiWHjc/79HQdoA=;
        b=2pkWsLajD3WSzZpO5sVNUa3P6XkSNWZvfID18WmcLhV+6Alkt07jKtfYra98Gs9Y0YCpQT
        tsjv7Oj1rfWuJCS7sJshZNMDHpJH8S85+NKqPtvFOfdtZPAQxY54Gm86XZZJKDz3r5uOqw
        I1wqvHxV0R+PSs0Xg3eBtxXpaNKrED9LRbOZQobYmiMjQlmovZOBGoPWgxSuUs1aLwqiHK
        irAbGzEdAmuRrNj9Ep6dAL5DwpIs/arkk0oID7z5QNHhTi5W4DmkmWfrouJAfslOUfypDP
        nxir+Wu7iP7Uc6zawc1ysOcwpffaeMJ04blepYDfY6Lx+OsNZjA/shOKhGQzMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689623030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BIYuBceOvZxFcNDniGd0KrPzPzR4CRiWHjc/79HQdoA=;
        b=rs+yyEhnNnmpnbiKwcLxUFW6oNy+iudM04d9wU+M2uXz54/ai7Wej9xR3yhwXpvHUiL6PI
        xhiCrITvMPI8mfAw==
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/build: vdso linker warning for orphan sections
In-Reply-To: <20230609051002.3342-1-npiggin@gmail.com>
References: <20230609051002.3342-1-npiggin@gmail.com>
Date:   Mon, 17 Jul 2023 21:49:48 +0206
Message-ID: <871qh6wcgb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

On 2023-06-09, Nicholas Piggin <npiggin@gmail.com> wrote:
> Add --orphan-handlin for vdsos, and adjust vdso linker scripts to deal
> with orphan sections.

I'm reporting that I am getting a linker warning with 6.5-rc2. The
warning message is:

ld: warning: discarding dynamic section .rela.opd

and bisects to:

8ad57add77d3 ("powerpc/build: vdso linker warning for orphan sections")

Despite the warning, my ppc64 system seems to run fine. Let me know if
you need any other information from me.

I noticed [0] this with 6.5-rc1 but didn't contact the right people.

John Ogness

[0] https://lore.kernel.org/lkml/871qhf1q3j.fsf@jogness.linutronix.de
