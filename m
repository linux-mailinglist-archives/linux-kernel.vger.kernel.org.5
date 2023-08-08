Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FE8774F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjHHXUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHHXUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:20:37 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C2A19AF;
        Tue,  8 Aug 2023 16:20:36 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 5916758730BD3; Wed,  9 Aug 2023 01:20:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 5716D60C2FC35;
        Wed,  9 Aug 2023 01:20:34 +0200 (CEST)
Date:   Wed, 9 Aug 2023 01:20:34 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Justin Stitt <justinstitt@google.com>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] netfilter: xtables: refactor deprecated strncpy
In-Reply-To: <20230808-net-netfilter-v1-7-efbbe4ec60af@google.com>
Message-ID: <35rnr776-4ssp-314r-0473-p19q3r880ps1@vanv.qr>
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com> <20230808-net-netfilter-v1-7-efbbe4ec60af@google.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 2023-08-09 00:48, Justin Stitt wrote:

>Prefer `strscpy` as it's a more robust interface.
>
>There may have existed a bug here due to both `tbl->repl.name` and
>`info->name` having a size of 32 as defined below:
>|  #define XT_TABLE_MAXNAMELEN 32
>
>This may lead to buffer overreads in some situations -- `strscpy` solves
>this by guaranteeing NUL-termination of the dest buffer.

It generally will not lead to overreads.
xt not only deals with strings on its own turf, it even takes
them from userspace-provided buffers, which means extra scrutiny is
absolutely required. Done in places like

x_tables.c:     if (strnlen(name, XT_EXTENSION_MAXNAMELEN) == XT_EXTENSION_MAXNAMELEN)


(Which is not to say the strncpy->strscpy mop-up is bad.)
