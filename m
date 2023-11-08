Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE15F7E5C76
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjKHReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjKHReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:34:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A365D1FFB;
        Wed,  8 Nov 2023 09:34:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55671C433C8;
        Wed,  8 Nov 2023 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699464858;
        bh=Ah6iBp9HdqknRL2F6W3dtE7zQoOycFU874dPjnGq0tU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B9mEuPTDSO82zZ2L0rAgeCyvhTwNG9AkwP+YbOFgTu1qV49ACP1iYtfx3vHo/Fdcb
         rOXcOVd/ZvmFXK1kp01onF2RhJ7DWozmt10JcTLDZ3QFmOaT00LfFHJ+lTOBhrAvRK
         l6X1+I7YQi9y113faFVTJB1+jCO0AdNfg6l8e9QiljOFziW+9Yf8Ff4IrPQLtPfn6a
         m1gJeBaZV/U28c4YKQqNFszbSOM7uzwrOpcgqEVtGV7hGMGWHHNzzCulDxL+qRA3/B
         UNZ3oxvGD5rGBNHv8BCG04jdvpDsE5YIdMAQs10336syTA9u6cBpq+UhWnWibRLjTD
         FlU9bXd6SShsQ==
From:   Mark Brown <broonie@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Mark Hasemeyer <markhas@chromium.org>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20231107144743.v1.1.I7987f05f61901f567f7661763646cb7d7919b528@changeid>
References: <20231107144743.v1.1.I7987f05f61901f567f7661763646cb7d7919b528@changeid>
Subject: Re: [PATCH v1] spi: Fix null dereference on suspend
Message-Id: <169946485678.3169019.15980438367313044998.b4-ty@kernel.org>
Date:   Wed, 08 Nov 2023 17:34:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2023 14:47:43 -0700, Mark Hasemeyer wrote:
> A race condition exists where a synchronous (noqueue) transfer can be
> active during a system suspend. This can cause a null pointer
> dereference exception to occur when the system resumes.
> 
> Example order of events leading to the exception:
> 1. spi_sync() calls __spi_transfer_message_noqueue() which sets
>    ctlr->cur_msg
> 2. Spi transfer begins via spi_transfer_one_message()
> 3. System is suspended interrupting the transfer context
> 4. System is resumed
> 6. spi_controller_resume() calls spi_start_queue() which resets cur_msg
>    to NULL
> 7. Spi transfer context resumes and spi_finalize_current_message() is
>    called which dereferences cur_msg (which is now NULL)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix null dereference on suspend
      commit: 4f646616d11c3ec3f5a5cb2cd683cfc0fa9a5018

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

