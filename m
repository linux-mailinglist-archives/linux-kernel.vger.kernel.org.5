Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6177DA4CC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 04:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjJ1CNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 22:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1CNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 22:13:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D32FB;
        Fri, 27 Oct 2023 19:13:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921F2C433C7;
        Sat, 28 Oct 2023 02:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698459198;
        bh=SP4XRBefB7saZs3AVFDrH14uJmpfek50CqylL2w0XhY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Go6m+efwnkyKZFLqYKfiPTqolZBTW4oKJxglZCgGOd83fwNMCycMVbrNzkRohpSbb
         Zxvsyh2QH13GMtOIGytzbZYYZC7p1ITl6HdPXP7DmDfASeXg+vw4PLTcY5Z82TrpP+
         p4CzGmEJXzVDseM7eT67xJ1z+VmWaFRv4NVAuEZuQBg6mSX+KFIL2AUnnelWy8hRk+
         KGHICGCz9uxdYiRitzLVRr6lGmkTvHV80BhsCoI4YwzrXoJ9Cogh0/oM5IwMdAEB+/
         NUFvewg8QVvJprFtspdqRiuNrRQPMhKd4+1+SOUmmqJB1NmH0AtMqPN5peKTTwZn64
         MmRW+4gj8PM/g==
Message-ID: <c0bc8db56b0ddad197b4e5ee7cd720be.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231027225821.95833-1-sboyd@kernel.org>
References: <20231027225821.95833-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: Fix clk gate kunit test on big-endian CPUs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 27 Oct 2023 19:13:16 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2023-10-27 15:58:21)
> The clk gate kunit test checks that the implementation of the basic clk
> gate reads and writes the proper bits in an MMIO register. The
> implementation of the basic clk gate type uses writel() and readl()
> which operate on little-endian registers. This test fails on big-endian
> CPUs because the clk gate implementation writes to 'fake_reg' with
> writel(), which converts the value to be written to little-endian before
> storing the value in the fake register. When the test checks the bits in
> the fake register on a big-endian machine it falsely assumes the format
> of the register is also big-endian, when it is really always
> little-endian. Suffice to say things don't work very well.
>=20
> Mark 'fake_reg' as __le32 and push through endian accessor fixes
> wherever the value is inspected to make this test endian agnostic.
> There's a CLK_GATE_BIG_ENDIAN flag for big-endian MMIO devices, which
> this test isn't using. A follow-up patch will test with and without that
> flag.
>=20
> Reported-by: Boqun Feng <boqun.feng@gmail.com>
> Closes: https://lore.kernel.org/r/ZTLH5o0GlFBYsAHq@boqun-archlinux
> Tested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
