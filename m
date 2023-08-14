Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9293C77B77C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjHNLWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjHNLWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:22:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7BFFA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CwtUPOcQ0JSmPG9joS7Jsy94l0Wu6FGllPhroZRoesw=; b=qz0rQNpK8fMbkHdREE5ywA9Z44
        MRZBhwNhNjgiOSISK5PlBdd/8RL2TWqH5NheUcedNazezmmK6/vyyYC3oXcA+/rpLEDwZ+t1cty8v
        zVv9CjI6LMn0m2DiLwBcBoLhUQbRNvGIEPqIiS7y0lArWgxwpxy7kyZ7qaNMz4l25anUv/0vxt58k
        61V9cxRr6FDgVzTpmXSoJJS0lMRY7h85ar5H9D9F8xfHViZ9l+7wYjSdf+Vj7ffEM6nxUn0/jNxFY
        qxWINC1yUtfX8xp+OuKWZzQQMFboa5zwQaHm0hKp6ZATJrR2CPcafi5UWZ2cy1sF6720zQAsLy3KX
        d5t4qY+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVVdo-00AYBH-2f;
        Mon, 14 Aug 2023 11:21:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3ABA630020B;
        Mon, 14 Aug 2023 13:21:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 280B420167A97; Mon, 14 Aug 2023 13:21:44 +0200 (CEST)
Date:   Mon, 14 Aug 2023 13:21:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Message-ID: <20230814112144.GF776869@hirez.programming.kicks-ass.net>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199901829.1782217.16990408177897780160.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169199901829.1782217.16990408177897780160.stgit@dwillia2-xfh.jf.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 12:43:38AM -0700, Dan Williams wrote:
> +static u8 *sev_report_new(struct device *dev, const struct tsm_desc *desc,

> +			  size_t *outblob_len)
> +{

> +
> +	u8 *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
> +

> +
> +	*outblob_len = size;
> +	no_free_ptr(buf);
> +	return buf;

This seems broken, no_free_ptr(x) is basically xchg(X, NULL) (except no
atomics). So the above would end up being:

	return NULL;

What you want to write is somehting like:

	return no_free_ptr(buf);

or, a convenient shorthand:

	return_ptr(buf);

