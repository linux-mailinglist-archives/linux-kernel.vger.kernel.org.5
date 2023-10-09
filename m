Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F157BD791
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbjJIJsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345913AbjJIJss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:48:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3594;
        Mon,  9 Oct 2023 02:48:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9650DC433C7;
        Mon,  9 Oct 2023 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696844926;
        bh=rBVqWb+z5R5TaUyQXEFi8ime0dEnUDOFCwNmwg86gkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFPqgjEqg4jLd1X0C/RVSq8m0am+Wj+lhZpJgVjFKFwEfBPYBtow2rsuqcvcLwp4d
         I7zG54rZDgMH5XDLE/mWcgfV0Z9etoSYyfq1rsk68K9l3Q2gpwESxUVfDY8+VMUvY8
         gj+CBfKLjE0XDqHs/w9uHFrw+uejrvvJg3S9lD84=
Date:   Mon, 9 Oct 2023 11:48:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <2023100912-tiara-pout-ba98@gregkh>
References: <20231004132247.01c3bfeb@canb.auug.org.au>
 <2023100410-concave-explore-95bf@gregkh>
 <e26b26ff-9e88-4455-9172-1afb520583e7@quicinc.com>
 <2023100445-cymbal-glade-52c8@gregkh>
 <044a2146-f859-44b3-bcf7-66b68d3e7787@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044a2146-f859-44b3-bcf7-66b68d3e7787@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 02:48:27PM +0530, Rohit Agarwal wrote:
> 
> On 10/4/2023 6:16 PM, Greg KH wrote:
> > On Wed, Oct 04, 2023 at 12:17:27PM +0530, Rohit Agarwal wrote:
> > > On 10/4/2023 12:13 PM, Greg KH wrote:
> > > > On Wed, Oct 04, 2023 at 01:22:47PM +1100, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > > 
> > > > > After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
> > > > > failed like this:
> > > > > 
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:156:43: error: 'QPHY_V6_PCS_SW_RESET' undeclared here (not in a function); did you mean 'QPHY_V2_PCS_SW_RESET'?
> > > > >     156 |         [QPHY_SW_RESET]                 = QPHY_V6_PCS_SW_RESET,
> > > > >         |                                           ^~~~~~~~~~~~~~~~~~~~
> > > > >         |                                           QPHY_V2_PCS_SW_RESET
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:157:43: error: 'QPHY_V6_PCS_START_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_START_CONTROL'?
> > > > >     157 |         [QPHY_START_CTRL]               = QPHY_V6_PCS_START_CONTROL,
> > > > >         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >         |                                           QPHY_V3_PCS_START_CONTROL
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:158:43: error: 'QPHY_V6_PCS_PCS_STATUS1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_PCS_STATUS1'?
> > > > >     158 |         [QPHY_PCS_STATUS]               = QPHY_V6_PCS_PCS_STATUS1,
> > > > >         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
> > > > >         |                                           QPHY_V5_PCS_PCS_STATUS1
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:159:43: error: 'QPHY_V6_PCS_POWER_DOWN_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_POWER_DOWN_CONTROL'?
> > > > >     159 |         [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V6_PCS_POWER_DOWN_CONTROL,
> > > > >         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >         |                                           QPHY_V3_PCS_POWER_DOWN_CONTROL
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:162:43: error: 'QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL'?
> > > > >     162 |         [QPHY_PCS_AUTONOMOUS_MODE_CTRL] = QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
> > > > >         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >         |                                           QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:163:44: error: 'QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR'?
> > > > >     163 |         [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
> > > > >         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >         |                                            QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:991:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG1'?
> > > > >     991 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG1, 0xc4),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:992:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_LOCK_DETECT_CONFIG2'?
> > > > >     992 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:993:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG3' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG3'?
> > > > >     993 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:994:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG6' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG6'?
> > > > >     994 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:997:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L'?
> > > > >     997 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:998:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H'?
> > > > >     998 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:999:26: error: 'QPHY_V6_PCS_CDR_RESET_TIME' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_CDR_RESET_TIME'?
> > > > >     999 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_CDR_RESET_TIME, 0x0a),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1000:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG1'?
> > > > >    1000 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1001:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG2'?
> > > > >    1001 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1003:26: error: 'QPHY_V6_PCS_EQ_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG1'?
> > > > >    1003 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG1, 0x4b),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1004:26: error: 'QPHY_V6_PCS_EQ_CONFIG5' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG5'?
> > > > >    1004 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG5, 0x10),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1008:26: error: 'QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL'?
> > > > >    1008 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1009:26: error: 'QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2'?
> > > > >    1009 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1010:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_L'?
> > > > >    1010 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1011:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_RCVR_DTCT_DLY_U3_H'?
> > > > >    1011 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
> > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > >      78 |                 .offset = o,            \
> > > > >         |                           ^
> > > > > 
> > > > > Caused by commit
> > > > > 
> > > > >     685dbd1b2306 ("phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support")
> > > > > 
> > > > > I have used the usb tree from next-20231003 for today.
> > > > Thanks, I've now reverted this from my tree.
> > > As mentioned in the cover letter of these changes, the series was dependent
> > > on the other submitted series [1], [2].
> > Ah, I missed that, I almost never read cover letters :)
> > 
> > > Can you also pick these series [1], [2] to resolve this build failures.
> > > [1] https://lore.kernel.org/all/20230911203842.778411-1-dmitry.baryshkov@linaro.org/
> > > [2] https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/
> > How about you just send this change with these others, or all of them as
> > one big series so they can be applied in the proper order?
> Adding Dmitry as well.
> 
> I see some of the dependent patches are already applied and the patches from
> [2] are not.
> Since all the rest dependent changes are already applied,
> you can pick series[2] and then this series that should also be fine.
> Please let me know if this is fine?

What is "this" series?  I don't have any of these in my inbox at all
anymore, sorry.  Please resend the pending patches that need to be
applied to my usb tree and I will be glad to do so.

thanks,

greg k-h
