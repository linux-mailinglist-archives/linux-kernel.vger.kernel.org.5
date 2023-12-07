Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32DF80860B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378677AbjLGJoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378654AbjLGJoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:44:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE845DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:44:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B62C433C7;
        Thu,  7 Dec 2023 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701942251;
        bh=z9LEnc9SGPP1cSw8n0MwiUc7iERA9aZU0X4XLc/JCus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZ0oyfP6rihYVRM820jd+i9VgQtmywGaPXq7igsGv32dxX/J3EeENhsGVzajAtiDQ
         S2yY1ariJG0saxlG3+i+48dvm5AOYb6yFJPZEDHFY+gGdd/jjbLrO98YUoU8qaRdvv
         3Be5rbRpPbKY+ucecdTPuNpO3eyvZIN8n/4Ip3ldpNjb3LJzdLdimrec2HA2++wehz
         z7IJBBG5+sWZX8HD0vjIgKfa1eyr3ZBzvDIGVWe9spjwxI0QOXs90zGv6n/Vm4czGu
         1wE9XA+hc1u2c4/7b0BWBth0NB76ZJFrIWRRSjdMemgW5OqUFurE6Y6fDJCy8B+Xar
         JOYxApp7CccNw==
Date:   Thu, 7 Dec 2023 15:13:57 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Naresh Maramaina <quic_mnaresh@quicinc.com>,
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
Message-ID: <20231207094357.GI2932@thinkpad>
References: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
 <20231204143101.64163-2-quic_mnaresh@quicinc.com>
 <590ade27-b4da-49be-933b-e9959aa0cd4c@acm.org>
 <692cd503-5b14-4be6-831d-d8e9c282a95e@quicinc.com>
 <5e7c5c75-cb5f-4afe-9d57-b0cab01a6f26@acm.org>
 <b9373252-710c-4a54-95cc-046314796960@quicinc.com>
 <20231206153242.GI12802@thinkpad>
 <effb603e-ca7a-4f24-9783-4d62790165ae@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <effb603e-ca7a-4f24-9783-4d62790165ae@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 03:02:04PM -1000, Bart Van Assche wrote:
> On 12/6/23 05:32, Manivannan Sadhasivam wrote:
> > On Wed, Dec 06, 2023 at 07:32:54PM +0530, Naresh Maramaina wrote:
> > > On 12/5/2023 10:41 PM, Bart Van Assche wrote:
> > > > On 12/4/23 21:58, Naresh Maramaina wrote:
> > > > > On 12/5/2023 12:30 AM, Bart Van Assche wrote:
> > > > > > On 12/4/23 06:30, Maramaina Naresh wrote:
> > > > > > > +    /* This capability allows the host controller driver to
> > > > > > > use the PM QoS
> > > > > > > +     * feature.
> > > > > > > +     */
> > > > > > > +    UFSHCD_CAP_PM_QOS                = 1 << 13,
> > > > > > >    };
> > > > > > 
> > > > > > Why does it depend on the host driver whether or not PM QoS is
> > > > > > enabled? Why isn't it enabled unconditionally?
> > > > > 
> > > > > For some platform vendors power KPI might be more important than
> > > > > random io KPI. Hence this flag is disabled by default and can be
> > > > > enabled based on platform requirement.
> > > > 
> > > > How about leaving this flag out unless if a host vendor asks explicitly
> > > > for this flag?
> > > 
> > > IMHO, instead of completely removing this flag, how about having
> > > flag like "UFSHCD_CAP_DISABLE_PM_QOS" which will make PMQOS enable
> > > by default and if some host vendor wants to disable it explicitly,
> > > they can enable that flag.
> > > Please let me know your opinion.
> 
> That would result in a flag that is tested but that is never set by
> upstream code. I'm not sure that's acceptable.
> 

Agree. The flag shouldn't be introduced if there are no users.

> > If a vendor wants to disable this feature, then the driver has to be modified.
> > That won't be very convenient. So either this has to be configured through sysfs
> > or Kconfig if flexibility matters.
> 
> Kconfig sounds worse to me because changing any Kconfig flag requires a
> modification of the Android GKI kernel.
> 

Hmm, ok. Then I think we can have a sysfs hook to toggle the enable switch.

- Mani

> Thanks,
> 
> Bart.

-- 
மணிவண்ணன் சதாசிவம்
