Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE4762341
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGYUYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjGYUX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71C62125
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3638A618C4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C4FC433C7;
        Tue, 25 Jul 2023 20:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690316632;
        bh=gG72119h7FAYQdi8Nq5wXomT6VcOlyBbkc1rgAkFy68=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=C2Ky7VZWC6qCQV2Qk9xw1LlvMFQ/Ql3XdMJNBfLYSHcqAaU1ySH4EZsT8vbbvIT5E
         zQBkIMWV2em7L0JxciTgfhNTtkBO00G6EDokN7wWUgIRubXUJggfIB+uOTMRskSmq4
         VICv3wbGWzqMTErXJs1GAa9s/kzsedgxFq8655Bz0Ug8UjlFLIptBB9kLoWLCXRGEB
         JXdiNWJp2ML8aF5Rp/fZFdCmlt4yxOMZm5luft3Sp663BtZQl9SbXEJgzduwfHurF2
         tjyg2jxJFFLdQVnxKZSMnj+LihRpWRUFW2e4FyQGQ8Vxa19wfXysrQQKGBYyT/+W7A
         mYmOo3UqV/37A==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230714081408.274567-1-wenst@chromium.org>
References: <20230714081408.274567-1-wenst@chromium.org>
Subject: Re: [PATCH v3] regulator: Use bitfield values for range selectors
Message-Id: <169031663040.1614869.7587282767286947756.b4-ty@kernel.org>
Date:   Tue, 25 Jul 2023 21:23:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 16:14:07 +0800, Chen-Yu Tsai wrote:
> Right now the regulator helpers expect raw register values for the range
> selectors. This is different from the voltage selectors, which are
> normalized as bitfield values. This leads to a bit of confusion. Also,
> raw values are harder to copy from datasheets or match up with them,
> as datasheets will typically have bitfield values.
> 
> Make the helpers expect bitfield values, and convert existing users. The
> field in regulator_desc is renamed to |linear_range_selectors_bitfield|.
> This is intended to cause drivers added in the same merge window and
> out-of-tree drivers using the incorrect variable and values to break,
> preventing incorrect values being used on actual hardware and potentially
> producing magic smoke.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Use bitfield values for range selectors
      commit: 269cb04b601dd8c35bbee180a9800335b93111fb

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

