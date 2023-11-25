Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417B27F889E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 07:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKYGW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 01:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYGW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 01:22:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B841723
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 22:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bqA320GVN+uZQed2gewU6Z8mN/88pvHuFhFLqaCQ+Xc=; b=cYFYvGKoe7RENBvjmaDN1cO2dk
        QFAhNow16KPUTKEd7LcDL9DF0GQSFrSMu+9EL0qfOgoAci0JVztlsRId9QoNm0Zv/5hJWDL1/+xkZ
        vCZzpas8j820yeMoeUwutzmYsew12tN0R2m+rae09ybjz1mpKA6204Vug3upkcqyVZD/uafjhIQXx
        ewaoMTKwLcA5wDlAKAa+EmtP3OhHG21uXlO4yHmLq4MKtqSKwGnStRwT8V9vdSGLWJd1s/reov2xk
        7xFYRu5VvQFUqbmKB4+yxmQVzdRbkBKmhzpIEdAQsuDFxVFc0z8CtObPUw5qfl2P8r2JUfBGkwS1v
        E5B4nsgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6m4B-008g4N-3B;
        Sat, 25 Nov 2023 06:22:59 +0000
Date:   Fri, 24 Nov 2023 22:22:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] riscv: fix incorrect use of __user pointer
Message-ID: <ZWGSw6/6OxUnsSVW@infradead.org>
References: <20231124113803.165431-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124113803.165431-1-cleger@rivosinc.com>
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

On Fri, Nov 24, 2023 at 12:38:03PM +0100, Clément Léger wrote:
>  
>  #ifdef CONFIG_RISCV_M_MODE
> -static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
> +static inline int load_u8(struct pt_regs *regs, const unsigned long addr, u8 *r_val)

Please avoid the overly long line here.  Or just drop the const as that
is rather pointless for a scalaer (unlike the pointer).

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
