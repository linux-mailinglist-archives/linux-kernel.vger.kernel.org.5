Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EFF75783B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjGRJkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGRJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:40:37 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CF2E60
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=ZhDN5xdyT8ZvjweCNzylAZf/KC5Duc3I1+ahoL2VXIA=; b=KSOYynkSHA5y97Z6woL5qvdhRU
        xyYvERlso5ApWgz3OBU9rR3qoB/VrFcbPjhuokbbopAmHQByTFF5UJzn/geBP8E7NLK+Z6wf76uf3
        bsi+UT3uINfP6nn2akCUPJy14s8J+AFtbN8crMzAW8UF4WFclYf4z+jc8GuBDa9gVMzNOM4/3O3V/
        xhGdis7/x7fmTqJg5hxyUs/pW6wbCmcudmuJtihXNuODNqT6PbPZCGaJtqtr/Bh70IOoRupuyDwn+
        0fehpoq8NtFUgu/g4teTE4nCqMKyhMh+CvzyEKW2KKXuvoUPwDjAxry9uKhlj1EXLE+0CCs1YqWDh
        +bSIz/Bqhw+VTZhYYRYSZB0Ne6KwfgMNzHT4Ami7OYTaspT7D7KAG57q8c/Ol0B/hSW6nfVLK7nvm
        VK7/dmbu5ua3Zh08/Jdi+8N4D9KprAYXSqT0pwtXOfrv8apZoJCVADBnCZshxZAFDvXJDCjESPiug
        aQ+39bPh7ZWscTZLtVTKGJ7oE3O8N8pYFswue3y02g8mEMJVxXd2Q/yfF+KED7s3LqdX0Pc+1wqa9
        wqUb/T0iLKqNPLtLGYF4Q05HDgzg1KqPSuvDXlRjl/Dn9MNj74VnRZvIp9YmlS2T72HrhTYZKk9Sb
        Nr9qrcVIrxLje+3qEQofvTF9ijeL0eHyZqOda0iD4=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: [PATCH 3/3] fs/9p: fix type mismatch in file cache mode helper
Date:   Tue, 18 Jul 2023 11:40:25 +0200
Message-ID: <2057058.f4oLnqTvTQ@silver>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v1-3-0683b283b932@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v1-3-0683b283b932@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 17, 2023 6:29:02 PM CEST Eric Van Hensbergen wrote:
> There were two flags which had incorrect type in the
> paramaters of the file cache mode helper function.

1. typo: "parameters"

2. I would be more precise and actually name the two flags in question in the
commit log.

> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/fid.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index 297c2c377e3dd..29281b7c38870 100644
> --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -46,8 +46,8 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
>   * NOTE: these are set after open so only reflect 9p client not
>   * underlying file system on server.
>   */
> -static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
> -	int s_cache, unsigned int f_flags)
> +static inline void v9fs_fid_add_modes(struct p9_fid *fid, unsigned int s_flags,
> +	unsigned int s_cache, unsigned int f_flags)
>  {
>  	if (fid->qid.type != P9_QTFILE)
>  		return;
> 
> 




