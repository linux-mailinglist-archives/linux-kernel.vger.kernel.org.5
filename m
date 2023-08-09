Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1166776B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjHIVyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHIVyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:54:51 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F387A6;
        Wed,  9 Aug 2023 14:54:50 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id D932B587264C0; Wed,  9 Aug 2023 23:54:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id D6F4060D19E7B;
        Wed,  9 Aug 2023 23:54:48 +0200 (CEST)
Date:   Wed, 9 Aug 2023 23:54:48 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Justin Stitt <justinstitt@google.com>
cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] netfilter: ipset: refactor deprecated strncpy
In-Reply-To: <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com>
Message-ID: <q49499n7-54p3-1soo-8s83-7p84724o08p7@vanv.qr>
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com> <20230809-net-netfilter-v2-1-5847d707ec0a@google.com> <20230809201926.GA3325@breakpoint.cc> <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 2023-08-09 23:40, Justin Stitt wrote:
>On Wed, Aug 9, 2023 at 1:19 PM Florian Westphal <fw@strlen.de> wrote:
>>
>> Justin Stitt <justinstitt@google.com> wrote:
>> > Use `strscpy_pad` instead of `strncpy`.
>>
>> I don't think that any of these need zero-padding.
>It's a more consistent change with the rest of the series and I don't
>believe it has much different behavior to `strncpy` (other than
>NUL-termination) as that will continue to pad to `n` as well.
>
>Do you think the `_pad` for 1/7, 6/7 and 7/7 should be changed back to
>`strscpy` in a v3? I really am shooting in the dark as it is quite
>hard to tell whether or not a buffer is expected to be NUL-padded or
>not.

I don't recall either NF userspace or kernelspace code doing memcmp
with name-like fields, so padding should not be strictly needed.
