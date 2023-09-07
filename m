Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23617797EAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjIGW0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjIGW0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:26:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDBB1BC7;
        Thu,  7 Sep 2023 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694125602;
        bh=cgZbxTCYgGpjj22ugISvwo52Q2rAVsGmksqytNaV7gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Had7YgUKSDmabypv6Z7AoXkYmN6B9q8uAc3gjTD6XopaYJEaixYB4imUQ6dKMm1Yj
         LDcvp/bN/RvuQSM7YL5BmUFW3DWp9m3BNbkqbYJH4xdIP73bFhPfGCanAJVVIbUkx1
         k1A0UuYTaorcjouw07fz9Ka2wk6Yw0bpK+Zuhx5cUezUSxVKxvJ+cn0z1X1uRrYqZr
         TtPcYWxTNW4o+TsbkVyulaXH5mL8g7K68WMl85x8t0jBGDqlvkeZdEbbQFoZxy63zY
         goAzVr7SZuAPSZ3ZluqAI/z3fTaBRxKDnFjcTERwRMATJ2PuTdeTQdvngZAe7xMi/9
         XkRlUmROcrn5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RhYkT3JyXz4x7q;
        Fri,  8 Sep 2023 08:26:41 +1000 (AEST)
Date:   Fri, 8 Sep 2023 08:26:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: linux-next: Tree for Sep 7
Message-ID: <20230908082625.487d39c4@canb.auug.org.au>
In-Reply-To: <e33882a1-f0e7-4bb1-04eb-332cadc8e2f6@gmail.com>
References: <20230907111112.02c64e37@canb.auug.org.au>
        <e33882a1-f0e7-4bb1-04eb-332cadc8e2f6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UYWjM/EUcA15EX4_AE3_26O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UYWjM/EUcA15EX4_AE3_26O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Akira,

