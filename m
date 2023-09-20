Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAED87A791D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjITKXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjITKXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:23:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772D6CF;
        Wed, 20 Sep 2023 03:23:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB71C433C8;
        Wed, 20 Sep 2023 10:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695205413;
        bh=jc/Y+vve/UFc6TPsxGQnkLPeA14f0BjGYS89vW7asks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMJF7gYkSHNmd5ymR/8RphkCwKDRUNaio+A3F0HweqkmSuPiRTB6vDoigJFt7ZHHx
         hc0Oyn7pi1cbJsJluSEIg4+3AW20EP0DYXqo9VbHRv3MXbpnwskvVL7wt4GDJgLJbR
         Gr97Dp8ScJgFqR5ihP5Z7auLD4Tbb6gmAQWIZrl5ZWQoaf5mWAXlU6889A7XfjocF3
         baxeUG3/A5SAZTIvYTr2ux2Nppzqn/Mco5uURtnfTS/xieWlqTInhatWdeMdBFMQmu
         XiiaGEA8dCLfpoHG8vvjbjdF8P1BtF96W+yai7o9QSEONOSV/43u8WPaapVAQweRb7
         p+o6Je9Qfi+Og==
Date:   Wed, 20 Sep 2023 12:23:27 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Can Guo <quic_cang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Message-ID: <20230920102327.GH4732@thinkpad>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
 <6055cd57-4de7-4b7e-a4f3-68a7de1aef28@linaro.org>
 <6225a132-4b7f-bbb4-e863-4e62b99dd79d@quicinc.com>
 <31823dc4-6f50-435b-9a20-66471209ec31@linaro.org>
 <d34242f8-6e21-1549-b87d-3db2e825b7d5@quicinc.com>
 <1413119B-8B9C-4DE4-A086-476B2BAA60AD@linaro.org>
 <20230919120829.GB4732@thinkpad>
 <CAA8EJppwjzNDsPHZqUdmgQy3fAbP+AFnOo4+FTDCdpBEZp5S_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJppwjzNDsPHZqUdmgQy3fAbP+AFnOo4+FTDCdpBEZp5S_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:27:59AM +0300, Dmitry Baryshkov wrote:
