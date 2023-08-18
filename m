Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65978128E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379349AbjHRSEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379371AbjHRSEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:04:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765E82D70
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:04:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04DF567EFC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 18:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85097C433CC;
        Fri, 18 Aug 2023 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692381861;
        bh=P15k+ZGTnh3saf8KGpHE9eVH30ID/HlxHmNdojIcpx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOJfCUsFtYqGREnA5GesxwE4BTL2LNH71u1NZ4aF2VXFru1FyM15kV4Tu9R7V2OA7
         +/5uGTenGy+RpjW1x8bWlf3xyAPg1E0cIk9u2f17rDT8/lI3+ph3i/BZdVdjruhbz9
         T7Vo2qKyfrTsdMeK0ed/TTP0h7pXr0m3/tOSTFDv7SvbZwilAs99mg0RcCeAT/VHp9
         dCbi4phDlRELTY/WZe6fIj+iPlaW/2lY+6UZ/+OsmO95bJadtTyrGUBO3JRklSqm+s
         x9lCIb8BtSKASOt5HJqIVyw33vkF8OiHWvIYic/8z8Uw1Vr+8QSak6hf6gg8FzhqHk
         bZCzQuOgJAcDQ==
From:   Will Deacon <will@kernel.org>
To:     Tomislav Novak <tnovak@meta.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Samuel Gosselin <sgosselin@google.com>
Subject: Re: [PATCH v2] hw_breakpoint: fix single-stepping when using bpf_overflow_handler
Date:   Fri, 18 Aug 2023 19:04:10 +0100
Message-Id: <169237465034.1400900.4830514571452045431.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230605191923.1219974-1-tnovak@meta.com>
References: <ZH40hgYbWc0x+1c3@tnovak-mbp.dhcp.thefacebook.com> <20230605191923.1219974-1-tnovak@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023 12:19:23 -0700, Tomislav Novak wrote:
> Arm platforms use is_default_overflow_handler() to determine if the
> hw_breakpoint code should single-step over the breakpoint trigger or
> let the custom handler deal with it.
> 
> Since bpf_overflow_handler() currently isn't recognized as a default
> handler, attaching a BPF program to a PERF_TYPE_BREAKPOINT event causes
> it to keep firing (the instruction triggering the data abort exception
> is never skipped). For example:
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] hw_breakpoint: fix single-stepping when using bpf_overflow_handler
      https://git.kernel.org/will/c/d11a69873d9a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
