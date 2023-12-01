Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14599800508
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377772AbjLAHux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjLAHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:50:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12BF1729
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:50:55 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b4746ae51so17229165e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701417054; x=1702021854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H2gU2U9hBWF780zstfEefKpDHx9EQliMYnuk3u2ThY4=;
        b=d9RJ+YIvFnUIuCYOr6XBFsJAm8bo4TEEyDBZehC/nCotP25lQzHDcf+Rs6EANdfOgR
         Jv9cY20viIdRYBuvEZJrHzvRdtX1ZTw2t0TjYWQxZD45grKoNFq+nHufEv+nB4R7Dy0+
         m20ZqQyLAm2SznOboVNrD67Y6JxU8IgTnO0jHeAJc878vAolgkFqOfaa98ZvJHnhh0Eo
         CLKQpROmSaogm1INdmiwvEEFOPYKdEsb6cj/gk53sSblZlv/SO/ihbMrrXsUb3UTk9oJ
         F5HkZ8fSuY4hSxFzD0/UsJIeauVTXU/G87fshtLW20avbtGfKNREIhPYfogzGTXVHf56
         Ef6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701417054; x=1702021854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2gU2U9hBWF780zstfEefKpDHx9EQliMYnuk3u2ThY4=;
        b=orsoA1EZ8uW8CWNeaxV76SLOJ0lGXE8zO7sOHEIkbN4XkVFula/3p4IdAUYdXw2JYj
         JMygMUW6KIE46shVdyWpEwaQwGGkpNYTGruwo6dcYfiHSUmOXK1BRcVQZWuG92h+jpJM
         BvsvCCTMcWF72v16eSPKx35wGfGNNuR/qTy4oy2iLEiH3AEqD1r1flDqEgd+m8YWFMmE
         zNbofrAJ6SGI8ypmt3QXGbI3Qnk7EjHfUq2nzf63n2//+Gxo0QoZitVyz4krQRxbu2m/
         fFi+mSr+wB20J9DcTi83YOLcPNy3/WO3VxK0gxbiYOdJHXN/EJioO1sCNZpZR2Dd2v31
         AILA==
X-Gm-Message-State: AOJu0Yw4kO1U2UD1qFNzi1dKncCym5HuH/biz7dPMMehCNkALP5Vu9fu
        hmxaNmeDjDlQ7Hoi5AA/Ko5m4A==
X-Google-Smtp-Source: AGHT+IGre09Lz2pQd+3q6YR9WzgD/AoJhpccDxPplK9L/zMozWVaQ6zdsMx862wk5Nz4YNkZ1WdeLg==
X-Received: by 2002:a05:600c:5022:b0:40b:5e59:c591 with SMTP id n34-20020a05600c502200b0040b5e59c591mr234499wmr.187.1701417054016;
        Thu, 30 Nov 2023 23:50:54 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040b349c91acsm8172293wmq.16.2023.11.30.23.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:50:53 -0800 (PST)
Date:   Fri, 1 Dec 2023 10:50:50 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Rae Moar <rmoar@google.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2 RESEND] kunit: debugfs: Handle errors from
 alloc_string_stream()
Message-ID: <a863d7dd-d982-462c-af5d-0ef0b48ea953@suswa.mountain>
References: <20231030104732.241339-1-rf@opensource.cirrus.com>
 <CA+GJov5vcRPo30CFYDwRq-iXHqtDtLd2jrmB+y_=BY6o2mZaBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+GJov5vcRPo30CFYDwRq-iXHqtDtLd2jrmB+y_=BY6o2mZaBA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:11:18PM -0500, Rae Moar wrote:
> > +       stream = alloc_string_stream(GFP_KERNEL);
> > +       if (IS_ERR_OR_NULL(stream))
> 
> In response to Dan Carpenter's comment from the last version, I see
> the benefits of changing IS_ERR_OR_NULL() to IS_ERR() instead because
> "stream" will not be NULL. This would then also be the same as the
> check in kunit_alloc_string_stream.
> 
> However, I also see the benefit of checking for NULL just in case anyways.
> 

Returning NULL in alloc_string_stream() is a bug.  Checking for NULL is
a work around for bugs.  There are basically two times where it can
be valid to work around bugs like this instead of fixing them.  1)  When
the function is implemented by over 10 different driver authors.  In
that case you can guarantee that at least one of them is going to do the
wrong thing.  There are between 2-5 places which do this in the kernel.
2)  If it's a API that used to return NULL and it's changed to returning
error pointers.  I've never seen anyone do this, but I've proposed it as
a solution to make backporting easier.

regards,
dan carpenter

