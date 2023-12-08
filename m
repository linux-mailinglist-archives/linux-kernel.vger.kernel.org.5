Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74658809BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjLHFUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjLHFUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:20:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA1F171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:20:38 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c6839373f8so1303957a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702012838; x=1702617638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S24zBF1HQHu7//kRNbFyR3A5MBKuHArHwgre5oFaz98=;
        b=BlZVeUaE7FW95xV40NHWDkDS8fySYp812MmcKYnHF8I+bzl4Lst0UwzKR7uyiIRcAm
         yDHyAP5WrTXy6RpGHrSDSnGeZ0f5n8HMwSnuIviD9HMrXoKUmEexxkJQhO/Mex5UiHxv
         W+bNgevUfan6BeM0kRLLsPsejH0lpwU4dOQHjh839ztL1DxAGC1vwr1vQ5hih1Z0I28c
         EW/cUs77wXmXFexrMZDhakHEcH/jsDHflD9Uror4hxd/OUNqCdSg/H1lGNau1fGOzl/L
         jidaksEVpoE6hiP6OaZI4EUFO4l7Ct8on3UpIe9GLbJw1WkW9+vhqAn8O4+FF1YoTePU
         Cy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702012838; x=1702617638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S24zBF1HQHu7//kRNbFyR3A5MBKuHArHwgre5oFaz98=;
        b=WT0nkGWzyN0q5wT4kYY+4+rv9L2fy9dUJmEVpOAfYGpUubJqpUtdIBc608YP6u1vc4
         HdpDbZbp47x33WIttWkl+f5BE0BCuPY0lhxhCdn0iA47X9VgaGfQS9fPjTHx2ypBPygv
         lWt7PM5cn9f9wBwZBtFTrKsbRC14n5tcKb8SMDYM1PaClE9vJxXf6o55IUMIvL3fBMto
         cGmoDnjIUSFt9Xlqc9LGAnmmMZGCIcjFY0ySgcjWS5FfHKXqsOeiBv9HMKgDXmBXAO+G
         C5RV5NbOZ6W0+Ggr+bl6LBvVoakyrYUV7WLWn/7ijhY1LoTXr/ehCqdmI1ANPc/4lyfF
         Xipg==
X-Gm-Message-State: AOJu0YwZBCH5mula9BY9uhvbDnZ4LZ0cu3oIx5Imb67W/ac2Vk420Qrd
        0OvHx3qGYUKo0hAzp/aYWhw=
X-Google-Smtp-Source: AGHT+IHFO7hxMW2q/zSGD4arP5k4TvrfV3bNdTgNoe2EcLYs3AnIy+d+fhMRX2btc5d5yXSj6ITIqQ==
X-Received: by 2002:a05:6a20:a4a4:b0:190:2036:fc4f with SMTP id y36-20020a056a20a4a400b001902036fc4fmr375050pzk.33.1702012837705;
        Thu, 07 Dec 2023 21:20:37 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id a7-20020a056a000c8700b006ce9da2e389sm715808pfv.13.2023.12.07.21.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:20:37 -0800 (PST)
Date:   Fri, 8 Dec 2023 13:20:31 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH 4/5] erofs: refine z_erofs_transform_plain() for
 sub-page block support
Message-ID: <20231208132031.00003b8d.zbestahu@gmail.com>
In-Reply-To: <20231206091057.87027-5-hsiangkao@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
        <20231206091057.87027-5-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Dec 2023 17:10:56 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Sub-page block support is still unusable even with previous commits if
