Return-Path: <linux-kernel+bounces-108131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6C388066F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F441F22D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEE23D3BB;
	Tue, 19 Mar 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gOP1c+sq"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271923FBA3;
	Tue, 19 Mar 2024 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882095; cv=none; b=X5rroKcB8nB63N/zGdYzGQ2oZuBbX5H9UuvxR7NCNFX8l13h8NQU80eyV0IPIAgQvpuEt3X6ncLPbvP04CJmVlzZy2KnNKmajtmPNIoZEHCBQEyTToB30qa40/uu46q7HYBF81aLDBbhBr356nhbiZer6U77/ddL4isveYSeVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882095; c=relaxed/simple;
	bh=Fefg+/1BVjbXtjfPp8AMwDaKfpDHl61WCT0z7N1myzQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iemq7yda52lo9FOIxfOqhR9Pmb44b9AkVcLuGnOXnBXM2lCmWwDVpNBOkuXVUlSa5GXBeLRS77ucBsp09EWzTQfT0lrno9YwlrwNH5eqTfKHGV9+RSQ/aNIWybATTL0tI7dbpT5vVIqUABRIP5qaAx6ZlCksXMFoiAUXBuUCysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gOP1c+sq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42JL16Rg103012;
	Tue, 19 Mar 2024 16:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710882066;
	bh=yXu//FYcXdqFH43bJEjGRJ337gdmABIU7dHUdY94yvo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=gOP1c+sqxwwRn98Dd9lMVNRtbPa5us7BdSTFAI6KmQHBeixbIcTiTaeI0QQZlUjbn
	 Pk6tO2BjWXCQD4+/yejUttx7MDAO49sUKPhtwtKcM+6wRZzP37/v01+LUNPhfGb9SF
	 4oVWpADdLRjjkTRWjDslYAIt39/xoErJq7AuA0cc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42JL16pq039676
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 16:01:06 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 16:01:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 16:01:06 -0500
Received: from localhost (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42JL16D6080117;
	Tue, 19 Mar 2024 16:01:06 -0500
Date: Tue, 19 Mar 2024 16:01:06 -0500
From: Brandon Brnich <b-brnich@ti.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
CC: Nas Chung <nas.chung@chipsnmedia.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jackson.lee"
	<jackson.lee@chipsnmedia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
Message-ID: <20240319210106.awn33cm7ex33g65b@udba0500997>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
 <20240318144225.30835-6-brnkv.i1@gmail.com>
 <SL2P216MB1246F7FA7E95896AA2409C90FB2C2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <hpqhbksvyfbqjumopk2k2drxri2ycb6j2dbdo74cfymcd7blgx@kzomazfosfwg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <hpqhbksvyfbqjumopk2k2drxri2ycb6j2dbdo74cfymcd7blgx@kzomazfosfwg>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Ivan, 

On 14:24-20240319, Ivan Bornyakov wrote:
> Hello, Nas
> 
> On Tue, Mar 19, 2024 at 10:56:22AM +0000, Nas Chung wrote:
> > Hi, Ivan.
> > 
> > >
> > >Allocate SRAM memory on module probe, free on remove. There is no need
> > >to allocate on device open, free on close, the memory is the same every
> > >time.
> > 
> > If there is no decoder/encoder instance, driver don't need to allocate SRAM memory.
> > The main reason of allocating the memory in open() is to allow other modules to
> > use more SRAM memory, if wave5 is not working.

I have to agree with this statement. Moving allocation to probe results
in wasting SRAM when VPU is not in use. VPU should only be allocating SRAM
when a stream instance is running and free that back once all instances
close.
 
> > >
> > >Also use gen_pool_size() to determine SRAM memory size to be allocated
> > >instead of separate "sram-size" DT property to reduce duplication.
> > >
> > >Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> > >---
> > > .../platform/chips-media/wave5/wave5-helper.c |  3 ---
> > > .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++---------
> > > .../chips-media/wave5/wave5-vpu-dec.c         |  2 --
> > > .../chips-media/wave5/wave5-vpu-enc.c         |  2 --
> > > .../platform/chips-media/wave5/wave5-vpu.c    | 12 +++++------
> > > .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
> > > 6 files changed, 16 insertions(+), 25 deletions(-)
> > >
> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c
> > >b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> > >index 8433ecab230c..ec710b838dfe 100644
> > >--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
> > >@@ -29,9 +29,6 @@ void wave5_cleanup_instance(struct vpu_instance *inst)
> > > {
> > > 	int i;
> > >
> > >-	if (list_is_singular(&inst->list))
> > >-		wave5_vdi_free_sram(inst->dev);
> > >-
> > > 	for (i = 0; i < inst->fbc_buf_count; i++)
> > > 		wave5_vpu_dec_reset_framebuffer(inst, i);
> > >
> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > >b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > >index 3809f70bc0b4..ee671f5a2f37 100644
> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> > >@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
> > >*vpu_dev, struct vpu_buf *array,
> > > void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
> > > {
> > > 	struct vpu_buf *vb = &vpu_dev->sram_buf;
> > >+	dma_addr_t daddr;
> > >+	void *vaddr;
> > >+	size_t size;
> > >
> > >-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
> > >+	if (!vpu_dev->sram_pool || vb->vaddr)
> > > 		return;
> > >
> > >-	if (!vb->vaddr) {
> > >-		vb->size = vpu_dev->sram_size;
> > >-		vb->vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
> > >-					       &vb->daddr);
> > >-		if (!vb->vaddr)
> > >-			vb->size = 0;
> > >+	size = gen_pool_size(vpu_dev->sram_pool);
> > >+	vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
> > >+	if (vaddr) {
> > >+		vb->vaddr = vaddr;
> > >+		vb->daddr = daddr;
> > >+		vb->size = size;
> > > 	}
> > >
> > > 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
> > >0x%p\n",
> > >@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device *vpu_dev)
> > > 	if (!vb->size || !vb->vaddr)
> > > 		return;
> > >
> > >-	if (vb->vaddr)
> > >-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
> > >-			      vb->size);
> > >+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
> > >>size);
> > >
> > > 	memset(vb, 0, sizeof(*vb));
> > > }
> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > >index aa0401f35d32..84dbe56216ad 100644
> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > >@@ -1854,8 +1854,6 @@ static int wave5_vpu_open_dec(struct file *filp)
> > > 		goto cleanup_inst;
> > > 	}
> > >
> > >-	wave5_vdi_allocate_sram(inst->dev);
> > >-
> > > 	return 0;
> > >
> > > cleanup_inst:
> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > >index 8bbf9d10b467..86ddcb82443b 100644
> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > >@@ -1727,8 +1727,6 @@ static int wave5_vpu_open_enc(struct file *filp)
> > > 		goto cleanup_inst;
> > > 	}
> > >
> > >-	wave5_vdi_allocate_sram(inst->dev);
> > >-
> > > 	return 0;
> > >
> > > cleanup_inst:
> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > >index f3ecadefd37a..2a0a70dd7062 100644
> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > >@@ -178,16 +178,11 @@ static int wave5_vpu_probe(struct platform_device
> > >*pdev)
> > > 		return ret;
> > > 	}
> > >
> > >-	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
> > >-				   &dev->sram_size);
> > >-	if (ret) {
> > >-		dev_warn(&pdev->dev, "sram-size not found\n");
> > >-		dev->sram_size = 0;
> > >-	}
> > >-
> > 
> > Required SRAM size is different from each wave5 product.
> > And, SoC vendor also can configure the different SRAM size
> > depend on target SoC specification even they use the same wave5 product.
> > 
> 
> One can limit iomem address range in SRAM node. Here is the example of
> how I setup Wave515 with SRAM:
> 
> 	sram@2000000 {
> 		compatible = "mmio-sram";
> 		reg = <0x0 0x2000000 0x0 0x80000>;
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges = <0x0 0x0 0x2000000 0x80000>;
> 		
> 		wave515_vpu_sram: wave515-vpu-sram@0 {
> 			reg = <0x0 0x80000>;
> 			pool;
> 		};
> 	};
> 
> 	wave515@410000 {
> 		compatible = "cnm,wave515";
> 		reg = <0x0 0x410000 0x0 0x10000>;
> 		clocks = <&clk_ref1>;
> 		clock-names = "videc";
> 		interrupt-parent = <&wave515_intc>;
> 		interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
> 		resets = <&wave515_reset 0>,
> 			 <&wave515_reset 4>,
> 			 <&wave515_reset 8>,
> 			 <&wave515_reset 12>;
> 		sram = <&wave515_vpu_sram>;
> 	};
> 
> gen_pool_size() returns size of wave515_vpu_sram, no need for extra
> "sram-size" property.

