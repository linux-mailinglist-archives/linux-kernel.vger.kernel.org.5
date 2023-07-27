Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E933476500E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjG0Jlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjG0Jl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:41:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A6835AB;
        Thu, 27 Jul 2023 02:39:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RBQdC3YZ8z6J6kV;
        Thu, 27 Jul 2023 17:36:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 10:39:30 +0100
Date:   Thu, 27 Jul 2023 10:39:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     Shuai Xue <xueshuai@linux.alibaba.com>,
        <chengyou@linux.alibaba.com>, <kaishen@linux.alibaba.com>,
        <helgaas@kernel.org>, <will@kernel.org>,
        <baolin.wang@linux.alibaba.com>, <robin.murphy@arm.com>,
        <yangyicong@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <rdunlap@infradead.org>,
        <mark.rutland@arm.com>, <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v6 3/4] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20230727103929.00000544@Huawei.com>
In-Reply-To: <31e2b012-3a29-d063-842d-e3f7736816e7@huawei.com>
References: <20230606074938.97724-1-xueshuai@linux.alibaba.com>
        <20230606074938.97724-4-xueshuai@linux.alibaba.com>
        <31e2b012-3a29-d063-842d-e3f7736816e7@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 23:14:07 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> On 2023/6/6 15:49, Shuai Xue wrote:
> > This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> > for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> > Core controller IP which provides statistics feature. The PMU is not a PCIe
> > Root Complex integrated End Point(RCiEP) device but only register counters
> > provided by each PCIe Root Port.
> > 
> > To facilitate collection of statistics the controller provides the
> > following two features for each Root Port:
> > 
> > - Time Based Analysis (RX/TX data throughput and time spent in each
> >   low-power LTSSM state)
> > - Event counters (Error and Non-Error for lanes)
> > 
> > Note, only one counter for each type and does not overflow interrupt.
> > 
> > This driver adds PMU devices for each PCIe Root Port. And the PMU device is
> > named based the BDF of Root Port. For example,
> > 
> >     30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
> > 
> > the PMU device name for this Root Port is dwc_rootport_3018.
> > 
> > Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
> > 
> >     $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
> > 
> > average RX bandwidth can be calculated like this:
> > 
> >     PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
> > 
> > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202305170639.XU3djFZX-lkp@intel.com/
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

I'll review on top to avoid any duplication with Yicong.

Note I've cropped the stuff neither of us commented on so it's
easier to spot the feedback.

Jonathan

> > ---
> >  drivers/perf/Kconfig        |   7 +
> >  drivers/perf/Makefile       |   1 +
> >  drivers/perf/dwc_pcie_pmu.c | 706 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 714 insertions(+)
> >  create mode 100644 drivers/perf/dwc_pcie_pmu.c
> > 
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index 711f82400086..6ff3921d7a62 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -209,6 +209,13 @@ config MARVELL_CN10K_DDR_PMU
> >  	  Enable perf support for Marvell DDR Performance monitoring
> >  	  event on CN10K platform.
> >  
> > +config DWC_PCIE_PMU
> > +	tristate "Enable Synopsys DesignWare PCIe PMU Support"
> > +	depends on (ARM64 && PCI)
> > +	help
> > +	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
> > +	  monitoring event on Yitian 710 platform.

The documentation kind of implies this isn't platform specific.
If some parts are (such as which events exist) then you may want to push
that to userspace / perftool with appropriate matching against specific SoC.

If it is generic, then change this text to "event on platform including the Yitian 710."

> > +
> >  source "drivers/perf/arm_cspmu/Kconfig"
> >  
> >  source "drivers/perf/amlogic/Kconfig"

> > new file mode 100644
> > index 000000000000..8bfcf6e0662d
> > --- /dev/null
> > +++ b/drivers/perf/dwc_pcie_pmu.c
> > @@ -0,0 +1,706 @@

...

