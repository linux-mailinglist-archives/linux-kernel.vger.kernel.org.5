Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AC47A1E86
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjIOMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjIOMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:21:58 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FCF2130
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:21:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FCLReC055595;
        Fri, 15 Sep 2023 07:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694780487;
        bh=TWpbAq6I3kBmGNuyWKN72N3R+tyapGx8TSRGW6J2IEA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aFbI2P+sBFgmfKtIgi3XtPmM/+u2ojzdbGy0pJ+R5B3x4veK0ENy++Zaxg7D4O1N6
         /aZpSZjwX8t0woDkTY3UdKY0DzTrr2SOuExFd0kUdmNNjhx5xsUNrqg4B0UHupHQLj
         ChXcrxCjaOXMOticlJx/xh4i2m7KYEcHpkSovgX4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FCLRVJ017986
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Sep 2023 07:21:27 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 07:21:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 07:21:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FCLR15099803;
        Fri, 15 Sep 2023 07:21:27 -0500
Date:   Fri, 15 Sep 2023 07:21:27 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     <ssantosh@kernel.org>, <t-konduru@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v2 1/2] soc: ti: k3-socinfo: Revamp driver to accommodate
 different rev structs
Message-ID: <20230915122127.f4cogffx4sc3towe@uncork>
References: <20230915064650.2287638-1-n-francis@ti.com>
 <20230915064650.2287638-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230915064650.2287638-2-n-francis@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:16-20230915, Neha Malcom Francis wrote:
> k3-socinfo.c driver assumes silicon revisions to be 1.0, 2.0 etc. for
> every platform. However this typical style is not followed by J721E
> (1.0, 1.1) and need not be followed by upcoming silicon revisions as
> well. Adapt the driver to be similar to its U-Boot counterpart
> (drivers/soc/soc_ti_k3.c) that accounts for this difference on the
> basis of partno/family.
> 
> Note that we change the order of invocation of
> k3_chipinfo_partno_to_names before k3_chipinfo_variant_to_sr so we
> have the family name in case error is returned.

Drop reference to U-boot and others. How about this:

The driver assumes that the silicon revisions for every platform are
incremental and one-to-one, corresponding to JTAG_ID's variant field:
1.0, 2.0, and so on. This assumption is wrong for SoCs such as J721E,
where the variant field to revision mapping is 1,0, 1.1. Further,
there are SoCs such as AM65x where the sub-variant version requires
custom decoding of other registers.

Address this by using conditional handling per JTAG ID that requires
an exception with J721E as the first example. To facilitate this
conversion, use macros to identify the JTAG_ID part number and map them
to predefined string array.

> 
> Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>

Maintain original From or drop this or use Co-developed-by as applicable?

> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  drivers/soc/ti/k3-socinfo.c | 71 +++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> index 6ea9b8c7d335..6de1e3531af9 100644
> --- a/drivers/soc/ti/k3-socinfo.c
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -33,19 +33,37 @@
>  
>  #define CTRLMMR_WKUP_JTAGID_MFG_TI		0x17
>  
> +#define JTAG_ID_PARTNO_AM65X		0xBB5A
> +#define JTAG_ID_PARTNO_J721E		0xBB64
> +#define JTAG_ID_PARTNO_J7200		0xBB6D
> +#define JTAG_ID_PARTNO_AM64X		0xBB38
> +#define JTAG_ID_PARTNO_J721S2		0xBB75
> +#define JTAG_ID_PARTNO_AM62X		0xBB7E
> +#define JTAG_ID_PARTNO_J784S4		0xBB80
> +#define JTAG_ID_PARTNO_AM62AX		0xBB8D
> +#define JTAG_ID_PARTNO_AM62PX		0xBB9D
> +
>  static const struct k3_soc_id {
>  	unsigned int id;
>  	const char *family_name;
>  } k3_soc_ids[] = {
> -	{ 0xBB5A, "AM65X" },
> -	{ 0xBB64, "J721E" },
> -	{ 0xBB6D, "J7200" },
> -	{ 0xBB38, "AM64X" },
> -	{ 0xBB75, "J721S2"},
> -	{ 0xBB7E, "AM62X" },
> -	{ 0xBB80, "J784S4" },
> -	{ 0xBB8D, "AM62AX" },
> -	{ 0xBB9D, "AM62PX" },
> +	{ JTAG_ID_PARTNO_AM65X, "AM65X" },
> +	{ JTAG_ID_PARTNO_J721E, "J721E" },
> +	{ JTAG_ID_PARTNO_J7200, "J7200" },
> +	{ JTAG_ID_PARTNO_AM64X, "AM64X" },
> +	{ JTAG_ID_PARTNO_J721S2, "J721S2"},
> +	{ JTAG_ID_PARTNO_AM62X, "AM62X" },
> +	{ JTAG_ID_PARTNO_J784S4, "J784S4" },
> +	{ JTAG_ID_PARTNO_AM62AX, "AM62AX" },
> +	{ JTAG_ID_PARTNO_AM62PX, "AM62PX" },
> +};
> +
> +static char *j721e_rev_string_map[] = {

static const?

> +	"1.0", "1.1",
> +};
> +
> +static char *k3_rev_string_map[] = {

We can drop this (See below)

> +	"1.0", "2.0", "3.0",
>  };
>  
>  static int
> @@ -63,6 +81,29 @@ k3_chipinfo_partno_to_names(unsigned int partno,
>  	return -EINVAL;
>  }
>  
> +static int
> +k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
> +			  struct soc_device_attribute *soc_dev_attr)
> +{
> +	switch (partno) {
> +	case JTAG_ID_PARTNO_J721E:
> +		if (variant >= ARRAY_SIZE(j721e_rev_string_map))
> +			goto bail;
> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
> +						   j721e_rev_string_map[variant]);
> +		break;
> +	default:
> +		if (variant >= ARRAY_SIZE(k3_rev_string_map))
> +			goto bail;
> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
> +						   k3_rev_string_map[variant]);

How about retaining the old logic as is?

soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);

> +	}

what if !soc_dev_attr->revision error handling?

> +	return 0;
> +
> +bail:

Rename to something like err_unknown_variant ?

> +	return -EINVAL;
return -ENODEV instead to help distinguish between not having memory Vs
not finding a match?

> +}
> +
>  static int k3_chipinfo_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node = pdev->dev.of_node;
> @@ -94,7 +135,6 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>  
>  	variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
>  		  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
> -	variant++;
>  
>  	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
>  		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
> @@ -103,15 +143,16 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>  	if (!soc_dev_attr)
>  		return -ENOMEM;
>  
> -	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
> -	if (!soc_dev_attr->revision) {
> -		ret = -ENOMEM;
> +	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
> +	if (ret) {
> +		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);

Might be worthwhile to print the errno to distinguish between no mem
fail vs nodev match fail. - see below for k3_chipinfo_partno_to_names

> +		ret = -ENODEV;

don't over-ride the return value - that is probably a preceding cleanup patch
for k3_chipinfo_partno_to_names - also to distinguish between -ENOMEM vs
-ENODEV.

>  		goto err;
>  	}
>  
> -	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
> +	ret = k3_chipinfo_variant_to_sr(partno_id, variant, soc_dev_attr);
>  	if (ret) {
> -		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
> +		dev_err(dev, "Unknown revision for %s\n", soc_dev_attr->family);
>  		ret = -ENODEV;
>  		goto err_free_rev;
>  	}
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
