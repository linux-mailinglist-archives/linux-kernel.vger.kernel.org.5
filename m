Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4769F758FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGSICL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjGSIB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:01:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA111FF6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:01:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307d20548adso6286857f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689753713; x=1692345713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UX6ZdyM5wEmrpik0psSyRcU5JjoiPAf9kF8mqF500wc=;
        b=fRTysXfaetG2sRpxmcXhoCnfUYUJQpX2v9kigO3Ow3Ym7PV4HJgRVZPRxGGipWYNII
         ij0vahFhRkjOpRklb6VrgUVM2Qn0HAOSMJ+CHdABKKNS6M4Oo7kYsLqVWXHTr20T+AY/
         EpTqeAu2TaJPZA6V96kfWCkqauePTuJDojJ2fKwo9KQ0llo+DO71hJnUxh6vx1+bVTdZ
         fqyZueCd4APPQ2sz0Pvvt2O304SeVOUO4UdPv267KPbOAlP+2UCFgpLOfzTD5Piv5Kly
         qIIZtzbSQLSLpcGxhq990xYAtkZ62oIu83ZscZ1V+XgEWcKmwNuWJpZ/FMSD2dIP7Nbt
         zXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689753713; x=1692345713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UX6ZdyM5wEmrpik0psSyRcU5JjoiPAf9kF8mqF500wc=;
        b=acz+wFrzV3WHf1526JsAUkzhKqtbybrvkunS3Y/tgxdR/+UVOQ8g7pLgebkLgWmCAc
         kVmm4J5JCKkkhkHkTD/2FF9kql8gj3DpLPfvUOa7L7HCcNAtTH5me0IIbgD4ml7u7Mva
         lDfXOD9PC/aKuYcXQomDDk6Tkjv7QRcB+YtgR2WSmgRtoWyRSE7uPk997a9MVBN8vxir
         POizIHfrU3HAHMYBbST4TxjXfKdJU0sgEl4kKVHrjXck+S2hDBHEJOaglbFp6kuNvk2x
         0HXNHel9KpCl0pt3P9M1/GX5abMuOb7AqiI6ODe7aRkNp7w7D5Rp7RGx/6fQ7p59qd/f
         YUZw==
X-Gm-Message-State: ABy/qLZ4aQuCrnG3SDYYqirI/dpus8Q2cGE1fdW34aoMGDM8LZV0PoFE
        tQ+hvoXFQIqaIBHwkKWTg6bHzA==
X-Google-Smtp-Source: APBJJlG4+7m3F5TQkfxgng+M1KHTqM/pNFhvkgHWvvYQzFLuUECfGrZYt9qwv14oKUpbg9GMZfE6Tg==
X-Received: by 2002:a5d:6212:0:b0:314:1a98:ebc0 with SMTP id y18-20020a5d6212000000b003141a98ebc0mr1378282wru.26.1689753713507;
        Wed, 19 Jul 2023 01:01:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v12-20020adfedcc000000b00314315071bbsm4583287wro.38.2023.07.19.01.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:01:52 -0700 (PDT)
Date:   Wed, 19 Jul 2023 11:01:49 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_conn: clean up some casts
Message-ID: <182a5159-3378-4d3b-8d05-bcb931cf450a@kadam.mountain>
References: <5cbde2b4-69b5-4b25-a095-251c8347cb09@kili.mountain>
 <CABBYNZK5MfkOSVUBtWLOLt+H-BBdYrQbZv=rmYtn4WtDyvJopw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZK5MfkOSVUBtWLOLt+H-BBdYrQbZv=rmYtn4WtDyvJopw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 12:30:57PM -0700, Luiz Augusto von Dentz wrote:
> Hi Dan,
> 
> On Mon, Jul 17, 2023 at 3:20 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The ERR_PTR/PTR_ERR() functions are only for error pointers.  They're
> > not a generic way to cast pointers to int.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > We should really create INT_PTR/PTR_INT() functions.  But this is a
> > cleanup until someone creates those.
> 
> Is there any reason you didn't create such macros? I mean we could
> have it local first, or perhaps we just do HANDLE_PTR/PTR_HANDLE to
> avoid any confusion.
> 

Yeah.  I can do that.

regards,
dan carpenter

