Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD10E802BF0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjLDHSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDHSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:18:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A42FD7;
        Sun,  3 Dec 2023 23:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yY6ML3ph7CQ+D94sQfedEXVjNv2KO8ygBz1V+AY3K4k=; b=0KYe+x6B7veqLYYz68p/bY95tN
        Z+UY65Qpab9ylmVas2NJaOQtXEMU0SP7Nk+RLOMPWwFGZF89ElT2dmyVPv6SqeZWGv/aV+YxcLAYh
        OHu/swwu3rav0aMjJ578nuMf75bdhdn3XmNA4Zo2z6uHqlUVj5KhL/cn4zovathMshVQT6LEw2q8l
        TBkLH/0VjWrIK8bd24FNYWtU6ZGzblFOk+uqFvxxD2INRzdoDhz+pucuR7Ir84LPE0mUoac8pJoEz
        kWeysFtPr0krxUy1hT1rorvM2Ykm/hmgvY0wOrjW6VLV0M9a4btKBDRyBOKu82U0YRupMWW6yVm1M
        G/P7ItSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rA3Dz-0038qQ-2O;
        Mon, 04 Dec 2023 07:18:39 +0000
Date:   Sun, 3 Dec 2023 23:18:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, me@jcix.top,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 2/3] xfs: update dir3 leaf block metadata after swap
Message-ID: <ZW19T8PHLDx8o7ho@infradead.org>
References: <20231130040516.35677-1-zhangjiachen.jaycee@bytedance.com>
 <20231130040516.35677-3-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130040516.35677-3-zhangjiachen.jaycee@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:05:15PM +0800, Jiachen Zhang wrote:
>  		return error;
>  	/*
>  	 * Copy the last block into the dead buffer and log it.
> +	 * If xfs enable crc, the node/leaf block records its blkno, we
> +	 * must update it.

I'd rewrod this sentence as:

	 * On CRC-enabled file systems, also update the stamped in blkno.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
