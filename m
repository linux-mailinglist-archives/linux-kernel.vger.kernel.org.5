Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764047D4545
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjJXCBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjJXCBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:01:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B928DC2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:01:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2750C433C7;
        Tue, 24 Oct 2023 02:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698112899;
        bh=fc3NKMfZoje2hmQNMCXwrEeKB9yHVquKxP4o2hHyQ+A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Pv5Cwg6lrfNB4MajdApvNEULjDz3t0D2/xLwROHqGAQ0KyWhnAq3U/HwPS07lav57
         0RuuIPkEZCxv6FsT9lB1DD10IxtXfng+3fjyxJOAFuHJBhdrawOg3GJp6twfi1r0SK
         ADO2tr3Smk5HojfVBb0dRqABH7e8ld9VsbBdRPeL8+TwSOZ7NGmVmjSH6IXf58AUiV
         IzQzHFB0VOC90BRHf5tCREzTJhB5A+wR1rQj3Biykm1aXpIlgM33AtD2TWWZQQqHxj
         ej7u+EDYAcEYkC/wnM8e5y8pbx8IxAvbzqzBM8GxULHDiQ3MZBRPhEOP1XV3vxcNBa
         79E//dVbSaOgg==
Message-ID: <c113be74d0ad1a7c94d313716e2fb8bd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid>
References: <20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid>
Subject: Re: [PATCH] spmi: mediatek: Fix UAF on device remove
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Yu-Che Cheng <giver@chromium.org>, Fei Shao <fshao@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
To:     James Lo <james.lo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yu-Che Cheng <giver@chromium.org>
Date:   Mon, 23 Oct 2023 19:01:36 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yu-Che Cheng (2023-07-17 02:39:35)
> The pmif driver data that contains the clocks is allocated along with
> spmi_controller.
> On device remove, spmi_controller will be freed first, and then devres
> , including the clocks, will be cleanup.
> This leads to UAF because putting the clocks will access the clocks in
> the pmif driver data, which is already freed along with spmi_controller.
>=20
> This can be reproduced by enabling DEBUG_TEST_DRIVER_REMOVE and
> building the kernel with KASAN.
>=20
> Fix the UAF issue by using unmanaged clk_bulk_get() and putting the
> clocks before freeing spmi_controller.
>=20
> Reported-by: Fei Shao <fshao@chromium.org>
> Signed-off-by: Yu-Che Cheng <giver@chromium.org>
> ---

Applied to spmi-next
