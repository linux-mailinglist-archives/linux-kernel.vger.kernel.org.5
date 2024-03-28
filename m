Return-Path: <linux-kernel+bounces-122837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A22F788FE30
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30031C28ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4594D7E776;
	Thu, 28 Mar 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIaWOR98"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2064CF3;
	Thu, 28 Mar 2024 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625777; cv=none; b=mAAmpwP2KHaPMNROE/D6bsBno057JKT1VE0HyCR/9Ddo7LtXZE/GvLr4ASrRUUDDU84ztN2pkSmNfl4D4T2Jd4OPW88azkXMsvXI7X98riDMbSE7160lMlIKKzIBYLUmUx7nvD2Z2SCtGuaaU6Xo8dO4HUTUNMHpLWFz0DeC/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625777; c=relaxed/simple;
	bh=+dd+jag5eM71uUTRIhuq8X0Lno8/0/lFhRJKWZMHVRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgSsnU5S6JFbwI/pArQLNutoKdV5nbqVXjqWYnCeSkJF/d/HJaXH0I5+cAO4N7nvfvJmJDAJHr/9MUdM77UuPacRwaYSn819EqgpSc0Ffumln56M8zANuT6x5bRRO8bRbW1ENFGdgRfVYulrRzL/SuFDMCsqueGL6+uxmtwgNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIaWOR98; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51381021af1so1138596e87.0;
        Thu, 28 Mar 2024 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711625773; x=1712230573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtjJIYgeoGnDv/4X+Zsdpt9BP5P3jAb4HXMnkefb5Bw=;
        b=RIaWOR98wAza6y9K09psAG4POn8cgJzxvqycyAqfYPYWqwVUPUHIMasgzyXqPI3Hko
         KjlKuYASK7RrqvO4MFX3etbnaw0wCVsjM3qHOi5tWEbxshh/3YaEMTBHafKIyOnFIosM
         1JVLAp8Rlpyrj5Er2TbUCBqF5B927ZNYjpttQByNb6RgbKrfNqezKszjMwBzgI/3A8v1
         foO1jDf92tP9xLNXL1bT14j8yrgrV+N0Jbw17y4QqMyp9uEYR8MgWCXV56xY7BgojGvg
         t6IsWx35+Rq8JpVzUESkPPWqC9G+y9N4WVv9rbHxSqsDErZtdDDOFXqm7Pv8mgQzW/sO
         Fogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711625773; x=1712230573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtjJIYgeoGnDv/4X+Zsdpt9BP5P3jAb4HXMnkefb5Bw=;
        b=C2jrdOIeZwT+5RxV+wtAzbY7RIelreS1/bt+dr9WdvxJk4NNtSrxieFhZFlXCEEszr
         f43yO4hFG+iwAOnBmyx+Bhpn7+jRra7t+FUpHKiftxIgisEYM3MDH/PGxwroCwdWuU7J
         ob8LuQF4Sn3XYVy16K2Tv0su0UkHHaO5ArHhP29+1YLtRDIhh4o/eo2ZPveGO0OCoKFy
         2K7ZJ7ysjQccRDaEk/ZZZiC4PdY4FpqOr+I3G6ahisy3cTOBl6yKi9wnglMRjf0uY9WK
         qwr97lbr4kqzChoH5lyv2cfM26MAbnqXPqnbv9kSQhYyajDdFk2vFejezcEWN96m4sRx
         iW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWO6BLG+2P7lCYWQM+clnBMRbk34FwyOXdDVgQSH77eidNy8bS6VDce18KN1tqmerBUOBVARDTzVMRzjvs+jQSfNed4iyHHQLiDAZdq
X-Gm-Message-State: AOJu0YyJlXe0W+i3dEOfnbsvPDIS/CtTRlo+C6yWPwybPq6nnlPXOQ1N
	77Amcb1s75RRyewiJrw3ISKRV4uDtH5UCg7P4lj+YliZKlDT5a1n
