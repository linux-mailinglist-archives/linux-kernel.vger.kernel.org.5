Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC098073B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379191AbjLFPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379142AbjLFPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:32:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ED28F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:32:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B75DC433C7;
        Wed,  6 Dec 2023 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701876772;
        bh=w1otnxj6ZQubR19XyLc2pJyxuUrOYv5s6Wn1rb3d1zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGASEMZu2w8Un5785u0aGDVqoWrEGsXz1MReexBAxddidRe4ZZe5zAr1Sm0k93D+u
         Ui2+j1KIQLPLlEMwubHnwKWoqH9i2LMROw+PNo+os8rAPeQ4hST37N62nDpHBIkPO4
         uHH8Emz7IPGW/hZ6oLAl6gSzocpcZnFhp6YtRXrD5oszVH52J7j9aOgXwG0nWmcR3T
         k6K524JwL7SyQMLDxr20AN1PKLPXkVriRV40ck2DScbYe+1PPJuMSCQUvXO70HkFBw
         uGJnKtfwIFtCkPIEyrUnhg4Hi3AGxm9XoGnIVmFItvXFPxt/PpS5LdtUW6oEHHL6xL
         hEgUg9hmtXlZg==
Date:   Wed, 6 Dec 2023 21:02:42 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Naresh Maramaina <quic_mnaresh@quicinc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chu.stanley@gmail.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: Re: [PATCH V2 1/3] ufs: core: Add CPU latency QoS support for ufs
 driver
Message-ID: <20231206153242.GI12802@thinkpad>
References: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
 <20231204143101.64163-2-quic_mnaresh@quicinc.com>
 <590ade27-b4da-49be-933b-e9959aa0cd4c@acm.org>
 <692cd503-5b14-4be6-831d-d8e9c282a95e@quicinc.com>
 <5e7c5c75-cb5f-4afe-9d57-b0cab01a6f26@acm.org>
 <b9373252-710c-4a54-95cc-046314796960@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9373252-710c-4a54-95cc-046314796960@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 07:32:54PM +0530, Naresh Maramaina wrote:
> 
> 
> On 12/5/2023 10:41 PM, Bart Van Assche wrote:
> > On 12/4/23 21:58, Naresh Maramaina wrote:
> > > On 12/5/2023 12:30 AM, Bart Van Assche wrote:
> > > > On 12/4/23 06:30, Maramaina Naresh wrote:
> > > > > +    /* This capability allows the host controller driver to
> > > > > use the PM QoS
> > > > > +     * feature.
> > > > > +     */
> > > > > +    UFSHCD_CAP_PM_QOS                = 1 << 13,
> > > > >   };
> > > > 
> > > > Why does it depend on the host driver whether or not PM QoS is
> > > > enabled? Why isn't it enabled unconditionally?
> > > 
> > > For some platform vendors power KPI might be more important than
> > > random io KPI. Hence this flag is disabled by default and can be
> > > enabled based on platform requirement.
> > 
> > How about leaving this flag out unless if a host vendor asks explicitly
> > for this flag?
> 
> IMHO, instead of completely removing this flag, how about having
> flag like "UFSHCD_CAP_DISABLE_PM_QOS" which will make PMQOS enable
> by default and if some host vendor wants to disable it explicitly,
> they can enable that flag.
> Please let me know your opinion.
> 

If a vendor wants to disable this feature, then the driver has to be modified.
That won't be very convenient. So either this has to be configured through sysfs
or Kconfig if flexibility matters.

- Mani

> > > > 
> > > > > + * @pm_qos_req: PM QoS request handle
> > > > > + * @pm_qos_init: flag to check if pm qos init completed
> > > > >    */
> > > > 
> > > > Documentation for pm_qos_init is missing.
> > > > 
> > > Sorry, i didn't get your comment, i have already added documentation
> > > for @pm_qos_init, @pm_qos_req variable as above. Do you want me to
> > > add this information some where else as well?
> > 
> > Oops, I meant 'qos_vote'.
> 
> Sure. I'll take of this in next patchset.
> 
> > 
> > Thanks,
> > 
> > Bart.
> > 
> 
> Thanks,
> Naresh
> 

-- 
மணிவண்ணன் சதாசிவம்
