Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E95D7EF8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjKQU6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjKQU6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:58:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB03B6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rzRni3SyCzvfWCvZwkgGkrmcDNOymWMsu+dejMBz2eA=; b=JpU+e3o9oEBqqeK+qfnkW1baFa
        tqxEYyJjfTIgWLL+cs59Tg1X4fa+MjLZOwpLLEUU2jKGj9CneHjpc20Aa6k+KuKuZxfB9yUv0m1fT
        tKrVn/RY1H/qc5gjT9di9Nl7Jab5OOl3CqaVyrtMMhf8kfZ83iH+2yzay8abq8oZtMJidk4PK0JFR
        wR8CiySx7wx+VEELHiDRcC77Wzd0kpcZqTeUU1yxoEa8obQaMEpkw37VRi87cc2RhA8bGSm9zQVv4
        taMwfq8NyZqFDuCrnSaRiwNwIM6/NORQtGqEGJHoYZbdFCGpgjgxUgr9iKT7BdRkaXYcg4ru5rNCf
        HEyl+d7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r45uf-00BZLy-Ea; Fri, 17 Nov 2023 20:58:05 +0000
Date:   Fri, 17 Nov 2023 20:58:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Daniel Gomez <da.gomez@samsung.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/2] test_xarray: add tests for advanced multi-index use
Message-ID: <ZVfT3bs9+F0jqIAw@casper.infradead.org>
References: <20231104005747.1389762-2-da.gomez@samsung.com>
 <202311152254.610174ff-oliver.sang@intel.com>
 <ZVfS8fiudvHADtoR@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVfS8fiudvHADtoR@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 12:54:09PM -0800, Luis Chamberlain wrote:
> +/*
> + * Can be used in contexts which busy loop on large number of entries but can
> + * sleep and timing is if no importance to test correctness.
> + */
> +#define XA_BUG_ON_RELAX(xa, x) do {				\
> +	if ((tests_run % 1000) == 0)				\
> +		schedule();					\
> +	XA_BUG_ON(xa, x);					\
> +} while (0)

That is awful.  Please don't do that.  You're mixing two completely
unrelated thing into the same macro, which makes no sense.  Not only
that, it's a macro which refers to something in the containing
environment that isn't a paramter to the macro.

