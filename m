Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221997F0719
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjKSPQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:16:53 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236C6C2;
        Sun, 19 Nov 2023 07:16:50 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5842a7fdc61so1889551eaf.3;
        Sun, 19 Nov 2023 07:16:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700407009; x=1701011809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWEPk/3aAzX0I4fI4cuUC5y57V6oWUlKYqFVGCjXpJ4=;
        b=jYdkgTQCJNpcIhYxrTjCuVXxg8j7bDaurJU0xschcM427IQCk8a5CGBzwTgHG+vSsJ
         yyptBjjQJMihbcnTi0hgl9sIOPahzvofD2ZkmYnKCtdySFtWmyUx9InMhPnMtF744uWq
         0SAtEr+gkYEBq0yG56Rt/61GE9ywlWqfxXdzbzWZ23DoePqulNHbZqe9VG2A794Jp61p
         OFeX4f9S+V69LIbCVku0o/PW15w2zg9k/LFmPsjJioL7Zd6gxFZ8J7njqP/GnhF8A0DQ
         432+1/gx8D9DEsqygWJ3AsnPFa7ZtRbzxOtsuvEKRnM9BgZCvUgCEflU+gUEr7RXmDdj
         OqRw==
X-Gm-Message-State: AOJu0Yz5Rcr/gEWmrXFGpUyknY38xrNNArWpSn3sh+4Z/4Zw5RWkRGbv
        4Q83zngXKrpTddJzk2VD8Q==
X-Google-Smtp-Source: AGHT+IFTumx8nyQQh6n2laOF1YkhSXqTh5bw2xAJK/w4wHOJAQlPpzBcTyUNnWCP6irMM3KxJR5Kug==
X-Received: by 2002:a05:6820:1c84:b0:56c:cd0c:1d67 with SMTP id ct4-20020a0568201c8400b0056ccd0c1d67mr5808089oob.7.1700407009353;
        Sun, 19 Nov 2023 07:16:49 -0800 (PST)
Received: from herring.priv ([2607:fb90:45e3:889f:15b4:1348:6d64:224b])
        by smtp.gmail.com with ESMTPSA id w18-20020a4ae4d2000000b00581fc1af0a7sm1065154oov.28.2023.11.19.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 07:16:48 -0800 (PST)
Received: (nullmailer pid 215792 invoked by uid 1000);
        Sun, 19 Nov 2023 15:16:43 -0000
Date:   Sun, 19 Nov 2023 09:16:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yi-De Wu <yi-de.wu@mediatek.com>
Cc:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>,
        Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: Re: [PATCH v7 02/16] dt-bindings: hypervisor: Add MediaTek GenieZone
 hypervisor
Message-ID: <20231119151643.GA213170-robh@kernel.org>
References: <20231116152756.4250-1-yi-de.wu@mediatek.com>
 <20231116152756.4250-3-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116152756.4250-3-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:27:42PM +0800, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> Add documentation for GenieZone(gzvm) node. This node informs gzvm
> driver to start probing if geniezone hypervisor is available and
> able to do virtual machine operations.
> 
> [Detail]
> The debate of using dt or not remains intact, and gentle ping seems not
> working on this issue. We'll keep this patch for further discussion and
> move forward in order to rebase based on the latest rc release. For
> previous discussion, please kindly refer to the following link.

Please explain in the commit message why this needs to be in DT and is 
not discoverable by some other means?

Rob
