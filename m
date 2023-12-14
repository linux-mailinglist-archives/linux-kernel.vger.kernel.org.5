Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694A78126B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443131AbjLNE6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjLNE6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:58:41 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9A9F7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 20:58:47 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b9fcb3223dso4444691b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 20:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702529926; x=1703134726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M/eDbBnSAkVRJUrxqWp2z02YHOKbVeP2jj9zgSj9Xq0=;
        b=EnsrM9YtjgUetkpf59lJhmRG1lSG0q3gUnrjecsuAGyHIH4cCBgamD4rO6c7oQUrII
         dFFRiuvKsvS3XIGEm8SVbgoLd2zNF2aSfCzvYD42W75BdP6inzOQZxWM4kNB3Um/zCvv
         I/UZeELcCUWZ8j6VKZgimMXVokcOjGruzqUjcTOcfe3QAo4x6lA320cmUXIlHHVgENCG
         j4jpBoQEGzauCQxdOgj4drFtl87ORy7hbZ3xekgBVDX60MHuivcHfBkIjvlBsUXPlm3G
         +MGqNeMcrMjyd5z07bsXhPyLa92ll9m9v1kWmJofQFJnVAnBfnYoNGH1Lrq6amhzqJ7W
         9a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702529926; x=1703134726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/eDbBnSAkVRJUrxqWp2z02YHOKbVeP2jj9zgSj9Xq0=;
        b=tYRsOwTWBUb7BeXMZ9nnCRiqzvkA6TCIsxIAbGCWwkmlVmp2wwT+++exYr+GKeDh1s
         GbJeBYzOoCUISnfjFGWGe29ShdXx7d45kqiL8oVwm2IynTthrs3Ju3rKIuEQjjqoKTyg
         gmE9M+FRJRISYZdwcPSxPigiGx0XS3gtrW+EfkrXAh2EZmbRaLx/zYY/F38U2d0c4hNy
         hExwQVKOMnJJjyXB18nv033RAXzXv4UsEcbDlybLKb+Z6imuPb3cGw3XwwQTvXzA/Abi
         iWFhPZntwOpwICLvkrjqYtEl0TlQVdhf9MTbEN/Jjibv4pxk0Dm8dVBNzPEHrx+Jco6k
         RorQ==
X-Gm-Message-State: AOJu0Yw/K/mpBVdfPwBJ44a3pnDOULTK0iaOMyORBX4RcUHbzZLZhrEU
        5JK4PQLS/kUfBwKBGrqSR9/FrWrJ8p6H1Yti4g==
X-Google-Smtp-Source: AGHT+IEsGjbaCX0celZ3IskU0RM8rY0gp0k/KHnbnZcAJOW0IfN7a0QoV+GxEx1NCpC9se2uHBGbng==
X-Received: by 2002:a05:6808:1509:b0:3b8:5fec:5d6 with SMTP id u9-20020a056808150900b003b85fec05d6mr11796197oiw.27.1702529926128;
        Wed, 13 Dec 2023 20:58:46 -0800 (PST)
Received: from thinkpad ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id c14-20020aa781ce000000b006d082dd8086sm7041845pfn.214.2023.12.13.20.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 20:58:45 -0800 (PST)
Date:   Thu, 14 Dec 2023 10:28:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com
Subject: Re: [PATCH v2 00/17] scsi: ufs: qcom: Code cleanups
Message-ID: <20231214045839.GB2938@thinkpad>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
 <yq1zfydfmqu.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1zfydfmqu.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:10:41PM -0500, Martin K. Petersen wrote:
> 
> Manivannan,
> 
> > This series has code some cleanups to the Qcom UFS driver. No functional
> > change. In this version, I've removed code supporting legacy controllers
> > ver < 2.0, as the respective platforms were never supported in upstream.
> >
> > Tested on: RB5 development board based on Qcom SM8250 SoC.
> 
> Applied to 6.8/scsi-staging, thanks!
> 

Thanks Martin! Andrew spotted an issue on patch 16/17 and I'm going to submit a
patch fixing that. Please either squash it or apply it separately at your own
convenience.

- Mani

> -- 
> Martin K. Petersen	Oracle Linux Engineering

-- 
மணிவண்ணன் சதாசிவம்
