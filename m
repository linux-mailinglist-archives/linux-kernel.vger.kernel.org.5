Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525698009ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378554AbjLAL2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378547AbjLAL2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:28:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D30CF;
        Fri,  1 Dec 2023 03:28:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701430122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kxBXQG/f8kU5v0EK+ncURnwi12nHyxr77nDpaGQa42Y=;
        b=AtU97WuWe4IF4u/AOHjTBbTRVKwBw93eRxWv8WhB3zCFMCDmgmr+dgtLqCEYjoa5E7fHXP
        zzUpOmfPz3lDPCaYsOdRpEVVWgfJEQEWWJ76JhPQar9deQQGFzAXxOZRpe41MSrf3kYphx
        YcaDy3CxUt+2//MyKV4M3wPreT7u/GT2W9/Z+00HXC/Tr8h/OJdTOzay8mfBYUik9kXTT4
        L9bGC8KIWdPRNAKS8B/ij/HRzYgGo+WuYNYjQkeS4ruamqoZwFIrF7gCrcRjtRW9TwWDM8
        fgb9pCJtKIQR465KaqxjEOA5+HmboM4l0aIMo53XGN9amKFmCCH7dCM+YHVdbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701430122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kxBXQG/f8kU5v0EK+ncURnwi12nHyxr77nDpaGQa42Y=;
        b=qd/HkafcWYHXHFYCQMVbiHc+ZmtzQRiF4LgZ9uk4bfggE/cqqFpEvaN4pBeHm0TmVjoOhM
        PV7ASivB+78rMNCA==
To:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, linux-hardening@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 06/21] cpu/hotplug: remove CPUHP_SLAB_PREPARE hooks
In-Reply-To: <20231120-slab-remove-slab-v2-6-9c9c70177183@suse.cz>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-6-9c9c70177183@suse.cz>
Date:   Fri, 01 Dec 2023 12:28:42 +0100
Message-ID: <87msuuxitx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20 2023 at 19:34, Vlastimil Babka wrote:

> The CPUHP_SLAB_PREPARE hooks are only used by SLAB which is removed.
> SLUB defines them as NULL, so we can remove those altogether.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

