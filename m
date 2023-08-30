Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621CB78DF76
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbjH3TUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242670AbjH3JOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:14:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0212FD2;
        Wed, 30 Aug 2023 02:14:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 303B92F4;
        Wed, 30 Aug 2023 02:15:15 -0700 (PDT)
Received: from bogus (unknown [10.57.36.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 689003F64C;
        Wed, 30 Aug 2023 02:14:34 -0700 (PDT)
Date:   Wed, 30 Aug 2023 10:13:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Pawandeep Oza <poza@qti.qualcomm.com>
Cc:     "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: ACPI binding with SCMI
Message-ID: <20230830091337.4rsik2tza6hqa22r@bogus>
References: <20230807154834.888328-1-quic_poza@quicinc.com>
 <20230818091931.iqh6bxiifk4wyc32@bogus>
 <CH0PR02MB80732F4C4134B3EF2D80B4EDF6E3A@CH0PR02MB8073.namprd02.prod.outlook.com>
 <20230829091912.xefuenspdbazvqlh@bogus>
 <CH0PR02MB807367CCAD0D5938C4679E18F6E7A@CH0PR02MB8073.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR02MB807367CCAD0D5938C4679E18F6E7A@CH0PR02MB8073.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:10:34PM +0000, Pawandeep Oza wrote:
> I am looking for scmi binding to ACPI. Basically, SCMI based perf control.
> We have ACPI based system, so I am looking for where I can describe (some
> way to describe doorbell and share memory in ACPI), and then scmi perf can
> bind to it via some sort of transport (perhaps fastchannels ? )

OK, the Section 5.2 ACPI-based Transport in the SCMI spec can be more clearer
IMO. It does state:
" SCMI FastChannels can be represented as ACPI System Memory and used
  in the Continuous Performance Control (CPC) object when using ACPI 
  Collaborative Processor Performance Control (CPPC)."

It doesn't cover the fact that CPPC is compatible only with SCMI fastchannels
without doorbells. Just a plain MMIO register to set the perf.

The normal PCC mailbox works fine if the CPPC Desired Perf Register is
a PCC address space based GAS. However the command is not 1:1 compatible
with SCMI perf. This is one of the reason why the protocols 0x0-0xF was
reserved in SCMI to be compatible with the ACPI CPPC way of using PCC
for perf.

Hope this helps and I didn't make it more complicated for you.

--
Regards,
Sudeep