"sram-size" property does need to be removed, as this was the consensus
gathered from my patch[0]. However, I think your method is still taking
a more static approach. One of the recommendations in my thread[1] was
making a list of known SRAM sizes given typical resolutions and
iterating through until a valid allocation is done. I don't think this
is the correct approach either based on Nas's comment that each Wave5
has different SRAM size requirement. It would clutter up the file too
much if each wave5 product had its own SRAM size mapping.

Could another approach be to change Wave5 dts node to have property set
as "sram = <&sram>;" in your example, then driver calls
gen_pool_availble to get size remaining? From there, a check could be 
put in place to make sure an unnecessary amount is not being allocated.


[0]: https://lore.kernel.org/lkml/99bf4d6d988d426492fffc8de9015751c323bd8a.camel@ndufresne.ca/
[1]: https://lore.kernel.org/lkml/9c5b7b2c-8a66-4173-dfe9-5724ec5f733d@ti.com/

Thanks,
Brandon
> 
> > Thanks.
> > Nas.
> > 
> > > 	dev->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> > > 	if (!dev->sram_pool)
> > > 		dev_warn(&pdev->dev, "sram node not found\n");
> > >+	else
> > >+		wave5_vdi_allocate_sram(dev);
> > >
> > > 	dev->product_code = wave5_vdi_read_register(dev,
> > >VPU_PRODUCT_CODE_REGISTER);
> > > 	ret = wave5_vdi_init(&pdev->dev);
> > >@@ -259,6 +254,8 @@ static int wave5_vpu_probe(struct platform_device
> > >*pdev)
> > > err_clk_dis:
> > > 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
> > >
> > >+	wave5_vdi_free_sram(dev);
> > >+
> > > 	return ret;
> > > }
> > >
> > >@@ -275,6 +272,7 @@ static void wave5_vpu_remove(struct platform_device
> > >*pdev)
> > > 	v4l2_device_unregister(&dev->v4l2_dev);
> > > 	wave5_vdi_release(&pdev->dev);
> > > 	ida_destroy(&dev->inst_ida);
> > >+	wave5_vdi_free_sram(dev);
> > > }
> > >
> > > static const struct wave5_match_data ti_wave521c_data = {
> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> > >b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> > >index fa62a85080b5..8d88381ac55e 100644
> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> > >@@ -749,7 +749,6 @@ struct vpu_device {
> > > 	struct vpu_attr attr;
> > > 	struct vpu_buf common_mem;
> > > 	u32 last_performance_cycles;
> > >-	u32 sram_size;
> > > 	struct gen_pool *sram_pool;
> > > 	struct vpu_buf sram_buf;
> > > 	void __iomem *vdb_register;
> > >--
> > >2.44.0
> > 
> 