> interlaced PLAIN pclusters exist.  Such pclusters can be found if the
> fragment feature is enabled.
> 
> This commit tries to handle "the head part" of interlaced PLAIN
> pclusters first: it was once explained in commit fdffc091e6f9 ("erofs:
> support interlaced uncompressed data for compressed files").
> 
> It uses a unique way for both shifted and interlaced PLAIN pclusters.
> As an added bonus, PLAIN pclusters larger than the block size is also
> supported now for the upcoming large lclusters.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/decompressor.c | 81 ++++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 021be5feb1bc..5ec11f5024b7 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -319,43 +319,58 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
>  static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>  				   struct page **pagepool)
>  {
> -	const unsigned int inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
> -	const unsigned int outpages =
> +	const unsigned int nrpages_in =
> +		PAGE_ALIGN(rq->pageofs_in + rq->inputsize) >> PAGE_SHIFT;
> +	const unsigned int nrpages_out =
>  		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
> -	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
> -					     PAGE_SIZE - rq->pageofs_out);
> -	const unsigned int lefthalf = rq->outputsize - righthalf;
> -	const unsigned int interlaced_offset =
> -		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
> -	u8 *src;
> -
> -	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
> -		DBG_BUGON(1);
> -		return -EFSCORRUPTED;
> -	}
> -
> -	if (rq->out[0] == *rq->in) {
> -		DBG_BUGON(rq->pageofs_out);
> -		return 0;
> +	const unsigned int bs = rq->sb->s_blocksize;
> +	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
> +	u8 *kin;
> +
> +	DBG_BUGON(rq->outputsize > rq->inputsize);
> +	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
> +		cur = bs - (rq->pageofs_out & (bs - 1));
> +		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
> +		cur = min(cur, rq->outputsize);
> +		if (cur && rq->out[0]) {
> +			kin = kmap_local_page(rq->in[nrpages_in - 1]);
> +			if (rq->out[0] == rq->in[nrpages_in - 1]) {
> +				memmove(kin + rq->pageofs_out, kin + pi, cur);
> +				flush_dcache_page(rq->out[0]);
> +			} else {
> +				memcpy_to_page(rq->out[0], rq->pageofs_out,
> +					       kin + pi, cur);
> +			}
> +			kunmap_local(kin);
> +		}
> +		rq->outputsize -= cur;
>  	}
>  
> -	src = kmap_local_page(rq->in[inpages - 1]) + rq->pageofs_in;
> -	if (rq->out[0])
> -		memcpy_to_page(rq->out[0], rq->pageofs_out,
> -			       src + interlaced_offset, righthalf);
> -
> -	if (outpages > inpages) {
> -		DBG_BUGON(!rq->out[outpages - 1]);
> -		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
> -			memcpy_to_page(rq->out[outpages - 1], 0, src +
> -					(interlaced_offset ? 0 : righthalf),
> -				       lefthalf);
> -		} else if (!interlaced_offset) {
> -			memmove(src, src + righthalf, lefthalf);
> -			flush_dcache_page(rq->in[inpages - 1]);
> -		}
> +	for (; rq->outputsize; rq->pageofs_in = 0, cur += PAGE_SIZE, ni++) {
> +		insz = min(PAGE_SIZE - rq->pageofs_in, rq->outputsize);

min_t(unsigned int, ,)?

../include/linux/minmax.h:21:28: error: comparison of distinct pointer types lacks a cast [-Werror]
  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))


> +		rq->outputsize -= insz;
> +		if (!rq->in[ni])
> +			continue;
> +		kin = kmap_local_page(rq->in[ni]);
> +		pi = 0;
> +		do {
> +			no = (rq->pageofs_out + cur + pi) >> PAGE_SHIFT;
> +			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
> +			DBG_BUGON(no >= nrpages_out);
> +			cnt = min(insz - pi, PAGE_SIZE - po);

ditto

> +			if (rq->out[no] == rq->in[ni]) {
> +				memmove(kin + po,
> +					kin + rq->pageofs_in + pi, cnt);
> +				flush_dcache_page(rq->out[no]);
> +			} else if (rq->out[no]) {
> +				memcpy_to_page(rq->out[no], po,
> +					       kin + rq->pageofs_in + pi, cnt);
> +			}
> +			pi += cnt;
> +		} while (pi < insz);
> +		kunmap_local(kin);
>  	}
> -	kunmap_local(src);
> +	DBG_BUGON(ni > nrpages_in);
>  	return 0;
>  }
>  