> > +
> > +struct dwc_pcie_pmu {
> > +	struct pci_dev		*pdev;		/* Root Port device */  
> 
> If the root port removed after the probe of this PCIe PMU driver, we'll access the NULL
> pointer. I didn't see you hold the root port to avoid the removal.
> 
> > +	u16			ras_des;	/* RAS DES capability offset */
> > +	u32			nr_lanes;
> > +
> > +	struct list_head	pmu_node;
> > +	struct hlist_node	cpuhp_node;
> > +	struct pmu		pmu;
> > +	struct perf_event	*event;
> > +	int			oncpu;
> > +};
> > +
> > +struct dwc_pcie_pmu_priv {
> > +	struct device *dev;
> > +	struct list_head pmu_nodes;
> > +};
> > +
> > +#define to_dwc_pcie_pmu(p) (container_of(p, struct dwc_pcie_pmu, pmu))
> > +  
> 
> somebody told me to put @pmu as the first member then this macro will have no calculation. :)
> 

...

> > +static ssize_t dwc_pcie_event_show(struct device *dev,
> > +				struct device_attribute *attr, char *buf)
> > +{
> > +	struct dwc_pcie_event_attr *eattr;
> > +
> > +	eattr = container_of(attr, typeof(*eattr), attr);
> > +
> > +	if (eattr->type == DWC_PCIE_LANE_EVENT)
> > +		return sysfs_emit(buf, "eventid=0x%x,type=0x%x,lane=?\n",
> > +				  eattr->eventid, eattr->type);
> > +

Elsewhere you always check for DWC_PCIE_TIME_BASE_EVENT.
Should probably do so here as well for consistency.

> > +	return sysfs_emit(buf, "eventid=0x%x,type=0x%x\n", eattr->eventid,
> > +		       eattr->type);
> > +}

> > +static struct attribute *dwc_pcie_pmu_time_event_attrs[] = {
> > +	/* Group #0 */
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(one_cycle, 0x00),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(TX_L0S, 0x01),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(RX_L0S, 0x02),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L0, 0x03),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1, 0x04),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_1, 0x05),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_2, 0x06),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(CFG_RCVRY, 0x07),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(TX_RX_L0S, 0x08),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_AUX, 0x09),
> > +
> > +	/* Group #1 */
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Tx_PCIe_TLP_Data_Payload, 0x20),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Rx_PCIe_TLP_Data_Payload, 0x21),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Tx_CCIX_TLP_Data_Payload, 0x22),
> > +	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Rx_CCIX_TLP_Data_Payload, 0x23),
> > +
> > +	/*
> > +	 * Leave it to the user to specify the lane ID to avoid generating
> > +	 * a list of hundreds of events.
> > +	 */
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_ack_dllp, 0x600),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_update_fc_dllp, 0x601),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_ack_dllp, 0x602),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_update_fc_dllp, 0x603),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_nulified_tlp, 0x604),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_nulified_tlp, 0x605),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_duplicate_tl, 0x606),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_write, 0x700),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_read, 0x701),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_configuration_write, 0x702),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_configuration_read, 0x703),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_io_write, 0x704),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_io_read, 0x705),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_completion_without_data, 0x706),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_completion_with_data, 0x707),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_message_tlp, 0x708),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_atomic, 0x709),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_tlp_with_prefix, 0x70A),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_memory_write, 0x70B),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_memory_read, 0x70C),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_io_write, 0x70F),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_io_read, 0x710),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_completion_without_data, 0x711),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_completion_with_data, 0x712),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_message_tlp, 0x713),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_atomic, 0x714),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_tlp_with_prefix, 0x715),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_ccix_tlp, 0x716),
> > +	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_ccix_tlp, 0x717),
> > +  
> 
> Intended blank line?
> 
> > +	NULL
> > +};


...

> > +static u64 dwc_pcie_pmu_read_time_based_counter(struct dwc_pcie_pmu *pcie_pmu)
> > +{
> > +	struct pci_dev *pdev = pcie_pmu->pdev;
> > +	u16 ras_des = pcie_pmu->ras_des;
> > +	u64 count;
> > +	u32 val;
> > +
> > +	pci_read_config_dword(
> > +		pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_HIGH, &val);
> > +	count = val;
> > +	count <<= 32;
> > +
> > +	pci_read_config_dword(
> > +		pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_LOW, &val);

This looks like tearing can occur.  you probably need to protect against that
(usual trick is re read the _HIGH part and if it changed, try again)

The hardware might prevent tearing (it would freeze the low register when you
read the high one, then only let it change after a read of the low registers is
done).  If that's the case - add a comment to say so.

> > +
> > +	count += val;
> > +
> > +	return count;
> > +}
> > +


