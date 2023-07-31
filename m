Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48E976A194
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGaT5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGaT5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF9A19A1;
        Mon, 31 Jul 2023 12:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B462612A3;
        Mon, 31 Jul 2023 19:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C26C433C9;
        Mon, 31 Jul 2023 19:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690833452;
        bh=gVWhENbW2svJWpdqp8/zaoWH73GFpHEoK7J6e76AXJw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cl5vreo/BbOp/GK45AoGthPj1BDPBaH5Ct5CWKi8GvTLwBQoTIzJCopjpKTB6Buki
         /uQpj98TbnzVf8TmzjNRRbhlYegZrCx7SHwv9ePPR+F3j6p7LfZTtUiIqFnjo6zoqn
         5te0Ey4ITo7ag1wUH18fggs4jLTO09KzmzW9eniT8+Ig2OxZKiNFUNANzrwN/EfDFq
         Z7Pk9IvV3NcwOgZwY/yqRSvby3AtASwXZn/HCy4jxaulNrpfWNRMLd4vHFeVjqic0J
         zJ32n3zbE0Lgc3MXbGYHJXaBxLfkbpi10MOaE26iUAbgUEnhp5qB8uOeYk1riQt7N4
         GWncRapjHeYfA==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
In-Reply-To: <20230522071030.5193-1-zhuyinbo@loongson.cn>
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
Subject: Re: [PATCH v11 0/2] spi: loongson: add bus driver for the loongson
 spi
Message-Id: <169083345067.549704.9124509502835129039.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 20:57:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 15:10:28 +0800, Yinbo Zhu wrote:
> Loongson platform support spi hardware controller and this series patch
> was to add spi driver and binding support.
> 
> Change in v2:
> 		1. This [PATCH v2 1/2] dt-bindings patch need depend on clk patch:
> 	 	   https://
> 		   lore.kernel.org/all/20230307115022.12846-1-zhuyinbo@loongson.cn/
> 		2. Remove the clock-names in spi yaml file.
> 		3. Add "loongson,ls7a-spi" compatible in spi yaml file.
> 		4. Add an || COMPILE_TEST and drop && PCI then add some CONFIG_PCI
> 		   macro to limit some pci code.
> 		5. Make the spi driver top code comment block that use C++ style.
> 		6. Drop spi->max_speed_hz.
> 		7. Add a spin_lock for loongson_spi_setup.
> 		8. Add a timeout and cpu_relax() in loongson_spi_write_read_8bit.
> 		9. Add spi_transfer_one and drop transfer and rework entire spi
> 		   driver that include some necessary changes.
> 		10. Use module_init replace subsys_initcall.
> 		11. About PM interface that I don't find any issue so I don't add
> 		    any changes.
> Change in v3:
> 		1. This [PATCH v3 1/2] dt-bindings patch need depend on clk patch:
> 		   https://
> 		   lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
> 		2. Drop the unused blank line in loongson,ls-spi.yaml file.
> 		3. Replace clock minItems with clock maxItems in yaml file.
> 		4. Separate spi driver into platform module, pci module and core
> 		   module.
> 		5. Replace DIV_ROUND_UP with DIV_ROUND_UP_ULL to fix compile error
> 		   "undefined reference to `__aeabi_uldivmod'" and  "__udivdi3 undefined"
> 		   that reported by test robot.
> 		6. Remove the spin lock.
> 		7. Clear the loongson_spi->hz and loongson_spi->mode in setup to fixup
> 		   the issue that multiple spi device transfer that maybe cause spi was
> 		   be misconfigured.
> Change in v4:
> 		1. This [PATCH v4 1/2] dt-bindings patch need depend on clk patch:
> 		   https://
> 		   lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
> 		2. Add "#include <linux/io.h>" in spi-loongson-core.c for fix the compile
> 		   issue which devm_ioremap no declaration.
> 		3. Add "EXPORT_SYMBOL_GPL(loongson_spi_dev_pm_ops)" in
> 		   spi-loongson-core.c for fix the compile issue which
> 		   loongson_spi_dev_pm_ops undefined.
> Change in v5:
> 		1. Get rid of the clock patch's dependency and open-code the clock IDs.
> 		2. Fixup checkpatch issue that by installed ply and gitpython package
> 		   locally, but this series of patch's code doesn't have any change.
> Change in v6:
> 		1. Remove the "#include <dt-bindings/clock/loongson,ls2k-clk.h>" in
> 		   yaml file.
> Change in v7:
> 		1. Remove the "loongson,ls7a-spi" and change yaml file name as
> 		   "loongson,ls2k-spi.yaml".
> 		2. Use module_pci_driver and module_platform_driver to replace
> 		   module_init and module_exit.
> 		3. Drop ".owner	= THIS_MODULE" in spi platform driver.
> 		4. Add devm_spi_alloc_master devm_spi_register_master to simplify code.
> 		5. Add pci_disable_device() in loongson_spi_pci_unregister.
> Change in v8:
> 		1. Add reviewed-by information for spi bindings patch.
> 		2. Fixup the uncorrect spi yaml file path in MAINTAINERS file.
> 		3. Add spi_master_suspend and spi_master_resume in spi pm function.
> Change in v9:
> 		1. Make spi_master_suspend go first in pm suspend.
> Change in v10:
> 		1. Fix the compile issue about of_node_get and of_get_property no
> 		   declaration.
> 		2. set config SPI_LOONGSON_CORE invisible.
> 		3. Captial "spi" in commit log and Kconfig file.
> 		4. Write header files in alphabetical order.
> 		5. Use clamp_val, GENMASK() and BIT() in spi clock setting.
> 		6. Optimize clock and mode setting code.
> 		7. Use readb_poll_timeout in loongson_spi_write_read_8bit.
> 		8. Remove some useless dmesg print.
> 		9. Use device_set_node replace of_node_get.
> 		10. Use dev_err_probe in code.
> 		11. Use devm_clk_get_optional replace devm_clk_get.
> 		12. Remove SPI_NO_CS for drop 2k500 non common type spi.
> 		13. Use pcim_enable_device() and pcim_iomap_regions() in spi pci
> 		    driver.
> 		14. Passing the remapped address in loongson_spi_init_master.
> 		15. Remove the useless goto flag "err_out".
> 		16. Use pci vendor id in pci_ids.h.
> 		17. Use devm_platform_ioremap_resource in spi platform driver.
> 		18. Remove the useless item in pci_device_id.
> 		19. Remove the inned comma in of_device_id.
> 		20. Add some headfile in spi_loongson.h.
> 		21. Remove the useless extern for loongson_spi_init_master in
> 		    spi_loongson.h.
> Change in v11:
> 		1. Use spi_get_chipselect() to replace all spi->chip_select in
> 		   spi driver
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: add loongson spi
      (no commit info)
[2/2] spi: loongson: add bus driver for the loongson spi controller
      commit: 6c7a864007b66e60a3f64858a9555efed408b048

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

