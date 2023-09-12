Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7620479CE99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjILKn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjILKnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:43:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9407F98
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IAQHVZXW2MalUHCANwdojX2cYCNpNFefug3dgvRipAE=; b=Q6HR9dzf2TMHSrq8jQklKZakU+
        MjSFfT6C1Zk/ATgGOA0v7nJZ4Dl9ODWXrPMFDqOLWCedzcQt9VN4T+TRLazJS3Xap18jH2V63zSKj
        XTu3oPmQ74A20TkpjSjM5RRmDdsJCXAEiuQcpE9cSXWpifEfNZV3w+GxQaqgbtFGsNI7hPOWFnlOR
        wzbxMrkqhZ5rN3C9I0uwmVM7FzAwLRTDkSMD+MdFdQiaGXMs4DS6NBCc0y7yqxfpnf83nAv9a//ge
        yt24qrsDorks+T0+D44MQTPTN5q42EPKlx0Ue5jqejnuDnCFBadFjY3jQFC7HV7lODqr/XpK9o59J
        8cO3MDiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qg0rB-00634n-3B;
        Tue, 12 Sep 2023 10:42:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1932F300348; Tue, 12 Sep 2023 12:42:59 +0200 (CEST)
Date:   Tue, 12 Sep 2023 12:42:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] slab: drop unneeded NULL-pointer check in kfree auto
 cleanup
Message-ID: <20230912104258.GA12405@noisy.programming.kicks-ass.net>
References: <20230912082643.13144-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912082643.13144-1-brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:26:43AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> kfree() already accepts and silently ignores NULL-pointers, there's no
> need to check it when running the auto cleanup routine.

There is, because now the compiler can't help you anymore. Also see:

  https://lkml.kernel.org/r/169451499208.27769.5856056754166699857.tip-bot2@tip-bot2
