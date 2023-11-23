Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746B37F63A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbjKWQJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345067AbjKWQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:09:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A9D6C;
        Thu, 23 Nov 2023 08:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700755762; x=1732291762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fI5I6aNI+wBDXkBFPmA1tH6IH8G5H7oF7TFedUg2UCA=;
  b=NabupWQTZlJqMWeoBE8u9FBPz5l4sGTmdL+FBqkvdWuHupdsqrXzVqWj
   SJdjx4mc+yVarcyP37/4rnIwsmY0sDotV03+2BK2+zbAmKjduicuLYX0N
   MIVO/tgV4hJOTLlBEmDuJi8y9BO/BVZyWkqk+1yYPJo8Tchjb2GFOtROg
   ceu02BVTr8XJQuzhpnaCeu3+JvRPFJmPZ4KN6uFOekwuuYP9WZbcd71F8
   +p3w2egb7kNSfkEFoWB7DYD/JGzPEO1gWIZL8OwpN431jF+x/1q8MYn2J
   44TRFWNFtutjC1c8B4NewBQ21GXVtka1BmEZC7zoXzlVF6WbhcJI0P1Ju
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423422204"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="423422204"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 08:09:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="771023284"
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="scan'208";a="771023284"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 08:09:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r6CGL-0000000GPTF-1VsT;
        Thu, 23 Nov 2023 18:09:09 +0200
Date:   Thu, 23 Nov 2023 18:09:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH v1 00/17] pinctrl: Convert struct group_desc to use
 struct pingroup
Message-ID: <ZV95JewcPbh_eKYh@smile.fi.intel.com>
References: <20231122164040.2262742-1-andriy.shevchenko@linux.intel.com>
 <ZV8zQZyT4Kwom-m_@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV8zQZyT4Kwom-m_@probook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:10:57PM +0100, J. Neuschäfer wrote:
> On Wed, Nov 22, 2023 at 06:35:32PM +0200, Andy Shevchenko wrote:
> > The struct group_desc has a lot of duplication with struct pingroup.
> > Deduplicate that by embeddind the latter in the former and convert
> > users.
> 
> It is strange to me that struct pingroup was introduced without any
> reference to the pre-existing struct group_desc, but it's good to see
> them unified at last.

Yep!

> Even better might be to move the definitions next to each other in the
> same file, so that anyone who finds one, also finds the other.

group_desc is a private to pin control generic implementation, pingroup is
generic for any pin control driver. Their current split is a right thing
to do, so no action required in this sense.

Thank you for review!

> > Linus, assuming everything is fine, I can push this to my tree.
> > Or you can apply it (assumming all CIs and people are happy with
> > the series).
> > 
> > NB. This series contains previously sent patches for Qualcomm and
> > Nuovoton. Here the updated version for Qualcomm that splits previous
> > patch to two and fixes compilation warnings.
> > 
> > NB. The function_desc is in plan to follow the similar deduplication.

-- 
With Best Regards,
Andy Shevchenko