...
> > +static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
> > +{
> > +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> > +	struct pci_dev *pdev = pcie_pmu->pdev;
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> > +	int event_id = DWC_PCIE_EVENT_ID(event);
> > +	int lane = DWC_PCIE_EVENT_LANE(event);
> > +	u16 ras_des = pcie_pmu->ras_des;
> > +	u32 ctrl;
> > +
> > +	/* Only one counter and it is in use */

Yikes. That's quite a restriction.  Probably good to mention in the docs.
I'm a little confused about the architecture though - there seem to be separate
registers for the Lane and time based events.  Can't count those at same time?

> > +	if (pcie_pmu->event)
> > +		return -ENOSPC;
> > +
> > +	pcie_pmu->event = event;
> > +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > +
> > +	if (type == DWC_PCIE_LANE_EVENT) {
> > +		/* EVENT_COUNTER_DATA_REG needs clear manually */
> > +		ctrl = FIELD_PREP(DWC_PCIE_CNT_EVENT_SEL, event_id) |
> > +			FIELD_PREP(DWC_PCIE_CNT_LANE_SEL, lane) |
> > +			FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_OFF) |
> > +			FIELD_PREP(DWC_PCIE_EVENT_CLEAR, DWC_PCIE_EVENT_PER_CLEAR);
> > +		pci_write_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL,
> > +				       ctrl);
> > +	} else if (type == DWC_PCIE_TIME_BASE_EVENT) {
> > +		/*
> > +		 * TIME_BASED_ANAL_DATA_REG is a 64 bit register, we can safely
> > +		 * use it with any manually controlled duration. And it is
> > +		 * cleared when next measurement starts.
> > +		 */
> > +		ctrl = FIELD_PREP(DWC_PCIE_TIME_BASED_REPORT_SEL, event_id) |
> > +			FIELD_PREP(DWC_PCIE_TIME_BASED_DURATION_SEL,
> > +				   DWC_PCIE_DURATION_MANUAL_CTL) |
> > +			DWC_PCIE_TIME_BASED_CNT_ENABLE;
> > +		pci_write_config_dword(
> > +			pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL, ctrl);
> > +	}
> > +
> > +	if (flags & PERF_EF_START)
> > +		dwc_pcie_pmu_event_start(event, PERF_EF_RELOAD);
> > +
> > +	perf_event_update_userpage(event);
> > +
> > +	return 0;
> > +}
...

