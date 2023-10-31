Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5127DCF07
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbjJaOX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjJaOX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:23:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D2DC9;
        Tue, 31 Oct 2023 07:23:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3DBC433C8;
        Tue, 31 Oct 2023 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698762205;
        bh=gHF4eLRcWSiCzarvxwZwly4HI7O2WIslxS/qaonfnn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IF/eYp2S75f9+6CreJlVFYfR+mY6FyCR/9KiNtiYPaP0qLKjxIkDse+nhKqTi66os
         1CzFoWhIsoj9Cz2byYZMH9eyI1Sgo7/pq8LcaMN2o0e7jj+fx9phqA0FLjw2lIATOT
         P/hqOhMta3RA4afNUT6pEguAuSFticwlM3z4MnJzKRbkoM+7Go1Bl9BOyGoK5FHWvi
         a7doouIyGKGVIMyHQMZWCA7VhD52vxM/T3bqFPp9fF9rqHhKfg1GhoZRug274n1ZQJ
         ebV0fhvl9VUvEr1uOrLv3yoLv17cZrN0Y/teVBXBq+mGtAf8ktAdT0x6r58G1SYPKZ
         Bg/jSkwvNKZmw==
Date:   Tue, 31 Oct 2023 14:23:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        quic_srichara@quicinc.com, qpic_varada@quicinc.com
Subject: Re: [RFC PATCH 4/5] spi: qpic: Add support for qpic spi nand driver
Message-ID: <a1270a88-49a9-4bdb-89a9-ce6929f2294d@sirena.org.uk>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
 <20231031120307.1600689-5-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="910ikmaqu7YIRsJ2"
Content-Disposition: inline
In-Reply-To: <20231031120307.1600689-5-quic_mdalam@quicinc.com>
X-Cookie: Is it clean in other dimensions?
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--910ikmaqu7YIRsJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 05:33:06PM +0530, Md Sadre Alam wrote:

> +config SPI_QPIC_SNAND
> +	tristate "QPIC SNAND controller"
> +	default y
> +	depends on ARCH_QCOM
> +	help
> +	  QPIC_SNAND(Quad SPI) driver for Qualcomm QPIC_SNAND controller.
> +

I don't see any build dependencies on anything QC specific so please add
an || COMPILE_TEST here, this makes it much easier to do generic changes
without having to build some specific config.

> +++ b/drivers/spi/Makefile
> @@ -153,6 +153,7 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+=3D spi-xtensa-xtfp=
ga.o
>  obj-$(CONFIG_SPI_ZYNQ_QSPI)		+=3D spi-zynq-qspi.o
>  obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+=3D spi-zynqmp-gqspi.o
>  obj-$(CONFIG_SPI_AMD)			+=3D spi-amd.o
> +obj-$(CONFIG_SPI_QPIC_SNAND)            +=3D spi-qpic-snand.o

Please keep this alphabetically sorted (there are some mistakes there
but no need to add to them).

> + * 	Sricharan R <quic_srichara@quicinc.com>
> + */
> +
> +#include <linux/mtd/spinand.h>
> +#include <linux/mtd/nand-qpic-common.h>
> +

This should be including the SPI API, and other API headers that are
used directly like the platform and clock APIs.

