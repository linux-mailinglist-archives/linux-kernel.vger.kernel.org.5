Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B54782A83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjHUN2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjHUN2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2277AB4;
        Mon, 21 Aug 2023 06:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D086372D;
        Mon, 21 Aug 2023 13:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10220C433C8;
        Mon, 21 Aug 2023 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692624477;
        bh=i1odpy9BeOmNPTWxlRoAMrhEEMbIwj1pbTOY9KKPZeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPkNEl6/sZsNOO7hnkESOVkJiuLB3ImiCAMusKYgsIKfwzRl6u6U5anBlUN0ShREn
         cbMKP2iDLHEREbGxqIOWnMYvkm/7IgkDFGnIPH8fa4s9+1z7oAcz8lFAuzudl+vRDG
         8uWQqXoIOsrHcHnMhNHAhSWd2MP/XPeI6h9f1erOjCMSwnJylHYgF/RF1dbd6ovAEw
         gQ2lEtbxt0NxmU0wYQAUuzubWa+vkNgTnqAWkUSOeCQzyy84SPVXembMrzduKwFYJG
         GV4fP+oZRyOeYBfMnexNb7d2eTgI1LrMhTTjszLSPGeY73z8KPCp4TFBdwlZWHYUaY
         VHiGqNnfp9mzQ==
Received: from johan by theta with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qY4wi-0000h7-1A;
        Mon, 21 Aug 2023 15:27:52 +0200
Date:   Mon, 21 Aug 2023 15:27:52 +0200
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
Message-ID: <ZONmWLcRKngCg9Rl@hovoldconsulting.com>
References: <20230809073432.4193-1-johan+linaro@kernel.org>
 <42f78c02-1ddc-cf1c-694f-abf9059dfb60@quicinc.com>
 <ZNNZVsFb3_Dt_NMb@hovoldconsulting.com>
 <85d7c7a3-7a11-bae0-6f37-5da9280792aa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d7c7a3-7a11-bae0-6f37-5da9280792aa@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:03:55AM +0530, Manikanta Pubbisetty wrote:
> On 8/9/2023 2:46 PM, Johan Hovold wrote:
> > On Wed, Aug 09, 2023 at 02:32:37PM +0530, Manikanta Pubbisetty wrote:
> > > On 8/9/2023 1:04 PM, Johan Hovold wrote:
> > > > This reverts commit d265ebe41c911314bd273c218a37088835959fa1.
> > > > 
> > > > Disabling threaded NAPI causes the Lenovo ThinkPad X13s to hang (e.g. no
> > > > more interrupts received) almost immediately during RX.
> > > > 
> > > > Apparently something broke since commit 13aa2fb692d3 ("wifi: ath11k:
> > > > Enable threaded NAPI") so that a simple revert is no longer possible.

> > > What is the chip that Lenovo Thinkpad X13s is having?
> > 
> > It's a WCN6855 (QCNFA765).
> 
> WCN6855 & QCN9074 share the same driver code base since both being PCIe
> devices. One working and another not working seems to be surprising. Do you
> have a dmesg log when this problem occurred?

I can't access the logs after I hit this bug (e.g. as there are no
interrupts received from the keyboard) but when I trigger this from the
console, there is nothing logged when the hang happens.

Later, secondary errors are logged from other drivers that are no longer
receiving interrupts either, and RCU detects a stall as I mentioned
elsewhere.

Johan
