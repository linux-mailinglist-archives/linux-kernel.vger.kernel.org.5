Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EEB7B38FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjI2R3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjI2R3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:29:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718FF1731
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:27:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-69101022969so12941422b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696008423; x=1696613223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd8ES7UTRS4g/SWmf5zxBULHM/lF3w6VRAdiJYs6Tsc=;
        b=mnHvYWfuhj77AztlOw7+dRx7IJbxeR3VGI2/80fKFfqyIuErtzTvg6lO0MAlXuiBsw
         yKFc2yy90rV0OblD8RTfbnp0lfvArnMItWLhf7KY52rJtpeCM/vQRFiet7o1008fYBpE
         0RBM4zp/sJBiB9Wej0a9tfE705dIW3lWhFDeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008423; x=1696613223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd8ES7UTRS4g/SWmf5zxBULHM/lF3w6VRAdiJYs6Tsc=;
        b=iYo5xdc/l5RX577lw/qgXJSlRqW4LmMSw9twbQj5eZqgu1Jh+vVH5Pwy+8yvtsoUBj
         L1y5p+XP/dXibrG+afHDlpph8/dSP1DqVpzhpqjO8dBYfqpFxgPmprT727z8T4ml9MoC
         uC7P4PAtEe9pg5UAy9f1yajwxZmqJTHw7k6iE+Q2Rk8BIwrNjYcE88ohkfAd/tBIWO0z
         2g3P1GVDgjFOFXHI/H51yMKp76kXZBmzOdGMB11xKE2ZuTfOAB0ltI8yfi1+MDbD9/PD
         xcupv2UAA1E8ix7HXVR0V2c6jjOSPdEM+/aKYcljNEevcKtUQcJzVzJnmwItW7huIFFn
         cXhQ==
X-Gm-Message-State: AOJu0Yz6aoqnwub/LTM81kDGMZB1Xzta2JNB8GIudCML85BPyNLBJ+R+
        9Nxm/DtHfIlCb0u6nXbx+/8GhthMKeHXwek4tUE=
X-Google-Smtp-Source: AGHT+IEXWkksRK1toVy3j5D1s4dbzSv/nL8bWHO6yyUqYwQr+UgzfldVKiEECFSqaadF6uH++QvI9w==
X-Received: by 2002:a05:6a20:d42f:b0:14e:315b:d9c with SMTP id il47-20020a056a20d42f00b0014e315b0d9cmr4362465pzb.22.1696008423179;
        Fri, 29 Sep 2023 10:27:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i6-20020aa787c6000000b0068a0b5df6b2sm15242690pfo.196.2023.09.29.10.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:27:02 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:27:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Torsten Schenk <torsten.schenk@zoho.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: 6fire: Fix undefined behavior bug in struct
 midi_runtime
Message-ID: <202309291026.06071AC@keescook>
References: <ZRb2CKHuaCu0u38i@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRb2CKHuaCu0u38i@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 06:06:32PM +0200, Gustavo A. R. Silva wrote:
> `struct urb` is a flexible structure, which means that it contains a
> flexible-array member at the bottom. This could potentially lead to an
> overwrite of the objects following `out_urb` in `struct midi_runtime`,
> among them a function pointer.
> 
> Fix this by placing the declaration of object `out_urb` at the end of
> `struct midi_runtime`.
> 
> Fixes: c6d43ba816d1 ("ALSA: usb/6fire - Driver for TerraTec DMX 6Fire USB")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Another good find. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