> On Tue, 19 Sept 2023 at 15:08, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Fri, Sep 15, 2023 at 05:31:45AM +0300, Dmitry Baryshkov wrote:
> > > On 11 September 2023 13:02:50 GMT+03:00, Can Guo <quic_cang@quicinc.com> wrote:
> > > >
> > > >On 9/11/2023 5:46 PM, Konrad Dybcio wrote:
> > > >> On 11.09.2023 11:42, Can Guo wrote:
> > > >>> Hi Konrad,
> > > >>>
> > > >>> On 9/11/2023 5:17 PM, Konrad Dybcio wrote:
> > > >>>> On 11.09.2023 07:59, Can Guo wrote:
> > > >>>>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
> > > >>>>>
> > > >>>>> Retrieve UFS device version from UFS host controller's spare register
> > > >>>>> which is populated by bootloader, and use the UFS device version together
> > > >>>>> with host controller's HW version to decide the proper power modes which
> > > >>>>> should be used to configure the UFS PHY.
> > > >>>> That sounds a bit fishy.. is there no bootloader-independent
> > > >>>> solution to that? Can't we bring in the code that the bootloader
> > > >>>> uses to determine these values?
> > > >>>>
> > > >>>> Konrad
> > > >>>
> > > >>> Agree, it is.
> > > >>>
> > > >>>
> > > >>> All these complexities come from one request from PHY design team - power saving.
> > > >>>
> > > >>> And to achieve power saving, Qualcomm UFS developers are requested to use the
> > > >>>
> > > >>> lowest hanging PHY settings which can sustain the Max agreed HS Gear (btw host
> > > >>>
> > > >>> and UFS device) during UFS's lifecycle in High Level OS,  whereas the power saving
> > > >>>
> > > >>> request does not apply to bootloader, which works for only a few seconds during
> > > >>>
> > > >>> bootup. Hence, there is no such version detect code in bootloader -  it just uses the
> > > >>>
> > > >>> highest PHY settings to configure PHY, boot up UFS and put UFS device version in this
> > > >>>
> > > >>> register.
> > > >> First of all, your email client seems to be inserting 2 newlines
> > > >> instead of 1. If you're using thunderbird, you may want to edit:
> > > >>
> > > >> mail.identity.(default or your mail identity idx).default.compose_html
> > > >>
> > > >> to `false`
> > > >>
> > > >> and add that to your internal wiki page, as I see many @quic folks having
> > > >> this issue.
> > > >>
> > > >>
> > > >> Going back to the main topic, I don't think we understood each other.
> > > >> The commit message states:
> > > >>
> > > >>
> > > >> "Retrieve UFS device version from UFS host controller's spare register
> > > >> which is populated by bootloader"
> > > >>
> > > >>
> > > >> Which means the bootloader is able to somehow determine the value
> > > >> that's in the spare register and write it there.
> > > >>
> > > >> I'm asking whether we can take the logic behind this value and
> > > >> move it to Linux so that we don't depend on the bootloader to
> > > >> guarantee it (e.g. Chrome or some other devices with more exotic
> > > >> fw may not work this way).
> > > >>
> > > >>
> > > >> Konrad
> > > >
> > > >
> > > >There is no logic behind this value at all in bootloader, as I explained, after bootloader
> > > >
> > > >initializes UFS, bootloader simply reads UFS's device version (the value you are referring)
> > > >
> > > >and write it to the register. But in Linux kernel, we need (or want to know) this value
> > > >
> > > >BEFORE we initialize UFS host controller (and UFS device).
> > >
> > > Depending on the bootloader behaviour is not an option. For example the kernel might be started via kexec. Or via u-boot. Or grub. Or any other bootloader. So please duplicate the logic to read the UFS version instead.
> > >
> >
> > As Can said, there is no logic in the bootloader. What it does it, after doing
> > the UFS initialization, it writes the agreed gear (between host and the device)
> > to this register. And in linux, we use that value to initialize the device
> > (i.e., not doing init based on the min gear).
> >
> > But the important factor here is that, we use this gear value to program the PHY
> > init sequence. So if there is no hint from the bootloader, linux will program
> > the min phy sequence (G3/G4) and then once the gear scaling happens, it will
> > program the max phy sequence (G4/G5).
> >
> > Now on recent platforms, the init sequences are not compatible with each other
> > i.e., once the min seq. is programmed, then before programming max seq. the
> > registers not common to both seq. should be programmed to default value. In
> > other words, min seq. specific registers should be reset to the default value.
> > Otherwise, there will be stability issues in the PHY.
> 
> I see nothing wrong with adding 'default' register programming to the
> gear tables. If we have to reset them to the default values to switch
> the PHY settings, these writes must be a part of the corresponding
> tables.
> 

Yep, that's what I initially proposed. But Qcom wanted to avoid the cost of
programming the reset tables in the PHY driver.

Can, could you please check if programming the additional sequence doesn't cause
any power/performance effect?

- Mani

> >
> > So to avoid that, if we get the hint from bootloader (always the max supported
> > gear between host and device), then only one seq. will be programmed.
> >
> > Other way to solve this issue is to reset the non common registers in the init
> > seq. to default value. But that will be an additional overhead.
> >
> > But... if the bootloader doesn't populate this register (if the boot device is
> > not UFS, like in compute platforms), then this whole logic won't work. This
> > should also be taken into consideration.
> 
> Yep, that's the dependency on the bootloader. Which we should avoid.
> 
> >
> > - Mani
> >
> > >
> > > P.S. you have been asked to fix your email client. Please do so. Or, if you are inserting these linebreaks manually, please stop.
> > >
> > > >Thanks,
> > > >
> > > >Can Guo.
> > > >
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்
> 
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
