Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC646774F6C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjHHXjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjHHXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:39:06 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F9E1BFE;
        Tue,  8 Aug 2023 16:39:02 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qTWHv-0005Zw-9W; Wed, 09 Aug 2023 01:38:55 +0200
Date:   Wed, 9 Aug 2023 01:38:55 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] netfilter: ipset: refactor deprecated strncpy
Message-ID: <20230808233855.GI9741@breakpoint.cc>
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
 <20230808-net-netfilter-v1-1-efbbe4ec60af@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808-net-netfilter-v1-1-efbbe4ec60af@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> wrote:
> Fixes several buffer overread bugs present in `ip_set_core.c` by using
> `strscpy` over `strncpy`.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> ---
> There exists several potential buffer overread bugs here. These bugs
> exist due to the fact that the destination and source strings may have
> the same length which is equal to the max length `IPSET_MAXNAMELEN`.

There is no truncation.  Inputs are checked via nla_policy:

[IPSET_ATTR_SETNAME2]   = { .type = NLA_NUL_STRING, .len = IPSET_MAXNAMELEN - 1 },