X-Google-Smtp-Source: AGHT+IHrOqrj2CF4kdmaeAukasfNq6Jpaeb76GRC0ExoFh2Oe3TB8lz/k3BD1D8OIBeghf2anA3zSA==
X-Received: by 2002:a05:6512:3901:b0:513:572f:88f1 with SMTP id a1-20020a056512390100b00513572f88f1mr1846121lfu.27.1711625773126;
        Thu, 28 Mar 2024 04:36:13 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id f15-20020ac24e4f000000b005159fb35a9fsm166859lfr.38.2024.03.28.04.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:36:12 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:36:10 +0300
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jackson.lee" <jackson.lee@chipsnmedia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: RE: RE: [PATCH v2 4/5] media: chips-media: wave5: drop
 "sram-size" DT prop
Message-ID: <7lro7ryzjajpzvkjdj5cndkmzmjkqvhts6dmer4pkkt7dluiii@wp7ael4ae7jd>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
 <20240325064102.9278-5-brnkv.i1@gmail.com>
 <SL2P216MB1246537DD623B813453B28F9FB342@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <5hd7duzqhgdxpmvom3opkhwxkq55dmitk4gwdl4dy46q662in6@xxkmvdj6plqb>
 <SL2P216MB1246499CC9FED9BFB5B11DA3FB3B2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB1246499CC9FED9BFB5B11DA3FB3B2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>

