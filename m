Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0437CCFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344159AbjJQWSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjJQWSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:18:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C6E95;
        Tue, 17 Oct 2023 15:18:21 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMIEBn028433;
        Tue, 17 Oct 2023 22:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=yod7tKTiyenpKi21EI2xG36/BjlhaK3nnueHtQLNxnE=;
 b=Q86VsmBJbl9UNZYZgUuhbH32T9rO/sTNx3jYWtCEL4MISbP52a4mijaajZp9DgQQFkG3
 eAQvmJxeFNYpN2vI62riEkFUarZdMLHGG4bVxFRCRr21J1Bw82joCT//YRIhCt42GWOV
 PMRYET5Hg8d1sUjWTcu6O2KSTYKRqVT9xp8BDCpxTn0PJncEQzP3fQtLSr0WFBAJSajx
 V0/QIrp/RaLBy30FyaT+owzngzl19XL96nsBhPML0yFQYxjk9HO87c1oviPca6hxNGE7
 Cq3I9Nf1gp2c64cpApD9i9kLP+v/6FcwH2MZRUtEmQAT1fCehcgYiEGx3aTn9d7fyNmz ew== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsv0v143c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 22:18:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HMICf4020266
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 22:18:12 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 15:18:12 -0700
Date:   Tue, 17 Oct 2023 15:18:11 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: qcom-ep: Implement dbi_cs2_access() function
 callback for DBI CS2 access
Message-ID: <20231017221811.GV3553829@hu-bjorande-lv.qualcomm.com>
References: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
 <20231017-pcie-qcom-bar-v1-2-3e26de07bec0@linaro.org>
 <20231017142431.GR3553829@hu-bjorande-lv.qualcomm.com>
 <20231017162129.GF5274@thinkpad>
 <20231017165609.GT3553829@hu-bjorande-lv.qualcomm.com>
 <20231017174100.GA137137@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231017174100.GA137137@thinkpad>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AQEoIHNDHRf6LYsZYb5W1aCSSblSTH7a
X-Proofpoint-GUID: AQEoIHNDHRf6LYsZYb5W1aCSSblSTH7a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=881
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:11:00PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 17, 2023 at 09:56:09AM -0700, Bjorn Andersson wrote:
> > On Tue, Oct 17, 2023 at 09:51:29PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Oct 17, 2023 at 07:24:31AM -0700, Bjorn Andersson wrote:
> > > > On Tue, Oct 17, 2023 at 11:47:55AM +0530, Manivannan Sadhasivam wrote:
> > > > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > > 
> > > > Your S-o-b should match this.
> > > > 
> > > 
> > > I gave b4 a shot for sending the patches and missed this. Will fix it in next
> > > version.
> > > 
> > > > > 
> > > > > Qcom EP platforms require enabling/disabling the DBI CS2 access while
> > > > > programming some read only and shadow registers through DBI. So let's
> > > > > implement the dbi_cs2_access() callback that will be called by the DWC core
> > > > > while programming such registers like BAR mask register.
> > > > > 
> > > > > Without DBI CS2 access, writes to those registers will not be reflected.
> > > > > 
> > > > > Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++++++++++++
> > > > >  1 file changed, 14 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > index 32c8d9e37876..4653cbf7f9ed 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > @@ -124,6 +124,7 @@
> > > > >  
> > > > >  /* ELBI registers */
> > > > >  #define ELBI_SYS_STTS				0x08
> > > > > +#define ELBI_CS2_ENABLE				0xa4
> > > > >  
> > > > >  /* DBI registers */
> > > > >  #define DBI_CON_STATUS				0x44
> > > > > @@ -262,6 +263,18 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
> > > > >  	disable_irq(pcie_ep->perst_irq);
> > > > >  }
> > > > >  
> > > > > +static void qcom_pcie_dbi_cs2_access(struct dw_pcie *pci, bool enable)
> > > > > +{
> > > > > +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > > > > +
> > > > > +	writel_relaxed(enable, pcie_ep->elbi + ELBI_CS2_ENABLE);
> > > > 
> > > > Don't you want to maintain the ordering of whatever write came before
> > > > this?
> > > > 
> > > 
> > > Since this in a dedicated function, I did not care about the ordering w.r.t
> > > previous writes. Even if it gets inlined, the order should not matter since it
> > > only enables/disables the CS2 access for the forthcoming writes.
> > > 
> > 
> > The wmb() - in a non-relaxed writel -  would ensure that no earlier
> > writes are reordered and end up in your expected set of "forthcoming
> > writes".
> > 
> 
> I was under the impression that the readl_relaxed() here serves as an implicit
> barrier. But reading the holy memory-barriers documentation doesn't explicitly
> say so. So I'm going to add wmb() to be on the safe side as you suggested.
> 

I'm talking about writes prior to this function is being called.

In other words, if you write:

writel_relaxed(A, ptr); (or writel, it doesn't matter)
writel_relaxed(X, ELBI_CS2_ENABLE);
readl_relaxed(ELBI_CS2_ENABLE);

Then there are circumstances where the write to ptr might be performed
after ELBI_CS2_ENABLE.

Iiuc, the way to avoid that is to either be certain that none of those
circumstances applies, or to add a wmb(), like:

writel_relaxed(A, ptr); (or writel, it doesn't matter)
wmb();
writel_relaxed(X, ELBI_CS2_ENABLE);
readl_relaxed(ELBI_CS2_ENABLE);

or short hand:

writel_relaxed(A, ptr); (or writel, it doesn't matter)
writel(X, ELBI_CS2_ENABLE);
readl_relaxed(ELBI_CS2_ENABLE);

Where the wmb() will ensure the two writes happen in order.

The read in your code will ensure that execution won't proceed until the
write has hit the hardware, so that's good. But writing this makes me
uncertain if there's sufficient guarantees for the CPU not reordering
later operations.

Regards,
Bjorn
