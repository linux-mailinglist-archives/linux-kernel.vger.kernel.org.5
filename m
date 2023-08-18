Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ECB780C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377153AbjHRNaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377183AbjHRNaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B231E4F;
        Fri, 18 Aug 2023 06:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 103466419A;
        Fri, 18 Aug 2023 13:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F7BC433C8;
        Fri, 18 Aug 2023 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692365399;
        bh=cFHYWvuH2yiNK08rOdgi29Mx3L982UHINNVuXMMZlro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P1ZQARbLlMB3eHw13XHg0a83dM8ZZPx1pSHSSsXE/N+75aVIQCGSdLdxD3A7G+pEH
         sFrFAcpiKImUJTkPdcibaE2ISnqDIzcuMO6WDGLA5pixEsvmRhURS60LWbNpV0jvlz
         /1zN2khkm60TrCZkMDWkpvUGL0gDV6jkcXg0UchkAYzuRGi/pBjVWq4jaYrIFzGKDm
         o/JmhREOOlkhgsyaE2NS+k+SfAJd8DbgCRSSn/2+AF8+7gUdi4Pt/A30j6BY9sbPBp
         8o02JLDXvV2NVHCBnMM/4vJXc9wLYTLP139QY6qD9/0O6hBSeGdloq3/SOLHuVyY14
         CTWUTSCLau5+w==
Date:   Fri, 18 Aug 2023 15:29:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Hui Su <sh_def@163.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nsproxy: Convert nsproxy.count to refcount_t
Message-ID: <20230818-parkplatz-wahrzeichen-bff62b8dc55e@brauner>
References: <20230818041327.gonna.210-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818041327.gonna.210-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 09:13:32PM -0700, Kees Cook wrote:
> From: Elena Reshetova <elena.reshetova@intel.com>
> 
> atomic_t variables are currently used to implement reference counters
> with the following properties:
>  - counter is initialized to 1 using atomic_set()
>  - a resource is freed upon counter reaching zero
>  - once counter reaches zero, its further
>    increments aren't allowed
>  - counter schema uses basic atomic operations
>    (set, inc, inc_not_zero, dec_and_test, etc.)
> 
> Such atomic variables should be converted to a newly provided
> refcount_t type and API that prevents accidental counter overflows and
> underflows. This is important since overflows and underflows can lead
> to use-after-free situation and be exploitable.
> 
> The variable nsproxy.count is used as pure reference counter. Convert it
> to refcount_t and fix up the operations.
> 
> **Important note for maintainers:
> 
> Some functions from refcount_t API defined in refcount.h have different
> memory ordering guarantees than their atomic counterparts. Please check
> Documentation/core-api/refcount-vs-atomic.rst for more information.
> 
> Normally the differences should not matter since refcount_t provides
> enough guarantees to satisfy the refcounting use cases, but in some
> rare cases it might matter. Please double check that you don't have
> some undocumented memory guarantees for this variable usage.
> 
> For the nsproxy.count it might make a difference in following places:
>  - put_nsproxy() and switch_task_namespaces(): decrement in
>    refcount_dec_and_test() only provides RELEASE ordering and ACQUIRE
>    ordering on success vs. fully ordered atomic counterpart
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Reviewed-by: David Windsor <dwindsor@gmail.com>
> Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
