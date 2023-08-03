Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9976EB10
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjHCNpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjHCNpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F2C46B7;
        Thu,  3 Aug 2023 06:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48AF761DA0;
        Thu,  3 Aug 2023 13:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC810C433C7;
        Thu,  3 Aug 2023 13:43:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SUsln0++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691070224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xCU98+BgwiTKpHLQhh9e4UzgsAB86GLhVoIzJKGYlgo=;
        b=SUsln0++WZ5AA8asjvTLVN+BS2ZUwXUM3ZEM8kz2K/5siBTfIvhIUOHhzt0Ula/B5WaNaY
        XAP253sX2JOtIMtNlWQ0OQ7+E/RBQyLaojKtY84TER2Q7mEuvSoCqacvCFLSlLbRktATGu
        E80mhwPMdj9okVXXE0AkTtMMaZwm1/U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eac8e714 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Aug 2023 13:43:42 +0000 (UTC)
Date:   Thu, 3 Aug 2023 15:42:31 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     jarkko@kernel.org, peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, dragonn@op.pl
Subject: Re: [PATCH 2/3] tpm: Add command line for not trusting tpm for RNG
Message-ID: <ZMuux5CE1xIR7Mc3@zx2c4.com>
References: <20230803015015.915-1-mario.limonciello@amd.com>
 <20230803015015.915-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230803015015.915-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 08:50:14PM -0500, Mario Limonciello wrote:
> The kernel supports random.cpu=off and random.bootloader=off.
> As TPM RNG is also registered as a hwrng, add the ability to
> prevent registering the TPM RNG.

Please do *not* do this. I agree with Jarkko that this doesn't belong.

Firstly, you're proposing a flag for the tpm driver, so the `random.`
namespace is inappropriate. Do not use the `random.` namespace if you're
not dealing with random.c specifically. Rather, this is very much a
`tpm.register_hwrng=1/0` flag, which describes better what this is about.

Secondly, I think you're making a mountain out of a molehill. You first
wanted to also disable Intel devices too, even though they aren't
affected by this bug. Now you're proposing a way for users to disable
everything. But so far there's no evidence that this matter goes any
further than AMD's fTPM. So let's calm a bit and not make too big deal
of this. If we suddenly get lots of reports that there's broken behavior
across the board, then maybe we should consider something like this. But
insofar as this is just an AMD derp, let's keep it simple and not over
complicate everything with more knobs. Fewer knobs, please!

Finally, with regards to AMD, my hope is that eventually the fTPM
becomes useful as a hwrng, and then we can relax the disabling to
re-enable it for whatever new revision might come to exist in the
future.

Thanks,
Jason
