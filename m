Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2ED777EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjHJQy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005201728
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A6BB66454
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879CFC433C8;
        Thu, 10 Aug 2023 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691686492;
        bh=/BiI3r6KjM3Bn3xX0qfnb30NGMBPvBrMysulwCHjixw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DOci+ZnrHilJyVQKb9f/WNY+b7IOlSolnLUO/FJnPlUjvkIE0EcrUcE4ycihUAART
         u9QmNZkNXDnsBCtGYF5DFGL4BVXfpMcuI3NAYR7leVOzQlKwEPBecn81/QThWECi2c
         +TJGjB0gU7CPqq6LVz6eYytYOlCRYvOqN3sHfJIE=
Date:   Thu, 10 Aug 2023 09:54:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_charante@quicinc.com>
Subject: Re: [PATCH v2] cma: introduce CMA_ALLOC_DEBUG config
Message-Id: <20230810095451.cada824810441ecc955e2b2e@linux-foundation.org>
In-Reply-To: <20230809131640.18791-1-quic_bibekkum@quicinc.com>
References: <20230809131640.18791-1-quic_bibekkum@quicinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 18:46:40 +0530 Bibek Kumar Patro <quic_bibekkum@quicinc.com> wrote:

> Currently enabling CONFIG_CMA_DEBUG enables DEBUG preprocessor macro.
> If DEBUG is defined, it's equivalent to a printk with KERN_DEBUG loglevel
> flooding the dmesg buffer with pr_debug prints from mm/cma driver and from
> included files as well. This results in excessive amount of CMA logging and
> also might distract the debug teams with unrelated KERN_DEBUG prints.One of
> the ways engineers currently tackle this problem is by passing loglevel=N
> though commandline to suppress KERN_DEBUG messages. This approach can
> sometimes become tiresome due to its repetitive nature.
> This patch proposes an alternative approach by introducing a simple new
> config CONFIG_CMA_ALLOC_DEBUG which only shows the cma bit allocation
> status in case of cma failure and do not enable DEBUG preprocessor macro
> from CONFIG_CMA_DEBUG avoiding excessive CMA logging from pr_debug.
> Engineers and tech teams seeking only for bitmap status in case of cma
> failure can use this simple config instead of worrying about changing
> the loglevel or trying other similar workarounds.

Would it be better to control this at runtime?  With a /proc or /sys tunable?
