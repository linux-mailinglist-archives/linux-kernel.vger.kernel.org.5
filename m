Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E25B76FDE6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjHDJ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHDJ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E6246B1;
        Fri,  4 Aug 2023 02:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2916961F85;
        Fri,  4 Aug 2023 09:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A608C433C7;
        Fri,  4 Aug 2023 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691143029;
        bh=GZxlJRBNUUNRegf/6QkTddvnLTIAEmIkAFh1Y4lWRnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CaZBEFs7BtjQ8hWDDw9EzMSgS0QH4hNpLnyFKMv0QHr2WprpOb5af8E+4cOOG7aia
         EzGvjHIgO7MlviHtM9uabwHo57tFSEC3qvwIZgCJOYP3Y9829rvUXj+y2vCl1VWqAO
         ztQpNvQWbmUSaC4W3b05yAELRYCxTOWnpGrAcq/E=
Date:   Fri, 4 Aug 2023 11:57:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     stable@vger.kernel.org, mhiramat@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        sashal@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, xukuohai@huawei.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        rostedt@goodmis.org, weiyongjun1@huawei.com, gustavoars@kernel.org,
        namit@vmware.com, laijs@linux.alibaba.com,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 5.10 0/9] x86/kprobes: Fix kprobe debug exception
 handling logic
Message-ID: <2023080446-outcast-stumble-91f4@gregkh>
References: <20230705064653.226811-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705064653.226811-1-lihuafei1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 02:46:44PM +0800, Li Huafei wrote:
> We found an issue with null pointer access due to kprobe debug exception
> error handling on 5.10, and I proposed a separate fix patch for 5.10,
> see [1]. But as Greg gave advice, we always choose to backport relevant
> patches from upstream to fix issues with stable kernels, so I made this
> patch set.
> 
> The main one we need to backport is patch 5, which uses int3 instead of
> debug trap for single-stepping, thus avoiding the problems we
> encountered with kprobe debug exception error handling. Patches 1-4 are
> pre-patches, and patches 6-9 are fixes for patch 5. The major
> modifications are patch 2 and patch 5. Patch 2 optimizes
> resume_execution() to avoid repeated instruction decoding, and patch 5
> uses int3 instead of debug trap, and as Masami said in the commit
> message this patch will change some behavior of kprobe, but it has
> almost no effect on the actual usage.
> 
> Please let me know if there are any problems, thanks!

Looks good, thanks for the backports, all now queued up.

greg k-h
