Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561997C8870
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjJMPSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjJMPR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:17:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17E8BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:17:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32caaa1c493so1789479f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697210274; x=1697815074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfoZ5XVzKB5xUSk2Mi8aOy+1livfWwwFoYiv9POKdA=;
        b=do1InFk1WrgznHtVc8dhPD0k4qZ4V3stLsJg8vJwUBRQWCkQOvZbuTKDgXJBUP58fL
         ttbgqGXYb7pG4j+rKlYSiHqMJKQXKvBCj201vPtCT2sXN5dnCVcH1xgSDLB4KRsIhX3G
         f3JqFo0LvQCCFIe52HdIJ3D6ryHROGpyg63NMqH0LcBzMepz8dxKe9sVbUp9ykfVLYFH
         GfunZ+8hcqh2roRNr9cYn+pyVOzFyYvrpoKxSzvjsz52UNIedVq1x9HuJeYR/SGIbf7L
         XjI92GSZskK/PCUyDoPKeHrTQCfjrQ6RLPcedvkhP6Y8XiXHWIiq+uAeSAQDdwvOGsE2
         F2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697210274; x=1697815074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rfoZ5XVzKB5xUSk2Mi8aOy+1livfWwwFoYiv9POKdA=;
        b=Iww2cGk8T5HzcSTGM+iROWSjLzpLjSGCMd4MVoRsrlZRROPlW5CF2nuYRt/BNxCBuI
         vTGe8teWYn98EjqLJxFY7Y5+ZKWEptN+w/XnsXUogHKjvMTEjVaaXieRXY1z/puLUTod
         v1qFJ+wWMsHdKU6qjxyn1+UQzyYaLZ60A+u9femYL6kT9hxV4gLgav+WU2PG4iaKanbE
         2TBXnWNHFuabr0q0FgsonTRfnnHj1EnfcJNL3n83yvVdEKDRlE/Q/R+nOJrZEMI9+bQJ
         yCij8l9le53/Dss2KZ6diiz6uSCMY1dSpdb8OqHhQCfo8Ov8tshO6rOAORmwhrOiYJRI
         8tVw==
X-Gm-Message-State: AOJu0YyCe4jUM8BZfal8sPlfIv/Id+HrH6d8XAjvLGbI2b3zw+12xAWR
        cCsf2wrYfiuvVr7GNEY0Kv/OBw==
X-Google-Smtp-Source: AGHT+IFLj03Y3alNcqYWEIf7+s3KhO7qp+5XajSXh6icVIyX7sXIXB6Rc+8gqDWeOOd8LUu2jpETFQ==
X-Received: by 2002:a05:6000:888:b0:319:7b66:7800 with SMTP id cs8-20020a056000088800b003197b667800mr21871867wrb.55.1697210274230;
        Fri, 13 Oct 2023 08:17:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d65c6000000b0032326908972sm4941696wrw.17.2023.10.13.08.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:17:53 -0700 (PDT)
Date:   Fri, 13 Oct 2023 18:17:51 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] staging: rtl8192e: Remove unchanged variable
 dig_enable_flag
Message-ID: <2ae55a15-0b0e-4423-838c-6abce81d1570@kadam.mountain>
References: <cover.1697127817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697127817.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 04:43:37PM +0200, Philipp Hortmann wrote:
> Remove dead code leftover from previous patches.
> 
> Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
> Transferred this patch over wlan connection of rtl8192e.
> 

Your patchsets are always very good, Philipp.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

