Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D3D7E35FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjKGHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKGHjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:39:18 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA36C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:39:15 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a8ee23f043so62606247b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 23:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699342755; x=1699947555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0b2uAK0sTnMtt8sJVqtZt8wq7e4UQ5SUD8tyD2zEIAY=;
        b=ksipwHS19zH2ls3agE6j8mx1huUfmPqJJ1kaxOsECCEPJMeO5O1er/+kpclJWSDpZa
         huTP8ughYgWPQjChg8tg6YNeXU239LTttMlgPzhEs3Iy8iQArfwI0oeXb7c3I+3gsfII
         i0JLt0/wS1mJ3e1soD/fItalfEqm2PQZ3wokk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699342755; x=1699947555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b2uAK0sTnMtt8sJVqtZt8wq7e4UQ5SUD8tyD2zEIAY=;
        b=A5d9xf210eLGc6rAl3nGYheSjQqzsmMMSY3abMn9y5r4DqzAL4dnSC8ihAxLcdGjKS
         Oa40p+svScB1dyaA/GRAafsDYzMs3uaIMK3MBEFe/HWBaVBYhySecwfIv8OhnJAB4zJp
         J2Nbe8ir5RhjVBG1LfEUA1KxSkat6eggV2iV0SgRaeUFTpDts9UKbJY6yuVuDToORrkq
         x1vj36FIXeX4GmmsArPrPrdF2GtnqPwaNhYtdxHiM5LqPhWJG9h98hLxHOy/tPGpaGSJ
         0PkfyfzIhFbSxO4z6GygiaviQEcrlxFNBcmWU3/LnKX62Fk1hsBw7zReNonhQc83AEWt
         1qgw==
X-Gm-Message-State: AOJu0Yxz3PmPuCzt3MZsSDwysMsxvRwAfnuO6BcnvVf91mmGRpIMZGpc
        YQfrANZrgM/hjZNZ32VENl+nuQ==
X-Google-Smtp-Source: AGHT+IGBYGmHNhAi24PQZPJ3JnNUBMcMmYndGPSqtFx2tldIxGSOCx5EPERGhQOBR5I55xCoagxrYQ==
X-Received: by 2002:a25:cecd:0:b0:d9a:bfe4:d827 with SMTP id x196-20020a25cecd000000b00d9abfe4d827mr33406692ybe.19.1699342754897;
        Mon, 06 Nov 2023 23:39:14 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7d66:31e7:94a6:e6a9])
        by smtp.gmail.com with ESMTPSA id h22-20020a056a00231600b006be0bd6a4d8sm6666858pfh.36.2023.11.06.23.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 23:39:14 -0800 (PST)
Date:   Tue, 7 Nov 2023 16:39:11 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouxianrong <zhouxianrong@huawei.com>,
        Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] zram: unsafe zram_get_element call in zram_read_page()
Message-ID: <20231107073911.GB11577@google.com>
References: <d10cdf1d-4a67-48df-b389-3a51f60e9431@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d10cdf1d-4a67-48df-b389-3a51f60e9431@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/06 22:54), Vasily Averin wrote:
> @@ -1362,14 +1362,14 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
>  		ret = zram_read_from_zspool(zram, page, index);
>  		zram_slot_unlock(zram, index);
>  	} else {
> +		unsigned long entry = zram_get_element(zram, index);
>  		/*
>  		 * The slot should be unlocked before reading from the backing
>  		 * device.
>  		 */
>  		zram_slot_unlock(zram, index);
>  
> -		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
> -				     parent);
> +		ret = read_from_bdev(zram, page, entry, parent);

Hmmm,
We may want to do more here. Basically, we probably need to re-confirm
after read_from_bdev() that the entry at index still has ZRAM_WB set
and, if so, that it points to the same blk_idx. IOW, check that it has
not been free-ed and re-used under us.

Minchan, what do you think? Is that scenario possible?
