Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A667878F953
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjIAHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjIAHtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A276E10D5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693554494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T97c3bZ8yb+eC9c+2FRwgNQ1FZhHS3MTO2NaIJuhVao=;
        b=eRcXF3iDfcPZleDn91lgP2AxgrKBEZoIaSgwdmzWntUrEibDmYDDy/kUOY8K9csEK8B3WJ
        vnxgRAVJJ7XVmsBhyNv2iItFJXavTUC2GWryNI3MlkxAz4XgAO9+W8JFm5ynqVM/eLgvQ8
        lSlYnMvEtXbWHqnJ8e2c83Z4P+DvtxU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-O8I94vmVMNSV96Sqs-y7mg-1; Fri, 01 Sep 2023 03:48:11 -0400
X-MC-Unique: O8I94vmVMNSV96Sqs-y7mg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31c5c47807aso893528f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 00:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693554490; x=1694159290;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T97c3bZ8yb+eC9c+2FRwgNQ1FZhHS3MTO2NaIJuhVao=;
        b=coM/y45w+w2XobLvq3I1yu2tktpBTCk4pU4ECpXrcq2rqJAjVEUMw2AZNxMcrIKbZX
         LpPUUJerlO8zoFL8+qpEA6/uRhp8bhZFRhm2xsQSsjm8IH7oA0otbSrVrE7bp8ZSjyIU
         rZCbJeS3duUCK9Z90gDQLGbCioZhPlaEAneFwxpq8k3uxUZUx7lBIs4Mkjacmef/4XnU
         5qgsoPv9+Z7LoBDif9LSUJsjj3wixDO6Es+HSPjaRXHkj0iwxs1dHLLaMlaIpO/EqC3z
         5VjRlSG+Z7tDq6Zmz7iaYD3D8uc2P99uBK65lqFYubP9xUpSXX7bqPuQPrTsAzgwl1oV
         Q58g==
X-Gm-Message-State: AOJu0Yz6QI2u2+pl3UJO6asXCWTH1b7lL4CU8448/vw2n5yOc8bwHFBT
        7jVd5EZoJkrV5K68roKEpMiiq5TP1RMW81h5IsmGdVR7QFvg/9AKtkDwKw7z38hKbvEkPQfVtiC
        VMugIJ4i5koMz8udz7KbE1oa4Ycr5sTxi
X-Received: by 2002:a5d:4c84:0:b0:317:df82:2868 with SMTP id z4-20020a5d4c84000000b00317df822868mr1487332wrs.26.1693554490288;
        Fri, 01 Sep 2023 00:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW3eqNjK7xkdR2zFqkK1SPACYHfa9Yg5dPyFnPdq2CybRvXzbPspfdjI/oMUXKz80HfDldzA==
X-Received: by 2002:a5d:4c84:0:b0:317:df82:2868 with SMTP id z4-20020a5d4c84000000b00317df822868mr1487323wrs.26.1693554490008;
        Fri, 01 Sep 2023 00:48:10 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020adffcc7000000b0031c7682607asm4399804wrs.111.2023.09.01.00.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 00:48:09 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's
 .atomic_check() callback
In-Reply-To: <6654778d-1f40-1775-c32c-ebf9728bc9a9@suse.de>
References: <20230830062546.720679-1-javierm@redhat.com>
 <6654778d-1f40-1775-c32c-ebf9728bc9a9@suse.de>
Date:   Fri, 01 Sep 2023 09:48:09 +0200
Message-ID: <87ledqbah2.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi Javier,
>
> another idea about this patch: why not just keep the allocation in the 
> plane's atomic check, but store the temporary buffers in a plane struct. 
> You'd only grow the arrays length in atomic_check and later fetch the 
> pointers in atomic_update. It needs some locking, but nothing complicated.
>

Yes, that would work too. Another option is to just move the buffers to
struct ssd130x_device as it was before commit 45b58669e532 ("drm/ssd130x:
Allocate buffer in the plane's .atomic_check() callback") but just make
them fixed arrays with the size of the biggest format.

That will be some memory wasted but will prevent the problem of trying to
allocate buffers after drm_atomic_helper_swap_state() has been called.

> Best regards
> Thomas
>
> Am 30.08.23 um 08:25 schrieb Javier Martinez Canillas:

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

