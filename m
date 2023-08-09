Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFA1775632
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjHIJQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjHIJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:16:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC8C1FCE;
        Wed,  9 Aug 2023 02:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 891346309A;
        Wed,  9 Aug 2023 09:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4BDC433C7;
        Wed,  9 Aug 2023 09:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691572569;
        bh=9V4zZTiTx/OUaeehWA5kos6hj9j4FO0wAOEIeQtMA0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plM/dt4FUnY/BBMbowR2boeB0PV2QPQxyJhZWIUWFBYzFaHbWiSy0uAVukIIRxIJj
         Qbs5YH5fxisix6kwrqU+A9qH+YaVPi4wvt2UXE5876MpaOutCmLxqZdvV5X6XmHYj0
         pPNm1/Ov+grRbI7yNXDvXz38ZTXsEkRFEV3dN+1n+w6Ztvj4vJqYsHe7yYksDl5ELw
         CjG7hf1UbkWJXvJZLmUt/qXmb8XuuW6q0qAsEzAKpOHQGJw/gNiIg6zwtD0w6Vzv5z
         JKedvArhKS0Gt0WXPkoZcRrMjMJbrLG7vMPGQCpNUb0ajckB5MiyhxHRYKgeN/SYCX
         lEuAGgjvQAe6w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qTfIU-0002lc-1l;
        Wed, 09 Aug 2023 11:16:06 +0200
Date:   Wed, 9 Aug 2023 11:16:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Revert "wifi: ath11k: Enable threaded NAPI""
Message-ID: <ZNNZVsFb3_Dt_NMb@hovoldconsulting.com>
References: <20230809073432.4193-1-johan+linaro@kernel.org>
 <42f78c02-1ddc-cf1c-694f-abf9059dfb60@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f78c02-1ddc-cf1c-694f-abf9059dfb60@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 02:32:37PM +0530, Manikanta Pubbisetty wrote:
> On 8/9/2023 1:04 PM, Johan Hovold wrote:
> > This reverts commit d265ebe41c911314bd273c218a37088835959fa1.
> > 
> > Disabling threaded NAPI causes the Lenovo ThinkPad X13s to hang (e.g. no
> > more interrupts received) almost immediately during RX.
> > 
> > Apparently something broke since commit 13aa2fb692d3 ("wifi: ath11k:
> > Enable threaded NAPI") so that a simple revert is no longer possible.
> > 
> 
> This is getting as weird as it would get :)
> 
> > As commit d265ebe41c91 ("Revert "wifi: ath11k: Enable threaded NAPI"")
> > does not address the underlying issue reported with QCN9074, it seems we
> > need to reenable threaded NAPI before fixing both bugs properly.
> > 
> 
> It seems that the revert has actually solved the issue reported with 
> QCN9074.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=217536

Sure, but it's only a workaround as the underlying cause has not been
identified.

> We were trying to reproduce the problem on X86+QCN9074 (with threaded 
> NAPI) from quite some time, but there is no repro yet.
>
> Actually, enabling/disabling threaded NAPI is a simple affair; I'm 
> wondering to hear that interrupts are blocked due  to not having 
> threaded NAPI.

It sounds to me like the driver's locking is broken if moving to softirq
processing hangs the machine like this. But I have not had time to try
to try to track it down besides verifying that reenabling threaded NAPI
makes the problem go away.

> What is the chip that Lenovo Thinkpad X13s is having?

It's a WCN6855 (QCNFA765).

Johan
