Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894117676AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjG1T7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjG1T7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F8C3C1D;
        Fri, 28 Jul 2023 12:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03970621EC;
        Fri, 28 Jul 2023 19:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC75C433C7;
        Fri, 28 Jul 2023 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690574350;
        bh=gyKknie8tn5HcYLMA+5Ehd9Wff0dg0xZdRYDgv4F5eY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PG1Cwi7DPql2YaACT2lH04ILxdWm7kJDt6rKuokj0cMxUg3gtHKsY/S2pT6jLquUl
         utOl9cUz0P3lZglFbA964eomldiIAi1cdP4RFDMS6i54dUUd8YN/5jQLQ86vgGxCqs
         XSmP2MilBhvXRyvVi/ct7JmscOTqBi4pl2Isw3RAjEsFjl/wKTWJ54ELcIojMGw2Bo
         j32FQZwkbj6x3o6JBlRV7VuBBXB+yjmWPy+SdwZjViAnLflMIkte7Vu/hvlRQb/h1q
         ut0nBXGBjohte5UQ3wvWGVSKYepBHDH52KnZ5O0c4JyEwYRWGrrL8yF7yAlVhMcYwM
         kelvITv3KYJZw==
Message-ID: <35de4ce57cc5cde96495dc245cdf8382.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230723162245.35033-1-mmyangfl@gmail.com>
References: <20230723162245.35033-1-mmyangfl@gmail.com>
Subject: Re: [PATCH v5 00/13] clk: hisilicon: Migrate devm APIs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Date:   Fri, 28 Jul 2023 12:59:07 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Yang (2023-07-23 09:22:25)
> Migrate devm APIs for HiSilicon clock drivers and remove redundant codes.
>=20
> This series is a partial improvement of [1]
>=20

Thanks for resending. Can you fix these checkpatch and compilation errors?

	WARNING: Macros with flow control statements should be avoided
	#581: FILE: drivers/clk/hisilicon/clk.c:165:
	+#define hisi_clk_register_fn(fn, type, stmt) \
	+int fn(struct device *dev, const struct type *clks, \
	+       size_t num, struct hisi_clock_data *data) \
	+{ \
	+       void __iomem *base =3D data->base; \
	+\
	+       for (int i =3D 0; i < num; i++) { \
	+               const struct type *p_clk =3D &clks[i]; \
	+               struct clk_hw *clk =3D stmt; \
	+\
	+               if (IS_ERR(clk)) { \
	+                       pr_err("%s: failed to register clock %s\n", \
	+                              __func__, p_clk->name); \
	+                       return PTR_ERR(clk); \
	+               } \
	+\
	+               if (p_clk->alias) \
	+                       clk_hw_register_clkdev(clk, p_clk->alias, NULL); \
	+\
	+               data->clk_data->hws[p_clk->id] =3D clk; \
	+       } \
	+\
	+       return 0; \
	+} \
	+EXPORT_SYMBOL_GPL(fn);

	WARNING: macros should not use a trailing semicolon
	#581: FILE: drivers/clk/hisilicon/clk.c:165:
	+#define hisi_clk_register_fn(fn, type, stmt) \
	+int fn(struct device *dev, const struct type *clks, \
	+       size_t num, struct hisi_clock_data *data) \
	+{ \
	+       void __iomem *base =3D data->base; \
	+\
	+       for (int i =3D 0; i < num; i++) { \
	+               const struct type *p_clk =3D &clks[i]; \
	+               struct clk_hw *clk =3D stmt; \
	+\
	+               if (IS_ERR(clk)) { \
	+                       pr_err("%s: failed to register clock %s\n", \
	+                              __func__, p_clk->name); \
	+                       return PTR_ERR(clk); \
	+               } \
	+\
	+               if (p_clk->alias) \
	+                       clk_hw_register_clkdev(clk, p_clk->alias, NULL); \
	+\
	+               data->clk_data->hws[p_clk->id] =3D clk; \
	+       } \
	+\
	+       return 0; \
	+} \
	+EXPORT_SYMBOL_GPL(fn);

These look like instead of macros just write the functions out.

	total: 0 errors, 2 warnings, 1002 lines checked
	in patch 'clk: hisilicon: Migrate devm APIs' (74cb486e14c6)
	WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cu=
re the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
	#174: FILE: drivers/clk/hisilicon/clk-hix5hd2.c:337:
	+MODULE_LICENSE("GPL v2");

	total: 0 errors, 1 warnings, 150 lines checked
	in patch 'clk: hisilicon: hix5hd2: Convert into platform driver module' (f=
40d4d59c265)
	WARNING: DT compatible string "hisilicon,hip04-clock" appears un-documente=
d -- check ./Documentation/devicetree/bindings/
	#46: FILE: drivers/clk/hisilicon/clk-hip04.c:33:
	+       { .compatible =3D "hisilicon,hip04-clock",

	total: 0 errors, 1 warnings, 51 lines checked
	in patch 'clk: hisilicon: hip04: Convert into platform driver module' (fc9=
19e7f3f7b)
	WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cu=
re the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
	#353: FILE: drivers/clk/hisilicon/clk-hi6220.c:299:
	+MODULE_LICENSE("GPL v2");

	total: 0 errors, 1 warnings, 324 lines checked
	in patch 'clk: hisilicon: hi6220: Convert into platform driver module' (85=
c1694448a3)
	WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cu=
re the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
	#298: FILE: drivers/clk/hisilicon/clk-hi3670.c:917:
	+MODULE_LICENSE("GPL v2");

	total: 0 errors, 1 warnings, 278 lines checked
	in patch 'clk: hisilicon: hi3670: Convert into module' (934dee9208ea)
	WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cu=
re the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
	#251: FILE: drivers/clk/hisilicon/clk-hi3660.c:550:
	+MODULE_LICENSE("GPL v2");

	total: 0 errors, 1 warnings, 231 lines checked
	in patch 'clk: hisilicon: hi3660: Convert into module' (1ac1cef160ff)

	drivers/clk/hisilicon/clk-hi3559a.c: In function =E2=80=98hi3559av100_shub=
_default_clk_set=E2=80=99:
	drivers/clk/hisilicon/clk-hi3559a.c:628:53: error: =E2=80=98SZ_4K=E2=80=99=
 undeclared (first use in this function)
	  628 |         crg_base =3D devm_ioremap(dev, CRG_BASE_ADDR, SZ_4K);
	      |                                                     ^~~~~