On Thu, Mar 28, 2024 at 10:16:53AM +0000, Nas Chung wrote:
> Hi, Ivan.
> 
> >-----Original Message-----
> >From: Ivan Bornyakov <brnkv.i1@gmail.com>
> >Sent: Wednesday, March 27, 2024 9:27 PM
> >To: Nas Chung <nas.chung@chipsnmedia.com>
> >Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> >jackson.lee <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
> ><mchehab@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>
> >Subject: Re: RE: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-
> >size" DT prop
> >
> >On Wed, Mar 27, 2024 at 10:27:19AM +0000, Nas Chung wrote:
> >> Hi, Ivan.
> >>
> >> >-----Original Message-----
> >> >From: Ivan Bornyakov <brnkv.i1@gmail.com>
> >> >Sent: Monday, March 25, 2024 3:41 PM
> >> >To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
> >> ><jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
> ><mchehab@kernel.org>;
> >> >Philipp Zabel <p.zabel@pengutronix.de>
> >> >Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; linux-media@vger.kernel.org;
> >> >linux-kernel@vger.kernel.org
> >> >Subject: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size" DT
> >> >prop
> >> >
> >> >Use all available SRAM memory up to WAVE5_MAX_SRAM_SIZE. Remove
> >> >excessive "sram-size" device-tree property as genalloc is already able
> >> >to determine available memory.
> >> >
> >> >Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> >> >---
> >> > .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++---------
> >> > .../platform/chips-media/wave5/wave5-vpu.c    |  7 -------
> >> > .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
> >> > .../chips-media/wave5/wave5-vpuconfig.h       |  2 ++
> >> > 4 files changed, 13 insertions(+), 18 deletions(-)
> >> >
> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >> >b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >> >index 3809f70bc0b4..a63fffed55e9 100644
> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> >> >@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
> >> >*vpu_dev, struct vpu_buf *array,
> >> > void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
> >> > {
> >> > 	struct vpu_buf *vb = &vpu_dev->sram_buf;
> >> >+	dma_addr_t daddr;
> >> >+	void *vaddr;
> >> >+	size_t size;
> >> >
> >> >-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
> >> >+	if (!vpu_dev->sram_pool || vb->vaddr)
> >> > 		return;
> >> >
> >> >-	if (!vb->vaddr) {
> >> >-		vb->size = vpu_dev->sram_size;
> >> >-		vb->vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
> >> >-					       &vb->daddr);
> >> >-		if (!vb->vaddr)
> >> >-			vb->size = 0;
> >> >+	size = min_t(size_t, WAVE5_MAX_SRAM_SIZE, gen_pool_avail(vpu_dev-
> >> >>sram_pool));
> >> >+	vaddr = gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
> >> >+	if (vaddr) {
> >> >+		vb->vaddr = vaddr;
> >> >+		vb->daddr = daddr;
> >> >+		vb->size = size;
> >> > 	}
> >> >
> >> > 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
> >> >0x%p\n",
> >> >@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device
> >*vpu_dev)
> >> > 	if (!vb->size || !vb->vaddr)
> >> > 		return;
> >> >
> >> >-	if (vb->vaddr)
> >> >-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
> >> >-			      vb->size);
> >> >+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
> >> >>size);
> >> >
> >> > 	memset(vb, 0, sizeof(*vb));
> >> > }
> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >> >b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >> >index 1e631da58e15..2a972cddf4a6 100644
> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> >> >@@ -177,13 +177,6 @@ static int wave5_vpu_probe(struct platform_device
> >> >*pdev)
> >> > 		goto err_reset_assert;
> >> > 	}
> >> >
> >> >-	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
> >> >-				   &dev->sram_size);
> >> >-	if (ret) {
> >> >-		dev_warn(&pdev->dev, "sram-size not found\n");
> >> >-		dev->sram_size = 0;
> >> >-	}
> >> >-
> >> > 	dev->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> >> > 	if (!dev->sram_pool)
> >> > 		dev_warn(&pdev->dev, "sram node not found\n");
> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >> >b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >> >index da530fd98964..975d96b22191 100644
> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> >> >@@ -750,7 +750,6 @@ struct vpu_device {
> >> > 	struct vpu_attr attr;
> >> > 	struct vpu_buf common_mem;
> >> > 	u32 last_performance_cycles;
> >> >-	u32 sram_size;
> >> > 	struct gen_pool *sram_pool;
> >> > 	struct vpu_buf sram_buf;
> >> > 	void __iomem *vdb_register;
> >> >diff --git a/drivers/media/platform/chips-media/wave5/wave5-
> >vpuconfig.h
> >> >b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> >> >index d9751eedb0f9..9d99afb78c89 100644
> >> >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> >> >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
> >> >@@ -28,6 +28,8 @@
> >> > #define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 128K,
> >AVC
> >> >40K
> >> > #define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
> >> >
> >> >+#define WAVE5_MAX_SRAM_SIZE		(64 * 1024)
> >>
> >> WAVE521 can support 8K stream decoding/encoding.
> >> So, I suggest the MAX_SRAME_SIZE to 128 * 1024 (128KB).
> >>
> >> And, Current driver always enable sec_axi_info option if sram buffer is
> >allocated.
> >> But, we have to enable/disable the sec_axi_info option after checking
> >the allocated sram size is enough to decode/encode current bitstream
> >resolution.
> >
> >Do we really? As an experiment I tried to provide to Wave515 1KB of SRAM
> >memory and decoded 4k sample file was fine...
> >
> 
> You can think It seems like driver works fine.
> But, This is not the behavior we expect.
> There is a possibility that unexpected problems may occur.
> 

Ok, then we either

 1) don't try to allocate any availible SRAM memory up to
    match_data->sram_size, but allocate exact match_data->sram_size

or

 2) allocate any available SRAM memory up to match_data->sram_size, but
    check for allocated size before writing to registers W5_USE_SEC_AXI
    and W5_CMD_ENC_PIC_USE_SEC_AXI

With second variant I won't be able to add said check for Wave521, as I
don't know its memory requirements.

Also would this check be SoC specific or would it be common for any SoC
with same Wave5xx IP?

> >> Wave5 can enable/disable the sec_axi_info option for each instance.
> >>
> >> How about handle sram-size through match_data ?
> >> I can find some drivers which use match_data to configure the sram size.
> >>
> >> We can use current "ti,k3-j721s2-wave521c" device as a 4K supported
> >device.
> >> - .sram_size = (64 * 1024);
> >> Driver just allocate the sram-size for max supported resolution of each
> >device, and we don't need to check the sram-size is enough or not.
> >>
> >> Thanks.
> >> Nas.
> >>
> >> >+
> >> > #define MAX_NUM_INSTANCE                32
> >> >
> >> > #define W5_MIN_ENC_PIC_WIDTH            256
> >> >--
> >> >2.44.0
> >>