> > +static int __dwc_pcie_pmu_probe(struct dwc_pcie_pmu_priv *priv)
> > +{
> > +	struct pci_dev *pdev = NULL;
> > +	struct dwc_pcie_pmu *pcie_pmu;
> > +	char *name;
> > +	u32 bdf;
> > +	int ret;
> > +
> > +	INIT_LIST_HEAD(&priv->pmu_nodes);
> > +
> > +	/* Match the rootport with VSEC_RAS_DES_ID, and register a PMU for it */
> > +	for_each_pci_dev(pdev) {
> > +		u16 vsec;
> > +		u32 val;
> > +
> > +		if (!(pci_is_pcie(pdev) &&
> > +		      pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
> > +			continue;
> > +
> > +		vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
> > +						DWC_PCIE_VSEC_RAS_DES_ID);
> > +		if (!vsec)
> > +			continue;
> > +
> > +		pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> > +		if (PCI_VNDR_HEADER_REV(val) != 0x04 ||
> > +		    PCI_VNDR_HEADER_LEN(val) != 0x100)
> > +			continue;
> > +		pci_dbg(pdev,
> > +			"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
> > +
> > +		bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
> > +		name = devm_kasprintf(priv->dev, GFP_KERNEL, "dwc_rootport_%x",
> > +				      bdf);
> > +		if (!name)
> > +			return -ENOMEM;
> > +
> > +		/* All checks passed, go go go */
> > +		pcie_pmu = devm_kzalloc(&pdev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
> > +		if (!pcie_pmu) {
> > +			pci_dev_put(pdev);  
> 
> we need to call pci_dev_put on all the return branch below and above and after the for_each_pci_dev()
> loop to keep the refcnt balance.

Good spot. I'd use a goto for this given there are lots of places.

> 
> > +			return -ENOMEM;
> > +		}
> > +
> > +		pcie_pmu->pdev = pdev;
> > +		pcie_pmu->ras_des = vsec;
> > +		pcie_pmu->nr_lanes = pcie_get_width_cap(pdev);
> > +		pcie_pmu->pmu = (struct pmu){
> > +			.module		= THIS_MODULE,
> > +			.attr_groups	= dwc_pcie_attr_groups,
> > +			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> > +			.task_ctx_nr	= perf_invalid_context,
> > +			.event_init	= dwc_pcie_pmu_event_init,
> > +			.add		= dwc_pcie_pmu_event_add,
> > +			.del		= dwc_pcie_pmu_event_del,
> > +			.start		= dwc_pcie_pmu_event_start,
> > +			.stop		= dwc_pcie_pmu_event_stop,
> > +			.read		= dwc_pcie_pmu_event_update,
> > +		};
> > +
> > +		/* Add this instance to the list used by the offline callback */
> > +		ret = cpuhp_state_add_instance(dwc_pcie_pmu_hp_state,
> > +					       &pcie_pmu->cpuhp_node);
> > +		if (ret) {
> > +			pci_err(pcie_pmu->pdev,
> > +				"Error %d registering hotplug @%x\n", ret, bdf);
> > +			return ret;
> > +		}

Here you mix non devm_ handling in mid way through a series of devm_ calls.
Whilst I 'think' what you have here is fine, I prefer to minimize thinking
whilst reviewing and using devm_add_action_or_reset() with callbacks
in appropriate places would ensure automatic unwinding in the error
path deals with everything in the reverse order of setup.

You just need two instances - one to unwind the cpuhp_state_add_instance() and
one to unwind the perf_pmu_register()
 
> > +		ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
> > +		if (ret) {
> > +			pci_err(pcie_pmu->pdev,
> > +				"Error %d registering PMU @%x\n", ret, bdf);
> > +			cpuhp_state_remove_instance_nocalls(
> > +				dwc_pcie_pmu_hp_state, &pcie_pmu->cpuhp_node);
> > +			return ret;
> > +		}
> > +
> > +		/* Add registered PMUs and unregister them when this driver remove */
> > +		list_add(&pcie_pmu->pmu_node, &priv->pmu_nodes);

This handling would be replaced by the tracking devm is doing for us. So I think
there will be no need for the list.


> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int dwc_pcie_pmu_remove(struct platform_device *pdev)
> > +{
> > +	struct dwc_pcie_pmu_priv *priv = platform_get_drvdata(pdev);
> > +	struct dwc_pcie_pmu *pcie_pmu;
> > +
> > +	list_for_each_entry(pcie_pmu, &priv->pmu_nodes, pmu_node) {
> > +		cpuhp_state_remove_instance(dwc_pcie_pmu_hp_state,
> > +					    &pcie_pmu->cpuhp_node);
> > +		perf_pmu_unregister(&pcie_pmu->pmu);  
> 
> should unregister the PMU first, keep the order reverse to __dwc_pcie_pmu_probe().
These two could have been handled via appropriate devm_add_action_or_reset()
above and let that infrastructure unwind for us in the error path.

If anyone fixes the whole pmu drivers aren't removable mess, then we will
also end up with remove handling for free :)

> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int dwc_pcie_pmu_probe(struct platform_device *pdev)
> > +{
> > +	struct dwc_pcie_pmu_priv *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->dev = &pdev->dev;
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	/* If one PMU registration fails, remove all. */
> > +	ret = __dwc_pcie_pmu_probe(priv);
> > +	if (ret) {
> > +		dwc_pcie_pmu_remove(pdev);

There is a bit of mixing of devm and not here which makes things somewhat
hard to reason about.  Perhaps take the whole unwind flow over to devm managed.
See above.

> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void dwc_pcie_pmu_migrate(struct dwc_pcie_pmu *pcie_pmu, unsigned int cpu)
> > +{
> > +	/* This PMU does NOT support interrupt, just migrate context. */
> > +	perf_pmu_migrate_context(&pcie_pmu->pmu, pcie_pmu->oncpu, cpu);
> > +	pcie_pmu->oncpu = cpu;
> > +}
> > +
> > +static int dwc_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
> > +{
> > +	struct dwc_pcie_pmu *pcie_pmu;
> > +	struct pci_dev *pdev;
> > +	int node;
> > +
> > +	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
> > +	pdev = pcie_pmu->pdev;
> > +	node = dev_to_node(&pdev->dev);
> > +
> > +	if (node != NUMA_NO_NODE && cpu_to_node(pcie_pmu->oncpu) != node &&

Perhaps worth a comment on when you might see node == NUMA_NO_NODE?
Beyond NUMA being entirely disabled, I'd hope that never happens and for that you
might be able to use a compile time check.

I wonder if this can be simplified by a flag that says if we are already in the
right node? Might be easier to follow than having similar dance in online and offline
to figure that out.


> > +	    cpu_to_node(cpu) == node)
> > +		dwc_pcie_pmu_migrate(pcie_pmu, cpu);
> > +
> > +	return 0;
> > +}
> > +
> > +static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
> > +{
> > +	struct dwc_pcie_pmu *pcie_pmu;
> > +	struct pci_dev *pdev;
> > +	int node;
> > +	cpumask_t mask;
> > +	unsigned int target;
> > +
> > +	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
> > +	if (cpu != pcie_pmu->oncpu)
> > +		return 0;
> > +
> > +	pdev = pcie_pmu->pdev;
> > +	node = dev_to_node(&pdev->dev);
> > +	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
> > +	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
> > +		target = cpumask_any(&mask);  
> 
> The cpumask_of_node() only contains the online CPUs so this branch is redundant. For arm64
> using arch_numa.c the node cpumask is updated in numa_{add, remove}_cpu() and for other
> arthitecture the behaviour should keep consistenct. Please correct my if I'm wrong.
> 
> > +	else
> > +		target = cpumask_any_but(cpu_online_mask, cpu);

If following above suggestion, would set flag to say in wrong node here - and wherever
you end up in a node to start with...


> > +	if (target < nr_cpu_ids)
> > +		dwc_pcie_pmu_migrate(pcie_pmu, target);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver dwc_pcie_pmu_driver = {
> > +	.probe = dwc_pcie_pmu_probe,
> > +	.remove = dwc_pcie_pmu_remove,
> > +	.driver = {.name = "dwc_pcie_pmu",},
> > +};
> > +
> > +static int __init dwc_pcie_pmu_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> > +				      "perf/dwc_pcie_pmu:online",
> > +				      dwc_pcie_pmu_online_cpu,
> > +				      dwc_pcie_pmu_offline_cpu);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	dwc_pcie_pmu_hp_state = ret;
> > +
> > +	ret = platform_driver_register(&dwc_pcie_pmu_driver);
> > +	if (ret) {
> > +		cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
> > +		return ret;
> > +	}
> > +
> > +	dwc_pcie_pmu_dev = platform_device_register_simple(
> > +				"dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
> > +	if (IS_ERR(dwc_pcie_pmu_dev)) {
> > +		platform_driver_unregister(&dwc_pcie_pmu_driver);  
> 
> On failure we also need to remove cpuhp state as well.

I'd suggest using gotos and a single error handling block. That
makes it both harder to forget things like this and easier to
compare that block with what happens in exit() - so slightly 
easier to review!

> 
> Thanks,
> Yicong
> 
> > +		return PTR_ERR(dwc_pcie_pmu_dev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void __exit dwc_pcie_pmu_exit(void)
> > +{
> > +	platform_device_unregister(dwc_pcie_pmu_dev);
> > +	platform_driver_unregister(&dwc_pcie_pmu_driver);
> > +	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
> > +}
> > +
> > +module_init(dwc_pcie_pmu_init);
> > +module_exit(dwc_pcie_pmu_exit);
> > +
> > +MODULE_DESCRIPTION("PMU driver for DesignWare Cores PCI Express Controller");
> > +MODULE_AUTHOR("Shuai xue <xueshuai@linux.alibaba.com>");
> > +MODULE_AUTHOR("Wen Cheng <yinxuan_cw@linux.alibaba.com>");
> > +MODULE_LICENSE("GPL v2");
> >   
