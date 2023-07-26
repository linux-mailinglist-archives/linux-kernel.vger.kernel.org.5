Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072A6762B08
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjGZF6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjGZF6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F35170D;
        Tue, 25 Jul 2023 22:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACC65615F0;
        Wed, 26 Jul 2023 05:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A48C433C8;
        Wed, 26 Jul 2023 05:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690351086;
        bh=wdDUWWLGKY/0b5qmLazgZKL+qx2jfNkIERNSCJhI2Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sf1W+CCwC50u6xijnDsJhrPB1Gr0HDAQQDnwsQ8ko3Hgn6/iFU7lI1Tx5SlUGIIU8
         mFaTh1V5WK40BkCm/ih8timG+aKJ8DDPS3VaMeuSzWnlA9xQS1wiwrIFcXjCCLJ2lW
         TVjfjuM+o9iAXN38g7jcX/be5b9pnrN448YX7yC/MpfKGFXVQKedNoBDmJAsT1M6Re
         m6mpg2KdL7EmJ5Cv/hvPODuLxwBhVWy2r90IbUYyH2Y/g0n+nMNL4g1oHPYLj5maSd
         w0rDP5klLRdht9DFiTzvo5oOy5RLPgBndjZsmOyZiX1xfjIrA1GP1VJNxJsM/AZM6k
         Rj6nIdzWUzOSA==
Date:   Tue, 25 Jul 2023 23:01:19 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: spi-qcom-qspi: Fallback to PIO for xfers that
 aren't multiples of 4 bytes
Message-ID: <pofajdrzzajqlphg6om3b5clw6kmbpx2cbdasbcv3lwx6gxyja@urzrfcctthj7>
References: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:02:26AM -0700, Douglas Anderson wrote:
> The Qualcomm QSPI driver appears to require that any reads using DMA
> are a mutliple of 4 bytes. If this isn't true then the controller will
> clobber any extra bytes in memory following the last word. Let's
> detect this and falback to PIO.
> 
> This fixes problems reported by slub_debug=FZPUA, which would complain
> about "kmalloc Redzone overwritten". One such instance said:
> 
>   0xffffff80c29d541a-0xffffff80c29d541b @offset=21530. First byte 0x0 instead of 0xcc
>   Allocated in mtd_kmalloc_up_to+0x98/0xac age=36 cpu=3 pid=6658
> 
> Tracing through what was happening I saw that, while we often did DMA
> tranfers of 0x1000 bytes, sometimes we'd end up doing ones of 0x41a
> bytes. Those 0x41a byte transfers were the problem.
> 
> NOTE: a future change will enable the SPI "mem ops" to help avoid this
> case, but it still seems good to add the extra check in the transfer.
> 
> Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