On Thu, 7 Sep 2023 12:00:39 +0900 Akira Yokosawa <akiyks@gmail.com> wrote:
>
> Stephen, I have noticed quite a few redundant documentation files
> reappeared in today's linux-next.  I didn't check linux-next earlier
> this week.
>=20
> Redundant dirs:
>=20
>     Documentation/loongarch/
>     Documentation/mips/
>     Documentation/s390/
>     Documentation/translations/zh_CN/loongarch/
>     Documentation/translations/zh_CN/mips/
>=20
> Bisection blames merge commit be2bf9967daa ("Merge branch 'for-next'
> of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git").
>=20
> I suspect the conflict in Documentation/bpf/linux-notes.rst caused
> those files once moved to arch/ in upstream to be picked up again
> during "git merge" ...

Actually, it looks like the merge

  2bf3c0292f35 ("Merge patch series "RISC-V: Probe for misaligned access sp=
eed"")

in the risc-v tree was resolved very badly and dragged a lot of stuff
back in.

$ git diff --stat 2bf3c0292f35^..2bf3c0292f35
 Documentation/bpf/instruction-set.rst              |  478 +++++++++
 Documentation/bpf/linux-notes.rst                  |   83 ++
 Documentation/devicetree/bindings/arm/msm/ssbi.txt |   18 +
 .../devicetree/bindings/arm/tegra/nvidia,nvec.txt  |   21 +
 .../bindings/arm/tegra/nvidia,tegra20-ahb.txt      |   17 +
 .../bindings/arm/tegra/nvidia,tegra20-flowctrl.txt |   18 +
 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |   64 ++
 .../bindings/clock/amlogic,gxbb-clkc.txt           |   53 +
 .../devicetree/bindings/clock/hix5hd2-clock.txt    |   30 +
 .../devicetree/bindings/clock/oxnas,stdclk.txt     |   28 +
 .../devicetree/bindings/clock/xlnx,zynqmp-clk.txt  |   63 ++
 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     |  132 +++
 .../devicetree/bindings/gpio/brcm,kona-gpio.txt    |   52 +
 .../devicetree/bindings/gpio/gpio_oxnas.txt        |   47 +
 .../bindings/input/rmi4/rmi_2d_sensor.txt          |   56 +
 .../devicetree/bindings/input/rmi4/rmi_f01.txt     |   39 +
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |   61 ++
 .../devicetree/bindings/input/rmi4/rmi_spi.txt     |   56 +
 .../devicetree/bindings/net/davicom-dm9000.txt     |   27 +
 .../devicetree/bindings/net/ftgmac100.txt          |   67 ++
 .../devicetree/bindings/net/oxnas-dwmac.txt        |   41 +
 .../devicetree/bindings/net/xilinx_gmii2rgmii.txt  |   35 +
 .../bindings/opp/ti-omap5-opp-supply.txt           |   63 ++
 .../bindings/pinctrl/brcm,bcm11351-pinctrl.txt     |  461 +++++++++
 .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  |   56 +
 .../devicetree/bindings/pinctrl/pinctrl-single.txt |  262 +++++
 .../bindings/pinctrl/ti,omap-pinctrl.txt           |   13 +
 .../bindings/power/xlnx,zynqmp-genpd.txt           |   34 +
 Documentation/devicetree/bindings/pps/pps-gpio.txt |   30 +
 .../devicetree/bindings/regulator/slg51000.txt     |   88 ++
 .../devicetree/bindings/serial/cavium-uart.txt     |   19 +
 .../bindings/serial/nvidia,tegra20-hsuart.txt      |   73 ++
 .../bindings/serial/nxp,lpc1850-uart.txt           |   28 +
 Documentation/devicetree/bindings/sound/gtm601.txt |   19 +
 .../devicetree/bindings/sound/max9892x.txt         |   44 +
 .../devicetree/bindings/sound/nau8821.txt          |   55 +
 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  101 ++
 Documentation/devicetree/bindings/sound/wm8904.txt |   33 +
 .../bindings/spi/nvidia,tegra114-spi.txt           |   61 ++
 .../bindings/spi/nvidia,tegra20-sflash.txt         |   37 +
 .../bindings/spi/nvidia,tegra20-slink.txt          |   37 +
 .../devicetree/bindings/spi/spi-bcm63xx.txt        |   33 +
 .../bindings/thermal/nvidia,tegra124-soctherm.txt  |  238 +++++
 .../devicetree/bindings/usb/samsung-hsotg.txt      |   38 +
 Documentation/hwmon/smm665.rst                     |  187 ++++
 Documentation/loongarch/booting.rst                |   42 +
 Documentation/loongarch/features.rst               |    3 +
 Documentation/loongarch/index.rst                  |   22 +
 Documentation/loongarch/introduction.rst           |  390 +++++++
 Documentation/loongarch/irq-chip-model.rst         |  160 +++
 Documentation/mips/booting.rst                     |   28 +
 Documentation/mips/features.rst                    |    3 +
 Documentation/mips/index.rst                       |   21 +
 Documentation/mips/ingenic-tcu.rst                 |   71 ++
 Documentation/mm/frontswap.rst                     |  264 +++++
 .../ethernet/mellanox/mlx5/devlink.rst             |  313 ++++++
 Documentation/riscv/hwprobe.rst                    |   11 +-
 Documentation/s390/3270.ChangeLog                  |   44 +
 Documentation/s390/3270.rst                        |  298 ++++++
 Documentation/s390/cds.rst                         |  530 ++++++++++
 Documentation/s390/common_io.rst                   |  140 +++
 Documentation/s390/config3270.sh                   |   76 ++
 Documentation/s390/driver-model.rst                |  328 ++++++
 Documentation/s390/features.rst                    |    3 +
 Documentation/s390/index.rst                       |   30 +
 Documentation/s390/monreader.rst                   |  212 ++++
 Documentation/s390/pci.rst                         |  133 +++
 Documentation/s390/qeth.rst                        |   64 ++
 Documentation/s390/s390dbf.rst                     |  478 +++++++++
 Documentation/s390/text_files.rst                  |   11 +
 Documentation/s390/vfio-ap-locking.rst             |  115 +++
 Documentation/s390/vfio-ap.rst                     | 1069 ++++++++++++++++=
++++
 Documentation/s390/vfio-ccw.rst                    |  445 ++++++++
 Documentation/s390/zfcpdump.rst                    |   50 +
 .../translations/zh_CN/loongarch/booting.rst       |   48 +
 .../translations/zh_CN/loongarch/features.rst      |    8 +
 .../translations/zh_CN/loongarch/index.rst         |   27 +
 .../translations/zh_CN/loongarch/introduction.rst  |  353 +++++++
 .../zh_CN/loongarch/irq-chip-model.rst             |  157 +++
 Documentation/translations/zh_CN/mips/booting.rst  |   34 +
 Documentation/translations/zh_CN/mips/features.rst |   13 +
 Documentation/translations/zh_CN/mips/index.rst    |   29 +
 .../translations/zh_CN/mips/ingenic-tcu.rst        |   72 ++
 Documentation/translations/zh_CN/mm/frontswap.rst  |  196 ++++
 arch/arm/mach-keystone/keystone.h                  |   16 +
 arch/arm/mach-keystone/memory.h                    |   18 +
 arch/arm/mach-keystone/pm_domain.c                 |   50 +
 arch/arm/mach-nspire/mmio.h                        |   16 +
 arch/arm/mach-ux500/pm_domains.c                   |   79 ++
 arch/arm/mach-ux500/pm_domains.h                   |   17 +
 arch/arm/vfp/entry.S                               |   31 +
 arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi      |    1 +
 arch/hexagon/mm/ioremap.c                          |   44 +
 arch/parisc/include/asm/machdep.h                  |   17 +
 arch/parisc/kernel/pa7300lc.c                      |   51 +
 arch/powerpc/include/asm/mpc8260.h                 |   22 +
 arch/powerpc/kernel/trace/ftrace_64_pg.S           |   67 ++
 arch/powerpc/kernel/trace/ftrace_low.S             |   78 ++
 arch/powerpc/kernel/trace/ftrace_mprofile.S        |  251 +++++
 arch/powerpc/lib/alloc.c                           |   23 +
 arch/powerpc/platforms/82xx/m82xx_pci.h            |   14 +
 arch/powerpc/platforms/83xx/usb.c                  |  251 +++++
 arch/riscv/errata/thead/errata.c                   |    8 -
 arch/riscv/include/asm/alternative.h               |    5 -
 arch/riscv/include/asm/cpufeature.h                |    2 +
 arch/riscv/kernel/Makefile                         |    1 +
 arch/riscv/kernel/alternative.c                    |   19 -
 arch/riscv/kernel/copy-unaligned.S                 |   71 ++
 arch/riscv/kernel/copy-unaligned.h                 |   13 +
 arch/riscv/kernel/cpufeature.c                     |  104 ++
 arch/riscv/kernel/smpboot.c                        |    3 +-
 arch/x86/include/asm/microcode_amd.h               |   58 ++
 arch/x86/include/asm/microcode_intel.h             |   88 ++
 drivers/accel/ivpu/ivpu_hw_mtl.c                   | 1053 ++++++++++++++++=
+++
 drivers/accel/ivpu/ivpu_hw_mtl_reg.h               |  281 +++++
 drivers/acpi/acpi_amba.c                           |  130 +++
 drivers/clk/clk-oxnas.c                            |  251 +++++
 drivers/clk/meson/axg-aoclk.h                      |   18 +
 drivers/clk/meson/g12a-aoclk.h                     |   32 +
 drivers/clk/meson/gxbb-aoclk.h                     |   15 +
 drivers/clk/mmp/clk-mmp2.c                         |  454 +++++++++
 drivers/clk/mmp/clk-pxa168.c                       |  354 +++++++
 drivers/clk/mmp/clk-pxa910.c                       |  325 ++++++
 drivers/clk/qcom/lcc-mdm9615.c                     |  572 +++++++++++
 drivers/firmware/imx/scu-pd.c                      |  428 ++++++++
 .../gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c    |  658 ++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |  356 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h             |   84 ++
 .../drm/amd/display/dmub/inc/dmub_subvp_state.h    |  183 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramga102.c  |   40 +
 130 files changed, 16400 insertions(+), 39 deletions(-)

When I redid that merge:

$ git diff HEAD^..HEAD
 Documentation/riscv/hwprobe.rst      |  11 ++--
 arch/riscv/errata/thead/errata.c     |   8 ---
 arch/riscv/include/asm/alternative.h |   5 --
 arch/riscv/include/asm/cpufeature.h  |   2 +
 arch/riscv/kernel/Makefile           |   1 +
 arch/riscv/kernel/alternative.c      |  19 -------
 arch/riscv/kernel/copy-unaligned.S   |  71 ++++++++++++++++++++++++
 arch/riscv/kernel/copy-unaligned.h   |  13 +++++
 arch/riscv/kernel/cpufeature.c       | 104 +++++++++++++++++++++++++++++++=
++++
 arch/riscv/kernel/smpboot.c          |   3 +-
 10 files changed, 198 insertions(+), 39 deletions(-)

So, the risc-v tree needs to be cleaned up.
--=20
Cheers,
Stephen Rothwell

--Sig_/UYWjM/EUcA15EX4_AE3_26O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT6ThEACgkQAVBC80lX
0GyveQgAjoO3CGTSyYgydXPReFZzzJf7xGr6+qheBZaFw2RuKKG8EdQsKurbXkEi
zHaCW1+FCve/jYww/kDZQpGjo1Pr8mrcQLUfcMxlSXwpAGkkeFce93VDewtH/jOq
5O+XMpOpUWXNPCdcBbD42rn9syZ7DaNZjmTwgBH+V5aO2xqGkR7h8qj5WIuEyDcQ
z1We+EsOAA2XotIpYT2XN9r9Sw3PBXz8ofBOh/nJG5vacF/pQSnDSN8ifXL8n1Iq
zt4mWNdDOO9RLgiulidDG9Th7bS33GMY2uNK9JOiPb4W1xillXwXMtx19P645gwV
do7sjrMMCVIn7WdTlPIZl9a9ZatwEA==
=QXKD
-----END PGP SIGNATURE-----

--Sig_/UYWjM/EUcA15EX4_AE3_26O--
