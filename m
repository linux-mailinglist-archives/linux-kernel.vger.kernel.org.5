Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465E4810A40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjLMG1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjLMG1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:27:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE50DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t4PAQOx3+CSuE5dewUU3fyIn/zPxMFS5epqiKPqRs7g=; b=4v49IxPnL/WeYwBSKh5v7e+6+l
        QzL/cAUEz76WnwoyyTOwK/TfPaxcW/A6BNwschiIbeoHrD9sx2WvoHoUm/pr8pKC+uOakcn5V2B7z
        +CCC1ln+sMr1XfYr9qxEsO7/Aajod7BagjomnIg4kiI8eCsYuJzjbY/h5pOvlGWLoBt576Rj9L8Db
        Y0HSXQgIotmUi//eMk/qB0nu1pJ+hCqs4NSpNcJjPxxBSusVRnEp89IajNRAKfAlUbh+ZqVDJirY9
        jCIIVvNQNOYFQeJ4mXkiKuHSDfEjd6Is0TlJQcCsIusj/SDNvUr4Vh1rIp2mfeK+q61oCj6JWjds8
        hw0TGJ0w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDIhx-00Dm7C-1m;
        Wed, 13 Dec 2023 06:27:01 +0000
Date:   Tue, 12 Dec 2023 22:27:01 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Joel Granados <j.granados@samsung.com>
Cc:     Conor Dooley <conor@kernel.org>, m.szyprowski@samsung.com,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, keescook@chromium.org, linux@weissschuh.net
Subject: Re: [PATCH] drivers: perf: constify the ctl_table argument of the
 riscv user access handler
Message-ID: <ZXlOtWf8ItvQwPT/@bombadil.infradead.org>
References: <20231206-flanking-frill-fffeca740221@spud>
 <mhng-8f7ddf72-8e2f-4dac-a67e-624eb5511a14@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-8f7ddf72-8e2f-4dac-a67e-624eb5511a14@palmer-ri-x1c9a>
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

On Tue, Dec 12, 2023 at 01:04:42PM -0800, Palmer Dabbelt wrote:
> On Wed, 06 Dec 2023 02:55:48 PST (-0800), Conor Dooley wrote:
> > On Wed, Dec 06, 2023 at 09:46:42AM +0100, Marek Szyprowski wrote:
> > > 
> > > Fix riscv build break after commit c8be9e66ca1e ("sysctl: treewide:
> > > constify the ctl_table argument of handlers").
> > > 
> > > Fixes: c8be9e66ca1e ("sysctl: treewide: constify the ctl_table argument of handlers")
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > This breaks the build when applied to the RISC-V tree. I'm going to mark
> > it "handled elsewhere" in patchwork since it needs to go into whatever
> > tree has the broken commit.
> 
> Ya, thanks.  There's a second copy of the fix over at
> https://lore.kernel.org/all/20231212-garage-pellet-c6a2bd34854c@spud/ .
> 
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> for this one too.  Just trying to merge that fixed hash into 6.7-rc1 is
> giving me a conflict, so I don't really want to pull it in myself.  So I
> think the best bet here is to have whomever took the patch take the fix, but
> LMK if there's some shared tag thing I should grab to take this into the
> RISC-V tree.

Thomas has to fold this in to his patch. I'll drop his patches for now
from linux-next.

  Luis
