Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163BF80A5E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574018AbjLHOvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574027AbjLHOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:50:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054D173F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D819C433C8;
        Fri,  8 Dec 2023 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047064;
        bh=T5He5Aq/lOrFvOVWphEjDW0dKri7ifK39X4Qeuo70+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5QTFyOdj1eXrySHveWmpSTex81IQ1KyWDBN1yCYV8g7rGrE0MQwcWt4o2c92W+T3
         os5EtnSPi3XlsGr49dxsvM4RGe7YZrg9c022H4t2nv9kf7mQopxjd142ga2q6Qwmvu
         I/5HGtVHLG4vLCYoJkbQtw46v2I/Ip+lxXaVVwM1QWtfgqQkfOU66ZmI9QI2nX3/6P
         vA2M0+sIq29PPMT3ijIPU+P6+BvSBrVj6mkANgWo4Xl6yjSyXKGn5VkyBz9aMh9jll
         OhMiMMqPJ20LdZK1csiAQXDgNt7BxVUL2/l+Uh469Y/0VgBwMo9qmWxnO1kRkmrupj
         vPVH08da7wEEg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] soc: qcom: stats: fix 64-bit division
Date:   Fri,  8 Dec 2023 06:55:14 -0800
Message-ID: <170204733604.342318.17962213281334041105.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206123717.524009-1-arnd@kernel.org>
References: <20231206123717.524009-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Dec 2023 13:37:06 +0100, Arnd Bergmann wrote:
> Unguarded 64-bit division is not allowed on 32-bit kernels because this
> is very slow. The result of trying anyway is a link failure:
> 
> arm-linux-gnueabi-ld: drivers/soc/qcom/qcom_stats.o: in function `qcom_ddr_stats_show':
> qcom_stats.c:(.text+0x334): undefined reference to `__aeabi_uldivmod'
> 
> As this function is only used for debugging and not performance critical,
> rewrite it to use div_u64() instead. ARCH_TIMER_FREQ is a multiple of
> MSEC_PER_SEC anyway, so there is no loss in precisison.
> 
> [...]

Applied, thanks!

[1/2] soc: qcom: stats: fix 64-bit division
      commit: 73380e2573c34a45e01786750a4a2efafc2248bd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
