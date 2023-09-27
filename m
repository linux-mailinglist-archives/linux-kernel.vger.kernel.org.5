Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081667AFA90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjI0GBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjI0GAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:00:54 -0400
Received: from out-191.mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F4B10E9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:00:29 -0700 (PDT)
Date:   Wed, 27 Sep 2023 06:00:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695794425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hbQpc4UesV7IX0JvCrTUx6QA3LAg9gDtHymuaQldZw=;
        b=eifoM+TFNp9/h7Xw9Ksm3RmCyTja/wb9Dr3OWTc22KJpHs9wmNbtVeET3FYkloyTu7fIjd
        E4bRUlHqgYeMPyaiXAUsLVgNAXBqbN2+i4L2JojMXPPPRKd61taTGJJYHyYST+kc+3gprs
        QgKoQIfrsbwo964baGJO29+Ss2z6v/0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] KVM: arm64: Support for Arm v8.8 memcpy
 instructions in KVM guests
Message-ID: <ZRPE9OcB9ndgFxbs@linux.dev>
References: <20230922112508.1774352-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922112508.1774352-1-kristina.martsenko@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kristina,

On Fri, Sep 22, 2023 at 12:25:06PM +0100, Kristina Martsenko wrote:
> Hi,
> 
> This is v2 of the series to allow using the new Arm memory copy instructions
> in KVM guests. See v1 for more information [1].


Thanks for sending out the series. I've been thinking about what the
architecture says for MOPS, and I wonder if what's currently in the
Arm ARM is clear enough for EL1 software to be written robustly.

While HCRX_EL2.MCE2 allows the hypervisor to intervene on MOPS
exceptions from EL1, there's no such control for EL0. So when vCPU
migration occurs EL1 could get an unexpected MOPS exception, even for a
process that was pinned to a single (virtual) CPU implementation.

Additionally, the wording of I_NXHPS seems to suggest that EL2 handling
of MOPS exceptions is only expected in certain circumstances where EL1 is
incapable of handling an exception. Is the unwritten expectation then
that EL1 software should tolerate 'unexpected' MOPS exceptions from EL1
and EL0, even if EL1 did not migrate the PE context?

Perhaps I'm being pedantic, but I'd really like for there to be some
documentation that suggests MOPS exceptions can happen due to context
migration done by a higher EL as that is the only option in the context
of virtualization.

-- 
Thanks,
Oliver
