Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107B27874C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbjHXP7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242370AbjHXP7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:59:25 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03BD6E50
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:59:24 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 84E4A2127C80; Thu, 24 Aug 2023 08:59:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 84E4A2127C80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692892763;
        bh=5A6FZVB5eWnbymKWXkBlkAfvCxZWBI2ubxpE/eKsggA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwCdcqDYbmfy3tXa+hOMp0G8tW+yi0DwODKEN7zViHTLeLHXItPL6dMndLrZ/VBzi
         7t9P5vEZjryF0oL78oTv5+jG3B23coluxAQeMMWei7V51TxRqIFKyKoZHpxN0u24Kb
         J62PSVVDO0YGMJ7q12YJ4KO1SRuNzeIhHDuPovS8=
Date:   Thu, 24 Aug 2023 08:59:23 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/numa: Add Devicetree support
Message-ID: <20230824155923.GA19733@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1687850882-22554-1-git-send-email-ssengar@linux.microsoft.com>
 <87edjscvdm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edjscvdm.ffs@tglx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-18.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 05:28:37PM +0200, Thomas Gleixner wrote:
> On Tue, Jun 27 2023 at 00:28, Saurabh Sengar wrote:
> > Hyper-V has usecases where it need to fetch NUMA information from
> > Devicetree. Currently, it is not possible to extract the NUMA
> > information from Devicetree for x86 arch.
> >
> > Add support for Devicetree in the x86_numa_init function, allowing
> > the retrieval of NUMA node information from the Devicetree.
> >
> > Additionally, relocate the x86_dtb_init function before initmem_init
> > to ensure the Devicetree initialization prior to its utilization in
> > x86_numa_init.
> 
> Moving dtb_init() is not really a good idea. The APIC/IO-APIC
> enumeration is post initmem_init() on purpose and the ongoing rework of
> the topology evaluation relies on that.
> 
> What you really want is to split dtb_init() into two parts:
> 
>    1) x86_flattree_get_config() which can be invoked before initmem init
>       like ACPI has an early init part so SRAT parsing can be done in
>       the numa initialization.
> 
>    2) The APIC/IOAPIC registration part, which stays where it is.
> 
> This split wants to be a seperate change.

Thanks for the review, I will send the v2 with suggested modifications.

- Saurabh

> 
> Thanks,
> 
>         tglx
> 
> 
> 
>    
