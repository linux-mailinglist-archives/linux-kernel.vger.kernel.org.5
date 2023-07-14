Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCDB753E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjGNPII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjGNPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:08:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6086F2702;
        Fri, 14 Jul 2023 08:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F349761D48;
        Fri, 14 Jul 2023 15:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591D0C433C7;
        Fri, 14 Jul 2023 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689347284;
        bh=ocPhOzFijupIUUD2Bp7JtiNo8d0/cn/ky2mmjm36hgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RcszFiUEGzq3FlUItGxNuvKWEHBh1AfacWryEi7hRHmCJ4Fd51i5qSG18fpY+OoNM
         as8q7Ii0vpGch75W8Tqc5213EyPArf+Um+Ic3cT47a/lfbyL7rwZboh/m/Yyevdc7A
         erYd1dUsqwryTaIohi60la+dY8EVLXwvJTlf3/tDcE3hlwdSoeKM3xKVKxVxprLoVz
         Vwh5sXKBmLQuRWFmOgtcaXx7CStoALoolBrdO1aYmDhVU++VNpmTWxtEmLUQ4ZsjAW
         Yf+8SgCp1dMQb64QanX1u9q8bKDcPQWQBhR/D62RAHmdYAqsuc1naL2IWaDyQE9lqT
         S+YTUzUN7dfpA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qKKOr-0004qL-0l;
        Fri, 14 Jul 2023 17:08:05 +0200
Date:   Fri, 14 Jul 2023 17:08:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/2] serial: qcom-geni: fix opp vote on shutdown
Message-ID: <ZLFk1Q0pTfYmB5EU@hovoldconsulting.com>
References: <20230714130214.14552-1-johan+linaro@kernel.org>
 <20230714130214.14552-2-johan+linaro@kernel.org>
 <e99b5975-b770-5460-1ce4-cd4eb1a50291@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99b5975-b770-5460-1ce4-cd4eb1a50291@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 04:29:08PM +0200, Konrad Dybcio wrote:
> On 14.07.2023 15:02, Johan Hovold wrote:
> > The operating-performance-point vote needs to be dropped when shutting
> > down the port to avoid wasting power by keeping resources like power
> > domains in an unnecessarily high performance state (e.g. when a UART
> > connected Bluetooth controller is not in use).
> > 
> > Fixes: a5819b548af0 ("tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state")
> > Cc: stable@vger.kernel.org      # 5.9
> > Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> I don't know a whole lot about this subsystem, but the PM call has
> a pointer to uport which already contains this clock rate.. Is it
> zeroed out by the core before we reach it, which would prevent us
> from reusing it?

No, but this driver has other issues and I couldn't be arsed fixing them
before addressing this bug.

Specifically that uartclk variable can currently be set by userspace...

I'll fix that up next week.

Johan
