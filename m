Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67A7A44A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbjIRI1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbjIRI1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:27:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BA11B6;
        Mon, 18 Sep 2023 01:26:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1362EC433C7;
        Mon, 18 Sep 2023 08:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695025603;
        bh=sMXA/6fEari6gFcvN4K1t3oFk4UFIEvXkCv0bTqIj5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2XvmWcozWHkSw/N8sb8Ry+NwN7vHjaQPDv3sxyalk6XldCahUkcj1cgGARw0kkHz
         yKR/pNFJ9fM2gO4iQ63iJwfyjudX+nJreWAHWO/Y0KD87L4PsdK8/ClAb9aCu4qrBz
         XIHRzKPc76RORYHeobe15Z6xsHb2TSzbLBEp9zlA=
Date:   Mon, 18 Sep 2023 10:26:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>,
        Thierry Reding <treding@nvidia.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Davis <afd@ti.com>,
        Matthew Howell <matthew.howell@sealevel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, Lukas Wunner <lukas@wunner.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Russell King <linux@armlinux.org.uk>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Jiamei Xie <jiamei.xie@arm.com>, Rob Herring <robh@kernel.org>,
        delisun <delisun@pateo.com.cn>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Yangtao Li <frank.li@vivo.com>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Baruch Siach <baruch@tkos.co.il>,
        Sherry Sun <sherry.sun@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sergey Organov <sorganov@gmail.com>, Tom Rix <trix@redhat.com>,
        Marek Vasut <marex@denx.de>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Lucas Tanure <tanure@linux.com>,
        linux-amlogic@lists.infradead.org,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-actions@lists.infradead.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yuan Can <yuancan@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-unisoc@lists.infradead.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Isaac True <isaac.true@canonical.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Hu <nick.hu@sifive.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Hammer Hsieh <hammerh0314@gmail.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Timur Tabi <timur@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH tty v1 00/74] serial: wrappers for uart port lock
Message-ID: <2023091826-seventy-opium-17b8@gregkh>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <87y1h3lwjh.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1h3lwjh.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:29:30AM +0206, John Ogness wrote:
> On 2023-09-14, John Ogness <john.ogness@linutronix.de> wrote:
> > Provide and use wrapper functions for spin_[un]lock*(port->lock)
> > invocations so that the console mechanics can be applied later on at a
> > single place and does not require to copy the same logic all over the
> > drivers.
> 
> For the full 74-patch series:
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Sorry that my SoB was missing from the initial posting.

Thanks for this, I'll rebuild my tree with this added.

greg k-h
