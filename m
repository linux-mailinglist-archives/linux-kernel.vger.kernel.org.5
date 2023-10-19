Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A477CFFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbjJSQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjJSQuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:50:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D63411F;
        Thu, 19 Oct 2023 09:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A32C433C7;
        Thu, 19 Oct 2023 16:50:18 +0000 (UTC)
Date:   Thu, 19 Oct 2023 22:20:13 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add new accessors to enable/disable DBI
 CS2 while setting the BAR size
Message-ID: <20231019165013.GB7254@thinkpad>
References: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
 <20231017-pcie-qcom-bar-v1-1-3e26de07bec0@linaro.org>
 <rsv5vgle2d36skx75ds4hqzmlqwldmj4g4ghrlyfuu3ideb3rh@74mnro7qnp4v>
 <20231019052835.GC5142@thinkpad>
 <vg7n2epn7ln77s34il5ojm6ixnboj6is4yq2jlfabnnjqmm4a6@ycsnoaixdnyn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vg7n2epn7ln77s34il5ojm6ixnboj6is4yq2jlfabnnjqmm4a6@ycsnoaixdnyn>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:37:39PM +0300, Serge Semin wrote:
> On Thu, Oct 19, 2023 at 10:58:35AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Oct 18, 2023 at 05:13:41PM +0300, Serge Semin wrote:
> > > On Tue, Oct 17, 2023 at 11:47:54AM +0530, Manivannan Sadhasivam wrote:
> > > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > > 
> > > > As per the DWC databook v4.21a, section M.4.1, in order to write some read
> > > > only and shadow registers through application DBI, the device driver should
> > > > assert DBI Chip Select 2 (CS2) in addition to DBI Chip Select (CS).
> > > > 
> > > > This is a requirement at least on the Qcom platforms while programming the
> > > > BAR size, as the BAR mask registers are marked RO. So let's add two new
> > > > accessors dw_pcie_dbi_cs2_{en/dis} to enable/disable CS2 access in a vendor
> > > > specific way while programming the BAR size.
> > > 
> > > Emm, it's a known thing for all IP-core versions: dbi_cs2 must be
> > > asserted to access the shadow DW PCIe CSRs space for both RC and
> > > EP including the BARs mask and their enabling/disabling flag (there
> > > are many more shadow CSRs available on DW PCIe EPs, and a few in DW
> > > PCIe RCs). That's why the dw_pcie_ops->writel_dbi2 pointer has been
> > > defined in the first place (dbi2 suffix means dbi_cs2). You should use
> > > it to create the platform-specific dbi_cs2 write accessors like it's
> > > done in pci-keystone.c and pcie-bt1.c. For instance like this:
> > > 
> > > static void qcom_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
> > > {
> > > 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > > 	int ret;
> > > 
> > > 	writel(1, pcie_ep->elbi + ELBI_CS2_ENABLE);
> > > 
> > > 	ret = dw_pcie_write(pci->dbi_base2 + reg, size, val);
> > > 	if (ret)
> > > 		dev_err(pci->dev, "write DBI address failed\n");
> > > 
> > > 	writel(0, pcie_ep->elbi + ELBI_CS2_ENABLE);
> > > }
> > > 
> > 
> 
> > Hmm, I was not aware that this write_dbi2() callback is supposed to enable the
> > CS2 access internally. But this approach doesn't look good to me.
> > 
> > We already have accessors for enabling write access to DBI RO registers:
> > 
> > dw_pcie_dbi_ro_wr_en()
> > dw_pcie_dbi_ro_wr_dis()
> > 
> > And IMO DBI_CS2 access should also be done this way instead of hiding it inside
> > the register write callback.
> 
> No, for many-many reasons.
> 
> First of all, DBI RO/RW switch and DBI/DBI2 are absolutely different
> things. Former one switches the CSRs access attributes in both DBI and
> DBI2 CSR spaces. The later one are two CSR spaces, which access to is
> platform-specific. They can't and shouldn't be compared.  DBI2 space
> is a shadow DBI CSRs space, which registers aren't just the RW
> versions of the DBI space, but its CSRs normally have different
> semantics with respect to the normal DBI CSRs available on the same
> offsets. I.e. BAR0 contains MEM/IO, TYPE, PREF flags and base address,
> meanwhile DBI2-BAR0 - BAR enable/disable flag, BAR mask. From that
> perspective having the dw_pcie_ops.write_dbi2 callback utilized for
> the DBI2 space access would provide an interface looking similar to
> the just DBI space - dw_pcie_ops.{write_dbi,read_dbi}. Thus the
> unified access interface would provide much more readable code, where
> based on the method name you'll be able to immediately infer the space
> being accessed to.
> 
> Secondly, DBI RO/RW switch is a straight-forward CSR flag
> clearing/setting DBI_RO_WR_EN. This mechanism is available on all DW
> PCIe IP-cores and works in the _same_ way on all of them: just the
> MISC_CONTROL_1_OFF.DBI_RO_WR_EN flag switching. It switches RO/RW
> access attributes on both DBI_CS and DBI_CS2. So it's a cross-platform
> thing independent from the vendor-specific IP-core settings. That's
> why having generic functions for the RO/RW switch was the best choice:
> it's cross-platform so no need in the platform-specific callbacks, it
> works for both DBI and DBI2 so instead of implementing two additional
> RW-accessors you can call the RW en/dis method around the DBI and DBI2
> accessors whenever you need to switch the access attributes.
> 
> On the contrary DBI_CS2 is the DW PCIe IP-core input signal which
> activation is platform-specific. Some platforms have it switchable via
> a system-controller, some - via an additional elbi CSRs space, some -
> provide an additional CSR space mapping DBI2 with no need in the
> direct DBI_CS2 flag toggle, some may have an intermix of these
> setups or may need some additional manipulation to access the DBI2
> space. So your case of having the DBI_CS2 flag available via the elbi
> space and having the DBI/DBI2 space mapped within the 4K offset with
> respect to DBI is just a single possible option.
> 
> Finally, it's all about simplicity, maintainability and KIS principle.
> Your approach would imply having additional platform-specific
> callbacks, meanwhile there is already available DBI2 space accessor
> which is more than enough to implement what you need.  Even if you
> drop the later one (and convert all the already available LLDDs to
> supporting what you want), having two callbacks instead of one will
> still make things harder to read, because the kernel hacker would need
> to keep in mind the DBI/DBI2 access context. Additionally calling
> _three_ methods instead of a _single_ one will look much more complex.
> Moreover having on/off antagonists prune to errors since a developer
> may forget to disable the DBI2 flag, which on some platforms will
> change the DBI CSRs semantics. Such error will be just impossible to
> meet should the current interface is preserved unless the
> platform-specific DBI2 accessor is incorrectly implemented, which
> would be still specific to the particular platform, but not for the
> entire DW PCIe driver. The last but not least, as I already mentioned
> dw_pcie_ops.write_dbi2 and respective wrappers look as much like the
> normal DBI accessors dw_pcie_ops.{write_dbi,read_dbi} which greatly
> improves the code readability.
> 

