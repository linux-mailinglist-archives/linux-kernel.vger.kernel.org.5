Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A6E7D46F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjJXFfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjJXFfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:35:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BC111A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:35:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083f61322fso31918335e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698125737; x=1698730537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMzU+U96Jrm5po+L9hfZsnb4xlLlkv8Neetn1c1Qi+w=;
        b=C5RMelYFv2AJ/NffMFYA6lakp/mcmLq+A4jTz2NCEsLZxLaJi+3AX9YY0T1LEdXK8O
         xDRSzCcR20TPRjVBqBxJL+g6aHCqa0eE/33xh3yhXUYs4VaAd+LI6zubPqn7LqTahO2L
         kYmy4vypzJUn7y54HROv/bGMarH3pfJrMIFQRAheNySCqdELa9KK+dK19HBnqTLfUgz5
         U9IYwb1ak11vAkBqIty5i5Ogk7K1GXRsb29oD77ZnZU7OgSKW8VlDp2uaGFvyUXTQzF1
         UfPxULnqlHKLhjghIuxuv8xaEkUoYNM6+SiOyKxRM9l09r/KQZ53w/3MtywnEwEdvudK
         Eu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698125737; x=1698730537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMzU+U96Jrm5po+L9hfZsnb4xlLlkv8Neetn1c1Qi+w=;
        b=tA+7EeOCMSSD6/SJFGOnId+PvF0mBNecydoOfvymZQ5nUVSMbhX6PpzKK8wv0eUZsw
         xLSxx6lwcf0VZWxbZr5GZHtxccy4AHmfiiZnuSL6wD+szqGWYc2eWPJWUZzQNzFyTZQ1
         Jvpcr1CIjNIID+VgGkKdSXxgjQ40fJL9O0tX4SxRs0tHCPbVrdaI3bfUudqcx1IbOGiZ
         /TUJOXNoFlTXPxTnkcH0P77BrLe9QhxnR8n1UPwLdYeWNvnc1dO1mu8AF4s3JV0Lzfgu
         FZWAFV8TMTg2NY7WEYsvgYQ7R52Uygikb/R7fc+2EpcjlXfik4/ixMOkX1JqiHS2ol3h
         PR3A==
X-Gm-Message-State: AOJu0YyUQlaswIjiKkafE7WWYkbpBaIPv/54FW701wfWYmXuEaADjGmP
        z0tSFFdPNOyVyMuXpCLRLW34qg==
X-Google-Smtp-Source: AGHT+IEo8KiM/RFZR69QTA1j71GiZ98Rzw3Ga2dc1o6Sa78qJi5HYkvqoAQIkUVRn3xG1/AuzJPStA==
X-Received: by 2002:a05:600c:5122:b0:408:3bbd:4a82 with SMTP id o34-20020a05600c512200b004083bbd4a82mr8534471wms.15.1698125737154;
        Mon, 23 Oct 2023 22:35:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f5-20020a056000128500b0031c6581d55esm9115663wrx.91.2023.10.23.22.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 22:35:36 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:35:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     keescook@chromium.org, Robert Richter <rric@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/thunderx: Fix some potential buffer overflow in
 thunderx_ocx_com_threaded_isr()
Message-ID: <70bd7480-508a-451d-bc0a-f78e652cf511@kadam.mountain>
References: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 07:13:51PM +0200, Christophe JAILLET wrote:
> @@ -1127,27 +1128,26 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
>  				ARRAY_SIZE(ocx->com_err_ctx));
>  		ctx = &ocx->com_err_ctx[tail];
>  
> -		snprintf(msg, OCX_MESSAGE_SIZE, "%s: OCX_COM_INT: %016llx",
> -			ocx->edac_dev->ctl_name, ctx->reg_com_int);
> -
>  		decode_register(other, OCX_OTHER_SIZE,
>  				ocx_com_errors, ctx->reg_com_int);
>  
> -		strncat(msg, other, OCX_MESSAGE_SIZE);
> +		remaining = OCX_MESSAGE_SIZE;
> +		remaining -= scnprintf(msg, remaining, "%s: OCX_COM_INT: %016llx%s",
> +				       ocx->edac_dev->ctl_name, ctx->reg_com_int,
> +				       other);
>  
>  		for (lane = 0; lane < OCX_RX_LANES; lane++)
>  			if (ctx->reg_com_int & BIT(lane)) {
> -				snprintf(other, OCX_OTHER_SIZE,
> -					 "\n\tOCX_LNE_INT[%02d]: %016llx OCX_LNE_STAT11[%02d]: %016llx",
> -					 lane, ctx->reg_lane_int[lane],
> -					 lane, ctx->reg_lane_stat11[lane]);
> -
> -				strncat(msg, other, OCX_MESSAGE_SIZE);
> -
>  				decode_register(other, OCX_OTHER_SIZE,
>  						ocx_lane_errors,
>  						ctx->reg_lane_int[lane]);
> -				strncat(msg, other, OCX_MESSAGE_SIZE);
> +
> +				remaining -= scnprintf(msg + (OCX_MESSAGE_SIZE - remaining),
> +						       remaining,

Instead of doing "remaining -=" the canonincal way is "off +=".  Then
the snprintf() becomes:

	off += scnprintf(msg + off, OCX_MESSAGE_SIZE - off, ""\n\tOCX_...

Your way works but it makes my head hurt.

regards,
dan carpenter

