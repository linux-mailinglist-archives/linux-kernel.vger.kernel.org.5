Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADF47A47B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjIRK7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjIRK7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:59:38 -0400
X-Greylist: delayed 2487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 03:59:31 PDT
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [217.182.43.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012408F;
        Mon, 18 Sep 2023 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=misterjones.org; s=dkim20211231; h=Content-Transfer-Encoding:Content-Type:
        Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Rf3oBTobynCkWOSW7RaPnv2qaYiAOqlAuJa1OgOSghY=; b=H5DmuluYmNKZkwLh8AMrPH6+mc
        z7C5Og2qQtznC4v36fDdiKzpf1PWKQKlMipPwryK5Hghmo2tBXU9OPdl6n5wuHatHlec+CY04EMcH
        ChM/ASRN1fbCYZUGNaNWGoZieu9txh78kj/pyE6GszBt/yKSr8ohHK9l2jzkOsrKHisZsLne+1ObT
        0KtdMCFF+/GSwmbuqakADTcxsGkxjLfQZmofnptYZ9zm6WquuOMq2EqgMI4mEsGxjMpbstNWo157q
        ZvFj9J68EiywlAhNAH2dUGaXAj2wUyp0eaHVWx9WTiOyE7N6W9ez+9UiePvGycjm2N8JlhIK4C/zD
        BmiDBCzQ==;
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@misterjones.org>)
        id 1qiBK7-00DuwM-5E;
        Mon, 18 Sep 2023 11:17:47 +0100
MIME-Version: 1.0
Date:   Mon, 18 Sep 2023 11:17:46 +0100
From:   Marc Zyngier <maz@misterjones.org>
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: errata: Add Cortex-A520 speculative
 unprivileged load workaround
In-Reply-To: <20230918100102.GA17472@willie-the-truck>
References: <20230912121120.380420-1-robh@kernel.org>
 <20230912121120.380420-2-robh@kernel.org>
 <20230918100102.GA17472@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <dcb12b18edc02634be3ac9909fa70602@misterjones.org>
X-Sender: maz@misterjones.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: robh@kernel.org, will@kernel.org, catalin.marinas@arm.com, corbet@lwn.net, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-18 11:01, Will Deacon wrote:
> On Tue, Sep 12, 2023 at 07:11:15AM -0500, Rob Herring wrote:
>> Implement the workaround for ARM Cortex-A520 erratum 2966298. On an
>> affected Cortex-A520 core, a speculatively executed unprivileged load
>> might leak data from a privileged level via a cache side channel.
>> 
>> The workaround is to execute a TLBI before returning to EL0. A
>> non-shareable TLBI to any address is sufficient.
> 
> Can you elaborate at all on how this works, please? A TLBI addressing a
> cache side channel feels weird (or is "cache" referring to some TLB
> structures rather than e.g. the data cache here?).
> 
> Assuming there's some vulnerable window between the speculative
> unprivileged load and the completion of the TLBI, what prevents another
> CPU from observing the side-channel during that time? Also, does the
> TLBI need to be using the same ASID as the unprivileged load? If so, 
> then
> a context-switch could widen the vulnerable window quite significantly.

Another 'interesting' case is the KVM world switch. If EL0 is
affected, what about EL1? Can such a data leak exist cross-EL1,
or from EL2 to El1? Asking for a friend...

         M.
-- 
Who you jivin' with that Cosmik Debris?
