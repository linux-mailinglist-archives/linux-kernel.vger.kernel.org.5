Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8CD7F71ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345687AbjKXKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345372AbjKXKo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:44:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70848D7D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=AmiGlj96IFtlJWedK6S19XGZRl2qB+TgVTNmtgUUI8g=; b=qbHNfOqmV7NK8ehhm3Fr5JG1yj
        dNvwJMLvu19xEiNCB+Pz0qYxRqtKmtUgnhAMF67ykfjRtARf/OWKv5Pv/Nf+ibqV0vn1sEhrqyQy4
        +rv8qdsgtLVI8LyDdLzKh9pd/Pt2bhz5P6S8ZlpR6vL/19m+/et87XliTZ99TaPWGUIfQi67t9+46
        5q8rZ22IBSitVEZ9RPltdavy3MX1XKsGl9ugfxi+MXzNUgURgVgYuIOq3OfoWr3owDeWp5xoiiULn
        aTmdrNFYOzJ1ZMbnNBcHD/OpjjY+iqghFrfJgSgWsFkR33pv/dnk82paie+33WCA9TklXHLlVCQSN
        m/puwjFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6TgC-006u6Y-0k;
        Fri, 24 Nov 2023 10:45:00 +0000
Date:   Fri, 24 Nov 2023 02:45:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH] riscv: fix __user annotation in traps_misaligned.c
Message-ID: <ZWB+rPU4nm+Zxd7d@infradead.org>
References: <20231123141617.259591-1-ben.dooks@codethink.co.uk>
 <ZWA9HwUNHDFIw0wP@infradead.org>
 <7232f08e-dfe3-43d6-a4f7-abf8360bbfc1@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7232f08e-dfe3-43d6-a4f7-abf8360bbfc1@rivosinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:28:08AM +0100, Clément Léger wrote:
> I sent a similar patch two days ago with the same modification. I'm not
> sure to get it. Why is it better to pass the "unsigned long" type from
> the caller ? I mean, the resulting code would look like this right ?

Because you're legimitizing casting between address_space, which is a
horrible idea.  By casting either from the unsigned long you make it
very clear that deep magic is coming in and you make an informed
decisions based on the user_mode() predicate.  Witht a blind cast
to add/remove a __user you don't.

I'm actually surprised sparse even allows __user casts without __force.
