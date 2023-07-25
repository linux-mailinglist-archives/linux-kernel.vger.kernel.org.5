Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0720C761889
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjGYMkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGYMks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:40:48 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA16DC4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:40:45 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 36PCeGQT060305;
        Tue, 25 Jul 2023 21:40:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Tue, 25 Jul 2023 21:40:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 36PCeFMV060302
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Jul 2023 21:40:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <41b72295-8eb2-8609-7494-cb8f57c4443a@I-love.SAKURA.ne.jp>
Date:   Tue, 25 Jul 2023 21:40:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Revert "fbcon: Use kzalloc() in fbcon_prepare_logo()"
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Helge Deller <deller@gmx.de>
References: <98b79fbdde69a4a203096eb9c8801045c5a055fb.1690218016.git.geert+renesas@glider.be>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <98b79fbdde69a4a203096eb9c8801045c5a055fb.1690218016.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/07/25 2:03, Geert Uytterhoeven wrote:
> The syzbot report turned out to be a false possitive, caused by a KMSAN
> problem.  Indeed, after allocating the buffer, it is fully initialized
> using scr_memsetw().  Hence there is no point in allocating zeroed
> memory, while this does incur some overhead.

I suggest using below description, for this problem was reported by me
using a kernel built with syzbot's config file (i.e. syzbot is irrelevant).

Commit a6a00d7e8ffd ("fbcon: Use kzalloc() in fbcon_prepare_logo()") is
redundant, for the root cause that resulted in a false positive was fixed
by commit 27f644dc5a77 ("x86: kmsan: use C versions of memset16/memset32/
memset64").

