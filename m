Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190F1810BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378778AbjLMHvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378554AbjLMHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:51:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C84BD;
        Tue, 12 Dec 2023 23:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=yTukDIvPvseoy1hNbDDGgwwb3/RxkKSXoPYCWaH//5k=; b=dOw65wL1I3pJFA5OkCVW55giVL
        jJOalIrBc4j5r5LTdtvyxA1zUhkCTVINrUqDH91ldAoL5//nxZU6VM6LJDAHN+y+04ahad3r6/7Yt
        DEQIDRkPkYN+kmbw6X2G+ZSVBc39WtgYe+rCMFFt6P9w8Inp3lDn8SSU1hIFnrcn+RwKzOlIUQMNP
        mN69RIlgKuKQzEI6IkWrsjn2oYkIsOcLAQeMo46wLMFqi0XRJFNiVgkPqEib7Nhgr8OGCQTJXqsJG
        l6xc1q3tNol6mXgirY7wtWqmBT69VNPXFz108aP/W+EQpl+jM1nykC/2BzDh9FJ1OHjmAoU6xeY31
        lC0TRIqw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDK1i-00DxGw-2a;
        Wed, 13 Dec 2023 07:51:30 +0000
Date:   Tue, 12 Dec 2023 23:51:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Kees Cook <keescook@chromium.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <ZXligolK0ekZ+Zuf@bombadil.infradead.org>
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
 <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231207104357.kndqvzkhxqkwkkjo@localhost>
 <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
 <20231208095926.aavsjrtqbb5rygmb@localhost>
 <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
 <20231212090930.y4omk62wenxgo5by@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231212090930.y4omk62wenxgo5by@localhost>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:09:30AM +0100, Joel Granados wrote:
> My idea was to do something similar to your originl RFC, where you have
> an temporary proc_handler something like proc_hdlr_const (we would need
> to work on the name) and move each subsystem to the new handler while
> the others stay with the non-const one. At the end, the old proc_handler
> function name would disapear and would be completely replaced by the new
> proc_hdlr_const.
>=20
> This is of course extra work and might not be worth it if you don't get
> negative feedback related to tree-wide changes. Therefore I stick to my
> previous suggestion. Send the big tree-wide patches and only explore
> this option if someone screams.

I think we can do better, can't we just increase confidence in that we
don't *need* muttable ctl_cables with something like smatch or
coccinelle so that we can just make them const?

Seems like a noble endeavor for us to generalize.

Then we just breeze through by first fixing those that *are* using
mutable tables by having it just de-register and then re-register
new tables if they need to be changed, and then a new series is sent
once we fix all those muttable tables.

  Luis
