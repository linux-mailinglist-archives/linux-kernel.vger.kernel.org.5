Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967A27AB2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjIVNqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjIVNq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:46:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F44CC0;
        Fri, 22 Sep 2023 06:46:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172F5C433C8;
        Fri, 22 Sep 2023 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695390377;
        bh=DM7Txi2MoiWZBA9K95f7zgHK56suYUEDbpXwcyC9bD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umEVFJrGGX/MrNunUQYkUy82x6LqEdrfsD8jygjAXXFDYOwO9AhUPrLzeJyAk2eKM
         EH2X9Hkf76IauDXpS2AtvTuNAjzbnmlRzsaELCQhfLhJN8MLsA0+b2XMButKL718IS
         jChUXG643/daHsdqciafR74kJ24ObxXfg7CRvi5dPA2o1UOuulsOvmPwK0mypO++WG
         clYbjTQxh0DvrGn0389fsg7fO0ljlnsctrDL9tFAY3aVwwL57w4Tj0Jn+SMjiibfx+
         wqbLSshF7hKZDB1vhRbyg8SgKE+M+VPDn9HpJiLjCLgBoldFrEs5TsiShoToeN9o2r
         eLbMGg1RGIofA==
Date:   Fri, 22 Sep 2023 06:50:22 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] soc: qcom: rmtfs: Support discarding guard pages
Message-ID: <4dreta5y4rxzrfzeuomm42oszoohus5fg7hhsstx7kzo5kjive@6mosi67enick>
References: <20230920-rmtfs-mem-guard-pages-v3-0-305b37219b78@quicinc.com>
 <20230920-rmtfs-mem-guard-pages-v3-2-305b37219b78@quicinc.com>
 <ZQyFliFYV7dUwGJg@gerhold.net>
 <j5ivvbjprgdcekujzjiobk7gpoaz3jxpnda5dsgoh6f4hsn5id@3ug5i74ubkqf>
 <ZQ1DmSRIe56WQmnK@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ1DmSRIe56WQmnK@gerhold.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 09:35:00AM +0200, Stephan Gerhold wrote:
> eOn Thu, Sep 21, 2023 at 07:51:42PM -0700, Bjorn Andersson wrote:
> > On Thu, Sep 21, 2023 at 08:04:06PM +0200, Stephan Gerhold wrote:
> > > On Wed, Sep 20, 2023 at 07:37:31PM -0700, Bjorn Andersson wrote:
> > > > In some configurations, the exact placement of the rmtfs shared memory
> > > > region isn't so strict. The DeviceTree author can then choose to use the
> > > > "size" property and rely on the OS for placement (in combination with
> > > > "alloc-ranges", if desired).
> > > > 
> > > > But on some platforms the rmtfs memory region may not be allocated
> > > > adjacent to regions allocated by other clients. Add support for
> > > > discarding the first and last 4k block in the region, if
> > > > qcom,use-guard-pages is specified in DeviceTree.
> > > > 
> > > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > > ---
> > > >  drivers/soc/qcom/rmtfs_mem.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> > > > index f83811f51175..83bba9321e72 100644
> > > > --- a/drivers/soc/qcom/rmtfs_mem.c
> > > > +++ b/drivers/soc/qcom/rmtfs_mem.c
> > > > @@ -200,6 +200,15 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
> > > >  	rmtfs_mem->client_id = client_id;
> > > >  	rmtfs_mem->size = rmem->size;
> > > >  
> > > > +	/*
> > > > +	 * If requested, discard the first and last 4k block in order to ensure
> > > > +	 * that the rmtfs region isn't adjacent to other protected regions.
> > > > +	 */
> > > > +	if (of_property_present(node, "qcom,use-guard-pages")) {
> > > 
> > > I think of_property_read_bool() would be more fitting here. Right now
> > > of_property_present() is just a wrapper around of_property_read_bool().
> > > Semantically reading a bool fits better here though. :-)
> > > 
> > 
> > Are you saying that you would prefer this to be a bool, so hat you can
> > give it a "false" value? Or you are simply saying "it walks like a
> > boolean, quacks like a boolean, let's use the boolean accessor"?
> > 
> 
> The latter. I would expect that of_property_present() is used for
> properties which usually have a value, while of_property_read_bool()
> is used for pure bool values which can be present or not but must not
> have a value. I think a "bool" in terms of DT is simply a present or
> not-present property without any value?
> 
> For example consider
> 
>   regulator-min-microvolts = <4200000000>;
>   regulator-always-on;
> 
> Then I would expect
> 
>   - of_property_present(..., "regulator-min-microvolts"), but
>   - of_property_read_bool(..., "regulator-always-on")
> 
> Does that make sense? :D
> 

Certainly, of_property_read_duck() it is.

Thanks,
Bjorn
