Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A32880EF28
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377006AbjLLOos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376936AbjLLOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:44:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E263114
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702392268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2xjg0etbdLaR5lepvPpgd7mHNgfxLS6jqL5w2wbBqn4=;
        b=EnLVaIzmwx+396Q5I/z4p4JpVglgVrHGpXTRaeNosBXpH3p0niMuS5WubsjS+IO75NvYm8
        3UCKqVcEYP01l4Atf+jIYkbRgaabczhxQJqL/ciomrj8rY2mK1xQjZMGLlPtP5AWqSaGrP
        r+J/pebbIp7U7ytjX7dtM0dXBJ1Nex8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-fBLEDJOPOdCsyHxcjjUcAg-1; Tue, 12 Dec 2023 09:44:26 -0500
X-MC-Unique: fBLEDJOPOdCsyHxcjjUcAg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42593d04ef6so43816671cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702392266; x=1702997066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xjg0etbdLaR5lepvPpgd7mHNgfxLS6jqL5w2wbBqn4=;
        b=L17iWZMyCS54W2vGm2AEwJm7QdAgZv7IXKl6PEi0BpP59J8tdRk9W2oir07c4D0rzm
         /jjeY7iGNDOxbANJIsjXG7DqA647LvkRFH27I+GXXV6s1AVYuqOdaReGOFU9IdrWpGVc
         yNOwmVF2I4HqjB2KqaUL2OD4ieEC+b62UTbguhpuzfSh8fO+Wz07PG1ORc7VfB9EkY8A
         +MammcccbCiT+a/QUp9FlJn+mV48fwsYiS0kCqLgofk56b3vLrrkFYm5eLnM0Pj6CoK1
         M0BG8SHLA29akA/J5juN66Q35eQmka+kmGLm+310gdmvO0qEdQaFvSxBaWMmqEGyKFwx
         P9Xw==
X-Gm-Message-State: AOJu0YymajvWwNu+cIgE6VoRVZUU69m0pbTIRZeSfhNrJ1TMGP+5DdQt
        deJ3N2S1z+l8sV/dlmaGRWs4nfdQQi8lIqYpyuG6wVAV8xxLxQhMaTc9lFFyCsx2DcorH5N7jt2
        GnATpMd6W0VsuF+acWsGoYlHI
X-Received: by 2002:ac8:5bc1:0:b0:425:8b0b:c626 with SMTP id b1-20020ac85bc1000000b004258b0bc626mr5762288qtb.104.1702392265843;
        Tue, 12 Dec 2023 06:44:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDx2IDXua2e+C7h/fWf6gqwxTnbpKX6V9M6OZxvVKCE6ICM3c3GFpuRnOcNIKUdVzrhEBXqA==
X-Received: by 2002:ac8:5bc1:0:b0:425:8b0b:c626 with SMTP id b1-20020ac85bc1000000b004258b0bc626mr5762274qtb.104.1702392265547;
        Tue, 12 Dec 2023 06:44:25 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id z23-20020ac87117000000b00423de58d3d8sm4110652qto.40.2023.12.12.06.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:44:24 -0800 (PST)
Date:   Tue, 12 Dec 2023 08:44:21 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     'Guanjun' <guanjun@linux.alibaba.com>
Cc:     neil.armstrong@linaro.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/1] soc: qcom: Fix compile error caused by uncorrectable
 definition of TRACE_INCLUDE_PATH
Message-ID: <kulysgxsa2lazwpbmovqtide3kvt6qq2dwtxmmi3ugznteo233@67ayvx2lduhi>
References: <20231209074716.2689401-1-guanjun@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209074716.2689401-1-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 03:47:16PM +0800, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> Compiler reports the error message when compiling the file drivers/soc/qcom/pmic_pdcharger_ulog.c:
>   - ./include/trace/define_trace.h:95:42: fatal error: ./pmic_pdcharger_ulog.h: No such file or directory
>       95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> 
> TRACE_INCLUDE_PATH shoule be relative to the path include/trace/define_trace.h, not
> the file including it. Fix it.
> 
> Fixes: 086fdb48bc65d(soc: qcom: add ADSP PDCharger ULOG driver)
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>

For what it is worth I sent a similar patch (which handled this by using
the CFLAG -I recommendation) over here about a week ago:

    https://lore.kernel.org/linux-arm-msm/20231205-pmicpdcharger-ulog-fixups-v1-1-71c95162cb84@redhat.com/

I keep disabling this driver locally when developing (or picking up that
patch) until something gets scooped up.

> ---
>  drivers/soc/qcom/pmic_pdcharger_ulog.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.h b/drivers/soc/qcom/pmic_pdcharger_ulog.h
> index 9d5d9af4fbe4..3ac994d160bd 100644
> --- a/drivers/soc/qcom/pmic_pdcharger_ulog.h
> +++ b/drivers/soc/qcom/pmic_pdcharger_ulog.h
> @@ -28,7 +28,7 @@ TRACE_EVENT(pmic_pdcharger_ulog_msg,
>  /* This part must be outside protection */
>  
>  #undef TRACE_INCLUDE_PATH
> -#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_PATH ../../../drivers/soc/qcom/
>  
>  #undef TRACE_INCLUDE_FILE
>  #define TRACE_INCLUDE_FILE pmic_pdcharger_ulog
> -- 
> 2.39.3
> 
> 

