Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ADE75854F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGRTEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGRTEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DBEF0;
        Tue, 18 Jul 2023 12:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D42A9616A9;
        Tue, 18 Jul 2023 19:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629B9C433C8;
        Tue, 18 Jul 2023 19:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689707069;
        bh=i5arC158buhsdER1IymQJe0RxYirolmyN139FgwqBgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P97MfToE5RbdIFjMz+1v/9qWwXzXMD+ovmg0kJQyqGn6DLx5kltZ0f/Y9UbGHR/y1
         jnL/d8bQPzol/2shPFRqxxFa0YvUY4gXb2aG2vgJxhpdl8zsEq8QLHGRmRFRCoOD/E
         bQh+XMuQXf/ilFFpxDjc+kRskboLgay+4g2mY50/mu/KBxyQ5Loi2ALZzeyuj5D0fI
         crzUsjgP3VZaWVQkDQTAjqiNGnSZA81yWx6oKAVyLYnxBaI0CcfiffRpMP3c5Js6RF
         jBx2f10QnjvvY56pMPzoMBo0CySNecDwtN7hlIpkPab4iFx50QddZ/y1d0fCdLrKhq
         PS9YA46u0hW9w==
Date:   Tue, 18 Jul 2023 12:07:52 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
Message-ID: <6uelwa7fpzbw757rbb2j3u4ogagypdzyqj5mykyhlkkkvrnfin@ttonjpfn7nxc>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-3-quic_nkela@quicinc.com>
 <xkw36iwjb47q7spf6qle5x3kcmx6fv7or6cwhlpkuvihn3xmt2@qhrhtug4htp2>
 <5c76250b-4415-950e-6aab-7ccbdc6ca83a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c76250b-4415-950e-6aab-7ccbdc6ca83a@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:53:24AM -0700, Nikunj Kela wrote:
> On 7/18/2023 11:29 AM, Bjorn Andersson wrote:
> > On Tue, Jul 18, 2023 at 09:08:33AM -0700, Nikunj Kela wrote:
> > > diff --git a/drivers/firmware/arm_scmi/qcom_hvc.c b/drivers/firmware/arm_scmi/qcom_hvc.c
[..]
> > > +static int qcom_hvc_chan_setup(struct scmi_chan_info *cinfo,
> > > +			       struct device *dev, bool tx)
> > > +{
[..]
> > > +	/* let's map 2 additional ulong since
> > > +	 * func-id & capability-id are kept after shmem.
> > > +	 *     +-------+
> > > +	 *     |       |
> > > +	 *     | shmem |
> > > +	 *     |       |
> > > +	 *     |       |
> > > +	 *     +-------+ <-- size
> > > +	 *     | funcId|
> > > +	 *     +-------+ <-- size + sizeof(ulong)
> > > +	 *     | capId |
> > > +	 *     +-------+ <-- size + 2*sizeof(ulong)
> > Relying on an undocumented convention that following the region
> > specified in DeviceTree are two architecture specifically sized integers
> > isn't good practice.
> > 
> > This should be covered by the DeviceTree binding, in one way or another.
> 
> ok. Usually, DTBs don't allow non-hw properties in the dtb. I can try adding
> a property as cap-id-width if its allowed.
> 

If you remove the additional part, per the next comment, DeviceTree
would be oblivious to these properties. I'll don't know if the
DeviceTree people have any concerns/suggestions about this.

> 
> > 
> > > +	 */
> > > +
> > > +	scmi_info->shmem = devm_ioremap(dev, res.start,
> > > +					size + 2 * sizeof(unsigned long));
> > I don't find any code that uses the size of the defined shm, so I don't
> > think you need to do this dance.
> Right! I can remove the addition part.
> > 
> > > +	if (!scmi_info->shmem) {
> > > +		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
> > > +		return -EADDRNOTAVAIL;
> > > +	}
> > > +
> > > +	func_id = readl((void *)(scmi_info->shmem) + size);
> > > +
> > > +#ifdef CONFIG_ARM64
> > > +	cap_id = readq((void *)(scmi_info->shmem) + size +
> > > +		       sizeof(unsigned long));
> > > +#else
> > > +	cap_id = readl((void *)(scmi_info->shmem) + size +
> > > +		       sizeof(unsigned long));
> > > +#endif
> > Please don't make the in-memory representation depend on architecture
> > specific data types. Quite likely you didn't compile test one of these
> > variants?
> > 
> > Just define the in-memory representation as u32 + u64.
> I tested this for ARM64, I didn't test it for 32bit since Hypervisor doesn't
> support it currently. In future, it may add 32 bit support too.

I'd not be surprised if the capability id is 64 bit on a 32-bit machine
as well, it's not really a property of the architecture.

But regardless, always using 64 bits in your memory representation will
at worst waste a few bytes. But the result is a better defined
interface, and you can avoid the conditional code.

Regards,
Bjorn
