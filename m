Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570597A6B48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjISTOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjISTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:14:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6A3B3;
        Tue, 19 Sep 2023 12:14:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17DCC433C8;
        Tue, 19 Sep 2023 19:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695150884;
        bh=O/2PHkyHfngUGOAxEJ3i8HsxP6TKXlPoENgLMx+44Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiayCZa5yefhuEjzC8nvlJhQAC5oXtcrzpnnAkMpevqdx9KHw5Y+bbQZonoxOl848
         KA8GwTHIsSedxxJ3qenKmZ7c/G4us5d3rhfWr3fuBxS/tfg74dU46Bgzz4aaqNhnan
         rYOAQtj8jwYmiIPo7UA8iarG7cm3lAlH4buESkFxDec0fRuObKMi763Vq1L2kwPphf
         qTw6XmhKb9e7a54OTs2r+aWPBLHOmsEdIvXockbxOrVR54/Bkrz0le3MCkNN4vpWR/
         gEzrzI2WQjTZqSfW6ZqFgOliGLpestKr3NTYNG9VqOhVfPDp4h0cI4SHOZtnDJUaxF
         q8KdQrK/77iHw==
Date:   Tue, 19 Sep 2023 12:18:53 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: rpmh: Include resource name in the trace event
Message-ID: <bvzh7acuaaz4twsku4bjj6pzmfjc4sqgcwn7bhy7yksiqllhrs@pvmysisfdgqd>
References: <20230707122713.37487-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707122713.37487-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 05:57:13PM +0530, Manivannan Sadhasivam wrote:
> The client drivers of RPMh like rpmhpd and bcm-voter has the name of the
> resource they are dealing with along with the address. So let's include
> the resource name in the RPMh trace event as it avoids doing a post
> processing of the trace event to resolve the resource name its address.
> 

Instead of extending the generic client API to pass the strings in (not
all clients are captured in this patch either), can't we do something
like dumping cmd-db into a trace_print_flags array during initialization
and use __print_symbolic() in TP_printk?

Although...for VRMs we probably want sym+<offset> in the output, so
__print_symbolic() isn't a perfect match...

Regards,
Bjorn
