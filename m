Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB137B7522
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbjJCXgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjJCXgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:36:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D9C9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:36:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB364C433C7;
        Tue,  3 Oct 2023 23:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696376208;
        bh=JlZKAr1MFKBroi3aiHBMj5smlSqGSHEUMHgaW1Fzld8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DiN7HWwAoSs3mW7jauE9BquMRpLtWxVfnh3UZ1Gmq/bSNNiaADXEwsx9ISXyApOJq
         755IQVY6QgI/evjKL0Erfk3cgxFNDXFgudhzlY2Rw0+tza8UVdHvnnjMtJe7bdqYQ/
         nfSye/GQRDLY1E76J/Ww/DPrFFu6SyS9jqEmvM0UYZB3+QEpUYD3N0N7oAkjbJL5GC
         /epq5QcS5FagvTZ6n9AyM25N0EPt3FYeYmIjAkmuKa4W5k40qgzqTSjJHDEcUMksOK
         i/MfI0/aqH8oTp4/3oD3t1bUxq4lLp6GkZapoFRsGZkHsAEN/x9t/yULq7gy+cx06f
         e/Tc5dvZRC7xg==
Message-ID: <164ebd58-2ee3-bff1-48e7-fe430fb27e6b@kernel.org>
Date:   Tue, 3 Oct 2023 17:36:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] nexthop: Annotate struct nh_notifier_res_table_info with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        llvm@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231003231818.work.883-kees@kernel.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231003231818.work.883-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 5:18 PM, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct
> nh_notifier_res_table_info.
> 
> Cc: David Ahern <dsahern@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/net/nexthop.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


