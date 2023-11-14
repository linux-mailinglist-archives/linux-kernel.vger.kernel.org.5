Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0647EB931
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjKNWOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjKNWON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:14:13 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BB1D5;
        Tue, 14 Nov 2023 14:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=QKV+COsbMm3ctH/hvmRLz2+UD4oEDJrHvUBihvmpKl0=; b=5ZscZ+b4Y6Fa5+ao0U5ZLxtWL/
        Lvg+gL3+5QOL1DpachQ++s1Iw7cMVRqFXKshdJLB1KtLBaD3enJOqz4X3Da5XUADRRBDKgywLcodR
        JwgYk/u01L9eGzQLiWbMpydD6tygpbJP08J/j351y6srY0SMbVqK7akgSjpkCRFuW9YA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r31fN-000CJm-U0; Tue, 14 Nov 2023 23:13:53 +0100
Date:   Tue, 14 Nov 2023 23:13:53 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: fix FPE events losing
Message-ID: <6caf2c31-70f9-4866-888c-cb6af3839845@lunn.ch>
References: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 11:07:34AM +0000, Jianheng Zhang wrote:
> The 32-bit access of register MAC_FPE_CTRL_STS may clear the FPE status
> bits unexpectedly. Use 8-bit access for MAC_FPE_CTRL_STS control bits to
> avoid unexpected access of MAC_FPE_CTRL_STS status bits that can reduce
> the FPE handshake retries.
> 
> The bit[19:17] of register MAC_FPE_CTRL_STS are status register bits.
> Those bits are clear on read (or write of 1 when RCWE bit in
> MAC_CSR_SW_Ctrl register is set). Using 32-bit access for
> MAC_FPE_CTRL_STS control bits makes side effects that clear the status
> bits. Then the stmmac interrupt handler missing FPE event status and
> leads to FPE handshake failure and retries.

Is it possible to call the core of stmmac_fpe_irq_status() to extract
the information from these bits and then call
stmmac_fpe_event_status()?

Alternatively, can you actually set RCWE in MAC_CSR_SW_Ctrl and add a
mask to dwmac5_fpe_configure() etc so they don't write 1 to these
bits? That seems safer than assuming 8 bit reads work.

      Andrew

