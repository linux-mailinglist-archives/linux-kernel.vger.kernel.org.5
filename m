Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E567EE8A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjKPVJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPVJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:09:06 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8EFA3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:09:02 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so989564a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700168942; x=1700773742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYAFY96XcFiMxIF+L4YoxaW0MbIDBtwFnVJcSIPp9Co=;
        b=e3Sp0UD+6Xyg6NDUJEif0hrLYx0CML2C0FUMAMVe2rcdU9lm0RoZ4CwzwGgSE0gQgX
         ns3/QTMffLN4JkMiWYdYl4tZszTywdXBDKrEKrL8Nn77J8k/iIT2a/K1glo6bdxPpdBf
         pQ9wlLCC+kQaurxjYR6qdQ0TkxLzlbP/2nmoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700168942; x=1700773742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYAFY96XcFiMxIF+L4YoxaW0MbIDBtwFnVJcSIPp9Co=;
        b=TMkE1XwVo5Xaar+LtWqM9TeV05FW0r/D68eQX/cX3HP9eAYwoosni5Zs/4/+jAhAjB
         pfSmsl3eFlJUdxy+rmRv0hUwPpGcSkFHLvAQdkGuzEGa3UGCsMSb0qqHZ1LgzHIpCL8Q
         yTyi38KKnSKtWlYk5fuGvmR2H1t4rVbMdEgfxnbxR342L3pyeYnUz8b5aXD0JQBYfcqe
         ok5S/dFQ0Un0sVrFCdfmjrpT457MWMQcbCIG78OqujiH9anQh2+W4N66rLt4NmbgaVyZ
         3QoVAy6LVBlacow0ZwCV9Djb3r54t095i2W1IGO1dF5ej8hzpVl2o3JJTGsMcu74RYtx
         0N4w==
X-Gm-Message-State: AOJu0Yxr1iugldYhGYx+1JwDfIMQHClHhNV7BhzZbb+Ryfzx9xuOtsy+
        G3KeNw3WQMyqfPjjJqTsae4P4Q==
X-Google-Smtp-Source: AGHT+IGDMJWNBh7L3/s1oXiCq33PVVTLiBNbt/MbNP2Jg71YOV8F+by6BxzlVI3bHz3WEwpQvMCriQ==
X-Received: by 2002:a05:6a20:12c6:b0:154:b4cb:2e8c with SMTP id v6-20020a056a2012c600b00154b4cb2e8cmr18208401pzg.24.1700168942326;
        Thu, 16 Nov 2023 13:09:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00130c00b0068fece22469sm175211pfu.4.2023.11.16.13.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 13:08:59 -0800 (PST)
Date:   Thu, 16 Nov 2023 13:08:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xen: privcmd: Replace zero-length array with
 flex-array member and use __counted_by
Message-ID: <202311161307.9422E1896B@keescook>
References: <ZVZlg3tPMPCRdteh@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVZlg3tPMPCRdteh@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 12:54:59PM -0600, Gustavo A. R. Silva wrote:
> Fake flexible arrays (zero-length and one-element arrays) are deprecated,
> and should be replaced by flexible-array members. So, replace
> zero-length array with a flexible-array member in `struct
> privcmd_kernel_ioreq`.
> 
> Also annotate array `ports` with `__counted_by()` to prepare for the
> coming implementation by GCC and Clang of the `__counted_by` attribute.
> Flexible array members annotated with `__counted_by` can have their
> accesses bounds-checked at run-time via `CONFIG_UBSAN_BOUNDS` (for array
> indexing) and `CONFIG_FORTIFY_SOURCE` (for strcpy/memcpy-family functions).
> 
> This fixes multiple -Warray-bounds warnings:
> drivers/xen/privcmd.c:1239:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
> drivers/xen/privcmd.c:1240:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
> drivers/xen/privcmd.c:1241:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
> drivers/xen/privcmd.c:1245:33: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
> drivers/xen/privcmd.c:1258:67: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
> 
> This results in no differences in binary output.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right to me. I can see the allocation:

        size = struct_size(kioreq, ports, ioeventfd->vcpus);
        kioreq = kzalloc(size, GFP_KERNEL);
        if (!kioreq)
                return ERR_PTR(-ENOMEM);

        kioreq->dom = ioeventfd->dom;
        kioreq->vcpus = ioeventfd->vcpus;


Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