Hmm, thanks for the detailed clarification, really appreciated.

My understanding about the DBI2 space was not clear and your reply clarified
that. I will implement the write_dbi2() callback as suggested.

- Mani

> So no, I failed to find any firm justification for the approach you
> suggest.
> 
> -Serge(y)
> 
> > 
> > - Mani
> > 
> > > /* Common DWC controller ops */
> > > static const struct dw_pcie_ops pci_ops = {
> > > 	.link_up = qcom_pcie_dw_link_up,
> > > 	.start_link = qcom_pcie_dw_start_link,
> > > 	.stop_link = qcom_pcie_dw_stop_link,
> > > 	.write_dbi2 = qcom_pcie_write_dbi2,
> > > };
> > > 
> > > For that reason there is absolutely no need in adding the new
> > > callbacks.
> > > 
> > > -Serge(y)
> > > 
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware-ep.c |  6 ++++++
> > > >  drivers/pci/controller/dwc/pcie-designware.h    | 13 +++++++++++++
> > > >  2 files changed, 19 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index d34a5e87ad18..1874fb3d8df4 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -269,11 +269,17 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > >  
> > > >  	dw_pcie_dbi_ro_wr_en(pci);
> > > >  
> > > > +	dw_pcie_dbi_cs2_en(pci);
> > > >  	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
> > > > +	dw_pcie_dbi_cs2_dis(pci);
> > > > +
> > > >  	dw_pcie_writel_dbi(pci, reg, flags);
> > > >  
> > > >  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> > > > +		dw_pcie_dbi_cs2_en(pci);
> > > >  		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
> > > > +		dw_pcie_dbi_cs2_dis(pci);
> > > > +
> > > >  		dw_pcie_writel_dbi(pci, reg + 4, 0);
> > > >  	}
> > > >  
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index 55ff76e3d384..3cba27b5bbe5 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -379,6 +379,7 @@ struct dw_pcie_ops {
> > > >  			     size_t size, u32 val);
> > > >  	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
> > > >  			      size_t size, u32 val);
> > > > +	void	(*dbi_cs2_access)(struct dw_pcie *pcie, bool enable);
> > > >  	int	(*link_up)(struct dw_pcie *pcie);
> > > >  	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
> > > >  	int	(*start_link)(struct dw_pcie *pcie);
> > > > @@ -508,6 +509,18 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
> > > >  	dw_pcie_writel_dbi(pci, reg, val);
> > > >  }
> > > >  
> > > > +static inline void dw_pcie_dbi_cs2_en(struct dw_pcie *pci)
> > > > +{
> > > > +	if (pci->ops && pci->ops->dbi_cs2_access)
> > > > +		pci->ops->dbi_cs2_access(pci, true);
> > > > +}
> > > > +
> > > > +static inline void dw_pcie_dbi_cs2_dis(struct dw_pcie *pci)
> > > > +{
> > > > +	if (pci->ops && pci->ops->dbi_cs2_access)
> > > > +		pci->ops->dbi_cs2_access(pci, false);
> > > > +}
> > > > +
> > > >  static inline int dw_pcie_start_link(struct dw_pcie *pci)
> > > >  {
> > > >  	if (pci->ops && pci->ops->start_link)
> > > > 
> > > > -- 
> > > > 2.25.1
> > > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
