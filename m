Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C6A7EA34F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjKMTJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:09:08 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3A410D0;
        Mon, 13 Nov 2023 11:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=PRaP26uLRIaPUrqCO1u+n8xWlzTOZc8MxJaS8V8h730=; b=OrrCkCNw20xRbhRNOU25FUUF+h
        tSAGAQvoF7CbCxtxcmg8GoEVsUAuMT/tW2YsT48IzTnFv9p08lM+jyrbiMAAyx4jkHqdvWsvivjB6
        JfBnItjIV4efAdAUamlDy5wBmg67+vz1EQNJsynuiqGF1KPJqiWU3MNr/c7IkbCq4K40=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r2cIa-00065F-Pu; Mon, 13 Nov 2023 20:08:40 +0100
Date:   Mon, 13 Nov 2023 20:08:40 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] linkmode: convert
 linkmode_{test,set,clear,mod}_bit() to macros
Message-ID: <33967a01-9ed0-43db-a615-907abab989b7@lunn.ch>
References: <20231113173717.927056-1-aleksander.lobakin@intel.com>
 <20231113173717.927056-5-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113173717.927056-5-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 06:37:10PM +0100, Alexander Lobakin wrote:
> Since commit b03fc1173c0c ("bitops: let optimize out non-atomic bitops
> on compile-time constants"), the non-atomic bitops are macros which can
> be expanded by the compilers into compile-time expressions, which will
> result in better optimized object code. Unfortunately, turned out that
> passing `volatile` to those macros discards any possibility of
> optimization, as the compilers then don't even try to look whether
> the passed bitmap is known at compilation time. In addition to that,
> the mentioned linkmode helpers are marked with `inline`, not
> `__always_inline`, meaning that it's not guaranteed some compiler won't
> uninline them for no reason, which will also effectively prevent them
> from being optimized (it's a well-known thing the compilers sometimes
> uninline `2 + 2`).
> Convert linkmode_*_bit() from inlines to macros. Their calling
> convention are 1:1 with the corresponding bitops, so that it's not even
> needed to enumerate and map the arguments, only the names. No changes in
> vmlinux' object code (compiled by LLVM for x86_64) whatsoever, but that
> doesn't necessarily means the change is meaningless.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
