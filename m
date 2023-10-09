Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBD57BEB12
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378509AbjJIT6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377401AbjJIT6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:58:36 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9486594
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:58:35 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3ae2ec1a222so3465151b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881515; x=1697486315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLuHSTvxz6vkfDxRZ/vqO8f0OQyjGiohBBwWRgjVl/4=;
        b=JNz0qgsYuK3TBnHTDPh/Cc8uro9vD0eEaeoje+InVGLUF7ebq4oIiwWPlHW3hBV6cm
         K5bjjD0d0TKKi4kyiXF6pWHhu2v34gR6/+gzFX/pBfEXU1HoIc/8oqKMyQop8Mjq+knU
         ND32KrXG51kEUrvqVOwSZmwbIrEJiBpaWMGa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881515; x=1697486315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLuHSTvxz6vkfDxRZ/vqO8f0OQyjGiohBBwWRgjVl/4=;
        b=kC74SGreQNc9/niKNDrrnTBOtNBpPtr/rZ5rOTBjNPXVA46+DVShBvrToPpmmIZunB
         iKCs5PVxLEv1NSy6sDx3ZtgyB/h9IsIkPKam697LPltT2HUN8Xw77JNhAMEUIYe2LcBs
         0EPyBuEEssLhMyBQZAbsR2yr27AgHT+YeDIm1RdeX0CVLOLaedFt1LP0qbuiRyTNw/+t
         pXq09UtnekJfSoGlK0TbhL/I4cYHqaRbS8hKj1COv1LA4aAbGOQcsnFTtSXVioshhkMu
         orFSu0pWZcgM6k/xU7WWxWX8DimJaIlQQUZP2HeCbJzYdJ0A2BIFe0pbQZvaFUjKDEYz
         jnPA==
X-Gm-Message-State: AOJu0YxLcqJfl6d0eEoC7BdXZQvMhwxaPXSXnRV7/xXD2iKK3qhBd1YC
        5Ab/bGQ8OfwPVbRrMOEjzgYYmg==
X-Google-Smtp-Source: AGHT+IEYzKgq/AXneaurNLWylzPihiqK77Oe890uhQ8y3iiRMPVTe3Jvvb72QyLFVuRIES4e/xI2jw==
X-Received: by 2002:a05:6808:2d6:b0:3a7:3988:87ee with SMTP id a22-20020a05680802d600b003a7398887eemr16427801oid.58.1696881514875;
        Mon, 09 Oct 2023 12:58:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i6-20020a633c46000000b0058563287aedsm8906706pgn.72.2023.10.09.12.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:58:34 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:58:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] bna: replace deprecated strncpy with strscpy_pad
Message-ID: <202310091258.C4CDBBED7D@keescook>
References: <20231009-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v2-1-78e0f47985d3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v2-1-78e0f47985d3@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:45:33PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> bfa_ioc_get_adapter_manufacturer() simply copies a string literal into
> `manufacturer`.
> 
> Another implementation of bfa_ioc_get_adapter_manufacturer() from
> drivers/scsi/bfa/bfa_ioc.c uses memset + strscpy:
> |	void
> |	bfa_ioc_get_adapter_manufacturer(struct bfa_ioc_s *ioc, char *manufacturer)
> |	{
> |		memset((void *)manufacturer, 0, BFA_ADAPTER_MFG_NAME_LEN);
> |			strscpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
> |	}
> 
> Let's use `strscpy_pad` to eliminate some redundant work while still
> NUL-terminating and NUL-padding the destination buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the update! Yeah, this looks safe to me now.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