> +static int qcom_snand_init(struct qcom_nand_controller *snandc)
> +{
> +	u32 snand_cfg_val =3D 0x0;
> +	int ret;

=2E..

> +	ret =3D submit_descs(snandc);
> +	if (ret)
> +		dev_err(snandc->dev, "failure in sbumitting spiinit descriptor\n");
> +
> +	free_descs(snandc);

This seems to be doing a bit more than I would expect an init function
to, and it's very surprising to see the descriptors freed immediately
after something called a submit (which suggests that the descriptors are
still in flight).

> +static int qpic_snand_read_page(struct qcom_nand_controller *snandc,
> +				const struct spi_mem_op *op)
> +{
> +	return 0;
> +}
> +
> +static int qpic_snand_write_page(struct qcom_nand_controller *snandc,
> +				const struct spi_mem_op *op)
> +{
> +	return 0;
> +}

=2E..

> +static int qpic_snand_exec_op(struct spi_mem *mem, const struct spi_mem_=
op *op)
> +{
> +	struct qcom_nand_controller *snandc =3D spi_controller_get_devdata(mem-=
>spi->master);
> +	dev_dbg(snandc->dev, "OP %02x ADDR %08llX@%d:%u DATA %d:%u", op->cmd.op=
code,
> +		op->addr.val, op->addr.buswidth, op->addr.nbytes,
> +		op->data.buswidth, op->data.nbytes);
> +
> +	/*
> +	 * Check for page ops or normal ops
> +	 */
> +	if (qpic_snand_is_page_op(op)) {
> +		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
> +			return qpic_snand_read_page(snandc, op);
> +		else
> +			return qpic_snand_write_page(snandc, op);

So does the device actually support page operations?  The above looks
like the driver will silently noop them.

> +	snandc->base_phys =3D res->start;
> +	snandc->base_dma =3D dma_map_resource(dev, res->start,
> +					   resource_size(res),
> +					   DMA_BIDIRECTIONAL, 0);
> +	if (dma_mapping_error(dev, snandc->base_dma))
> +		return -ENXIO;
> +
> +	ret =3D clk_prepare_enable(snandc->core_clk);
> +	if (ret)
> +		goto err_core_clk;

The DMA mapping and clock enables only get undone in error handling,
they're not undone in the normal device release path.

> +
> +	ret =3D clk_prepare_enable(snandc->aon_clk);
> +	if (ret)
> +		goto err_aon_clk;
> +
> +	ret =3D clk_prepare_enable(snandc->iomacro_clk);
> +	if (ret)
> +		goto err_snandc_alloc;
> +
> +	ret =3D qcom_nandc_alloc(snandc);
> +	if (ret)
> +		goto err_snandc_alloc;
> +
> +	ret =3D qcom_snand_init(snandc);
> +	if (ret)
> +		goto err_init;
> +
> +	// setup ECC engine
> +	snandc->ecc_eng.dev =3D &pdev->dev;
> +	snandc->ecc_eng.integration =3D NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
> +	snandc->ecc_eng.ops =3D &qcom_snand_ecc_engine_ops;
> +	snandc->ecc_eng.priv =3D snandc;
> +
> +	ret =3D nand_ecc_register_on_host_hw_engine(&snandc->ecc_eng);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register ecc engine.\n");
> +		goto err_init;
> +	}
> +
> +	ctlr->num_chipselect =3D QPIC_QSPI_NUM_CS;
> +	ctlr->mem_ops =3D &qcom_spi_mem_ops;
> +	ctlr->mem_caps =3D &qcom_snand_mem_caps;
> +	ctlr->dev.of_node =3D pdev->dev.of_node;
> +	ctlr->mode_bits =3D SPI_TX_DUAL | SPI_RX_DUAL |
> +			    SPI_TX_QUAD | SPI_RX_QUAD;
> +
> +	ret =3D spi_register_master(ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_controller failed.\n");
> +		goto err_init;
> +	}
> +
> +	return 0;
> +err_init:
> +	qcom_nandc_unalloc(snandc);
> +err_snandc_alloc:
> +	clk_disable_unprepare(snandc->aon_clk);
> +err_aon_clk:
> +	clk_disable_unprepare(snandc->core_clk);
> +err_core_clk:
> +	dma_unmap_resource(dev, res->start, resource_size(res),
> +			   DMA_BIDIRECTIONAL, 0);
> +
> +	return ret;
> +}
> +
> +static int qcom_snand_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr =3D platform_get_drvdata(pdev);
> +	spi_unregister_master(ctlr);
> +
> +	return 0;
> +}
> +
> +static const struct qcom_nandc_props ipq9574_snandc_props =3D {
> +	.dev_cmd_reg_start =3D 0x7000,
> +	.is_bam =3D true,
> +	.qpic_v2 =3D true,
> +};
> +
> +static const struct of_device_id qcom_snandc_of_match[] =3D {
> +	{
> +		.compatible =3D "qcom,ipq9574-nand",
> +		.data =3D &ipq9574_snandc_props,
> +	},
> +	{}
> +}
> +MODULE_DEVICE_TABLE(of, qcom_snandc_of_match);
> +
> +static struct platform_driver qcom_snand_driver =3D {
> +	.driver =3D {
> +		.name		=3D "qcom_snand",
> +		.of_match_table =3D qcom_snandc_of_match,
> +	},
> +	.probe =3D qcom_snand_probe,
> +	.remove =3D qcom_snand_remove,
> +};
> +module_platform_driver(qcom_snand_driver);
> +
> +MODULE_DESCRIPTION("SPI driver for QPIC QSPI cores");
> +MODULE_AUTHOR("Md Sadre Alam <quic_mdalam@quicinc.com>");
> +MODULE_LICENSE("GPL");
> --=20
> 2.34.1
>=20

--910ikmaqu7YIRsJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVBDdUACgkQJNaLcl1U
h9Ayhgf+Ka7rwW/sqJZ1kD93K1uUeVHjyDvf9z9Z5yfcVvPLmIkHxGj4/ETeJFnP
QIHcNM4TsiFOAjfsSU0JyCZKrw+7jgOgRE4EVfWUAqLwD3FdY9wTjmQmp5/pVlwF
PbU9JbZjvWnPHhTjoZJNUJbA80Ea3E3ROE7FAS+P9VNTBgRqX00ubdyhXQ4ya3MT
F3M8NiZmWmKNXOhoOOcNZkNNovhJh2X5ZY3GKhJ1mDdqlCcs3Uy7QU6lyhf6S9wR
QhnUtjZuFqRSiSkVa7oTQIr7vZeG+gRj4uaK+QzglDmCJCInE/atWbONPyipveku
8Ya+gviROLEJ0/htPxRIOAWjmwlKQw==
=ddU9
-----END PGP SIGNATURE-----

--910ikmaqu7YIRsJ2--
