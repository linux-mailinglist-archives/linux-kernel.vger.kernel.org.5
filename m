Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B280D0A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbjLKQLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343886AbjLKQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:11:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8E8E;
        Mon, 11 Dec 2023 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OpglHNMJJzSYx4T/kW665rmi/jtAX7GsOChv2TFobqY=; b=ZBI0pwfXyKO4WzDr/GoqiD07Co
        m9H1p0cuX7jyp3zfEsid8e96EHf+FruxRo/h9Z7aOTec1EOYzK3w7twOUDO+5r7Uvy7TgMg4AhN5A
        XPpQFSaIDNbG/IBqRqkMg8PSNXaQJhQT+kmZwtDwtvsmC5rBu6G0SQKuKeXZ7OMu9/F0IkykBurtB
        EEhOu4Snnpdf9XEFPoOtR5CXbfp/Nzs620D3v3x75LY3An5m3oy0jj0x0sxyL/OfsYUpD8097DPzd
        N08o8m6dQi9yotKcqJ65fCfFOrsa2THZBmM8Ys+fEUKATZ5MecKZO9sg24Lt1Q188iC+k4EOk+doJ
        ZqUnAXFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCisO-005gRx-1R;
        Mon, 11 Dec 2023 16:11:24 +0000
Date:   Mon, 11 Dec 2023 08:11:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 09/12] riscv: Add support for kernel-mode FPU
Message-ID: <ZXc0rAdi7Vo8nbS8@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-10-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-10-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef __riscv_f
> +
> +#define kernel_fpu_begin() \
> +	static_assert(false, "floating-point code must use a separate translation unit")
> +#define kernel_fpu_end() kernel_fpu_begin()
> +
> +#else
> +
> +void kernel_fpu_begin(void);
> +void kernel_fpu_end(void);
> +
> +#endif

I'll assume this is related to trick that places code in a separate
translation unit, but I fail to understand it.  Can you add a comment
explaining it?

