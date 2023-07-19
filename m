Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D5775A0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGSVvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSVvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629121FD9;
        Wed, 19 Jul 2023 14:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C49E661856;
        Wed, 19 Jul 2023 21:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC63C433C7;
        Wed, 19 Jul 2023 21:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689803465;
        bh=xH1GVI1iu7jDWprNY4OlcNDItWm4nUtPSNOgYZARkRg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KPXvnFJfVwdD7V9jlF+t84LLmmCAu20Xf3LSGGdQBU4rllGg/86JI8gthSmeSqbgy
         1BzZX8Lrsuht7Bmo35MyPNAPAYIQJgoyS80GoNQOsPCCHDTyf9OXMYYcCPDUbmz4hA
         bXkTPRyLe1HKzTRg7z2QEt49YTi6b8ytUEs8wxOKMoz1I+C7mtChB+H6bThU/7dgNM
         /ELHKZohnTbTuwAlYO77+dCbB7mefNCzWFyS2I2iI+xth1Wofm6SCGP8ROK+DRA73L
         7tkmVsU4tRYN+PAmL3u6qPtmphVG9I2so6L5UMUIs7LWhHmKxhJALatOfXsx6kZvcl
         dNAHPzS/emTWA==
Message-ID: <f7f861bbfb33b90d24e72eea3833d194.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230707135852.24292-8-bhe@redhat.com>
References: <20230707135852.24292-1-bhe@redhat.com> <20230707135852.24292-8-bhe@redhat.com>
Subject: Re: [PATCH 7/8] clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        schnelle@linux.ibm.com, vkoul@kernel.org, eli.billauer@gmail.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, derek.kiernan@amd.com,
        dragan.cvetic@amd.com, linux@dominikbrodowski.net,
        Jonathan.Cameron@huawei.com, linus.walleij@linaro.org,
        tsbogend@alpha.franken.de, joyce.ooi@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, tglx@linutronix.de, maz@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        frowand.list@gmail.com, Baoquan He <bhe@redhat.com>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jul 2023 14:51:02 -0700
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

Quoting Baoquan He (2023-07-07 06:58:51)
> On s390 systems (aka mainframes), it has classic channel devices for
> networking and permanent storage that are currently even more common
> than PCI devices. Hence it could have a fully functional s390 kernel
> with CONFIG_PCI=3Dn, then the relevant iomem mapping functions
> [including ioremap(), devm_ioremap(), etc.] are not available.
>=20
> Here let COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM so that it won't
> be built to cause below compiling error if PCI is unset:
>=20
> ------

Applied to clk-fixes
